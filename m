Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVLSM5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVLSM5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 07:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVLSM5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 07:57:34 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:53981 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932283AbVLSM5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 07:57:34 -0500
Date: Mon, 19 Dec 2005 07:56:51 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
In-Reply-To: <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0512190744350.9001@gandalf.stny.rr.com>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Dec 2005, Linus Torvalds wrote:

>
>
> On Mon, 19 Dec 2005, Andi Kleen wrote:
> >
> > Do you have an idea where this big difference comes from? It doesn't look
> > it's from the fast path which is essentially the same.  Do the mutexes have
> > that much better scheduling behaviour than semaphores? It is a bit hard to
> > believe.
>
> Are ingo's mutex'es perhaps not trying to be fair?
>
> The normal mutexes try to make sure that if a process comes in and gets
> stuck on a mutex, and then another CPU releases the mutex and immediately
> tries to grab it again, the other CPU will _not_ get it.
>
> That's a huge performance disadvantage, but it's done on purpose, because
> otherwise you end up in a situation where the semaphore release code did
> wake up the waiter, but before the waiter actually had time to grab it (it
> has to go through the IPI and scheduling logic), the same CPU just grabbed
> it again.
>
> The original semaphores were unfair, and it works really well most of the
> time. But then it really sucks in some nasty cases.
>
> The numbers make me suspect that Ingo's mutexes are unfair too, but I've
> not looked at the code yet.

Yes, Ingo's code does act like this unfairness.  Interesting also is that
Ingo's original code for his rt_mutexes was fair, and it killed
performance for high priority processes.  I introduced a "lock stealing"
algorithm that would check if the process trying to grab the lock again
was a higher priority then the one about to get it, and if it was, it
would "steal" the lock from it unfairly as you said.

Now, you are forgetting about PREEMPT.  Yes, on multiple CPUs, and that is
what Ingo is testing, to wait for the other CPU to schedule in and run is
probably not as bad as with PREEMPTION. (Ingo, did you have preemption on
in these tests?).  The reason is that if you have a high priority process
release a lock (giving it to a lower priority process that hasn't woken up
yet), then try to grab it again, but a lower priority process was waiting
on it,  the high priorty process would need to schedule out and wait on
the lower priority process. Here's a case of priority inversion that can
be solved without priority inheritance.

The way this situation happens is if you have three processes, A B and C
where A is the highest and C is the lowest.  C grabs the lock and is
preempted by A, A tries to grab the lock and goes to sleep, then B
runs and preempts C (remember, we don't have PI here), and then tries to
grab the lock.  C releases the lock and gives it to A, then A releases the
lock (gives it to B) and then tries to grab it again.

Now you must wait for two schedules and B to release the lock, before high
priority process A gets to run again.

So when we have PREEMPT, your fairness is not being very fair.

-- Steve
