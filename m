Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVALNRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVALNRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVALNRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:17:43 -0500
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:34971 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261174AbVALNR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:17:28 -0500
Date: Wed, 12 Jan 2005 14:17:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: swsusp/dm: Use right levels for device_suspend()
Message-ID: <20050112131709.GB1378@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This almost changes no code (constant is still "3"), but at least it
uses right constants for device_suspend() and fixes types at few
points. Also puts explanation of constants to the
Documentation. Please apply,
								Pavel

--- clean/Documentation/power/devices.txt	2005-01-12 11:07:37.000000000 +0100
+++ linux/Documentation/power/devices.txt	2005-01-12 11:11:53.000000000 +0100
@@ -229,3 +229,91 @@
 The driver core will not call any extra functions when binding the
 device to the driver. 
 
+pm_message_t meaning
+
+pm_message_t has two fields. event ("major"), and flags.  If driver
+does not know event code, it aborts the request, returning error. Some
+drivers may need to deal with special cases based on the actual type
+of suspend operation being done at the system level. This is why
+there are flags.
+
+Event codes are:
+
+ON -- no need to do anything except special cases like broken
+HW.
+
+# NOTIFICATION -- pretty much same as ON?
+
+FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
+scratch. That probably means stop accepting upstream requests, the
+actual policy of what to do with them being specific to a given
+driver. It's acceptable for a network driver to just drop packets
+while a block driver is expected to block the queue so no request is
+lost. (Use IDE as an example on how to do that). FREEZE requires no
+power state change, and it's expected for drivers to be able to
+quickly transition back to operating state.
+
+SUSPEND -- like FREEZE, but also put hardware into low-power state. If
+there's need to distinguish several levels of sleep, additional flag
+is probably best way to do that.
+
+Transitions are only from a resumed state to a suspended state, never
+between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
+FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
+
+All events are: 
+
+[NOTE NOTE NOTE: If you are driver author, you should not care; you
+should only look at event, and ignore flags.]
+
+#Prepare for suspend -- userland is still running but we are going to
+#enter suspend state. This gives drivers chance to load firmware from
+#disk and store it in memory, or do other activities taht require
+#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
+#are forbiden once the suspend dance is started.. event = ON, flags =
+#PREPARE_TO_SUSPEND
+
+Apm standby -- prepare for APM event. Quiesce devices to make life
+easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
+
+Apm suspend -- same as APM_STANDBY, but it we should probably avoid
+spinning down disks. event = FREEZE, flags = APM_SUSPEND
+
+System halt, reboot -- quiesce devices to make life easier for BIOS. event
+= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
+
+System shutdown -- at least disks need to be spun down, or data may be
+lost. Quiesce devices, just to make life easier for BIOS. event =
+FREEZE, flags = SYSTEM_SHUTDOWN
+
+Kexec    -- turn off DMAs and put hardware into some state where new
+kernel can take over. event = FREEZE, flags = KEXEC
+
+Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
+may need to be enabled on some devices. This actually has at least 3
+subtypes, system can reboot, enter S4 and enter S5 at the end of
+swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
+SYSTEM_SHUTDOWN, SYSTEM_S4
+
+Suspend to ram  -- put devices into low power state. event = SUSPEND,
+flags = SUSPEND_TO_RAM
+
+Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
+devices into low power mode, but you must be able to reinitialize
+device from scratch in resume method. This has two flavors, its done
+once on suspending kernel, once on resuming kernel. event = FREEZE,
+flags = DURING_SUSPEND or DURING_RESUME
+
+Device detach requested from /sys -- deinitialize device; proably same as
+SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
+= FREEZE, flags = DEV_DETACH.
+
+#These are not really events sent:
+#
+#System fully on -- device is working normally; this is probably never
+#passed to suspend() method... event = ON, flags = 0
+#
+#Ready after resume -- userland is now running, again. Time to free any
+#memory you ate during prepare to suspend... event = ON, flags =
+#READY_AFTER_RESUME
+#
--- clean/arch/i386/kernel/apm.c	2005-01-12 11:07:38.000000000 +0100
+++ linux/arch/i386/kernel/apm.c	2005-01-12 11:12:01.000000000 +0100
@@ -1201,8 +1201,8 @@
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
 
-	device_suspend(3);
-	device_power_down(3);
+	device_suspend(PMSG_SUSPEND);
+	device_power_down(PMSG_SUSPEND);
 
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
@@ -1255,7 +1255,7 @@
 {
 	int	err;
 
-	device_power_down(3);
+	device_power_down(PMSG_SUSPEND);
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 	/* If needed, notify drivers here */

--- clean/kernel/power/disk.c	2004-12-25 13:35:03.000000000 +0100
+++ linux/kernel/power/disk.c	2005-01-12 10:57:23.000000000 +0100
@@ -51,7 +51,7 @@
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		device_power_down(PM_SUSPEND_DISK);
+ 		device_power_down(PMSG_SUSPEND);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
@@ -144,8 +146,10 @@
 	free_some_memory();
 
 	disable_nonboot_cpus();
-	if ((error = device_suspend(PM_SUSPEND_DISK)))
+	if ((error = device_suspend(PMSG_FREEZE))) {
+		printk("Some devices failed to suspend\n");
 		goto Finish;
+	}
 
 	return 0;
  Finish:

--- clean/kernel/power/main.c	2004-12-25 13:35:03.000000000 +0100
+++ linux/kernel/power/main.c	2005-01-12 10:57:23.000000000 +0100
@@ -65,7 +65,7 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(state)))
+	if ((error = device_suspend(PMSG_SUSPEND)))
 		goto Finish;
 	return 0;
  Finish:
@@ -78,13 +78,14 @@
 }
 
 
-static int suspend_enter(u32 state)
+static int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if ((error = device_power_down(state)))
+
+	if ((error = device_power_down(PMSG_SUSPEND)))
 		goto Done;
 	error = pm_ops->enter(state);
 	device_power_up();

--- clean/kernel/power/swsusp.c	2005-01-12 11:07:40.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-01-12 11:35:42.000000000 +0100
@@ -849,7 +848,7 @@
 	 * become desynchronized with the actual state of the hardware
 	 * at resume time, and evil weirdness ensues.
 	 */
-	if ((error = device_power_down(PM_SUSPEND_DISK))) {
+	if ((error = device_power_down(PMSG_FREEZE))) {
 		local_irq_enable();
 		return error;
 	}
@@ -878,7 +876,7 @@
 {
 	int error;
 	local_irq_disable();
-	device_power_down(PM_SUSPEND_DISK);
+	device_power_down(PMSG_FREEZE);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();

--- clean/drivers/acpi/sleep/main.c	2004-12-25 13:34:59.000000000 +0100
+++ linux/drivers/acpi/sleep/main.c	2004-12-25 15:51:15.000000000 +0100
@@ -159,7 +159,7 @@
 
 int acpi_suspend(u32 acpi_state)
 {
-	u32 states[] = {
+	suspend_state_t states[] = {
 		[1]	= PM_SUSPEND_STANDBY,
 		[3]	= PM_SUSPEND_MEM,
 		[4]	= PM_SUSPEND_DISK,

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
