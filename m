Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUHQM3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUHQM3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHQM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:29:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59637 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266085AbUHQM2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:28:44 -0400
Date: Tue, 17 Aug 2004 17:39:11 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][4/6]Register snapshotting before kexec-boot
Message-ID: <20040817120911.GE3916@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com> <20040817120809.GD3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20040817120809.GD3916@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-reg-268.patch"



This patch contains the code for stopping the other cpus and snapshotting
their register values before doing the kexec reboot.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>


---

 linux-2.6.8.1-hari/arch/i386/kernel/Makefile                   |    1 
 linux-2.6.8.1-hari/arch/i386/kernel/crash_dump.c               |   98 ++++++++++
 linux-2.6.8.1-hari/arch/i386/kernel/machine_kexec.c            |   14 +
 linux-2.6.8.1-hari/arch/i386/kernel/smp.c                      |   13 +
 linux-2.6.8.1-hari/include/asm-i386/crash_dump.h               |   32 +++
 linux-2.6.8.1-hari/include/asm-i386/mach-default/irq_vectors.h |    1 
 linux-2.6.8.1-hari/include/asm-i386/smp.h                      |    1 
 7 files changed, 156 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/Makefile~kd-reg-268 arch/i386/kernel/Makefile
--- linux-2.6.8.1/arch/i386/kernel/Makefile~kd-reg-268	2004-08-17 17:08:08.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/kernel/Makefile	2004-08-17 17:08:18.000000000 +0530
@@ -24,6 +24,7 @@ obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_MODULES)		+= module.o
diff -puN /dev/null arch/i386/kernel/crash_dump.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/kernel/crash_dump.c	2004-08-17 17:08:34.000000000 +0530
@@ -0,0 +1,98 @@
+/*
+ * Architecture specific (i386) functions for kexec based crash dumps.
+ *
+ * Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *
+ * Copyright (C) IBM Corporation, 2004. All rights reserved.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+
+#include <asm/crash_dump.h>
+#include <asm/processor.h>
+#include <asm/hardirq.h>
+#include <asm/nmi.h>
+#include <asm/hw_irq.h>
+
+#ifdef CONFIG_SMP
+static atomic_t waiting_for_dump_ipi;
+static int crash_dump_expect_ipi[NR_CPUS];
+extern void crash_dump_send_ipi(void);
+extern void stop_this_cpu(void *);
+
+static int crash_dump_nmi_callback(struct pt_regs *regs, int cpu)
+{
+	if (!crash_dump_expect_ipi[cpu])
+		return 0;
+
+	crash_dump_expect_ipi[cpu] = 0;
+	crash_dump_save_this_cpu(regs, cpu);
+	atomic_dec(&waiting_for_dump_ipi);
+
+	stop_this_cpu(NULL);
+
+	return 1;
+}
+
+void __crash_dump_stop_cpus(void)
+{
+	int i, cpu = smp_processor_id();
+	int other_cpus = num_online_cpus()-1;
+
+	if (other_cpus > 0) {
+		atomic_set(&waiting_for_dump_ipi, other_cpus);
+
+		for (i = 0; i < NR_CPUS; i++)
+			crash_dump_expect_ipi[i] = (i != cpu && cpu_online(i));
+
+		set_nmi_callback(crash_dump_nmi_callback);
+		/* Ensure the new callback function is set before sending
+		 * out the IPI
+		 */
+		wmb();
+
+		crash_dump_send_ipi();
+		while (atomic_read(&waiting_for_dump_ipi) > 0)
+			cpu_relax();
+
+		unset_nmi_callback();
+	} else {
+		local_irq_disable();
+		disable_local_APIC();
+		local_irq_enable();
+	}
+}
+#else
+void __crash_dump_stop_cpus(void) {}
+#endif
+
+void crash_get_current_regs(struct pt_regs *regs)
+{
+	__asm__ __volatile__("movl %%ebx,%0" : "=m"(regs->ebx));
+	__asm__ __volatile__("movl %%ecx,%0" : "=m"(regs->ecx));
+	__asm__ __volatile__("movl %%edx,%0" : "=m"(regs->edx));
+	__asm__ __volatile__("movl %%esi,%0" : "=m"(regs->esi));
+	__asm__ __volatile__("movl %%edi,%0" : "=m"(regs->edi));
+	__asm__ __volatile__("movl %%ebp,%0" : "=m"(regs->ebp));
+	__asm__ __volatile__("movl %%eax,%0" : "=m"(regs->eax));
+	__asm__ __volatile__("movl %%esp,%0" : "=m"(regs->esp));
+	__asm__ __volatile__("movw %%ss, %%ax;" :"=a"(regs->xss));
+	__asm__ __volatile__("movw %%cs, %%ax;" :"=a"(regs->xcs));
+	__asm__ __volatile__("movw %%ds, %%ax;" :"=a"(regs->xds));
+	__asm__ __volatile__("movw %%es, %%ax;" :"=a"(regs->xes));
+	__asm__ __volatile__("pushfl; popl %0" :"=m"(regs->eflags));
+
+	regs->eip = (unsigned long)current_text_addr();
+}
+
+void crash_dump_save_this_cpu(struct pt_regs *regs, int cpu)
+{
+	crash_smp_current_task[cpu] = (int)current;
+	crash_smp_regs[cpu] = *regs;
+}
+
diff -puN arch/i386/kernel/machine_kexec.c~kd-reg-268 arch/i386/kernel/machine_kexec.c
--- linux-2.6.8.1/arch/i386/kernel/machine_kexec.c~kd-reg-268	2004-08-17 17:08:08.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/kernel/machine_kexec.c	2004-08-17 17:08:18.000000000 +0530
@@ -17,8 +17,9 @@
 #include <asm/io.h>
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
-#include <asm/hw_irq.h>
 
