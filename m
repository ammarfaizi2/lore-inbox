Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933065AbWKXU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbWKXU1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935040AbWKXU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:27:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61605 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933065AbWKXU1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:27:11 -0500
Date: Fri, 24 Nov 2006 21:25:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
Message-ID: <20061124202514.GA7608@elte.hu>
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611241813.13205.ak@suse.de>
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

> > make the TSC synchronization code more robust, and unify it between 
> > x86_64 and i386.
> > 
> > The biggest change is the removal of the 'fix up TSCs' code on 
> > x86_64 and i386, in some rare cases it was /causing/ time-warps on 
> > SMP systems.
> 
> On x86-64 I don't think it can since it doesn't check anymore on sync 
> Intel.

yeah - the main new bit for x86-64 is the unconditional check for time 
warps. We shouldnt (and cannot) really trust the CPU and the board/BIOS 
getting it right. There were always some motherboards using Intel CPUs 
that had the TSCs wrong.

> > The new code only checks for TSC asynchronity - and if it can prove 
> > a time-warp (if it can observe the TSC going backwards when going 
> > from one CPU to another within a critical section), then the TSC 
> > clock-source is turned off.
> 
> The trouble is that people are using the RDTSC anyways even if the 
> kernel doesn't. So some synchronization is probably a good idea.

which apps are using it? It might be safer in terms of app compatibility 
if we removed the TSC bit in the case where we know it doesnt work, and 
if we turned the feature off in the CPU in this case. We could also try 
to 'approximately' sync up the TSC, but that obviously cannot be used 
for kernel timekeeping - and by offering an 'almost' good TSC to 
userspace we'd lure them towards using something we /cannot/ fix.

nor can the TSC really be synced up properly in the hotplug CPU case, 
after the fact - what if the app already read out an older TSC value and 
a new CPU is added. If the TSC isnt sync on SMP then it quickly gets 
pretty messy, and we should rather take a look at /why/ these apps are 
using RDTSC.

	Ingo
