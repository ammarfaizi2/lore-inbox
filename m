Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCSBBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUCSBBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:01:45 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:21464 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261619AbUCSBBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:01:32 -0500
Date: Thu, 18 Mar 2004 16:59:57 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040318165957.592e49d3.pj@sgi.com>
In-Reply-To: <1079651064.8149.158.camel@arrakis>
References: <1079651064.8149.158.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__18_Mar_2004_16_59_57_-0800_GrAyQKwemChSe_Us"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__18_Mar_2004_16_59_57_-0800_GrAyQKwemChSe_Us
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Your nodemask_t reminds me of something I posted to linux-ia64 last
November 7, 2004, under the subject: "[PATCH preview] Adds nodemask_t
for use in cpusets (NUMA memory placement)".

Chris Hellwig responded to it at the time asking why I didn't provide a
single generic mask ADT, and make cpumask and nodemask instances of
that.

I coded that up, but then got distracted.  The remaining issue for which
I didn't have a good answer was that my proposal would break the optimum
handling for sparc64 or other systems that didn't handle passing
structures on the stack efficiently.

Bill Irwin was a party to my discussions of that effort, so I presume
that if he felt it had further merit, he would have mentioned it to
you, Matthew.

Could one of you, Bill or Matthew, speak to why this generic mask ADT,
underlying both cpumask and nodemask, should not be pursued further,
instead of duplicating the various details of cpumask, after a global
s/cpu/node/g change?

I am attaching the header file include/linux/mask.h for my current
version of this mask.h, in case someone reading wants more specifics of
what it is that I am referring to.

This version almost certainly does _not_ work on big endian 64 systems,
due to my ignorance of how kernel bitmasks were layed out when I last
worked on this mask.h header.  Unlike the sparc64 performance issues
with passing structs on the stack, I would hope that the big/little
endian issues could be fixed without messing things up too much.

If this mask.h could actually be made to work, including on sparc64,
then it would seem to be a much cleaner solution.  With it, we would
define cpumask_t and nodemask_t as simply:

  typedef __mask(NR_NODES) nodemask_t;
  typedef __mask(NR_CPUS) cpumask_t;

and either use operations such as mask_and() on both, or if one insisted
on keeping operations that specifically called out cpumask, add some
15 trivial defines such as:

  #define cpumask_and(dst, src1, src2) mask_and(dst, src1, src2)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

--Multipart=_Thu__18_Mar_2004_16_59_57_-0800_GrAyQKwemChSe_Us
Content-Type: text/plain;
 name="mask.h"
Content-Disposition: attachment;
 filename="mask.h"
Content-Transfer-Encoding: 7bit

#ifndef _MASK_H
#define _MASK_H

/*
 * linux/include/linux/mask.h
 *
 * Copyright (c) 2003 Silicon Graphics, Inc. All rights reserved.
 *
 * Paul Jackson <pj@sgi.com>
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */

