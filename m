Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVLST4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVLST4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVLST4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:56:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55774 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964928AbVLST4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:56:38 -0500
Date: Mon, 19 Dec 2005 20:55:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219195553.GA14155@elte.hu>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 19 Dec 2005, Ingo Molnar wrote:
> > 
> > in fact, generic mutexes are _more_ fair than struct semaphore in their 
> > wait logic. In the stock semaphore implementation, when a waiter is 
> > woken up, it will retry the lock, and if it fails, it goes back to the 
> > _tail_ of the queue again - waiting one full cycle again.
> 
> Ingo, I don't think that is true.
> 
> It shouldn't be true, at least. The whole point with the "sleeper" 
> count was to not have that happen. Of course, bugs happen, so I won't 
> guarantee that's actually true, but ..

you are right, i based my comments on observed behavior, not on the 
code's intentions.

I havent actually traced the behavior of semaphores (being mostly 
interested in mutexes ;-), but fairness algorithms always show up as 
heavy context-switchers on SMP (because other CPUs queue themselves as 
waiters, and wakeups go across CPUs all the time), and i'm quite sure 
that contended scenarios with the current semaphore implementation never 
overscheduled. Hence current semaphores are very likely not fair, and 
sleepers roundrobin back to the queue quite often.

but i've got some measurements of how fairness plays out in practice.  
The mutex based ops go:

 mars:~> ./test-mutex V 16 10
 8 CPUs, running 16 parallel test-tasks.
 checking VFS performance.
 avg ops/sec:               85130
 average cost per op:       206.59 usecs
 average deviance per op:   319.08 usecs

note the 'average latency of an op' (in absolute time), and the standard 
deviation (which has been measured by summing up the deltas between 
subsequent latencies, and divided by the total number of ops).

With semaphores the results go like this:

 mars:~> ./test-mutex V 16 10
 8 CPUs, running 16 parallel test-tasks.
 checking VFS performance.
 avg ops/sec:               34381
 average cost per op:       512.13 usecs
 average deviance per op:   573.10 usecs

look that even though the ratio between the per op cost and the standard 
deviance looks to be a bit better for semaphores, the pure fact that it 
was much slower lengthened its standard deviance to well above that of 
the mutex's.

So even if they are fairer, if the system ends up being slower, fairness 
(==observed fluctuations, and resulting injustices) suffers more as a 
result than due to the queueing logic. I'd chose this 200 +/- 150 usecs 
behavior over 500 +/- 280 usecs behavior - even though the latter has 
smaller relative fluctuations.

(although i'm still unsure which one is fairer, because i couldnt create 
a scenario that is comparable in terms of fairness comparisons: the 
mutex based workloads are always more efficient, and as a result they 
schedule into the idle thread more often, which creates additional noise 
and may be a reason why its standard deviation is higher. The semaphore 
workloads are more saturated, which may flatten its standard deviation.)

> If you are woken up as a waiter on a semaphore, you shouldn't fail to 
> get it. You will be woken first, and nobody else will get at it, 
> because the count has been kept negative or zero even by the waiters, 
> so that a fast-path user shouldn't be able to get the lock without 
> going through the slow path and adding itself (last) to the list.
> 
> But hey, somebody should test it with <n> kernel threads that just do 
> down()/up() and some make-believe work in between to make sure there 
> really is contention, and count how many times they actually get the 
> semaphore. That code has been changed so many times that it may not 
> work the way it is advertized ;)
> 
> [ Oh.  I'm looking at the semaphore code, and I realize that we have a 
>   "wake_up(&sem->wait)" in the __down() path because we had some race long 
>   ago that we fixed by band-aiding over it. Which means that we wake up 
>   sleepers that shouldn't be woken up. THAT may well be part of the 
>   performance problem.. The semaphores are really meant to wake up just 
>   one at a time, but because of that race hack they'll wake up _two_ at a 
>   time - once by up(), once by down().
> 
>   That also destroys the fairness. Does anybody remember why it's that 
>   way? ]
> 
> Ho humm.. That's interesting.

hm, removing that wakeup quickly causes hung test-tasks. (i booted an 
all-mutexes kernel, and did the testing on arch_semaphores, using the 
modified semaphore-sleepers.c code. The test ran for a few seconds, so 
semaphores werent _totally_ broken, but there's some clear race in terms 
of not waking up a sleeper.)

and even considering that the current semaphore implementation may have 
a fairness bug, i cannot imagine that making it more fair would also 
speed it up. So it could end up having an even larger performance gap to 
the mutex implementation. But in any case, it should be an interesting 
comparison! I personally find the semaphore implementation clever but 
too complex, maybe that's a reason why such bugs might be hiding there.  
(possibly for many years already ...)

In any case, i concur with you that the fairness design of the two is 
not comparable, and that semaphores _should_ be fairer.

	Ingo
