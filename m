Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVADU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVADU43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVADUz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:55:57 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:41683 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262132AbVADUw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:52:28 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
From: Mark_H_Johnson@raytheon.com
Subject: Real-Time Preemption, comparison to 2.6.10-mm1
Date: Tue, 4 Jan 2005 14:11:56 -0600
Message-ID: <OF57960072.EA98312D-ON86256F7F.006EF463-86256F7F.006EF501@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/04/2005 02:49:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just finished a couple test runs of 2.6.10-mm1 (no realtime preemption)
patches for comparison. The results show that the realtime preemption
patches go a long way to improving the latency of the kernel as measured
by the maximum duration of the CPU loop in latencytest. This was on my
two CPU test system (866 Mhz Pentium III).

Comparison of 2.6.9-V0.7.33-00RT and .33-00PK results with 2.6.10-mm1

00RT has PREEMPT_RT (and tracing)
00PK has PREEMPT_DESKTOP and no threaded IRQ's (and tracing)
mm1 is 2.6.10-mm1 with CONFIG_PREEMPT=y and CONFIG_PREEMPT_BKL=y
2.4 has lowlat + preempt patches applied

% within 100 usec (200 usec for RT due to tracing overhead)
           CPU loop (%)          Elapsed Time (sec)        2.4
Test   mm1     RT     PK       mm1     RT      PK   |   CPU  Elapsed
X     99.90  96.78  99.88       62 *   90 *    83+* |  97.20   70
top   99.94  93.87 100.00       30 *   36 *    31+  |  97.48   29
neto  94.16  99.17 100.00       75 *  340 *   193+  |  96.23   36
neti  93.92  99.13  98.39       54 *  340 *   280 * |  95.86   41
diskw 89.16  98.04 100.00?      64 *  350 *   310+  |  77.64   29
diskc 92.31  95.56  99.94      320+*  350 *   310+  |  84.12   77
diskr 95.06  90.77  99.94      310+*  220 *   310+  |  90.66   86
total                          915   1726    1517   |         368
        [higher is better]        [lower is better]
* wide variation in audio duration
+ long stretch of audio duration "too fast"
? I believe I had non RT starvation & this result is in error
[chart shows a typical results for about 20 seconds and then
gets "really smooth" like the top chart for the remainder of
the measured duration]

The percentages are all within a handful of a percent so these
results look pretty comparable.

Looking at ping response time:
  RT 0.226 / 0.486 / 2.475 / 0.083 msec
  PK 0.102 / 0.174 / 0.813 / 0.054 msec
 mm1 0.087 / 0.150 / 2.279 / 0.125 msec
for min / average / max / mdev values. Again, tracing penalizes
RT much more than PK so this is to be expected. The higher variation
on mm1 is perhaps to be expected (as well as the max value). The min
value is comparable to PK & is likely smaller due to differences in
tracing (PK had tracing, mm1 does not).

The maximum duration of the CPU loop (as measured by the
application) is in the range of 2.05 msec to 3.30 compared
to the nominal 1.16 msec duration for -00RT. The equivalent
numbers for -00PK are 1.21 to 2.61 msec. I would expect RT
to be better than PK on this measure, but it never seems to
be the result I measure. For the mm1 kernel, the range was
much larger (as expected) from 1.18 to 5.59 msec. The huge
latencies in mm1 are primarily in disk reads & copies /
overhead of the ext3 file system.

The non RT application starvation for mm1 was much less
pronounced but still present. I could watch the disk light
on the last two tests & see it go out (and stay out) for an
extended period. It does not make sense to me that a single RT
application (on a two CPU machine) and a nice'd non RT application
can cause this starvation behavior. This behavior was not
present on the 2.4 kernels and seems to be a regression to me.

I will put together a pair of 2.6.10-mm1-V0.7.34-xx kernels
tomorrow and rerun the tests to see if the results are consistent.

  --Mark

