Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUKFO4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUKFO4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 09:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKFO4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 09:56:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12770 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261409AbUKFOzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 09:55:17 -0500
Date: Sat, 6 Nov 2004 16:57:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
Message-ID: <20041106155720.GA14950@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103105840.GA3992@elte.hu>
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


i have released the -V0.7.18 Real-Time Preemption patch, which can be
downloaded from:

   http://redhat.com/~mingo/realtime-preempt/

this release includes fixes and cleanups.

Changes between -V0.7.12 and -V0.7.18:

 - merged to 2.6.10-rc1-mm3

 - fixed the e1000 xmit warnings reported by Amit Shah. Same fix for tg3
   too.

 - added irq-latency fix from Thomas Gleixner: re-enable interrupts
   before adding timings to the entropy pool.

 - fixed excessive ksoftirqd overhead during outgoing TCP traffic. 
   ksoftirqd kept getting re-woken while it had no way to progress.

 - added upstream fix from Andi Kleen for the vmalloc bug causing module
   load problems/crashes. Added ipc/shm fix too.

Changes between -V0.7.1 and -V0.7.12:

 - big source level cleanups: completely rearranged the mutex type
   definitions and source files, to make it reflect the code. Made
   all locking objects based on a new, central lock type: struct
   rt_mutex. This type is never exposed externally, it is internal to
   the RT code. Unified all the RT locking code in kernel/rt.c, this 
   also simplified and sped things up. Undid collateral damage to the
   generic rwsem code - it is now untouched and independent of the RT
   code.

 - rearranged the way spinlocks interact with the RT code and cleaned 
   up the RT spinlock definitions. Found and fixed a bug in the process:
   rwlocks were dropping the BKL upon contention.

 - small x86 speedup: call __schedule not preempt_schedule_irq from
   work_resched.

 - ported PREEMPT_RT to x64. This resulted in the generalization of some
   of the x86 changes.

 - hopefully fixed fbcon kernel logging

 - hacked reiser4 to make it work on PREEMPT_REALTIME.

 - dropped the swap-layout-improvements patch. While it was working fine 
   it's not necessary for latencies anymore under the PREEMPT_REALTIME
   approach, and the swap-patch was getting intrusive.

 - fixed preemption-bug in drain_cpu_caches() on SMP [bug introduced by
   PREEMPT_REALTIME]

 - new attempt at getting rid of the networking related deadlocks

 - selinux deadlock fix and RCU-code conversion to RT semantics

to create a -V0.7.18 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.18

	Ingo
