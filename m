Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVDMD55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVDMD55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVDLTO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:14:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:44489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262207AbVDLKce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:34 -0400
Message-Id: <200504121032.j3CAWJna005557@shell0.pdx.osdl.net>
Subject: [patch 105/198] pm_message_t: more fixes in common and i386
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

I thought I'm done with fixing u32 vs.  pm_message_t ...  unfortunately
that turned out not to be the case as Russel King pointed out.  Here are
fixes for Documentation and common code (mainly system devices).

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/driver-model/bus.txt    |    2 +-
 25-akpm/Documentation/driver-model/driver.txt |    4 ++--
 25-akpm/arch/i386/kernel/apic.c               |    2 +-
 25-akpm/arch/i386/kernel/i8259.c              |    2 +-
 25-akpm/arch/i386/kernel/io_apic.c            |    2 +-
 25-akpm/arch/i386/kernel/nmi.c                |    2 +-
 25-akpm/arch/i386/kernel/time.c               |    2 +-
 25-akpm/arch/i386/oprofile/nmi_int.c          |    2 +-
 25-akpm/drivers/base/sys.c                    |    3 ++-
 25-akpm/include/linux/pci.h                   |    5 +++--
 25-akpm/include/linux/sysdev.h                |    5 +++--
 11 files changed, 17 insertions(+), 14 deletions(-)

diff -puN arch/i386/kernel/apic.c~pm_message_t-more-fixes-in-common-and-i386 arch/i386/kernel/apic.c
--- 25/arch/i386/kernel/apic.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.164855192 -0700
+++ 25-akpm/arch/i386/kernel/apic.c	2005-04-12 03:21:28.181852608 -0700
@@ -548,7 +548,7 @@ static struct {
 	unsigned int apic_thmr;
 } apic_pm_state;
 
-static int lapic_suspend(struct sys_device *dev, u32 state)
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	unsigned long flags;
 
diff -puN arch/i386/kernel/i8259.c~pm_message_t-more-fixes-in-common-and-i386 arch/i386/kernel/i8259.c
--- 25/arch/i386/kernel/i8259.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.165855040 -0700
+++ 25-akpm/arch/i386/kernel/i8259.c	2005-04-12 03:21:28.182852456 -0700
@@ -262,7 +262,7 @@ static int i8259A_resume(struct sys_devi
 	return 0;
 }
 
