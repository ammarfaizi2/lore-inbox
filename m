Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936951AbWLDOyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936951AbWLDOyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936921AbWLDOye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:54:34 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:22393 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936945AbWLDOy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:54:27 -0500
Date: Mon, 4 Dec 2006 15:54:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] cpu shutdown rework
Message-ID: <20061204145422.GS32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] cpu shutdown rework

Let one master cpu kill all other cpus instead of sending an external
interrupt to all other cpus so they can kill themselves.
Simplifies reipl/shutdown functions a lot.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c           |   24 ---------
 arch/s390/kernel/machine_kexec.c |   65 ++++++------------------
 arch/s390/kernel/smp.c           |  104 +++++++++++----------------------------
 drivers/s390/char/sclp_quiesce.c |   37 -------------
 include/asm-s390/smp.h           |    8 +++
 5 files changed, 58 insertions(+), 180 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-04 14:50:50.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-04 14:50:50.000000000 +0100
@@ -576,23 +576,6 @@ static struct subsys_attribute dump_type
 
 static decl_subsys(dump, NULL, NULL);
 
-#ifdef CONFIG_SMP
-static void dump_smp_stop_all(void)
-{
-	int cpu;
-	preempt_disable();
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		while (signal_processor(cpu, sigp_stop) == sigp_busy)
-			udelay(10);
-	}
-	preempt_enable();
-}
-#else
-#define dump_smp_stop_all() do { } while (0)
-#endif
-
 /*
  * Shutdown actions section
  */
@@ -724,13 +707,13 @@ static void do_dump(void)
 
 	switch (dump_method) {
 	case IPL_METHOD_CCW_CIO:
-		dump_smp_stop_all();
+		smp_send_stop();
 		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
 		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
 	case IPL_METHOD_CCW_VM:
-		dump_smp_stop_all();
+		smp_send_stop();
 		sprintf(buf, "STORE STATUS");
 		__cpcmd(buf, NULL, 0, NULL);
 		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
@@ -1059,9 +1042,6 @@ void s390_reset_system(void)
 {
 	struct _lowcore *lc;
 
-	/* Disable all interrupts/machine checks */
-	__load_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK);
-
 	/* Stack for interrupt/machine check handler */
 	lc = (struct _lowcore *)(unsigned long) store_prefix();
 	lc->panic_stack = S390_lowcore.panic_stack;
diff -urpN linux-2.6/arch/s390/kernel/machine_kexec.c linux-2.6-patched/arch/s390/kernel/machine_kexec.c
--- linux-2.6/arch/s390/kernel/machine_kexec.c	2006-12-04 14:50:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/machine_kexec.c	2006-12-04 14:50:50.000000000 +0100
@@ -1,15 +1,10 @@
 /*
  * arch/s390/kernel/machine_kexec.c
  *
- * (C) Copyright IBM Corp. 2005
+ * Copyright IBM Corp. 2005,2006
  *
- * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
- *
- */
-
-/*
- * s390_machine_kexec.c - handle the transition of Linux booting another kernel
- * on the S390 architecture.
+ * Author(s): Rolf Adelsberger,
+ *	      Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
 #include <linux/device.h>
@@ -24,81 +19,53 @@
 #include <asm/smp.h>
 #include <asm/reset.h>
 
-static void kexec_halt_all_cpus(void *);
-
-typedef void (*relocate_kernel_t) (kimage_entry_t *, unsigned long);
+typedef void (*relocate_kernel_t)(kimage_entry_t *, unsigned long);
 
 extern const unsigned char relocate_kernel[];
 extern const unsigned long long relocate_kernel_len;
 
-int
-machine_kexec_prepare(struct kimage *image)
+int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long reboot_code_buffer;
+	void *reboot_code_buffer;
 
 	/* We don't support anything but the default image type for now. */
 	if (image->type != KEXEC_TYPE_DEFAULT)
 		return -EINVAL;
 
 	/* Get the destination where the assembler code should be copied to.*/
-	reboot_code_buffer = page_to_pfn(image->control_code_page)<<PAGE_SHIFT;
+	reboot_code_buffer = (void *) page_to_phys(image->control_code_page);
 
 	/* Then copy it */
-	memcpy((void *) reboot_code_buffer, relocate_kernel,
-	       relocate_kernel_len);
+	memcpy(reboot_code_buffer, relocate_kernel, relocate_kernel_len);
 	return 0;
 }
 
