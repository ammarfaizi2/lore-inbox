Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbULMXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbULMXQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbULMXQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:16:15 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:64159 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261209AbULMXQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:16:10 -0500
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
Message-ID: <OF98A20B07.E99AF3FF-ON86256F69.007E772D@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 13 Dec 2004 17:14:32 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/13/2004 05:14:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
> > The maximum duration of the CPU loop (as measured by the application)
> > is in the range of 1.42 msec to 2.57 compared to the nominal 1.16 msec
> > duration for -20RT.  The equivalent numbers for -20PK are 1.28 to 1.93
> > msec. [...]
>
> so -20RT has resolved all the CPU-loop-max-delay issues of the -RT
> kernel regarding the RT-priority CPU loop and in essence adds only a
> small amount of delay (100 usecs?) to the nominal (==minimum possible)
> delay?
I believe so, or in other words a minor penalty to average latency impact
to get a reduction in maximum latency [though I am not sure I actually
measured such a reduction].

> i suspect the 100 usecs comparison is an effect of the cutoff value
> being a single value. Also, 100 usecs is so close to the DMA related
> delay which makes it hard to compare it - other than stating that -RT
> has higher CPU overhead.
I think we agree on this assessment. I don't think the threading overhead
is 100 usec but more likely 50 usec [at least on my hardware - see below].
That the extra 50 usec puts us over the 100 usec measure is unfortunate.

> are the ping times still considered anomalous? Could be a side-effect of
> the different flow of control between hardirq/softirq contexts. (There
> have been a (low but nonzero) number of assumptions about the flow in
> pieces of softirq code, and there could be more.)
Please note that to get the ping times I stated, I set the priority of
ksoftirqd/0 and /1 to 99 (along with the IRQ threads). Others won't be
so generous and get different results.

I believe the longer duration with -20RT is due to the threading overhead.
Look at the numbers for -20PK and -20RT, the minimums are
  -20PK 0.089 msec (or 089 usec)
  -20RT 0.134 msec (or 134 usec)
or a difference of about 50 usec. If the sequence of steps is something
like
  Network Interrupt -T-> Network IRQ -T-> ksoftirqd/0 -> ping reply
on -RT and
  Network Interrupt -> Network IRQ -> soft IRQ -> ping reply
on -PK, the difference measured is likely reasonable.

[where -T-> represents a new thread activation, and -> represents something
like a function call]

Again, the benefit of PREEMPT_RT (over PREEMPT_DESKTOP) should be reduced
maximum latencies with a modest (or very little) impact to overall
performance / throughput. We are certainly getting a lot closer on
reaching that goal.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

