Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUK2PH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUK2PH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUK2PH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:07:59 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:13486 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261291AbUK2PHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:07:46 -0500
Date: Mon, 29 Nov 2004 16:07:43 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041129095941.GD7868@elte.hu>
Message-Id: <Pine.OSF.4.05.10411291152050.14592-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> [...] 
> To give you an extreme example: you cannot run OpenOffice.org with
> SCHED_FIFO prio 99 and expect it to have any sane deterministic latency
> bounds. The simpler the app, the easier it is to control latencies.
> 

No, but I want to have my RT-subsystem to be not affected even if the
users choose to run 1000 soffice.bin at SCHED_NORMAL!! Not that I suspect
a cracker would be able to lock on to my RT-system and do it on perpose,
but I know developers make errors. Very often I have seen servers
becomming over-burdened  because some application keeps spawning new
threads/processors - often as a solution to being overloaded!!!

That would indeed demand that the kernel would be O(1) in a lot of places
where it isn't right now. 1) The first job is to identify those places, 2)
make the core system be pure O(1) such that RT applications are posible at
all, 3) stop using spinlocks for all none-O(1) places such that RT
applications are not disturbed by none-O(1) behaviour even though
none-real-time threads hits them all the time and 4) chance the most
usefull, but none-critical places to be O(1), too, such that these
subsystems can be used in real-time applications as well. 

I think you have come very far with 1)-3). There is a lot of work in 4)
but I think that can be left to those people who actually need to use
those subsystems in a real-time application:

The filesystems will most likely never be O(1) but simple device drivers
can easily be made O(1). I.e. you can make real-time applications using a
character device once you have opened the device but not the file-system
in general. The TCP/IP stack probably wont be O(1) for a long time, i.e.
no real-time application can use TCP/IP directly for a long time :-( 

Now I started to look at priority inheritance because I saw that as the
way to fullfill 3) with the twist that real-time applications can share
resources with non-real-time applications. I think the current
implementation is good, if the current mechanism is keeped inside the
kernel. The problem is that a raw spinlock is used to lock for a iteration
over a list which can be O(number of waiters * locking depth) long. As
long as we are in the kernel both is "controlled", i.e. one can see the
worst-case number in stress test and know it can't get worse. * 

However, if the same mechanism is used for a userspace mutex there will be
a problem since very long list of waiters can be build up on a mutex by a
faulty application. (That could be one where starvation is solved by
spawning new the threads to handle the work, which then will block on the
critical region, such the lists gets longer and longer...) The solution I
see, is to uplift the level of abstraction: Have the same mechanism but
the lock around the wait queues is this time around the kernel mutex. I.e.
the kernel mutex is implemented with a raw spinlock, the user space mutex
is implemented by a kernel mutex! That will be more expensive, ofcourse,
but avoid that non-real-time userspace threads having degrading the
system latency by bad usage of muteces.

But there are probably still a lot of other places where non-real-time
userspace threads can increase the overall system latency in a
unpredictable way, but I think you got a good grab on those now :-)


> [...] 
> 	Ingo
> 

Esben

*If somebody is afraid that the number of waiters on a mutex can be made
unlimited long by forinstance having a lot of non-real-time processes
calling into the same kernel region it can be fixed by moving and 
keeping processes at priority 100 and SCHED_FIFO when they own a mutex
such they will run to completion before other non-real-time task can be
scheduled on the same CPU. In fact that will make the system behave as
the old non-preemptive kernel when there is only non-real-time threads! --
which also saves the system from rescheduling and thus make it have a
better through-put performance.


