Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318875AbSG1B3l>; Sat, 27 Jul 2002 21:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318876AbSG1B3l>; Sat, 27 Jul 2002 21:29:41 -0400
Received: from holomorphy.com ([66.224.33.161]:17829 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318875AbSG1B3g>;
	Sat, 27 Jul 2002 21:29:36 -0400
Date: Sat, 27 Jul 2002 18:32:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com, gone@us.ibm.com, colpatch@us.ibm.com,
       zwane@linuxpower.ca, mingo@elte.hu, rusty@rustcorp.com.au,
       rmk@arm.linux.org.uk
Subject: 2.5.29 NUMA-Q minimal workaround updates
Message-ID: <20020728013234.GG2907@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	gone@us.ibm.com, colpatch@us.ibm.com, zwane@linuxpower.ca,
	mingo@elte.hu, rusty@rustcorp.com.au, rmk@arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my latest set of combined workarounds and fixes to get my
machines to boot. Without them, booting is impossible. These are the
"minimalistic" ones for easy porting, but unfortunately new and serious
issues have been introduced (addressed by the "hotplug fixes" and the
do_IRQ() fix), so they're a wee bit more heavyweight than I'd like. If
there are better equivalents (as there are for the xquad_portio stuff
and balance_irq() stuff) then please push them instead. I've tried to
note the ones where superior methods of dealing with the issues exist
in the changelog below. One issue not addressed by this patch is the
overflow of zone->zone_start_paddr with fix from Pat Gaughen pending.

Zwane, I've cc:'d you as you appear to have a strong interest in APIC
manipulation code. Martin, you're the NUMA-Q maintainer. =) Pat, you've
got pending fixes and arch support you're working on that may hit this
stuff later on in boot. Matt, one of your patches is the "superior
method of dealing with the issue" mentioned in the description of the
patch component.

Ingo, Rusty, & Russell, you're included so whatever objections you
might have to your fixes being bundled here may be voiced.

This has successfully compiled, booted, and run 2.5.29 on elm3b17
(16 cpus, 16GB RAM NUMA-Q) in combination testing with some stealth
patches I'm working on. Expect offsets and/or fuzz.

Many thanks to Ingo Molnar, Rusty Russell, and Russell King for their
rapid responses to bugreports and quick fixing of the bugs in this release.

This patch is left monolithic as the "real fixes" I myself (among
others) would like to have merged are still pending. Linus, please
*don't* apply.

Flame on!

(1)  comment out the /DISCARD/ line in arch/i386/vmlinux.lds to
	kill all the link errors in one stroke
	workaround, do not merge

(2)  #ifdef out balance_irq()
	superior equivalent exists, do not merge
	IO-APIC's are configured to use physical APIC ID's, not
	clustered hierachical. Physical mode interrupts are not
	cross-node routable on NUMA-Q, and connectivity information
	to restrict the interrupt affinity bindings is unavailable.
	Superior fix due to Matt Dobson, not included here.

(3)  make smp_call_function() deal with num_cpus_online() == 0
	superior equivalent exists, do not merge
	Real answer is either moving xquad_portio ioremap to after
	cpus_online_map is initialized or to force initialization to
	cpu 0 being online before the call.
	Real fix due to Martin Bligh, not included here.

(4)  call printk() to get delays in cpu_init()
	blatant workaround not fixing fundamental issue, do not merge
	Pat Mochel and H. Peter Anvin slated to investigate the
	Heisenbug but starved for time, someone please help. This one
	is non-deterministic.
	No real fix exists.

(5)  fix typo in arch/i386/mm/init.c pagetable init for PAE
	trivial fix, missing 'p' in a variable name.

(6)  synchronize_irq() for acenic
	trivial compilefix, pass dev->irq to it

(7)  synchronize_irq() for ns83820
	trivial compilefix, pass dev->irq to it

(8)  synchronize_irq() for sb1250-mac
	trivial compilefix, pass dev->irq to it

(9)  synchronize_irq() for e1000
	trivial compilefix, pass adapter->pdev->irq to it

(10) synchronize_irq() for NCR53C9x
	trivial compilefix, pass esp->irq to it

(11) use akpm's workaround for MPAGE_BIO_MAX_SIZE
	blatant workaround not fixing fundamental issue, do not merge
	bio splitting is required to deal with qlogicisp's constraints
	on sglist length
	Real fix due to Adam Richter (and/or Jens Axboe), not included here.

(12) bump up MAX_IO_APICS to 1024
	MAX_IO_APICS is 8, but 28+ IO-APIC appear 8+ quad configurations.
	Martin, Zwane, we've seen some bad IO-APIC stuff come out of the
	affected code, I'll leave it up to Martin to decide when the time
	is right to deal with this.
	Do not merge, pending Martin Bligh's (NUMA-Q maintainer) decision

(13) rusty's hotplug fixes
	pending desperately-needed bugfix, please merge

(14) mingo's hotplug fixes
	pending desperately-needed bugfix, please merge

(15) mingo's do_irq()/synchronize_irq() fixes
	pending desperately-needed bugfix, please merge


Cheers,
Bill


===== arch/i386/vmlinux.lds 1.9 vs edited =====
--- 1.9/arch/i386/vmlinux.lds	Sun May 19 12:03:14 2002
+++ edited/arch/i386/vmlinux.lds	Sat Jul 27 06:49:59 2002
@@ -84,11 +84,13 @@
   _end = . ;
 
   /* Sections to be discarded */
+  /*
   /DISCARD/ : {
 	*(.text.exit)
 	*(.data.exit)
 	*(.exitcall.exit)
 	}
+  */
 
   /* Stabs debugging sections.  */
   .stab 0 : { *(.stab) }
===== arch/i386/kernel/i8259.c 1.13 vs edited =====
--- 1.13/arch/i386/kernel/i8259.c	Mon Jun 10 16:03:24 2002
+++ edited/arch/i386/kernel/i8259.c	Sat Jul 27 15:21:51 2002
@@ -38,7 +38,8 @@
 
 static void end_8259A_irq (unsigned int irq)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
+							irq_desc[irq].action)
 		enable_8259A_irq(irq);
 }
 
