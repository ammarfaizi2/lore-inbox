Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130416AbRCBLrP>; Fri, 2 Mar 2001 06:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRCBLrF>; Fri, 2 Mar 2001 06:47:05 -0500
Received: from colorfullife.com ([216.156.138.34]:24325 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130416AbRCBLqx>;
	Fri, 2 Mar 2001 06:46:53 -0500
From: Manfred Spraul <manfred@colorfullife.com>
To: Mark Hemment <markhe@veritas.com>
Subject: Re: Q: explicit alignment control for the slab allocator
Message-ID: <983533909.3a9f89554db32@colorfullife.com>
Date: Fri, 02 Mar 2001 06:51:49 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103021040100.11260-100000@alloc>
In-Reply-To: <Pine.LNX.4.21.0103021040100.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 134.96.7.93
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitiere Mark Hemment <markhe@veritas.com>:

> 
> 
> > In which cases an offset > alignment is really a win?
> 
>   You've got me. :)  I don't know.
>   In the Bonwick paper, such a facility was described, so I thought
> "hey,
> sounds like that might be useful".
>   Could be a win on archs with small L1 cache line sizes (16bytes on a
> 486) - but most modern processors have larger lines.

IIRC cache colouring was introduced for some sun hardware with 2 memory busses:
one handes (addr%256<128), the other one (addr%256>=128)

If everything is perfectly aligned, the load one one bus was far higher than the
load on the other bus.

Probably there are similar problems when walking linked lists if the L1 cache
has a low associativity.


>   Hmm, no that note, seen the L1 line size defined for a Pentium IIII?
> 128 bytes!! (CONFIG_X86_L1_CACHE_SHIFT of 7).  That is probably going to
> waste a lot of space for small objects.
>
No, it doesn't:
HWCACHE_ALIGN means "do not cross a cache line boundary".
Thus all power-of-2 objects are unaffected.
It does waste a lot of space for 129 byte objects with HWCACHALIGN set: they are
rounded up to 256 bytes.
But that isn't new: 68 byte buffer heads on Athlon kernels were rounded to 128
bytes.
[btw, 128 bytes is the L2 cache line size. The L1 cache line size is 64 bytes]

> 
> > Obviously using offset 32 bytes for a structure with a 64 byte hot
> zone
> > means that 2 slabs with a different "color" compete for the same cache
> > lines [just assuming 32 byte cache lines for simplicity] in 50% of the
> > cases, but otoh offset==64 halfs the number of possible colors.
> 
>   Yes.
>   It is possibly to improve on the current slab allocator, to get an
> extra colour or two out of it for some object sizes (eg. when the slab
> management is on slab, it is only ever at the front of a slab - it could
> also wrap round to the rear).
>
That's another issue.

The question is who should decide about the cache colour offset?

a) the slab allocator always chooses the smallest sensible offset (i.e. the
alignment)
b) the caller can specify the offset, e.g. if the caller knows that the hot zone
is large he would use a larger colour offset.

Even if the hot zone is larger than the default offset, is there any advantage
of increasing the colour offset beyond the alignment?

I don't see an advantage.

--
	Manfred
