Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRCBKxE>; Fri, 2 Mar 2001 05:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRCBKwy>; Fri, 2 Mar 2001 05:52:54 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:12254 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S130397AbRCBKwp>; Fri, 2 Mar 2001 05:52:45 -0500
Date: Fri, 2 Mar 2001 10:59:53 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <3A9EC563.C450FAD3@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0103021040100.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Mar 2001, Manfred Spraul wrote:
> Yes, I see the difference, but I'm not sure that it will work as
> intended.
> offset must be a multiple of the alignment, everything else won't work.

  The code does force the offset to be a multiple of the alignment -
rounding the offset up.  The idea was to a caller could something like;
	kmem_cache_create("foo", sizeof(foo_s),
			  offsetoff(foo_s, member), ....);

where structure members in foo_s are "hot" up until the 'member'
structure.

> In which cases an offset > alignment is really a win?

  You've got me. :)  I don't know.
  In the Bonwick paper, such a facility was described, so I thought "hey,
sounds like that might be useful".
  Could be a win on archs with small L1 cache line sizes (16bytes on a
486) - but most modern processors have larger lines.
  Hmm, no that note, seen the L1 line size defined for a Pentium IIII?
128 bytes!! (CONFIG_X86_L1_CACHE_SHIFT of 7).  That is probably going to
waste a lot of space for small objects.


> Obviously using offset 32 bytes for a structure with a 64 byte hot zone
> means that 2 slabs with a different "color" compete for the same cache
> lines [just assuming 32 byte cache lines for simplicity] in 50% of the
> cases, but otoh offset==64 halfs the number of possible colors.

  Yes.
  It is possibly to improve on the current slab allocator, to get an
extra colour or two out of it for some object sizes (eg. when the slab
management is on slab, it is only ever at the front of a slab - it could
also wrap round to the rear).

Mark

