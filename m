Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTBIMBD>; Sun, 9 Feb 2003 07:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTBIMAc>; Sun, 9 Feb 2003 07:00:32 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:4176
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267245AbTBIL6V>; Sun, 9 Feb 2003 06:58:21 -0500
Date: Sun, 9 Feb 2003 07:07:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][10/15] smp_call_function/_on_cpu - s390
Message-ID: <Pine.LNX.4.50.0302090652460.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 66 insertions(+), 9 deletions(-)

Index: linux-2.5.59-bk/arch/s390/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/s390/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/s390/kernel/smp.c	9 Feb 2003 09:08:34 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/s390/kernel/smp.c	9 Feb 2003 09:23:30 -0000
@@ -102,13 +102,10 @@
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
@@ -116,6 +113,8 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
@@ -148,6 +147,64 @@
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
+	int i, cpu, num_cpus = hweight32(mask);
+
+	/* FIXME: get cpu lock -hc */
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
+	/* Send a message to all other CPUs and wait for them to respond */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << cpu) && mask))
+			smp_ext_bitcall(i, ec_call_function);
+	}
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
 static inline void do_send_stop(void)
 {
         u32 dummy;
@@ -228,7 +285,7 @@
 void machine_restart_smp(char * __unused) 
 {
 	cpu_restart_map = cpu_online_map;
-        smp_call_function(do_machine_restart, NULL, 0, 0);
+        smp_call_function(do_machine_restart, NULL, 0);
 	do_machine_restart(NULL);
 }
 
@@ -247,7 +304,7 @@
 
 void machine_halt_smp(void)
 {
-        smp_call_function(do_machine_halt, NULL, 0, 0);
+        smp_call_function(do_machine_halt, NULL, 0);
 	do_machine_halt(NULL);
 }
 
@@ -266,7 +323,7 @@
 
 void machine_power_off_smp(void)
 {
-        smp_call_function(do_machine_power_off, NULL, 0, 0);
+        smp_call_function(do_machine_power_off, NULL, 0);
 	do_machine_power_off(NULL);
 }
 
@@ -339,7 +396,7 @@
 
 void smp_ptlb_all(void)
 {
-        smp_call_function(smp_ptlb_callback, NULL, 0, 1);
+        smp_call_function(smp_ptlb_callback, NULL, 1);
 	local_flush_tlb();
 }
 
@@ -400,7 +457,7 @@
 	parms.end_ctl = cr;
 	parms.orvals[cr] = 1 << bit;
 	parms.andvals[cr] = 0xFFFFFFFF;
-	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
+	smp_call_function(smp_ctl_bit_callback, &parms, 1);
         __ctl_set_bit(cr, bit);
 }
 
@@ -414,7 +471,7 @@
 	parms.end_ctl = cr;
 	parms.orvals[cr] = 0x00000000;
 	parms.andvals[cr] = ~(1 << bit);
-	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
+	smp_call_function(smp_ctl_bit_callback, &parms, 1);
         __ctl_clear_bit(cr, bit);
 }
 
