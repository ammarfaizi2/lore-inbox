Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbULIRSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbULIRSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULIRSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:18:15 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:58293 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261359AbULIRRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:17:31 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8CB9B8EE.C928A668-ON86256F65.0058B4C3@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 10:56:14 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 10:56:15 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't take this message the wrong way. I strongly support what
Ingo is doing with the 2.6 kernel. Its just sometimes the measurements
don't seem to show the improvements everyone wants to see.

>But you do have set your reference irq (soundcard) to the highest prio
>in the PREEMPT_RT case? I just ask to make sure.
Yes, but then I have ALL the IRQ's at the highest priority (plus a couple
other /0 and /1 tasks). Please note, I only use latencytest (an audio
application) to get an idea of RT performance on a desktop machine
before I consider using the kernel for my real application.

In my "real" application (a large real time simulation running on a
cluster) I cannot necessarily assign one batch of IRQ's higher than
any others (nor above / below the main RT tasks). The character of
my RT application is something like this:
 - an interrupt is delivered on a periodic basis across the
PCI bus / shared memory interface to synchronize operations
across the cluster
 - one or more active RT tasks doing compute (mix of logical and
floating point operations)
 - bursts of PCI activity on a shared memory interface between
cluster nodes (think message passing)
 - bursts of network activity (primarily on the head node)
 - occasional bursts of disk I/O, primarily reads but some writes
to preallocated files
 - non RT monitoring (plus a FEW daemons)
CPU load is pretty steady at up to 20% for any of the two CPU nodes
in the cluster. The upper bound for OS overhead (latency) I need is
about 1 msec (out of a 12.5 msec / 80 Hz frame). I do have some
long CPU runs / PCI shared memory traffic in the 80 Hz task at
a one per second rate that might take up to 10 msec of the 12.5
msec frame.

I could set the IRQ priority of the shared memory interface to be
the highest (since I do task scheduling based on it) but after
that there is also no preset assignment of priority to I/O activity.
Some form of priority inheritance may be "better" but I understand
that is not likely to be implemented (nor worth the effort).

By setting the IRQ threads to RT FIFO 99, I also get something closer
to PREEMPT_DESKTOP w/o IRQ threading (or for that matter, closer to
the 2.4 kernel I use today). It shows more clearly the overhead
of adding the threads.

The other place where PREEMPT_RT shows the overhead is in simple
activities like a ping. The average time to respond to a ping on a
stock kernel (or PREEMPT_DESKTOP) on my hardware is about 150 usec
and over twice that on PREEMPT_RT.

>Also, the PK results
>can probably even be improved by having all irq handlers threaded except
>for the soundcard irq.
Again, I don't really see a benefit for my real application.

Don't get me wrong. I see a lot of benefit for what Ingo is doing
to the 2.6 kernel. If I see a fix to the non RT process starvation
problem, I don't see any serious problems preventing me from
deploying a 2.6 PREEMPT_DESKTOP kernel. It will be the first 2.6 kernel
that works better for my application than the 2.4 kernel I use today.

It would be better to have PREEMPT_RT at that same point. It solves
some knotty problems (like how to avoid chains of hard / soft IRQ's
from preempting a real time task) but the threading overhead and
related application performance impacts that get introduced at this
point seem pretty significant to me. As Ingo noted in a private
message
  "IRQ-threading will always be more expensive than direct IRQs,
   but it should be a fixed overhead not some drastic degradation."
I agree the overhead should be modest but somehow the test cases I
run don't show that (yet). There is certainly more work to be done
to fix that.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

