Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbTAVFVr>; Wed, 22 Jan 2003 00:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbTAVFVr>; Wed, 22 Jan 2003 00:21:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:5125
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267362AbTAVFVn>; Wed, 22 Jan 2003 00:21:43 -0500
Date: Wed, 22 Jan 2003 00:30:56 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: paulus@samba.org, <linuxppc-dev@lists.linuxppc.org>,
       <benh@kernel.crashing.org>
Subject: [PATCH][2.5][10/18] smp_call_function_on_cpu - ppc
Message-ID: <Pine.LNX.4.44.0301220028240.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/arch/ppc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/ppc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/ppc/kernel/smp.c	17 Jan 2003 11:14:47 -0000	1.1.1.1
+++ linux-2.5.59/arch/ppc/kernel/smp.c	22 Jan 2003 00:53:12 -0000
@@ -165,7 +165,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 }
 
 /*
@@ -188,13 +188,10 @@
  * in the system.
  */
 
-int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
-		      int wait)
 /*
  * [SUMMARY] Run a function on all other CPUs.
  * <func> The function to run. This must be fast and non-blocking.
  * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
  * <wait> If true, wait (atomically) until function has completed on other CPUs.
  * [RETURNS] 0 on success, else a negative status code. Does not return until
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
@@ -202,6 +199,8 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
+int smp_call_function(void (*func) (void *info), void *info, int wait)
 {
 	/* FIXME: get cpu lock with hotplug cpus, or change this to
            bitmask. --RR */
@@ -263,6 +262,80 @@
 
  out:
 	spin_unlock(&call_lock);
+	return ret;
+}
+
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
+static int smp_call_function_on_cpu(void (*func) (void *info), void *info,
+					int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int ret = -1;
+	int timeout;
+	int i, cpu, num_cpus = hweight32(mask);
+
+	if (num_cpus == 0 || )
+		return -EINVAL;
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
+			smp_message_pass(i, PPC_MSG_CALL_FUNCTION, 0, 0);
+	}
+
+	/* Wait for response */
+	timeout = 1000000;
+	while (atomic_read(&data.started) != num_cpus) {
+		if (--timeout == 0) {
+			printk("smp_call_function on cpu %d: other cpus not responding (%d)\n",
+			       cpu, atomic_read(&data.started));
+			goto out;
+		}
+		barrier();
+		udelay(1);
+	}
+
+	if (wait) {
+		timeout = 1000000;
+		while (atomic_read(&data.finished) != num_cpus) {
+			if (--timeout == 0) {
+				printk("smp_call_function on cpu %d: other cpus not finishing (%d/%d)\n",
+				       cpu, atomic_read(&data.finished), atomic_read(&data.started));
+				goto out;
+			}
+			barrier();
+			udelay(1);
+		}
+	}
+	ret = 0;
+
+ out:
+	spin_unlock(&call_lock);
+	pu_cpu_no_resched();
 	return ret;
 }
 
Index: linux-2.5.59/arch/ppc/kernel/temp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/ppc/kernel/temp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 temp.c
--- linux-2.5.59/arch/ppc/kernel/temp.c	17 Jan 2003 11:14:47 -0000	1.1.1.1
+++ linux-2.5.59/arch/ppc/kernel/temp.c	22 Jan 2003 00:54:12 -0000
@@ -195,7 +195,7 @@
 	/* schedule ourselves to be run again */
 	mod_timer(&tau_timer, jiffies + shrink_timer) ;
 #ifdef CONFIG_SMP
-	smp_call_function(tau_timeout, NULL, 1, 0);
+	smp_call_function(tau_timeout, NULL, 0);
 #endif
 	tau_timeout(NULL);
 }
@@ -240,7 +240,7 @@
 	add_timer(&tau_timer);
 	
 #ifdef CONFIG_SMP
-	smp_call_function(TAU_init_smp, NULL, 1, 0);
+	smp_call_function(TAU_init_smp, NULL, 0);
 #endif
 	TAU_init_smp(NULL);
 	

-- 
function.linuxpower.ca


