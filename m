Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319301AbSILHPU>; Thu, 12 Sep 2002 03:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319356AbSILHPU>; Thu, 12 Sep 2002 03:15:20 -0400
Received: from dp.samba.org ([66.70.73.150]:29368 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319301AbSILHPQ>;
	Thu, 12 Sep 2002 03:15:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Only allocate per-cpu copies for possible CPUs
Date: Thu, 12 Sep 2002 17:19:43 +1000
Message-Id: <20020912072006.DF98A2C0C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not quite as neat as I would like, but it means that per-cpu vars are
still usable on the boot CPU early, and usable on the other cpus by
the time they are called online.

The problem is that some people want to use per-cpu vars before we
have probed for cpus, so we don't know what CPUs are possible, hence
this "alloc the boot cpu using bootmem and the other cpus using
kmalloc" approach.

This is a precursor to pushing "change all [NR_CPUS] arrays to per-cpu
vars" (which then implies that the per-cpu area pointer, not the cpu
number, becomes the primary object from which the other is derived.

Comments?

Name: per-cpu only for possible CPUs
Author: Rusty Russell
Status: Tested on 2.5.34 2-way i386

D: This allocates per-cpu areas only for those CPUs which may actually
D: exist, before each one comes online.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/init/main.c working-2.5.34-percpu_possible/init/main.c
--- linux-2.5.34/init/main.c	Tue Sep 10 09:11:21 2002
+++ working-2.5.34-percpu_possible/init/main.c	Thu Sep 12 15:01:31 2002
@@ -309,32 +309,36 @@ static void __init smp_init(void)
 #define smp_init()	do { } while (0)
 #endif
 
-static inline void setup_per_cpu_areas(void) { }
+static inline void setup_per_cpu_area(unsigned int cpu) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 
 #else
 
 #ifdef __GENERIC_PER_CPU
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
 unsigned long __per_cpu_offset[NR_CPUS];
 
-static void __init setup_per_cpu_areas(void)
+/* Sets up per-cpu area for boot CPU. */
+static void __init setup_per_cpu_area(unsigned int cpu)
 {
-	unsigned long size, i;
+	unsigned long size;
 	char *ptr;
-	/* Created by linker magic */
-	extern char __per_cpu_start[], __per_cpu_end[];
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
 	if (!size)
 		return;
 
-	ptr = alloc_bootmem(size * NR_CPUS);
+	/* First CPU happens really early... */
+	if (cpu == smp_processor_id())
+		ptr = alloc_bootmem(size);
+	else
+		ptr = kmalloc(size, GFP_ATOMIC);
 
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
-		__per_cpu_offset[i] = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, size);
-	}
+	__per_cpu_offset[cpu] = ptr - __per_cpu_start;
+	memcpy(ptr, __per_cpu_start, size);
 }
 #endif /* !__GENERIC_PER_CPU */
 
@@ -343,7 +347,16 @@ static void __init smp_init(void)
 {
 	unsigned int i;
 
-	/* FIXME: This should be done in userspace --RR */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			if (i != smp_processor_id())
+				setup_per_cpu_area(i);
+		} else {
+			/* Force a NULL deref on use */
+			__per_cpu_offset[i] = (char *)0 - __per_cpu_start;
+		}
+	}
+
 	for (i = 0; i < NR_CPUS; i++) {
 		if (num_online_cpus() >= max_cpus)
 			break;
@@ -395,7 +408,7 @@ asmlinkage void __init start_kernel(void
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
-	setup_per_cpu_areas();
+	setup_per_cpu_area(smp_processor_id());
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
