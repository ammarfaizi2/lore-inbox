Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSA2JBB>; Tue, 29 Jan 2002 04:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSA2JAw>; Tue, 29 Jan 2002 04:00:52 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:40972 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288960AbSA2JAo>; Tue, 29 Jan 2002 04:00:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] per-cpu areas for 2.5.3-pre6
Date: Tue, 29 Jan 2002 20:01:17 +1100
Message-Id: <E16VU8j-0006Hm-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the __per_cpu_data tag for data, and the
per_cpu() & this_cpu() macros to go with it.

This allows us to get rid of all those special case structures
springing up all over the place for CPU-local data.

Thanks!
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.3-pre6/include/linux/smp.h working-2.5.3-pre6-percpu/include/linux/smp.h
--- linux-2.5.3-pre6/include/linux/smp.h	Thu Jan 17 16:35:24 2002
+++ working-2.5.3-pre6-percpu/include/linux/smp.h	Wed Jan 30 04:17:59 2002
@@ -71,7 +71,17 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#else
+#define __per_cpu_data	__attribute__((section(".data.percpu")))
+
+#ifndef __HAVE_ARCH_CPU_OFFSET
+#define per_cpu_offset(cpu) (__per_cpu_offset[(cpu)])
+#endif
+
+#define per_cpu(var, cpu)						  \
+(*(__typeof__(&var)((void *)&var + per_cpu_offset(cpu))))
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+#else /* !SMP */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
@@ -88,6 +98,10 @@
 #define cpu_online_map				1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define __per_cpu_data
+#define per_cpu(var, cpu)			var
 
 #endif
+
+#define this_cpu(var)				per_cpu(var,smp_processor_id())
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.3-pre6/arch/i386/vmlinux.lds working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds
--- linux-2.5.3-pre6/arch/i386/vmlinux.lds	Tue Jan 29 09:16:52 2002
+++ working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds	Wed Jan 30 04:00:34 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.3-pre6/arch/ppc/vmlinux.lds working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.3-pre6/arch/ppc/vmlinux.lds	Tue Jan 29 09:16:53 2002
+++ working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds	Wed Jan 30 04:00:34 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.3-pre6/init/main.c working-2.5.3-pre6-percpu/init/main.c
--- linux-2.5.3-pre6/init/main.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu/init/main.c	Wed Jan 30 06:43:10 2002
@@ -274,16 +274,42 @@
 
 #else
 
+unsigned long __per_cpu_offset[NR_CPUS];
+/* Created by linker magic */
+extern char __per_cpu_start, __per_cpu_end;
+
+static void setup_per_cpu_areas(void)
+{
+	unsigned int i;
+	size_t per_cpu_size;
+	char *region;
+	
+	/* Set up per-CPU offset pointers.  Page align to be safe. */
+	per_cpu_size = ((&__per_cpu_end - &__per_cpu_start) + PAGE_SIZE-1)
+		& ~(PAGE_SIZE-1);
+	region = kmalloc(per_cpu_size * smp_num_cpus, GFP_KERNEL);
+	if (!region)
+		panic("Could not allocate per-cpu regions: %u bytes\n",
+		      per_cpu_size * smp_num_cpus);
+	for (i = 0; i < smp_num_cpus; i++) {
+		memcpy(region + per_cpu_size*i, &__per_cpu_start,
+		       &__per_cpu_end - &__per_cpu_start);
+		__per_cpu_offset[i] 
+			= (region + per_cpu_size*i) - &__per_cpu_start;
+	}
+	printk("Did %u cpu regions...\n", smp_num_cpus);
+}
+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
 	/* Get other processors into their bootup holding patterns. */
 	smp_boot_cpus();
 
+	setup_per_cpu_areas();
 	smp_threads_ready=1;
 	smp_commence();
 }
-
 #endif
 
 /*

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
