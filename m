Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVA1Hjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVA1Hjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 02:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVA1Hjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 02:39:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36249 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261280AbVA1Hj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 02:39:27 -0500
Date: Fri, 28 Jan 2005 08:38:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Message-ID: <20050128073856.GA2186@elte.hu>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I noticed that you changed rw-locks to behave quite diferently under
> real-time preemption: They basicly works like normal locks now. I.e.
> there can only be one reader task within each region. This can can
> however lock the region recursively. [...]

correct.

> [...] I wanted to start looking at fixing that because it ought to
> hurt scalability quite a bit - and even on UP create a few unneeded
> task-switchs. [...]

no, it's not a big scalability problem. rwlocks are really a mistake -
if you want scalability and spinlocks/semaphores are not enough then one
should either use per-CPU locks or lockless structures. rwlocks/rwsems
will very unlikely help much.

> However, the more I think about it the bigger the problem:

yes, that complexity to get it perform in a deterministic manner is why
i introduced this (major!) simplification of locking. It turns out that
most of the time the actual use of rwlocks matches this simplified
'owner-recursive exclusive lock' semantics, so we are lucky.

look at what kind of worst-case scenarios there may already be with
multiple spinlocks (blocker.c). With rwlocks that just gets insane.

	Ingo
