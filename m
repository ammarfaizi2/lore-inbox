Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVA1T7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVA1T7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVA1Tz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:55:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7588 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262791AbVA1TqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:46:13 -0500
Date: Fri, 28 Jan 2005 20:45:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Esben Nielsen <simlo@phys.au.dk>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
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
Message-ID: <20050128194546.GA348@elte.hu>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk> <20050128073856.GA2186@elte.hu> <1106939910.14321.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106939910.14321.37.camel@lade.trondhjem.org>
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


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> If you do have a highest interrupt case that causes all activity to
> block, then rwsems may indeed fit the bill.
> 
> In the NFS client code we may use rwsems in order to protect stateful
> operations against the (very infrequently used) server reboot recovery
> code. The point is that when the server reboots, the server forces us
> to block *all* requests that involve adding new state (e.g. opening an
> NFSv4 file, or setting up a lock) while our client and others are
> re-establishing their existing state on the server.

it seems the most scalable solution for this would be a global flag plus
per-CPU spinlocks (or per-CPU mutexes) to make this totally scalable and
still support the requirements of this rare event. An rwsem really
bounces around on SMP, and it seems very unnecessary in the case you
described.

possibly this could be formalised as an rwlock/rwlock implementation
that scales better. brlocks were such an attempt.

> IOW: If you are planning on converting rwsems into a semaphore, you
> will screw us over most royally, by converting the currently highly
> infrequent scenario of a single task being able to access the server
> into the common case.

nono, i have no such plans.

	Ingo
