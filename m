Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUDRC0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 22:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264100AbUDRC0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 22:26:42 -0400
Received: from holomorphy.com ([207.189.100.168]:33421 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264105AbUDRC0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 22:26:38 -0400
Date: Sat, 17 Apr 2004 19:26:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: cpumask_arith.h fixes
Message-ID: <20040418022638.GV743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So long as we're not using zeroed tail invariants, some equivalent of
the following is needed for cpumask_arith.h to function properly. This
patch addresses the following issues:

(1) cpus_equal() returns false negatives with nonzero tails
(2) cpus_empty() returns false negatives with nonzero tails
(3) cpus_weight() returns incorrect results with nonzero tails
(4) first_cpu() should check before doing __ffs(0); it's undefined
(5) cpus_shift_right() should not shift meaningless set bits from tails
	into the meaningful portion of the cpumask
(6) cpus_coerce() handing back nonzero tails to callers is poor form;
	they're in need of updates in general and it's likely they'll
	do unsafe bit twiddling inspecting tail bits.

I'm having enough trouble remembering what Paul Jackson's take on things
was to remember the relation of this to it (superseded by it if merged?
Possible if he starts zeroing tails). I think he reported the issue.


-- wli


Index: wli-2.6.5-mm6/include/asm-generic/cpumask_arith.h
===================================================================
--- wli-2.6.5-mm6.orig/include/asm-generic/cpumask_arith.h	2004-04-03 19:37:37.000000000 -0800
+++ wli-2.6.5-mm6/include/asm-generic/cpumask_arith.h	2004-04-17 19:11:53.000000000 -0700
@@ -15,17 +15,17 @@
 #define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
 #define cpus_clear(map)			do { map = 0; } while (0)
 #define cpus_complement(map)		do { map = ~(map); } while (0)
-#define cpus_equal(map1, map2)		((map1) == (map2))
-#define cpus_empty(map)			((map) == 0)
+#define cpus_equal(map1, map2)		(!(((map1) ^ (map2)) & CPU_MASK_ALL))
+#define cpus_empty(map)			(!((map) & CPU_MASK_ALL))
 #define cpus_addr(map)			(&(map))
 
 #if BITS_PER_LONG == 32
-#define cpus_weight(map)		hweight32(map)
+#define cpus_weight(map)		hweight32((map) & CPU_MASK_ALL)
 #elif BITS_PER_LONG == 64
-#define cpus_weight(map)		hweight64(map)
+#define cpus_weight(map)		hweight64((map) & CPU_MASK_ALL)
 #endif
 
-#define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
+#define cpus_shift_right(dst, src, n)	do { dst = ((src) >> (n)) & CPU_MASK_ALL; } while (0)
 #define cpus_shift_left(dst, src, n)	do { dst = (src) << (n); } while (0)
 
 #define any_online_cpu(map)			\
@@ -39,11 +39,15 @@
 #define CPU_MASK_NONE	((cpumask_t)0)
 
 /* only ever use this for things that are _never_ used on large boxen */
-#define cpus_coerce(map)		((unsigned long)(map))
+#define cpus_coerce(map)		((unsigned long)(map) & CPU_MASK_ALL)
 #define cpus_promote(map)		({ map; })
 #define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
 
-#define first_cpu(map)			__ffs(map)
 #define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
+#define first_cpu(map)						\
+({								\
+	cpumask_t __first_cpu_map__ = (map) & CPU_MASK_ALL;	\
+	__first_cpu_map__ ? __ffs(__first_cpu_map__) : NR_CPUS;	\
+})
 
 #endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