-static int i8259A_suspend(struct sys_device *dev, u32 state)
+static int i8259A_suspend(struct sys_device *dev, pm_message_t state)
 {
 	save_ELCR(irq_trigger);
 	return 0;
diff -puN arch/i386/kernel/io_apic.c~pm_message_t-more-fixes-in-common-and-i386 arch/i386/kernel/io_apic.c
--- 25/arch/i386/kernel/io_apic.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.167854736 -0700
+++ 25-akpm/arch/i386/kernel/io_apic.c	2005-04-12 03:21:28.190851240 -0700
@@ -2299,7 +2299,7 @@ struct sysfs_ioapic_data {
 };
 static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
 
-static int ioapic_suspend(struct sys_device *dev, u32 state)
+static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct IO_APIC_route_entry *entry;
 	struct sysfs_ioapic_data *data;
diff -puN arch/i386/kernel/nmi.c~pm_message_t-more-fixes-in-common-and-i386 arch/i386/kernel/nmi.c
--- 25/arch/i386/kernel/nmi.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.168854584 -0700
+++ 25-akpm/arch/i386/kernel/nmi.c	2005-04-12 03:21:28.191851088 -0700
@@ -265,7 +265,7 @@ void enable_timer_nmi_watchdog(void)
 
 static int nmi_pm_active; /* nmi_active before suspend */
 
-static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
+static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
diff -puN arch/i386/kernel/time.c~pm_message_t-more-fixes-in-common-and-i386 arch/i386/kernel/time.c
--- 25/arch/i386/kernel/time.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.170854280 -0700
+++ 25-akpm/arch/i386/kernel/time.c	2005-04-12 03:21:28.192850936 -0700
@@ -376,7 +376,7 @@ void notify_arch_cmos_timer(void)
 
 static long clock_cmos_diff, sleep_start;
 
-static int timer_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
diff -puN arch/i386/oprofile/nmi_int.c~pm_message_t-more-fixes-in-common-and-i386 arch/i386/oprofile/nmi_int.c
--- 25/arch/i386/oprofile/nmi_int.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.171854128 -0700
+++ 25-akpm/arch/i386/oprofile/nmi_int.c	2005-04-12 03:21:28.192850936 -0700
@@ -32,7 +32,7 @@ static int nmi_enabled = 0;
 
 #ifdef CONFIG_PM
 
-static int nmi_suspend(struct sys_device *dev, u32 state)
+static int nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	if (nmi_enabled == 1)
 		nmi_stop();
diff -puN Documentation/driver-model/bus.txt~pm_message_t-more-fixes-in-common-and-i386 Documentation/driver-model/bus.txt
--- 25/Documentation/driver-model/bus.txt~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.172853976 -0700
+++ 25-akpm/Documentation/driver-model/bus.txt	2005-04-12 03:21:28.193850784 -0700
@@ -18,7 +18,7 @@ struct bus_type {
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
-	int		(*suspend)(struct device * dev, u32 state);
+	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };
 
diff -puN Documentation/driver-model/driver.txt~pm_message_t-more-fixes-in-common-and-i386 Documentation/driver-model/driver.txt
--- 25/Documentation/driver-model/driver.txt~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.174853672 -0700
+++ 25-akpm/Documentation/driver-model/driver.txt	2005-04-12 03:21:28.193850784 -0700
@@ -16,7 +16,7 @@ struct device_driver {
         int     (*probe)        (struct device * dev);
         int     (*remove)       (struct device * dev);
 
-        int     (*suspend)      (struct device * dev, u32 state, u32 level);
+        int     (*suspend)      (struct device * dev, pm_message_t state, u32 level);
         int     (*resume)       (struct device * dev, u32 level);
 
         void    (*release)      (struct device_driver * drv);
@@ -195,7 +195,7 @@ device; i.e. anything in the device's dr
 If the device is still present, it should quiesce the device and place
 it into a supported low-power state.
 
-	int	(*suspend)	(struct device * dev, u32 state, u32 level);
+	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 
 suspend is called to put the device in a low power state. There are
 several stages to successfully suspending a device, which is denoted in
diff -puN drivers/base/sys.c~pm_message_t-more-fixes-in-common-and-i386 drivers/base/sys.c
--- 25/drivers/base/sys.c~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.175853520 -0700
+++ 25-akpm/drivers/base/sys.c	2005-04-12 03:21:28.194850632 -0700
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/pm.h>
 
 
 extern struct subsystem devices_subsys;
@@ -302,7 +303,7 @@ void sysdev_shutdown(void)
  *	all synchronization.
  */
 
-int sysdev_suspend(u32 state)
+int sysdev_suspend(pm_message_t state)
 {
 	struct sysdev_class * cls;
 
diff -puN include/linux/pci.h~pm_message_t-more-fixes-in-common-and-i386 include/linux/pci.h
--- 25/include/linux/pci.h~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.176853368 -0700
+++ 25-akpm/include/linux/pci.h	2005-04-12 03:21:28.195850480 -0700
@@ -501,6 +501,7 @@ typedef int __bitwise pci_power_t;
 #define PCI_D2	((pci_power_t __force) 2)
 #define PCI_D3hot	((pci_power_t __force) 3)
 #define PCI_D3cold	((pci_power_t __force) 4)
+#define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
 /*
  * The pci_dev structure is used to describe PCI devices.
@@ -669,7 +670,7 @@ struct pci_driver {
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
-	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
+	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
 
 	struct device_driver	driver;
 	struct pci_dynids dynids;
@@ -952,7 +953,7 @@ static inline const struct pci_device_id
 static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline int pci_restore_state(struct pci_dev *dev) { return 0; }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state) { return 0; }
-static inline pci_power_t pci_choose_state(struct pci_dev *dev, u32 state) { return PCI_D0; }
+static inline pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state) { return PCI_D0; }
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable) { return 0; }
 
 #define	isa_bridge	((struct pci_dev *)NULL)
diff -puN include/linux/sysdev.h~pm_message_t-more-fixes-in-common-and-i386 include/linux/sysdev.h
--- 25/include/linux/sysdev.h~pm_message_t-more-fixes-in-common-and-i386	2005-04-12 03:21:28.178853064 -0700
+++ 25-akpm/include/linux/sysdev.h	2005-04-12 03:21:28.196850328 -0700
@@ -22,6 +22,7 @@
 #define _SYSDEV_H_
 
 #include <linux/kobject.h>
+#include <linux/pm.h>
 
 
 struct sys_device;
@@ -31,7 +32,7 @@ struct sysdev_class {
 
 	/* Default operations for these types of devices */
 	int	(*shutdown)(struct sys_device *);
-	int	(*suspend)(struct sys_device *, u32 state);
+	int	(*suspend)(struct sys_device *, pm_message_t state);
 	int	(*resume)(struct sys_device *);
 	struct kset		kset;
 };
@@ -50,7 +51,7 @@ struct sysdev_driver {
 	int	(*add)(struct sys_device *);
 	int	(*remove)(struct sys_device *);
 	int	(*shutdown)(struct sys_device *);
-	int	(*suspend)(struct sys_device *, u32 state);
+	int	(*suspend)(struct sys_device *, pm_message_t state);
 	int	(*resume)(struct sys_device *);
 };
 
_
