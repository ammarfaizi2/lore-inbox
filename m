Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbULAO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbULAO6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULAO6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:58:25 -0500
Received: from bos-gate1.raytheon.com ([199.46.198.230]:52259 "EHLO
	bos-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261267AbULAO6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:58:02 -0500
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFD409C8B3.8F810860-ON86256F5D.004D6614@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Wed, 1 Dec 2004 08:57:02 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/01/2004 08:57:11 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>interesting numbers. The slowdown in networking could easily be due to
>IRQ and softirq threading, so it would make sense to also add a "PNT"
>test (preempt, non-threaded), just to have something functionally
>comparable to 2.4 lowlat+preempt.
Unless I am mistaken, my "PK" config is the closest to 2.4 lowlat+preempt.
For the relevant differences in .config:
  PK                                  RT
  CONFIG_PREEMPT_DESKTOP=y            CONFIG_PREEMPT_DESKTOP is not set
  CONFIG_PREEMPT_RT is not set        CONFIG_PREEMPT_RT=y
  CONFIG_PREEMPT=y                    CONFIG_PREEMPT=y
  CONFIG_PREEMPT_SOFTIRQS is not set  CONFIG_PREEMPT_SOFTIRQS=y
  CONFIG_PREEMPT_HARDIRQS is not set  CONFIG_PREEMPT_HARDIRQS=y
(though the system still creates ksoftirqd/0 and /1 on both...)
  CONFIG_SPINLOCK_BKL is not set      [not present]
  CONFIG_PREEMPT_BKL=y                CONFIG_PREEMPT_BKL=y
  CONFIG_ASM_SEMAPHORES=y             [not present]
  CONFIG_RWSEM_XCHGADD_ALGORITHM=y    [not present]
  ...
  [not present]                       CONFIG_RT_DEADLOCK_DETECT=y
  ...

Unless you are saying that I should back off to one of the other
preempt settings (to replicate the 2.4 config on 2.6).

Also, I ran another set of tests with -15 late yesterday. The
results were not necessarily consistent with -9. I had to run
the -PK tests twice due to an error that
  /dev/dsp was busy
which aborted one of the latencytest runs (not the first one...).
The line below with "dnr" is from that run.

[the -15 data follows in the same format as the -9 data yesterday]
The 2.4 numbers are from 2.4.24 w/ low latency / preempt patches.

      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test    PK     RT       PK      RT   |   CPU  Elapsed
X     99.66  99.22      53 *    68   |  97.20   70
top   99.92  97.96     240+     34   |  97.48   29
neto    dnr  99.98     dnr     360   |  96.23   36
neti  98.22  98.31     270 *   350   |  95.86   41
diskw 94.11  99.57     295+*   360 * |  77.64   29
diskc 99.67  97.49     310+*   360   |  84.12   77
diskr 99.52  98.35     310+*   180   |  90.66   86
total                 1478    1712   |         368
did not count neto in this total^^
* wide variation in audio duration
+ had long stretches of audio duration well below the nominal
duration

Both the -PK and -RT tests had long pauses where the sampling
scripts I use did not capture any data. The profile script had
elapsed times of 77, 192, 52, 106, 305, and 82 seconds [for a
5 second sleep]. The load average after each of these pauses
ranged from 8.8 to 16.1. It still looks like the cpu_burn program
(non RT, nice) is starving the other normal non RT tasks
(should not happen...).

I am still getting lots of truncated latency_trace results.

The latency_trace output doesn't seem to get the process name
right. Most traces look something like this [truncated example]

preemption latency trace v1.1.1 on 2.6.10-rc2-mm3-V0.7.31-15RT
--------------------------------------------------------
 latency: 102 us, entries: 1(1)    |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: cat/9789, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: buffered_rmqueue+0x69/0x180 <c014f859>
 => ended at:   buffered_rmqueue+0xa3/0x180 <c014f89e>
========>
<unknown-9789 80000000 0.000ms (+0.000ms): buffered_rmqueue (__alloc_pages)

So the name is correct in the header but not in the trace lines in
most (but not ALL) cases. I have another example where IRQ 0/2 was
traced and its lines were OK in the trace, but I had references to
unknown-2036, unknown-2044, and unknown-3802 in the trace. This
one example appeared to be a task switch from unknown-2036 to
IRQ 0-2 and the traces are OK after the line with __switch_to in it.
Let me know if you need examples (I have plenty to choose from).

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

