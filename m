Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbULCU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbULCU7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbULCU7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:59:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57539 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262380AbULCU6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:58:38 -0500
Date: Fri, 3 Dec 2004 21:58:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Message-ID: <20041203205807.GA25578@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124101626.GA31788@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.32-0 Real-Time Preemption patch, which can be
downloaded from the usual place:

	http://redhat.com/~mingo/realtime-preempt/

this is a fixes-mostly release with one new feature:

implemented global RT-task balancing on SMP systems, which improves the
latency of RT tasks on SMP systems. The basic problem was that the 2.6
kernel has per-CPU runqueues. In the current design there is no
guarantee that if an RT task starves another, lower-prio (or same-prio)
RT task in a given local runqueue, that the starved task will ever be
migrated to another CPU: it has to wait for the higher-prio task to
finish. In short, task migration on SMP is fundamentally non-RT and
priority-insensitive. In particular the workloads and latencies reported
by Mark H. Johnson reflect such SMP scheduling artifacts.

the new global RT-task balancing feature solves this problem by tracking
the 'RT overload' situation (when there is more than one RT tasks on a
CPU) and makes other CPUs 'pull' RT tasks (and only RT tasks)
immediately when such a situation occurs.

To give an example, in the following scheduling scenario:

  CPU#0					CPU#1

  task-A SCHED_FIFO prio 30		task-C SCHED_FIFO prio 30 [curr]
  task-B SCHED_FIFO prio 40 [curr]

task-B is the currently executing task on CPU#0, task-C is the currently
executing task on CPU#1. Now on the vanilla 2.6 kernel, if task-C
blocks, there's no guarantee that task-A will be run there - if there's
a SCHED_NORMAL task on CPU#1's runqueue then it will run indefinitely. 
With global RT-balancing task-A will be scheduled on CPU#1 immediately
after task-C leaves it.

furthermore, if in the same scenario, if e.g. a RT-prio 35 task-D is
woken up on CPU#0, the vanilla 2.6 scheduler will not move it to CPU#1,
even though it could preempt the prio 30 task-C there. With global
RT-balancing this will happen and task-C will be preempted immediately
and task-D runs.

on low RT load (the common case) the scheduler behaves like the stock
scheduler - the new logic only kicks in if a CPU runqueue has 2 or more
RT tasks running at once.

anyway, while the feature is stable on my SMP testboxes, this is still a
nontrivial ~200-lines delta in the scheduler so there might be problems. 
UP should not be affected by this.

other changes since -V0.7.32-20:

 - local-APIC shutdown fix: this should solve some of the 'reboot hangs' 
   reports.

 - more tracing fixes - might fix the 'truncated traces' problems.

 - reduce the NMI watchdog frequency from 10 KHz to 1000 Hz.

 - dont report futex reschedules as atomicity violations

to create a -V0.7.32-0 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/2.6.10-rc2-mm2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm2-V0.7.32-0

	Ingo
