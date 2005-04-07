Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVDGHBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDGHBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDGHBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:01:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47493 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261710AbVDGHBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:01:09 -0400
Date: Thu, 7 Apr 2005 09:00:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 1/5] sched: remove degenerate domains
Message-ID: <20050407070037.GA26430@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <20050406054412.GA5853@elte.hu> <4253949A.3040707@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253949A.3040707@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> [...] Although I'd imagine it may be something distros may want. For 
> example, a generic x86-64 kernel for both AMD and Intel systems could 
> easily have SMT and NUMA turned on.

yes, that's true - in fact reducing the number of separate kernel 
packages is of utmost importance to all distributions. (I'm not sure we 
are there yet with CONFIG_NUMA, but small steps wont hurt.)

> I agree with the downside of exercising less code paths though.

if we make CONFIG_NUMA good enough on small boxes so that distributors 
can turn it on then in the long run the loss could be offset by the win 
the extra QA gives.

> >is there any case where we'd want to simplify the domain tree? One more 
> >domain level is just one (and very minor) aspect of CONFIG_NUMA - i'd 
> >not want to run a CONFIG_NUMA kernel on a non-NUMA box, even if the 
> >domain tree got optimized. Hm?
> 
> I guess there is the SMT issue too, and even booting an SMP kernel on 
> a UP system. Also small ia64 NUMA systems will probably have one 
> redundant NUMA level.

i think most factors of not running an SMP kernel on a UP box are not 
due scheduler overhead: the biggest cost is spinlock overhead. Someone 
should try a little prototype: use the 'alternate instructions' 
framework to patch out calls to spinlock functions to NOPs, and 
benchmark the resulting kernel against UP. If it's "good enough", 
distros will use it. Having just a single binary kernel RPM that 
supports everything from NUMA through SMP to UP is the holy grail of 
distros. (especially the ones that offer commercial support and 
services.)

this is probably not possible on x86 - e.g. it would probably be 
expensive (in terms of runtime cost) to make the PAE/non-PAE decision 
runtime (the distro boot kernel needs to be non-PAE). But for newer 
arches like x64 it should be easier.

> If/when topologies get more complex (for example, the recent Altix 
> discussions we had with Paul), it will be generally easier to set up 
> all levels in a generic way, then weed them out using something like 
> this, rather than put the logic in the domain setup code.

ok. That should also make it easier to put more of the arch domain setup 
code into sched.c. E.g. i'm still uneasy about it having so much 
scheduler code in arch/ia64/kernel/domain.c, and all the ripple effects. 
(the #ifdefs, include file impact, etc.)

	Ingo