+struct pt_regs crash_smp_regs[NR_CPUS];
+u32 crash_smp_current_task[NR_CPUS];
 
 static void set_idt(void *newidt, __u16 limit)
 {
@@ -97,6 +98,14 @@ void __relocate_base_mem(unsigned long b
 		if (PageReserved(page))
 			copy_page(dest_addr, src_addr);
 	}
+
+	/* Now copy over the saved task pointers and the registers
+	 * to the end of the  reserved area
+	 */
+	dest_addr = (void *)(__va(CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE));
+	memcpy(dest_addr, crash_smp_regs, (sizeof(struct pt_regs)*NR_CPUS));
+	dest_addr += sizeof(struct pt_regs)*NR_CPUS;
+	memcpy(dest_addr, crash_smp_current_task, (sizeof(u32)*NR_CPUS));
 }
 
 /*
@@ -111,7 +120,8 @@ void machine_kexec(struct kimage *image)
 
 	/* switch to an mm where the reboot_code_buffer is identity mapped */
 	use_mm(&init_mm);
-	stop_apics();
+
+	crash_dump_stop_cpus();
 
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
diff -puN arch/i386/kernel/smp.c~kd-reg-268 arch/i386/kernel/smp.c
--- linux-2.6.8.1/arch/i386/kernel/smp.c~kd-reg-268	2004-08-17 17:08:08.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/kernel/smp.c	2004-08-17 17:08:18.000000000 +0530
@@ -143,6 +143,9 @@ inline void __send_IPI_shortcut(unsigned
 	 */
 	cfg = __prepare_ICR(shortcut, vector);
 
+	if (vector == CRASH_DUMP_VECTOR)
+		cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
+
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
 	 */
@@ -221,6 +224,9 @@ inline void send_IPI_mask_sequence(cpuma
 			 */
 			cfg = __prepare_ICR(0, vector);
 			
+			if (vector == CRASH_DUMP_VECTOR)
+				cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
+
 			/*
 			 * Send the IPI. The write to APIC_ICR fires this off.
 			 */
@@ -467,6 +473,11 @@ void flush_tlb_all(void)
 	on_each_cpu(do_flush_tlb_all, NULL, 1, 1);
 }
 
+void crash_dump_send_ipi(void)
+{
+	send_IPI_allbutself(CRASH_DUMP_VECTOR);
+}
+
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
@@ -548,7 +559,7 @@ int smp_call_function (void (*func) (voi
 	return 0;
 }
 
-static void stop_this_cpu (void * dummy)
+void stop_this_cpu (void * dummy)
 {
 	/*
 	 * Remove this CPU:
diff -puN include/asm-i386/crash_dump.h~kd-reg-268 include/asm-i386/crash_dump.h
--- linux-2.6.8.1/include/asm-i386/crash_dump.h~kd-reg-268	2004-08-17 17:08:09.000000000 +0530
+++ linux-2.6.8.1-hari/include/asm-i386/crash_dump.h	2004-08-17 17:08:18.000000000 +0530
@@ -1,5 +1,7 @@
 /* asm-i386/crash_dump.h */
 #include <linux/bootmem.h>
+#include <asm/hw_irq.h>
+#include <asm/apic.h>
 
 extern unsigned int dump_enabled;
 
@@ -8,6 +10,11 @@ void __init find_max_pfn(void);
 void __relocate_base_mem(unsigned long, unsigned long);
 
 extern unsigned int crashed;
+extern struct pt_regs crash_smp_regs[NR_CPUS];
+extern u32 crash_smp_current_task[NR_CPUS];
+extern void crash_dump_save_this_cpu(struct pt_regs *, int);
+extern void __crash_dump_stop_cpus(void);
+extern void crash_get_current_regs(struct pt_regs *regs);
 
 #ifdef CONFIG_CRASH_DUMP
 #define CRASH_BACKUP_BASE ((unsigned long)CONFIG_BACKUP_BASE * 0x100000)
@@ -28,7 +35,26 @@ static inline void set_saved_max_pfn(voi
 static inline void crash_reserve_bootmem(void)
 {
 	if (!dump_enabled)
-		reserve_bootmem(CRASH_BACKUP_BASE, CRASH_BACKUP_SIZE);
+		reserve_bootmem(CRASH_BACKUP_BASE, CRASH_BACKUP_SIZE + PAGE_SIZE);
+}
+
+static inline void crash_dump_stop_cpus(void)
+{
+	if (!crashed)
+	stop_apics();
+	else {
+		int cpu = smp_processor_id();
+
+		crash_smp_current_task[cpu] = (int)current;
+		crash_get_current_regs(&crash_smp_regs[cpu]);
+
+		/* This also captures the register states of the other cpus */
+		__crash_dump_stop_cpus();
+#if defined(CONFIG_X86_IO_APIC)
+		disable_IO_APIC();
+#endif
+		disconnect_bsp_APIC();
+	}
 }
 #else
 #define CRASH_BACKUP_BASE 0x08000000
@@ -36,4 +62,8 @@ static inline void crash_reserve_bootmem
 static inline void relocate_base_mem(void) {}
 static inline void set_saved_max_pfn(void) {}
 static inline void crash_reserve_bootmem(void) {}
+static inline void crash_dump_stop_cpus(void)
+{
+	stop_apics();
+}
 #endif
diff -puN include/asm-i386/mach-default/irq_vectors.h~kd-reg-268 include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.8.1/include/asm-i386/mach-default/irq_vectors.h~kd-reg-268	2004-08-17 17:08:09.000000000 +0530
+++ linux-2.6.8.1-hari/include/asm-i386/mach-default/irq_vectors.h	2004-08-17 17:08:18.000000000 +0530
@@ -48,6 +48,7 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define CRASH_DUMP_VECTOR	0xfa
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*
diff -puN include/asm-i386/smp.h~kd-reg-268 include/asm-i386/smp.h
--- linux-2.6.8.1/include/asm-i386/smp.h~kd-reg-268	2004-08-17 17:08:09.000000000 +0530
+++ linux-2.6.8.1-hari/include/asm-i386/smp.h	2004-08-17 17:08:18.000000000 +0530
@@ -41,6 +41,7 @@ extern void smp_message_irq(int cpl, voi
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
+extern void stop_this_cpu(void *);
 
 #define MAX_APICID 256
 

_

--M38YqGLZlgb6RLPS--
