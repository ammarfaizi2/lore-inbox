Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317804AbSFMTWP>; Thu, 13 Jun 2002 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSFMTWO>; Thu, 13 Jun 2002 15:22:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23797 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317803AbSFMTWD>; Thu, 13 Jun 2002 15:22:03 -0400
Subject: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: Robert Love <rml@mvista.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-5KjiHN/wK71Iv0oqtdyF"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jun 2002 12:21:58 -0700
Message-Id: <1023996118.4800.75.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5KjiHN/wK71Iv0oqtdyF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Attached patch provides SPARC64 support for the O(1) scheduler in
2.4-ac.  This is based off a 2.5 backport for my O(1) scheduler patches
by Thomas Duffy (i.e. give him the credit).

I do not know if any other architectures in 2.4-ac support the new
scheduler yet, but I will work on sending you the diffs as I get them or
do them...

Patch is against 2.4.19-pre10-ac2, please apply.

	Robert Love

--=-5KjiHN/wK71Iv0oqtdyF
Content-Disposition: attachment; filename=sched-O1-sparc64-rml-2.4.19-pre10-ac2-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-O1-sparc64-rml-2.4.19-pre10-ac2-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/entry.S linux/arch/spa=
rc64/kernel/entry.S
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/entry.S	Thu Jun  6 08:55:13 =
2002
+++ linux/arch/sparc64/kernel/entry.S	Thu Jun 13 12:09:51 2002
@@ -1436,8 +1436,10 @@
 		 * %o7 for us.  Check performance counter stuff too.
 		 */
 		andn		%o7, SPARC_FLAG_NEWCHILD, %l0
+#if CONFIG_SMP
 		mov		%g5, %o0	/* 'prev' */
 		call		schedule_tail
+#endif
 		 stb		%l0, [%g6 + AOFF_task_thread + AOFF_thread_flags]
 		andcc		%l0, SPARC_FLAG_PERFCTR, %g0
 		be,pt		%icc, 1f
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/irq.c linux/arch/sparc=
64/kernel/irq.c
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/irq.c	Thu Jun  6 08:55:13 20=
02
+++ linux/arch/sparc64/kernel/irq.c	Thu Jun 13 12:09:51 2002
@@ -162,7 +162,7 @@
 		tid =3D ((tid & UPA_CONFIG_MID) << 9);
 		tid &=3D IMAP_TID_UPA;
 	} else {
-		tid =3D (starfire_translate(imap, current->processor) << 26);
+		tid =3D (starfire_translate(imap, smp_processor_id()) << 26);
 		tid &=3D IMAP_TID_UPA;
 	}
=20
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/process.c linux/arch/s=
parc64/kernel/process.c
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/process.c	Thu Jun  6 08:55:1=
3 2002
+++ linux/arch/sparc64/kernel/process.c	Thu Jun 13 12:09:51 2002
@@ -53,12 +53,8 @@
 		return -EPERM;
=20
 	/* endless idle loop with no priority at all */
