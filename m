Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbUC3CGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 21:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUC3CGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 21:06:54 -0500
Received: from holomorphy.com ([207.189.100.168]:7583 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263490AbUC3CGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 21:06:50 -0500
Date: Mon, 29 Mar 2004 18:06:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-ID: <20040330020637.GA791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com
References: <20040329041249.65d365a1.pj@sgi.com> <1080601576.6742.43.camel@arrakis> <20040329235233.GV791@holomorphy.com> <20040329154330.445e10e2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329154330.445e10e2.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:43:30PM -0800, Paul Jackson wrote:
> My thinking on when to worry about the unused bits, and when not to, is
> thus.
> For the lib/bitmap.c code, it seems that the existing standard, followed
> by everything except bitmap_complement(), is to not set any unused bits
> (at least when called with correct arguments in range), but to always
> filter them out when testing for some Boolean condition or scalar result
> (weight).

No, the existing standard is to treat the unused bits as "don't cares".
The difference codewise between the two choices is rather small anyway,
but if you want to _change_ the invariant to be something else, e.g.
insist that they always be zeroes, announce this up-front and make the
change independently of API. The "bugs" you're speaking of are nowhere
near the vicinity of bitmap_complement(). They exist only in the
arithmetic implementation and are fixed in a minimal impact way in the
following patch, which maintains current invariants.

The impact of changing this invariant is likely more relevant to
sensitivity to garbage leaking in through initializations of dynamically
allocated cpumasks than the implementations of the runtime operations.

In any event, best to fix the bug in the current code now and let the
cleanups go in after. akpm, this is needed for mainline.


-- wli


Index: mm5-2.6.5-rc2/include/asm-generic/cpumask_arith.h
===================================================================
--- mm5-2.6.5-rc2.orig/include/asm-generic/cpumask_arith.h	2004-03-19 16:11:33.000000000 -0800
+++ mm5-2.6.5-rc2/include/asm-generic/cpumask_arith.h	2004-03-29 17:58:25.000000000 -0800
@@ -6,6 +6,12 @@
  * to contain the whole cpu bitmap.
  */
 
+#if NR_CPUS % BITS_PER_LONG
+#define __CPU_VALID_MASK__		(~((1UL<< (NR_CPUS%BITS_PER_LONG) - 1))
+#else
+#define __CPU_VALID_MASK__		(~0UL)
+#endif
+
 #define cpu_set(cpu, map)		set_bit(cpu, &(map))
 #define cpu_clear(cpu, map)		clear_bit(cpu, &(map))
 #define cpu_isset(cpu, map)		test_bit(cpu, &(map))
@@ -15,14 +21,14 @@
 #define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
 #define cpus_clear(map)			do { map = 0; } while (0)
 #define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
+#define cpus_equal(x, y)		(!(((x) ^ (y)) & __CPU_VALID_MASK__))
+#define cpus_empty(map)			(!((map) & __CPU_VALID_MASK__))
 #define cpus_addr(map)			(&(map))
 
 #if BITS_PER_LONG == 32
-#define cpus_weight(map)		hweight32(map)
+#define cpus_weight(map)		hweight32((map) & __CPU_VALID_MASK__)
 #elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
+#define cpus_weight(map)		hweight64((map) & __CPU_VALID_MASK__)
 #endif
 
 #define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
@@ -39,7 +45,7 @@
 #define CPU_MASK_NONE	((cpumask_t)0)
 
 /* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
+#define cpus_coerce(map)		((map) & __CPU_VALID_MASK__)
 #define cpus_promote(map)		({ map; })
 #define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
 