/* Mask is an abstract data type for multi-word bit masks.  Masks are
 * wrapped in a struct, so that they can be passed about as lvalues.
 * The available mask operations and their rough meaning in a single
 * word, single-threaded, unsafe, hypothetical case are:
 *
 * mask_bitsize(mask)			sizeof(mask) * 8
 * mask_snprintf(buf, len, mask)	snprintf(buf, len, "%lx", mask)
 * mask_parse(ubuf, ubuflen, mask)	parse comma sep 32 bit words to mask
 * mask_parselist(buf, mask)		parse cpuset =/+/- list to mask
 * mask_bitset(bit, mask)		mask |= bit
 * mask_bitclear(bit, mask)		mask &= ~bit
 * mask_allset(mask)			mask = ~0UL
 * mask_allclear(mask)			mask = 0UL
 * mask_setnbits(mask, nbits)		mask = ~(~0UL << nbits)
 * mask_isset(bit, mask)		mask | bit
 * mask_test_and_set(bit, mask)		mask | bit ? 0 : mask |= bit
 * mask_assign(dst, src)		dst = src
 * mask_andnot(dst, src)		dst &= ~src
 * mask_orequal(dst, src)		dst |= src
 * mask_and(dst, src1, src2)		dst = src1 & src2
 * mask_or(dst, src1, src2)		dst = src1 | src2
 * mask_complement(mask)		mask = ~mask
 * mask_equal(mask1, mask2)		mask1 == mask2
 * mask_empty(mask)			mask == 0UL
 * mask_weight(mask)			Hamming Weight: number set bits
 * mask_shift_right(dst, src, n)	dst = src >> n
 * mask_shift_left(dst, src, n)		dst = src << n
 * mask_first(mask)			find_first_bit(mask)
 * mask_next(bit, mask)			find_next_bit(mask, size, bit)
 * mask_of_bit(n, mask)			(typeof(mask)) (1 << n)
 * MASK_ALL(mask, nbits)		(typeof(mask)) ~(~0UL << nbits)
 * MASK_NONE(mask)			(typeof(mask)) 0UL
 *
 * Example usage to establish a cpumask_t type and cpu_* operations:
 *   typedef __mask(NR_CPUS) cpumask_t;
 *   #define cpu_set(cpu, map) mask_bitset((cpu), (map))
 *   #define ... 15 or so more cpu_ops() using corresponding mask_ops().
 * Or just do the one line "typedef __mask[..] xxx_t" definition,
 *   skip the custom named op definitions, and use the mask_* ops
 *   directly.  Maybe the custom cpu_* ops should have been done that
 *   way in the first place.
 *
 * The above ops that set or clear bits within an existing mask
 *   do so with atomic instructions, but operations on multiple
 *   words are not thread safe - bring your own locks.
 *
 * The existing definitions of CPU_MASK_ALL were inconsistent.
 *   For cpumasks of one word size or less, they set exactly
 *   NR_CPUS bits, leaving any remaining high order bits zero.
 *   For cpumasks of multiple words, all bits were set, which
 *   might result in a cpumask of weight > NR_CPUS, if NR_CPUS
 *   is not an exact multiple of the number of bits in an
 *   unsigned long.  The MASK_ALL(mask, nbits) macro follows
 *   this inconsistency.
 */

#include "linux/bitops.h"
#include "linux/string.h"
#include "linux/types.h"
#include "linux/kernel.h"
#include "linux/bitmap.h"

/* Deliberately not using DECLARE_BITMAP() - gratuitously opaque. -pj */
#define __mask(bits)	struct { unsigned long _m[BITS_TO_LONGS(bits)]; }

extern int bitmap_snprintf(char *buf, unsigned int buflen,
	const unsigned long *maskp, unsigned int nmaskbits);

extern int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
	unsigned long *maskp, int nmaskbits);

extern int bitmap_parselist(char *buf,
	unsigned long *maskp, int nmaskbits);

extern void bitmap_setnbits(unsigned long *maskp,
	int nmaskbits, int nbits);

#define mask_bitsize(mask) (sizeof(mask) * 8)

/* Silently right truncates if buflen too short. */
#define mask_snprintf(buf, buflen, mask)		\
	bitmap_snprintf((buf), (buflen),		\
	((mask)._m), sizeof(mask)*8);

#define mask_parse(ubuf, ubuflen, mask)			\
	bitmap_parse((ubuf), (ubuflen), 		\
	((mask)._m), sizeof(mask)*8);

#define mask_parselist(buf, mask)			\
	bitmap_parse((buf),		 		\
	((mask)._m), sizeof(mask)*8);

#define mask_bitset(bit, mask)				\
	(!sizeof(mask) ? 1 :				\
	set_bit((bit), (mask)._m))

#define mask_bitclear(bit, mask)			\
	(!sizeof(mask) ? 0 :				\
	clear_bit((bit), (mask)._m))

