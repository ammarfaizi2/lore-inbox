Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSAPR2Q>; Wed, 16 Jan 2002 12:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSAPRZE>; Wed, 16 Jan 2002 12:25:04 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4868 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S285022AbSAPRY3>; Wed, 16 Jan 2002 12:24:29 -0500
Date: Wed, 16 Jan 2002 20:24:23 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Peter Rival <frival@zk3.dec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone tried 2.5.[23] on Alpha?
Message-ID: <20020116202423.A753@jurassic.park.msu.ru>
In-Reply-To: <3C459334.7070408@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C459334.7070408@zk3.dec.com>; from frival@zk3.dec.com on Wed, Jan 16, 2002 at 09:50:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 09:50:28AM -0500, Peter Rival wrote:
> I just wanted to check if anyone has tried 2.5.[23] on Alpha yet.  It 
> appears Ingo's scheduler changes haven't been ported to work on the 
> Alpha platform as yet.

I'm running 2.5.3-pre1 on sx164 right now with these patches.
The scheduler changes are untested on SMP though.

Ivan.

--- 2.5.3p1/include/asm-alpha/io.h	Tue Nov 27 20:23:27 2001
+++ linux/include/asm-alpha/io.h	Wed Jan 16 18:30:12 2002
@@ -60,7 +60,9 @@ static inline void * phys_to_virt(unsign
 	return (void *) (address + IDENT_ADDR);
 }
 
-#define page_to_phys(page)	(((page) - (page)->zone->zone_mem_map) << PAGE_SHIFT)
+#define page_to_phys		PAGE_TO_PA
+/* This depends on working iommu */
+#define BIO_VMERGE_BOUNDARY	(alpha_mv.mv_pci_tbi ? PAGE_SIZE : 0)
 
 /*
  * Change addresses as seen by the kernel (virtual) to addresses as
--- 2.5.3p1/include/asm-alpha/bitops.h	Sat Oct 13 02:35:54 2001
+++ linux/include/asm-alpha/bitops.h	Wed Jan 16 18:30:11 2002
@@ -73,6 +73,17 @@ clear_bit(unsigned long nr, volatile voi
 /*
  * WARNING: non atomic version.
  */
