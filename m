Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288484AbSA3Ehx>; Tue, 29 Jan 2002 23:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288511AbSA3Ehp>; Tue, 29 Jan 2002 23:37:45 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:60688 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288484AbSA3Eh0>; Tue, 29 Jan 2002 23:37:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
In-Reply-To: Your message of "Tue, 29 Jan 2002 18:12:37 -0800."
             <Pine.LNX.4.33.0201291801550.1747-100000@penguin.transmeta.com> 
Date: Wed, 30 Jan 2002 15:13:26 +1100
Message-Id: <E16Vm7i-0008A6-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0201291801550.1747-100000@penguin.transmeta.com> you 
write:
> Also, wouldn't it be much nicer to just leave CPU#0 at the start of
> .data.percpu, and not have to have an offset for CPU0 at all? That would
> sure make the UP case cleaner.

Tried that, but it's uglier 8(  UP never hits this code anyway, and we
discard the original section anyway (ie. it's in the init section).

Main neatening comes from introducing an ALIGN macro in linux/cache.h.
Also extended the __HAVE_ARCH_PER_CPU so it can be replaced by arch's
without touching the core (thanks Anton).  This means that they can
allocate a fixed amount per CPU, and keep the per-cpu pointer in a
register, from which smp_processor_id() can be simply derived.

Hope this is better,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/include/linux/cache.h working-2.5.3-pre6-percpu/include/linux/cache.h
--- linux-2.5.3-pre6/include/linux/cache.h	Thu Jan 17 16:34:59 2002
+++ working-2.5.3-pre6-percpu/include/linux/cache.h	Wed Jan 30 14:59:20 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/include/linux/smp.h working-2.5.3-pre6-percpu/include/linux/smp.h
--- linux-2.5.3-pre6/include/linux/smp.h	Thu Jan 17 16:35:24 2002
+++ working-2.5.3-pre6-percpu/include/linux/smp.h	Wed Jan 30 14:23:58 2002
@@ -71,7 +71,18 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#else
+#define __per_cpu_data	__attribute__((section(".data.percpu")))
+
+#ifndef __HAVE_ARCH_PER_CPU
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+#define per_cpu(var, cpu) \
+	(*((__typeof__(&var))((void *)&var + __per_cpu_offset[(cpu)])))
+
+#define this_cpu(var) per_cpu(var,smp_processor_id())
+
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/init/main.c working-2.5.3-pre6-percpu/init/main.c
--- linux-2.5.3-pre6/init/main.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu/init/main.c	Wed Jan 30 14:44:33 2002
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
+	extern char __per_cpu_start, __per_cpu_end;
+
+	/* Copy section for each CPU (we discard the original) */
+	size = ALIGN(&__per_cpu_end - &__per_cpu_start, SMP_CACHE_BYTES);
+	ptr = alloc_bootmem(size * NR_CPUS);
+
+	for (i = 0; i < NR_CPUS; i++, ptr += size) {
+		__per_cpu_offset[i] = ptr - &__per_cpu_start;
+		memcpy(ptr, &__per_cpu_start, size);
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/arch/i386/vmlinux.lds working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds
--- linux-2.5.3-pre6/arch/i386/vmlinux.lds	Tue Jan 29 09:16:52 2002
+++ working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds	Wed Jan 30 12:02:35 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/arch/ppc/vmlinux.lds working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds
--- linux-2.5.3-pre6/arch/ppc/vmlinux.lds	Tue Jan 29 09:16:53 2002
+++ working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds	Wed Jan 30 12:02:35 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.3-pre6-percpu/include/linux/interrupt.h working-2.5.3-pre6-percpu-tasklet/include/linux/interrupt.h
--- working-2.5.3-pre6-percpu/include/linux/interrupt.h	Thu Jan 17 16:35:24 2002
+++ working-2.5.3-pre6-percpu-tasklet/include/linux/interrupt.h	Wed Jan 30 12:00:08 2002
@@ -124,14 +124,6 @@
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
-struct tasklet_head
-{
-	struct tasklet_struct *list;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
-
-extern struct tasklet_head tasklet_vec[NR_CPUS];
-extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
-
 #ifdef CONFIG_SMP
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.3-pre6-percpu/kernel/ksyms.c working-2.5.3-pre6-percpu-tasklet/kernel/ksyms.c
--- working-2.5.3-pre6-percpu/kernel/ksyms.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu-tasklet/kernel/ksyms.c	Wed Jan 30 12:00:16 2002
@@ -542,8 +542,6 @@
 EXPORT_SYMBOL(strsep);
 
 /* software interrupts */
-EXPORT_SYMBOL(tasklet_hi_vec);
-EXPORT_SYMBOL(tasklet_vec);
 EXPORT_SYMBOL(bh_task_vec);
 EXPORT_SYMBOL(init_bh);
 EXPORT_SYMBOL(remove_bh);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.3-pre6-percpu/kernel/softirq.c working-2.5.3-pre6-percpu-tasklet/kernel/softirq.c
--- working-2.5.3-pre6-percpu/kernel/softirq.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu-tasklet/kernel/softirq.c	Wed Jan 30 12:34:12 2002
@@ -145,9 +145,13 @@
 
 
 /* Tasklets */
+struct tasklet_head
+{
+	struct tasklet_struct *list;
+};
 
-struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned_in_smp;
-struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned_in_smp;
+static struct tasklet_head tasklet_vec __per_cpu_data;
+static struct tasklet_head tasklet_hi_vec __per_cpu_data;
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {
@@ -155,8 +159,8 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = tasklet_vec[cpu].list;
-	tasklet_vec[cpu].list = t;
+	t->next = per_cpu(tasklet_vec, cpu).list;
+	per_cpu(tasklet_vec, cpu).list = t;
 	cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -167,8 +171,8 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = tasklet_hi_vec[cpu].list;
-	tasklet_hi_vec[cpu].list = t;
+	t->next = per_cpu(tasklet_hi_vec, cpu).list;
+	per_cpu(tasklet_hi_vec, cpu).list = t;
 	cpu_raise_softirq(cpu, HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -179,8 +183,8 @@
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = tasklet_vec[cpu].list;
-	tasklet_vec[cpu].list = NULL;
+	list = per_cpu(tasklet_vec, cpu).list;
+	per_cpu(tasklet_vec, cpu).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -200,8 +204,8 @@
 		}
 
 		local_irq_disable();
-		t->next = tasklet_vec[cpu].list;
-		tasklet_vec[cpu].list = t;
+		t->next = per_cpu(tasklet_vec, cpu).list;
+		per_cpu(tasklet_vec, cpu).list = t;
 		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
@@ -213,8 +217,8 @@
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = tasklet_hi_vec[cpu].list;
-	tasklet_hi_vec[cpu].list = NULL;
+	list = per_cpu(tasklet_hi_vec, cpu).list;
+	per_cpu(tasklet_hi_vec, cpu).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -234,8 +238,8 @@
 		}
 
 		local_irq_disable();
-		t->next = tasklet_hi_vec[cpu].list;
-		tasklet_hi_vec[cpu].list = t;
+		t->next = per_cpu(tasklet_hi_vec, cpu).list;
+		per_cpu(tasklet_hi_vec, cpu).list = t;
 		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
 		local_irq_enable();
 	}
