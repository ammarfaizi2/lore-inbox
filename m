Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbULIS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbULIS0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 13:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULIS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 13:26:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56469 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261577AbULIS0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 13:26:50 -0500
Date: Thu, 9 Dec 2004 19:26:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Florian Schmidt <mista.tapas@gmx.net>, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209182626.GA13132@elte.hu>
References: <OF8CB9B8EE.C928A668-ON86256F65.0058B4C3@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8CB9B8EE.C928A668-ON86256F65.0058B4C3@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> In my "real" application (a large real time simulation running on a
> cluster) I cannot necessarily assign one batch of IRQ's higher than
> any others (nor above / below the main RT tasks). The character of
> my RT application is something like this:
> [...]

> CPU load is pretty steady at up to 20% for any of the two CPU nodes in
> the cluster. The upper bound for OS overhead (latency) I need is about
> 1 msec (out of a 12.5 msec / 80 Hz frame). I do have some long CPU
> runs / PCI shared memory traffic in the 80 Hz task at a one per second
> rate that might take up to 10 msec of the 12.5 msec frame.

so the 1 msec latency is needed by this 80 Hz task? I'd thus make this
task prio 90 (higher than most IRQ handlers), and make the 80 Hz
timesource's [timer IRQ? RTC? special driver?] IRQ thread prio 91. All
other IRQ threads should be below prio 90. Whatever else this task
triggers will be handled either by PI handling, or is started enough in
advance (such as disk IO or network IO) to be completed by the time the
80 Hz task needs it.

> I could set the IRQ priority of the shared memory interface to be the
> highest (since I do task scheduling based on it) but after that there
> is also no preset assignment of priority to I/O activity.

but if this is the task that needs to do its work within 1 msec when
signalled, it should be the highest prio one nevertheless, and no IRQ
(except the signal IRQ) must be allowed to preempt it.

(The other tasks can 'feed' this master task with whatever scheduling
pattern, as long as the 'master task' provides frames with a precise 80
Hz frequency. Any jitter to the execution of these other threads is
handled by buffering enough stuff in advance.)

> Some form of priority inheritance may be "better" but I understand
> that is not likely to be implemented (nor worth the effort).

the master task's priority will be inherited across most of the
dependencies that might happen at the kernel level. [ If it doesnt then
it should show up in traces and i'm most interested in fixing it ... ]

> By setting the IRQ threads to RT FIFO 99, I also get something closer
> to PREEMPT_DESKTOP w/o IRQ threading (or for that matter, closer to
> the 2.4 kernel I use today). It shows more clearly the overhead of
> adding the threads.

i believe this is the wrong model for this workload.

> [...] As Ingo noted in a private message
>   "IRQ-threading will always be more expensive than direct IRQs,
>    but it should be a fixed overhead not some drastic degradation."
>
> I agree the overhead should be modest but somehow the test cases I run
> don't show that (yet). There is certainly more work to be done to fix
> that.

have you tried it with all debugging turned off? I'd like to fix any
performance problems related to IRQ/softirq threading. (If you mean the
'lost pings' problem, that one looks like to be more of a priority
inversion problem than a real performance issue.)

	Ingo
