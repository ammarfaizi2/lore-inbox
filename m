Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbUKLRFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUKLRFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUKLREJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:04:09 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:64854 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262599AbUKLRBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 12:01:12 -0500
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
Date: Fri, 12 Nov 2004 10:58:38 -0600
Message-ID: <OF201B61B1.F0A7806E-ON86256F4A.005D427B-86256F4A.005D4299@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/12/2004 10:58:42 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

This builds just fine and runs without any serious failures. The RT
performance still has rough edges with several bursts of long
delays in the CPU loop of latencytest. These tests are all on an
SMP system with CONFIG_PREEMPT_RT and full tracing enabled.

I have sent several log files to Ingo separately but the following
summarizes what I am seeing:

 [1] major network delays while latencytest is running (ping drops packets
or they get delayed by minutes). I did not see this on some previous tests
where I made more of the /0 and /1 tasks RT. May have to do that again.
 [2] display / keyboard / mouse will occasionally freeze or act much more
slowly than on a non PREEMPT_RT kernel.
 [3] I no longer see the major delays in events/0 and /1. This particular
live lock appears to be solved. I actually don't see any tasks or
applications taking a lot of CPU time except cpu_burn and latencytest
(both should). This is a little puzzling since with the poor response
to non RT / interactive activities, I would expect to see something
take up the CPU time.
 [4] the user latency traces show the RT CPU loop in latencytrace being
delayed by a variety of kernel activites. I also note that preempt_count
is zero during several periods of the trace so I'm surprised that we did
not continue to run the RT task (and do this stuff on the other CPU).
These delays have hundreds of entries with over 100 usec delay overall.
 [5] I can make the symptoms MUCH worse by simply running my cpu_burn
application as a non realtime application. (no I/O or system calls, just
a simple loop) This is run as a nice'd application so should run only
when nothing else is ready to run.
 [6] the latency trace may have some SMP race conditions where the entries
displayed do not match the header. Examples are a 100 usec trace header
followed by 8 entries that last about 4 usec.
 [7] both the wakeup and the preempt disable traces do not show any
significant periods of delays. The most I can get out of these is
roughly 100 usec which I believe correlates with disk DMA and the
particular motherboard chip set on the system under test. This
looks really good if [4] can be fixed.
 [8] Some samples of /proc/loadavg during my big test showed some
extremely large numbers. For example:
5.07 402.44 0.58 5/120 4448
6.35 195.67 1.63 7/122 4663
5.39 130.82 2.20 18/122 4705
2.10 43.17 3.00 8/122 5912
8.90 8.89 4.70 10/123 7780
8.33 8.52 4.95 6/124 7887
Not quite sure what a 5 minute loadavg of 402 means when I have
only a 120 tasks in the system. May be a symptom of some bug in
the load average calculations (and not PREEMPT_RT related) but
not sure.

  --Mark

