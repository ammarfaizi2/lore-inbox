Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317766AbSGWExL>; Tue, 23 Jul 2002 00:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317951AbSGWExL>; Tue, 23 Jul 2002 00:53:11 -0400
Received: from holomorphy.com ([66.224.33.161]:27272 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317766AbSGWExJ>;
	Tue, 23 Jul 2002 00:53:09 -0400
Date: Mon, 22 Jul 2002 21:56:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com, rmk@arm.linux.org.uk
Subject: [BUG] 2.5.27-bk deadlocks every other boot
Message-ID: <20020723045608.GJ919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	rmk@arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like a fresh bug was recently introduced. Every other boot
my NUMA-Q testboxen deadlock just after a serial console printk() about
speed change or something on that order. It occurs nondeterministically
after userspace has run for a short while, during init scripts.

My current set of NUMA-Q workarounds follows as a combined diff (yes,
Martin, I know they're not what you'd like to merge but they should be
equivalent in functionality so far as fixing bootup problems goes).

rmk, I've cc:'d you in the hopes that some unmerged serial fix will
magically materialize.

Cheers,
Bill


===== arch/i386/config.in 1.42 vs edited =====
--- 1.42/arch/i386/config.in	Fri Jul 19 16:00:55 2002
+++ edited/arch/i386/config.in	Mon Jul 22 22:44:41 2002
@@ -165,7 +165,9 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   if [ "$CONFIG_PREEMPT" != "y" ]; then
+      bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   fi
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
===== arch/i386/vmlinux.lds 1.9 vs edited =====
--- 1.9/arch/i386/vmlinux.lds	Sun May 19 12:03:14 2002
+++ edited/arch/i386/vmlinux.lds	Mon Jul 22 22:49:39 2002
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
===== arch/i386/kernel/io_apic.c 1.23 vs edited =====
--- 1.23/arch/i386/kernel/io_apic.c	Sun Jul 21 09:09:17 2002
+++ edited/arch/i386/kernel/io_apic.c	Mon Jul 22 22:44:41 2002
@@ -219,7 +219,7 @@
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
 
-#if CONFIG_SMP
+#if CONFIG_SMP && !CONFIG_MULTIQUAD
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
 {
 	int search_idle = 1;
===== arch/i386/kernel/smp.c 1.18 vs edited =====
--- 1.18/arch/i386/kernel/smp.c	Mon Jul 15 10:03:02 2002
+++ edited/arch/i386/kernel/smp.c	Mon Jul 22 22:44:41 2002
@@ -569,7 +569,7 @@
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
 
-	if (!cpus)
+	if (cpus <= 0)
 		return 0;
 
 	data.func = func;
===== arch/i386/kernel/cpu/common.c 1.2 vs edited =====
--- 1.2/arch/i386/kernel/cpu/common.c	Mon Jul 15 10:03:21 2002
+++ edited/arch/i386/kernel/cpu/common.c	Mon Jul 22 22:44:41 2002
@@ -444,6 +444,8 @@
 	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 
+	printk(KERN_INFO "Loading GDT/IDT for CPU#%d\n", nr);
+
 	/*
 	 * Delete NT
 	 */
@@ -464,6 +466,8 @@
 	load_TR(nr);
 	load_LDT(&init_mm.context);
 
+	printk(KERN_INFO "Loaded per-cpu LDT/TSS for CPU#%d\n", nr);
+
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
@@ -481,4 +485,6 @@
 	clear_thread_flag(TIF_USEDFPU);
 	current->used_math = 0;
 	stts();
+
+	printk(KERN_INFO "Cleaned up FPU and debug regs for CPU#%d\n", nr);
 }
===== drivers/net/tulip/de2104x.c 1.5 vs edited =====
--- 1.5/drivers/net/tulip/de2104x.c	Thu Mar  7 01:42:39 2002
+++ edited/drivers/net/tulip/de2104x.c	Mon Jul 22 22:47:20 2002
@@ -1455,7 +1455,7 @@
 	/* Update the error counts. */
 	__de_get_stats(de);
 
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 	de_clean_rings(de);
 
 	de_init_hw(de);
===== drivers/scsi/qlogicisp.c 1.11 vs edited =====
--- 1.11/drivers/scsi/qlogicisp.c	Sun Jul 21 01:55:49 2002
+++ edited/drivers/scsi/qlogicisp.c	Mon Jul 22 22:49:12 2002
@@ -84,14 +84,13 @@
 {								\
 	unsigned long flags;					\
 								\
-	save_flags(flags);					\
-	cli();							\
+	local_irq_save(flags);					\
 	trace.buf[trace.next].name  = (w);			\
 	trace.buf[trace.next].time  = jiffies;			\
 	trace.buf[trace.next].index = (i);			\
 	trace.buf[trace.next].addr  = (long) (a);		\
 	trace.next = (trace.next + 1) & (TRACE_BUF_LEN - 1);	\
-	restore_flags(flags);					\
+	local_irq_restore(flags);				\
 }
 
 #else
@@ -1704,8 +1703,7 @@
 
 	ENTER("isp1020_load_parameters");
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	hwrev = isp_inw(host, ISP_CFG0) & ISP_CFG0_HWMSK;
 	isp_cfg1 = ISP_CFG1_F64 | ISP_CFG1_BENAB;
@@ -1724,7 +1722,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set initiator id failure\n");
 		return 1;
 	}
@@ -1736,7 +1734,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set retry count failure\n");
 		return 1;
 	}
@@ -1747,7 +1745,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : async data setup time failure\n");
 		return 1;
 	}
@@ -1759,7 +1757,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set active negation state failure\n");
 		return 1;
 	}
@@ -1771,7 +1769,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set pci control parameter failure\n");
 		return 1;
 	}
@@ -1782,7 +1780,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set tag age limit failure\n");
 		return 1;
 	}
@@ -1793,7 +1791,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set selection timeout failure\n");
 		return 1;
 	}
@@ -1812,7 +1810,7 @@
 		isp1020_mbox_command(host, param);
 
 		if (param[0] != MBOX_COMMAND_COMPLETE) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			printk("qlogicisp : set target parameter failure\n");
 			return 1;
 		}
@@ -1827,7 +1825,7 @@
 			isp1020_mbox_command(host, param);
 
 			if (param[0] != MBOX_COMMAND_COMPLETE) {
-				restore_flags(flags);
+				local_irq_restore(flags);
 				printk("qlogicisp : set device queue "
 				       "parameter failure\n");
 				return 1;
@@ -1854,7 +1852,7 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set response queue failure\n");
 		return 1;
 	}
@@ -1879,12 +1877,12 @@
 	isp1020_mbox_command(host, param);
 
 	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		printk("qlogicisp : set request queue failure\n");
 		return 1;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	LEAVE("isp1020_load_parameters");
 
===== fs/mpage.c 1.11 vs edited =====
--- 1.11/fs/mpage.c	Tue Jul 16 14:47:15 2002
+++ edited/fs/mpage.c	Mon Jul 22 22:44:41 2002
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
+++ edited/include/asm-i386/apicdef.h	Mon Jul 22 22:44:41 2002
@@ -108,7 +108,11 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
+#ifndef CONFIG_MULTIQUAD
 #define MAX_IO_APICS 8
+#else
+#define MAX_IO_APICS 1024
+#endif /* CONFIG_MULTIQUAD */
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well
