Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbULIR30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbULIR30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULIR30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:29:26 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50315 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261551AbULIR3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:29:08 -0500
Date: Thu, 9 Dec 2004 18:28:48 +0100
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
Message-ID: <20041209172848.GD7975@elte.hu>
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

> >But you do have set your reference irq (soundcard) to the highest prio
> >in the PREEMPT_RT case? I just ask to make sure.
>
> Yes, but then I have ALL the IRQ's at the highest priority (plus a couple
> other /0 and /1 tasks). [...]

that is the fundamental problem i believe: your 'CPU loop' gets delayed
by them.

> [...] Please note, I only use latencytest (an audio application) to
> get an idea of RT performance on a desktop machine before I consider
> using the kernel for my real application.

but you never want your real application be delayed by things like IDE
processing or networking workloads, correct? The only thing that should
have higher priority than your application is the event thread that
handles the hardware from which you get events. I.e. the soundcard IRQ
in your case (plus the timer IRQ thread, because your task is also
timing out).

i'm not sure what the primary event source for your application is, but
i bet it's not the IDE irq thread, nor the network IRQ thread.

so you are seeing the _inverse_ of advances in the -RT kernel: it's
getting better and better at preempting your prio 30 CPU loop with the
higher-prio RT tasks. I.e. the lower-prio CPU loop gets worse and worse
latencies.

	Ingo
