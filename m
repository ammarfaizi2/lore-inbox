Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbULMRL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbULMRL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULMRLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:11:09 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:54114 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261312AbULMRIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:08:48 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFA329B47C.3EDA9672-ON86256F69.005967F1@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 13 Dec 2004 11:05:13 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/13/2004 11:07:57 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A comparison of PREEMPT_RT (no tracing) to PREEMPT_DESKTOP
(with tracing) to help answer previous requests.

Comparison of .32-20RT and .32-18PK results
20RT has PREEMPT_RT (all tracing disabled)
18PK has PREEMPT_DESKTOP and no threaded IRQ's (tracing enabled)
2.4 has lowlat + preempt patches applied

      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test   RT     PK        RT      PK   |   CPU  Elapsed
X     99.87 100.00&     65 *    64+  |  97.20   70
top   99.35 100.00&     31 *    31+  |  97.48   29
neto  96.94 100.00&    113 *   184+  |  96.23   36
neti  97.05 100.00&    119 *   170+  |  95.86   41
diskw 94.36  99.99      30 *    61+  |  77.64   29
diskc 93.85  99.34      98 *   310+  |  84.12   77
diskr 99.39  99.96     133 *   310+  |  90.66   86
total                  589    1130   |         368
 [higher is better]  [lower is better]
* wide variation in audio duration
+ long stretch of audio duration "too fast"
& 100% to digits shown, had a FEW samples > 100 usec.

The results for -20RT (without tracing) are much better than
-18RT (with tracing) but still not quite as good as -18PK
with respect to the 100 usec delays.

The overhead of threading the IRQ's (and rescheduling the
RT application making the measurements) is likely cause of
the difference in 100 usec latency measurements.

I believe the threading overhead is confirmed by the slightly
slower ping response measurements:
  RT 0.134 / 0.208 / 1.502 / 0.075 msec
  PK 0.102 / 0.164 / 0.708 / 0.044 msec
for min / average / max / mdev values. These are much
better than with -18RT (with tracing) as well. Apparently the
tracing overhead is pretty high in the task switching area.

The maximum duration of the CPU loop (as measured by the
application) is in the range of 1.42 msec to 2.57 compared
to the nominal 1.16 msec duration for -20RT.

The non RT starvation problem appears to be mitigated quite
a bit by removing the tracing. I did a follow up test without
cpu_burn (non RT, nice) and the elapsed times varied in an
odd pattern:

  with cpu_burn      65  31 113 119  30  98 133
  without cpu_burn   63  30 121 150  32  87  97

The disk numbers are getting much closer to the 2.4 values
so removal of cpu_burn definitely helps prevent starvation.
The larger network numbers are something I should probably
confirm on my 2.4 test system to see if something changed
on the network to skew the results.

I will be building a -20PK without tracing for a more complete
comparison.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

