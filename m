Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbUKPWOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUKPWOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUKPWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:13:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17536 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261859AbUKPWKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:10:49 -0500
Date: Wed, 17 Nov 2004 00:11:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116231145.GC31529@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <20041116184315.GA5492@elte.hu> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu> <20041116222039.662f41ac@mango.fruits.de> <20041116223243.43feddf4@mango.fruits.de> <20041116224257.GB27550@elte.hu> <20041116230443.452497b9@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116230443.452497b9@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> hmm, the output doens't look so much different (or am i just blind?).
> maybe i need to do make clean before building with this patch applied?

the trace is fine, note the extra 0x08000000:

>     5 88010003 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
>     5 88010003 0.000ms (+0.000ms): (0) ((1))
>     5 88010002 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
>     5 88010002 0.000ms (+0.000ms): wake_up_process (redirect_hardirq)
         ^--- this one
>     5 88010001 0.000ms (+0.000ms): preempt_schedule (__do_IRQ)
>     5 88010001 0.000ms (+0.000ms): irq_exit (do_IRQ)
>     5 88000002 0.000ms (+0.000ms): do_softirq (irq_exit)
>     5 88000002 0.001ms (+0.990ms): __do_softirq (do_softirq)
>     5 08000000 0.991ms (+0.000ms): preempt_schedule (_mmx_memcpy)
>     5 98000000 0.991ms (+0.000ms): __schedule (preempt_schedule)

it was zero before - indeed hard to notice optically :-|

found the reason for this latency meanwhile: it's kernel_fpu_begin() and
kernel_fpu_end() disabling/enabling preemption. (these are used by the
mmx memcpy's)

i've uploaded the -11 patch with a preliminary fix:

    http://redhat.com/~mingo/realtime-preempt/

which turns off the FPU-based ops if PREEMPT_RT is specified. The speed
difference should be small but the latency difference is large ...

could you try -11, do you still see these large latencies?

	Ingo
