Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbUKJOdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUKJOdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUKJOdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:33:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12515 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261964AbUKJOcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:32:12 -0500
Date: Wed, 10 Nov 2004 16:33:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041110153300.GB9875@elte.hu>
References: <20041021132717.GA29153@elte.hu> <200411101452.36007.annabellesgarden@yahoo.de> <20041110150136.GA8668@elte.hu> <200411101520.43192.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411101520.43192.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Yes, it always happens, when callling ./cvscompile script of a
> project, that is mounted via nfs. Haven't tried to do that
> ./cvscompile locally, should I?

very interesting, nfs is indeed one of the frequent BKL users.

a 'BKL leak' is an unbalanced lock, e.g.:

	lock_kernel();
	... do stuff ...
	if (error)
		return;
	... do more stuff ...
	unlock_kernel();

the BKL is a very special type of lock which fact has the side-effect
that in the stock kernel a 'BKL leak' can go unnoticed very easily: it
causes no problems other than hard-to-debug (but severe) scalability
regressions. The moment the BKL count leaked from the NFS code that
process has been 'scalability-poisoned' and will be handicapped until it
exits.

In the PREEMPT_RT patchset i added a strict locking checker to do_exit()
that found this apparent NFS bug. Unfortunately the deadlock detector
only reported a pretty common place where the BKL gets
dropped/reacquired frequently so we dont know where the NFS code has the
lock/unlock imbalance. Could you report this bug to the NFS maintainers
(along with the above and the previous analysis)?

	Ingo
