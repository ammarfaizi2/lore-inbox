Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUHRG0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUHRG0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268664AbUHRG0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:26:46 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:48512 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268658AbUHRG0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:26:34 -0400
Date: Wed, 18 Aug 2004 08:26:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040818062601.GB7854@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org> <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817161245.50dd6b96.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hence your new suspend_state_t will need to be typecast to a pointer to
> > > struct, and not a struct.  And that's not a thing which we do in-kernel
> > > much at all.  (There's nothing wrong with the practice per-se, but in the
> > > kernel it does violate the principle of least surprise).
> > > 
> > > So if you really do intend to add more things to the suspend state I'd
> > > suggest that you set the final framework in place immediately.  Do:
> > > 
> > > struct suspend_state {
> > > 	enum system_state state;
> > > }
> > 
> > I can do that... but it will break compilation of every driver in the
> > tree. I can fix drivers I use and try to fix some more will sed, but
> > it will be painfull (and pretty big diff, and I'll probably miss some).
> 
> That's OK - it's just an hour's work.  I'd be more concerned about
> irritating people who are maintaining and using out-of-tree drivers.
> 
> Can you remind me why we need _any_ of this?  "enums to clear suspend-state
> confusion" sounds like something which is very optional.  I'd be opting to
> go do something else instead ;)

Ok, here's non-ugly patch. It may mean that ugly patch is comming in
future (BenH would argue that), but it is probably best solution for
now. Please apply,

[changelog for you:]

Switch from plain u32 to enums in power managment, so that drivers are
not confused what the parameter means, and introduce helper to convert
between system state and PCI state.

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
+++ linux/include/linux/pci.h	2004-08-18 08:17:21.000000000 +0200
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
+	int  (*suspend) (struct pci_dev *dev, enum system_state reason);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
@@ -1021,5 +1022,30 @@
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
+static inline enum pci_state to_pci_state(enum system_state state)
+{
+	switch (state) {
+	case PM_SUSPEND_ON:
+		return PCI_D0;
+	case PM_SUSPEND_STANDBY:
+		return PCI_D1;
+	case PM_SUSPEND_MEM:
+		return PCI_D3hot;
+	case PM_SUSPEND_DISK:
+		return PCI_D3cold;
+	default:
+		BUG();
+		return PCI_D0;
+	}
+}
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
--- tmp/linux/include/linux/pm.h	2004-08-15 19:15:05.000000000 +0200
+++ linux/include/linux/pm.h	2004-08-18 08:14:45.000000000 +0200
@@ -193,11 +193,11 @@
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
 
@@ -241,8 +240,11 @@
 
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
 

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


