Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUKIVJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUKIVJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUKIVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:09:47 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:16976 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261683AbUKIVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:09:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC1C59379.C97F0CF1-ON86256F47.00720C09@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Tue, 9 Nov 2004 15:07:32 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/09/2004 03:07:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.23 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/

A few notes on results from running with this patch (well, actually -EA
that Ingo provided separately).

[1] Build problems, separately reported to Ingo with CONFIG_PREEMPT_RT
enabled on x86 and you have modules using kunmap_atomic. Fix by adding
kunmap_virt and kmap_to_page to the list of exports.

[2] The live lock that I was having seems to have been killed based
on an hour of testing (I could usually cause it in 5 minutes or less).

[3] I am not so sure that the latency tracing works. I do not get any
trace output, even if I set preempt_max_latency to zero. I also noticed
that /proc/sys/kernel/preempt_wakeup_timing was removed at .20 but
not sure if that was deliberate. As a result, I have no reports from
the kernel tracing.

[4] Application level latencies are OK but not great.
 X test - only 90% of CPU loops are within 100 usec of nominal value.
In previous RT kernels I got > 99% with 100 usec.
 top test - looks much nicer than X test, but still have up to 30%
overhead on CPU loop.
 network I/O tests - smoothest of all test results, very nice
 disk write - very noisy, bursts of long delays with only 82% within
100 usec and worst case has over 100% overhead (2.5 msec vs 1.16 nominal)
 disk copy - fewer bursts, but worst case is similar to disk write.
About 95% within 100 usec.
 disk read - relatively clean with a pair of modest bursts early in
the test and then settled out a little worse than the network tests.
99.9% of samples within 100 usec and max of 1.65 msec.

[5] concurrent ping of system had over 13% lost packets (1089 out
of 10723 - plus I let this run after the tests had completed). The
2.4 RT kernel I use has no lost packets.

[6] I did a separate run of a script Ingo suggested that samples
the kernel profile data. It shows basically no CPU time for the
events/0 and events/1 tasks. I took 11 samples in about 1/2 hour
of testing but nothing seems to jump out of the data.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

