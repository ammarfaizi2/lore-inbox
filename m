Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTBIMIR>; Sun, 9 Feb 2003 07:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbTBIL7u>; Sun, 9 Feb 2003 06:59:50 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:61519
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267227AbTBIL47>; Sun, 9 Feb 2003 06:56:59 -0500
Date: Sun, 9 Feb 2003 07:05:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][3/15] smp_call_function/_on_cpu - i386
Message-ID: <Pine.LNX.4.50.0302090549410.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 kernel/cpu/mcheck/non-fatal.c |    2 -
 kernel/cpu/mtrr/main.c        |    2 -
 kernel/cpuid.c                |    2 -
 kernel/io_apic.c              |    4 +-
 kernel/ldt.c                  |    2 -
 kernel/microcode.c            |    2 -
 kernel/msr.c                  |    4 +-
 kernel/reboot.c               |    2 -
 kernel/smp.c                  |   64 ++++++++++++++++++++++++++++++++++++++----
 kernel/sysenter.c             |    2 -
 mach-voyager/voyager_smp.c    |    8 +----
 mm/pageattr.c                 |    2 -
 oprofile/nmi_int.c            |    8 ++---
 13 files changed, 78 insertions(+), 26 deletions(-)

Index: linux-2.5.59-bk/arch/i386/kernel/cpuid.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/cpuid.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpuid.c
--- linux-2.5.59-bk/arch/i386/kernel/cpuid.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/cpuid.c	9 Feb 2003 09:23:29 -0000
@@ -71,7 +71,7 @@
     cmd.reg  = reg;
     cmd.data = data;
     
-    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
+    smp_call_function(cpuid_smp_cpuid, &cmd, 1);
   }
 }
 #else /* ! CONFIG_SMP */
Index: linux-2.5.59-bk/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io_apic.c
--- linux-2.5.59-bk/arch/i386/kernel/io_apic.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/io_apic.c	9 Feb 2003 09:23:29 -0000
@@ -1049,7 +1049,7 @@
 
 void print_all_local_APICs (void)
 {
-	smp_call_function(print_local_APIC, NULL, 1, 1);
+	smp_call_function(print_local_APIC, NULL, 1);
 	print_local_APIC(NULL);
 }
 
@@ -1524,7 +1524,7 @@
 	 */ 
 	printk(KERN_INFO "activating NMI Watchdog ...");
 
-	smp_call_function(enable_NMI_through_LVT0, NULL, 1, 1);
+	smp_call_function(enable_NMI_through_LVT0, NULL, 1);
 	enable_NMI_through_LVT0(NULL);
 
 	printk(" done.\n");
Index: linux-2.5.59-bk/arch/i386/kernel/ldt.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/ldt.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ldt.c
--- linux-2.5.59-bk/arch/i386/kernel/ldt.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/ldt.c	9 Feb 2003 09:23:29 -0000
@@ -59,7 +59,7 @@
 #ifdef CONFIG_SMP
 		preempt_disable();
 		if (current->mm->cpu_vm_mask != (1 << smp_processor_id()))
-			smp_call_function(flush_ldt, 0, 1, 1);
+			smp_call_function(flush_ldt, 0, 1);
 		preempt_enable();
 #endif
 	}
Index: linux-2.5.59-bk/arch/i386/kernel/microcode.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/microcode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 microcode.c
--- linux-2.5.59-bk/arch/i386/kernel/microcode.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/microcode.c	9 Feb 2003 09:23:29 -0000
@@ -183,7 +183,7 @@
 	int i, error = 0, err;
 	struct microcode *m;
 
-	if (smp_call_function(do_update_one, NULL, 1, 1) != 0) {
+	if (smp_call_function(do_update_one, NULL, 1) != 0) {
 		printk(KERN_ERR "microcode: IPI timeout, giving up\n");
 		return -EIO;
 	}
Index: linux-2.5.59-bk/arch/i386/kernel/msr.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/msr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 msr.c
--- linux-2.5.59-bk/arch/i386/kernel/msr.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/msr.c	9 Feb 2003 09:23:29 -0000
@@ -124,7 +124,7 @@
     cmd.data[0] = eax;
     cmd.data[1] = edx;
     
-    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
+    smp_call_function(msr_smp_wrmsr, &cmd, 1);
     return cmd.err;
   }
 }
