Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbULJVzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbULJVzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbULJVzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:55:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45790 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261827AbULJVyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:54:51 -0500
Date: Fri, 10 Dec 2004 22:54:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041210215443.GB7609@elte.hu>
References: <OF3220A1AC.7E7F07CF-ON86256F66.00749EC3@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3220A1AC.7E7F07CF-ON86256F66.00749EC3@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> Hmm. Now that I look at it, the duration in the header (99 usec) is
> the duration of lt.01 (as reported by the script) but the total
> duration of the trace (248 usec) is the duration from the script for
> lt.02.

how do your collection scripts access /proc/latency_trace? The output is 
only atomic if the file is read as a whole, i.e.:

	cat /proc/latency_trace > wherever

or:

	cp /proc/latency wherever

but i guess you are doing this already ...

obviously tracing goes on while the scripts are saving the latency
trace, so the kernel goes to great lengths to try to guarantee
atomicity. There are 3 levels of tracing buffers:

	- 'current' trace buffers (per CPU)
	- 'max' trace buffer
	- 'output' trace buffer

the max trace is updated whenever a new max latency is detected. (not
stricly true: if one CPU is already saving a trace and this CPU detects
a new latency too then this CPU skips the trace, instead of spinning
waiting for the other CPU. This makes the tracing code more atomic, but
it opens up a window to 'lose' a latency - but statistically every
_type_ of latency should be saved sooner or later, since the 'dropping'
of traces is random, not systematic.)

the output trace is atomically filled in from the max trace, whenever
userspace accesses offset 0 of /proc/latency_trace. It will stay the
same until userspace finishes reading /proc/latency_trace (arrives to
the maximum offset of the file). Hence userspace can take all time it
wants to save a trace, it will stay the same. At least this is the
theory.

	Ingo
