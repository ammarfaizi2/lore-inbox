Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVL2Rl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVL2Rl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 12:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVL2Rl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 12:41:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750903AbVL2Rl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 12:41:26 -0500
Date: Thu, 29 Dec 2005 09:41:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <20051229073259.GA20177@elte.hu>
Message-ID: <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > When it comes to inlining I just don't trust gcc as far as I can spit 
> > it.  We're putting the kernel at the mercy of future random brainfarts 
> > and bugs from the gcc guys.  It would be better and safer IMO to 
> > continue to force `inline' to have strict and sane semamtics, and to 
> > simply be vigilant about our use of it.
> 
> i think there's quite an attitude here - we are at the mercy of "gcc 
> brainfarts" anyway, and users are at the mercy of "kernel brainfarts" 
> just as much.

There's a huge difference here. The gcc people very much have a "Oh, we 
changed old documented behaviour - live with it" attitude, together with 
"That was a gcc extension, not part of the C language, so when we change 
how gcc behaves, it's _your_ problem" approach.

At least they used to. 

So yes, there's a huge attitude difference. The gcc people have a BAD 
attitude. When the meaning of "inline" changed (from a "inline this" to 
"hey, it's a hint"), the gcc people never EVER said "sorry". They 
effectively said "screw you".

I know this is why I don't trust gcc wrt inlining. It's not so much about 
any technical issues, as about the fact that the kernel tends to be a lot 
heavier user of gcc features than most programs, and has correctness 
issues with them, AND THE GCC PEOPLE SIMPLY DON'T CARE.

Comparing it to the kernel is ludicrous. We care about user-space 
interfaces to an insane degree. We go to extreme lengths to maintain even 
badly designed or unintentional interfaces. Breaking user programs simply 
isn't acceptable. We're _not_ like the gcc developers. We know that 
people use old binaries for years and years, and that making a new 
release doesn't mean that you can just throw that out. You can trust us.

Maybe gcc development has changed. Maybe it hasn't.

THAT is what makes me worry. I don't know if this is why Andrew doesn't 
trust inlining, but I suspect it has similar roots. Not trusting it 
because we haven't been able to trust the people behind it. No heads-up, 
no warnings, no discussions. Just a "screw you, things changed, your 
usage doesn't matter, and we're not even interested in listening to you 
or telling you why things changed".

There have been situations where documented gcc semantics changed, and 
instead of saying "sorry", the gcc people changed the documentation. What 
the hell is the point of documented semantics if you can't depend on them 
anyway?

One thing we could do: I think modern gcc's at least have an option to 
warn when they don't inline something. It might make sense to just enable 
that warning, and see _which_ functions -Os and -funit-at-a-time say are 
too large to be inlined.

Maybe the right thing to do is to just heed that warning, and remove such 
functions from header files and make them no-inline? That way we get the 
size fixes _regardless_ of any compiler options.

				Linus
