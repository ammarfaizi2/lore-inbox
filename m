Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVDBVGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDBVGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVDBVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:05:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3017 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261283AbVDBVEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:04:20 -0500
Date: Sat, 2 Apr 2005 23:03:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: pm_message_t: more fixes in common and i386
Message-ID: <20050402210347.GA1968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I thought I'm done with fixing u32 vs. pm_message_t ... unfortunately
that turned out not to be the case as Russel King pointed out. Here
are fixes for Documentation and common code (mainly system
devices). [These patches are independend and change no object code;
therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
							Pavel

--- clean-cvs/include/linux/pci.h	2005-03-29 13:31:52.000000000 +0200
+++ linux-cvs/include/linux/pci.h	2005-03-31 23:54:51.000000000 +0200
@@ -501,6 +501,7 @@
 #define PCI_D2	((pci_power_t __force) 2)
 #define PCI_D3hot	((pci_power_t __force) 3)
 #define PCI_D3cold	((pci_power_t __force) 4)
+#define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
 /*
  * The pci_dev structure is used to describe PCI devices.
@@ -669,7 +670,7 @@
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
-	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
+	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 
 	struct device_driver	driver;
 	struct pci_dynids dynids;
@@ -952,7 +953,7 @@
 static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline int pci_restore_state(struct pci_dev *dev) { return 0; }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state) { return 0; }
-static inline pci_power_t pci_choose_state(struct pci_dev *dev, u32 state) { return PCI_D0; }
+static inline pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state) { return PCI_D0; }
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable) { return 0; }
 
 #define	isa_bridge	((struct pci_dev *)NULL)
--- clean-cvs/Documentation/driver-model/bus.txt	2004-08-26 00:52:57.000000000 +0200
+++ linux-cvs/Documentation/driver-model/bus.txt	2005-03-31 23:54:41.000000000 +0200
@@ -18,7 +18,7 @@
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
-	int		(*suspend)(struct device * dev, u32 state);
+	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };
 
--- clean-cvs/Documentation/driver-model/driver.txt	2003-05-17 03:31:10.000000000 +0200
+++ linux-cvs/Documentation/driver-model/driver.txt	2005-03-31 23:54:41.000000000 +0200
@@ -16,7 +16,7 @@
         int     (*probe)        (struct device * dev);
         int     (*remove)       (struct device * dev);
 
-        int     (*suspend)      (struct device * dev, u32 state, u32 level);
+        int     (*suspend)      (struct device * dev, pm_message_t state, u32 level);
         int     (*resume)       (struct device * dev, u32 level);
 
         void    (*release)      (struct device_driver * drv);
@@ -195,7 +195,7 @@
 If the device is still present, it should quiesce the device and place
 it into a supported low-power state.
 
-	int	(*suspend)	(struct device * dev, u32 state, u32 level);
+	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 
 suspend is called to put the device in a low power state. There are
 several stages to successfully suspending a device, which is denoted in
--- clean-cvs/arch/i386/kernel/apic.c	2005-03-31 23:31:19.000000000 +0200
+++ linux-cvs/arch/i386/kernel/apic.c	2005-03-31 23:54:43.000000000 +0200
@@ -548,7 +548,7 @@
 	unsigned int apic_thmr;
 } apic_pm_state;
 
-static int lapic_suspend(struct sys_device *dev, u32 state)
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	unsigned long flags;
 
--- clean-cvs/arch/i386/kernel/i8259.c	2005-03-15 23:27:33.000000000 +0100
+++ linux-cvs/arch/i386/kernel/i8259.c	2005-03-31 23:54:43.000000000 +0200
@@ -262,7 +262,7 @@
 	return 0;
 }
 
-static int i8259A_suspend(struct sys_device *dev, u32 state)
+static int i8259A_suspend(struct sys_device *dev, pm_message_t state)
 {
 	save_ELCR(irq_trigger);
 	return 0;
--- clean-cvs/arch/i386/kernel/io_apic.c	2005-03-31 23:31:20.000000000 +0200
+++ linux-cvs/arch/i386/kernel/io_apic.c	2005-03-31 23:54:43.000000000 +0200
@@ -2299,7 +2299,7 @@
 };
 static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
 
-static int ioapic_suspend(struct sys_device *dev, u32 state)
+static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct IO_APIC_route_entry *entry;
 	struct sysfs_ioapic_data *data;
--- clean-cvs/arch/i386/kernel/nmi.c	2005-03-31 23:31:20.000000000 +0200
+++ linux-cvs/arch/i386/kernel/nmi.c	2005-03-31 23:54:43.000000000 +0200
@@ -265,7 +265,7 @@
 
 static int nmi_pm_active; /* nmi_active before suspend */
 
-static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
+static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
--- clean-cvs/arch/i386/kernel/time.c	2005-03-31 23:31:21.000000000 +0200
+++ linux-cvs/arch/i386/kernel/time.c	2005-03-31 23:54:43.000000000 +0200
@@ -376,7 +376,7 @@
 
 static long clock_cmos_diff, sleep_start;
 
-static int timer_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
--- clean-cvs/arch/i386/oprofile/nmi_int.c	2005-03-15 23:27:39.000000000 +0100
+++ linux-cvs/arch/i386/oprofile/nmi_int.c	2005-03-31 23:54:43.000000000 +0200
@@ -32,7 +32,7 @@
 
 #ifdef CONFIG_PM
 
-static int nmi_suspend(struct sys_device *dev, u32 state)
+static int nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	if (nmi_enabled == 1)
 		nmi_stop();


--- clean-cvs/drivers/base/sys.c	2005-03-29 13:29:36.000000000 +0200
+++ linux-cvs/drivers/base/sys.c	2005-03-31 23:54:43.000000000 +0200
@@ -20,7 +20,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-
+#include <linux/pm.h>
 
 extern struct subsystem devices_subsys;
 
@@ -302,7 +302,7 @@
  *	all synchronization.
  */
 
-int sysdev_suspend(u32 state)
+int sysdev_suspend(pm_message_t state)
 {
 	struct sysdev_class * cls;
 
--- clean-cvs/include/linux/sysdev.h	2004-03-03 05:41:03.000000000 +0100
+++ linux-cvs/include/linux/sysdev.h	2005-03-31 23:54:51.000000000 +0200
@@ -22,6 +22,7 @@
 #define _SYSDEV_H_
 
 #include <linux/kobject.h>
+#include <linux/pm.h>
 
 
 struct sys_device;
@@ -31,7 +32,7 @@
 
 	/* Default operations for these types of devices */
 	int	(*shutdown)(struct sys_device *);
-	int	(*suspend)(struct sys_device *, u32 state);
+	int	(*suspend)(struct sys_device *, pm_message_t state);
 	int	(*resume)(struct sys_device *);
 	struct kset		kset;
 };
@@ -50,7 +51,7 @@
 	int	(*add)(struct sys_device *);
 	int	(*remove)(struct sys_device *);
 	int	(*shutdown)(struct sys_device *);
-	int	(*suspend)(struct sys_device *, u32 state);
+	int	(*suspend)(struct sys_device *, pm_message_t state);
 	int	(*resume)(struct sys_device *);
 };
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
