Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSITGyV>; Fri, 20 Sep 2002 02:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261637AbSITGyV>; Fri, 20 Sep 2002 02:54:21 -0400
Received: from dp.samba.org ([66.70.73.150]:37760 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261258AbSITGyP>;
	Fri, 20 Sep 2002 02:54:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CPU possible optimization
Date: Fri, 20 Sep 2002 16:51:36 +1000
Message-Id: <20020920065921.9AEA12C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This Works For Me(tm), but changing the boot order is always fraught
  with danger...  Should save some space as other things get converted
  to use the per-cpu infrastructure. ]

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
