Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUDAVNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbUDAVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:13:26 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:2610 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263177AbUDAVMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:12 -0500
Date: Thu, 1 Apr 2004 13:11:36 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 6/23] mask v2 - Replace cpumask_t with one using mask
Message-Id: <20040401131136.792495fa.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_6_of_23 - Rework cpumasks to use new mask ADT
	Removes many old include/asm-<arch> and asm-generic cpumask files
	Add intersects, subset, xor and andnot operators.
	Provides temporary emulators for obsolete const, promote, coerce
	Presents entire cpumask API clearly in single cpumask.h file

Diffstat Patch_6_of_23:
 asm-alpha/cpumask.h                   |    6 -
 asm-arm/cpumask.h                     |    6 -
 asm-arm26/cpumask.h                   |    6 -
 asm-cris/cpumask.h                    |    6 -
 asm-generic/cpumask.h                 |   40 -------
 asm-generic/cpumask_arith.h           |   49 ---------
 asm-generic/cpumask_array.h           |   54 ---------
 asm-generic/cpumask_const_reference.h |   29 -----
 asm-generic/cpumask_const_value.h     |   21 ---
 asm-generic/cpumask_up.h              |   59 ----------
 asm-h8300/cpumask.h                   |    6 -
 asm-i386/cpumask.h                    |    6 -
 asm-m68k/cpumask.h                    |    6 -
 asm-m68knommu/cpumask.h               |    6 -
 asm-mips/cpumask.h                    |    6 -
 asm-parisc/cpumask.h                  |    6 -
 asm-ppc/cpumask.h                     |    6 -
 asm-ppc64/cpumask.h                   |    6 -
 asm-s390/cpumask.h                    |    6 -
 asm-sh/cpumask.h                      |    6 -
 asm-sparc/cpumask.h                   |    6 -
 asm-sparc64/cpumask.h                 |    6 -
 asm-um/cpumask.h                      |    6 -
 asm-v850/cpumask.h                    |    6 -
 asm-x86_64/cpumask.h                  |    6 -
 linux/cpumask.h                       |  184 ++++++++++++++++++++++++++++------
 26 files changed, 153 insertions(+), 397 deletions(-)

