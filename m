Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbULJVZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbULJVZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULJVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:25:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55002 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261212AbULJVZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:25:17 -0500
Date: Fri, 10 Dec 2004 22:24:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
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
Message-ID: <20041210212451.GF5864@elte.hu>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> [...] I also had several cases where I "triggered" a trace but no
> output - I assume those are related symptoms. For example:
> 
> # ./cpu_delay 0.000100
> Delay limit set to 0.00010000 seconds
> calibrating loop ....
> time diff= 0.504598 or 396354830 loops/sec.
> Trace activated with 0.000100 second delay.
> Trace triggered with 0.000102 second delay. [not recorded]
> Trace activated with 0.000100 second delay.
> Trace triggered with 0.000164 second delay. [not recorded]

is the userspace delay measurement nested inside the kernel-based
method? I.e. is it something like:

	gettimeofday(0,1);
	timestamp1 = cycles();

	... loop some ...

	timestamp2 = cycles();
	gettimeofday(0,0);

and do you get 'unreported' latencies in such a case too? If yes then
that would indeed indicate a tracer bug. But if the measurement is done
like this:

	gettimeofday(0,1);
	timestamp1 = cycles();

	... loop some ...

	gettimeofday(0,0);		// [1]
	timestamp2 = cycles();		// [2]

then a delay could get inbetween [1] and [2].

OTOH if the 'loop some' time is long enough then the [1]-[2] window is
too small to be significant statistically, while your logs show a near
50% 'miss rate'.

	Ingo
