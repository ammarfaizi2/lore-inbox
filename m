Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVHKW5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVHKW5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHKW5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:57:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932460AbVHKW5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:57:21 -0400
Message-Id: <20050811225609.058881000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
Subject: [patch 3/8] [PATCH] x86_64: Fixing smpboot timing problem
Content-Disposition: inline; filename=x86_64-fix-smpboot-timing-problem.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

introduced in 2.6.12. Please apply to stable.

>From Eric Biederman

sync_tsc was using smp_call_function to ask the boot processor
to report it's tsc value.  smp_call_function performs an IPI_send_allbutself
which is a broadcast ipi.  There is a window during processor startup during
which the target cpu has started and before it has initialized it's interrupt
vectors so it can properly process an interrupt.  Receveing an interrupt
during that window will triple fault the cpu and do other nasty things.

Why cli does not protect us from that is beyond me.

The simple fix is to match ia64 and provide a smp_call_function_single.
Which avoids the broadcast and is more efficient.

This certainly fixes the problem of getting stuck on boot which was
very easy to trigger on my SMP Hyperthreaded Xeon, and I think
it fixes it for the right reasons.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.12/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.12.orig/arch/x86_64/kernel/smp.c
+++ linux-2.6.12/arch/x86_64/kernel/smp.c
@@ -284,6 +284,71 @@ struct call_data_struct {
 static struct call_data_struct * call_data;
 
 /*
+ * this function sends a 'generic call function' IPI to one other CPU
+ * in the system.
+ */
+static void __smp_call_function_single (int cpu, void (*func) (void *info), void *info,
+				int nonatomic, int wait)
+{
+	struct call_data_struct data;
+	int cpus = 1;
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	call_data = &data;
+	wmb();
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_mask(cpumask_of_cpu(cpu), CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != cpus)
+		cpu_relax();
+
+	if (!wait)
+		return;
+
+	while (atomic_read(&data.finished) != cpus)
+		cpu_relax();
+}
+
+/*
+ * Run a function on another CPU
+ *  <func>	The function to run. This must be fast and non-blocking.
+ *  <info>	An arbitrary pointer to pass to the function.
+ *  <nonatomic>	Currently unused.
+ *  <wait>	If true, wait until function has completed on other CPUs.
+ *  [RETURNS]   0 on success, else a negative status code.
+ *
+ * Does not return until the remote CPU is nearly ready to execute <func>
+ * or is or has executed.
+ */
+
+int smp_call_function_single (int cpu, void (*func) (void *info), void *info, 
+	int nonatomic, int wait)
+{
+	
+	int me = get_cpu(); /* prevent preemption and reschedule on another processor */
+
+	if (cpu == me) {
+		printk("%s: trying to call self\n", __func__);
+		put_cpu();
+		return -EBUSY;
+	}
+	spin_lock_bh(&call_lock);
+
+	__smp_call_function_single(cpu, func,info,nonatomic,wait);	
+
+	spin_unlock_bh(&call_lock);
+	put_cpu();
+	return 0;
+}
+
+/*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
  */
Index: linux-2.6.12/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.12/arch/x86_64/kernel/smpboot.c
@@ -202,9 +202,6 @@ static __cpuinit void sync_master(void *
 {
 	unsigned long flags, i;
 
-	if (smp_processor_id() != boot_cpu_id)
-		return;
-
 	go[MASTER] = 0;
 
 	local_irq_save(flags);
@@ -253,7 +250,7 @@ get_delta(long *rt, long *master)
 	return tcenter - best_tm;
 }
 
-static __cpuinit void sync_tsc(void)
+static __cpuinit void sync_tsc(unsigned int master)
 {
 	int i, done = 0;
 	long delta, adj, adjust_latency = 0;
@@ -267,9 +264,17 @@ static __cpuinit void sync_tsc(void)
 	} t[NUM_ROUNDS] __cpuinitdata;
 #endif
 
+	printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n",
+		smp_processor_id(), master);
+
 	go[MASTER] = 1;
 
-	smp_call_function(sync_master, NULL, 1, 0);
+	/* It is dangerous to broadcast IPI as cpus are coming up,
+	 * as they may not be ready to accept them.  So since
+	 * we only need to send the ipi to the boot cpu direct
+	 * the message, and avoid the race.
+	 */
+	smp_call_function_single(master, sync_master, NULL, 1, 0);
 
 	while (go[MASTER])	/* wait for master to be ready */
 		no_cpu_relax();
@@ -313,16 +318,14 @@ static __cpuinit void sync_tsc(void)
 	printk(KERN_INFO
 	       "CPU %d: synchronized TSC with CPU %u (last diff %ld cycles, "
 	       "maxerr %lu cycles)\n",
-	       smp_processor_id(), boot_cpu_id, delta, rt);
+	       smp_processor_id(), master, delta, rt);
 }
 
 static void __cpuinit tsc_sync_wait(void)
 {
 	if (notscsync || !cpu_has_tsc)
 		return;
-	printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
-			boot_cpu_id);
-	sync_tsc();
+	sync_tsc(boot_cpu_id);
 }
 
 static __init int notscsync_setup(char *s)
Index: linux-2.6.12/include/asm-x86_64/smp.h
===================================================================
--- linux-2.6.12.orig/include/asm-x86_64/smp.h
+++ linux-2.6.12/include/asm-x86_64/smp.h
@@ -46,6 +46,8 @@ extern int pic_mode;
 extern int smp_num_siblings;
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
+extern int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
+				     int retry, int wait);
 extern void smp_send_reschedule(int cpu);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void zap_low_mappings(void);

--
