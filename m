Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUHQV1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUHQV1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268451AbUHQV1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:27:37 -0400
Received: from gprs214-166.eurotel.cz ([160.218.214.166]:26240 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268445AbUHQVZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:25:45 -0400
Date: Tue, 17 Aug 2004 23:25:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040817212510.GA744@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812120220.GA30816@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch should clear up some confusion between driver model and
> drivers people, and also prepares way to add runtime power managment
> later. Please apply,

PCI states are now marked with PCI_D? so that confusion is not
possible. Andrew complained about warning in to_pci_state(); I do not
see it, but I added catch-all return anyway.

I'd like this to be applied, so I can start fixing the drivers...

								Pavel

--- tmp/linux/drivers/base/power/power.h	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/power.h	2004-08-15 19:15:49.000000000 +0200
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
--- tmp/linux/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2004-08-17 12:45:39.000000000 +0200
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME: It probably should not be cast like this */
+	return dpm_runtime_suspend(dev, (enum system_state) dev->detach_state);
 }
 
 
--- tmp/linux/drivers/base/power/suspend.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/suspend.c	2004-08-17 23:20:28.000000000 +0200
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
--- tmp/linux/include/linux/pci.h	2004-08-15 19:15:05.000000000 +0200
+++ linux/include/linux/pci.h	2004-08-17 23:16:41.000000000 +0200
@@ -18,6 +18,7 @@
 #define LINUX_PCI_H
 
 #include <linux/mod_devicetable.h>
+#include <linux/pci.h>
 
 /*
  * Under PCI, each device has 256 bytes of configuration address space,
@@ -637,7 +638,7 @@
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, suspend_state_t reason);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
@@ -1021,5 +1022,27 @@
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
 
+enum pci_state {
+	PCI_D0 = 0,
+	PCI_D1 = 1,
+	PCI_D2 = 2,
+	PCI_D3hot = 3,
+	PCI_D3cold = 4
+};
+
+static inline enum pci_state to_pci_state(suspend_state_t state)
+{
+	if (SUSPEND_EQ(state, PM_SUSPEND_ON))
+		return PCI_D0;
+	if (SUSPEND_EQ(state, PM_SUSPEND_STANDBY))
+		return PCI_D1;
+	if (SUSPEND_EQ(state, PM_SUSPEND_MEM))
+		return PCI_D3hot;
+	if (SUSPEND_EQ(state, PM_SUSPEND_DISK))
+		return PCI_D3cold;
+	BUG();
+	return PCI_D0;	/* akpm complained about warnings? */
+}
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
--- tmp/linux/include/linux/pm.h	2004-08-15 19:15:05.000000000 +0200
+++ linux/include/linux/pm.h	2004-08-15 19:35:41.000000000 +0200
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
 
--- tmp/linux/kernel/power/console.c	2004-02-20 12:29:52.000000000 +0100
+++ linux/kernel/power/console.c	2004-06-03 00:27:20.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/vt_kern.h>
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include "power.h"
 
 static int new_loglevel = 10;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