@@ -139,7 +139,7 @@
     cmd.cpu = cpu;
     cmd.reg = reg;
 
-    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
+    smp_call_function(msr_smp_rdmsr, &cmd, 1);
     
     *eax = cmd.data[0];
     *edx = cmd.data[1];
Index: linux-2.5.59-bk/arch/i386/kernel/reboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/reboot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 reboot.c
--- linux-2.5.59-bk/arch/i386/kernel/reboot.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/reboot.c	9 Feb 2003 09:23:29 -0000
@@ -243,7 +243,7 @@
 		   cleared reboot_smp, and do the reboot if it is the
 		   correct CPU, otherwise it halts. */
 		if (reboot_cpu != cpuid)
-			smp_call_function((void *)machine_restart , NULL, 1, 0);
+			smp_call_function((void *)machine_restart , NULL, 0);
 	}
 
 	/* if reboot_cpu is still -1, then we want a tradional reboot, 
Index: linux-2.5.59-bk/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/i386/kernel/smp.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/smp.c	9 Feb 2003 09:23:29 -0000
@@ -452,7 +452,7 @@
 
 void flush_tlb_all(void)
 {
-	smp_call_function (flush_tlb_all_ipi,0,1,1);
+	smp_call_function (flush_tlb_all_ipi,0,1);
 
 	do_flush_tlb_all_local();
 }
@@ -499,13 +499,11 @@
  * in the system.
  */
 
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-			int wait)
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 /*
  * [SUMMARY] Run a function on all other CPUs.
  * <func> The function to run. This must be fast and non-blocking.
  * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
  * <wait> If true, wait (atomically) until function has completed on other CPUs.
  * [RETURNS] 0 on success, else a negative status code. Does not return until
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
@@ -545,6 +543,62 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info,
+				int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int num_cpus = hweight32(mask), cpu;
+
+	if (num_cpus == 0)
+		return -EINVAL;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	wmb();
+
+	/* Send a message to the CPUs in the mask and wait for them to respond */
+	send_IPI_mask_sequence(mask, CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		cpu_relax();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			cpu_relax();
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
@@ -564,7 +618,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 
 	local_irq_disable();
 	disable_local_APIC();
Index: linux-2.5.59-bk/arch/i386/kernel/sysenter.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/sysenter.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sysenter.c
--- linux-2.5.59-bk/arch/i386/kernel/sysenter.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/sysenter.c	9 Feb 2003 09:23:29 -0000
@@ -96,7 +96,7 @@
 
 	memcpy((void *) page, sysent, sizeof(sysent));
 	enable_sep_cpu(NULL);
-	smp_call_function(enable_sep_cpu, NULL, 1, 1);
+	smp_call_function(enable_sep_cpu, NULL, 1);
 	return 0;
 }
 
Index: linux-2.5.59-bk/arch/i386/kernel/cpu/mcheck/non-fatal.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/cpu/mcheck/non-fatal.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 non-fatal.c
--- linux-2.5.59-bk/arch/i386/kernel/cpu/mcheck/non-fatal.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/cpu/mcheck/non-fatal.c	9 Feb 2003 09:23:29 -0000
@@ -49,7 +49,7 @@
 
 static void do_mce_timer(void *data)
 { 
-	smp_call_function (mce_checkregs, NULL, 1, 1);
+	smp_call_function (mce_checkregs, NULL, 1);
 } 
 
 static DECLARE_WORK(mce_work, do_mce_timer, NULL);
Index: linux-2.5.59-bk/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/kernel/cpu/mtrr/main.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 main.c
--- linux-2.5.59-bk/arch/i386/kernel/cpu/mtrr/main.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/kernel/cpu/mtrr/main.c	9 Feb 2003 09:23:29 -0000
@@ -224,7 +224,7 @@
 	atomic_set(&data.gate,0);
 
 	/*  Start the ball rolling on other CPUs  */
