Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUCXEiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUCXEiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:38:16 -0500
Received: from holomorphy.com ([207.189.100.168]:43394 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263001AbUCXEiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:38:04 -0500
Date: Tue, 23 Mar 2004 20:37:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-ID: <20040324043755.GD791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com
References: <1079651082.8149.175.camel@arrakis> <20040322230850.1d8f26dc.pj@sgi.com> <20040323101323.GD2045@holomorphy.com> <20040323133650.2044fd8f.pj@sgi.com> <20040324020357.GC791@holomorphy.com> <20040323201101.3427494c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323201101.3427494c.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Any idea where this bogon might be?

On Tue, Mar 23, 2004 at 08:11:01PM -0800, Paul Jackson wrote:
> Unless I'm missing something (quite possible), the following would
> expose the complement operators setting of high unused bits.
>     You have 32 bit unsigned longs and NR_CPUS == 24, you complement
>     some cpumask, and you then ask if it is empty, or ask if it is
>     equal to another cpumask that differs only in the unused
>     high byte, or ask its Hamming weight?
> The arithmetic cpumask ops don't mask off the unused bits above NR_CPUS.
> This might never be noticed, because cpumask_complement is the only op
> that sets these unused bits, the complement op is very rarely used, and
> none of its current uses can lead to the above bugs that I see offhand.

It's supposed to do this. bitmap_weight() masks off the trailing bits to
filter out "don't cares" from whole-word ops. Everything else operates
bitwise. Something like the following will keep the bits clear as you
wish, since apparently the more simplistic single-word ops aren't obeying
this. It's likely possible to better this by exploiting some invariants;
feel free improve on it.


-- wli


Index: pgcl-2.6.5-rc2/include/asm-generic/cpumask_arith.h
===================================================================
--- pgcl-2.6.5-rc2.orig/include/asm-generic/cpumask_arith.h	2004-03-19 16:11:33.000000000 -0800
+++ pgcl-2.6.5-rc2/include/asm-generic/cpumask_arith.h	2004-03-23 20:34:54.000000000 -0800
@@ -6,6 +6,12 @@
  * to contain the whole cpu bitmap.
  */
 
+#if NR_CPUS % BITS_PER_LONG
+#define __CPU_MASK_VALID_BITS__		((1UL << (NR_CPUS % BITS_PER_LONG)) - 1)
+#else
+#define __CPU_MASK_VALID_BITS__		(~0UL)
+#endif
+
 #define cpu_set(cpu, map)		set_bit(cpu, &(map))
 #define cpu_clear(cpu, map)		clear_bit(cpu, &(map))
 #define cpu_isset(cpu, map)		test_bit(cpu, &(map))
@@ -14,15 +20,15 @@
 #define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
 #define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
 #define cpus_clear(map)			do { map = 0; } while (0)
-#define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
+#define cpus_complement(map)		do { map = ~(map) & __CPU_MASK_VALID_BITS__; } while (0)
+#define cpus_equal(map1, map2)		(!(((map1) ^ (map2)) & __CPU_MASK_VALID_BITS__))
+#define cpus_empty(map)			(!((map) & __CPU_MASK_VALID_BITS__))
 #define cpus_addr(map)			(&(map))
 
 #if BITS_PER_LONG == 32
-#define cpus_weight(map)		hweight32(map)
+#define cpus_weight(map)		hweight32((map) & __CPU_MASK_VALID_BITS__)
 #elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
+#define cpus_weight(map)		hweight64((map) & __CPU_MASK_VALID_BITS__)
 #endif
 
 #define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
@@ -39,11 +45,13 @@
 #define CPU_MASK_NONE	((cpumask_t)0)
 
 /* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
+#define cpus_coerce(map)		((unsigned long)(map) & __CPU_MASK_VALID_BITS__)
 #define cpus_promote(map)		({ map; })
 #define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
 
 #define first_cpu(map)			__ffs(map)
 #define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
 
+#undef __CPU_MASK_VALID_BITS__
+
 #endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
