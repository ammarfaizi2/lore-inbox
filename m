Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265596AbUFCR07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUFCR07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUFCRXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:23:00 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:53983 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264367AbUFCRLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:11:47 -0400
Date: Thu, 3 Jun 2004 10:10:10 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603101010.4b15734a.pj@sgi.com>
In-Reply-To: <20040603094339.03ddfd42.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask 5/10 rewrite cpumask.h - single bitmap based implementation

	Major rewrite of cpumask to use a single implementation,
	as a struct-wrapped bitmap.

	This patch leaves some 26 include/asm-*/cpumask*.h
	header files orphaned - to be removed next patch.

	Some nine cpumask macros for const variants and to
	coerce and promote between an unsigned long and a
	cpumask are obsolete.  Simple emulation wrappers are
	provided in this patch for these obsolete macros,
	which can be removed once each of the 3 archs (i386,
	ppc64, x86_64) using them are recoded in follow-on
	patches to not need them.

	The CPU_MASK_ALL macro now avoids leaving possible
	garbage one bits in any unused portion of the high word.

	An inproved comment lists all available operators, for
	convenient browsing.

 arch/sparc64/kernel/irq.c |    6 
 include/linux/cpumask.h   |  409 +++++++++++++++++++++--
 kernel/rcupdate.c         |    7 
 kernel/sched.c            |    5 
 4 files changed, 387 insertions(+), 40 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/include/linux/cpumask.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/linux/cpumask.h	2004-06-03 05:56:00.000000000 -0700
+++ 2.6.7-rc2-mm2/include/linux/cpumask.h	2004-06-03 07:04:31.000000000 -0700
@@ -1,52 +1,379 @@
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
+ *
+ * Subtlety:
+ * 1) The 'type-checked' form of cpu_isset() causes gcc (3.3.2, anyway)
+ *    to generate slightly worse code.  Note for example the additional
+ *    40 lines of assembly code compiling the "for each possible cpu"
+ *    loops buried in the disk_stat_read() macros calls when compiling
+ *    drivers/block/genhd.c (arch i386, CONFIG_SMP=y).  So use a simple
+ *    one-line #define for cpu_isset(), instead of wrapping an inline
+ *    inside a macro, the way we do the other calls.
+ */
+
 #include <linux/threads.h>
 #include <linux/bitmap.h>
-#include <asm/cpumask.h>
 #include <asm/bug.h>
 
-#ifdef CONFIG_SMP
-
-extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
-
-#define num_online_cpus()		cpus_weight(cpu_online_map)
-#define num_possible_cpus()		cpus_weight(cpu_possible_map)
-
-#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
+typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
+extern cpumask_t _unused_cpumask_arg_;
 