+static inline void
+__clear_bit(unsigned long nr, volatile void * addr)
+{
+	int *m = ((int *) addr) + (nr >> 5);
+
+	*m &= ~(1 << (nr & 31));
+}
+
+/*
+ * WARNING: non atomic version.
+ */
 static __inline__ void
 __change_bit(unsigned long nr, volatile void * addr)
 {
--- 2.5.3p1/include/asm-alpha/smp.h	Fri Sep 14 02:21:32 2001
+++ linux/include/asm-alpha/smp.h	Wed Jan 16 18:30:11 2002
@@ -55,7 +55,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
 
 #define hard_smp_processor_id()	__hard_smp_processor_id()
-#define smp_processor_id()	(current->processor)
+#define smp_processor_id()	(current->cpu)
 
 extern unsigned long cpu_present_mask;
 #define cpu_online_map cpu_present_mask
--- 2.5.3p1/include/asm-alpha/sched.h	Thu Jan  1 00:00:00 1970
+++ linux/include/asm-alpha/sched.h	Wed Jan 16 18:30:12 2002
@@ -0,0 +1,30 @@
+#ifndef __ALPHA_SCHED_H
+#define __ALPHA_SCHED_H
+
+/*
+ * Required for scheduler.
+ */
+
+#include <asm/bitops.h>
+
+#if MAX_RT_PRIO != 128 || MAX_PRIO != 168
+# error update this function.
+#endif
+
+static inline int
+sched_find_first_zero_bit(unsigned long *bitmap)
+{
+	unsigned long b0 = bitmap[0];
+	unsigned long b1 = bitmap[1];
+	unsigned long b2 = bitmap[2];
+	unsigned long ofs = MAX_RT_PRIO;
+
+	if (unlikely(~(b0 & b1) != 0)) {
+		b2 = (~b0 ? b0 : b1);
+		ofs = (~b0 ? 0 : 64);
+	}
+
+	return ffz(b2) + ofs;
+}
+
+#endif /* __ALPHA_SCHED_H */
--- 2.5.3p1/include/asm-alpha/mmu_context.h	Sat Dec 30 01:07:23 2000
+++ linux/include/asm-alpha/mmu_context.h	Wed Jan 16 18:30:12 2002
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <asm/system.h>
 #include <asm/machvec.h>
+#include <asm/sched.h>
 
 /*
  * Force a context reload. This is needed when we change the page
--- 2.5.3p1/drivers/pci/pci.c	Wed Jan 16 18:19:21 2002
+++ linux/drivers/pci/pci.c	Wed Jan 16 18:20:00 2002
@@ -23,6 +23,7 @@
 #include <linux/kmod.h>		/* for hotplug_path */
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
--- 2.5.3p1/arch/alpha/mm/fault.c	Tue Sep 18 03:15:02 2001
+++ linux/arch/alpha/mm/fault.c	Wed Jan 16 18:20:00 2002
@@ -196,8 +196,7 @@ no_context:
  */
 out_of_memory:
 	if (current->pid == 1) {
-		current->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
--- 2.5.3p1/arch/alpha/kernel/setup.c	Wed Dec 26 02:39:20 2001
+++ linux/arch/alpha/kernel/setup.c	Wed Jan 16 18:20:00 2002
@@ -437,7 +437,7 @@ static void srm_console_write(struct con
 static kdev_t srm_console_device(struct console *c)
 {
   /* Huh? */
-        return MKDEV(TTY_MAJOR, 64 + c->index);
+        return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 static int __init srm_console_setup(struct console *co, char *options)
--- 2.5.3p1/arch/alpha/kernel/srm_env.c	Sun Oct 21 21:20:57 2001
+++ linux/arch/alpha/kernel/srm_env.c	Wed Jan 16 18:20:00 2002
@@ -43,6 +43,7 @@
 #include <linux/proc_fs.h>
 #include <asm/console.h>
 #include <asm/uaccess.h>
+#include <asm/machvec.h>
 
 #define DIRNAME		"srm_environment"	/* Subdir in /proc/	*/
 #define VERSION		"0.0.2"			/* Module version	*/
--- 2.5.3p1/arch/alpha/kernel/pci-noop.c	Fri Jan  4 20:57:24 2002
+++ linux/arch/alpha/kernel/pci-noop.c	Wed Jan 16 18:20:00 2002
@@ -106,6 +106,7 @@ sys_pciconfig_write(unsigned long bus, u
 void *
 pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
 {
+	return NULL;
 }
 void
 pci_free_consistent(struct pci_dev *pdev, size_t size, void *cpu_addr,
@@ -116,6 +117,7 @@ dma_addr_t
 pci_map_single(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	       int direction)
 {
+	return 0;
 }
 void
 pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, size_t size,
--- 2.5.3p1/arch/alpha/kernel/process.c	Thu Dec 27 19:21:28 2001
+++ linux/arch/alpha/kernel/process.c	Wed Jan 16 19:51:24 2002
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/tty.h>
 #include <linux/console.h>
+#include <linux/init_task.h>
 
 #include <asm/reg.h>
 #include <asm/uaccess.h>
@@ -74,8 +75,6 @@ void
 cpu_idle(void)
 {
 	/* An endless idle loop with no priority at all.  */
-	current->nice = 20;
-
 	while (1) {
 		/* FIXME -- EV6 and LCA45 know how to power down
 		   the CPU.  */
--- 2.5.3p1/arch/alpha/kernel/smp.c	Wed Jan 16 18:16:19 2002
+++ linux/arch/alpha/kernel/smp.c	Wed Jan 16 18:20:00 2002
@@ -156,11 +156,6 @@ smp_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
 
-	if (current != init_tasks[cpu_number_map(cpuid)]) {
-		printk("BUG: smp_calling: cpu %d current %p init_tasks[cpu_number_map(cpuid)] %p\n",
-		       cpuid, current, init_tasks[cpu_number_map(cpuid)]);
-	}
-
 	DBGS(("CALLIN %d state 0x%lx\n", cpuid, current->state));
 
 	/* Turn on machine checks.  */
@@ -491,14 +486,11 @@ smp_boot_one_cpu(int cpuid, int cpunum)
 	if (idle == &init_task)
 		panic("idle process is init_task for CPU %d", cpuid);
 
-	idle->processor = cpuid;
-	idle->cpus_runnable = 1 << cpuid; /* we schedule the first task manually */
+	idle->cpu = cpuid;
 	__cpu_logical_map[cpunum] = cpuid;
 	__cpu_number_map[cpuid] = cpunum;
  
-	del_from_runqueue(idle);
 	unhash_process(idle);
-	init_tasks[cpunum] = idle;
 
 	DBGS(("smp_boot_one_cpu: CPU %d state 0x%lx flags 0x%lx\n",
 	      cpuid, idle->state, idle->flags));
@@ -605,17 +597,11 @@ smp_boot_cpus(void)
 
 	__cpu_number_map[boot_cpuid] = 0;
 	__cpu_logical_map[0] = boot_cpuid;
-	current->processor = boot_cpuid;
+	current->cpu = boot_cpuid;
 
 	smp_store_cpu_info(boot_cpuid);
 	smp_tune_scheduling(boot_cpuid);
 	smp_setup_percpu_timer(boot_cpuid);
-
-	init_idle();
-
-	/* ??? This should be in init_idle.  */
-	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
 
 	/* Nothing to do on a UP box, or when told not to.  */
 	if (smp_num_probed == 1 || max_cpus == 0) {
