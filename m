Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282082AbRLHLto>; Sat, 8 Dec 2001 06:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282083AbRLHLtf>; Sat, 8 Dec 2001 06:49:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56069 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282082AbRLHLtX>; Sat, 8 Dec 2001 06:49:23 -0500
Subject: Re: [RFC][PATCH] 2.5.0 Multi-Queue Scheduler
To: kravetz@us.ibm.com (Mike Kravetz)
Date: Sat, 8 Dec 2001 11:58:22 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20011207143415.B1127@w-mikek2.des.beaverton.ibm.com> from "Mike Kravetz" at Dec 07, 2001 02:34:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Cg7a-0001CR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> maintain the behavior of the existing scheduler.  This was both
> good and bad.  The good is that we did not need to be concerned
> with load balancing like traditional multi-queue schedulers.

Which version of the scheduler do you behave like ?

> balancing.  This is what Davide Libenzi is working on and
> something I plan to tackle next.  If you have any ideas on
> areas where our time would be better spent, I would be happy
> to hear them.

I've played with your code, and some other ideas too. I don't think the
Linus scheduler is salvagable. Its based upon assumptions about access to
data and scaling that broke when the pentium came out let alone the quad
xeon.

I have the core bits of a scheduler that behaves roughly like Linux 2.4 with
the recent Ingo cache change [in fact that came from working out what the
Linus scheduler does].

Uniprocessor scheduling is working fine (I've not tackled the RT stuff tho)
SMP I'm pondering bits still.

Currently I do the following

Two sets of 8 queues per processor, and a bitmask of non empty queues.

Picking a new task to run is as simple as
	new = cpu->run_queue[fastffz[cpu->runnable]];

(fastffz is a lookup table, for more queues you want a real ffz which is
 a few clocks more but might be worth it on very big boxen)

sleep simply doesn't put the task back on a run queue

wake_up (uniprocessor) is

	if(task->epoch != epoch)
		adjust_priority(task);
	queue_task(cpu, task);
	if(test_and_set_bit(task->pri, cpu->runnable))
		schedule();

Running out of ticks (as with the original Linus scheduler - Ingo edition)
bumps you off run_queue onto next_queue. run/next queue exchange when there
is nothing left to run, but next_queue has stuff (ie non idle). At that
point we switch them and bump epoch.

epoch is a trick I took from the montavista patches - instead of iterating
every task in the system to adjust priority, we work out what it would have
been by adjusting at wake up.

I don't see how to get an O(roughly 1) scheduler without changing behaviour.
At the same time I agree with Linus that a lot of boxes typically have < 3
runnable tasks so we can't make the simple case suffer.

Alan
