Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUIONNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUIONNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUIONNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:13:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12220 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265996AbUIOMzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:55:32 -0400
Date: Wed, 15 Sep 2004 18:25:25 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][4/6]Register snapshotting before kexec boot
Message-ID: <20040915125525.GE15450@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com> <20040915125422.GD15450@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <20040915125422.GD15450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-reg-269rc1-mm5.patch"



This patch contains the code for stopping the other cpus and snapshotting
their register values before doing the kexec reboot.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>


---

 linux-2.6.9-rc1-hari/arch/i386/kernel/Makefile                   |    1 
 linux-2.6.9-rc1-hari/arch/i386/kernel/crash_dump.c               |  101 ++++++++++
 linux-2.6.9-rc1-hari/arch/i386/kernel/machine_kexec.c            |    4 
 linux-2.6.9-rc1-hari/arch/i386/kernel/smp.c                      |   13 +
 linux-2.6.9-rc1-hari/include/asm-i386/crash_dump.h               |   41 +++-
 linux-2.6.9-rc1-hari/include/asm-i386/mach-default/irq_vectors.h |    1 
 linux-2.6.9-rc1-hari/include/asm-i386/smp.h                      |    1 
 7 files changed, 160 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/Makefile~kd-reg-269rc1-mm5 arch/i386/kernel/Makefile
--- linux-2.6.9-rc1/arch/i386/kernel/Makefile~kd-reg-269rc1-mm5	2004-09-15 17:36:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/kernel/Makefile	2004-09-15 17:36:37.000000000 +0530
@@ -25,6 +25,7 @@ obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff -puN /dev/null arch/i386/kernel/crash_dump.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/kernel/crash_dump.c	2004-09-15 17:36:37.000000000 +0530
@@ -0,0 +1,101 @@
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
+struct pt_regs crash_smp_regs[NR_CPUS];
+long crash_smp_current_task[NR_CPUS];
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
+	crash_smp_current_task[cpu] = (long)current;
+	crash_smp_regs[cpu] = *regs;
+}
+
diff -puN arch/i386/kernel/machine_kexec.c~kd-reg-269rc1-mm5 arch/i386/kernel/machine_kexec.c
--- linux-2.6.9-rc1/arch/i386/kernel/machine_kexec.c~kd-reg-269rc1-mm5	2004-09-15 17:36:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/kernel/machine_kexec.c	2004-09-15 17:36:37.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/crash_dump.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -194,6 +195,9 @@ void machine_kexec(struct kimage *image)
 	unsigned long reboot_code_buffer;
 	relocate_new_kernel_t rnk;
 
+	crash_dump_stop_cpus();
+	crash_dump_save_registers();
+
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
diff -puN arch/i386/kernel/smp.c~kd-reg-269rc1-mm5 arch/i386/kernel/smp.c
--- linux-2.6.9-rc1/arch/i386/kernel/smp.c~kd-reg-269rc1-mm5	2004-09-15 17:36:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/kernel/smp.c	2004-09-15 17:36:37.000000000 +0530
@@ -143,6 +143,9 @@ void __send_IPI_shortcut(unsigned int sh
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
@@ -489,6 +495,11 @@ void smp_send_reschedule(int cpu)
 	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
 }
 
+void crash_dump_send_ipi(void)
+{
+	send_IPI_allbutself(CRASH_DUMP_VECTOR);
+}
+
 /*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
@@ -565,7 +576,7 @@ int smp_call_function (void (*func) (voi
 	return 0;
 }
 
-static void stop_this_cpu (void * dummy)
+void stop_this_cpu (void * dummy)
 {
 	/*
 	 * Remove this CPU:
diff -puN include/asm-i386/crash_dump.h~kd-reg-269rc1-mm5 include/asm-i386/crash_dump.h
--- linux-2.6.9-rc1/include/asm-i386/crash_dump.h~kd-reg-269rc1-mm5	2004-09-15 17:36:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/asm-i386/crash_dump.h	2004-09-15 17:36:37.000000000 +0530
@@ -1,5 +1,7 @@
 /* asm-i386/crash_dump.h */
 #include <linux/bootmem.h>
+#include <asm/hw_irq.h>
+#include <asm/apic.h>
 
 extern unsigned int dump_enabled;
 
@@ -8,6 +10,11 @@ unsigned long __init find_max_low_pfn(vo
 void __init find_max_pfn(void);
 
 extern unsigned int crashed;
+extern struct pt_regs crash_smp_regs[NR_CPUS];
+extern long crash_smp_current_task[NR_CPUS];
+extern void crash_dump_save_this_cpu(struct pt_regs *, int);
+extern void __crash_dump_stop_cpus(void);
+extern void crash_get_current_regs(struct pt_regs *regs);
 
 #ifdef CONFIG_CRASH_DUMP
 #define CRASH_BACKUP_BASE ((unsigned long)CONFIG_BACKUP_BASE * 0x100000)
@@ -32,13 +39,45 @@ static inline void crash_reserve_bootmem
 	if (!dump_enabled) {
 		reserve_bootmem(0, CRASH_RELOCATE_SIZE);
 		reserve_bootmem(CRASH_BACKUP_BASE,
-			CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE);
+			CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE + PAGE_SIZE);
 	}
 }
+
+static inline void crash_dump_stop_cpus(void)
+{
+	if (!crashed)
+		return;
+
+	int cpu = smp_processor_id();
+
+	crash_smp_current_task[cpu] = (long)current;
+	crash_get_current_regs(&crash_smp_regs[cpu]);
+
+	/* This also captures the register states of the other cpus */
+	__crash_dump_stop_cpus();
+#if defined(CONFIG_X86_IO_APIC)
+	disable_IO_APIC();
+#endif
+#if defined(CONFIG_X86_LOCAL_APIC)
+	disconnect_bsp_APIC();
+#endif
+}
+
+static inline void crash_dump_save_registers(void)
+{
+	void *addr;
+
+	addr = __va(CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE);
+	memcpy(addr, crash_smp_regs, (sizeof(struct pt_regs)*NR_CPUS));
+	addr += sizeof(struct pt_regs)*NR_CPUS;
+	memcpy(addr, crash_smp_current_task, (sizeof(long)*NR_CPUS));
+}
 #else
 #define CRASH_BACKUP_BASE 0x6000000
 #define CRASH_BACKUP_SIZE 0x1000000
 #define crash_relocate_mem() do { } while(0)
 #define set_saved_max_pfn() do { } while(0)
 #define crash_reserve_bootmem() do { } while(0)
+#define crash_dump_stop_cpus() do { } while(0)
+#define crash_dump_save_registers() do { } while(0)
 #endif
diff -puN include/asm-i386/mach-default/irq_vectors.h~kd-reg-269rc1-mm5 include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.9-rc1/include/asm-i386/mach-default/irq_vectors.h~kd-reg-269rc1-mm5	2004-09-15 17:36:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/asm-i386/mach-default/irq_vectors.h	2004-09-15 17:36:37.000000000 +0530
@@ -48,6 +48,7 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define CRASH_DUMP_VECTOR	0xfa
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*
diff -puN include/asm-i386/smp.h~kd-reg-269rc1-mm5 include/asm-i386/smp.h
--- linux-2.6.9-rc1/include/asm-i386/smp.h~kd-reg-269rc1-mm5	2004-09-15 17:36:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/asm-i386/smp.h	2004-09-15 17:36:37.000000000 +0530
@@ -41,6 +41,7 @@ extern void smp_message_irq(int cpl, voi
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
+extern void stop_this_cpu(void *);
 
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];

_

--pZs/OQEoSSbxGlYw--
