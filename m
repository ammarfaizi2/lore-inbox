Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVAOEKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVAOEKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVAOEKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:10:16 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:45502 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262080AbVAOEJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:09:52 -0500
Date: Sat, 15 Jan 2005 05:09:51 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: rusty@rustcorp.com.au, manpreet@fabric7.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050115040951.GC13525@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix boot up SMP race in timer setup on i386/x86-64.

This fixes a long standing race in 2.6 i386/x86-64 SMP boot.
The per CPU timers would only get initialized after an secondary
CPU was running. But during initialization the secondary CPU would
already enable interrupts to compute the jiffies. When a per 
CPU timer fired in this window it would run into a BUG in timer.c
because the timer heap for that CPU wasn't fully initialized.

The race only happens when a CPU takes a long time to boot
(e.g. very slow console output with debugging enabled).

To fix I added a new cpu notifier notifier command CPU_UP_PREPARE_EARLY
that is called before the secondary CPU is started. timer.c
uses that now to initialize the per CPU timers early before
the other CPU runs any Linux code.

i386 and x86-64 have been fixed to use this.

For compatibility with other architectures I made timer.c 
handle both (initialization both with CPU_UP_PREPARE and
CPU_UP_PREPARE_EARLY) with a flag. This could be cleaned up later.

Cc: rusty@rustcorp.com.au
Cc: manpreet@fabric7.com
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/smpboot.c
===================================================================
--- linux.orig/arch/i386/kernel/smpboot.c	2005-01-14 10:12:15.%N +0100
+++ linux/arch/i386/kernel/smpboot.c	2005-01-14 10:22:53.%N +0100
@@ -44,6 +44,7 @@
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
 #include <linux/bootmem.h>
+#include <linux/cpu.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -766,6 +767,9 @@
 	idle = fork_idle(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
+
+	cpu_up_early(cpu);
+
 	idle->thread.eip = (unsigned long) start_secondary;
 	/* start_eip had better be page-aligned! */
 	start_eip = setup_trampoline();
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c	2005-01-14 10:12:27.%N +0100
+++ linux/kernel/timer.c	2005-01-14 10:22:53.%N +0100
@@ -86,6 +86,7 @@
 
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
+static DEFINE_PER_CPU(int, timer_inited) = 0; 
 
 static void check_timer_failed(struct timer_list *timer)
 {
@@ -1281,6 +1282,9 @@
 {
 	int j;
 	tvec_base_t *base;
+	
+	if (per_cpu(timer_inited, cpu))
+		return;
        
 	base = &per_cpu(tvec_bases, cpu);
 	spin_lock_init(&base->lock);
@@ -1294,6 +1298,7 @@
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
 	base->timer_jiffies = jiffies;
+	per_cpu(timer_inited, cpu) = 1;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1367,6 +1372,7 @@
 {
 	long cpu = (long)hcpu;
 	switch(action) {
+	case CPU_UP_PREPARE_EARLY:
 	case CPU_UP_PREPARE:
 		init_timers_cpu(cpu);
 		break;
Index: linux/include/linux/notifier.h
===================================================================
--- linux.orig/include/linux/notifier.h	2005-01-04 12:13:31.%N +0100
+++ linux/include/linux/notifier.h	2005-01-14 10:22:53.%N +0100
@@ -70,6 +70,7 @@
 #define CPU_DOWN_PREPARE	0x0005 /* CPU (unsigned)v going down */
 #define CPU_DOWN_FAILED		0x0006 /* CPU (unsigned)v NOT going down */
 #define CPU_DEAD		0x0007 /* CPU (unsigned)v dead */
+#define CPU_UP_PREPARE_EARLY    0x0008 /* CPU (unsigned)v will be going up soon */
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c	2005-01-14 10:12:16.%N +0100
+++ linux/arch/x86_64/kernel/smpboot.c	2005-01-14 10:22:53.%N +0100
@@ -44,6 +44,7 @@
 #include <linux/bootmem.h>
 #include <linux/thread_info.h>
 #include <linux/module.h>
+#include <linux/cpu.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -566,6 +567,10 @@
 	idle = fork_idle(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
+	
+	/* Initialize timer early */
+	cpu_up_early(cpu);
+
 	x86_cpu_to_apicid[cpu] = apicid;
 
 	cpu_pda[cpu].pcurrent = idle;
Index: linux/kernel/cpu.c
===================================================================
--- linux.orig/kernel/cpu.c	2005-01-14 10:12:27.%N +0100
+++ linux/kernel/cpu.c	2005-01-14 10:22:53.%N +0100
@@ -191,3 +191,25 @@
 	up(&cpucontrol);
 	return ret;
 }
+
+/* CPU will be going up soon */
+int __devinit cpu_up_early(unsigned int cpu)
+{
+	void *hcpu = (void *)(long)cpu;
+	int ret;
+
+	if ((ret = down_interruptible(&cpucontrol)) != 0)
+		return ret;
+
+	ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE_EARLY, hcpu);
+	if (ret == NOTIFY_BAD) {
+		printk("%s: attempt to prepare CPU %u failed\n",
+				__FUNCTION__, cpu);
+		ret = -EINVAL;
+		
+		/* no cancel done here for now */
+	}
+	
+	up(&cpucontrol);
+	return ret;
+}
