Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVA1P2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVA1P2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVA1P2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:28:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50922 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261442AbVA1P2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:28:52 -0500
Date: Fri, 28 Jan 2005 16:28:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
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
Message-ID: <20050128152802.GA15508@elte.hu>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk> <20050128073856.GA2186@elte.hu> <20050128115640.GP10843@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128115640.GP10843@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> On Fri, Jan 28, 2005 at 08:38:56AM +0100, Ingo Molnar wrote:
> > no, it's not a big scalability problem. rwlocks are really a mistake -
> > if you want scalability and spinlocks/semaphores are not enough then one
> > should either use per-CPU locks or lockless structures. rwlocks/rwsems
> > will very unlikely help much.
> 
> I wouldn't be so sure about that. SGI is already implicitly relying on
> the parallel holding of rwsems for the lockless pagefaulting, and
> Oracle has been pushing on mapping->tree_lock becoming an rwlock for a
> while, both for large performance gains.

i dont really buy it. Any rwlock-type of locking causes global cacheline
bounces. It can make a positive scalability difference only if the
read-lock hold time is large, at which point RCU could likely have
significantly higher performance. There _may_ be an intermediate locking
pattern that is both long-held but has a higher mix of write-locking
where rwlocks/rwsems may have a performance advantage over RCU or
spinlocks.

Also this is about PREEMPT_RT, mainly aimed towards embedded systems,
and at most aimed towards small (dual-CPU) SMP systems, not the really
big systems.

But, the main argument wrt. PREEMPT_RT stands and is independent of any
scalability properties: rwlocks/rwsems have so bad deterministic
behavior that they are almost impossible to implement in a sane way.

	Ingo
