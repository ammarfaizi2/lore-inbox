Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbUKCS01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUKCS01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUKCS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:26:26 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:1162 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261738AbUKCS0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:26:23 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Date: Wed, 3 Nov 2004 12:24:39 -0600
Message-ID: <OFD824DF3C.9378DEBF-ON86256F41.00652222-86256F41.0065224E@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/03/2004 12:24:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.1 Real-Time Preemption patch, which can be
>downloaded from:
>
>    http://redhat.com/~mingo/realtime-preempt/

V0.7.1 had build problems but after applying V0.7.7, I got a clean build
and was able to do some testing.

 - single user and telnet 5 were uneventful

 - preempt_wakeup_timing (PWT) is still generating false positives on SMP

 - after disabling PWT, I ran for over an hour without any latency
traces > 200 usec.

 - no crashes, lockups, or other fatal behavior in that same period

 - X test was generally OK. A few bursts of high overhead (> 1 msec)
on the CPU task and worst case was > 2 msec.

 - top test was a little cleaner, but its worst case was much worse
(over 17 msec).

 - network tests were similar, with even longer worst cases (21 msec and
32 msec)

 - disk I/O tests had some really odd results. The write test was much
cleaner than read / copy. All tests had > 25 msec worst cases. The read
test also had a pretty consistent variation on CPU overhead, about 500 usec
range (compared to 1160 usec nominal duration) in CPU loop timing.

A few other things I noticed:
 - whenever the real time test was active, responses to ping from another
system would basically stop until the real time test was done. In one case
about 25 ping packets were returned after a huge delay. From that, it
appears they were received but the return was delayed.
 - cat /proc/interrupts showed that LOC was increasing on both CPU's
during the tests.
 - the scheduler seems to prefer run my cpu_burn (nice'd) task instead
of updating the X display, doing the latency timing checks, ping responses,
and anything else that does useful work.
 - the disk write test was REALLY SLOW, perhaps hundreds of Kbytes per
second instead of what I normally see. I took much longer than the real
time audio test. I checked with top and noticed that "fam" was taking
near 100% of CPU time. I closed my konqueror window (just happened to be
looking at my test directory) and fam usage went away and the disk writes
sped up considerably. I don't recall seeing this symptom on -T3 or
previous tests, may try that later today to see if this is an old problem
or not.

This appears to be more stable than anything else since -T3 but the
odd spikes and scheduling symptoms are quite troubling.
  --Mark

