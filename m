Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272224AbTHDVor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272222AbTHDVor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:44:47 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:39653 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272223AbTHDVo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:44:28 -0400
Date: Mon, 4 Aug 2003 23:44:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-laptop@vger.kernel.org,
       sfr@canb.auug.org.au, david-b@pacbell.net
Subject: Re: Do not suspend PCI devices twice [PATCH for testing]
Message-ID: <20030804214401.GB2787@elf.ucw.cz>
References: <20030804212624.GA2452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804212624.GA2452@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> PCI devices are suspendend twice; once using pm_send_all() and once
> because of driver model (when using ACPI). That's bad.
> 
> If I kill pm_send_all() hook, they will not be suspended at all with
> APM, because APM does not call device_suspend(...,
> SUSPEND_SAVE_STATE). This patch fixes both of these.
> 
> Ouch, no it does not. You should > drivers/pci/power.c. Its no longer
> needed.
> 
> It compiles, and I'd like someone to test it ;-).

Here's the right patch. You no longer need to > power.c.

								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/apm.c	2003-05-27 13:42:28.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/apm.c	2003-08-04 23:11:06.000000000 +0200
@@ -1185,19 +1185,23 @@
 	int		err;
 	struct apm_user	*as;
 
+	if (device_suspend(3, SUSPEND_NOTIFY))
+		if (vetoable)
+			goto veto;
+	if (device_suspend(3, SUSPEND_SAVE_STATE)) {
+		if (vetoable) {
+			device_resume(RESUME_RESTORE_STATE);
+			goto veto;
+		}
+	}
 	if (pm_send_all(PM_SUSPEND, (void *)3)) {
 		/* Vetoed */
 		if (vetoable) {
-			if (apm_info.connection_version > 0x100)
-				set_system_power_state(APM_STATE_REJECT);
-			err = -EBUSY;
-			ignore_sys_suspend = 0;
-			printk(KERN_WARNING "apm: suspend was vetoed.\n");
-			goto out;
+			device_resume(RESUME_RESTORE_STATE);
+			goto veto;
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
-
 	device_suspend(3, SUSPEND_POWER_DOWN);
 
 	/* serialize with the timer interrupt */
@@ -1234,7 +1238,17 @@
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
 	device_resume(RESUME_POWER_ON);
 	pm_send_all(PM_RESUME, (void *)0);
+	device_resume(RESUME_RESTORE_STATE);
 	queue_event(APM_NORMAL_RESUME, NULL);
+
+	if (0) {
+ veto:
+		if (apm_info.connection_version > 0x100)
+			set_system_power_state(APM_STATE_REJECT);
+		err = -EBUSY;
+		ignore_sys_suspend = 0;
+		printk(KERN_WARNING "apm: suspend was vetoed.\n");
+	}
  out:
 	spin_lock(&user_list_lock);
 	for (as = user_list; as != NULL; as = as->next) {
--- /usr/src/tmp/linux/drivers/pci/power.c	2003-06-15 22:42:54.000000000 +0200
+++ /usr/src/linux/drivers/pci/power.c	2003-08-04 23:25:37.000000000 +0200
@@ -1,159 +0,0 @@
-#include <linux/pci.h>
-#include <linux/pm.h>
-#include <linux/init.h>
-
-/*
- * PCI Power management..
- *
- * This needs to be done centralized, so that we power manage PCI
- * devices in the right order: we should not shut down PCI bridges
- * before we've shut down the devices behind them, and we should
- * not wake up devices before we've woken up the bridge to the
- * device.. Eh?
- *
- * We do not touch devices that don't have a driver that exports
- * a suspend/resume function. That is just too dangerous. If the default
- * PCI suspend/resume functions work for a device, the driver can
- * easily implement them (ie just have a suspend function that calls
- * the pci_set_power_state() function).
- */
-
-static int pci_pm_save_state_device(struct pci_dev *dev, u32 state)
-{
-	int error = 0;
-	if (dev) {
-		struct pci_driver *driver = dev->driver;
-		if (driver && driver->save_state) 
-			error = driver->save_state(dev,state);
-	}
-	return error;
-}
-
-static int pci_pm_suspend_device(struct pci_dev *dev, u32 state)
-{
-	int error = 0;
-	if (dev) {
-		struct pci_driver *driver = dev->driver;
-		if (driver && driver->suspend)
-			error = driver->suspend(dev,state);
-	}
-	return error;
-}
-
-static int pci_pm_resume_device(struct pci_dev *dev)
-{
-	int error = 0;
-	if (dev) {
-		struct pci_driver *driver = dev->driver;
-		if (driver && driver->resume)
-			error = driver->resume(dev);
-	}
-	return error;
-}
-
-static int pci_pm_save_state_bus(struct pci_bus *bus, u32 state)
-{
-	struct list_head *list;
-	int error = 0;
-
-	list_for_each(list, &bus->children) {
-		error = pci_pm_save_state_bus(pci_bus_b(list),state);
-		if (error) return error;
-	}
-	list_for_each(list, &bus->devices) {
-		error = pci_pm_save_state_device(pci_dev_b(list),state);
-		if (error) return error;
-	}
-	return 0;
-}
-
-static int pci_pm_suspend_bus(struct pci_bus *bus, u32 state)
-{
-	struct list_head *list;
-
-	/* Walk the bus children list */
-	list_for_each(list, &bus->children) 
-		pci_pm_suspend_bus(pci_bus_b(list),state);
-
-	/* Walk the device children list */
-	list_for_each(list, &bus->devices)
-		pci_pm_suspend_device(pci_dev_b(list),state);
-	return 0;
-}
-
-static int pci_pm_resume_bus(struct pci_bus *bus)
-{
-	struct list_head *list;
-
-	/* Walk the device children list */
-	list_for_each(list, &bus->devices)
-		pci_pm_resume_device(pci_dev_b(list));
-
-	/* And then walk the bus children */
-	list_for_each(list, &bus->children)
-		pci_pm_resume_bus(pci_bus_b(list));
-	return 0;
-}
-
-static int pci_pm_save_state(u32 state)
-{
-	struct pci_bus *bus = NULL;
-	int error = 0;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		error = pci_pm_save_state_bus(bus,state);
-		if (!error)
-			error = pci_pm_save_state_device(bus->self,state);
-	}
-	return error;
-}
-
-static int pci_pm_suspend(u32 state)
-{
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		pci_pm_suspend_bus(bus,state);
-		pci_pm_suspend_device(bus->self,state);
-	}
-	return 0;
-}
-
-static int pci_pm_resume(void)
-{
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		pci_pm_resume_device(bus->self);
-		pci_pm_resume_bus(bus);
-	}
-	return 0;
-}
-
-static int 
-pci_pm_callback(struct pm_dev *pm_device, pm_request_t rqst, void *data)
-{
-	int error = 0;
-
-	switch (rqst) {
-	case PM_SAVE_STATE:
-		error = pci_pm_save_state((unsigned long)data);
-		break;
-	case PM_SUSPEND:
-		error = pci_pm_suspend((unsigned long)data);
-		break;
-	case PM_RESUME:
-		error = pci_pm_resume();
-		break;
-	default: break;
-	}
-	return error;
-}
-
-static int __init pci_pm_init(void)
-{
-	pm_register(PM_PCI_DEV, 0, pci_pm_callback);
-	return 0;
-}
-
-subsys_initcall(pci_pm_init);
--- /usr/src/tmp/linux/kernel/suspend.c	2003-08-04 23:28:06.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-08-04 23:07:11.000000000 +0200
@@ -630,16 +630,20 @@
 static void drivers_unsuspend(void)
 {
 	device_resume(RESUME_RESTORE_STATE);
+	pm_send_all(PM_RESUME, (void *)0);
 	device_resume(RESUME_ENABLE);
 }
 
 /* Called from process context */
 static int drivers_suspend(void)
 {
-	device_suspend(4, SUSPEND_NOTIFY);
-	device_suspend(4, SUSPEND_SAVE_STATE);
-	device_suspend(4, SUSPEND_DISABLE);
-	if(!pm_suspend_state) {
+	if (device_suspend(4, SUSPEND_NOTIFY))
+		return -EIO;
+	if (device_suspend(4, SUSPEND_SAVE_STATE)) {
+		device_resume(RESUME_RESTORE_STATE);
+		return -EIO;
+	}
+	if (!pm_suspend_state) {
 		if(pm_send_all(PM_SUSPEND,(void *)3)) {
 			printk(KERN_WARNING "Problem while sending suspend event\n");
 			return(1);
@@ -647,6 +651,7 @@
 		pm_suspend_state=1;
 	} else
 		printk(KERN_WARNING "PM suspend state already raised\n");
+	device_suspend(4, SUSPEND_DISABLE);
 	  
 	return(0);
 }
@@ -868,7 +873,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if (drivers_suspend()==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