===== arch/i386/kernel/io_apic.c 1.24 vs edited =====
--- 1.24/arch/i386/kernel/io_apic.c	Mon Jul 22 12:55:00 2002
+++ edited/arch/i386/kernel/io_apic.c	Sat Jul 27 06:49:59 2002
@@ -219,7 +219,7 @@
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
 
-#if CONFIG_SMP
+#if CONFIG_SMP && !CONFIG_MULTIQUAD
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
 {
 	int search_idle = 1;
===== arch/i386/kernel/irq.c 1.15 vs edited =====
--- 1.15/arch/i386/kernel/irq.c	Wed Jul 24 03:00:19 2002
+++ edited/arch/i386/kernel/irq.c	Sat Jul 27 15:21:51 2002
@@ -187,10 +187,6 @@
 #if CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
-	/* is there anything to synchronize with? */
-	if (!irq_desc[irq].action)
-		return;
-
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
 		cpu_relax();
 }
@@ -350,7 +346,7 @@
 	 * use the action we have.
 	 */
 	action = NULL;
-	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
 		action = desc->action;
 		status &= ~IRQ_PENDING; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
@@ -363,7 +359,7 @@
 	   a different instance of this same irq, the other processor
 	   will take care of it.
 	 */
-	if (!action)
+	if (unlikely(!action))
 		goto out;
 
 	/*
@@ -381,12 +377,12 @@
 		handle_IRQ_event(irq, &regs, action);
 		spin_lock(&desc->lock);
 		
-		if (!(desc->status & IRQ_PENDING))
+		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
 	}
-	desc->status &= ~IRQ_INPROGRESS;
 out:
+	desc->status &= ~IRQ_INPROGRESS;
 	/*
 	 * The ->end() handler has to deal with interrupts which got
 	 * disabled while the handler was running.
===== arch/i386/kernel/smp.c 1.22 vs edited =====
--- 1.22/arch/i386/kernel/smp.c	Fri Jul 26 00:53:45 2002
+++ edited/arch/i386/kernel/smp.c	Sat Jul 27 06:49:59 2002
@@ -566,7 +566,7 @@
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
 
-	if (!cpus)
+	if (cpus <= 0)
 		return 0;
 
 	data.func = func;
===== arch/i386/kernel/cpu/common.c 1.4 vs edited =====
--- 1.4/arch/i386/kernel/cpu/common.c	Thu Jul 25 08:37:42 2002
+++ edited/arch/i386/kernel/cpu/common.c	Sat Jul 27 06:49:59 2002
@@ -454,6 +454,8 @@
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 
+	printk(KERN_INFO "Loading GDT/IDT for CPU#%d\n", cpu);
+
 	/*
 	 * Delete NT
 	 */
@@ -474,6 +476,8 @@
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
+	printk(KERN_INFO "Loaded per-cpu LDT/TSS for CPU#%d\n", cpu);
+
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
@@ -491,4 +495,6 @@
 	clear_thread_flag(TIF_USEDFPU);
 	current->used_math = 0;
 	stts();
+
+	printk(KERN_INFO "Cleaned up FPU and debug regs for CPU#%d\n", cpu);
 }
===== arch/i386/mm/init.c 1.22 vs edited =====
--- 1.22/arch/i386/mm/init.c	Fri Jul 26 12:07:32 2002
+++ edited/arch/i386/mm/init.c	Sat Jul 27 06:49:59 2002
@@ -54,7 +54,7 @@
 		
 #if CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pgd(pgd, __pgd(__pa(md_table) | _PAGE_PRESENT));