-void
-machine_kexec_cleanup(struct kimage *image)
+void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void
-machine_shutdown(void)
+void machine_shutdown(void)
 {
 	printk(KERN_INFO "kexec: machine_shutdown called\n");
 }
 
-NORET_TYPE void
-machine_kexec(struct kimage *image)
-{
-	on_each_cpu(kexec_halt_all_cpus, image, 0, 0);
-	for (;;);
-}
-
 extern void pfault_fini(void);
 
-static void
-kexec_halt_all_cpus(void *kernel_image)
+void machine_kexec(struct kimage *image)
 {
-	static atomic_t cpuid = ATOMIC_INIT(-1);
-	int cpu;
-	struct kimage *image;
 	relocate_kernel_t data_mover;
 
+	preempt_disable();
 #ifdef CONFIG_PFAULT
 	if (MACHINE_IS_VM)
 		pfault_fini();
 #endif
-
-	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) != -1)
-		signal_processor(smp_processor_id(), sigp_stop);
-
-	/* Wait for all other cpus to enter stopped state */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		while (!smp_cpu_not_running(cpu))
-			cpu_relax();
-	}
-
+	smp_send_stop();
 	s390_reset_system();
 
-	image = (struct kimage *) kernel_image;
-	data_mover = (relocate_kernel_t)
-		(page_to_pfn(image->control_code_page) << PAGE_SHIFT);
+	data_mover = (relocate_kernel_t) page_to_phys(image->control_code_page);
 
 	/* Call the moving routine */
-	(*data_mover) (&image->head, image->start);
+	(*data_mover)(&image->head, image->start);
+	for (;;);
 }
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-12-04 14:50:50.000000000 +0100
@@ -230,18 +230,37 @@ static inline void do_store_status(void)
         }
 }
 
+static inline void do_wait_for_stop(void)
+{
+	int cpu;
+
+	/* Wait for all other cpus to enter stopped state */
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		while(!smp_cpu_not_running(cpu))
+			cpu_relax();
+	}
+}
+
 /*
  * this function sends a 'stop' sigp to all other CPUs in the system.
  * it goes straight through.
  */
 void smp_send_stop(void)
 {
+	/* Disable all interrupts/machine checks */
+	__load_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK);
+
         /* write magic number to zero page (absolute 0) */
 	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
 
 	/* stop other processors. */
 	do_send_stop();
 
+	/* wait until other processors are stopped */
+	do_wait_for_stop();
+
 	/* store status of other processors. */
 	do_store_status();
 }
@@ -250,88 +269,28 @@ void smp_send_stop(void)
  * Reboot, halt and power_off routines for SMP.
  */
 
