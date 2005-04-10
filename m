Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVDJS0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVDJS0k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDJSTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:19:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24808 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261554AbVDJSPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:15:17 -0400
Date: Sun, 10 Apr 2005 20:14:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Nyberg <alexn@dsv.su.se>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: smp swsusp [was Re: 2.6.12-rc2-mm2]
Message-ID: <20050410181459.GA1349@elf.ucw.cz>
References: <1113145590732@pavel_ucw.cz> <1113149198.1076.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113149198.1076.2.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hi! The patch is ok, but this should be rewriten to use cpu hotplug instead. 
> > I have some patches but they need more testing. --p
> > 
> 
> Heh yeah on the whole it didn't work too well ;), tell me if you need
> smp testing. I only have S{0,1,4,5} here though (shouldn't there be a S2
> at least also?), dual x64.

S2 basically does not exist. S3 is way more usable...

Here's patch, its against -mm; you'll probably need to adjust it a
bit. Maybe pci.c changes are no longer relevant.

								Pavel

--- clean-mm/drivers/pci/pci.c	2005-03-21 11:39:32.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-03-22 01:41:48.000000000 +0100
@@ -376,11 +376,13 @@
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
+#if 0
 	if (platform_pci_choose_state) {
 		ret = platform_pci_choose_state(dev, state);
 		if (ret >= 0)
 			state = ret;
 	}
+#endif
 	switch (state) {
 	case 0: return PCI_D0;
 	case 3: return PCI_D3hot;
--- clean-mm/kernel/power/Kconfig	2005-01-22 21:24:53.000000000 +0100
+++ linux-mm/kernel/power/Kconfig	2005-03-23 11:40:14.000000000 +0100
@@ -28,7 +28,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	depends on EXPERIMENTAL && PM && SWAP && (HOTPLUG_CPU || !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
--- clean-mm/kernel/power/smp.c	2005-03-19 00:32:32.000000000 +0100
+++ linux-mm/kernel/power/smp.c	2005-03-23 15:38:30.000000000 +0100
@@ -7,79 +7,53 @@
  * This file is released under the GPLv2.
  */
 
-#undef DEBUG
-
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
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
-static cpumask_t oldmask;
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
+	int cpu, error;
 
-	atomic_set(&cpu_counter, 0);
-	atomic_set(&freeze, 1);
-	smp_call_function(smp_pause, NULL, 0, 0);
-	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
-		cpu_relax();
-		barrier();
+	error = 0;
+	cpus_clear(frozen_cpus);
+	printk("Freezing cpus ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		error = cpu_down(cpu);
+		if (!error) {
+			cpu_set(cpu, frozen_cpus);
+			printk("CPU%d is down\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	printk("ok\n");
+	BUG_ON(smp_processor_id() != 0);
+	if (error)
+		panic("cpus not sleeping");
 }
 
 void enable_nonboot_cpus(void)
 {
-	printk("Restarting CPUs");
-	atomic_set(&freeze, 0);
-	while (atomic_read(&cpu_counter)) {
-		cpu_relax();
-		barrier();
-	}
-	printk("...");
-	set_cpus_allowed(current, oldmask);
-	schedule();
-	printk("ok\n");
+	int cpu, error;
 
+	printk("Thawing cpus ...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		if (cpu == 0)
+			continue;
+		error = cpu_up(cpu);
+		if (!error) {
+			printk("CPU%d is up\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d up: %d\n", cpu, error);
+		panic("Not enough cpus");
+	}
 }
-
-
--- clean-mm/kernel/power/swsusp.c	2005-03-21 11:39:33.000000000 +0100
+++ linux-mm/kernel/power/swsusp.c	2005-03-23 15:34:53.000000000 +0100
@@ -1194,8 +1194,11 @@
 		return "version";
 	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
 		return "machine";
+#if 0
+	/* We can't use number of CPUs when we use hotplug to remove them ;-))) */
 	if(swsusp_info.cpus != num_online_cpus())
 		return "number of cpus";
+#endif
 	return NULL;
 }
 


-- 
Boycott Kodak -- for their patent abuse against Java.
