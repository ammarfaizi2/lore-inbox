Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267301AbSLEMIc>; Thu, 5 Dec 2002 07:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267302AbSLEMIc>; Thu, 5 Dec 2002 07:08:32 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:13263 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267301AbSLEMIb>; Thu, 5 Dec 2002 07:08:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 04:13:29 -0800
Message-Id: <200212051213.EAA04698@adam.yggdrasil.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC] generic device DMA implementation
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>On Wed, 2002-12-04 at 22:46, James Bottomley wrote:
>> If you have a machine that has both consistent and inconsistent blocks, you 
>> need to encode that in dma_addr_t (which is a platform definable type).
>
>I don't agree here. Encoding things in dma_addr_t, then special casing
>in consistent_{map,unmap,sync,....) looks really ugly to me ! You want
>dma_addr_t to contain a bus address for the given bus you are working
>with and pass that to your device, period.

	I don't think that James meant actually defining flag bits
inside of dma_addr_t, although I suppose you could do it for some
unused high bits on some architectures.  I think the implication
was that you could have something like:


static inline int is_consistent(dma_addr_t addr)
{
	return (addr >= CONSISTENT_AREA_START && addr < CONSISTENT_AREA_END);
}

	I also don't recall anyone proposing special casing
dma_{map,unmap,sync} based on the results of such a check.  I think
the only function that might use it would be maybe_wmb(addr,len),
which, on some might machines might be:

static inline void maybe_wmb(dma_addr_t addr, size_t len)
{
	if (!is_consistent(addr))
		wmb();
}

	In practice, I think dma_malloc() would either always return
consistent memory or never return consistent memory on a given
machine, so maybe_wmb would probably never do such range checking.
Instead it would compile to nothing on machines where dma_alloc always
returned consistent memory, would compile to wmb() on systems where
dma_alloc would only succeed if it could return non-consistent memory,
and would compile to a procedure pointer on parisc that would either
set to point to a no-op or wmb, depending on which kind of machine the
kernel was booted on.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
