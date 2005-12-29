Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVL2HdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVL2HdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 02:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVL2HdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 02:33:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14538 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932568AbVL2HdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 02:33:22 -0500
Date: Thu, 29 Dec 2005 08:32:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229073259.GA20177@elte.hu>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228201150.b6cfca14.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > I think gcc should arguably not be forced to inline things when doing 
> > -Os, and it's also expected to mess up much less than when optimizing 
> > for speed. So maybe forced inlining should be dependent on 
> > !CONFIG_CC_OPTIMIZE_FOR_SIZE?
> 
> When it comes to inlining I just don't trust gcc as far as I can spit 
> it.  We're putting the kernel at the mercy of future random brainfarts 
> and bugs from the gcc guys.  It would be better and safer IMO to 
> continue to force `inline' to have strict and sane semamtics, and to 
> simply be vigilant about our use of it.

i think there's quite an attitude here - we are at the mercy of "gcc 
brainfarts" anyway, and users are at the mercy of "kernel brainfarts" 
just as much. Should users disable swapping and trash-talk it just 
because the Linux kernel used to have a poor VM? (And the gcc folks are 
certainly listening - it's not like they were unwilling to fix stuff, 
they simply had their own decade-old technological legacies that made 
certain seemingly random problems much harder to attack. E.g. -Os has 
recently been improved quite significantly in to-be-gcc-4.2.)

at least let us allow gcc do it in the CONFIG_CC_OPTIMIZE_FOR_SIZE case, 
-Os means "optimize for space" - no ifs and when, it's a _very_ clear 
and definite goal. I dont think there's much space for gcc to mess up 
there, it's a mostly binary decision: either the inlining of a 
particular function saves space, or not.

in the other case, when optimizing for speed, the decisions are alot 
less clear, and gcc has arguably alot more leeway to mess up.

also, there's a fundamental conflict of 'speed vs. performance' here, 
for a certain boundary region. For the extremes, very small and very 
large functions, the decision is clear, but if e.g. a CPU has tons of 
cache, it might prefer more agressive inlining than if it doesnt. So 
it's not like we can do it in a fully static manner.

> If no-forced-inlining makes the kernel smaller then we probably have 
> (yet more) incorrect inlining. We should hunt those down and fix them.  
> We did quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a 
> script which would identify which functions are a candidate for 
> uninlining?

this is going to be a never ending battle, and it's not about peanuts 
either: we are talking about 5% of .text space here, on a .config that 
carries most of the important subsystems and drivers. Do we really want 
to take on this battle and fight it for 30,000+ kernel functions - when 
gcc today can arguably do a _better_ job than what we attempted to do 
manually for years? We went to great trouble going to BK just to make 
development easier - shouldnt we let a fully open-source tool like gcc 
make our lives easier and not worry about details like that? Whether to 
inline or not _is_ a mostly thoughtless work with almost zero intellect 
in it. I'd rather trust gcc do it than some script doing the same much 
worse.

	Ingo
