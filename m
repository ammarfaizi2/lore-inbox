Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbUKROon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUKROon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUKROon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:44:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48618 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262104AbUKROoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:44:39 -0500
Date: Thu, 18 Nov 2004 16:44:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <adam@doogie.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-10
Message-ID: <20041118154442.GA12483@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <Pine.LNX.4.58.0411171214220.11137@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411171214220.11137@gradall.private.brainfood.com>
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


* Adam Heath <adam@doogie.org> wrote:

> Running .26-5.  Been running almost 2 days.  All small latency values. 
> Then, just a few minutes ago, got a 133us value:

this entry has most of the overhead:

>     0 80000000 00000004 [0284618592175975] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (__do_IRQ+0x13d/0x170 <c013f3cd>)
>     0 80000000 00000005 [0284618592176118] 0.000ms (+0.127ms): irq_exit+0xb/0x50 <c013f10b> (do_IRQ+0x53/0x70 <c01080d3>)
>     0 80000000 00000006 [0284618592387634] 0.127ms (+0.000ms): do_IRQ+0x0/0x70 <c0108080> (<0000a253>)
>     0 80000000 00000007 [0284618592387690] 0.127ms (+0.000ms): do_IRQ+0x0/0x70 <c0108080> (<0000000e>)

this shows that we interrupted some longer critical section - in this
case it seems to be BIOS/APM code.

> Note the jump in irq_exit/do_IRQ.

that jump is a delayed interrupt hitting the BIOS on its way out of APM
idle mode it seems:

>     0 80000000 0000001b [0284618592393899] 0.131ms (+0.000ms): apm_do_busy+0xb/0x40 <c01111eb> (cpu_idle+0x4c/0x70 <c0103f9c>)
>     0 80000000 0000001c [0284618592393987] 0.131ms (+0.000ms): apm_bios_call_simple+0xe/0xf0 <c0110f2e> (apm_do_busy+0x2e/0x40 <c011120e>)

There's nothing to be done about that, except to disable APM. Perhaps
you could try ACPI, maybe that doesnt have such latencies in the BIOS.

	Ingo
