Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTBIMIS>; Sun, 9 Feb 2003 07:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTBIL7T>; Sun, 9 Feb 2003 06:59:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:63311
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267229AbTBIL5Q>; Sun, 9 Feb 2003 06:57:16 -0500
Date: Sun, 9 Feb 2003 07:06:02 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][4/15] smp_call_function/_on_cpu - ia64
Message-ID: <Pine.LNX.4.50.0302090551010.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ia64/kernel/palinfo.c |    2 -
 arch/ia64/kernel/perfmon.c |    2 -
 arch/ia64/kernel/smp.c     |   57 ++++++++++++++++++++++++++++-----------------
 arch/ia64/kernel/smpboot.c |    2 -
 include/asm-ia64/smp.h     |    2 -
 5 files changed, 39 insertions(+), 26 deletions(-)

Index: linux-2.5.59-bk/include/asm-ia64/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/include/asm-ia64/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.59-bk/include/asm-ia64/smp.h	9 Feb 2003 09:09:20 -0000	1.1.1.1
+++ linux-2.5.59-bk/include/asm-ia64/smp.h	9 Feb 2003 09:23:29 -0000
@@ -133,8 +133,6 @@
 extern void __init init_smp_config (void);
 extern void smp_do_timer (struct pt_regs *regs);
 
-extern int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
-				     int retry, int wait);
 extern void smp_send_reschedule (int cpu);
 extern void smp_send_reschedule_all (void);
 
Index: linux-2.5.59-bk/arch/ia64/kernel/palinfo.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/ia64/kernel/palinfo.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 palinfo.c
--- linux-2.5.59-bk/arch/ia64/kernel/palinfo.c	9 Feb 2003 09:08:23 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/ia64/kernel/palinfo.c	9 Feb 2003 09:23:29 -0000
@@ -867,7 +867,7 @@
 
 
 	/* will send IPI to other CPU and wait for completion of remote call */
-	if ((ret=smp_call_function_single(f->req_cpu, palinfo_smp_call, &ptr, 0, 1))) {
+	if ((ret=smp_call_function_single(f->req_cpu, palinfo_smp_call, &ptr, 1))) {
 		printk("palinfo: remote CPU call from %d to %d on function %d: error %d\n", smp_processor_id(), f->req_cpu, f->func_id, ret);
 		return 0;
 	}
Index: linux-2.5.59-bk/arch/ia64/kernel/perfmon.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/ia64/kernel/perfmon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 perfmon.c
--- linux-2.5.59-bk/arch/ia64/kernel/perfmon.c	9 Feb 2003 09:08:23 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/ia64/kernel/perfmon.c	9 Feb 2003 09:23:29 -0000
@@ -3268,7 +3268,7 @@
 	}
 
 	/* will send IPI to other CPU and wait for completion of remote call */
-	if ((ret=smp_call_function_single(cpu, pfm_handle_fetch_regs, &arg, 0, 1))) {
+	if ((ret=smp_call_function_single(cpu, pfm_handle_fetch_regs, &arg, 1))) {
 		printk("perfmon: remote CPU call from %d to %d error %d\n", smp_processor_id(), cpu, ret);
 		return;
 	}
Index: linux-2.5.59-bk/arch/ia64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/ia64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/ia64/kernel/smp.c	9 Feb 2003 09:08:23 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/ia64/kernel/smp.c	9 Feb 2003 09:23:29 -0000
@@ -17,6 +17,9 @@
  *  scheme.
  * 10/13/00 Goutham Rao <goutham.rao@intel.com> Updated smp_call_function and
  *		smp_call_function_single to resend IPI on timeouts
+ * 21/01/03 Zwane Mwaikambo <zwane@holomorphy.com> Removed extraneous 'retry/nonatomic'
+ *		parameter from smp_call_function* and introduced smp_call_function_on_cpu
+ *		in accordance with other architectures.
  */
 #define __KERNEL_SYSCALLS__
 
@@ -206,7 +209,7 @@
 void
 smp_flush_tlb_all (void)
 {
-	smp_call_function((void (*)(void *))local_flush_tlb_all, 0, 1, 1);
+	smp_call_function((void (*)(void *))local_flush_tlb_all, NULL, 1);
 	local_flush_tlb_all();
 }
 
@@ -226,31 +229,35 @@
 	 * anyhow, and once a CPU is interrupted, the cost of local_flush_tlb_all() is
 	 * rather trivial.
 	 */
-	smp_call_function((void (*)(void *))local_finish_flush_tlb_mm, mm, 1, 1);
+	smp_call_function((void (*)(void *))local_finish_flush_tlb_mm, mm, 1);
 }
 
 /*
- * Run a function on another CPU
- *  <func>	The function to run. This must be fast and non-blocking.
- *  <info>	An arbitrary pointer to pass to the function.
- *  <nonatomic>	Currently unused.
- *  <wait>	If true, wait until function has completed on other CPUs.
- *  [RETURNS]   0 on success, else a negative status code.
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
  *
- * Does not return until the remote CPU is nearly ready to execute <func>
- * or is or has executed.
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
  */
 
 int
-smp_call_function_single (int cpuid, void (*func) (void *info), void *info, int nonatomic,
-			  int wait)
+smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
 {
 	struct call_data_struct data;
-	int cpus = 1;
+	int num_cpus = hweight64(mask), cpu, i;
 
-	if (cpuid == smp_processor_id()) {
-		printk("%s: trying to call self\n", __FUNCTION__);
-		return -EBUSY;
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
 	}
 
 	data.func = func;
@@ -264,21 +271,30 @@
 
 	call_data = &data;
 	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
-  	send_IPI_single(cpuid, IPI_CALL_FUNC);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			send_IPI_single(i, IPI_CALL_FUNC);
+	}
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data.started) != num_cpus)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data.finished) != num_cpus)
 			barrier();
 	call_data = NULL;
 
 	spin_unlock_bh(&call_lock);
+	put_cpu_no_resched();
 	return 0;
 }
 
+int smp_call_function_single (int cpuid, void (*func) (void *info), void *info, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, 1UL << cpuid);
+}
+
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
@@ -288,7 +304,6 @@
  *  [SUMMARY]	Run a function on all other CPUs.
  *  <func>	The function to run. This must be fast and non-blocking.
  *  <info>	An arbitrary pointer to pass to the function.
- *  <nonatomic>	currently unused.
  *  <wait>	If true, wait (atomically) until function has completed on other CPUs.
  *  [RETURNS]   0 on success, else a negative status code.
  *
@@ -299,7 +314,7 @@
  * hardware interrupt handler or from a bottom half handler.
  */
 int
-smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait)
+smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
Index: linux-2.5.59-bk/arch/ia64/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/ia64/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smpboot.c
--- linux-2.5.59-bk/arch/ia64/kernel/smpboot.c	9 Feb 2003 09:08:23 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/ia64/kernel/smpboot.c	9 Feb 2003 09:23:29 -0000
@@ -203,7 +203,7 @@
 
 	go[MASTER] = 1;
 
-	if (smp_call_function_single(master, sync_master, NULL, 1, 0) < 0) {
+	if (smp_call_function_single(master, sync_master, NULL, 0) < 0) {
 		printk("sync_itc: failed to get attention of CPU %u!\n", master);
 		return;
 	}
