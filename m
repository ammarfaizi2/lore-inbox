Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUKOSlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUKOSlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUKOSlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:41:25 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:59936 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261662AbUKOSlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:41:18 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Date: Mon, 15 Nov 2004 12:40:08 -0600
Message-ID: <OFCFA96E95.192AA15E-ON86256F4D.00668D28-86256F4D.00668D43@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/15/2004 12:40:11 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't see an announcement for V0.7.26, so I'll post this summary
under this title.

Built today with V0.7.26-4 without any problems. System booted up
and telnet 5 was uneventful as well.

Ran two series of tests with latencytest and my stress tests with
the following results:

[1] Appear to have a new symptom of 200 usec delays at raw_read_unlock
which doesn't make any sense to me. Have included a latency trace
at the end of this message with an example. An occasional 100 usec
hit I understand (disk DMA) but I don't recall seeing this symptom
before.

[2] Still get the symptoms with truncated trace output and bad
ping responses. Refer to my previous messages for examples.

[3] The logging script (sleep 5 seconds, record data if slept for
over 10 seconds) was triggered about 30 times in an hour of testing.
None have the huge load average values reported last time but
several have 1 minute load averages above 15 (expect 6-8).

[4] All of the tests have bursts of long application level delays.
I'll be running another test program to see if I can find anything
with the user level tracing. Disk activity seems to make it worse
but all the tests had at least one CPU delay over a millisecond.
There seems to be a "short" (well > 500 usec) delay related to
disk reads and a longer one for disk writes.

[5] System after testing was done had a major "time shift"
as noted in the system log.

Nov 15 12:33:55 dws77 ntpd[2359]: synchronized to 192.52.216.4, stratum=3
Nov 15 12:33:57 dws77 ntpd[2359]: synchronized to 192.52.216.1, stratum=2
Nov 15 12:33:36 dws77 ntpd[2359]: time reset -21.466037 s
Nov 15 12:33:36 dws77 ntpd[2359]: frequency error -512 PPM exceeds
tolerance 500 PPM

No crashes nor any major stability problems.
  --Mark

--- 200 usec latency example ---
preemption latency trace v1.0.7 on 2.6.10-rc1-mm3-RT-V0.7.26-4
-------------------------------------------------------
 latency: 206 us, entries: 12 (12)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kjournald/1209, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: __down_mutex+0x3f/0x300 <c032d9af>
 => ended at:   __down_mutex+0x1a6/0x300 <c032db16>
=======>
 1209 80000000 0.000ms (+0.002ms): __down_mutex (__spin_lock)
 1209 80000000 0.002ms (+0.001ms): _raw_spin_lock (__down_mutex)
 1209 80000000 0.004ms (+0.000ms): _raw_spin_lock (__down_mutex)
 1209 80000000 0.004ms (+0.000ms): do_nmi (__down_mutex)
 1209 80000000 0.005ms (+0.000ms): do_nmi (mcount)
 1209 80000000 0.005ms (+0.000ms): do_nmi (<00200286>)
 1209 80000000 0.006ms (+0.000ms): profile_hook (profile_tick)
 1209 80000000 0.006ms (+0.000ms): _raw_read_lock (profile_hook)
 1209 80000000 0.007ms (+0.196ms): _raw_read_unlock (profile_tick)
 1209 80000000 0.204ms (+0.001ms): set_new_owner (__down_mutex)
 1209 80000000 0.205ms (+0.000ms): _raw_spin_unlock (__down_mutex)
 1209 80000000 0.205ms (+0.000ms): _raw_spin_unlock (__down_mutex)

