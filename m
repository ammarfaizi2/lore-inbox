Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUH1MCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUH1MCe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUH1MCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:02:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27591 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266376AbUH1MCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:02:03 -0400
Date: Sat, 28 Aug 2004 14:03:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@RAYTHEON.COM
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q0
Message-ID: <20040828120309.GA17121@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824061459.GA29630@elte.hu>
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


i've uploaded the -Q0 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q0

note that since -bk4 doesnt exist yet, i've uploaded a patch that brings
2.6.8.1 up to BK-curr:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

apply this patch to 2.6.8.1 before applying the -Q0 patch.

Changes:

there are a number of fundamental changes in the -Q0, of both structural
and functional nature.

Structural changes:

Linus' current BK tree (what will be 2.6.9-rc1-bk4) has just merged most
of the might_sleep() improvements we did for -mm and a bunch of other
changes that were part of the voluntary-preempt patchset. So i've
started a pre-merge cleanup of the voluntary-preempt patchset, to be
able to merge as much of the remaining stuff upstream as possible. This
doesnt (necessarily) mean voluntary-preempt itself will be merged, it
means that the independent latency improvements move out of the
voluntary-preemption umbrella and will go upstream.

About the cleanup:

Firstly, the user controls have changed. There are now 4 independent
flags in /proc/sys/kernel/: kernel_preemption, voluntary_preemption,
softirq_preemption and hardirq_preemption - each default to a value of 1
(enabled). NOTE: levels 2,3 for voluntary_preemption is not valid
anymore, each of the flags can be 0 or 1. The flags control what their
name says, for best latencies one should keep all of them enabled.

Similarly, there are 4 independent options for the .config:
CONFIG_PREEMPT, CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS and
CONFIG_PREEMPT_HARDIRQS. (In theory all of these options should compile
independently, but i've only tested all-enabled so far.)

Internally, the voluntary_ prefixed conditional reschedule variants were
replaced by the existing cond_resched(), cond_resched_lock(),
need_resched()/etc. infrastructure.

Functional changes:

i took another look at SMP latencies, the last larger chunk of code that
produced millisec-category latencies. CONFIG_PREEMPT tries to solve some
of the SMP issues but there were still lots of problems remaining: main
problem area is spinlocks nested at multiple levels. If a piece of code
(e.g. the MM or ext3's journalling code) does the following:

	spin_lock(&spinlock_1);
	...
	spin_lock(&spinlock_2);
	...

then even with CONFIG_PREEMPT enabled, current kernels may spin on
spinlock_2 indefinitely. A number of critical sections break their long
paths by using cond_resched_lock(), but this does not break the path on
SMP, because need_resched() is not set in the above case.

(The -mm kernel introduced a couple of patches that try to drop
spinlocks unconditionally at a high frequency: but besides being a
kludge it's also a performance problem, we keep
dropping/waiting/retaking locks quite frequently. That solution also
doesnt solve the problem of cond_resched_lock() not working on SMP.)

to solve the problem i've introduced a new spinlock field,
lock->break_lock, which signals towards the holding CPU that a
spinlock-break is requested by another CPU. This field is only set if a
CPU is spinning in __preempt_spin_lock [at any locking depth], so the
default overhead is zero. I've extended cond_resched_lock() to check for
this flag - in this case we can also save a reschedule. I've added the
lock_need_resched(lock) and need_lockbreak(lock) methods to check for
the need to break out of a critical section.

preliminary results on a dual x86 box show a dramatic reduction in
latencies on SMP - where there used to be 5-10 msec latencies there are
close-to-UP latencies now. But it needs more testing.

the -Q0 patch also adds a number of lock-breaks that are part of the -mm
tree: e.g. the PTY lock-break.

please re-send any patches that i havent merged yet, and re-report
latencies that still occur with -Q0.

	Ingo
