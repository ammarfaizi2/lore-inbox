Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbULAWJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbULAWJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbULAWJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:09:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18921 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261367AbULAWJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:09:29 -0500
Date: Wed, 1 Dec 2004 23:09:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041201220916.GA24992@elte.hu>
References: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94> <20041201103251.GA18838@elte.hu> <32831.192.168.1.5.1101905229.squirrel@192.168.1.5> <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu> <20041201162034.GA8098@elte.hu> <33059.192.168.1.5.1101927565.squirrel@192.168.1.5> <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu> <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Here goes attached the captured latency traces for you to check. I
> guess this time xmms-jack its at stake 'coz it was the cherry on top
> of the cake, for three times in a row :)

the latency does seem to be related to clients, as in the following
trace:

  xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041201202926.trc

jackd-16714 goes into sys_poll() at timestamp 0.850ms, and does a pipe
related wait:

   jackd-16714 00000000 0.853ms (+0.000ms): pipe_poll (do_pollfd)

and goes to sleep:

   jackd-16714 00000000 0.857ms (+0.000ms): schedule_timeout (do_poll)

almost 3 milliseconds later, at timestamp 3.404ms, the pipe related
timer expires and jackd gets scheduled again:

ksoftirq-3     00000000 3.403ms (+0.000ms): wake_up_process (run_timer_softirq)
ksoftirq-3     ........ 3.404ms (+0.000ms): ->    jackd-16714
                     [ 00000027 00000003 ]: try_to_wake_up

obviously an xrun has happened during this 2.6 msec wait:

   IRQ 5-3078  00000000 2.277ms (+0.000ms): xrun (snd_pcm_period_elapsed)

but ... this brings up the question, is this a valid scenario? How can
jackd block on clients for so long? Perhaps this means that every audio
buffer has run empty and jackd desperately needed some new audio input,
which it didnt get from the clients, up until after the xrun? In theory
this should only be possible if there's CPU saturation (that's why i
asked about how much CPU% time there was in use).

One indication that this might have been the case is that in the full
3.5 msecs trace there's not a single cycle spent idle. But, lots of time
was spent by e.g. X or gkrellm-4356, which are not RT tasks - so from
the RT task POV i think there were cycles left to be utilized. Could
this be a client bug? That seems a bit unlikely because to let jackd
'run empty', each and every client would have to starve it, correct?

anyway, your plan to try jack_test3.1 again looks like the correct
approach: we first need to check the behavior of 'trivial clients',
before more complex scenarios with real clients can be considered.

	Ingo
