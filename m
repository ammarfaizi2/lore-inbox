Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbUK3NVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUK3NVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUK3NVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:21:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57773 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262070AbUK3NUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:20:53 -0500
Date: Tue, 30 Nov 2004 14:19:56 +0100
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
Message-ID: <20041130131956.GA23451@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu> <48590.195.245.190.94.1101810584.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48590.195.245.190.94.1101810584.squirrel@195.245.190.94>
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

>     xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-*.trc.gz
>         - the captured traces, as dumped with xruntrace1_watch.sh script.

> Each trace shows only the first XRUN occurrence on a distinct jackd
> session. Every other trace were triggered and captured after
> restarting jackd.

interesting - the trace shows only a latency of 20-40 usecs. Perhaps the
tracing should be done over two periods?

Could you try to hack alsa_driver.c to do the gettimeofday(1,1) call for
only every second case. Something like this ought to be enough:

	{
		static count = 0;

		if (!(count++ & 1))
			gettimeofday(0,1);
	}

(only one thread accesses this particular variable so there are no
threading issues.)

with this variant there's a 50% chance that we get the trace of the last
2 poll() instances. (and there's a 50% chance that we get only 1 period
covered.)

in any case, the scripts & approach seems to be almost there, i hope we
only need the above change to see the true source of the xruns.

	Ingo
