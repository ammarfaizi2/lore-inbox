Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUIHRl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUIHRl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUIHRl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 13:41:58 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:40837 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269210AbUIHRjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 13:39:09 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc1-bk] fix pci/pmcore enum value problem
Date: Wed, 8 Sep 2004 10:38:50 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qO0PBbJjw7OYNj6"
Message-Id: <200409081038.50387.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_qO0PBbJjw7OYNj6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In contrast to previous versions of this patch, I've actually been using
this one ... it behaves OK with both /proc/sys/acpi and /sys/power/state,
at least in terms of letting drivers use pci_set_power_state() the same
way they've done since LK2.4 days.

- Dave

--Boundary-00=_qO0PBbJjw7OYNj6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pmcore-0908.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmcore-0908.patch"

Changes the PM_SUSPEND_MEM (and PM_SUSPEND_DISK) enum values so that
they make sense as PCI device power states.

(a) Fixes bugs whereby PCI drivers are being given bogus values.
    The should resolve OSDL bugid 2886 without changing the PCI
    API (its PM calls still act as on 2.4 kernels).

(b) Doesn't change the awkward assumption in the 2.6 PMcore that
    the /sys/bus/*/devices/power/state, /proc/acpi/sleep,
    dev->power.power_state, and dev->detach_state files share
    the same numeric codes ... even for busses very unlike PCI,
    or systems with several "on" policies as well as STD and STR.

Really we need to move away from "u32" codes that are easily confused
with each other, towards typed values (probably struct pointers), but
this is the simplest comprehensive fix for the PCI problem.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


--- 1.16/include/linux/pm.h	Thu Jul  1 22:23:53 2004
+++ edited/include/linux/pm.h	Wed Sep  8 07:54:20 2004
@@ -194,11 +194,12 @@
 extern void (*pm_power_off)(void);
 
 enum {
-	PM_SUSPEND_ON,
-	PM_SUSPEND_STANDBY,
-	PM_SUSPEND_MEM,
-	PM_SUSPEND_DISK,
-	PM_SUSPEND_MAX,
+	PM_SUSPEND_ON = 0,
+	PM_SUSPEND_STANDBY = 1,
+	/* NOTE: PM_SUSPEND_MEM == PCI_D3hot */
+	PM_SUSPEND_MEM = 3,
+	PM_SUSPEND_DISK = 4,
+	PM_SUSPEND_MAX = 5,
 };
 
 enum {
--- 1.17/kernel/power/main.c	Mon Apr 12 10:54:21 2004
+++ edited/kernel/power/main.c	Wed Sep  8 07:54:20 2004
@@ -225,8 +225,8 @@
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	for (s = &pm_states[state]; *s; s++, state++) {
-		if (!strncmp(buf, *s, len))
+	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
+		if (*s && !strncmp(buf, *s, len))
 			break;
 	}
 	if (*s)
--- 1.86/kernel/power/swsusp.c	Thu Jul  1 22:23:48 2004
+++ edited/kernel/power/swsusp.c	Wed Sep  8 07:54:20 2004
@@ -699,7 +699,7 @@
 	else
 #endif
 	{
-		device_suspend(3);
+		device_suspend(PM_SUSPEND_DISK);
 		device_shutdown();
 		machine_power_off();
 	}
@@ -720,7 +720,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
-	device_power_down(3);
+	device_power_down(PM_SUSPEND_DISK);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -789,7 +789,7 @@
 {
 	int is_problem;
 	read_swapfiles();
-	device_power_down(3);
+	device_power_down(PM_SUSPEND_DISK);
 	is_problem = suspend_prepare_image();
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -844,8 +844,8 @@
 		free_some_memory();
 		disable_nonboot_cpus();
 		/* Save state of all device drivers, and stop them. */
-		printk("Suspending devices... ");
-		if ((res = device_suspend(3))==0) {
+		printk("Suspending devices...\n");
+		if ((res = device_suspend(PM_SUSPEND_DISK))==0) {
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -1200,7 +1200,7 @@
 		goto read_failure;
 	/* FIXME: Should we stop processes here, just to be safer? */
 	disable_nonboot_cpus();
-	device_suspend(3);
+	device_suspend(PM_SUSPEND_DISK);
 	do_magic(1);
 	panic("This never returns");
 

--Boundary-00=_qO0PBbJjw7OYNj6--
