Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314527AbSDTEgH>; Sat, 20 Apr 2002 00:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314556AbSDTEgG>; Sat, 20 Apr 2002 00:36:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60685 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314527AbSDTEgG>; Sat, 20 Apr 2002 00:36:06 -0400
Date: Fri, 19 Apr 2002 21:35:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <ak@suse.de>, <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420062149.G1291@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204192129130.3110-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
>
> I don't think it's good enough for merging yet. If you really want to do
> the fxrestor, you should at least do the init_fpu only once during
> bootup.

No, it needs to be done once per process FP state init, ie "flush_thread".

Think about it - we do _not_ copy the FP registers over an execve().

> The fxrestor is probably just overkill, but the memset + the
> initializations is completly superflous in a fast path,

That's no fast path, that's a "this process has never used the FPU before,
so we'd better make sure that it starts off with a really clean slate".

There is not just "one" FP state per kernel - there is one per process.
There _has_ to be.

> I still think the xor will be faster, no dcache pollution at all and
> less I/O to ram. Future features can require change to the "empty FPU"
> state anyways.

But the point is that people may still use a 2.4.x kernel on a P4-SSE3,
which only adds a few new instructions, and which re-uses the old SSE2
save area.

No kernel support necessary - it's transparent to the kernel, which won't
ever even know that some new fields in the save area are now used.

That was the whole point of MMX - it worked without any new OS support.
Intel learnt somewhat from past mistakes and made the save area bigger
than necessary, so that they can add new extensions without needing to
upgrade the OS yet another time.

THAT is the reason we can't just zero the SSE registers - because if we
do, we'll have the same problem next time around.

		Linus