===================================================================
--- 2.6.4.orig/include/asm-alpha/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-alpha/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_ALPHA_CPUMASK_H
-#define _ASM_ALPHA_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_ALPHA_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-arm/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-arm/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_ARM_CPUMASK_H
-#define _ASM_ARM_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_ARM_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-arm26/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-arm26/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_ARM26_CPUMASK_H
-#define _ASM_ARM26_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_ARM26_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-cris/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-cris/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_CRIS_CPUMASK_H
-#define _ASM_CRIS_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_CRIS_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,40 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_H
-#define __ASM_GENERIC_CPUMASK_H
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/threads.h>
-#include <linux/types.h>
-#include <linux/bitmap.h>
-
-#if NR_CPUS > BITS_PER_LONG && NR_CPUS != 1
-#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
-
-struct cpumask
-{
-	unsigned long mask[CPU_ARRAY_SIZE];
-};
-
-typedef struct cpumask cpumask_t;
-
-#else
-typedef unsigned long cpumask_t;
-#endif
-
-#ifdef CONFIG_SMP
-#if NR_CPUS > BITS_PER_LONG
-#include <asm-generic/cpumask_array.h>
-#else
-#include <asm-generic/cpumask_arith.h>
-#endif
-#else
-#include <asm-generic/cpumask_up.h>
-#endif
-
-#if NR_CPUS <= 4*BITS_PER_LONG
-#include <asm-generic/cpumask_const_value.h>
-#else
-#include <asm-generic/cpumask_const_reference.h>
-#endif
-
-#endif /* __ASM_GENERIC_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask_arith.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask_arith.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,49 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_ARITH_H
-#define __ASM_GENERIC_CPUMASK_ARITH_H
-
-/*
- * Arithmetic type -based cpu bitmaps. A single unsigned long is used
- * to contain the whole cpu bitmap.
- */
-
-#define cpu_set(cpu, map)		set_bit(cpu, &(map))
-#define cpu_clear(cpu, map)		clear_bit(cpu, &(map))
-#define cpu_isset(cpu, map)		test_bit(cpu, &(map))
-#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, &(map))
-
-#define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
-#define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
-#define cpus_clear(map)			do { map = 0; } while (0)
-#define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
-#define cpus_addr(map)			(&(map))
-
-#if BITS_PER_LONG == 32
-#define cpus_weight(map)		hweight32(map)
-#elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
-#endif
-
-#define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
-#define cpus_shift_left(dst, src, n)	do { dst = (src) << (n); } while (0)
-
-#define any_online_cpu(map)			\
-({						\
-	cpumask_t __tmp__;			\
-	cpus_and(__tmp__, map, cpu_online_map);	\
-	__tmp__ ? first_cpu(__tmp__) : NR_CPUS;	\
-})
-
-#define CPU_MASK_ALL	(~((cpumask_t)0) >> (8*sizeof(cpumask_t) - NR_CPUS))
-#define CPU_MASK_NONE	((cpumask_t)0)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
-#define cpus_promote(map)		({ map; })
-#define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
-
-#define first_cpu(map)			__ffs(map)
-#define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
-
-#endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask_array.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask_array.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,54 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_ARRAY_H
-#define __ASM_GENERIC_CPUMASK_ARRAY_H
-
-/*
- * Array-based cpu bitmaps. An array of unsigned longs is used to contain
- * the bitmap, and then contained in a structure so it may be passed by
- * value.
- */
-
-#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
-
-#define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
-#define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
-#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)
-#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, (map).mask)
-
-#define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
-#define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
-#define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
-#define cpus_complement(map)	bitmap_complement((map).mask, (map).mask, NR_CPUS)
-#define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
-#define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
-#define cpus_addr(map)		((map).mask)
-#define cpus_weight(map)		bitmap_weight((map).mask, NR_CPUS)
-#define cpus_shift_right(d, s, n)	bitmap_shift_right((d).mask, (s).mask, n, NR_CPUS)
-#define cpus_shift_left(d, s, n)	bitmap_shift_left((d).mask, (s).mask, n, NR_CPUS)
-#define first_cpu(map)		find_first_bit((map).mask, NR_CPUS)
-#define next_cpu(cpu, map)	find_next_bit((map).mask, NR_CPUS, cpu + 1)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)	((map).mask[0])
-#define cpus_promote(map)	({ cpumask_t __cpu_mask = CPU_MASK_NONE;\
-					__cpu_mask.mask[0] = map;	\
-					__cpu_mask;			\
-				})
-#define cpumask_of_cpu(cpu)	({ cpumask_t __cpu_mask = CPU_MASK_NONE;\
-					cpu_set(cpu, __cpu_mask);	\
-					__cpu_mask;			\
-				})
-#define any_online_cpu(map)			\
-({						\
-	cpumask_t __tmp__;			\
-	cpus_and(__tmp__, map, cpu_online_map);	\
-	find_first_bit(__tmp__.mask, NR_CPUS);	\
-})
-
-
-/*
- * um, these need to be usable as static initializers
- */
-#define CPU_MASK_ALL	{ {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} }
-#define CPU_MASK_NONE	{ {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
-
-#endif /* __ASM_GENERIC_CPUMASK_ARRAY_H */
===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask_const_reference.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask_const_reference.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,29 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_CONST_REFERENCE_H
-#define __ASM_GENERIC_CPUMASK_CONST_REFERENCE_H
-
-struct cpumask_ref {
-	const cpumask_t *val;
-};
-
-typedef const struct cpumask_ref cpumask_const_t;
-
-#define mk_cpumask_const(map)		((cpumask_const_t){ &(map) })
-#define cpu_isset_const(cpu, map)	cpu_isset(cpu, *(map).val)
-
-#define cpus_and_const(dst,src1,src2)	cpus_and(dst,*(src1).val,*(src2).val)
-#define cpus_or_const(dst,src1,src2)	cpus_or(dst,*(src1).val,*(src2).val)
-
-#define cpus_equal_const(map1, map2)	cpus_equal(*(map1).val, *(map2).val)
-
-#define cpus_copy_const(map1, map2)	bitmap_copy((map1).mask, (map2).val->mask, NR_CPUS)
-
-#define cpus_empty_const(map)		cpus_empty(*(map).val)
-#define cpus_weight_const(map)		cpus_weight(*(map).val)
-#define first_cpu_const(map)		first_cpu(*(map).val)
-#define next_cpu_const(cpu, map)	next_cpu(cpu, *(map).val)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce_const(map)		cpus_coerce(*(map).val)
-#define any_online_cpu_const(map)	any_online_cpu(*(map).val)
-
-#endif /* __ASM_GENERIC_CPUMASK_CONST_REFERENCE_H */
===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask_const_value.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask_const_value.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,21 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_CONST_VALUE_H
-#define __ASM_GENERIC_CPUMASK_CONST_VALUE_H
-
-typedef const cpumask_t cpumask_const_t;
-
-#define mk_cpumask_const(map)		(map)
-#define cpu_isset_const(cpu, map)	cpu_isset(cpu, map)
-#define cpus_and_const(dst,src1,src2)	cpus_and(dst, src1, src2)
-#define cpus_or_const(dst,src1,src2)	cpus_or(dst, src1, src2)
-#define cpus_equal_const(map1, map2)	cpus_equal(map1, map2)
-#define cpus_empty_const(map)		cpus_empty(map)
-#define cpus_copy_const(map1, map2)	do { map1 = (cpumask_t)map2; } while (0)
-#define cpus_weight_const(map)		cpus_weight(map)
-#define first_cpu_const(map)		first_cpu(map)
-#define next_cpu_const(cpu, map)	next_cpu(cpu, map)
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce_const(map)		cpus_coerce(map)
-#define any_online_cpu_const(map)	any_online_cpu(map)
-
-#endif /* __ASM_GENERIC_CPUMASK_CONST_VALUE_H */
===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask_up.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask_up.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,59 +0,0 @@
-#ifndef __ASM_GENERIC_CPUMASK_UP_H
-#define __ASM_GENERIC_CPUMASK_UP_H
-
-#define cpus_coerce(map)	(map)
-
-#define cpu_set(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 1UL; } while (0)
-#define cpu_clear(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 0UL; } while (0)
-#define cpu_isset(cpu, map)		((void)(cpu), cpus_coerce(map) != 0UL)
-#define cpu_test_and_set(cpu, map)	((void)(cpu), test_and_set_bit(0, &(map)))
-
-#define cpus_and(dst, src1, src2)					\
-	do {								\
-		if (cpus_coerce(src1) && cpus_coerce(src2))		\
-			cpus_coerce(dst) = 1UL;				\
-		else							\
-			cpus_coerce(dst) = 0UL;				\
-	} while (0)
-
-#define cpus_or(dst, src1, src2)					\
-	do {								\
-		if (cpus_coerce(src1) || cpus_coerce(src2))		\
-			cpus_coerce(dst) = 1UL;				\
-		else							\
-			cpus_coerce(dst) = 0UL;				\
-	} while (0)
-
-#define cpus_clear(map)			do { cpus_coerce(map) = 0UL; } while (0)
-
-#define cpus_complement(map)						\
-	do {								\
-		cpus_coerce(map) = !cpus_coerce(map);			\
-	} while (0)
-
-#define cpus_equal(map1, map2)		(cpus_coerce(map1) == cpus_coerce(map2))
-#define cpus_empty(map)			(cpus_coerce(map) == 0UL)
-#define cpus_addr(map)			(&(map))
-#define cpus_weight(map)		(cpus_coerce(map) ? 1UL : 0UL)
-#define cpus_shift_right(d, s, n)	do { cpus_coerce(d) = 0UL; } while (0)
-#define cpus_shift_left(d, s, n)	do { cpus_coerce(d) = 0UL; } while (0)
-#define first_cpu(map)			(cpus_coerce(map) ? 0 : 1)
-#define next_cpu(cpu, map)		1
-
-/* only ever use this for things that are _never_ used on large boxen */
-#define cpus_promote(map)						\
-	({								\
-		cpumask_t __tmp__;					\
-		cpus_coerce(__tmp__) = map;				\
-		__tmp__;						\
-	})
-#define cpumask_of_cpu(cpu)		((void)(cpu), cpus_promote(1))
-#define any_online_cpu(map)		(cpus_coerce(map) ? 0 : 1)
-
-/*
- * um, these need to be usable as static initializers
- */
-#define CPU_MASK_ALL	1UL
-#define CPU_MASK_NONE	0UL
-
-#endif /* __ASM_GENERIC_CPUMASK_UP_H */
===================================================================
--- 2.6.4.orig/include/asm-h8300/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-h8300/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_H8300_CPUMASK_H
-#define _ASM_H8300_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_H8300_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-i386/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-i386/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_I386_CPUMASK_H
-#define _ASM_I386_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_I386_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-m68k/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-m68k/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_M68K_CPUMASK_H
-#define _ASM_M68K_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_M68K_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-m68knommu/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-m68knommu/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_M68KNOMMU_CPUMASK_H
-#define _ASM_M68KNOMMU_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_M68KNOMMU_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-mips/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-mips/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_MIPS_CPUMASK_H
-#define _ASM_MIPS_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_MIPS_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-parisc/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-parisc/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_PARISC_CPUMASK_H
-#define _ASM_PARISC_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_PARISC_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-ppc/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-ppc/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_PPC_CPUMASK_H
-#define _ASM_PPC_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_PPC_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-ppc64/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-ppc64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_PPC64_CPUMASK_H
-#define _ASM_PPC64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_PPC64_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-s390/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-s390/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_S390_CPUMASK_H
-#define _ASM_S390_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_S390_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-sh/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-sh/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_SH_CPUMASK_H
-#define _ASM_SH_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_SH_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-sparc/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-sparc/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_SPARC_CPUMASK_H
-#define _ASM_SPARC_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_SPARC_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-sparc64/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-sparc64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_SPARC64_CPUMASK_H
-#define _ASM_SPARC64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_SPARC64_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-um/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-um/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_UM_CPUMASK_H
-#define _ASM_UM_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_UM_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-v850/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-v850/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_V850_CPUMASK_H
-#define _ASM_V850_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_V850_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/asm-x86_64/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/asm-x86_64/cpumask.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,6 +0,0 @@
-#ifndef _ASM_X86_64_CPUMASK_H
-#define _ASM_X86_64_CPUMASK_H
-
-#include <asm-generic/cpumask.h>
-
-#endif /* _ASM_X86_64_CPUMASK_H */
===================================================================
--- 2.6.4.orig/include/linux/cpumask.h	2004-04-01 09:15:56.000000000 -0800
+++ 2.6.4/include/linux/cpumask.h	2004-04-01 09:35:15.000000000 -0800
@@ -1,44 +1,170 @@
 #ifndef __LINUX_CPUMASK_H
 #define __LINUX_CPUMASK_H
 
