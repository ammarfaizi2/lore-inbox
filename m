Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280037AbRKSRCy>; Mon, 19 Nov 2001 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280051AbRKSRCo>; Mon, 19 Nov 2001 12:02:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32776 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280037AbRKSRCi>; Mon, 19 Nov 2001 12:02:38 -0500
Date: Mon, 19 Nov 2001 08:57:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Andrea Arcangeli <andrea@suse.de>, <ehrhardt@mathematik.uni-ulm.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1 
In-Reply-To: <588.1006159468@redhat.com>
Message-ID: <Pine.LNX.4.33.0111190839520.8103-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, David Woodhouse wrote:
>
> Is it worth making put_unaligned and get_unaligned on x86 avoid this by
> loading/storing the two halves of the required datum separately, then?

No, modern CPU's do it well enough - starting from the Pentium, Intel does
all locking internally in the caches, and depends on the cache coherency
protocol to show the atomicity to the rest of the world. Only an i486 will
actually show the locked cycles on the bus, if I remember correctly.

In fact, I think the CPU will do a unaligned non-cache-crossing operation
as fast as a aligned store. The cacheline-crossing case is noticeably
slower, at least on a PPro (the Pentium had some optimizations where it
would pair the two cacheline accesses, and could do two cacheline accesses
in one cycle - so the cacheline crosser could execute at full speed, but
it would hurt pairing with _other_ memory instructions).

Testing shows:
 - PPro core:
	single-cycle stores, whether aligned or not, within a
	cacheline.

	8 cycles for cacheline crossing stores

 - Athlon:
	single cycle for unaligned, whether cache-line croesser or not.

(And as mentioned, I think Pentiums act the same as athlons).

In short, unaligned integer ops are not affected very much at all. They do
take more resources internally (ie they use two write-ports to the cache
when cache-crossing), so even when they run at the "same" speed, it pairs
etc better if aligned, but x86 is very very good at unaligned handling.

One of the advantages of a legacy of crap: x86 never had the choice to be
designed for "the good case". In order to run fast, an x86 has to run fast
even on bad code.

Because in real life, it doesn't matter how well you do on spec benchmarks
with good compilers.

		Linus

