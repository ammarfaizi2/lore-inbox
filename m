Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTAVF2M>; Wed, 22 Jan 2003 00:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTAVF2L>; Wed, 22 Jan 2003 00:28:11 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:16389
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267348AbTAVF2I>; Wed, 22 Jan 2003 00:28:08 -0500
Date: Wed, 22 Jan 2003 00:37:31 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH][2.5][13/18] smp_call_function_on_cpu - s390x
Message-ID: <Pine.LNX.4.44.0301220035340.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/arch/s390x/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/s390x/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/s390x/kernel/smp.c	17 Jan 2003 11:15:17 -0000	1.1.1.1
+++ linux-2.5.59/arch/s390x/kernel/smp.c	22 Jan 2003 01:17:31 -0000
@@ -101,13 +101,10 @@
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
@@ -115,6 +112,8 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
@@ -147,6 +146,60 @@
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
+	int cpu, i, num_cpus = hweight64(mask);
+
+	/* FIXME: get cpu lock -hc */
+	if (num_cpus == 0)
+		return 0;
+
+	cpu = get_cpu();
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
+		if (cpu_online(i) && ((1UL << i) & mask))
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
+
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 static inline void do_send_stop(void)
 {
         u32 dummy;
@@ -227,7 +280,7 @@
 void machine_restart_smp(char * __unused) 
 {
 	cpu_restart_map = cpu_online_map;
-        smp_call_function(do_machine_restart, NULL, 0, 0);
+        smp_call_function(do_machine_restart, NULL, 0);
 	do_machine_restart(NULL);
 }
 
@@ -246,7 +299,7 @@
 
 void machine_halt_smp(void)
 {
-        smp_call_function(do_machine_halt, NULL, 0, 0);
+        smp_call_function(do_machine_halt, NULL, 0);
 	do_machine_halt(NULL);
 }
 
@@ -265,7 +318,7 @@
 
 void machine_power_off_smp(void)
 {
-        smp_call_function(do_machine_power_off, NULL, 0, 0);
+        smp_call_function(do_machine_power_off, NULL, 0);
 	do_machine_power_off(NULL);
 }
 
@@ -383,7 +436,7 @@
 	parms.end_ctl = cr;
 	parms.orvals[cr] = 1 << bit;
 	parms.andvals[cr] = -1L;
-	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
+	smp_call_function(smp_ctl_bit_callback, &parms, 1);
         __ctl_set_bit(cr, bit);
 }
 
@@ -397,7 +450,7 @@
 	parms.end_ctl = cr;
 	parms.orvals[cr] = 0;
 	parms.andvals[cr] = ~(1L << bit);
-	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
+	smp_call_function(smp_ctl_bit_callback, &parms, 1);
         __ctl_clear_bit(cr, bit);
 }
 

-- 
function.linuxpower.ca


