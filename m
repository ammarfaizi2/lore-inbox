Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317806AbSFMTXd>; Thu, 13 Jun 2002 15:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317803AbSFMTX2>; Thu, 13 Jun 2002 15:23:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30709 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317806AbSFMTWc>; Thu, 13 Jun 2002 15:22:32 -0400
Subject: [PATCH] 2.4-ac: alpha support for O(1) scheduler
From: Robert Love <rml@mvista.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-B9EKbwMuA45Wrwnb7gvh"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jun 2002 12:22:27 -0700
Message-Id: <1023996147.4799.77.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B9EKbwMuA45Wrwnb7gvh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Attached patch provides Alpha support for the O(1) scheduler in 2.4-ac. 
This is based off the Alpha O(1) support in 2.4-aa by Andrea Arcangeli.

Patch is against 2.4.19-pre10-ac2, please apply.

	Robert Love

--=-B9EKbwMuA45Wrwnb7gvh
Content-Disposition: attachment; filename=sched-O1-alpha-2.4.19-pre10-ac2-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-O1-alpha-2.4.19-pre10-ac2-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre10-ac2/arch/alpha/kernel/process.c linux/arch/alp=
ha/kernel/process.c
--- linux-2.4.19-pre10-ac2/arch/alpha/kernel/process.c	Thu Jun  6 08:55:05 =
2002
+++ linux/arch/alpha/kernel/process.c	Thu Jun 13 12:16:23 2002
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/tty.h>
 #include <linux/console.h>
+#include <linux/sched_runqueue.h>
=20
 #include <asm/reg.h>
 #include <asm/uaccess.h>
@@ -74,9 +75,6 @@
 cpu_idle(void)
 {
 	/* An endless idle loop with no priority at all.  */
-	current->nice =3D 20;
-	current->counter =3D -100;
-
 	while (1) {
 		/* FIXME -- EV6 and LCA45 know how to power down
 		   the CPU.  */
diff -urN linux-2.4.19-pre10-ac2/arch/alpha/kernel/smp.c linux/arch/alpha/k=
ernel/smp.c
--- linux-2.4.19-pre10-ac2/arch/alpha/kernel/smp.c	Thu Jun  6 08:55:05 2002
+++ linux/arch/alpha/kernel/smp.c	Thu Jun 13 12:16:23 2002
@@ -82,6 +82,7 @@
 int smp_num_cpus =3D 1;		/* Number that came online.  */
 int smp_threads_ready;		/* True once the per process idle is forked. */
 cycles_t cacheflush_time;
+unsigned long cache_decay_ticks;
=20
 int __cpu_number_map[NR_CPUS];
 int __cpu_logical_map[NR_CPUS];
@@ -156,11 +157,6 @@
 {
 	int cpuid =3D hard_smp_processor_id();
=20
-	if (current !=3D init_tasks[cpu_number_map(cpuid)]) {
-		printk("BUG: smp_calling: cpu %d current %p init_tasks[cpu_number_map(cp=
uid)] %p\n",
-		       cpuid, current, init_tasks[cpu_number_map(cpuid)]);
-	}
-
 	DBGS(("CALLIN %d state 0x%lx\n", cpuid, current->state));
=20
 	/* Turn on machine checks.  */
@@ -215,9 +211,6 @@
 	DBGS(("smp_callin: commencing CPU %d current %p\n",
 	      cpuid, current));
=20
-	/* Setup the scheduler for this processor.  */
-	init_idle();
-
 	/* ??? This should be in init_idle.  */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm =3D &init_mm;
@@ -236,8 +229,9 @@
 smp_tune_scheduling (int cpuid)
 {
 	struct percpu_struct *cpu;
-	unsigned long on_chip_cache;
-	unsigned long freq;
+	unsigned long on_chip_cache;	/* kB */
+	unsigned long freq;		/* Hz */
+	unsigned long bandwidth =3D 350;	/* MB/s */
=20
 	cpu =3D (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset
 				      + cpuid * hwrpb->processor_size);
@@ -258,29 +252,21 @@
=20
 	case EV6_CPU:
 	case EV67_CPU:
-		on_chip_cache =3D 64 + 64;
-		break;
-
 	default:
-		on_chip_cache =3D 8 + 8;
+		on_chip_cache =3D 64 + 64;
 		break;
 	}
=20
 	freq =3D hwrpb->cycle_freq ? : est_cycle_freq;
=20
-#if 0
-	/* Magic estimation stolen from x86 port.  */
-	cacheflush_time =3D freq / 1024L * on_chip_cache / 5000L;
-
-        printk("Using heuristic of %d cycles.\n",
-               cacheflush_time);
-#else
-	/* Magic value to force potential preemption of other CPUs.  */
-	cacheflush_time =3D INT_MAX;
+	cacheflush_time =3D (freq / 1000000) * (on_chip_cache << 10) / bandwidth;
+	cache_decay_ticks =3D cacheflush_time / (freq / 1000) * HZ / 1000;
=20
-        printk("Using heuristic of %d cycles.\n",
-               cacheflush_time);
-#endif
+	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
+	       cacheflush_time/(freq/1000000),
+	       (cacheflush_time*100/(freq/1000000)) % 100);
+	printk("task migration cache decay timeout: %ld msecs.\n",
+	       (cache_decay_ticks + 1) * 1000 / HZ);
 }
