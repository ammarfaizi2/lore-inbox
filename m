Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSFRUma>; Tue, 18 Jun 2002 16:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317612AbSFRUm3>; Tue, 18 Jun 2002 16:42:29 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:57606
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317611AbSFRUmU>;
	Tue, 18 Jun 2002 16:42:20 -0400
From: <mgix@mgix.com>
To: <rusty@rustcorp.com.au>, "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
Subject: RE: Question about sched_yield() 
Date: Tue, 18 Jun 2002 13:42:20 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBEEELCBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-reply-to: <E17KPS1-0003pP-00@wagner.rustcorp.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Given that yield is "sleep for some time but I won't tell you what I'm
> doing", I have no sympathy for yield users 8)

Here's something interesting at last.

True, when userland calls sched_yield, the kernel is left in the dark.

However, I am not aware of any alternative to communicate what
I really want to the scheduler, and here's why. If anyone has
ideas on how to do this better, please, I'm all ears.

It's basically about spinlocks and the cost of task switching.

I'm trying to implement "smart" spinlocks.

Regular blocking lock based on some kind of kernel object are:

	1. Slow because every unsuccessful use of the lock will
         trigger a task switch. There is no way to have two threads
         exchange messages at a very fast rate with a blocking lock.

	2. Expensive in terms of kernel resource consumption: you end
         up allocating a kernel object each time you need a lock.
         If your app's locking is sufficienly fine-grained, you end
         up allocating a huge number of kernel objects.

	3. To avoid problem 2., you can try and allocate kernel objects
         on the fly, but then performance gets even worse: every lock
         acquisition/release requiring the creation/destruction of a
         kernel object.

The alternative, userland spinlocks :

	1. Cost zero in term of kernel resource consumption.

	2. Are a major catastrophe when running on a UP box
         (you can spin as long as you want, nothing's going to
          change since there's only one CPU and you're hogging it)

	3. A CPU hog at best when running on an SMP boxes: the spinning
         thread gobbles up a whole 100% of a CPU.

"Smart" spinlocks basically try and do it this way:

	int spinLoops= GetNumberOfProcsICanRunOn() > 1 ? someBigNumber : 1;
	while(1)
	{
		int n= spinLoops;
		while(n--) tryAndGetTheSpinLock();
		if(gotIt) break;
		sched_yield();
	}

These seem to have all the qualities I want:

1. On a UP box, the thread will poke at the spinlock only once,
   and then yield and *hopefully* get scheduled till later, giving
   a chance to the lock owner to finish its stuff and release.

   Net result: spinning thread gives no CPU consumption, no kernel
   object allocated, and proper locking behaviour.

2. On an SMP box, the thread will bang on the spinlock a large
   number of times, hoping to get it before it gets taskswitched away.
   If it does, great: no time lost.
   If it doesn't, we're out of luck, yield the CPU and try again next time.

   Net result: tunable balance between CPU consumption and task switching
   costs, no kernel object allocated, and proper locking behaviour.


I'm sure this issue has been beaten to death before, but I
just wanted to gove my $.02

	- Mgix




