Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268518AbUHLMDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268518AbUHLMDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUHLMDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:03:15 -0400
Received: from gprs214-235.eurotel.cz ([160.218.214.235]:10373 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268524AbUHLMCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:02:55 -0400
Date: Thu, 12 Aug 2004 14:02:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: [patch] enums to clear suspend-state confusion
Message-ID: <20040812120220.GA30816@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch should clear up some confusion between driver model and
drivers people, and also prepares way to add runtime power managment
later. Please apply,
							Pavel


--- linux-mm/drivers/base/power/power.h	2004-07-28 21:29:22.000000000 +0200
+++ linux-delme/drivers/base/power/power.h	2004-08-12 13:41:12.000000000 +0200
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
--- linux-mm/drivers/base/power/shutdown.c	2004-07-28 21:29:22.000000000 +0200
+++ linux-delme/drivers/base/power/shutdown.c	2004-08-12 13:42:10.000000000 +0200
@@ -29,6 +29,7 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
+	/* FIXME: It probably should not be cast like this */
 	return dpm_runtime_suspend(dev, dev->detach_state);
 }
 
--- linux-mm/drivers/base/power/suspend.c	2004-07-28 21:29:22.000000000 +0200
+++ linux-delme/drivers/base/power/suspend.c	2004-08-12 13:43:08.000000000 +0200
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
 
@@ -112,7 +113,7 @@
  *	done, power down system devices.
  */
 
-int device_power_down(u32 state)
+int device_power_down(enum system_state state)
 {
 	int error = 0;
 	struct device * dev;
--- linux-mm/drivers/ide/ide-disk.c	2004-07-28 22:43:29.000000000 +0200
+++ linux-delme/drivers/ide/ide-disk.c	2004-08-12 13:41:12.000000000 +0200
@@ -1406,6 +1406,7 @@
 {
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
+		/* FIXME: This is buggy. */
 		if (rq->pm->pm_state == 4)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
--- linux-mm/include/linux/pci.h	2004-07-28 22:43:31.000000000 +0200
+++ linux-delme/include/linux/pci.h	2004-08-12 13:41:12.000000000 +0200
@@ -637,7 +637,7 @@
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, suspend_state_t reason);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
@@ -1021,5 +1021,26 @@
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
--- linux-mm/include/linux/pm.h	2004-07-28 21:29:32.000000000 +0200
+++ linux-delme/include/linux/pm.h	2004-08-12 13:41:12.000000000 +0200
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
@@ -241,8 +249,11 @@
 
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
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
