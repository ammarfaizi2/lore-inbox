Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263534AbVBEGDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbVBEGDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbVBEGDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:03:10 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:53173 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266294AbVBEGC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:02:59 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manish Lachwani <mlachwani@mvista.com>
In-Reply-To: <1107483490.27584.459.camel@localhost.localdomain>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
	 <20050122122915.GA7098@elte.hu>  <20050201201402.GA31930@elte.hu>
	 <1107481908.27584.448.camel@localhost.localdomain>
	 <1107483490.27584.459.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 05 Feb 2005 01:02:30 -0500
Message-Id: <1107583350.27584.473.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 21:18 -0500, Steven Rostedt wrote:

> Here's the problem: If I raise the priorities of the processes before
> zeroing the semaphore, the machine hangs.  If I zero the semaphore
> before raising the priorities, the program runs fine.

Hi Ingo,

I've looked into this and found where the deadlock occurs. Actually it
is a starving of processes. I finally got around to trying it on
2.6.11-rc3, and it doesn't have a problem.

Anyway, here's the scoop. 

The parent process that zeros the semaphore to allow the child process
to run after the parent upped the priority of the child really high,
gets stuck in the following:

In update_queue in ipc/sem.c (I don't have the correct line numbers,
cause I haven't stripped out the debug yet). at the point of:
			q->status = IN_WAKEUP;
			/*
			 * Continue scanning. The next operation
			 * that must be checked depends on the type of the
			 * completed operation:
			 * - if the operation modified the array, then
			 *   restart from the head of the queue and
			 *   check for threads that might be waiting
			 *   for semaphore values to become 0.
			 * - if the operation didn't modify the array,
			 *   then just continue.
			 */
			if (q->alter)
				n = sma->sem_pending;
			else
				n = q->next;
			wake_up_process(q->sleeper);

Here is where it locks up.

			/* hands-off: q will disappear immediately after
			 * writing q->status.
			 */
			q->status = error;


I also found that the high priority child is running in an infinite
while loop in sys_semtimedop in the same file, at the following:

	while(unlikely(error == IN_WAKEUP)) {
		cpu_relax();
		error = queue.status;
	}

So, what looks to be happening is that as soon as the parent wakes up
the child, the child preempts the parent, and hits this while loop. But
since the child is a realtime task, with the highest priority of the
system, it starves the system. Of course this is a UP and I don't think
this will show a problem on an SMP machine. 

I can't think of a solution right now, so I'll just pass it on to
you ;-).  Once again it's late and I'm going to bed.


Thanks,

-- Steve


