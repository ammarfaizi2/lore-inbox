Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbULNXR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbULNXR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULNXQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:16:26 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:12085 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261747AbULNXMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:12:42 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF48DAA6CB.4EA3A6BD-ON86256F6A.007B5393@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Tue, 14 Dec 2004 17:11:44 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/14/2004 05:11:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A comparison of PREEMPT_RT (with tracing) to PREEMPT_DESKTOP
(with tracing). Due to the tracing overheads (and the results
I measured in the last few days), I'll report on percentages
within 200 usec for RT and 100 usec on PK to make it "more fair".

Comparison of .33-00RT and .33-00PK results
00RT has PREEMPT_RT
00PK has PREEMPT_DESKTOP and no threaded IRQ's
2.4 has lowlat + preempt patches applied

  within 200/100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test   RT     PK        RT      PK   |   CPU  Elapsed
X     96.78  99.88      90 *    83+* |  97.20   70
top   93.87 100.00      36 *    31+  |  97.48   29
neto  99.17 100.00     340 *   193+  |  96.23   36
neti  99.13  98.39     340 *   280 * |  95.86   41
diskw 98.04 100.00?    350 *   310+  |  77.64   29
diskc 95.56  99.94     350 *   310+  |  84.12   77
diskr 90.77  99.94     220 *   310+  |  90.66   86
total                 1726    1517   |         368
 [higher is better]  [lower is better]
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
for min / average / max / mdev values. Again, tracing penalizes
RT much more than PK so this is to be expected.

The maximum duration of the CPU loop (as measured by the
application) is in the range of 2.05 msec to 3.30 compared
to the nominal 1.16 msec duration for -00RT. The equivalent
numbers for -00PK are 1.21 to 2.61 msec. I would expect RT
to be better than PK on this measure, but it never seems to
be the result I measure.

Based on the number of latency_trace files, -00RT still
is far better than -00PK. In particular, I get some extended
delays in -00PK from:
 - network (I have an 2000 usec example!)
 - rcu_process_callbacks (around 250 usec)
 - clear_page_range (around 170 usec)
 - free_pages_and_swap_cache (around 140 usec)
 - do_no_page (around 170 usec)
 - ide [IRQ?] (around 200 usec)
 - journal_remove_journal_head (> 1000 usec)
 - do_wait / wait_task_zombie (around 200 usec)
A fix to the network & journaling latencies would be helpful.
The others are certainly less important. I'll send the traces
separately.

Also, if you get some odd trace results on an SMP system,
Ingo already has some fixes applied in response to some buglets
I found & reported separately.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

