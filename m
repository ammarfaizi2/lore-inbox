Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbUKRLe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbUKRLe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbUKRLey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:34:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43975 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262737AbUKRLeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:34:07 -0500
Date: Thu, 18 Nov 2004 13:35:21 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041118123521.GA29091@elte.hu>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117124234.GA25956@elte.hu>
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


i have released the -V0.7.28-1 Real-Time Preemption patch, which can be
downloaded from the usual place:

	http://redhat.com/~mingo/realtime-preempt/

this should fix the lockup bug reported by Florian Schmidt.

there's a generic PREEMPT bug in the upstream kernel: there exists a
single-instruction race window in __flush_tlb(), if the kernel preempted
exactly there in a lazy-TLB thread and certain other, rare scheduling
and MM properties were true as well (a certain constellation of threads
and lazy-TLB kernel threads occured), and the lazy-TLB task then got
another user TLB to inherit, and switched to a task from which it
inherited that new TLB, thus the wrong cr3 was loaded and inherited by
this next, non-lazy-TLB next task; then (and only then) this scenario
would typically manifest itself in the form of an infinite pagefault
lockup occuring much after the fact, upon the next userspace access (to
the joy of a totally baffled kernel developer). I suspect from the
description you can guess how much fun it was to debug it =B-)

the bug is even more rare in the generic kernel, because there most (but
not all) TLB flush points are in a critical section.

this fix could resolve some of the other 'my box just locked up'
reports.

Changes since a -V0.7.28-0:

 - reverted the UP-ioapic change - it was unrelated to the lockup and it
   is known to cause problems on certain IDE/soundcard combinations.

 - fixed and improved the trace_print_on_crash tracing feature - it was
   highly needed to find the TLB bug ...

to create a -V0.7.28-1 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/2.6.10-rc2-mm1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.28-1

	Ingo
