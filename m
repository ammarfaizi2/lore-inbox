Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUIXGg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUIXGg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUIXGg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:36:56 -0400
Received: from fmr02.intel.com ([192.55.52.25]:39358 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268488AbUIXGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:31:49 -0400
Date: Fri, 24 Sep 2004 14:16:44 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: suspend/resume support for driver requires an external firmware
Message-ID: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[Mail originally post on acpi-dev, repost here per Patrick's request.]


Hi,

I make the ipw2100 driver (http://ipw2100.sf.net) support suspend/resume
with below patch.
http://cache.gmane.org//gmane/linux/drivers/ipw2100/devel/2129-001.bin

Current state is the patch makes ipw2100 suspend/resume work in the expense
of addtional ~200k kernel runtime memory. So I'd rather look on it as a
workaround instead of a finial solution.

The problem is ipw2100 requires an external on-disk firmware support. When
the device is put to D3 state, firmware needs to be unloaded. And the
firmware should be loaded again after the device is put to D0 state. But
currently there is no suspend/resume order(dependency) for the online
devices list in the kernel (dpm_active). So the ide disk might still be in
the suspend state when ipw2100->resume is called. This causes a deadlock.
Note here the ipw2100 can be any driver that requires a firmware.


I propose 2 choices to fix the problem.

Choice 1. In 2.5 kernel, there used to be a ->save_state method in the
device PM interface. From the "not yet updated" document
(Documentation/power/pci.txt), this function can be used as "a notification
that it(the device) may be entering a sleep state in the near future". If we
take back this interface, the problem can be solved. That is, the driver
loads firmware into memory in ->save_state and frees the memory in ->resume.
The deadlock is resolved without any runtime memory wasted.

patch embeded at the end of the mail.


Choice 2. Add a notifier call chain for swsusp before prepare_suspend (and
probably for acpi_suspend as well). Each driver requires the notification
(i.e. ipw2100) registers its own callback. For people who think device PM
->save_state is an overkill since 99% devices don't require firmwares
(really today, who knows the future?), this can be considered as another
(better) solution.


Choice 3? or I missed something here?


Your comments are highly appreciated!

-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820



Signed-off-by: Zhu Yi <yi.zhu@intel.com>

 drivers/base/power/suspend.c |   18 ++++++++++++++++++
 drivers/pci/pci-driver.c     |   13 +++++++++++++
 include/linux/device.h       |    1 +
 include/linux/pci.h          |    1 +
 include/linux/pm.h           |    1 +
 kernel/power/swsusp.c        |    5 +++++
 6 files changed, 39 insertions(+)


diff -urp linux-2.6.8.1-vanilla/drivers/pci/pci-driver.c linux-2.6.8.1-swsusp/drivers/pci/pci-driver.c
--- linux-2.6.8.1-vanilla/drivers/pci/pci-driver.c	2004-09-18 20:38:57.000000000 +0800
+++ linux-2.6.8.1-swsusp/drivers/pci/pci-driver.c	2004-09-18 15:44:24.000000000 +0800
@@ -295,6 +295,18 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 
+static int pci_device_save_state(struct device * dev, u32 state)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+	int i = 0;
+
+	if (drv && drv->save_state)
+		i = drv->save_state(pci_dev,state);
+		
+	return i;
+}
+
 static int pci_device_suspend(struct device * dev, u32 state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
@@ -537,6 +549,7 @@ struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.hotplug	= pci_hotplug,
+	.save_state	= pci_device_save_state,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
 	.dev_attrs	= pci_dev_attrs,
diff -urp linux-2.6.8.1-vanilla/include/linux/device.h linux-2.6.8.1-swsusp/include/linux/device.h
--- linux-2.6.8.1-vanilla/include/linux/device.h	2004-09-18 20:40:32.000000000 +0800
+++ linux-2.6.8.1-swsusp/include/linux/device.h	2004-09-18 13:59:39.000000000 +0800
@@ -62,6 +62,7 @@ struct bus_type {
 	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
+	int		(*save_state)(struct device * dev, u32 state);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
 };
diff -urp linux-2.6.8.1-vanilla/include/linux/pci.h linux-2.6.8.1-swsusp/include/linux/pci.h
--- linux-2.6.8.1-vanilla/include/linux/pci.h	2004-09-18 20:36:44.000000000 +0800
+++ linux-2.6.8.1-swsusp/include/linux/pci.h	2004-09-18 14:47:31.000000000 +0800
@@ -637,6 +637,7 @@ struct pci_driver {
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
+	int  (*save_state) (struct pci_dev *dev, u32 state);	/* Device save state */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
diff -urp linux-2.6.8.1-vanilla/include/linux/pm.h linux-2.6.8.1-swsusp/include/linux/pm.h
--- linux-2.6.8.1-vanilla/include/linux/pm.h	2004-09-18 20:37:57.000000000 +0800
+++ linux-2.6.8.1-swsusp/include/linux/pm.h	2004-09-18 16:58:08.000000000 +0800
@@ -241,6 +241,7 @@ struct dev_pm_info {
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
+extern int device_save_state(u32 state);
 extern int device_suspend(u32 state);
 extern int device_power_down(u32 state);
 extern void device_power_up(void);
diff -urp linux-2.6.8.1-vanilla/drivers/base/power/suspend.c linux-2.6.8.1-swsusp/drivers/base/power/suspend.c
--- linux-2.6.8.1-vanilla/drivers/base/power/suspend.c	2004-09-18 20:40:14.000000000 +0800
+++ linux-2.6.8.1-swsusp/drivers/base/power/suspend.c	2004-09-18 17:35:43.000000000 +0800
@@ -49,6 +49,24 @@ int suspend_device(struct device * dev, 
 	return error;
 }
 
+/**
+ *	device_save_state - Save state all devices in system.
+ *	@state:		    Power state to put each device in.
+ *
+ *	Walk the dpm_active list, call ->save_state() for each device.
+ */
+int device_save_state(u32 state)
+{
+	struct device * dev;
+	int error = 0;
+
+	list_for_each_entry(dev, &dpm_active, power.entry) {
+		if (dev->bus && dev->bus->save_state)
+			error = dev->bus->save_state(dev, state);
+	}
+
+	return error;
+}
 
 /**
  *	device_suspend - Save state and stop all devices in system.
diff -urp linux-2.6.8.1-vanilla/kernel/power/swsusp.c linux-2.6.8.1-swsusp/kernel/power/swsusp.c
--- linux-2.6.8.1-vanilla/kernel/power/swsusp.c	2004-09-18 20:35:07.000000000 +0800
+++ linux-2.6.8.1-swsusp/kernel/power/swsusp.c	2004-09-18 20:55:07.000000000 +0800
@@ -835,6 +835,11 @@ int software_suspend(void)
 	}		
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
+
+	/* device save_state */
+	if (device_save_state(3))
+		return -EBUSY;
+
 	if (!prepare_suspend_processes()) {
 
 		/* At this point, all user processes and "dangerous"

