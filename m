Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUDHUjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUDHUe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:34:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:61413 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262427AbUDHTug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:50:36 -0400
Date: Thu, 8 Apr 2004 12:49:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 6b/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124909.749b16d5.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P6b.new_cpumask.h - Rewrite cpumask.h to use bitmap directly.

	Major rewrite of cpumask to use a single implementation,
	as a struct-wrapped bitmap.

	This patch leaves some 26 include/asm-*/cpumask*.h
	header files orphaned - to be removed next patch.

	Some nine cpumask macros for const variants and to
	coerce and promote between an unsigned long and a
	cpumask are obsolete.  Simple emulation wrappers are
	provided in this patch, which can be removed once each
	of the 3 archs (i386, ppc64, x86_64) using them are
	recoded in follow-on patches to not need them.

	The CPU_MASK_ALL macro now avoids leaving possible
	garbage one bits in any unused portion of the high word.

	An inproved comment lists all available operators, for
	convenient browsing.

Index: 2.6.5.bitmap/include/linux/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/cpumask.h	2004-04-08 09:39:25.000000000 -0700
+++ 2.6.5.bitmap/include/linux/cpumask.h	2004-04-08 09:39:29.000000000 -0700
@@ -1,44 +1,330 @@
 #ifndef __LINUX_CPUMASK_H
 #define __LINUX_CPUMASK_H
 
