Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbUKUXwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUKUXwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUKUXwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:52:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51089 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261847AbUKUXwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:52:05 -0500
Date: Mon, 22 Nov 2004 01:54:11 +0100
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
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122005411.GA19363@elte.hu>
References: <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118164612.GA17040@elte.hu>
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


i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
downloaded from the usual place:

	http://redhat.com/~mingo/realtime-preempt/

the biggest change in this release are fixes for priority-inheritance
bugs uncovered by Esben Nielsen pi_test suite. These bugs could explain
some of the jackd-under-load latencies reported.

Changes since -V0.7.29-0:

 - priority inheritance handling fixes:

    - sort the RT wakees at wakeup time, not at block-time: an RT task
      might have gotten boosted while it slept.

    - fix priority-restoration bug at mutex-release time

    - use task_rt() not p->policy to determine whether a task needs 
      PI handling - a SCHED_OTHER task might be boosted to RT prio.

    - fix mutex_setprio() bug: queue now-RT tasks to the active array, 
      otherwise expired SCHED_OTHER tasks will not be properly boosted.

 - went back to the mask-and-delay method of handling hardirqs on 
   UP-IOAPIC as well. Due to APIC prioritization hardirqs can get
   delayed by another, unacked hardirq, so the quick method needs more 
   work before it can be used.

 - added Thomas Gleixner's semaphore -> completion changes for 
   drv->unload_sem. This fixes the module unload crashes reported by 
   Rui Nuno Capela and Shane Shrybman.

 - dvb mutex updates for RT, this fixes the bug reported by Christian 
   Meder.

 - e100 fix from K.R. Foley - this should fix the boot-time e100
   enable_irq warning.

 - NFS lockd mutex RT fixes from Thomas Gleixner - this could fix some
   of the bugs reported by Bill Huey.

 - PREEMPT_VOLUNTARY fixes - this could fix the boot-time hang reported 
   by Lee Revell.

 - wake up irq thread upon creation - this solves the 'irq thread only 
   changes priority after first interrupt arrives' anomaly reported.

to create a -V0.7.30-2 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/2.6.10-rc2-mm2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm2-V0.7.30-2

	Ingo