+	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	if (pmd_table != pmd_offset(pgd, 0)) 
 		BUG();
 #else
===== drivers/net/acenic.c 1.24 vs edited =====
--- 1.24/drivers/net/acenic.c	Wed Jul 24 03:00:19 2002
+++ edited/drivers/net/acenic.c	Sat Jul 27 08:29:15 2002
@@ -856,7 +856,7 @@
 		 * Then release the RX buffers - jumbo buffers were
 		 * already released in ace_close().
 		 */
-		synchronize_irq();
+		synchronize_irq(dev->irq);
 
 		for (i = 0; i < RX_STD_RING_ENTRIES; i++) {
 			struct sk_buff *skb = ap->skb->rx_std_skbuff[i].skb;
@@ -2877,7 +2877,7 @@
 		}
 	} else {
 		while (test_and_set_bit(0, &ap->jumbo_refill_busy));
-		synchronize_irq();
+		synchronize_irq(dev->irq);
 		ace_set_rxtx_parms(dev, 0);
 		if (ap->jumbo) {
 			struct cmd cmd;
===== drivers/net/ns83820.c 1.12 vs edited =====
--- 1.12/drivers/net/ns83820.c	Mon Jun 10 15:07:50 2002
+++ edited/drivers/net/ns83820.c	Sat Jul 27 08:30:29 2002
@@ -755,7 +755,7 @@
 
 	/* synchronize with the interrupt handler and kill it */
 	dev->rx_info.up = 0;
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 
 	/* touch the pci bus... */
 	readl(dev->base + IMR);
@@ -1296,11 +1296,11 @@
 	readl(dev->base + IER);
 
 	dev->rx_info.up = 0;
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 
 	ns83820_do_reset(dev, CR_RST);
 
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 
 	dev->IMR_cache &= ~(ISR_TXURN | ISR_TXIDLE | ISR_TXERR | ISR_TXDESC | ISR_TXOK);
 	ns83820_cleanup_rx(dev);
===== drivers/net/sb1250-mac.c 1.1 vs edited =====
--- 1.1/drivers/net/sb1250-mac.c	Sun Mar  3 09:54:35 2002
+++ edited/drivers/net/sb1250-mac.c	Sat Jul 27 08:30:56 2002
@@ -2544,7 +2544,7 @@
 	spin_unlock_irqrestore(&sc->sbm_lock, flags);
 	
 	/* Make sure there is no irq-handler running on a different CPU. */
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 	
 	free_irq(dev->irq, dev);
 	
===== drivers/net/e1000/e1000_main.c 1.21 vs edited =====
--- 1.21/drivers/net/e1000/e1000_main.c	Wed May 29 22:51:53 2002
+++ edited/drivers/net/e1000/e1000_main.c	Sat Jul 27 08:27:00 2002
@@ -1699,7 +1699,7 @@
 {
 	atomic_inc(&adapter->irq_sem);
 	E1000_WRITE_REG(&adapter->hw, IMC, ~0);
-	synchronize_irq();
+	synchronize_irq(adapter->pdev->irq);
 }
 
 /**
===== drivers/scsi/NCR53C9x.c 1.8 vs edited =====
--- 1.8/drivers/scsi/NCR53C9x.c	Sun Jun  9 09:32:34 2002
+++ edited/drivers/scsi/NCR53C9x.c	Sat Jul 27 08:32:04 2002
@@ -1381,7 +1381,7 @@
 	don = esp->dma_ports_p(esp);
 	if(don) {
 		esp->dma_ints_off(esp);
-		synchronize_irq();
+		synchronize_irq(esp->irq);
 	}
 	if(esp->issue_SC) {
 		Scsi_Cmnd **prev, *this;
===== fs/mpage.c 1.11 vs edited =====
--- 1.11/fs/mpage.c	Tue Jul 16 14:47:15 2002
+++ edited/fs/mpage.c	Sat Jul 27 06:49:59 2002
@@ -24,7 +24,7 @@
  * The largest-sized BIO which this code will assemble, in bytes.  Set this
  * to PAGE_CACHE_SIZE if your drivers are broken.
  */
-#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
+#define MPAGE_BIO_MAX_SIZE PAGE_CACHE_SIZE
 
 /*
  * I/O completion handler for multipage BIOs.
===== include/asm-i386/apicdef.h 1.3 vs edited =====
--- 1.3/include/asm-i386/apicdef.h	Wed Mar 27 16:05:30 2002
+++ edited/include/asm-i386/apicdef.h	Sat Jul 27 06:49:59 2002
@@ -108,7 +108,11 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
+#ifndef CONFIG_MULTIQUAD
 #define MAX_IO_APICS 8
+#else
+#define MAX_IO_APICS 1024
+#endif /* CONFIG_MULTIQUAD */
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well
===== init/main.c 1.52 vs edited =====
--- 1.52/init/main.c	Sat Jul 27 06:42:24 2002
+++ edited/init/main.c	Sat Jul 27 16:12:33 2002
@@ -527,6 +527,19 @@
 	do_initcalls();
 }
 
+static void do_pre_smp_initcalls(void)
+{
+#if CONFIG_SMP
+	extern int migration_init(void);
+#endif
+	extern int spawn_ksoftirqd(void);
+
+#if CONFIG_SMP
+	migration_init();
+#endif
+	spawn_ksoftirqd();
+}
+
 extern void prepare_namespace(void);
 
 static int init(void * unused)
@@ -536,6 +549,9 @@
 	lock_kernel();
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
+
+	do_pre_smp_initcalls();
+
 	smp_init();
 	do_basic_setup();
 
===== kernel/sched.c 1.113 vs edited =====
--- 1.113/kernel/sched.c	Mon Jul 22 17:23:12 2002
+++ edited/kernel/sched.c	Sat Jul 27 16:12:33 2002
@@ -16,19 +16,23 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  */
 
+#define __KERNEL_SYSCALLS__
+
 #include <linux/mm.h>
 #include <linux/nmi.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
+#include <linux/delay.h>
+#include <linux/unistd.h>
 #include <linux/highmem.h>
+#include <linux/security.h>
+#include <linux/notifier.h>
 #include <linux/smp_lock.h>
-#include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
-#include <linux/security.h>
-#include <linux/notifier.h>
-#include <linux/delay.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1816,18 +1820,57 @@
 	preempt_enable();
 }
 