-#define for_each_cpu_mask(cpu, mask)					\
-	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
-		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu, mk_cpumask_const(mask)))
+#define cpu_set(cpu, dst) __cpu_set((cpu), &(dst))
+static inline void __cpu_set(int cpu, volatile cpumask_t *dstp)
+{
+	set_bit(cpu, dstp->bits);
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
+	bitmap_zero(dstp->bits, nbits);
+}
+
+/* No static inline type checking - see Subtlety (1) above. */
+#define cpu_isset(cpu, cpumask) test_bit((cpu), (cpumask).bits)
+
+#define cpu_test_and_set(cpu, cpumask) __cpu_test_and_set((cpu), &(cpumask))
+static inline int __cpu_test_and_set(int cpu, cpumask_t *addr)
+{
+	return test_and_set_bit(cpu, addr->bits);
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
+
+#define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
+static inline int __next_cpu(int n, cpumask_t *srcp, int nbits)
+{
+	return find_next_bit(srcp->bits, nbits, n+1);
+}
+
+#define cpumask_of_cpu(cpu)						\
+({									\
+	typeof(_unused_cpumask_arg_) m;					\
+	if (sizeof(m) == sizeof(unsigned long)) {			\
+		m.bits[0] = 1UL<<(cpu);					\
+	} else {							\
+		cpus_clear(m);						\
+		cpu_set((cpu), m);					\
+	}								\
+	m;								\
+})
+
+#define CPU_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(NR_CPUS)
+
+#if NR_CPUS <= BITS_PER_LONG
+
+#define CPU_MASK_ALL							\
+((cpumask_t) { {							\
+	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
+} })
 
-#define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
-#define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
 #else
-#define	cpu_online_map			cpumask_of_cpu(0)
-#define	cpu_possible_map		cpumask_of_cpu(0)
 
-#define num_online_cpus()		1
-#define num_possible_cpus()		1
+#define CPU_MASK_ALL							\
+((cpumask_t) { {							\
+	[0 ... BITS_TO_LONGS(NR_CPUS)-2] = ~0UL,			\
+	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
+} })
 
-#define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
-#define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
-
-#define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
-#define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #endif
 
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
+#if NR_CPUS > 1
+#define for_each_cpu_mask(cpu, mask)		\
+	for ((cpu) = first_cpu(mask);		\
+		(cpu) < NR_CPUS;		\
+		(cpu) = next_cpu((cpu), (mask)))
+#else /* NR_CPUS == 1 */
+#define for_each_cpu_mask(cpu, mask) for ((cpu) = 0; (cpu) < 1; (cpu)++)
+#endif /* NR_CPUS */
+
+/*
+ * The following particular system cpumasks and operations manage
+ * possible, present and online cpus.  Each of them is a fixed size
+ * bitmap of size NR_CPUS.
+ *
+ *  #ifdef CONFIG_HOTPLUG_CPU
+ *     cpu_possible_map - all NR_CPUS bits set
+ *     cpu_present_map  - has bit 'cpu' set iff cpu is populated
+ *     cpu_online_map   - has bit 'cpu' set iff cpu available to scheduler
+ *  #else
+ *     cpu_possible_map - has bit 'cpu' set iff cpu is populated
+ *     cpu_present_map  - copy of cpu_possible_map
+ *     cpu_online_map   - has bit 'cpu' set iff cpu available to scheduler
+ *  #endif
+ *
+ *  In either case, NR_CPUS is fixed at compile time, as the static
+ *  size of these bitmaps.  The cpu_possible_map is fixed at boot
+ *  time, as the set of CPU id's that it is possible might ever
+ *  be plugged in at anytime during the life of that system boot.
+ *  The cpu_present_map is dynamic(*), representing which CPUs
+ *  are currently plugged in.  And cpu_online_map is the dynamic
+ *  subset of cpu_present_map, indicating those CPUs available
+ *  for scheduling.
+ *
+ *  If HOTPLUG is enabled, then cpu_possible_map is forced to have
+ *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
+ *  ACPI reports present at boot.
+ *
+ *  If HOTPLUG is enabled, then cpu_present_map varies dynamically,
+ *  depending on what ACPI reports as currently plugged in, otherwise
+ *  cpu_present_map is just a copy of cpu_possible_map.
+ *
+ *  (*) Well, cpu_present_map is dynamic in the hotplug case.  If not
+ *      hotplug, it's a copy of cpu_possible_map, hence fixed at boot.
+ *
+ * Subtleties:
+ * 1) UP arch's (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
+ *    assumption that their single CPU is online.  The UP
+ *    cpu_{online,possible,present}_maps are placebos.  Changing them
+ *    will have no useful affect on the following num_*_cpus()
+ *    and cpu_*() macros in the UP case.  This ugliness is a UP
+ *    optimization - don't waste any instructions or memory references
+ *    asking if you're online or how many CPUs there are if there is
+ *    only one CPU.
+ * 2) Most SMP arch's #define some of these maps to be some
+ *    other map specific to that arch.  Therefore, the following
+ *    must be #define macros, not inlines.  To see why, examine
+ *    the assembly code produced by the following.  Note that
+ *    set1() writes phys_x_map, but set2() writes x_map:
+ *        int x_map, phys_x_map;
+ *        #define set1(a) x_map = a
+ *        inline void set2(int a) { x_map = a; }
+ *        #define x_map phys_x_map
+ *        main(){ set1(3); set2(5); }
+ */
+
+extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_present_map;
-#define num_present_cpus()		cpus_weight(cpu_present_map)
-#define cpu_present(cpu)		cpu_isset(cpu, cpu_present_map)
-#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
 
-#define cpumask_scnprintf(buf, buflen, map)				\
-	bitmap_scnprintf(buf, buflen, cpus_addr(map), NR_CPUS)
+#if NR_CPUS > 1
+#define num_online_cpus()    cpus_weight(cpu_online_map)
+#define num_possible_cpus()  cpus_weight(cpu_possible_map)
+#define num_present_cpus()   cpus_weight(cpu_present_map)
+#define cpu_online(cpu)      cpu_isset((cpu), cpu_online_map)
+#define cpu_possible(cpu)    cpu_isset((cpu), cpu_possible_map)
+#define cpu_present(cpu)     cpu_isset((cpu), cpu_present_map)
+#else
+#define num_online_cpus()    1
+#define num_possible_cpus()  1
+#define num_present_cpus()   1
+#define cpu_online(cpu)      ((cpu) == 0)
+#define cpu_possible(cpu)    ((cpu) == 0)
+#define cpu_present(cpu)     ((cpu) == 0)
+#endif
 
-#define cpumask_parse(buf, buflen, map)					\
-	bitmap_parse(buf, buflen, cpus_addr(map), NR_CPUS)
+#define any_online_cpu(mask)			\
+({						\
+	int cpu;				\
+	for_each_cpu_mask(cpu, (mask))		\
+		if (cpu_online(cpu))		\
+			break;			\
+	cpu;					\
+})
+
+#define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
+#define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
+#define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
+
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
Index: 2.6.7-rc2-mm2/kernel/sched.c
===================================================================
--- 2.6.7-rc2-mm2.orig/kernel/sched.c	2004-06-03 05:56:00.000000000 -0700
+++ 2.6.7-rc2-mm2/kernel/sched.c	2004-06-03 06:42:03.000000000 -0700
@@ -3119,6 +3119,11 @@
 cpumask_t cpu_present_map;
 EXPORT_SYMBOL(cpu_present_map);
 
+#ifndef CONFIG_SMP
+cpumask_t cpu_online_map = CPU_MASK_ALL;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
+#endif
+
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process
Index: 2.6.7-rc2-mm2/arch/sparc64/kernel/irq.c
===================================================================
--- 2.6.7-rc2-mm2.orig/arch/sparc64/kernel/irq.c	2004-06-03 05:42:56.000000000 -0700
+++ 2.6.7-rc2-mm2/arch/sparc64/kernel/irq.c	2004-06-03 05:57:13.000000000 -0700
@@ -687,9 +687,10 @@
 	 *    Just Do It.
 	 */
 	struct irqaction *ap = bp->irq_info;
-	cpumask_t cpu_mask = get_smpaff_in_irqaction(ap);
+	cpumask_t cpu_mask;
 	unsigned int buddy, ticks;
 
+	cpus_addr(cpu_mask)[0] = get_smpaff_in_irqaction(ap);
 	cpus_and(cpu_mask, cpu_mask, cpu_online_map);
 	if (cpus_empty(cpu_mask))
 		cpu_mask = cpu_online_map;
@@ -1206,9 +1207,10 @@
 {
 	struct ino_bucket *bp = ivector_table + (long)data;
 	struct irqaction *ap = bp->irq_info;
-	cpumask_t mask = get_smpaff_in_irqaction(ap);
+	cpumask_t mask;
 	int len;
 
+	cpus_addr(mask)[0] = get_smpaff_in_irqaction(ap);
 	if (cpus_empty(mask))
 		mask = cpu_online_map;
 
Index: 2.6.7-rc2-mm2/kernel/rcupdate.c
===================================================================
--- 2.6.7-rc2-mm2.orig/kernel/rcupdate.c	2004-06-03 05:46:28.000000000 -0700
+++ 2.6.7-rc2-mm2/kernel/rcupdate.c	2004-06-03 05:57:13.000000000 -0700
@@ -130,17 +130,14 @@
  */
 static void rcu_start_batch(int next_pending)
 {
-	cpumask_t active;
-
 	if (next_pending)
 		rcu_ctrlblk.next_pending = 1;
 
 	if (rcu_ctrlblk.next_pending &&
 			rcu_ctrlblk.completed == rcu_ctrlblk.cur) {
 		/* Can't change, since spin lock held. */
-		active = nohz_cpu_mask;
-		cpus_complement(active);
-		cpus_and(rcu_state.rcu_cpu_mask, cpu_online_map, active);
+		cpus_andnot(rcu_state.rcu_cpu_mask, cpu_online_map,
+							nohz_cpu_mask);
 		write_seqcount_begin(&rcu_ctrlblk.lock);
 		rcu_ctrlblk.next_pending = 0;
 		rcu_ctrlblk.cur++;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
