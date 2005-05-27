Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVE0NwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVE0NwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0NwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:52:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36541 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261489AbVE0Nvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:51:52 -0400
Date: Fri, 27 May 2005 15:50:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527135037.GB16158@elte.hu>
References: <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527133122.GF86087@muc.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> > what i meant is a pretty common-sense thing: the more independent the
> > locks are, the more shortlived locking is, the less latencies there are.
> 
> At least on SMP the most finegrained locking is not always the best; 
> you can end up with bouncing cache lines all the time, with two CPUs 
> synchronizing to each other all the time, which is just slow.

yeah, and i wasnt arguing for the most finegrained locking: cacheline 
bouncing hurts worst-case latencies just as much (in fact, more, being a 
worst-case) than it hurts scalability.

> it is sometimes better to batch things with less locks. And every lock 
> has a cost even when not taken, and they add up pretty quickly.

(the best is obviously to have no locking at all, unless there's true 
resource sharing.)

> > The reverse is true too: most of the latency-breakers move code out from
> > under locks - which obviously improves scalability too. So if you are 
> > working on scalability you'll indirectly improve latencies - and if you 
> > are working on reducing latencies, you often improve scalability.
> 
> But I agree that often less latency is good even for scalability.
> 
> 
> > > > but it's certainly not for free. Just like there's no zero-cost
> > > > virtualization, or there's no zero-cost nanokernel approach either,
> > > > there's no zero-cost single-kernel-image deterministic system either.
> > > > 
> > > > and the argument about binary kernels - that's a choice up to vendors
> > > 
> > > It is not only binary distribution kernels. I always use my own self
> > > compiled kernels, but I certainly would not want a special kernel just
> > > to do something normal that requires good latency (like sound use).
> > 
> > for good sound you'll at least need PREEMPT_VOLUNTARY. You'll need 
> > CONFIG_PREEMPT for certain workloads or pro-audio use.
> 
> AFAIK the kernel has quite regressed recently, but that was not true 
> (for reasonable sound) at least for some earlier 2.6 kernels and some 
> of the low latency patchkit 2.4 kernels.
> 
> So it is certainly possible to do it without preemption.

PREEMPT_VOLUNTARY does it without preemption. PREEMPT_VOLUNTARY is quite 
similar to most of the lowlatency patchkits, just simpler.

> > the impact of PREEMPT on the codebase has a positive effect as well: it 
> > forces us to document SMP data structure dependencies better. Under 
> > PREEMPT_NONE it would have been way too easy to get into the kind of 
> > undocumented interdependent data structure business that we so well know 
> > from the big kernel lock days. get_cpu()/put_cpu() precisely marks the 
> > critical section where we use a given per-CPU data structure.
> 
> Nah, there is still quite some code left that is unmarked, but ignores 
> this case for various reason (e.g. in low level exception handling 
> which is preempt off anyways). However you are right it might have 
> helped a bit for generic code. But it is still quite ugly...

there's a slow trend related to RCU: rcu_read_lock() is silent about 
what kind of implicit lock dependencies there are. So when we convert a 
spinlock-using piece of code to RCU we lose that information, making it 
harder to convert it to another type of locking later on. (But this is 
not a complaint against RCU, just a demonstration that we do lose 
information.)

	Ingo
