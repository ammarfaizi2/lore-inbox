Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280994AbRKCUYF>; Sat, 3 Nov 2001 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281031AbRKCUX4>; Sat, 3 Nov 2001 15:23:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56325 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280994AbRKCUXp>; Sat, 3 Nov 2001 15:23:45 -0500
Date: Sat, 3 Nov 2001 12:20:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Juergen Doelle <jdoelle@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Pls apply this spinlock patch to the kernel
In-Reply-To: <20011103115556.A5984@twiddle.net>
Message-ID: <Pine.LNX.4.33.0111031215490.2026-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Nov 2001, Richard Henderson wrote:
>
> The "cache_line_pad" is useless.  The __attribute__((aligned(N)))
> is completely sufficient.

I think you missed the important part: there must be no false sharing with
ANYTHING ELSE.

If you have a 4-byte entry that is aligned to 128 bytes, you have 124
bytes of stuff that the linker _will_ fill up with other things.

And if you don't want false sharing, that MUST NOT HAPPEN.

Try it. You'll see.

> Separate sections are also not needed.  While you can't guarantee
> adjacency, the object file *does* record the required alignment
> and that must be honored by the linker.

It's not just alignment: it wants an exclusive cacheline. Thus the
padding.

And I'm claiming, based on past experiences with the linker, that the
padding won't guarantee anything, because the linker can re-order things
to "pack" them tighter. So the padding either has to be inside a structure
or a union (which implies a new type, and thus that the users care about
whether the spinlock is padded or not), or it needs a separate section, so
that it doesn't _matter_ if the linker re-orders anything, because
everything in that section is aligned, and as such you cannot get false
sharing even with reordering.

		Linus