=20
 /*
@@ -505,14 +491,11 @@
 	if (idle =3D=3D &init_task)
 		panic("idle process is init_task for CPU %d", cpuid);
=20
-	idle->processor =3D cpuid;
-	idle->cpus_runnable =3D 1 << cpuid; /* we schedule the first task manuall=
y */
+	init_idle(idle, cpuid);
+	unhash_process(idle);
+
 	__cpu_logical_map[cpunum] =3D cpuid;
 	__cpu_number_map[cpuid] =3D cpunum;
-=20
-	del_from_runqueue(idle);
-	unhash_process(idle);
-	init_tasks[cpunum] =3D idle;
=20
 	DBGS(("smp_boot_one_cpu: CPU %d state 0x%lx flags 0x%lx\n",
 	      cpuid, idle->state, idle->flags));
@@ -619,14 +602,11 @@
=20
 	__cpu_number_map[boot_cpuid] =3D 0;
 	__cpu_logical_map[0] =3D boot_cpuid;
-	current->processor =3D boot_cpuid;
=20
 	smp_store_cpu_info(boot_cpuid);
 	smp_tune_scheduling(boot_cpuid);
 	smp_setup_percpu_timer(boot_cpuid);
=20
-	init_idle();
-
 	/* ??? This should be in init_idle.  */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm =3D &init_mm;
diff -urN linux-2.4.19-pre10-ac2/include/asm-alpha/bitops.h linux/include/a=
sm-alpha/bitops.h
--- linux-2.4.19-pre10-ac2/include/asm-alpha/bitops.h	Thu Jun  6 08:54:10 2=
002
+++ linux/include/asm-alpha/bitops.h	Thu Jun 13 12:16:23 2002
@@ -3,6 +3,7 @@
=20
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <asm/compiler.h>
=20
 /*
  * Copyright 1994, Linus Torvalds.
@@ -74,6 +75,17 @@
  * WARNING: non atomic version.
  */
 static __inline__ void
+__clear_bit(unsigned long nr, volatile void * addr)
+{
+	int *m =3D ((int *) addr) + (nr >> 5);
+
+	*m &=3D ~(1 << (nr & 31));
+}
+
+/*
+ * WARNING: non atomic version.
+ */
+static __inline__ void
 __change_bit(unsigned long nr, volatile void * addr)
 {
 	int *m =3D ((int *) addr) + (nr >> 5);
@@ -264,6 +276,28 @@
 #endif
 }
=20
+/*
+ * __ffs =3D Find First set bit in word.  Undefined if no set bit exists.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+#if defined(__alpha_cix__) && defined(__alpha_fix__)
+	/* Whee.  EV67 can calculate it directly.  */
+	unsigned long result;
+	__asm__("cttz %1,%0" : "=3Dr"(result) : "r"(word));
+	return result;
+#else
+	unsigned long bits, qofs, bofs;
+
+	__asm__("cmpbge $31,%1,%0" : "=3Dr"(bits) : "r"(word));
+	qofs =3D ffz_b(bits);
+	bits =3D __kernel_extbl(word, qofs);
+	bofs =3D ffz_b(~bits);
+
+	return qofs*8 + bofs;
+#endif
+}
+
 #ifdef __KERNEL__
=20
 /*
@@ -365,13 +399,77 @@
 }
=20
 /*
- * The optimizer actually does good code for this case..
+ * Find next one bit in a bitmap reasonably efficiently.
+ */
+static inline unsigned long
+find_next_bit(void * addr, unsigned long size, unsigned long offset)
+{
+	unsigned long * p =3D ((unsigned long *) addr) + (offset >> 6);
+	unsigned long result =3D offset & ~63UL;
+	unsigned long tmp;
+
+	if (offset >=3D size)
+		return size;
+	size -=3D result;
+	offset &=3D 63UL;
+	if (offset) {
+		tmp =3D *(p++);
+		tmp &=3D ~0UL << offset;
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
+found_first:
+	tmp &=3D ~0UL >> (64 - size);
+	if (!tmp)
+		return result + size;
+found_middle:
+	return result + __ffs(tmp);
+}
+
+/*
+ * The optimizer actually does good code for this case.
  */
 #define find_first_zero_bit(addr, size) \
 	find_next_zero_bit((addr), (size), 0)
+#define find_first_bit(addr, size) \
+	find_next_bit((addr), (size), 0)
=20
 #ifdef __KERNEL__
=20
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is set.
+ */
+static inline unsigned long
+sched_find_first_bit(unsigned long b[3])
+{
+	unsigned long b0 =3D b[0], b1 =3D b[1], b2 =3D b[2];
+	unsigned long ofs;
+
+	ofs =3D (b1 ? 64 : 128);
+	b1 =3D (b1 ? b1 : b2);
+	ofs =3D (b0 ? 0 : ofs);
+	b0 =3D (b0 ? b0 : b1);
+
+	return __ffs(b0) + ofs;
+}
+
+
 #define ext2_set_bit                 __test_and_set_bit
 #define ext2_clear_bit               __test_and_clear_bit
 #define ext2_test_bit                test_bit
diff -urN linux-2.4.19-pre10-ac2/include/asm-alpha/smp.h linux/include/asm-=
alpha/smp.h
--- linux-2.4.19-pre10-ac2/include/asm-alpha/smp.h	Thu Jun  6 08:54:10 2002
+++ linux/include/asm-alpha/smp.h	Thu Jun 13 12:16:23 2002
@@ -55,7 +55,7 @@
 #define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
=20
 #define hard_smp_processor_id()	__hard_smp_processor_id()
-#define smp_processor_id()	(current->processor)
+#define smp_processor_id()	(current->cpu)
=20
 extern unsigned long cpu_present_mask;
 #define cpu_online_map cpu_present_mask

--=-B9EKbwMuA45Wrwnb7gvh--

