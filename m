Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286168AbRLTGQl>; Thu, 20 Dec 2001 01:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286167AbRLTGQb>; Thu, 20 Dec 2001 01:16:31 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:261 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S286169AbRLTGPw>; Thu, 20 Dec 2001 01:15:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] New per-cpu patch v2.5.1
Date: Thu, 20 Dec 2001 17:15:43 +1100
Message-Id: <E16GwUZ-0004xr-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some discussion, this may be a more sane (untested) per-cpu area
patch.  It dynamically allocated the sections (and discards the
original), which would allow (future) NUMA people to make sure their
CPU area is allocated near them.

Comments welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1/arch/i386/vmlinux.lds working-2.5.1-percpu/arch/i386/vmlinux.lds
--- linux-2.5.1/arch/i386/vmlinux.lds	Tue Jul  3 07:40:14 2001
+++ working-2.5.1-percpu/arch/i386/vmlinux.lds	Thu Dec 20 14:13:03 2001
@@ -50,6 +50,10 @@
   __initcall_start = .;
   .initcall.init : { *(.initcall.init) }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1/arch/ppc/vmlinux.lds working-2.5.1-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.1/arch/ppc/vmlinux.lds	Tue Aug 28 23:58:33 2001
+++ working-2.5.1-percpu/arch/ppc/vmlinux.lds	Thu Dec 20 14:34:13 2001
@@ -96,6 +96,10 @@
   __initcall_start = .;
   .initcall.init : { *(.initcall.init) }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1/include/linux/smp.h working-2.5.1-percpu/include/linux/smp.h
--- linux-2.5.1/include/linux/smp.h	Tue Dec 18 19:08:06 2001
+++ working-2.5.1-percpu/include/linux/smp.h	Thu Dec 20 14:30:28 2001
@@ -71,7 +71,18 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#else
+#define PER_CPU(decl)	decl##__percpu __attribute__((section(".data.percpu")))
+
+/* Created by linker magic */
+extern char __per_cpu_start, __per_cpu_end;
+
+extern void *per_cpu_off[NR_CPUS];
+
+#define per_cpu(var, cpu)					\
+(*(__typeof__(&var)((void *)&var##__percpu - &__per_cpu_start)	\
+   + per_cpu_off[cpu]))
+
+#else /* !SMP */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
@@ -86,6 +97,10 @@
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
-
+#define PER_CPU(decl)				decl
+#define per_cpu(var, cpu)			var
 #endif
+
+#define this_cpu(var)				per_cpu(var,smp_processor_id())
+
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1/init/main.c working-2.5.1-percpu/init/main.c
--- linux-2.5.1/init/main.c	Mon Dec 17 16:09:13 2001
+++ working-2.5.1-percpu/init/main.c	Thu Dec 20 17:08:42 2001
@@ -305,10 +305,14 @@
 
 #else
 
+void *per_cpu_off[NR_CPUS];
 
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
+	unsigned int i;
+	size_t per_cpu_size;
+
 	/* Get other processors into their bootup holding patterns. */
 	smp_boot_cpus();
 	wait_init_idle = cpu_online_map;
@@ -324,6 +328,16 @@
 		barrier();
 	}
 	printk("All processors have done init_idle\n");
+
+	/* Set up per-CPU section pointers.  Page align to be safe. */
+	per_cpu_size = ((&__per_cpu_end - &__per_cpu_start) + PAGE_SIZE-1)
+		& ~(PAGE_SIZE-1);
+	per_cpu_off[0] = kmalloc(per_cpu_size * smp_num_cpus, GFP_KERNEL);
+	for (i = 0; i < smp_num_cpus; i++) {
+		per_cpu_off[i] = per_cpu_off[0] + per_cpu_size;
+		memcpy(per_cpu_off[i], &__per_cpu_start,
+		       __per_cpu_end - &__per_cpu_start);
+	}
 }
 
 #endif