#define mask_allset(mask) 				\
	memset((mask)._m, 0xff, sizeof(mask))

#define mask_allclear(mask) 				\
	memset((mask)._m, 0, sizeof(mask))

#define mask_setnbits(mask, nbits)			\
do {							\
	if (sizeof(mask) == sizeof(unsigned long))	\
		(mask)._m[0] = ~(~0UL << ((nbits)%BITS_PER_LONG));	\
	else						\
		bitmap_setnbits((mask)._m,		\
			sizeof(mask)*8, (nbits));	\
} while (0)

#define mask_isset(bit, mask)				\
	(!sizeof(mask) ? 1 : 				\
	test_bit((bit), (mask)._m))

#define mask_test_and_set(bit, mask)			\
	(!sizeof(mask) ? 1 : 				\
	test_and_set_bit(bit, (mask)._m))

#define mask_assign(dst, src)				\
		((dst) = (src))

#define mask_andnot(dst, src)				\
do {							\
	unsigned long *dstp = (dst)._m;			\
	const unsigned long *srcp = (src)._m;		\
	unsigned int masklen = ARRAY_SIZE((dst)._m);	\
	int i;						\
	for (i = 0; i < masklen; i++)			\
		dstp[i] &= ~srcp[i];			\
} while (0)

#define mask_orequal(dst, src)				\
do {							\
	unsigned long *dstp = (dst)._m;			\
	const unsigned long *srcp = (src)._m;		\
	unsigned int masklen = ARRAY_SIZE((dst)._m);	\
	int i;						\
	for (i = 0; i < masklen; i++)			\
		dstp[i] |= srcp[i];			\
} while (0)

#define mask_and(dst, src1, src2)			\
	bitmap_and((dst)._m, (src1)._m, (src2)._m,	\
		mask_bitsize(dst))

#define mask_or(dst, src1, src2)			\
	bitmap_or((dst)._m, (src1)._m, (src2)._m,	\
		mask_bitsize(dst))

#define mask_complement(mask)				\
	bitmap_complement((mask)._m, mask_bitsize(mask))

#define mask_equal(mask1, mask2)			\
	bitmap_equal((mask1)._m, (mask2)._m,		\
		mask_bitsize(mask1))

#define mask_empty(mask)				\
	bitmap_empty((mask)._m, mask_bitsize(mask))

#define mask_weight(mask)				\
	bitmap_weight((mask)._m, mask_bitsize(mask))

#define mask_shift_right(dst, src, shift)		\
	bitmap_shift_right((dst)._m, (src)._m, (shift),	\
		mask_bitsize(dst))

#define mask_shift_left(dst, src, shift)		\
	bitmap_shift_left((dst)._m, (src)._m, (shift),	\
		mask_bitsize(dst))

#define mask_first(mask)				\
	find_first_bit((mask)._m, mask_bitsize(mask))

#define mask_next(n, mask)				\
	(!sizeof(mask) ? 0 : 				\
	find_next_bit((mask)._m, mask_bitsize(mask), (n)+1))

/* Need input 'mask' argument just to get type */
#define mask_of_bit(n, mask)				\
({							\
	typeof(mask) __mask;				\
	mask_allclear(__mask);				\
	mask_bitset((n), __mask);			\
	__mask;						\
})

#define MASK_ALL(mask, nbits)				\
({							\
	typeof(mask) __mask;				\
	int nbitshift = (nbits) % BITS_PER_LONG;	\
	if (sizeof(mask) == sizeof(unsigned long))	\
		__mask._m[0] = ~(~0UL << nbitshift);	\
	else						\
		mask_setnbits(__mask, (nbits));		\
	__mask;						\
})

#define MASK_NONE(mask)					\
({							\
	typeof(mask) __mask;				\
	mask_allclear(__mask);				\
	__mask;						\
})

#endif /* _MASK_H */

--Multipart=_Thu__18_Mar_2004_16_59_57_-0800_GrAyQKwemChSe_Us--