+/*
+ * The migration thread startup relies on the following property
+ * of set_cpus_allowed(): if the thread is not running currently
+ * then we can just put it into the target runqueue.
+ */
+DECLARE_MUTEX_LOCKED(migration_startup);
+
+typedef struct migration_startup_data {
+	int cpu;
+	task_t *thread;
+} migration_startup_t;
+
+static int migration_startup_thread(void * data)
+{
+	migration_startup_t *startup = data;
+
+	wait_task_inactive(startup->thread);
+	set_cpus_allowed(startup->thread, 1UL << startup->cpu);
+	up(&migration_startup);
+
+	return 0;
+}
+
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = (int) (long) bind_cpu;
 	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
+	migration_startup_t startup;
 	runqueue_t *rq;
-	int ret;
+	int ret, pid;
 
 	daemonize();
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	set_cpus_allowed(current, 1UL << cpu);
+	startup.cpu = cpu;
+	startup.thread = current;
+	pid = kernel_thread(migration_startup_thread, &startup,
+		CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	down(&migration_startup);
+
+	/* we need to waitpid() to release the helper thread */
+	waitpid(pid, NULL, __WCLONE);
+
+	/*
+	 * At this point the startup helper thread must have
+	 * migrated us to the proper CPU already:
+	 */
+	if (smp_processor_id() != (int)bind_cpu)
+		BUG();
+
 	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
@@ -1888,12 +1931,15 @@
 			  unsigned long action,
 			  void *hcpu)
 {
+	unsigned long cpu = (unsigned long)hcpu;
+
 	switch (action) {
 	case CPU_ONLINE:
-		printk("Starting migration thread for cpu %li\n",
-		       (long)hcpu);
-		kernel_thread(migration_thread, hcpu,
+		printk("Starting migration thread for cpu %li\n", cpu);
+		kernel_thread(migration_thread, (void *)cpu,
 			      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+		while (!cpu_rq(cpu)->migration_thread)
+			yield();
 		break;
 	}
 	return NOTIFY_OK;
@@ -1901,7 +1947,7 @@
 
 static struct notifier_block migration_notifier = { &migration_call, NULL, 0 };
 
-int __init migration_init(void)
+__init int migration_init(void)
 {
 	/* Start one for boot CPU. */
 	migration_call(&migration_notifier, CPU_ONLINE,
@@ -1910,7 +1956,6 @@
 	return 0;
 }
 
-__initcall(migration_init);
 #endif
 
 extern void init_timervecs(void);
===== kernel/softirq.c 1.21 vs edited =====
--- 1.21/kernel/softirq.c	Mon Jul 22 17:22:41 2002
+++ edited/kernel/softirq.c	Sat Jul 27 16:12:27 2002
@@ -410,11 +410,9 @@
 
 static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
 
-static __init int spawn_ksoftirqd(void)
+__init int spawn_ksoftirqd(void)
 {
 	cpu_callback(&cpu_nfb, CPU_ONLINE, (void *)smp_processor_id());
 	register_cpu_notifier(&cpu_nfb);
 	return 0;
 }
-
-__initcall(spawn_ksoftirqd);