+/*
+ * Cpumasks provide a bit mask suitable for representing the
+ * set of CPU's in a system, one bit position per CPU number.
+ *
+ * See detailed comments in the file linux/mask.h describing the
+ * data type on which these cpumasks are based.
+ *
+ * For details of cpumask_scnprintf() and cpumask_parse(),
+ * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
+ *
+ * The available cpumask operations are:
+ *
+ * void cpu_set(cpu, mask)		turn on bit 'cpu' in mask
+ * void cpu_clear(cpu, mask)		turn off bit 'cpu' in mask
+ * void cpus_setall(mask)		set all bits
+ * void cpus_clear(mask)		clear all bits
+ * int cpu_isset(cpu, mask)		true iff bit 'cpu' set in mask
+ * int cpu_test_and_set(cpu, mask)	test and set bit 'cpu' in mask
+ *
+ * void cpus_and(dst, src1, src2)	dst = src1 & src2  [intersection]
+ * void cpus_or(dst, src1, src2)	dst = src1 | src2  [union]
+ * void cpus_xor(dst, src1, src2)	dst = src1 ^ src2
+ * void cpus_andnot(dst, src1, src2)	dst = src1 & ~src2
+ * void cpus_complement(dst, src)	dst = ~src
+ *
+ * int cpus_equal(mask1, mask2)		Does mask1 == mask2?
+ * int cpus_intersects(mask1, mask2)	Do mask1 and mask2 intersect?
+ * int cpus_subset(mask1, mask2)	Is mask1 a subset of mask2?
+ * int cpus_empty(mask)			Is mask empty (no bits sets)?
+ * int cpus_full(mask)			Is mask full (all bits sets)?
+ * int cpus_weight(mask)		Hamming weigh - number of set bits
+ *
+ * void cpus_shift_right(dst, src, n)	Shift right
+ * void cpus_shift_left(dst, src, n)	Shift left
+ *
+ * int first_cpu(mask)			Number lowest set bit, or NR_CPUS
+ * int next_cpu(cpu, mask)		Next cpu past 'cpu', or NR_CPUS
+ *
+ * cpumask_t cpumask_of_cpu(cpu)	Return cpumask with bit 'cpu' set
+ * CPU_MASK_ALL				Initializer - all bits set
+ * CPU_MASK_NONE			Initializer - no bits set
+ * unsigned long *cpus_addr(mask)	Array of unsigned long's in mask
+ *
+ * int cpumask_scnprintf(buf, len, mask) Format cpumask for printing
+ * int cpumask_parse(ubuf, ulen, mask)	Parse ascii string as cpumask
+ *
+ * int num_online_cpus()		Number of online CPUs
+ * int num_possible_cpus()		Number of all possible CPUs
+ * int cpu_online(cpu)			Is some cpu online?
+ * int cpu_possible(cpu)		Is some cpu possible?
+ * void cpu_set_online(cpu)		set cpu in cpu_online_map
+ * void cpu_set_offline(cpu)		clear cpu in cpu_online_map
+ * int any_online_cpu(mask)		First online cpu in mask
+ *
+ * for_each_cpu_mask(cpu, mask)		for-loop cpu over mask
+ * for_each_cpu(cpu)			for-loop cpu over cpu_possible_map
+ * for_each_online_cpu(cpu)		for-loop cpu over cpu_online_map
+ */
+
 #include <linux/threads.h>
