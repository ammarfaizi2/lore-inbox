Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVA1P7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVA1P7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVA1P7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:59:44 -0500
Received: from holomorphy.com ([66.93.40.71]:37357 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261372AbVA1P7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:59:37 -0500
Date: Fri, 28 Jan 2005 07:55:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
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
Message-ID: <20050128155549.GR10843@holomorphy.com>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk> <20050128073856.GA2186@elte.hu> <20050128115640.GP10843@holomorphy.com> <20050128152802.GA15508@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128152802.GA15508@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> I wouldn't be so sure about that. SGI is already implicitly relying on
>> the parallel holding of rwsems for the lockless pagefaulting, and
>> Oracle has been pushing on mapping->tree_lock becoming an rwlock for a
>> while, both for large performance gains.

On Fri, Jan 28, 2005 at 04:28:02PM +0100, Ingo Molnar wrote:
> i dont really buy it. Any rwlock-type of locking causes global cacheline
> bounces. It can make a positive scalability difference only if the
> read-lock hold time is large, at which point RCU could likely have
> significantly higher performance. There _may_ be an intermediate locking
> pattern that is both long-held but has a higher mix of write-locking
> where rwlocks/rwsems may have a performance advantage over RCU or
> spinlocks.

The performance relative to mutual exclusion is quantifiable and very
reproducible. These results have people using arguments similar to what
you made above baffled. Systems as small as 4 logical cpus feel these
effects strongly, and it appears to scale almost linearly with the
number of cpus. It may be worth consulting an x86 processor architect
or similar to get an idea of why the counterargument fails. I'm rather
interested in hearing why as well, as I believed the cacheline bounce
argument until presented with incontrovertible evidence to the contrary.

As far as performance relative to RCU goes, I suspect cases where
write-side latency is important will arise for these. Other lockless
methods are probably more appropriate, and are more likely to dominate
rwlocks as expected. For instance, a reimplementation of the radix
trees for lockless insertion and traversal (c.f. lockless pagetable
patches for examples of how that's carried out) is plausible, where RCU
memory overhead in struct page is not.


On Fri, Jan 28, 2005 at 04:28:02PM +0100, Ingo Molnar wrote:
> Also this is about PREEMPT_RT, mainly aimed towards embedded systems,
> and at most aimed towards small (dual-CPU) SMP systems, not the really
> big systems.
> But, the main argument wrt. PREEMPT_RT stands and is independent of any
> scalability properties: rwlocks/rwsems have so bad deterministic
> behavior that they are almost impossible to implement in a sane way.

I suppose if it's not headed toward mainline the counterexamples don't
really matter. I don't have much to say about the RT-related issues,
though I'm aware of priority inheritance's infeasibility for the
rwlock/rwsem case.


-- wli
