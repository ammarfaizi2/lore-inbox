Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUHJXO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUHJXO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267813AbUHJXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:14:58 -0400
Received: from gprs214-124.eurotel.cz ([160.218.214.124]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267810AbUHJXOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:14:42 -0400
Date: Wed, 11 Aug 2004 01:14:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: [patch] Smaller goal first: fix confusion [was Re: [RFC] Fix Device Power Management States]
Message-ID: <20040810231409.GB2287@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net> <20040810100751.GC9034@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net> <20040810175637.GB28113@elf.ucw.cz> <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I still do not see it... swsusp does not care about logical state of
> > device. (Actually manipulating logical state of device might make
> > swsusp less transparent). It cares about device not doing DMA (I also
> > said "no interrupts", but that is not strictly neccessary: we disable
> > interrupts for atomic copy. Device should do no NMIs, through).
> 
> Perhaps it is unncessary to do at a class level, at least at this point.
> I think we all agree that we need some sort of stop/start methods for
> devices, though. In which, we can add to struct bus_type:
> 
> 	int (*dev_stop)(struct device *);
> 	int (*dev_start)(struct device *);
> 
> Sound good?

What about this one... it should solve u32 confusion _now_, and
prepare ground for adding runtime power managment
later... suspend_state_t can be redefined to be structure later.

In future, pci_set_power_state should be modified to take "enum
pci_state" so that confusion is harder...

								Pavel

--- tmp/linux/drivers/base/power/power.h	2003-09-28 22:05:43.000000000 +0200
+++ linux/drivers/base/power/power.h	2004-08-11 00:18:58.000000000 +0200
@@ -1,5 +1,4 @@
-
-
+/* FIXME: This needs explanation... */
 enum {
 	DEVICE_PM_ON,
 	DEVICE_PM1,
@@ -66,14 +65,14 @@
 /*
  * suspend.c
  */
-extern int suspend_device(struct device *, u32);
+extern int suspend_device(struct device *, enum system_state);
 
 
 /*
  * runtime.c
  */
 
-extern int dpm_runtime_suspend(struct device *, u32);
+extern int dpm_runtime_suspend(struct device *, enum system_state);
 extern void dpm_runtime_resume(struct device *);
 
 #else /* CONFIG_PM */
@@ -88,7 +87,7 @@
 
 }
 
-static inline int dpm_runtime_suspend(struct device * dev, u32 state)
+static inline int dpm_runtime_suspend(struct device * dev, enum system_state state)
 {
 	return 0;
 }
--- tmp/linux/drivers/base/power/shutdown.c	2004-06-22 12:36:02.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2004-08-11 00:20:12.000000000 +0200
@@ -29,7 +30,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev,dev->detach_state);
+	/* FIXME: It probably should not be cast like this */
+	return dpm_runtime_suspend(dev, (enum system_state) dev->detach_state);
 }
 
 
--- tmp/linux/drivers/base/power/suspend.c	2004-06-22 12:36:02.000000000 +0200
+++ linux/drivers/base/power/suspend.c	2004-08-11 00:21:16.000000000 +0200
@@ -28,6 +28,7 @@
  * lists. This way, the ancestors will be accessed before their descendents.
  */
 
+/* FIXME: Having both suspend_device and device_suspend is evil */
 
 /**
  *	suspend_device - Save state of one device.
@@ -35,7 +36,7 @@
  *	@state:	Power state device is entering.
  */
 