-#include <linux/bitmap.h>
-#include <asm/cpumask.h>
+#include <linux/mask.h>
 #include <asm/bug.h>
 
-#ifdef CONFIG_SMP
-
-extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
-
-#define num_online_cpus()		cpus_weight(cpu_online_map)
-#define num_possible_cpus()		cpus_weight(cpu_possible_map)
-#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
-
-#define for_each_cpu_mask(cpu, mask)					\
-	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
-		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu, mk_cpumask_const(mask)))
+typedef __mask(NR_CPUS) cpumask_t;
+extern cpumask_t _unused_cpumask_arg_;
 
-#define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
-#define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
+#define cpu_set(cpu, mask)	     mask_setbit((cpu), (mask))
+#define cpu_clear(cpu, mask)	     mask_clearbit((cpu), (mask))
+#define cpus_setall(mask)	     mask_setall((mask), NR_CPUS)
+#define cpus_clear(mask)	     mask_clearall(mask, NR_CPUS)
+#define cpu_isset(cpu, mask)	     mask_isset((cpu), (mask))
+#define cpu_test_and_set(cpu, mask)  mask_test_and_set((cpu), (mask))
+#define cpus_and(dst, src1, src2)    mask_and((dst), (src1), (src2), NR_CPUS)
+#define cpus_or(dst, src1, src2)     mask_or((dst), (src1), (src2), NR_CPUS)
+#define cpus_xor(dst, src1, src2)    mask_xor((dst), (src1), (src2), NR_CPUS)
+#define cpus_andnot(dst, src1, src2) mask_andnot((dst), (src1), (src2), NR_CPUS)
+#define cpus_complement(dst, src)    mask_complement((dst), (src), NR_CPUS)
+#define cpus_equal(mask1, mask2)     mask_equal((mask1), (mask2), NR_CPUS)
+#define cpus_intersects(mask1, mask2) mask_intersects((mask1), (mask2), NR_CPUS)
+#define cpus_subset(mask1, mask2)    mask_subset((mask1), (mask2), NR_CPUS)
+#define cpus_empty(mask)	     mask_empty(mask, NR_CPUS)
+#define cpus_full(mask)		     mask_full((mask), NR_CPUS)
+#define cpus_weight(mask)	     mask_weight((mask), NR_CPUS)
+#define cpus_shift_right(dst, src, n)	\
+			mask_shift_right((dst), (src), (n), NR_CPUS)
+#define cpus_shift_left(dst, src, n)	\
+			mask_shift_left((dst), (src), (n), NR_CPUS)
+#define first_cpu(mask)		     mask_first((mask), NR_CPUS)
+#define next_cpu(cpu, mask)	     mask_next((cpu), (mask), NR_CPUS)
+#define cpumask_of_cpu(cpu)	     mask_of_bit((cpu), _unused_cpumask_arg_)
+#if NR_CPUS <= BITS_PER_LONG
+#define CPU_MASK_ALL		     MASK_ALL1(NR_CPUS)
 #else
