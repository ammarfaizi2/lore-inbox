Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVG2FME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVG2FME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVG2FL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:11:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262361AbVG2FKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:10:49 -0400
Date: Thu, 28 Jul 2005 22:09:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
Subject: Re: 2.6.12 hangs on boot
Message-Id: <20050728220921.231623b5.akpm@osdl.org>
In-Reply-To: <200506221813.50385.gluk@php4.ru>
References: <200506221813.50385.gluk@php4.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander Y. Fomichev" <gluk@php4.ru> wrote:
>
> G' day
> 
> I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8 GHz
> [ MoBo: Intel E7520, intel 82801 ]
> but kernel hangs on boot right after records:
> 
> Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
> Initializing CPU#2
> 
> ( below is a link to full boot trace, actually -git3 but no differences)
> http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-hang
> 
> An attempt to enable debug:
> +CONFIG_ACPI_DEBUG=y
> +CONFIG_DEBUG_SLAB=y
> +CONFIG_DEBUG_PREEMPT=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_SPINLOCK_SLEEP=y
> +CONFIG_DEBUG_KOBJECT=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_INIT_DEBUG=y
> gives rather strange result, kernel boots successfully ( with a lot of
> debuging messages of course but i couldn't find something suspicious )
> http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-debug
> 
> config for 2.6.12 have been taken from previous one, only
> 'make oldconfig' has been made.
> http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3.config
> 
> Hang 100% reproducible on at least two of my EM64T hosts.
> ( actualy the same configuration as of MoBo/CPU )

Is this still happening in 2.6.13-rc4?

If so, could you please test 2.6.13-rc4 plus the below fix?

Thanks.


From: ebiederm@xmission.com (Eric W. Biederman)

sync_tsc was using smp_call_function to ask the boot processor to report
it's tsc value.  smp_call_function performs an IPI_send_allbutself which is
a broadcast ipi.  There is a window during processor startup during which
the target cpu has started and before it has initialized it's interrupt
vectors so it can properly process an interrupt.  Receveing an interrupt
during that window will triple fault the cpu and do other nasty things.

Why cli does not protect us from that is beyond me.

The simple fix is to match ia64 and provide a smp_call_function_single. 
Which avoids the broadcast and is more efficient.

This certainly fixes the problem of getting stuck on boot which was very
easy to trigger on my SMP Hyperthreaded Xeon, and I think it fixes it for
the right reasons.

I believe this patch suffers from apicid versus logical cpu number
confusion.  I copied the basic logic from smp_send_reschedule and I can't
find where that translates from the logical cpuid to apicid.  So it isn't
quite correct yet.  It should be close enough that it shouldn't be too hard
to finish it up.

More bug fixes after I have slept but I figured I needed to get this
one out for review.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/smp.c     |   65 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/smpboot.c |   18 +++++++----
 include/asm-x86_64/smp.h     |    2 +
 3 files changed, 79 insertions(+), 6 deletions(-)

diff -puN arch/x86_64/kernel/smpboot.c~x86_64-sync_tsc-fix-the-race-so-we-can-boot arch/x86_64/kernel/smpboot.c
--- devel/arch/x86_64/kernel/smpboot.c~x86_64-sync_tsc-fix-the-race-so-we-can-boot	2005-07-28 22:07:55.000000000 -0700
+++ devel-akpm/arch/x86_64/kernel/smpboot.c	2005-07-28 22:07:55.000000000 -0700
@@ -280,7 +280,7 @@ get_delta(long *rt, long *master)
 	return tcenter - best_tm;
 }
 
-static __cpuinit void sync_tsc(void)
+static __cpuinit void sync_tsc(unsigned int master)
 {
 	int i, done = 0;
 	long delta, adj, adjust_latency = 0;
@@ -294,9 +294,17 @@ static __cpuinit void sync_tsc(void)
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
@@ -340,16 +348,14 @@ static __cpuinit void sync_tsc(void)
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
diff -puN arch/x86_64/kernel/smp.c~x86_64-sync_tsc-fix-the-race-so-we-can-boot arch/x86_64/kernel/smp.c
--- devel/arch/x86_64/kernel/smp.c~x86_64-sync_tsc-fix-the-race-so-we-can-boot	2005-07-28 22:07:55.000000000 -0700
+++ devel-akpm/arch/x86_64/kernel/smp.c	2005-07-28 22:07:55.000000000 -0700
@@ -294,6 +294,71 @@ void unlock_ipi_call_lock(void)
 }
 
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
diff -puN include/asm-x86_64/smp.h~x86_64-sync_tsc-fix-the-race-so-we-can-boot include/asm-x86_64/smp.h
--- devel/include/asm-x86_64/smp.h~x86_64-sync_tsc-fix-the-race-so-we-can-boot	2005-07-28 22:07:55.000000000 -0700
+++ devel-akpm/include/asm-x86_64/smp.h	2005-07-28 22:07:55.000000000 -0700
@@ -48,6 +48,8 @@ extern void unlock_ipi_call_lock(void);
 extern int smp_num_siblings;
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
+extern int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
+				     int retry, int wait);
 extern void smp_send_reschedule(int cpu);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void zap_low_mappings(void);
_

