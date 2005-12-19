Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVLSPvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVLSPvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLSPvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:51:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28127 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964783AbVLSPvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:51:01 -0500
Date: Mon, 19 Dec 2005 16:50:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219155010.GA7790@elte.hu>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 19 Dec 2005, Andi Kleen wrote:
> > 
> > Do you have an idea where this big difference comes from? It doesn't look
> > it's from the fast path which is essentially the same.  Do the mutexes have
> > that much better scheduling behaviour than semaphores? It is a bit hard to 
> > believe.
> 
> Are Ingo's mutex'es perhaps not trying to be fair?
> 
> The normal mutexes try to make sure that if a process comes in and 
> gets stuck on a mutex, and then another CPU releases the mutex and 
> immediately tries to grab it again, the other CPU will _not_ get it.

the VFS creat+unlink performance advantage i measured on SMP systems is 
a pure 'struct mutex' vs. stock 'struct semaphore' measurement. I 
measured the same kernel with a single .config option difference 
(DEBUG_MUTEX_FULL to get the 'mutex' variant, vs. DEBUG_MUTEX_PARTIAL to 
get the 'semaphore' variant), the systems were completely idle, and the 
results are statistically stable.

fact is, we dont implement fairness in the upstream struct semaphore 
implementation(s) either - it would be extremely bad to performance (as 
you are pointing it out too).

both stock semaphores and generic mutexes are unfair in the following 
sense: if there is a waiter 'in flight' (but has not grabbed the lock 
yet), a 'lucky bastard may jump the queue' and may grab the lock, 
without having waited anything. So comparing semaphores to generic 
mutexes is an apples to apples comparison.

in fact, generic mutexes are _more_ fair than struct semaphore in their 
wait logic. In the stock semaphore implementation, when a waiter is 
woken up, it will retry the lock, and if it fails, it goes back to the 
_tail_ of the queue again - waiting one full cycle again.

in the generic mutex implementation, the first waiter is woken up, and 
it will retry the lock - but no other waiters are woken up until this 
waiter has done its round. (a mutex implementation can do this, because 
it knows that there can only be one owner, while a counting semaphore 
has to be prepared for the possibility of multiple concurrent up()s, and 
for the count going above 1.)

and this is also the crutial difference that gives mutexes the 
performance edge in contended workloads (so this should also answers 
Andi's question): stock semaphores easily end up creating a 'thundering 
herd' scenario, if a 'fast lucky bastard' releases the lock - and wakes 
up _yet another_ waiter. The end result is, that given a high enough 
'semaphore use frequency', our wake-one logic in semaphores totally 
falls apart and we end up having all waiters racing for the runqueues, 
and racing for the lock itself. This causes much higher CPU utilization, 
wasted resources, and slower total performance.

there is one more wakeup related optimization in generic mutexes: the 
waiter->woken flag. It is set when the waiter is 'set into flight', and 
subsequent wakeups first check this flag. Since new waiters are added to 
the end of the wait-list, this waiter's data cachelines stay clean, and 
the ->woken flag is nicely shared amongst CPUs. Doing a blind 
wake_up_process() would at a minimum dirty the remote runqueue's lock 
cacheline.

> That's a huge performance disadvantage, but it's done on purpose, 
> because otherwise you end up in a situation where the semaphore 
> release code did wake up the waiter, but before the waiter actually 
> had time to grab it (it has to go through the IPI and scheduling 
> logic), the same CPU just grabbed it again.
> 
> The original semaphores were unfair, and it works really well most of 
> the time. But then it really sucks in some nasty cases.
> 
> The numbers make me suspect that Ingo's mutexes are unfair too, but 
> I've not looked at the code yet.

yes, they are unfair - just like stock semaphores.

[ Note that the generic rt-mutexes in the -rt tree are of course fair to 
  higher-prio tasks, and this fairness is implemented via 
  priority-queueing and priority inheritance: the highest prio (RT) task
  gets the lock, and if a lower-prio task is holding the lock, it is
  boosted up until the end of the critical section, at which point it
  hands over the lock to the highprio task.

  implementing any other method to achieve fairness would result in 
  really bad real-world performance. The -rt tree's performance is quite 
  close to the vanilla kernel (considering that it's a fully preemptible
  kernel), and we couldnt do that without the mutex implementation. ]

generic mutexes, as present in this patchqueue, do not include priority 
queueing and priority inheritance, so they are 'plain unfair', just like 
stock semaphores are.

> NOTE! I'm not a huge fan of fairness per se. I think unfair is often 
> ok, and the performance advantages are certainly real. It may well be 
> that the cases that caused problems before are now done differently 
> (eg we switched the VM semaphore over to an rwsem), and that we can 
> have an unfair and fast mutex for those cases where we don't care.
> 
> I just suspect the comparison isn't fair.

the comparison is 100% totally fair, because both generic mutexes, and 
struct semaphores are 100% totally unfair :-) There's no difference in 
the level of unfairness either: 'lucky bastards' are allowed to steal 
the lock in both implementations.

we have only one (limited) notion of fairness in Linux synchronization 
primitives: rwsems prefer waiting writers, and then block subsequent 
readers. Note that rwsems are still reader-reader and writer-writer 
unfair, hence the -rt tree replaces the rwsem implementation too, with 
generic mutexes and PI.

	Ingo
