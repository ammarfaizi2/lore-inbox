Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUJ0NGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUJ0NGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUJ0NFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:05:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3305 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262427AbUJ0NCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:02:51 -0400
Date: Wed, 27 Oct 2004 15:03:59 +0200
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
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041027130359.GA6203@elte.hu>
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


i have released the -V0.4 Real-Time Preemption patch, which can be
downloaded from:

   http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release, but still experimental.

this release should fix more bugs of the 'slowdown' and 'interactivity
problems' variety.

To debug the wakeup anomalies reported i've implemented a new variant of
the latency tracer, which now traces 'wakeup latencies' too - i.e. it
measures and traces maximum delays observed from the point of wakeup to
the point of the really starting to execute. Only the highest-priority
runnable task in the system is traced at a time, but this should be more
than enough to find the high latency scheduling paths.

This new tracing mode can be enabled by compiling a LATENCY_TRACE kernel
as usual and doing:

	echo 4 > /proc/sys/kernel/trace_enabled

then to start tracing, reset the current max latency value via e.g.:

	echo 10 > /proc/sys/kernel/preempt_max_latency

then the kernel should signal wakeup latency events in the syslog:

  (sshd/3093/CPU#0): new 18 us maximum-latency wakeup.
  (sshd/3093/CPU#0): new 19 us maximum-latency wakeup.
  (hackbench/3818/CPU#0): new 20 us maximum-latency wakeup.
  (hackbench/3762/CPU#0): new 21 us maximum-latency wakeup.
  (hackbench/3814/CPU#0): new 22 us maximum-latency wakeup.
  (ksoftirqd/0/3/CPU#0): new 35 us maximum-latency wakeup.

the latency trace of the last (and highest) event can always be found in
/proc/latency_trace, as usual. Note that the trace output is a bit
different in the wakeup-tracing case.

NOTE: the tracer works on SMP too, but since on SMP tasks can switch
from one CPU to another a given trace can be less useful if the delay
happened on another CPU.

using this wakeup tracer i found and fixed a couple of 'missed
preemption check' bugs - all introduced by PREEMPT_REALTIME in the -U/-V
timeframe. So if you had latency/interactivity problems please re-check
-V0.4.

the wakeup tracer is nice in the sense of that it traces actual, realy.

Changes since -V0.3.2:

 - fixed the rtc_lock related crash reported by K.R. Foley and Robert 
   Crocombe.

 - fixed missing preemption checks in rwsem-generic.c

 - fixed missing preemption check in schedule_tail() [==new task wakeup]

 - implemented wakeup-latency tracer

to create a -V0.4 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-V0.4

	Ingo
