Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUDAVlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUDAV2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:28:25 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:2867 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263176AbUDAVMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:44 -0500
Date: Thu, 1 Apr 2004 13:11:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 5/23] mask v2 - Add new mask.h file
Message-Id: <20040401131129.4329336f.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_5_of_23 - New mask ADT
	Adds new include/linux/mask.h header file

	==> See this mask.h header for more extensive mask documentation <==

Diffstat Patch_5_of_23:
 mask.h                         |  362 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 362 insertions(+)

===================================================================
--- 2.6.4.orig/include/linux/mask.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.4/include/linux/mask.h	2004-04-01 09:31:34.000000000 -0800
@@ -0,0 +1,369 @@
+#ifndef __LINUX_MASK_H
+#define __LINUX_MASK_H
+
+/*
+ * include/linux/mask.h
+ *
+ * Copyright (c) 2004 Silicon Graphics, Inc. All rights reserved.
+ *
+ * Paul Jackson <pj@sgi.com>
+ *
+ * This file is distributed under the GNU GENERAL PUBLIC LICENSE (GPL)
+ * Version 2 (June 1991). See the "COPYING" file distributed with this
+ * software for more info.
+ */
+
+/*
+ * Mask is an abstract data type for multi-word bit masks.  Masks
+ * are bitmaps (arrays of unsigned longs) wrapped in a struct.
+ * The struct wrapper enables them to be assigned and passed as
+ * arguments.  Masks are useful for representing sets of small
+ * numbers, such as the CPU numbers on a multi-processor system.
+ *
+ * How mask.h fits with bitops.h, bitmap.h, cpumask.h and nodemask.h:
+ *
+ *  1) bitmap.h and lib/bitmap.c provide several operations
+ *     for manipulating bitmaps, as arrays of unsigned long.
+ *     There are operations that and, or, set, clear, shift,
+ *     print, parse, and test these bitmaps.  The routines
+ *     typically require a pointer to an array of unsigned longs,
+ *     and a count of the number of valid bits therein.
+ *
+ *     The byte ordering of bitmaps is more natural on little
+ *     endian architectures.  See the big-endian headers
+ *     include/asm-ppc64/bitops.h and include/asm-s390/bitops.h
+ *     for the best explanations of this ordering.
+ *
+ *  2) bitops.h provides a few specific inline routines for
+ *     finding the first set bit and the Hamming weight of
+ *     these same bitmaps.  Several architectures provide
+ *     include/asm-<arch>/bitops.h variants, optimized for
+ *     specific processor instruction sets.
+ *
+ *  3) mask.h makes use of bitmap.h, bitops.h and a few other
+ *     kernel utilities to provide a mask abstract data type
+ *     (ADT) as a structure of an array of unsigned longs.
+ *     mask.h attempts to provide a fairly complete set of
+ *     operations, to make it easy for users to write clear
+ *     concise and correct mask manipulation code.
+ *
+ *     The mask macros use the fairly rich compile time
+ *     optimizations of gcc in order to generate optimum code
+ *     for each architecture.  Some of these macros require the
+ *     current mask type or number of bits - the cpumask.h and
+ *     nodemask.h macros serve to hide such details.
+ *
+ *  4) cpumask.h and nodemask.h are both based on mask.h.
+ *     They provide cpu and node specific macros that hide
+ *     such details as NR_CPUS that might be needed by the
+ *     lower level mask macros defined below.
+ *
+ * Summary:
+ *     Don't use mask.h directly - use cpumask.h and nodemask.h.
+ *
+ * The available mask operations and their rough meaning in the
+ * case that "nbits == BITS_PER_LONG" are:
+ *
+ * __mask(nbits)			Use to define new *mask types
+ * mask_setbit(bit, mask)		mask |= bit
+ * mask_clearbit(bit, mask)		mask &= ~bit
+ * mask_setall(mask, nbits)		mask = ~0UL
+ * mask_clearall(mask, nbits)		mask = 0UL
+ * mask_isset(bit, mask)		Is bit set in mask?
+ * mask_test_and_set(bit, mask)		mask & bit ? 1 : (mask |= bit, 0)
+ * mask_and(dst, src1, src2, nbits)	dst = src1 & src2
+ * mask_or(dst, src1, src2, nbits)	dst = src1 | src2
+ * mask_xor(dst, src1, src2, nbits)	dst = src1 ^ src2
+ * mask_andnot(dst, src1, src2, nbits)	dst = src1 & ~src2
+ * mask_complement(dst, src, nbits)	dst = ~src
+ * mask_equal(mask1, mask2, nbits)	Are mask1 and mask2 equal?
+ * mask_intersects(mask1, mask2, nbits) Do mask1 and mask2 overlap?
+ * mask_subset(mask1, mask2, nbits)	Is mask1 a subset of mask2?
+ * mask_empty(mask, nbits)		Is mask empty?
+ * mask_full(mask, nbits)		Are all bits set in mask?
+ * mask_weight(mask, nbits)		Hamming Weight: number set bits
+ * mask_shift_right(dst, src, n, nbits)	dst = src >> n
+ * mask_shift_left(dst, src, n, nbits)	dst = src << n
+ * mask_first(mask, nbits)		find_first_bit(mask, nbits)
+ * mask_next(bit, mask, nbits)		find_next_bit(mask, size, bit, nbits)
+ * mask_of_bit(bit, T)			returns mask with a single bit set
+ * MASK_ALL(nbits)			returns mask with all bits set
+ * MASK_NONE(nbits)			returns mask with no bits set
+ * mask_addr(mask)			Array of unsigned long's in mask
+ * mask_scnprintf(buf, len, mask, nbits) scnprintf(buf, len, "%lx", mask, nbits)
+ * mask_parse(ubuf, ulen, mask, nbits)	parse comma sep 32 bit words to mask
+ *
+ *           Various Implementation Details
+ *           ==============================
+ *
+ * The parameter 'T' above must be a variable of the appropriate
+ *   mask type (cpumask_t or nodemask_t, for instance).  This
+ *   variable is only used for its typeof() information.
+ *
+ * For details of mask_scnprintf() and mask_parse(), see
+ *   bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c
+ *
+ * A new *mask type should be defined, such as cpumask_t or
+ *   nodemask_t, for each possibly different sized (number of
+ *   bits) bitmask based on this mask ADT.  The definition
+ *   for example of cpumask_t is:
+ *           typedef __mask(NR_CPUS) cpumask_t;
+ *
+ * The previous definitions of CPU_MASK_ALL were inconsistent.
+ *   For cpumasks of one word size or less, they set exactly
+ *   NR_CPUS bits, leaving any remaining high order bits zero.
+ *   For cpumasks of multiple words, all bits were set, which
+ *   might result in a cpumask of weight > NR_CPUS, if NR_CPUS is
+ *   not an exact multiple of the number of bits in an unsigned
+ *   long.  The MASK_ALL(nbits) macro fixes this inconsistency
+ *   by refining the static initializor to set only valid bits
+ *   in the last word.
+ *
+ * These macros presume that all masks passed in a given call
+ *   are the same nbits long, and that only bits in positions
+ *   b where 0 <= b < nbits might be set in input masks.
+ *   They ensure that no additional bits outside this range
+ *   become set (however don't protect against improperly set
+ *   bits that are outside this range but still inside the array
+ *   of unsigned longs representing the mask.)  In other words,
+ *   any implementation of these ops may assume as a precondition
+ *   that any unused bits (bits in the array of unsigned
+ *   longs, outside the range 0 to nbits-1) are zero.  And any
+ *   implementation of these ops must ensure as a postcondition
+ *   on all output masks that this same precondition (unused
+ *   bits are zero) holds.  If you manage to create, by some
+ *   other means, a mask with some unused bits non-zero, and
+ *   then pass that mask to one of these mask operations, that
+ *   operation may malfunction.
+ *
+ * The abstract bit model supported by these masks is that of
+ *   an infinite set of bits, in positions numbered 0 and up,
+ *   where all but the first 'nbits' bits are always zero.
+ *   Calls that implicitly attempt to set any bit outside of
+ *   the first 'nbits' bits successfully and quietly leave such
+ *   bits as zero.  Calls that query or modify specifically
+ *   numbered bit positions require as a precondition that the
+ *   specified bit position 'n' is the range 0 <= n < nbits, and
+ *   may malfunction if handed a bit position outside this range.
+ *
+ * The mask_addr() op enables violating this model.  It returns
+ *   the address of the start of the array of unsigned
+ *   longs, enabling the caller to directly manipulate them.
+ *   This can be used to intermix mask ops with classic 'C' bit
+ *   operations, usually only done on systems whose cpumask_t
+ *   fits in a single unsigned long word.
+ *
+ * The underlying bitmap.c operations such as bitmap_and() and
+ *   bitmap_or() don't follow this model.  They don't assume
+ *   the precondition that unused bits are zero, and they do not
+ *   mask off any unused portion of input masks in most cases.
+ *   The bitmap operations that produce Boolean or scalar results,
+ *   such as for empty, full and weight, _do_ filter out unused bits.
+ *   However the underlying bitop.h operations, such as set_bit()
+ *   and clear_bit(), do no sanitizing of their inputs, depending
+ *   heavily on preconditions.
+ *
+ * The declaration of the array _m[] of unsigned longs in the
+ *   definition of __mask() below intentionally does not use
+ *   the DECLARE_BITMAP() macro.  It would be gratuitously opaque
+ *   in this case - as the macro implementations below depend on
+ *   the internal details of this declaration.
+ *
+ * The MASK_LAST_WORD() macro defines the value of the last (high
+ *   order) word of a bitmask.  In particular, for the case of a
+ *   mask of a size that is an exact multiple of the word size,
+ *   with all bits set, it ensures that this value is all one's,
+ *   not all zero's.
+ *
+ * The file include/mask.h applies to all architectures.
+ *   Architectures requiring custom details should provide
+ *   them in their include/asm-<arch>/bitops.h file, and
+ *   if necessary modify the common include/linux/mask.h
+ *   file to conditionally generate the necessary code,
+ *   depending on compile time settings.  No need to write
+ *   ugly #ifdef's to do this - gcc provides a rich set
+ *   of compile time extensions.  See further for example:
+ *   http://gcc.gnu.org/onlinedocs/gcc-3.3.3/gcc/C-Extensions.html
+ *
+ * Some architectures (I'm told sparc32) do not pass structures
+ *   efficiently as arguments to subroutine calls, even if the
+ *   structure is just one word long.  If you need to pass
+ *   a cpumask or nodemask to a subroutine in a performance
+ *   critical path on such an architecture, then as an
+ *   alternative, pass the first unsigned long of the mask
+ *   directly, using cpus_addr() or nodes_addr().  Of course,
+ *   if your masks are more than one word long, this won't
+ *   be adequate.
+ */
+
+#include "linux/bitops.h"
+#include "linux/string.h"
+#include "linux/types.h"
+#include "linux/kernel.h"
+#include "linux/bitmap.h"
+
+#define __mask(bits)	struct { unsigned long _m[BITS_TO_LONGS(bits)]; }
+
+#define MASK_LAST_WORD(nbits)						\
+(									\
+	((nbits) % BITS_PER_LONG) ?					\
+		(1<<((nbits) % BITS_PER_LONG))-1 : ~0UL			\
+)				
+
+#define mask_setbit(bit, mask)						\
+	set_bit((bit), (mask)._m)
+
+#define mask_clearbit(bit, mask)					\
+	clear_bit((bit), (mask)._m)
+
+#define mask_setall(mask, nbits) 					\
+do {									\
+	size_t sz_all_but_last = sizeof(mask) - sizeof(unsigned long);	\
+	if (sz_all_but_last > 0)					\
+		memset((mask)._m, 0xff, sz_all_but_last);		\
+	(mask)._m[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits);	\
+} while(0)
+
+#define mask_clearall(mask, nbits) 					\
+do {									\
+	if (sizeof(mask) == sizeof(unsigned long))			\
+		(mask)._m[0] = 0UL;					\
+	else								\
+		bitmap_clear((mask)._m, (nbits));			\
+} while(0)
+
+#define mask_isset(bit, mask)						\
+	test_bit((bit), (mask)._m)
+
+#define mask_test_and_set(bit, mask)					\
+	test_and_set_bit((bit), (mask)._m)
+
+#define mask_and(dst, src1, src2, nbits)				\
+do {									\
+	if (sizeof(dst) == sizeof(unsigned long))			\
+		(dst)._m[0] = (src1)._m[0] & (src2)._m[0];		\
+	else								\
+		bitmap_and((dst)._m, (src1)._m, (src2)._m, (nbits));	\
+} while(0)
+
+#define mask_or(dst, src1, src2, nbits)					\
+do {									\
+	if (sizeof(dst) == sizeof(unsigned long))			\
+		(dst)._m[0] = (src1)._m[0] | (src2)._m[0];		\
+	else								\
+		bitmap_or((dst)._m, (src1)._m, (src2)._m, (nbits));	\
+} while(0)
+
+#define mask_xor(dst, src1, src2, nbits)				\
+do {									\
+	if (sizeof(dst) == sizeof(unsigned long))			\
+		(dst)._m[0] = (src1)._m[0] ^ (src2)._m[0];		\
+	else								\
+		bitmap_xor((dst)._m, (src1)._m, (src2)._m, (nbits));	\
+} while(0)
+
+#define mask_andnot(dst, src1, src2, nbits)				\
+do {									\
+	if (sizeof(dst) == sizeof(unsigned long))			\
+		(dst)._m[0] = (src1)._m[0] & ~(src2)._m[0];		\
+	else								\
+		bitmap_andnot((dst)._m, (src1)._m, (src2)._m, (nbits));	\
+} while(0)
+
+#define mask_complement(dst, src, nbits)				\
+	bitmap_complement((dst)._m, (src)._m, (nbits))
+
+#define mask_equal(mask1, mask2, nbits)					\
+({									\
+	int r;								\
+	if (sizeof(mask1) == sizeof(unsigned long))			\
+		r = ((mask1)._m[0] == (mask2)._m[0]);			\
+	else								\
+		r = bitmap_equal((mask1)._m, (mask2)._m, (nbits));	\
+	r;								\
+})
+
+#define mask_intersects(mask1, mask2, nbits)				\
+({									\
+	int r;								\
+	if (sizeof(mask1) == sizeof(unsigned long))			\
+		r = (((mask1)._m[0] & (mask2)._m[0]) != 0);		\
+	else								\
+		r = bitmap_intersects((mask1)._m, (mask2)._m, (nbits));	\
+	r;								\
+})
+
+#define mask_subset(mask1, mask2, nbits)				\
+({									\
+	int r;								\
+	if (sizeof(mask1) == sizeof(unsigned long))			\
+		r = (((mask1)._m[0] & ~(mask2)._m[0]) == 0);		\
+	else								\
+		r = bitmap_subset((mask1)._m, (mask2)._m, (nbits));	\
+	r;								\
+})
+
+#define mask_empty(mask, nbits)						\
+({									\
+	int r;								\
+	if (sizeof(mask) == sizeof(unsigned long))			\
+		r = ((mask)._m[0] == 0UL);				\
+	else								\
+		r = bitmap_empty((mask)._m, (nbits));			\
+	r;								\
+})
+
+#define mask_full(mask, nbits)						\
+	bitmap_full((mask)._m, (nbits))
+
+#define mask_weight(mask, nbits)					\
+	bitmap_weight((mask)._m, (nbits))
+
+#define mask_shift_right(dst, src, n, nbits)				\
+	bitmap_shift_right((dst)._m, (src)._m, (n), (nbits))
+
+#define mask_shift_left(dst, src, n, nbits)				\
+	bitmap_shift_left((dst)._m, (src)._m, (n), (nbits))
+
+#define mask_first(mask, nbits)						\
+	find_first_bit((mask)._m, (nbits))
+
+#define mask_next(bit, mask, nbits)					\
+	find_next_bit((mask)._m, (nbits), (bit)+1)
+
+#define mask_of_bit(bit, T)						\
+({									\
+	typeof(T) m;							\
+	mask_clearall(m, 8*sizeof(m));					\
+	mask_setbit((bit), m);						\
+	m;								\
+})
+
+/* Use if nbits <= BITS_PER_LONG */
+#define MASK_ALL1(nbits)						\
+{ {									\
+	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
+} }
+
+/* Use if nbits > BITS_PER_LONG */
+#define MASK_ALL2(nbits)						\
+{ {									\
+	[0 ... BITS_TO_LONGS(nbits)-2] = ~0UL,				\
+	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
+} }
+
+#define MASK_NONE(nbits)						\
+{ {									\
+	[0 ... BITS_TO_LONGS(nbits)-1] =  0UL				\
+} }
+
+#define mask_addr(mask)							\
+	((mask)._m)
+
+#define mask_scnprintf(buf, len, mask, nbits)				\
+	bitmap_scnprintf((buf), (len), ((mask)._m), (nbits))
+
+#define mask_parse(ubuf, ulen, mask, nbits)				\
+	bitmap_parse((ubuf), (ulen), ((mask)._m), (nbits))
+
+#endif /* __LINUX_MASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
