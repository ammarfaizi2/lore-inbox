Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935057AbWKXUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935057AbWKXUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935060AbWKXUs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:48:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20187 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935057AbWKXUs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:48:26 -0500
Date: Fri, 24 Nov 2006 21:46:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
Message-ID: <20061124204636.GA12196@elte.hu>
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de> <20061124202514.GA7608@elte.hu> <200611242137.39012.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611242137.39012.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> 
> > yeah - the main new bit for x86-64 is the unconditional check for time 
> > warps. We shouldnt (and cannot) really trust the CPU and the board/BIOS 
> > getting it right. There were always some motherboards using Intel CPUs 
> > that had the TSCs wrong.
> 
> In the 64bit capable generation I don't know of any run in spec 
> (except for multinode systems and there was one overclocked system 
> where the cores got unsync, but overclocking is an operator error)

i have one (Intel based), 64-bit, fully in spec, which is off by 
~3000-4000 cycles. So it happens. But it's a no-brainer thing, this area 
is historically so bad that it would be crazy /not/ to spend this 20 
msecs bootup time per CPU to check whether its TSC is in sync.

I was in fact surprised when i noticed that you removed the 
unconditional TSC check that i put there years ago - with this we 
started a ride into the dark with lights off. If the situation gets 
better in say 2 years and no system ever produces the warning message we 
can remove it. (but i doubt it will ever get 100% correct.) [The patch 
will need some cooking in -mm, because it touches code that is fragile 
to begin with, but it's a necessity i'm quite sure.]

> > > The trouble is that people are using the RDTSC anyways even if the 
> > > kernel doesn't. So some synchronization is probably a good idea.
> > 
> > which apps are using it? It might be safer in terms of app 
> > compatibility if we removed the TSC bit in the case where we know it 
> > doesnt work, and if we turned the feature off in the CPU in this 
> > case. We could also try to 'approximately' sync up the TSC,
> 
> There was a patch from google for trap -- trapping RDTSC for syncing 
> on demand. I'm not sure that was the right strategy though.

but which apps are using RDTSC natively? Trapping isnt too good i agree 
- if then we should remove it from the CPU features and hence apps wont 
(or shouldnt) use it.

> > nor can the TSC really be synced up properly in the hotplug CPU 
> > case, after the fact - what if the app already read out an older TSC 
> > value and a new CPU is added. If the TSC isnt sync on SMP then it 
> > quickly gets pretty messy, and we should rather take a look at /why/ 
> > these apps are using RDTSC.
> 
> Because gettimeofday is too slow.

as i indicated it in another discussion, i can fix that. Next patch will 
be that.

	Ingo