-int suspend_device(struct device * dev, u32 state)
+int suspend_device(struct device * dev, enum system_state state)
 {
 	int error = 0;
 
@@ -70,7 +71,7 @@
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend(enum system_state state)
 {
 	int error = 0;
 
@@ -112,15 +113,15 @@
  *	done, power down system devices. 
  */
 
-int device_power_down(u32 state)
+int device_power_down(enum system_state state)
 {
 	int error = 0;
 	struct device * dev;
 
 	list_for_each_entry_reverse(dev,&dpm_off_irq,power.entry) {
 		if ((error = suspend_device(dev,state)))
 			break;
 	} 
 	if (error)
 		goto Error;
 	if ((error = sysdev_suspend(state)))
--- tmp/linux/drivers/net/e100.c	2004-06-22 12:36:10.000000000 +0200
+++ linux/drivers/net/e100.c	2004-08-11 00:27:01.000000000 +0200
@@ -2269,7 +2269,7 @@
 }
 
 #ifdef CONFIG_PM
-static int e100_suspend(struct pci_dev *pdev, u32 state)
+static int e100_suspend(struct pci_dev *pdev, suspend_state_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
@@ -2282,7 +2282,7 @@
 	pci_save_state(pdev, nic->pm_state);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, to_pci_state(state));
 
 	return 0;
 }
--- tmp/linux/include/linux/pci.h	2004-06-22 12:36:45.000000000 +0200
+++ linux/include/linux/pci.h	2004-08-10 23:56:56.000000000 +0200
@@ -18,6 +18,7 @@
 #define LINUX_PCI_H
 
 #include <linux/mod_devicetable.h>
+#include <linux/pci.h>
 
 /*
  * Under PCI, each device has 256 bytes of configuration address space,
@@ -593,7 +594,7 @@
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, suspend_state_t reason);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
@@ -965,5 +966,26 @@
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
 
+enum pci_state {
+	D0 = 0,
+	D1 = 1,
+	D2 = 2,
+	D3hot = 3,
+	D3cold = 4
+};
+
+static inline enum pci_state to_pci_state(suspend_state_t state)
+{
+	if (SUSPEND_EQ(state, PM_SUSPEND_ON))
+		return D0;
+	if (SUSPEND_EQ(state, PM_SUSPEND_STANDBY))
+		return D1;
+	if (SUSPEND_EQ(state, PM_SUSPEND_MEM))
+		return D3hot;
+	if (SUSPEND_EQ(state, PM_SUSPEND_DISK))
+		return D3cold;
+	BUG();
+}
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
--- tmp/linux/include/linux/pm.h	2004-06-22 12:36:45.000000000 +0200
+++ linux/include/linux/pm.h	2004-08-10 23:53:02.000000000 +0200
@@ -193,14 +193,22 @@
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
-enum {
-	PM_SUSPEND_ON,
-	PM_SUSPEND_STANDBY,
-	PM_SUSPEND_MEM,
-	PM_SUSPEND_DISK,
+enum system_state {
+	PM_SUSPEND_ON = 0,
+	PM_SUSPEND_STANDBY = 1,
+	PM_SUSPEND_MEM = 2,
+	PM_SUSPEND_DISK = 3,
 	PM_SUSPEND_MAX,
 };
 
+/*
+ * For now, drivers only get system state. Later, this is going to become
+ * structure or something to enable runtime power managment.
+ */
+typedef enum system_state suspend_state_t;
+
+#define SUSPEND_EQ(a, b) (a == b)
+
 enum {
 	PM_DISK_FIRMWARE = 1,
 	PM_DISK_PLATFORM,
@@ -209,7 +217,6 @@
 	PM_DISK_MAX,
 };
 
-
 struct pm_ops {
 	u32	pm_disk_mode;
 	int (*prepare)(u32 state);
@@ -241,8 +248,11 @@
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
-extern int device_suspend(u32 state);
-extern int device_power_down(u32 state);
+/*
+ * apply system suspend policy to all devices
+ */
+extern int device_suspend(enum system_state reason);
+extern int device_power_down(enum system_state reason);
 extern void device_power_up(void);
 extern void device_resume(void);
 
--- tmp/linux/kernel/power/disk.c	2004-05-20 23:08:36.000000000 +0200
+++ linux/kernel/power/disk.c	2004-08-11 00:11:53.000000000 +0200
@@ -46,20 +46,25 @@
 	int error = 0;
 
 	local_irq_save(flags);
-	device_power_down(PM_SUSPEND_DISK);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
+		device_power_down(PM_SUSPEND_DISK);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
+		device_power_down(PM_SUSPEND_DISK);
 		printk("Powering off system\n");
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
+		device_power_down(PM_SUSPEND_DISK);
 		machine_restart(NULL);
 		break;
 	}
 	machine_halt();
+	/* Valid image is on the disk, if we continue we risk serious data corruption
+	   after resume. */
+	while(1);
 	device_power_up();
 	local_irq_restore(flags);
 	return 0;


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
