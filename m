Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUKPVmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUKPVmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUKPVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:42:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12506 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261839AbUKPVlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:41:35 -0500
Date: Tue, 16 Nov 2004 23:42:57 +0100
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
Message-ID: <20041116224257.GB27550@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <20041116184315.GA5492@elte.hu> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu> <20041116222039.662f41ac@mango.fruits.de> <20041116223243.43feddf4@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116223243.43feddf4@mango.fruits.de>
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

> It seems this excerpt from below trace is characteristic for all the long
> traces:
> 
>    5 80000002 0.001ms (+1.114ms): __do_softirq (do_softirq)
>    5 00000000 1.115ms (+0.000ms): preempt_schedule (_mmx_memcpy)

i've seen this before, it's still unsolved. This trace shows it nicely:

>     5 80010002 0.000ms (+0.000ms): wake_up_process (redirect_hardirq)
>     5 80010001 0.000ms (+0.000ms): preempt_schedule (__do_IRQ)
>     5 80010001 0.000ms (+0.000ms): irq_exit (do_IRQ)
>     5 80000002 0.000ms (+0.000ms): do_softirq (irq_exit)
>     5 80000002 0.001ms (+1.114ms): __do_softirq (do_softirq)
>     5 00000000 1.115ms (+0.000ms): preempt_schedule (_mmx_memcpy)
>     5 90000000 1.115ms (+0.000ms): __schedule (preempt_schedule)
>     5 90000000 1.115ms (+0.000ms): profile_hit (__schedule)

this is either a false positive, or we missed a preemption. To see which
one, could you apply the attached patch and try to reproduce this long
trace? The new trace will tell us whether need_resched is set during
that ~1 msec window.

	Ingo

--- linux/kernel/latency.c.orig
+++ linux/kernel/latency.c
@@ -184,6 +184,7 @@ ____trace(struct cpu_trace *tr, unsigned
 		 * Encode irqs-off into the preempt count:
 		 */
 			 + (irqs_disabled() ? 0x80000000 : 0)
+			 + (need_resched() ?  0x08000000 : 0)
 #endif
 				;
 	}
