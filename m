Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVCPNYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVCPNYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVCPNXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:23:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32665 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262580AbVCPNWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:22:07 -0500
Date: Wed, 16 Mar 2005 14:21:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, rusty@rustcorp.com.au
Subject: CPU hotplug on i386
Message-ID: <20050316132151.GA2227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to solve long-standing uglyness in swsusp cmp code by calling
cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
available on i386. Is there way to enable CPU_HOTPLUG on i386?

								Pavel

--- clean/kernel/power/smp.c	2004-08-15 19:15:06.000000000 +0200
+++ linux/kernel/power/smp.c	2005-03-16 14:16:00.000000000 +0100
@@ -16,70 +16,39 @@
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
 
-static atomic_t cpu_counter, freeze;
-
-
-static void smp_pause(void * data)
-{
-	struct saved_context ctxt;
-	__save_processor_state(&ctxt);
-	printk("Sleeping in:\n");
-	dump_stack();
-	atomic_inc(&cpu_counter);
-	while (atomic_read(&freeze)) {
-		/* FIXME: restore takes place at random piece inside this.
-		   This should probably be written in assembly, and
-		   preserve general-purpose registers, too
-
-		   What about stack? We may need to move to new stack here.
-
-		   This should better be ran with interrupts disabled.
-		 */
-		cpu_relax();
-		barrier();
-	}
-	atomic_dec(&cpu_counter);
-	__restore_processor_state(&ctxt);
-}
-
-cpumask_t oldmask;
+cpumask_t frozen_cpus;
 
 void disable_nonboot_cpus(void)
 {
-	printk("Freezing CPUs (at %d)", smp_processor_id());
-	oldmask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(0));
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
-	printk("...");
-	BUG_ON(smp_processor_id() != 0);
-
-	/* FIXME: for this to work, all the CPUs must be running
-	 * "idle" thread (or we deadlock). Is that guaranteed? */
-
-	atomic_set(&cpu_counter, 0);
-	atomic_set(&freeze, 1);
-	smp_call_function(smp_pause, NULL, 0, 0);
-	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
-		cpu_relax();
-		barrier();
+	int cpu, error;
+	cpus_clear(frozen_cpus);
+	printk("Freezing cpus...\n");
+	for_each_online_cpu(cpu) {
+		if (!cpu)
+			continue;
+		cpu_set(cpu, frozen_cpus);
+		error = cpu_down(cpu);
+		if (!error)
+			continue;
+		printk("Error taking cpu %d down: %d\n", cpu, error);
+		panic("Too many cpus");
 	}
-	printk("ok\n");
+	BUG_ON(smp_processor_id() != 0);
 }
 
 void enable_nonboot_cpus(void)
 {
-	printk("Restarting CPUs");
-	atomic_set(&freeze, 0);
-	while (atomic_read(&cpu_counter)) {
-		cpu_relax();
-		barrier();
+	int cpu, error;
+	printk("Thawing cpus...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		if (!cpu)
+			continue;
+		error = cpu_up(cpu);
+		if (!error)
+			continue;
+		printk("Error taking cpu %d up: %d\n", cpu, error);
+		panic("Not enough cpus");
 	}
-	printk("...");
-	set_cpus_allowed(current, oldmask);
-	schedule();
-	printk("ok\n");
-
 }
 
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
