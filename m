Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUDABGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUDABGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:06:50 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:50904 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261763AbUDABGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:06:44 -0500
Subject: Re: [PATCH] mask ADT: replace cpumask_t implementation [3/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040329041256.0f27e8c4.pj@sgi.com>
References: <20040329041256.0f27e8c4.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-8t6gt9ir2/ZepLjm0v7H"
Organization: IBM LTC
Message-Id: <1080781547.9787.55.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 31 Mar 2004 17:05:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8t6gt9ir2/ZepLjm0v7H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-29 at 04:12, Paul Jackson wrote:
> Patch_3_of_22 - Rework cpumasks to use new mask ADT
> 	Removes many old include/asm-<arch> and asm-generic cpumask files
> 	Add intersects, subset, xor and andnot operators.
> 	Provides temporary emulators for obsolete const, promote, coerce
> 	Presents entire cpumask API clearly in single cpumask.h file

Paul,
	Some changes to include/linux/cpumask.h:

1) You didn't provide a set of cpu_set_online/offline() macros.  No one
is using these, but it may be a nice thing to have all the places that
are *writing* to cpu_online_map do it through a macro.  If nothing else,
it makes cpu_online_map & node_online_map accessed similarly.

2) Dropped #include <linux/config.h>.  The very next include
(linux/threads.h) includes this file.

3) Indented all the cpu_* and cpus_* macros.  Massively more readable.

4) Made sure any macro call with more than 1 argument had its arguments
wrapped in parens.  It seemed like you were a bit inconsistent as to
whether or not the arguments to macros got parens.

5) Moved for_each_cpu() & for_each_online_cpu() definitions outside the
#ifdef CONFIG_SMP, because they are identical for the SMP/UP cases.

Cheers!

-Matt

--=-8t6gt9ir2/ZepLjm0v7H
Content-Disposition: attachment; filename=cpumask_h-mcd.patch
Content-Type: text/x-patch; name=cpumask_h-mcd.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-pj_nodemask/include/linux/cpumask.h linux-2.6.4-cpumask_h-mcd/include/linux/cpumask.h
--- linux-2.6.4-pj_nodemask/include/linux/cpumask.h	Tue Mar 30 17:04:27 2004
+++ linux-2.6.4-cpumask_h-mcd/include/linux/cpumask.h	Wed Mar 31 16:21:46 2004
@@ -51,6 +51,8 @@
  * int num_possible_cpus()		Number of all possible CPUs
  * int cpu_online(cpu)			Is some cpu < NR_CPUS online?
  * int cpu_possible(cpu)		Is some cpu < NR_CPUS possible?
+ * void cpu_set_online(cpu)		set cpu in cpu_online_map
+ * void cpu_set_offline(cpu)		clear cpu in cpu_online_map
  * int any_online_cpu(mask)		First online cpu in mask
  *
  * for_each_cpu_mask(cpu, mask)		for-loop cpu over mask
@@ -58,45 +60,44 @@
  * for_each_online_cpu(cpu)		for-loop cpu over cpu_online_map
  */
 
-#include <linux/config.h>
-#include <linux/mask.h>
 #include <linux/threads.h>
+#include <linux/mask.h>
 #include <asm/bug.h>
 
 typedef __mask(NR_CPUS) cpumask_t;
 extern cpumask_t _unused_cpumask_arg_;
 
-#define cpu_set(cpu, mask) mask_setbit((cpu), (mask))
-#define cpu_clear(cpu, mask) mask_clearbit((cpu), (mask))
-#define cpus_setall(mask) mask_setall(mask, NR_CPUS)
-#define cpus_clear(mask) mask_clearall(mask)
-#define cpu_isset(cpu, mask) mask_isset((cpu), (mask))
-#define cpu_test_and_set(cpu, mask) mask_test_and_set((cpu), (mask))
-#define cpus_and(dst, src1, src2) mask_and((dst), (src1), (src2))
-#define cpus_or(dst, src1, src2) mask_or((dst), (src1), (src2))
-#define cpus_xor(dst, src1, src2) mask_xor((dst), (src1), (src2))
-#define cpus_andnot(dst, src1, src2) mask_andnot((dst), (src1), (src2))
-#define cpus_complement(dst, src) mask_complement((dst), (src), NR_CPUS)
-#define cpus_equal(mask1, mask2) mask_equal((mask1), (mask2))
-#define cpus_intersects(mask1, mask2) mask_intersects(mask1, mask2)
-#define cpus_subset(mask1, mask2) mask_subset(mask1, mask2)
-#define cpus_empty(mask) mask_empty(mask)
-#define cpus_full(mask) mask_full(mask, NR_CPUS)
-#define cpus_weight(mask) mask_weight(mask, NR_CPUS)
-#define cpus_shift_right(dst, src, n) \
+#define cpu_set(cpu, mask)		mask_setbit((cpu), (mask))
+#define cpu_clear(cpu, mask)		mask_clearbit((cpu), (mask))
+#define cpus_setall(mask)		mask_setall((mask), NR_CPUS)
+#define cpus_clear(mask)		mask_clearall(mask)
+#define cpu_isset(cpu, mask)		mask_isset((cpu), (mask))
+#define cpu_test_and_set(cpu, mask)	mask_test_and_set((cpu), (mask))
+#define cpus_and(dst, src1, src2)	mask_and((dst), (src1), (src2))
+#define cpus_or(dst, src1, src2)	mask_or((dst), (src1), (src2))
+#define cpus_xor(dst, src1, src2)	mask_xor((dst), (src1), (src2))
+#define cpus_andnot(dst, src1, src2)	mask_andnot((dst), (src1), (src2))
+#define cpus_complement(dst, src)	mask_complement((dst), (src), NR_CPUS)
+#define cpus_equal(mask1, mask2)	mask_equal((mask1), (mask2))
+#define cpus_intersects(mask1, mask2)	mask_intersects((mask1), (mask2))
+#define cpus_subset(mask1, mask2)	mask_subset((mask1), (mask2))
+#define cpus_empty(mask)		mask_empty(mask)
+#define cpus_full(mask)			mask_full((mask), NR_CPUS)
+#define cpus_weight(mask)		mask_weight((mask), NR_CPUS)
+#define cpus_shift_right(dst, src, n)	\
 			mask_shift_right((dst), (src), (n), NR_CPUS)
