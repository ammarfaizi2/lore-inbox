Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbULAPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbULAPmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbULAPmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:42:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48558 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261283AbULAPl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:41:26 -0500
Date: Wed, 1 Dec 2004 16:40:47 +0100
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
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041201154046.GA15244@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu> <48590.195.245.190.94.1101810584.squirrel@195.245.190.94> <20041130131956.GA23451@elte.hu> <17532.195.245.190.94.1101829198.squirrel@195.245.190.94> <20041201103251.GA18838@elte.hu> <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
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


ok, got the latest traces from Rui offlist.

here's a summary of an xrun that went like this:

   jackd-4711  00000000 0.002ms (+0.000ms): do_poll (sys_poll)
   ...
   jackd-4711  80000002 0.012ms (+0.000ms): dequeue_task (deactivate_task)
   ...
   IRQ 5-3052  ........ 1.946ms (+0.000ms): ->    jackd-4711
                     [ 00000027 00000001 ]: try_to_wake_up
   ...
qjackctl-4719  ........ 2.362ms (+0.000ms): common_interrupt:
                     [ b75e9090 00000005 00000000 ]
   ...
   IRQ 5-3052  00000000 2.473ms (+0.000ms): xrun (snd_pcm_period_elapsed)
   ...

this shows an interesting phenomenon: for whatever reason IRQ5's thread
didnt run until timestamp 1.946ms. There is lots of idle time between
timestamps 0.012ms and 1.946ms, so this must be some weird condition. 

Rui, could you activate trace_freerunning and send me a couple of 'big'
traces that result out of it? Apparently there is some other, earlier
activity that caused this to happen to IRQ5. Nothing seems to have woken
up IRQ5 when it ran, which is weird by itself too.

if IRQ thread 5 got delayed somehow that might explain the xrun: the
hardware interrupt had no chance to run. But how IRQ5 could stay on the
runqueue while the idle thread managed to run is strange.

	Ingo
