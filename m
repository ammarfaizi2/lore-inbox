Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLaR6U>; Sun, 31 Dec 2000 12:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130306AbQLaR6K>; Sun, 31 Dec 2000 12:58:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129911AbQLaR6B>; Sun, 31 Dec 2000 12:58:01 -0500
Date: Sun, 31 Dec 2000 09:27:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Andi Kleen wrote:
> 
> Sounds good. It could also be controlled by a CONFIG_SPACE_EFFICIENT for
> embedded systems, where you could trade a bit of CPU for less memory overhead 
> even on systems where u8 is slow and atomicity doesn't come into play
> because it's UP anyways. 

UP has nothing to do with it.

The alpha systems I remember this problem on were all SMP.

Imagine an architecture where you need to do a

	load_32()
	mask-and-insert-byte
	store_32()

and imagine that an interrupt comes in:

	load_32()
	mask-and-insert-byte

			* INTERRUPT *

			load_32()
			mask-and-insert-ANOTHER-byte
			store_32()

			interrupt return

	store_32()

and notice how the value written by the interrupt is gone, gone, gone,
even though it was to a completely different byte.

Now, imagine that the first byte is the "age", and imagine that the thing
the interrupt tries to update is "flags".

Yes, you're screwed.

I don't think it's a good diea.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
