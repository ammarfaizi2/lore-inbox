Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUKCK5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUKCK5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUKCK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:57:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38071 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261544AbUKCK5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:57:46 -0500
Date: Wed, 3 Nov 2004 11:58:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>, "K.R. Foley" <kr@cybsft.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041103105840.GA3992@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027001542.GA29295@elte.hu>
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


i have released the -V0.7.1 Real-Time Preemption patch, which can be
downloaded from:

    http://redhat.com/~mingo/realtime-preempt/

this release is mainly a merge of -V0.6.9 to 2.6.10-rc2-mm2.

I havent done a proper changelog for a couple of days so here is a list
of bigger changes since -V0.4:

 - implemented a first version of the priority inheritance handling and
   priority inversion avoidance logic. This feature, after some initial
   stability problems, solved the jackd and rtc_wakeup latencies that
   were introduced by the ultra-finegrained locking in the -V series.

   (the -T/U series had a coarser locking scheme triggered much lower
   levels of priority inversion scenarios. The locking in the -V series
   was clearly the tipping point.)

   The new PI code covers all synchronization objects in Linux (on
   PREEMPT_REALTIME): spinlocks, rwlocks, semaphores and rwsems. 
   Feedback on the design of this code would be welcome, and patches as
   well, if you have a better scheme. The code is pretty modular so feel 
   free to experiment with alternative schemes.

 - completely reworked the debugging framework. All lock types
   (spinlocks, rwlocks, semaphores and rwsems) are now tracked, both
   their symbolic name and their place of acquire are traced and printed
   out upon detection of a deadlock. More and better information is
   printed upon a deadlock. Got rid of the 'semaphore owners array' in
   debugging mode, this reduces the footprint of semaphores quite
   significantly and speeds up deadlock detection.

 - got rid of the separate 'counted semaphores' implementation, it was
   too intrusive. Made the core 'generic semaphores' implementation
   compatible with vanilla Linux counted semaphore semantics. This also
   enabled the unrolling of the completion-handling cleanups which,
   while being very nice, were getting intrusive as well.

 - countless build and driver related reports/fixes from lots of people

 - more latency breaks in the remaining critical sections. A
   particularly important one was the irqs-off latency bugfix from
   Thomas Gleixner.

 - sped up the i8259 PIC and the PIT timer hardirq handling routines -
   these are now in the path of the longest latency.

 - cleaned up IRQ and signal preemption - there were missed
   check-rescheds and possibilities for IRQ recursion.

 - made ALSA's ioctl()s not use the BKL - this fixes more jackd
   latencies.

to create a -V0.7.1 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/2.6.10-rc1-mm2.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm2-V0.7.1

	Ingo