-	current->nice =3D 20;
-	current->counter =3D -100;
-	init_idle();
-
 	for (;;) {
-		/* If current->need_resched is zero we should really
+		/* If current->word.need_resched is zero we should really
 		 * setup for a system wakup event and execute a shutdown
 		 * instruction.
 		 *
@@ -79,16 +75,12 @@
 /*
  * the idle loop on a UltraMultiPenguin...
  */
-#define idle_me_harder()	(cpu_data[current->processor].idle_volume +=3D 1)
-#define unidle_me()		(cpu_data[current->processor].idle_volume =3D 0)
+#define idle_me_harder()	(cpu_data[smp_processor_id()].idle_volume +=3D 1)
+#define unidle_me()		(cpu_data[smp_processor_id()].idle_volume =3D 0)
 int cpu_idle(void)
 {
-	current->nice =3D 20;
-	current->counter =3D -100;
-	init_idle();
-
 	while(1) {
-		if (current->need_resched !=3D 0) {
+		if (current->need_resched) {
 			unidle_me();
 			schedule();
 			check_pgt_cache();
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/rtrap.S linux/arch/spa=
rc64/kernel/rtrap.S
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/rtrap.S	Thu Jun  6 08:55:13 =
2002
+++ linux/arch/sparc64/kernel/rtrap.S	Thu Jun 13 12:09:51 2002
@@ -140,7 +140,7 @@
 		.align			64
 		.globl			rtrap_clr_l6, rtrap, irqsz_patchme, rtrap_xcall
 rtrap_clr_l6:	clr			%l6
-rtrap:		lduw			[%g6 + AOFF_task_processor], %l0
+rtrap:		lduw			[%g6 + AOFF_task_cpu], %l0
 		sethi			%hi(irq_stat), %l2	! &softirq_active
 		or			%l2, %lo(irq_stat), %l2	! &softirq_active
 irqsz_patchme:	sllx			%l0, 0, %l0
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/smp.c linux/arch/sparc=
64/kernel/smp.c
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/smp.c	Thu Jun  6 08:55:13 20=
02
+++ linux/arch/sparc64/kernel/smp.c	Thu Jun 13 12:09:51 2002
@@ -252,6 +252,8 @@
  */
 static struct task_struct *cpu_new_task =3D NULL;
=20
+static void smp_tune_scheduling(void);
+
 void __init smp_boot_cpus(void)
 {
 	int cpucount =3D 0, i;
@@ -259,10 +261,11 @@
 	printk("Entering UltraSMPenguin Mode...\n");
 	__sti();
 	smp_store_cpu_info(boot_cpu_id);
-	init_idle();
=20
-	if (linux_num_cpus =3D=3D 1)
+	if (linux_num_cpus =3D=3D 1) {
+		smp_tune_scheduling();
 		return;
+	}
=20
 	for (i =3D 0; i < NR_CPUS; i++) {
 		if (i =3D=3D boot_cpu_id)
@@ -278,16 +281,13 @@
 			int no;
=20
 			prom_printf("Starting CPU %d... ", i);
-			kernel_thread(start_secondary, NULL, CLONE_PID);
+			kernel_thread(NULL, NULL, CLONE_PID);
 			cpucount++;
=20
 			p =3D init_task.prev_task;
-			init_tasks[cpucount] =3D p;
=20
-			p->processor =3D i;
-			p->cpus_runnable =3D 1UL << i; /* we schedule the first task manually *=
/
+			init_idle(p, i);
=20
-			del_from_runqueue(p);
 			unhash_process(p);
=20
 			callin_flag =3D 0;
@@ -338,6 +338,12 @@
 		smp_activated =3D 1;
 		smp_num_cpus =3D cpucount + 1;
 	}
+
+	/* We want to run this with all the other cpus spinning
+	* in the kernel.
+	*/
+	smp_tune_scheduling();
+
 	smp_processors_ready =3D 1;
 	membar("#StoreStore | #StoreLoad");
 }
@@ -1148,7 +1154,6 @@
 	__cpu_number_map[boot_cpu_id] =3D 0;
 	prom_cpu_nodes[boot_cpu_id] =3D linux_cpus[0].prom_node;
 	__cpu_logical_map[0] =3D boot_cpu_id;
-	current->processor =3D boot_cpu_id;
 	prof_counter(boot_cpu_id) =3D prof_multiplier(boot_cpu_id) =3D 1;
 }
=20
@@ -1175,6 +1180,96 @@
 	return base;
 }
=20
+cycles_t cacheflush_time;
+unsigned long cache_decay_ticks;
+
+extern unsigned long cheetah_tune_scheduling(void);
+extern unsigned long timer_ticks_per_usec_quotient;
+
+static void __init smp_tune_scheduling(void)
+{
+	unsigned long orig_flush_base, flush_base, flags, *p;
+	unsigned int ecache_size, order;
+	cycles_t tick1, tick2, raw;
+
+	/* Approximate heuristic for SMP scheduling.  It is an
+	 * estimation of the time it takes to flush the L2 cache
+	 * on the local processor.
+	 *
+	 * The ia32 chooses to use the L1 cache flush time instead,
+	 * and I consider this complete nonsense.  The Ultra can service
+	 * a miss to the L1 with a hit to the L2 in 7 or 8 cycles, and
+	 * L2 misses are what create extra bus traffic (ie. the "cost"
+	 * of moving a process from one cpu to another).
+	 */
+	printk("SMP: Calibrating ecache flush... ");
+	if (tlb_type =3D=3D cheetah) {
+		cacheflush_time =3D cheetah_tune_scheduling();
+		goto report;
+	}
+
+	ecache_size =3D prom_getintdefault(linux_cpus[0].prom_node,
+					 "ecache-size", (512 * 1024));
+	if (ecache_size > (4 * 1024 * 1024))
+		ecache_size =3D (4 * 1024 * 1024);
+	orig_flush_base =3D flush_base =3D
+		__get_free_pages(GFP_KERNEL, order =3D get_order(ecache_size));
+
+	if (flush_base !=3D 0UL) {
+		__save_and_cli(flags);
+
+		/* Scan twice the size once just to get the TLB entries
+		 * loaded and make sure the second scan measures pure misses.
+		 */
+		for (p =3D (unsigned long *)flush_base;
+		     ((unsigned long)p) < (flush_base + (ecache_size<<1));
+		     p +=3D (64 / sizeof(unsigned long)))
+			*((volatile unsigned long *)p);
+
+		/* Now the real measurement. */
+		__asm__ __volatile__("
+		b,pt	%%xcc, 1f
+		 rd	%%tick, %0
+
+		.align	64
+1:		ldx	[%2 + 0x000], %%g1
+		ldx	[%2 + 0x040], %%g2
+		ldx	[%2 + 0x080], %%g3
+		ldx	[%2 + 0x0c0], %%g5
+		add	%2, 0x100, %2
+		cmp	%2, %4
+		bne,pt	%%xcc, 1b
+		 nop
+=09
+		rd	%%tick, %1"
+		: "=3D&r" (tick1), "=3D&r" (tick2), "=3D&r" (flush_base)
+		: "2" (flush_base), "r" (flush_base + ecache_size)
+		: "g1", "g2", "g3", "g5");
+
+		__restore_flags(flags);
+
+		raw =3D (tick2 - tick1);
+
+		/* Dampen it a little, considering two processes
+		 * sharing the cache and fitting.
+		 */
+		cacheflush_time =3D (raw - (raw >> 2));
+
+		free_pages(orig_flush_base, order);
+	} else {
+		cacheflush_time =3D ((ecache_size << 2) +
+				   (ecache_size << 1));
+	}
+report:
+	/* Convert cpu ticks to jiffie ticks. */
+	cache_decay_ticks =3D ((long)cacheflush_time * timer_ticks_per_usec_quoti=
ent);
+	cache_decay_ticks >>=3D 32UL;
+	cache_decay_ticks =3D (cache_decay_ticks * HZ) / 1000;
+
+	printk("Using heuristic of %ld cycles, %ld ticks.\n",
+	       cacheflush_time, cache_decay_ticks);
+}
+
 /* /proc/profile writes can call this, don't __init it please. */
 int setup_profiling_timer(unsigned int multiplier)
 {
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/trampoline.S linux/arc=
h/sparc64/kernel/trampoline.S
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/trampoline.S	Thu Jun  6 08:5=
5:13 2002
+++ linux/arch/sparc64/kernel/trampoline.S	Thu Jun 13 12:09:51 2002
@@ -253,7 +253,7 @@
 	wrpr		%o1, PSTATE_IG, %pstate
=20
 	/* Get our UPA MID. */
-	lduw		[%o2 + AOFF_task_processor], %g1
+	lduw		[%o2 + AOFF_task_cpu], %g1
 	sethi		%hi(cpu_data), %g5
 	or		%g5, %lo(cpu_data), %g5
=20
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/kernel/traps.c linux/arch/spa=
rc64/kernel/traps.c
--- linux-2.4.19-pre10-ac2/arch/sparc64/kernel/traps.c	Thu Jun  6 08:55:13 =
2002
+++ linux/arch/sparc64/kernel/traps.c	Thu Jun 13 12:09:51 2002
@@ -1,4 +1,4 @@
-/* $Id: traps.c,v 1.82 2001/11/18 00:12:56 davem Exp $
+/* $Id: traps.c,v 1.84 2002/01/30 01:39:56 davem Exp $
  * arch/sparc64/kernel/traps.c
  *
  * Copyright (C) 1995,1997 David S. Miller (davem@caip.rutgers.edu)
@@ -527,6 +527,21 @@
 			       "i" (ASI_PHYS_USE_EC));
 }
=20
+#ifdef CONFIG_SMP
+unsigned long cheetah_tune_scheduling(void)
+{
+	unsigned long tick1, tick2, raw;
+
+	__asm__ __volatile__("rd %%tick, %0" : "=3Dr" (tick1));
+	cheetah_flush_ecache();
+	__asm__ __volatile__("rd %%tick, %0" : "=3Dr" (tick2));
+
+	raw =3D (tick2 - tick1);
+
+	return (raw - (raw >> 2));
+}
+#endif
+
 /* Unfortunately, the diagnostic access to the I-cache tags we need to
  * use to clear the thing interferes with I-cache coherency transactions.
  *
@@ -1660,13 +1675,16 @@
 	}
 }
=20
+/* Only invoked on boot processor. */
 void trap_init(void)
 {
-	/* Attach to the address space of init_task. */
+	/* Attach to the address space of init_task.  On SMP we
+	 * do this in smp.c:smp_callin for other cpus.
+	 */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm =3D &init_mm;
=20
-	/* NOTE: Other cpus have this done as they are started
-	 *       up on SMP.
-	 */
+#ifdef CONFIG_SMP
+	current->cpu =3D hard_smp_processor_id();
+#endif
 }
diff -urN linux-2.4.19-pre10-ac2/arch/sparc64/solaris/misc.c linux/arch/spa=
rc64/solaris/misc.c
--- linux-2.4.19-pre10-ac2/arch/sparc64/solaris/misc.c	Thu Jun  6 08:55:15 =
2002
+++ linux/arch/sparc64/solaris/misc.c	Thu Jun 13 12:09:51 2002
@@ -15,6 +15,7 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/timex.h>
+#include <linux/major.h>
=20
 #include <asm/uaccess.h>
 #include <asm/string.h>
diff -urN linux-2.4.19-pre10-ac2/include/asm-sparc64/bitops.h linux/include=
/asm-sparc64/bitops.h
--- linux-2.4.19-pre10-ac2/include/asm-sparc64/bitops.h	Thu Jun  6 08:54:13=
 2002
+++ linux/include/asm-sparc64/bitops.h	Thu Jun 13 12:09:51 2002
@@ -1,4 +1,4 @@
-/* $Id: bitops.h,v 1.38 2001/11/19 18:36:34 davem Exp $
+/* $Id: bitops.h,v 1.39 2002/01/30 01:40:00 davem Exp $
  * bitops.h: Bit string operations on the V9.
  *
  * Copyright 1996, 1997 David S. Miller (davem@caip.rutgers.edu)
@@ -7,6 +7,7 @@
 #ifndef _SPARC64_BITOPS_H
 #define _SPARC64_BITOPS_H
=20
+#include <linux/compiler.h>
 #include <asm/byteorder.h>
=20
 extern long ___test_and_set_bit(unsigned long nr, volatile void *addr);
@@ -64,66 +65,71 @@
 #define smp_mb__before_clear_bit()	do { } while(0)
 #define smp_mb__after_clear_bit()	do { } while(0)
=20
-extern __inline__ int test_bit(int nr, __const__ void *addr)
+static __inline__ int test_bit(int nr, __const__ void *addr)
 {
 	return (1UL & (((__const__ long *) addr)[nr >> 6] >> (nr & 63))) !=3D 0UL=
;
 }
=20
 /* The easy/cheese version for now. */
-extern __inline__ unsigned long ffz(unsigned long word)
+static __inline__ unsigned long ffz(unsigned long word)
 {
 	unsigned long result;
=20
-#ifdef ULTRA_HAS_POPULATION_COUNT	/* Thanks for nothing Sun... */
-	__asm__ __volatile__(
-"	brz,pn	%0, 1f\n"
-"	 neg	%0, %%g1\n"
-"	xnor	%0, %%g1, %%g2\n"
-"	popc	%%g2, %0\n"
-"1:	" : "=3D&r" (result)
-	  : "0" (word)
-	  : "g1", "g2");
-#else
-#if 1 /* def EASY_CHEESE_VERSION */
 	result =3D 0;
 	while(word & 1) {
 		result++;
 		word >>=3D 1;
 	}
-#else
-	unsigned long tmp;
+	return result;
+}
=20
-	result =3D 0;=09
-	tmp =3D ~word & -~word;
-	if (!(unsigned)tmp) {
-		tmp >>=3D 32;
-		result =3D 32;
-	}
-	if (!(unsigned short)tmp) {
-		tmp >>=3D 16;
-		result +=3D 16;
-	}
-	if (!(unsigned char)tmp) {
-		tmp >>=3D 8;
-		result +=3D 8;
-	}
-	if (tmp & 0xf0) result +=3D 4;
-	if (tmp & 0xcc) result +=3D 2;
-	if (tmp & 0xaa) result ++;
-#endif
-#endif
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static __inline__ unsigned long __ffs(unsigned long word)
+{
+	unsigned long result =3D 0;
+
+	while (!(word & 1UL)) {
+		result++;
+		word >>=3D 1;
+	}
 	return result;
 }
=20
 #ifdef __KERNEL__
=20
 /*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int _sched_find_first_bit(unsigned long *b)
+{
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(((unsigned int)b[1])))
+		return __ffs(b[1]) + 64;
+	if (b[1] >> 32)
+		return __ffs(b[1] >> 32) + 96;
+	return __ffs(b[2]) + 128;
+}
+
+/*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-
-#define ffs(x) generic_ffs(x)
+static __inline__ int ffs(int x)
+{
+	if (!x)
+		return 0;
+	return __ffs((unsigned long)x);
+}
=20
 /*
  * hweightN: returns the hamming weight (i.e. the number
@@ -132,7 +138,7 @@
=20
 #ifdef ULTRA_HAS_POPULATION_COUNT
=20
-extern __inline__ unsigned int hweight32(unsigned int w)
+static __inline__ unsigned int hweight32(unsigned int w)
 {
 	unsigned int res;
=20
@@ -140,7 +146,7 @@
 	return res;
 }
=20
-extern __inline__ unsigned int hweight16(unsigned int w)
+static __inline__ unsigned int hweight16(unsigned int w)
 {
 	unsigned int res;
=20
@@ -148,7 +154,7 @@
 	return res;
 }
=20
-extern __inline__ unsigned int hweight8(unsigned int w)
+static __inline__ unsigned int hweight8(unsigned int w)
 {
 	unsigned int res;
=20
@@ -165,12 +171,67 @@
 #endif
 #endif /* __KERNEL__ */
=20
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static __inline__ unsigned long find_next_bit(void *addr, unsigned long si=
ze, unsigned long offset)
+{
+	unsigned long *p =3D ((unsigned long *) addr) + (offset >> 6);
+	unsigned long result =3D offset & ~63UL;
+	unsigned long tmp;
+
+	if (offset >=3D size)
+		return size;
+	size -=3D result;
+	offset &=3D 63UL;
+	if (offset) {
+		tmp =3D *(p++);
+		tmp &=3D (~0UL << offset);
+		if (size < 64)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -=3D 64;
+		result +=3D 64;
+	}
+	while (size & ~63UL) {
+		if ((tmp =3D *(p++)))
+			goto found_middle;
+		result +=3D 64;
+		size -=3D 64;
+	}
+	if (!size)
+		return result;
+	tmp =3D *p;
+
+found_first:
+	tmp &=3D (~0UL >> (64 - size));
+	if (tmp =3D=3D 0UL)        /* Are any bits set? */
+		return result + size; /* Nope. */
+found_middle:
+	return result + __ffs(tmp);
+}
+
+/**
+ * find_first_bit - find the first set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first set bit, not the number of the byte
+ * containing a bit.
+ */
+#define find_first_bit(addr, size) \
+	find_next_bit((addr), (size), 0)
+
 /* find_next_zero_bit() finds the first zero bit in a bit string of length
  * 'size' bits, starting the search at bit 'offset'. This is largely based
  * on Linus's ALPHA routines, which are pretty portable BTW.
  */
=20
-extern __inline__ unsigned long find_next_zero_bit(void *addr, unsigned lo=
ng size, unsigned long offset)
+static __inline__ unsigned long find_next_zero_bit(void *addr, unsigned lo=
ng size, unsigned long offset)
 {
 	unsigned long *p =3D ((unsigned long *) addr) + (offset >> 6);
 	unsigned long result =3D offset & ~63UL;
@@ -219,7 +280,7 @@
 #define set_le_bit(nr,addr)		((void)___test_and_set_le_bit(nr,addr))
 #define clear_le_bit(nr,addr)		((void)___test_and_clear_le_bit(nr,addr))
=20
-extern __inline__ int test_le_bit(int nr, __const__ void * addr)
+static __inline__ int test_le_bit(int nr, __const__ void * addr)
 {
 	int			mask;
 	__const__ unsigned char	*ADDR =3D (__const__ unsigned char *) addr;
@@ -232,7 +293,7 @@
 #define find_first_zero_le_bit(addr, size) \
         find_next_zero_le_bit((addr), (size), 0)
=20
-extern __inline__ unsigned long find_next_zero_le_bit(void *addr, unsigned=
 long size, unsigned long offset)
+static __inline__ unsigned long find_next_zero_le_bit(void *addr, unsigned=
 long size, unsigned long offset)
 {
 	unsigned long *p =3D ((unsigned long *) addr) + (offset >> 6);
 	unsigned long result =3D offset & ~63UL;
diff -urN linux-2.4.19-pre10-ac2/include/asm-sparc64/smp.h linux/include/as=
m-sparc64/smp.h
--- linux-2.4.19-pre10-ac2/include/asm-sparc64/smp.h	Thu Jun  6 08:54:13 20=
02
+++ linux/include/asm-sparc64/smp.h	Thu Jun 13 12:09:51 2002
@@ -103,7 +103,7 @@
 	}
 }
=20
-#define smp_processor_id() (current->processor)
+#define smp_processor_id() (current->cpu)
=20
 /* This needn't do anything as we do not sleep the cpu
  * inside of the idler task, so an interrupt is not needed
@@ -127,8 +127,6 @@
=20
 #endif /* !(__ASSEMBLY__) */
=20
-#define PROC_CHANGE_PENALTY	20
-
 #endif /* !(CONFIG_SMP) */
=20
 #define NO_PROC_ID		0xFF
diff -urN linux-2.4.19-pre10-ac2/include/linux/kbd_kern.h linux/include/lin=
ux/kbd_kern.h
--- linux-2.4.19-pre10-ac2/include/linux/kbd_kern.h	Thu Jun  6 08:54:05 200=
2
+++ linux/include/linux/kbd_kern.h	Thu Jun 13 12:09:51 2002
@@ -1,6 +1,7 @@
 #ifndef _KBD_KERN_H
 #define _KBD_KERN_H
=20
+#include <linux/tty.h>
 #include <linux/interrupt.h>
 #include <linux/keyboard.h>
=20
diff -urN linux-2.4.19-pre10-ac2/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre10-ac2/kernel/sched.c	Thu Jun  6 11:16:04 2002
+++ linux/kernel/sched.c	Thu Jun 13 12:09:51 2002
@@ -392,8 +392,15 @@
 		next->active_mm =3D oldmm;
 		atomic_inc(&oldmm->mm_count);
 		enter_lazy_tlb(oldmm, next, smp_processor_id());
-	} else
+	} else {
 		switch_mm(oldmm, mm, next, smp_processor_id());
+#ifdef CONFIG_SPARC64
+		if (oldmm =3D=3D mm) {
+			load_secondary_context(mm);
+			reload_tlbmiss_state(next, mm);
+		}
+#endif
+	}
=20
 	if (unlikely(!prev->mm)) {
 		prev->active_mm =3D NULL;

--=-5KjiHN/wK71Iv0oqtdyF--

