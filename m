Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSGXSnD>; Wed, 24 Jul 2002 14:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGXSnD>; Wed, 24 Jul 2002 14:43:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63704 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317468AbSGXSnC>;
	Wed, 24 Jul 2002 14:43:02 -0400
Date: Wed, 24 Jul 2002 20:45:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] scheduler bits for 2.5.27, -D4
Message-ID: <Pine.LNX.4.44.0207242021580.2050-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


updated scheduler changes/fixes, against BK-current:

   http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.27-D4

the main change in -D4 (besides the merging) is that i've reworked the
lowlevel entry.S hot-path impact of SCHED_BATCH. The test for SCHED_BATCH
is now done in entry.S, so the cost of SCHED_BATCH is a single instruction
in the 'work pending' path, plus a comparison & branch instruction in the
'need to do preemption' path. This is the only overhead that non-batch
processes see - the remaining overhead of schedule_batch() happens only
for SCHED_BATCH processes.

(it could be made 3 instructions in the 'need to do preemption' path only,
with the caveat of an AGI. [or its equivalent on other CPUs])

the irq hotpath, the syscall return hotpath is not affected, only the 'we
will context switch now' hotpath is affected.

(-D4 compiles, boots & works just fine on x86 UP and SMP.)

Bugfixes:

 - introduce new type of context-switch locking, this is a must-have for
   ia64 and sparc64.

 - load_balance() bug noticed by Scott Rhine and myself: scan the
   whole list to find imbalance number of tasks, not just the tail
   of the list.

 - sched_yield() fix: use current->array not rq->active.

Features:

 - SCHED_BATCH feature.

 - ->first_time_slice to limit the number of timeslices 'won' via child
   exit - this is the logical equivalent of the child-timeslice
   distribution change in Andrea's tree.

 - sched_yield() cleanup and simplification: yielding puts the task
   into the expired queue. This eliminates spurious yields in which
   the same task repeatedly calls into yield() without achieving
   anything. It's also the most logical thing to do - the yielder
   has asked for other tasks to be scheduled first.

Cleanups, smaller changes:

 - simpler locking in schedule_tail().

 - load_balance() cleanup: split up into find_busiest_queue(),
   pull_task() and load_balance() functions.

 - idle_tick() cleanups: use a parameter already existing in the
   calling function.

 - scheduler_tick() cleanups: use more intuitive variable names.

 - remove obsolete comments.

 - clear ->first_time_slice when a new timeslice is calculated.

 - move the sched initialization code to the end of sched.c.

 - no need for nr_uninterruptible to be signed.

	Ingo



