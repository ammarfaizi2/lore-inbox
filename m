Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314560AbSDTFF4>; Sat, 20 Apr 2002 01:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314561AbSDTFF4>; Sat, 20 Apr 2002 01:05:56 -0400
Received: from [195.223.140.120] ([195.223.140.120]:41488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314560AbSDTFFz>; Sat, 20 Apr 2002 01:05:55 -0400
Date: Sat, 20 Apr 2002 07:07:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020420070713.H1291@dualathlon.random>
In-Reply-To: <20020420062149.G1291@dualathlon.random> <Pine.LNX.4.44.0204192129130.3110-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 09:35:45PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> >
> > I don't think it's good enough for merging yet. If you really want to do
> > the fxrestor, you should at least do the init_fpu only once during
> > bootup.
> 
> No, it needs to be done once per process FP state init, ie "flush_thread".

Note that with init_fpu I meant the init_fpu written in the patch. All
you need is a:

	fxrstor "default fpu state"

You don't need to memset(0) and init your own stack to create the
"default fpu state" at every "flush_thread". You only need to execute an
fxrestor over a piece of ram initialized only once during boot, never
initialized ala init_fpu in the fast path.

> 
> Think about it - we do _not_ copy the FP registers over an execve().
> 
> > The fxrestor is probably just overkill, but the memset + the
> > initializations is completly superflous in a fast path,
> 
> That's no fast path, that's a "this process has never used the FPU before,
> so we'd better make sure that it starts off with a really clean slate".

it's executed by every single task using the fpu, I do use python or bc
to do a simple math from bash and exit, that's a fast path for me, the
math exception should return ASAP, doing a superflous memset in the math
exception over an array looks bad to me.

> There is not just "one" FP state per kernel - there is one per process.
> There _has_ to be.

There is only "one" FP _empty_ state per kernel. That's the only thing
you need to resolve the math exception, no need to replicate it.  Then
you set used_math and PF_USEDFPU and the rest of the matchanism will take
care of using the per-process backing store to save/restore it. No need
to memset to create the "empty FPU" state at every exception over and over again.

> 
> > I still think the xor will be faster, no dcache pollution at all and
> > less I/O to ram. Future features can require change to the "empty FPU"
> > state anyways.
> 
> But the point is that people may still use a 2.4.x kernel on a P4-SSE3,
> which only adds a few new instructions, and which re-uses the old SSE2
> save area.

If there's no new xmm and new control register that's fine. If there's
new control register the 2.4.x kernel will need modifications anyways.

Just adding new instructions is just fine, like between sse and sse2.

I think the only argument for that is that it will potentially clear the
xmm8-15 registers too, if they will be added to an x86 (they're just in
x86-64). The control part doesn't make much sense to be because it will
likely not be zero anyways.

> THAT is the reason we can't just zero the SSE registers - because if we
> do, we'll have the same problem next time around.

You are zeroing the SSE registers with the fxrestor way too. If a new
control register is added zero won't be guaranteed to be the right
initialization for it, most control registers aren't set to 0 by
default.

Unless they provide some future plan so that we can design the OS now to
support new feature it's pointless to spend cycles to try to be
backwards compatible with future cpus. Zeroing registers will be fine if
they add new instructions, everything else won't be backwards compatible
by definition because it wasn't documented that you had to do a certain
think to be backwards compatible.

Andrea