-static void do_machine_restart(void * __unused)
-{
-	int cpu;
-	static atomic_t cpuid = ATOMIC_INIT(-1);
-
-	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) != -1)
-		signal_processor(smp_processor_id(), sigp_stop);
-
-	/* Wait for all other cpus to enter stopped state */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		while(!smp_cpu_not_running(cpu))
-			cpu_relax();
-	}
-
-	/* Store status of other cpus. */
-	do_store_status();
-
-	/*
-	 * Finally call reipl. Because we waited for all other
-	 * cpus to enter this function we know that they do
-	 * not hold any s390irq-locks (the cpus have been
-	 * interrupted by an external interrupt and s390irq
-	 * locks are always held disabled).
-	 */
-	do_reipl();
-}
-
 void machine_restart_smp(char * __unused) 
 {
-        on_each_cpu(do_machine_restart, NULL, 0, 0);
-}
-
-static void do_wait_for_stop(void)
-{
-	unsigned long cr[16];
-
-	__ctl_store(cr, 0, 15);
-	cr[0] &= ~0xffff;
-	cr[6] = 0;
-	__ctl_load(cr, 0, 15);
-	for (;;)
-		enabled_wait();
-}
-
-static void do_machine_halt(void * __unused)
-{
-	static atomic_t cpuid = ATOMIC_INIT(-1);
-
-	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) == -1) {
-		smp_send_stop();
-		if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
-			cpcmd(vmhalt_cmd, NULL, 0, NULL);
-		signal_processor(smp_processor_id(),
-				 sigp_stop_and_store_status);
-	}
-	do_wait_for_stop();
+	smp_send_stop();
+	do_reipl();
 }
 
 void machine_halt_smp(void)
 {
-        on_each_cpu(do_machine_halt, NULL, 0, 0);
-}
-
-static void do_machine_power_off(void * __unused)
-{
-	static atomic_t cpuid = ATOMIC_INIT(-1);
-
-	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) == -1) {
-		smp_send_stop();
-		if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
-			cpcmd(vmpoff_cmd, NULL, 0, NULL);
-		signal_processor(smp_processor_id(),
-				 sigp_stop_and_store_status);
-	}
-	do_wait_for_stop();
+	smp_send_stop();
+	if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
+		__cpcmd(vmhalt_cmd, NULL, 0, NULL);
+	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
+	for (;;);
 }
 
 void machine_power_off_smp(void)
 {
-        on_each_cpu(do_machine_power_off, NULL, 0, 0);
+	smp_send_stop();
+	if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
+		__cpcmd(vmpoff_cmd, NULL, 0, NULL);
+	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
+	for (;;);
 }
 
 /*
@@ -860,4 +819,3 @@ EXPORT_SYMBOL(smp_ctl_clear_bit);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_get_cpu);
 EXPORT_SYMBOL(smp_put_cpu);
-
diff -urpN linux-2.6/drivers/s390/char/sclp_quiesce.c linux-2.6-patched/drivers/s390/char/sclp_quiesce.c
--- linux-2.6/drivers/s390/char/sclp_quiesce.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_quiesce.c	2006-12-04 14:50:50.000000000 +0100
@@ -19,52 +19,17 @@
 
 #include "sclp.h"
 
-
-#ifdef CONFIG_SMP
-/* Signal completion of shutdown process. All CPUs except the first to enter
- * this function: go to stopped state. First CPU: wait until all other
- * CPUs are in stopped or check stop state. Afterwards, load special PSW
- * to indicate completion. */
-static void
-do_load_quiesce_psw(void * __unused)
-{
-	static atomic_t cpuid = ATOMIC_INIT(-1);
-	psw_t quiesce_psw;
-	int cpu;
-
-	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) != -1)
-		signal_processor(smp_processor_id(), sigp_stop);
-	/* Wait for all other cpus to enter stopped state */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		while(!smp_cpu_not_running(cpu))
-			cpu_relax();
-	}
-	/* Quiesce the last cpu with the special psw */
-	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
-	quiesce_psw.addr = 0xfff;
-	__load_psw(quiesce_psw);
-}
-
-/* Shutdown handler. Perform shutdown function on all CPUs. */
-static void
-do_machine_quiesce(void)
-{
-	on_each_cpu(do_load_quiesce_psw, NULL, 0, 0);
-}
-#else
 /* Shutdown handler. Signal completion of shutdown by loading special PSW. */
 static void
 do_machine_quiesce(void)
 {
 	psw_t quiesce_psw;
 
+	smp_send_stop();
 	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
 	quiesce_psw.addr = 0xfff;
 	__load_psw(quiesce_psw);
 }
-#endif
 
 /* Handler for quiesce event. Start shutdown procedure. */
 static void
diff -urpN linux-2.6/include/asm-s390/smp.h linux-2.6-patched/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/smp.h	2006-12-04 14:50:50.000000000 +0100
@@ -18,6 +18,7 @@
 
 #include <asm/lowcore.h>
 #include <asm/sigp.h>
+#include <asm/ptrace.h>
 
 /*
   s390 specific smp.c headers
@@ -101,6 +102,13 @@ smp_call_function_on(void (*func) (void 
 	func(info);
 	return 0;
 }
+
+static inline void smp_send_stop(void)
+{
+	/* Disable all interrupts/machine checks */
+	__load_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK);
+}
+
 #define smp_cpu_not_running(cpu)	1
 #define smp_get_cpu(cpu) ({ 0; })
 #define smp_put_cpu(cpu) ({ 0; })