+/*
+ * Cpumasks provide a bitmap suitable for representing the
+ * set of CPU's in a system, one bit position per CPU number.
+ *
+ * See detailed comments in the file linux/bitmap.h describing the
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
 #include <linux/bitmap.h>
-#include <asm/cpumask.h>
 #include <asm/bug.h>
 
-#ifdef CONFIG_SMP
+typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
+extern cpumask_t _unused_cpumask_arg_;
 
-extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
+#define cpu_set(cpu, dst) __cpu_set((cpu), &(dst))
+static inline void __cpu_set(int cpu, volatile cpumask_t *dstp)
+{
+	if (cpu < NR_CPUS)
+		set_bit(cpu, dstp->bits);
+}
+
+#define cpu_clear(cpu, dst) __cpu_clear((cpu), &(dst))
+static inline void __cpu_clear(int cpu, volatile cpumask_t *dstp)
+{
+	clear_bit(cpu, dstp->bits);
+}
+
+#define cpus_setall(dst) __cpus_setall(&(dst), NR_CPUS)
+static inline void __cpus_setall(cpumask_t *dstp, int nbits)
+{
+	bitmap_fill(dstp->bits, nbits);
+}
+
+#define cpus_clear(dst) __cpus_clear(&(dst), NR_CPUS)
+static inline void __cpus_clear(cpumask_t *dstp, int nbits)
+{
+	bitmap_clear(dstp->bits, nbits);
+}
+
+#define cpu_isset(cpu, cpumask) __cpu_isset((cpu), &(cpumask))
+static inline int __cpu_isset(int cpu, const volatile cpumask_t *addr)
+{
+	return test_bit(cpu, addr->bits);
+}
+
+#define cpu_test_and_set(cpu, cpumask) __cpu_test_and_set((cpu), &(cpumask))
+static inline int __cpu_test_and_set(int cpu, cpumask_t *addr)
+{
+	if (cpu < NR_CPUS)
+		return test_and_set_bit(cpu, addr->bits);
+	else
+		return 0;
+}
+
+#define cpus_and(dst, src1, src2) __cpus_and(&(dst), &(src1), &(src2), NR_CPUS)
+static inline void __cpus_and(cpumask_t *dstp, cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_or(dst, src1, src2) __cpus_or(&(dst), &(src1), &(src2), NR_CPUS)
+static inline void __cpus_or(cpumask_t *dstp, cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_xor(dst, src1, src2) __cpus_xor(&(dst), &(src1), &(src2), NR_CPUS)
+static inline void __cpus_xor(cpumask_t *dstp, cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_andnot(dst, src1, src2) \
+				__cpus_andnot(&(dst), &(src1), &(src2), NR_CPUS)
+static inline void __cpus_andnot(cpumask_t *dstp, cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_complement(dst, src) __cpus_complement(&(dst), &(src), NR_CPUS)
+static inline void __cpus_complement(cpumask_t *dstp,
+					cpumask_t *srcp, int nbits)
+{
+	bitmap_complement(dstp->bits, srcp->bits, nbits);
+}
+
+#define cpus_equal(src1, src2) __cpus_equal(&(src1), &(src2), NR_CPUS)
+static inline int __cpus_equal(cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	return bitmap_equal(src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_intersects(src1, src2) __cpus_intersects(&(src1), &(src2), NR_CPUS)
+static inline int __cpus_intersects(cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_subset(src1, src2) __cpus_subset(&(src1), &(src2), NR_CPUS)
+static inline int __cpus_subset(cpumask_t *src1p,
+					cpumask_t *src2p, int nbits)
+{
+	return bitmap_subset(src1p->bits, src2p->bits, nbits);
+}
+
+#define cpus_empty(src) __cpus_empty(&(src), NR_CPUS)
+static inline int __cpus_empty(cpumask_t *srcp, int nbits)
+{
+	return bitmap_empty(srcp->bits, nbits);
+}
+
+#define cpus_full(cpumask) __cpus_full(&(cpumask), NR_CPUS)
+static inline int __cpus_full(cpumask_t *srcp, int nbits)
+{
+	return bitmap_full(srcp->bits, nbits);
+}
+
+#define cpus_weight(cpumask) __cpus_weight(&(cpumask), NR_CPUS)
+static inline int __cpus_weight(cpumask_t *srcp, int nbits)
+{
+	return bitmap_weight(srcp->bits, nbits);
+}
+
+#define cpus_shift_right(dst, src, n) \
+			__cpus_shift_right(&(dst), &(src), (n), NR_CPUS)
+static inline void __cpus_shift_right(cpumask_t *dstp,
+					cpumask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define cpus_shift_left(dst, src, n) \
+			__cpus_shift_left(&(dst), &(src), (n), NR_CPUS)
+static inline void __cpus_shift_left(cpumask_t *dstp,
+					cpumask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define first_cpu(src) __first_cpu(&(src), NR_CPUS)
+static inline int __first_cpu(cpumask_t *srcp, int nbits)
+{
+	return find_first_bit(srcp->bits, nbits);
+}
 
-#define num_online_cpus()		cpus_weight(cpu_online_map)
-#define num_possible_cpus()		cpus_weight(cpu_possible_map)
-#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
-
-#define for_each_cpu_mask(cpu, mask)					\
-	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
-		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu, mk_cpumask_const(mask)))
+#define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
+static inline int __next_cpu(int n, cpumask_t *srcp, int nbits)
+{
+	return find_next_bit(srcp->bits, nbits, n+1);
+}
+
+#define cpumask_of_cpu(cpu)						\
+({									\
+	typeof(_unused_cpumask_arg_) m;					\
+	int c = cpu;							\
+	if (sizeof(m) == sizeof(unsigned long)) {			\
+		if (c < NR_CPUS)					\
+			m.bits[0] = 1UL<<c;				\
+	} else {							\
+		cpus_clear(m);						\
+		cpu_set(c, m);						\
+	}								\
+	m;								\
+})
+
+#define CPU_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(NR_CPUS)
+
+#if NR_CPUS <= BITS_PER_LONG
+
+#define CPU_MASK_ALL							\
+{ {									\
+	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
+} }
 
-#define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
-#define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
 #else
-#define	cpu_online_map			cpumask_of_cpu(0)
-#define	cpu_possible_map		cpumask_of_cpu(0)
-#define num_online_cpus()		1
-#define num_possible_cpus()		1
-#define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
-#define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
-#define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
-#define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define CPU_MASK_ALL							\
+{ {									\
+	[0 ... BITS_TO_LONGS(NR_CPUS)-2] = ~0UL,			\
+	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
+} }
+
 #endif
 
-#define cpumask_scnprintf(buf, buflen, map)				\
-	bitmap_scnprintf(buf, buflen, cpus_addr(map), NR_CPUS)
+#define CPU_MASK_NONE							\
+{ {									\
+	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
+} }
+
+#define cpus_addr(src) ((src).bits)
+
+#define cpumask_scnprintf(buf, len, src) \
+			__cpumask_scnprintf((buf), (len), &(src), NR_CPUS)
+static inline int __cpumask_scnprintf(char *buf, int len,
+					cpumask_t *srcp, int nbits)
+{
+	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
+}
+
+#define cpumask_parse(ubuf, ulen, src) \
+			__cpumask_parse((ubuf), (ulen), &(src), NR_CPUS)
+static inline int __cpumask_parse(const char __user *buf, int len,
+					cpumask_t *srcp, int nbits)
+{
+	return bitmap_parse(buf, len, srcp->bits, nbits);
+}
+
+/*
+ * The following particular system cpumasks and operations
+ * on them manage all (possible) and online cpus.
+ */
+
+extern cpumask_t cpu_online_map;
+extern cpumask_t cpu_possible_map;
+
+#ifdef CONFIG_SMP
+
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
 
-#define cpumask_parse(buf, buflen, map)					\
-	bitmap_parse(buf, buflen, cpus_addr(map), NR_CPUS)
+/* Begin obsolete cpumask operator emulation */
+#define cpu_isset_const(a,b) cpu_isset(a,b)
+#define cpumask_const_t cpumask_t
+#define cpus_coerce(m) (cpus_addr(m)[0])
+#define cpus_coerce_const cpus_coerce
+#define cpus_promote(x) ({ cpumask_t m; m.bits[0] = x; m; })
+#define cpus_weight_const cpus_weight
+#define first_cpu_const first_cpu
+#define mk_cpumask_const(x) x
+#define next_cpu_const next_cpu
+/* End of obsolete cpumask operator emulation */
 
 #endif /* __LINUX_CPUMASK_H */
Index: 2.6.5.bitmap/kernel/sched.c
===================================================================
--- 2.6.5.bitmap.orig/kernel/sched.c	2004-04-08 09:39:25.000000000 -0700
+++ 2.6.5.bitmap/kernel/sched.c	2004-04-08 09:39:29.000000000 -0700
@@ -2349,6 +2349,11 @@
 	return retval;
 }
 
+#ifndef CONFIG_SMP
+cpumask_t cpu_online_map = CPU_MASK_ALL;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
+#endif
+
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
