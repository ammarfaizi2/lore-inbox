Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265585AbUFDE3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUFDE3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUFDE3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:29:47 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:13465 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265585AbUFDE2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:28:24 -0400
Subject: Re: [PATCH] cpumask 10/10 optimize various uses of new cpumasks
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040603101115.7f746d98.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	 <20040603101115.7f746d98.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086323259.29381.1036.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 14:27:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 03:11, Paul Jackson wrote:
> cpumask 10/10 optimize various uses of new cpumasks
> 
>         Make use of for_each_cpu_mask() macro to simplify and optimize
>         a couple of sparc64 per-CPU loops.

This means we can finally do this, too... Yes!

Name: Cleanup cpumask_t Temporaries
Status: Booted on 2.6.7-rc2-bk4
Depends: Misc/cpumask-tour-de-force.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Paul Jackson's cpumask tour-de-force allows us to get rid of those
stupid temporaries which we used to hold CPU_MASK_ALL to hand them to
functions.  This used to break NR_CPUS > BITS_PER_LONG.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/arch/ppc64/kernel/irq.c .9851-linux-2.6.7-rc2-bk4.updated/arch/ppc64/kernel/irq.c
--- .9851-linux-2.6.7-rc2-bk4/arch/ppc64/kernel/irq.c	2004-05-31 09:57:03.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/arch/ppc64/kernel/irq.c	2004-06-04 12:06:09.000000000 +1000
@@ -738,7 +738,6 @@ static int irq_affinity_write_proc (stru
 	irq_desc_t *desc = get_irq_desc(irq);
 	int ret;
 	cpumask_t new_value, tmp;
-	cpumask_t allcpus = CPU_MASK_ALL;
 
 	if (!desc->handler->set_affinity)
 		return -EIO;
@@ -753,7 +752,7 @@ static int irq_affinity_write_proc (stru
 	 * NR_CPUS == 32 and cpumask is a long), so we mask it here to
 	 * be consistent.
 	 */
-	cpus_and(new_value, new_value, allcpus);
+	cpus_and(new_value, new_value, CPU_MASK_ALL);
 
 	/*
 	 * Grab lock here so cpu_online_map can't change, and also
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/arch/ppc64/kernel/rtasd.c .9851-linux-2.6.7-rc2-bk4.updated/arch/ppc64/kernel/rtasd.c
--- .9851-linux-2.6.7-rc2-bk4/arch/ppc64/kernel/rtasd.c	2004-06-04 12:01:24.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/arch/ppc64/kernel/rtasd.c	2004-06-04 12:06:30.000000000 +1000
@@ -364,7 +364,6 @@ static int rtasd(void *unused)
 	unsigned int err_type;
 	int cpu = 0;
 	int event_scan = rtas_token("event-scan");
-	cpumask_t all = CPU_MASK_ALL;
 	int rc;
 
 	daemonize("rtasd");
@@ -419,7 +418,7 @@ static int rtasd(void *unused)
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
 		do_event_scan(event_scan);
-		set_cpus_allowed(current, all);
+		set_cpus_allowed(current, CPU_MASK_ALL);
 
 		/* Drop hotplug lock, and sleep for a bit (at least
 		 * one second since some machines have problems if we
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/arch/ppc64/kernel/xics.c .9851-linux-2.6.7-rc2-bk4.updated/arch/ppc64/kernel/xics.c
--- .9851-linux-2.6.7-rc2-bk4/arch/ppc64/kernel/xics.c	2004-05-31 09:57:04.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/arch/ppc64/kernel/xics.c	2004-06-04 12:08:16.000000000 +1000
@@ -240,14 +240,13 @@ static unsigned int real_irq_to_virt(uns
 static int get_irq_server(unsigned int irq)
 {
 	cpumask_t cpumask = irq_affinity[irq];
-	cpumask_t allcpus = CPU_MASK_ALL;
 	cpumask_t tmp = CPU_MASK_NONE;
 	unsigned int server;
 
 #ifdef CONFIG_IRQ_ALL_CPUS
 	/* For the moment only implement delivery to all cpus or one cpu */
 	if (smp_threads_ready) {
-		if (cpus_equal(cpumask, allcpus)) {
+		if (cpus_equal(cpumask, CPU_MASK_ALL)) {
 			server = default_distrib_server;
 		} else {
 			cpus_and(tmp, cpu_online_map, cpumask);
@@ -616,8 +615,7 @@ static void xics_set_affinity(unsigned i
 	long status;
 	unsigned long xics_status[2];
 	unsigned long newmask;
-	cpumask_t allcpus = CPU_MASK_ALL;
 	cpumask_t tmp = CPU_MASK_NONE;
 
 	irq = virt_irq_to_real(irq_offset_down(virq));
 	if (irq == XICS_IPI || irq == NO_IRQ)
@@ -632,7 +629,7 @@ static void xics_set_affinity(unsigned i
 	}
 
 	/* For the moment only implement delivery to all cpus or one cpu */
-	if (cpus_equal(cpumask, allcpus)) {
+	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
 		newmask = default_distrib_server;
 	} else {
 		cpus_and(tmp, cpu_online_map, cpumask);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/include/asm-i386/mach-numaq/mach_apic.h .9851-linux-2.6.7-rc2-bk4.updated/include/asm-i386/mach-numaq/mach_apic.h
--- .9851-linux-2.6.7-rc2-bk4/include/asm-i386/mach-numaq/mach_apic.h	2004-06-04 12:01:24.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/include/asm-i386/mach-numaq/mach_apic.h	2004-06-04 12:03:54.000000000 +1000
@@ -8,8 +8,7 @@
 
 static inline cpumask_t target_cpus(void)
 {
-	cpumask_t tmp = CPU_MASK_ALL;
-	return tmp;
+	return CPU_MASK_ALL;
 }
 
 #define TARGET_CPUS (target_cpus())
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/include/asm-i386/mach-summit/mach_apic.h .9851-linux-2.6.7-rc2-bk4.updated/include/asm-i386/mach-summit/mach_apic.h
--- .9851-linux-2.6.7-rc2-bk4/include/asm-i386/mach-summit/mach_apic.h	2004-06-04 12:01:24.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/include/asm-i386/mach-summit/mach_apic.h	2004-06-04 12:04:00.000000000 +1000
@@ -19,8 +19,7 @@
 
 static inline cpumask_t target_cpus(void)
 {
-	cpumask_t tmp = CPU_MASK_ALL;
-	return tmp;
+	return CPU_MASK_ALL;
 } 
 #define TARGET_CPUS	(target_cpus())
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/kernel/kmod.c .9851-linux-2.6.7-rc2-bk4.updated/kernel/kmod.c
--- .9851-linux-2.6.7-rc2-bk4/kernel/kmod.c	2004-05-31 09:57:40.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/kernel/kmod.c	2004-06-04 12:01:59.000000000 +1000
@@ -154,7 +154,6 @@ static int ____call_usermodehelper(void 
 {
 	struct subprocess_info *sub_info = data;
 	int retval;
-	cpumask_t mask = CPU_MASK_ALL;
 
 	/* Unblock all signals. */
 	flush_signals(current);
@@ -165,7 +164,7 @@ static int ____call_usermodehelper(void 
 	spin_unlock_irq(&current->sighand->siglock);
 
 	/* We can run anywhere, unlike our parent keventd(). */
-	set_cpus_allowed(current, mask);
+	set_cpus_allowed(current, CPU_MASK_ALL);
 
 	retval = -EPERM;
 	if (current->fs->root)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/kernel/kthread.c .9851-linux-2.6.7-rc2-bk4.updated/kernel/kthread.c
--- .9851-linux-2.6.7-rc2-bk4/kernel/kthread.c	2004-06-04 08:56:09.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/kernel/kthread.c	2004-06-04 12:03:34.000000000 +1000
@@ -65,7 +65,6 @@ static int kthread(void *_create)
 	void *data;
 	sigset_t blocked;
 	int ret = -EINTR;
-	cpumask_t mask = CPU_MASK_ALL;
 
 	kthread_exit_files();
 
@@ -79,7 +78,7 @@ static int kthread(void *_create)
 	flush_signals(current);
 
 	/* By default we can run anywhere, unlike keventd. */
-	set_cpus_allowed(current, mask);
+	set_cpus_allowed(current, CPU_MASK_ALL);
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9851-linux-2.6.7-rc2-bk4/kernel/sched.c .9851-linux-2.6.7-rc2-bk4.updated/kernel/sched.c
--- .9851-linux-2.6.7-rc2-bk4/kernel/sched.c	2004-06-04 12:01:25.000000000 +1000
+++ .9851-linux-2.6.7-rc2-bk4.updated/kernel/sched.c	2004-06-04 12:02:35.000000000 +1000
@@ -3906,16 +3906,15 @@ void __init sched_init(void)
 	/* Set up an initial dummy domain for early boot */
 	static struct sched_domain sched_domain_init;
 	static struct sched_group sched_group_init;
-	cpumask_t cpu_mask_all = CPU_MASK_ALL;
 
 	memset(&sched_domain_init, 0, sizeof(struct sched_domain));
-	sched_domain_init.span = cpu_mask_all;
+	sched_domain_init.span = CPU_MASK_ALL;
 	sched_domain_init.groups = &sched_group_init;
 	sched_domain_init.last_balance = jiffies;
 	sched_domain_init.balance_interval = INT_MAX; /* Don't balance */
 
 	memset(&sched_group_init, 0, sizeof(struct sched_group));
-	sched_group_init.cpumask = cpu_mask_all;
+	sched_group_init.cpumask = CPU_MASK_ALL;
 	sched_group_init.next = &sched_group_init;
 	sched_group_init.cpu_power = SCHED_LOAD_SCALE;
 #endif

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