-#define cpus_shift_left(dst, src, n) \
+#define cpus_shift_left(dst, src, n)	\
 			mask_shift_left((dst), (src), (n), NR_CPUS)
-#define first_cpu(mask) mask_first(mask, NR_CPUS)
-#define next_cpu(cpu, mask) mask_next(cpu, mask, NR_CPUS)
-#define cpumask_of_cpu(cpu) mask_of_bit((cpu), _unused_cpumask_arg_)
-#define CPU_MASK_ALL MASK_ALL(NR_CPUS)
-#define CPU_MASK_NONE MASK_NONE(NR_CPUS)
-#define cpus_raw(mask) mask_raw(mask)
+#define first_cpu(mask)			mask_first((mask), NR_CPUS)
+#define next_cpu(cpu, mask)		mask_next((cpu), (mask), NR_CPUS)
+#define cpumask_of_cpu(cpu)		mask_of_bit((cpu), _unused_cpumask_arg_)
+#define CPU_MASK_ALL			MASK_ALL(NR_CPUS)
+#define CPU_MASK_NONE			MASK_NONE(NR_CPUS)
+#define cpus_raw(mask)			mask_raw(mask)
 #define cpumask_scnprintf(buf, len, mask) \
-			mask_scnprintf(buf, len, mask, NR_CPUS)
+			mask_scnprintf((buf), (len), (mask), NR_CPUS)
 #define cpumask_parse(ubuf, ulen, mask) \
-			mask_parse(ubuf, ulen, mask, NR_CPUS)
+			mask_parse((ubuf), (ulen), (mask), NR_CPUS)
 
 /*
  * The following particular system cpumasks and operations
@@ -110,8 +111,10 @@ extern cpumask_t cpu_possible_map;
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define num_possible_cpus()		cpus_weight(cpu_possible_map)
-#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
+#define cpu_online(cpu)			cpu_isset((cpu), cpu_online_map)
+#define cpu_possible(cpu)		cpu_isset((cpu), cpu_possible_map)
+#define cpu_set_online(cpu)		cpu_set((cpu), cpu_online_map)
+#define cpu_set_offline(cpu)		cpu_clear((cpu), cpu_online_map)
 
 #define any_online_cpu(mask)			\
 ({						\
@@ -125,10 +128,7 @@ extern cpumask_t cpu_possible_map;
 		cpu < NR_CPUS;			\
 		cpu = next_cpu(cpu, mask))
 
-#define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
-#define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
-
-#else
+#else /* !CONFIG_SMP */
 
 #define	cpu_online_map			cpumask_of_cpu(0)
 #define	cpu_possible_map		cpumask_of_cpu(0)
@@ -137,14 +137,18 @@ extern cpumask_t cpu_possible_map;
 #define num_possible_cpus()		1
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
+#define cpu_set_online(cpu)		({ BUG_ON((cpu) != 0); })
+#define cpu_set_offline(cpu)		({ BUG(); })
 
 #define any_online_cpu(mask)		0
 
-#define for_each_cpu_mask(cpu, mask) for (cpu = 0; cpu < 1; cpu++)
+#define for_each_cpu_mask(cpu, mask)	for (cpu = 0; cpu < 1; cpu++)
 
-#define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
-#define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#endif /* CONFIG_SMP */
 
-#endif
+#define for_each_cpu(cpu)		\
+			for_each_cpu_mask(cpu, cpu_possible_map)
+#define for_each_online_cpu(cpu)	\
+			for_each_cpu_mask(cpu, cpu_online_map)
 
 #endif /* __LINUX_CPUMASK_H */

--=-8t6gt9ir2/ZepLjm0v7H--