-	if (smp_call_function(ipi_handler, &data, 1, 0) != 0)
+	if (smp_call_function(ipi_handler, &data, 0) != 0)
 		panic("mtrr: timed out waiting for other CPUs\n");
 
 	local_irq_save(flags);
Index: linux-2.5.59-bk/arch/i386/mach-voyager/voyager_smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/mach-voyager/voyager_smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 voyager_smp.c
--- linux-2.5.59-bk/arch/i386/mach-voyager/voyager_smp.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/mach-voyager/voyager_smp.c	9 Feb 2003 09:23:29 -0000
@@ -1091,14 +1091,12 @@
 /* Call this function on all CPUs using the function_interrupt above 
     <func> The function to run. This must be fast and non-blocking.
     <info> An arbitrary pointer to pass to the function.
-    <retry> If true, keep retrying until ready.
     <wait> If true, wait until function has completed on other CPUs.
     [RETURNS] 0 on success, else a negative status code. Does not return until
     remote CPUs are nearly ready to execute <<func>> or are or have executed.
 */
 int
-smp_call_function (void (*func) (void *info), void *info, int retry,
-		   int wait)
+smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	__u32 mask = cpu_online_map;
@@ -1233,7 +1231,7 @@
 void
 flush_tlb_all(void)
 {
-	smp_call_function (flush_tlb_all_function, 0, 1, 1);
+	smp_call_function (flush_tlb_all_function, 0, 1);
 
 	do_flush_tlb_all_local();
 }
@@ -1276,7 +1274,7 @@
 void
 smp_send_stop(void)
 {
-	smp_call_function(smp_stop_cpu_function, NULL, 1, 1);
+	smp_call_function(smp_stop_cpu_function, NULL, 1);
 }
 
 /* this function is triggered in time.c when a clock tick fires
Index: linux-2.5.59-bk/arch/i386/mm/pageattr.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/mm/pageattr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pageattr.c
--- linux-2.5.59-bk/arch/i386/mm/pageattr.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/mm/pageattr.c	9 Feb 2003 09:23:29 -0000
@@ -132,7 +132,7 @@
 static inline void flush_map(void)
 {	
 #ifdef CONFIG_SMP 
-	smp_call_function(flush_kernel_map, NULL, 1, 1);
+	smp_call_function(flush_kernel_map, NULL, 1);
 #endif	
 	flush_kernel_map(NULL);
 }
Index: linux-2.5.59-bk/arch/i386/oprofile/nmi_int.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/i386/oprofile/nmi_int.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 nmi_int.c
--- linux-2.5.59-bk/arch/i386/oprofile/nmi_int.c	9 Feb 2003 09:08:22 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/i386/oprofile/nmi_int.c	9 Feb 2003 09:23:29 -0000
@@ -95,7 +95,7 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
-	smp_call_function(nmi_cpu_setup, NULL, 0, 1);
+	smp_call_function(nmi_cpu_setup, NULL, 1);
 	nmi_cpu_setup(0);
 	set_nmi_callback(nmi_callback);
 	oprofile_pmdev = set_nmi_pm_callback(oprofile_pm_callback);
@@ -148,7 +148,7 @@
 {
 	unset_nmi_pm_callback(oprofile_pmdev);
 	unset_nmi_callback();
-	smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
+	smp_call_function(nmi_cpu_shutdown, NULL, 1);
 	nmi_cpu_shutdown(0);
 }
 
@@ -162,7 +162,7 @@
 
 static int nmi_start(void)
 {
-	smp_call_function(nmi_cpu_start, NULL, 0, 1);
+	smp_call_function(nmi_cpu_start, NULL, 1);
 	nmi_cpu_start(0);
 	return 0;
 }
@@ -177,7 +177,7 @@
  
 static void nmi_stop(void)
 {
-	smp_call_function(nmi_cpu_stop, NULL, 0, 1);
+	smp_call_function(nmi_cpu_stop, NULL, 1);
 	nmi_cpu_stop(0);
 }
 
