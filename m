Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292310AbSBUDKB>; Wed, 20 Feb 2002 22:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292620AbSBUDJw>; Wed, 20 Feb 2002 22:09:52 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:18951 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292310AbSBUDJn>; Wed, 20 Feb 2002 22:09:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __per_cpu_data
Date: Thu, 21 Feb 2002 14:09:27 +1100
Message-Id: <E16djbs-0002Pc-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Richard Henderson-approved, cleaner, brighter per-cpu patch.  

Please apply,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3/include/linux/compiler.h working-2.5.3-percpu/include/linux/compiler.h
--- linux-2.5.3/include/linux/compiler.h	Wed Sep 19 07:12:45 2001
+++ working-2.5.3-percpu/include/linux/compiler.h	Fri Feb  1 09:46:02 2002
@@ -13,4 +13,12 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
+/* This macro obfuscates arithmetic on a variable address so that gcc
+   shouldn't recognize it. This prevents optimizations such as the
+   famous:
+	strcpy(s, "xxx"+X) => memcpy(s, "xxx"+X, 4-X) */
+#define reloc_hide(var, off)						\
+  ({ __typeof__(&(var)) __ptr;					\
+    __asm__ ("" : "=g"(__ptr) : "0"((void *)&(var) + (off)));	\
+    *__ptr; })
 #endif /* __LINUX_COMPILER_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3/include/linux/smp.h working-2.5.3-percpu/include/linux/smp.h
--- linux-2.5.3/include/linux/smp.h	Fri Feb  1 19:21:37 2002
+++ working-2.5.3-percpu/include/linux/smp.h	Fri Feb  1 19:17:09 2002
@@ -11,6 +11,7 @@
 #ifdef CONFIG_SMP
 
 #include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <asm/smp.h>
 
 /*
@@ -71,7 +72,17 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#else
+#define __per_cpu_data	__attribute__((section(".data.percpu")))
+
+#ifndef __HAVE_ARCH_PER_CPU
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) reloc_hide(var, per_cpu_offset(cpu))
+
+#define this_cpu(var) per_cpu(var, smp_processor_id())
+#endif /* !__HAVE_ARCH_PER_CPU */
+#else /* !SMP */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
@@ -88,6 +99,9 @@
 #define cpu_online_map				1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define __per_cpu_data
+#define per_cpu(var, cpu)			var
+#define this_cpu(var)				var
 
 #endif
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3/init/main.c working-2.5.3-percpu/init/main.c
--- linux-2.5.3/init/main.c	Thu Jan 31 08:59:17 2002
+++ working-2.5.3-percpu/init/main.c	Fri Feb  1 19:13:52 2002
@@ -272,8 +272,32 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void)
+{
+}
 #else
 
+#ifndef __HAVE_ARCH_PER_CPU
+unsigned long __per_cpu_offset[NR_CPUS];
+
+static void __init setup_per_cpu_areas(void)
+{
+	unsigned long size, i;
+	char *ptr;
+	/* Created by linker magic */
+	extern char __per_cpu_start[], __per_cpu_end[];
+
+	/* Copy section for each CPU (we discard the original) */
+	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+	ptr = alloc_bootmem(size * NR_CPUS);
+
+	for (i = 0; i < NR_CPUS; i++, ptr += size) {
+		__per_cpu_offset[i] = ptr - __per_cpu_start;
+		memcpy(ptr, __per_cpu_start, size);
+	}
+}
+#endif /* !__HAVE_ARCH_PER_CPU */
+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
@@ -316,6 +340,7 @@
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
+	setup_per_cpu_areas();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3/include/linux/cache.h working-2.5.3-percpu/include/linux/cache.h
--- linux-2.5.3/include/linux/cache.h	Fri Feb  1 19:21:37 2002
+++ working-2.5.3-percpu/include/linux/cache.h	Fri Feb  1 19:17:09 2002
@@ -4,8 +4,10 @@
 #include <linux/config.h>
 #include <asm/cache.h>
 
+#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
+
 #ifndef L1_CACHE_ALIGN
-#define L1_CACHE_ALIGN(x) (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
+#define L1_CACHE_ALIGN(x) ALIGN(x, L1_CACHE_BYTES)
 #endif
 
 #ifndef SMP_CACHE_BYTES
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3/arch/i386/vmlinux.lds working-2.5.3-percpu/arch/i386/vmlinux.lds
--- linux-2.5.3/arch/i386/vmlinux.lds	Thu Jan 31 08:58:52 2002
+++ working-2.5.3-percpu/arch/i386/vmlinux.lds	Fri Feb  1 09:11:18 2002
@@ -58,6 +58,10 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3/arch/ppc/vmlinux.lds working-2.5.3-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.3/arch/ppc/vmlinux.lds	Thu Jan 31 08:58:55 2002
+++ working-2.5.3-percpu/arch/ppc/vmlinux.lds	Fri Feb  1 09:11:18 2002
@@ -104,6 +104,10 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
