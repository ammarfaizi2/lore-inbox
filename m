Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTBIMK7>; Sun, 9 Feb 2003 07:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBIMJR>; Sun, 9 Feb 2003 07:09:17 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:8272
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267221AbTBIL7C>; Sun, 9 Feb 2003 06:59:02 -0500
Date: Sun, 9 Feb 2003 07:07:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][14/15] smp_call_function/_on_cpu - x86_64
Message-ID: <Pine.LNX.4.50.0302090659000.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 kernel/bluesmoke.c |    2 -
 kernel/cpuid.c     |    2 -
 kernel/io_apic.c   |    2 -
 kernel/ldt.c       |    2 -
 kernel/msr.c       |    4 +--
 kernel/reboot.c    |    2 -
 kernel/smp.c       |   65 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 mm/pageattr.c      |    2 -
 8 files changed, 68 insertions(+), 13 deletions(-)

Index: linux-2.5.59-bk/arch/x86_64/kernel/bluesmoke.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/bluesmoke.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 bluesmoke.c
--- linux-2.5.59-bk/arch/x86_64/kernel/bluesmoke.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/bluesmoke.c	9 Feb 2003 09:23:30 -0000
@@ -138,7 +138,7 @@
 		if (i == smp_processor_id())
 			mce_checkregs(&i);
 		else
-			smp_call_function (mce_checkregs, &i, 1, 1);
+			smp_call_function (mce_checkregs, &i, 1);
 	}
 
 	/* Refresh the timer. */
Index: linux-2.5.59-bk/arch/x86_64/kernel/cpuid.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/cpuid.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpuid.c
--- linux-2.5.59-bk/arch/x86_64/kernel/cpuid.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/cpuid.c	9 Feb 2003 09:23:30 -0000
@@ -71,7 +71,7 @@
     cmd.reg  = reg;
     cmd.data = data;
     
-    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
+    smp_call_function(cpuid_smp_cpuid, &cmd, 1);
   }
 }
 #else /* ! CONFIG_SMP */
Index: linux-2.5.59-bk/arch/x86_64/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io_apic.c
--- linux-2.5.59-bk/arch/x86_64/kernel/io_apic.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/io_apic.c	9 Feb 2003 09:23:30 -0000
@@ -926,7 +926,7 @@
 
 void print_all_local_APICs (void)
 {
-	smp_call_function(print_local_APIC, NULL, 1, 1);
+	smp_call_function(print_local_APIC, NULL, 1);
 	print_local_APIC(NULL);
 }
 
Index: linux-2.5.59-bk/arch/x86_64/kernel/ldt.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/ldt.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ldt.c
--- linux-2.5.59-bk/arch/x86_64/kernel/ldt.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/ldt.c	9 Feb 2003 09:23:30 -0000
@@ -64,7 +64,7 @@
 #ifdef CONFIG_SMP
 		preempt_disable();
 		if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
-			smp_call_function(flush_ldt, 0, 1, 1);
+			smp_call_function(flush_ldt, NULL, 1);
 		preempt_enable();
 #endif
 	}
Index: linux-2.5.59-bk/arch/x86_64/kernel/msr.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/msr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 msr.c
--- linux-2.5.59-bk/arch/x86_64/kernel/msr.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/msr.c	9 Feb 2003 09:23:30 -0000
@@ -125,7 +125,7 @@
     cmd.data[0] = eax;
     cmd.data[1] = edx;
     
-    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
+    smp_call_function(msr_smp_wrmsr, &cmd, 1);
     return cmd.err;
   }
 }
@@ -140,7 +140,7 @@
     cmd.cpu = cpu;
     cmd.reg = reg;
 
-    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
+    smp_call_function(msr_smp_rdmsr, &cmd, 1);
     
     *eax = cmd.data[0];
     *edx = cmd.data[1];
Index: linux-2.5.59-bk/arch/x86_64/kernel/reboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/reboot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 reboot.c
--- linux-2.5.59-bk/arch/x86_64/kernel/reboot.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/reboot.c	9 Feb 2003 09:23:30 -0000
@@ -88,7 +88,7 @@
 		   cleared reboot_smp, and do the reboot if it is the
 		   correct CPU, otherwise it halts. */
 		if (reboot_cpu != cpuid)
-			smp_call_function((void *)machine_restart , NULL, 1, 0);
+			smp_call_function((void *)machine_restart , NULL, 0);
 	}
 
 	/* if reboot_cpu is still -1, then we want a tradional reboot, 
Index: linux-2.5.59-bk/arch/x86_64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/x86_64/kernel/smp.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/kernel/smp.c	9 Feb 2003 09:23:30 -0000
@@ -343,7 +343,7 @@
 
 void flush_tlb_all(void)
 {
-	smp_call_function (flush_tlb_all_ipi,0,1,1);
+	smp_call_function (flush_tlb_all_ipi,NULL,1);
 
 	do_flush_tlb_all_local();
 }
@@ -385,13 +385,10 @@
  * in the system.
  */
 
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-			int wait)
 /*
  * [SUMMARY] Run a function on all other CPUs.
  * <func> The function to run. This must be fast and non-blocking.
  * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
  * <wait> If true, wait (atomically) until function has completed on other CPUs.
  * [RETURNS] 0 on success, else a negative status code. Does not return until
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
@@ -399,6 +396,8 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
@@ -431,6 +430,62 @@
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
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
+{
+	struct call_data_struct data;
+	int i, cpu, num_cpus = hweight64(mask);
+
+	if (num_cpus == 0)
+		return 0;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return 0;
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
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			barrier();
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
@@ -449,7 +504,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 
 	local_irq_disable();
 	disable_local_APIC();
Index: linux-2.5.59-bk/arch/x86_64/mm/pageattr.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/x86_64/mm/pageattr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pageattr.c
--- linux-2.5.59-bk/arch/x86_64/mm/pageattr.c	9 Feb 2003 09:08:39 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/x86_64/mm/pageattr.c	9 Feb 2003 09:23:30 -0000
@@ -124,7 +124,7 @@
 static inline void flush_map(unsigned long address)
 {	
 #ifdef CONFIG_SMP 
-	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
+	smp_call_function(flush_kernel_map, (void *)address, 1);
 #endif	
 	flush_kernel_map((void *)address);
 }
