Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314650AbSDTQ2H>; Sat, 20 Apr 2002 12:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314651AbSDTQ2G>; Sat, 20 Apr 2002 12:28:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26639 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314650AbSDTQ2B>; Sat, 20 Apr 2002 12:28:01 -0400
Date: Sat, 20 Apr 2002 09:27:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <ak@suse.de>, <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420070713.H1291@dualathlon.random>
Message-ID: <Pine.LNX.4.33.0204200919080.11450-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> 
> Note that with init_fpu I meant the init_fpu written in the patch. All
> you need is a:
> 
> 	fxrstor "default fpu state"

Ok, that I agree with.

> > That's no fast path, that's a "this process has never used the FPU before,
> > so we'd better make sure that it starts off with a really clean slate".
> 
> it's executed by every single task using the fpu

Yes. _Once_ in their lifetimes.

> > But the point is that people may still use a 2.4.x kernel on a P4-SSE3,
> > which only adds a few new instructions, and which re-uses the old SSE2
> > save area.
> 
> If there's no new xmm and new control register that's fine. If there's
> new control register the 2.4.x kernel will need modifications anyways.
> 
> Just adding new instructions is just fine, like between sse and sse2.

If Intel makes the SSE3 registers twice as wide (or creates new ones), the 
xorps trick simply will not work.

> I think the only argument for that is that it will potentially clear the
> xmm8-15 registers too, if they will be added to an x86 (they're just in
> x86-64). The control part doesn't make much sense to be because it will
> likely not be zero anyways.

Actually, even control parts likely _will_ be be zero, the way people 
work.

> > THAT is the reason we can't just zero the SSE registers - because if we
> > do, we'll have the same problem next time around.
> 
> You are zeroing the SSE registers with the fxrestor way too.


Andrea, that's the whole _point_.

>							 If a new
> control register is added zero won't be guaranteed to be the right
> initialization for it, most control registers aren't set to 0 by
> default.

Even then, having a reliable failure that is easy to pinpoint it a lot 
better than random behaviour that has taken us more than two years to even 
_find_.

Besides, zeroes for initial values of control registers actually _is_ 
fairly likely, in my opinion. I've sent off an email to my Intel contacts 
to try to make this architected..

		Linus