-#define	cpu_online_map			cpumask_of_cpu(0)
-#define	cpu_possible_map		cpumask_of_cpu(0)
-#define num_online_cpus()		1
-#define num_possible_cpus()		1
-#define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
-#define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
-
-#define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
-#define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define CPU_MASK_ALL		     MASK_ALL2(NR_CPUS)
 #endif
+#define CPU_MASK_NONE		     MASK_NONE(NR_CPUS)
+#define cpus_addr(mask)		     mask_addr(mask)
+#define cpumask_scnprintf(buf, len, mask) \
+			mask_scnprintf((buf), (len), (mask), NR_CPUS)
+#define cpumask_parse(ubuf, ulen, mask) \
+			mask_parse((ubuf), (ulen), (mask), NR_CPUS)
+
+/*
+ * The following particular system cpumasks and operations
+ * on them manage all (possible) and online cpus.
+ */
+
+#ifdef CONFIG_SMP
 
-#define cpumask_scnprintf(buf, buflen, map)				\
-	bitmap_scnprintf(buf, buflen, cpus_addr(map), NR_CPUS)
+extern cpumask_t cpu_online_map;
+extern cpumask_t cpu_possible_map;
 
-#define cpumask_parse(buf, buflen, map)					\
-	bitmap_parse(buf, buflen, cpus_addr(map), NR_CPUS)
+#define num_online_cpus()	     cpus_weight(cpu_online_map)
+#define num_possible_cpus()	     cpus_weight(cpu_possible_map)
+#define cpu_online(cpu)		     cpu_isset((cpu), cpu_online_map)
+#define cpu_possible(cpu)	     cpu_isset((cpu), cpu_possible_map)
+#define cpu_set_online(cpu)	     cpu_set((cpu), cpu_online_map)
+#define cpu_set_offline(cpu)	     cpu_clear((cpu), cpu_online_map)
+
+#define any_online_cpu(mask)			\
+({						\
+	cpumask_t m;				\
+	cpus_and(m, mask, cpu_online_map);	\
+	first_cpu(m);				\
+})
+
+#define for_each_cpu_mask(cpu, mask)		\
+	for (cpu = first_cpu(mask);		\
+		cpu < NR_CPUS;			\
+		cpu = next_cpu(cpu, mask))
+
+#else /* !CONFIG_SMP */
+
+#define	cpu_online_map		     cpumask_of_cpu(0)
+#define	cpu_possible_map	     cpumask_of_cpu(0)
+
+#define num_online_cpus()	     1
+#define num_possible_cpus()	     1
+#define cpu_online(cpu)		     ({ BUG_ON((cpu) != 0); 1; })
+#define cpu_possible(cpu)	     ({ BUG_ON((cpu) != 0); 1; })
+#define cpu_set_online(cpu)	     ({ BUG_ON((cpu) != 0); })
+#define cpu_set_offline(cpu)	     ({ BUG(); })
+
+#define any_online_cpu(mask)	     0
+
+#define for_each_cpu_mask(cpu, mask) for (cpu = 0; cpu < 1; cpu++)
+
+#endif /* CONFIG_SMP */
+
+#define for_each_cpu(cpu)	     \
+			for_each_cpu_mask(cpu, cpu_possible_map)
+#define for_each_online_cpu(cpu)     \
+			for_each_cpu_mask(cpu, cpu_online_map)
+
+/* Begin obsolete cpumask operator emulation */
+#define cpu_isset_const(a,b) cpu_isset(a,b)
+#define cpumask_const_t cpumask_t
+#define cpus_coerce(m) (cpus_addr(m)[0])
+#define cpus_coerce_const cpus_coerce
+#define cpus_promote(x) ({ cpumask_t m; m._m[0] = x; m; })
+#define cpus_weight_const cpus_weight
+#define first_cpu_const first_cpu
+#define mk_cpumask_const(x) x
+#define next_cpu_const next_cpu
+/* End of obsolete cpumask operator emulation */
 
 #endif /* __LINUX_CPUMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
