Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSA3CAO>; Tue, 29 Jan 2002 21:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSA3CAF>; Tue, 29 Jan 2002 21:00:05 -0500
Received: from [202.135.142.194] ([202.135.142.194]:18695 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287872AbSA3B7y>; Tue, 29 Jan 2002 20:59:54 -0500
Date: Wed, 30 Jan 2002 13:00:26 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
Message-Id: <20020130130026.13803fda.rusty@rustcorp.com.au>
In-Reply-To: <3C57430B.8B6DFD9F@zip.com.au>
In-Reply-To: <3C57207E.28598C1F@zip.com.au>
	<E16VivB-0005sI-00@wagner.rustcorp.com.au>
	<3C57430B.8B6DFD9F@zip.com.au>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002 16:49:15 -0800
Andrew Morton <akpm@zip.com.au> wrote:
 
> Looks good.  I'll shut up now.

8)  Linus, this patch contains the per-cpu patch, and uses it in softirq.c.
It moves the tasklet_vec/tasklet_hi_vec inside softirq.c too (they're not used
anywhere else).

Boots and runs: more cleanups will follow once this is in...

Thanks!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/arch/i386/vmlinux.lds working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds
--- linux-2.5.3-pre6/arch/i386/vmlinux.lds	Tue Jan 29 09:16:52 2002
+++ working-2.5.3-pre6-percpu/arch/i386/vmlinux.lds	Wed Jan 30 10:17:38 2002
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
+++ working-2.5.3-pre6-percpu/arch/ppc/vmlinux.lds	Wed Jan 30 10:17:38 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/include/linux/smp.h working-2.5.3-pre6-percpu/include/linux/smp.h
--- linux-2.5.3-pre6/include/linux/smp.h	Thu Jan 17 16:35:24 2002
+++ working-2.5.3-pre6-percpu/include/linux/smp.h	Wed Jan 30 10:17:38 2002
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
+(*((__typeof__(&var))((void *)&var + per_cpu_offset(cpu))))
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre6/init/main.c working-2.5.3-pre6-percpu/init/main.c
--- linux-2.5.3-pre6/init/main.c	Tue Jan 29 09:17:09 2002
+++ working-2.5.3-pre6-percpu/init/main.c	Wed Jan 30 10:43:33 2002
@@ -272,8 +272,33 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void)
+{
+}
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
+	region = alloc_bootmem_pages(per_cpu_size*NR_CPUS);
+	for (i = 0; i < NR_CPUS; i++) {
+		memcpy(region + per_cpu_size*i, &__per_cpu_start,
+		       &__per_cpu_end - &__per_cpu_start);
+		__per_cpu_offset[i] 
+			= (region + per_cpu_size*i) - &__per_cpu_start;
+	}
+}
+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
@@ -316,6 +341,7 @@
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
+	setup_per_cpu_areas();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
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
