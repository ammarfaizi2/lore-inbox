Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311954AbSCQH50>; Sun, 17 Mar 2002 02:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311958AbSCQH5R>; Sun, 17 Mar 2002 02:57:17 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:47035 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311954AbSCQH5K>; Sun, 17 Mar 2002 02:57:10 -0500
Date: Sun, 17 Mar 2002 09:40:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] CS5530 Power Management
Message-ID: <Pine.LNX.4.44.0203170936420.6387-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In light of what Alan stated earlier about Geode based boxes and the BIOS 
doing the right thing, i wonder if the following code is still valid. Main 
features are enabling the idle timers and enabling active_idle. I'd 
appreciate comments on wether the BIOS does this stuff too.

Cheers,
	Zwane "power management freak" Mwaikambo

Diffed against 2.4.19-pre2-ac3

diff -urN linux-2.4.19-orig/Documentation/Configure.help linux-2.4.19-work/Documentation/Configure.help
--- linux-2.4.19-orig/Documentation/Configure.help	Sat Mar 16 22:31:57 2002
+++ linux-2.4.19-work/Documentation/Configure.help	Sat Mar 16 22:39:15 2002
@@ -17441,6 +17441,19 @@
 
   If unsure, say N.
 
+National Semiconductor CS5530 Enhanced Power Management
+CONFIG_CS5530PM
+  This driver enables additional power management features of the
+  National Semiconductor CS5530 South Bridge. It currently supports
+  user configurable inactivity timeout and CPU power saving via
+  the active idle mode as supported by the Geode GX range of processors.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module is called sc5530_pm.o.  If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.  Most
+  people will say N.
+
 Power Management support
 CONFIG_PM
   "Power Management" means that parts of your computer are shut
diff -urN linux-2.4.19-orig/MAINTAINERS linux-2.4.19-work/MAINTAINERS
--- linux-2.4.19-orig/MAINTAINERS	Sat Mar 16 22:31:57 2002
+++ linux-2.4.19-work/MAINTAINERS	Sat Mar 16 22:39:15 2002
@@ -388,6 +388,12 @@
 W:	http://developer.axis.com
 S:	Maintained
 
+CS5530 POWER MANAGEMENT DRIVER
+P:	Zwane Mwaikambo
+M:	zwane@commfireservices.com
+W:	http://www.national.com
+S:	Maintained
+
 CYBERPRO FB DRIVER
 P:	Russell King
 M:	rmk@arm.linux.org.uk
diff -urN linux-2.4.19-orig/drivers/char/Config.in linux-2.4.19-work/drivers/char/Config.in
--- linux-2.4.19-orig/drivers/char/Config.in	Sat Mar 16 22:31:57 2002
+++ linux-2.4.19-work/drivers/char/Config.in	Sat Mar 16 22:39:15 2002
@@ -222,6 +222,7 @@
 dep_tristate 'AMD 768 Random Number Generator support' CONFIG_AMD_RNG $CONFIG_PCI
 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
 dep_tristate 'AMD 762/768 native power management' CONFIG_AMD_PM768 $CONFIG_PCI
+dep_tristate 'Natsemi CS5530 Enhanced Power Management (EXPERIMENTAL)' CONFIG_CS5530PM $CONFIG_PCI $CONFIG_EXPERIMENTAL
 tristate '/dev/nvram support' CONFIG_NVRAM
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_IA64" = "y" ]; then
diff -urN linux-2.4.19-orig/drivers/char/Makefile linux-2.4.19-work/drivers/char/Makefile
--- linux-2.4.19-orig/drivers/char/Makefile	Sat Mar 16 22:31:57 2002
+++ linux-2.4.19-work/drivers/char/Makefile	Sat Mar 16 22:39:15 2002
@@ -206,6 +206,7 @@
 obj-$(CONFIG_INTEL_RNG) += i810_rng.o
 obj-$(CONFIG_AMD_RNG) += amd768_rng.o
 obj-$(CONFIG_AMD_PM768) += amd768_pm.o
+obj-$(CONFIG_CS5530PM) += cs5530_pm.o
 
 obj-$(CONFIG_ITE_GPIO) += ite_gpio.o
 obj-$(CONFIG_AU1000_GPIO) += au1000_gpio.o
diff -urN linux-2.4.19-orig/drivers/char/cs5530_pm.c linux-2.4.19-work/drivers/char/cs5530_pm.c
--- linux-2.4.19-orig/drivers/char/cs5530_pm.c	Thu Jan  1 02:00:00 1970
+++ linux-2.4.19-work/drivers/char/cs5530_pm.c	Sat Mar 16 22:39:29 2002
@@ -0,0 +1,193 @@
+/*	Enhanced Power Management driver for National Semiconductor CS5530
+ *
+ *	(c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+ *	All Rights Reserved.
+ *
+ *	Inspired and based on amd768pm.c by Alan Cox
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	The author(s) of this software shall not be held liable for damages
+ *	of any nature resulting due to the use of this software. This
+ *	software is provided AS-IS with no warranties.
+ *
+ *	Changelog:
+ *	20020317	Zwane Mwaikambo		Test release
+ *	
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/uaccess.h>
+
+#define CS5530PM_MODULE_VER	"build 20020316"
+#define CS5530PM_MODULE_NAME	"cs5530pm"
+#define PFX			CS5530PM_MODULE_NAME ": "
+
+#define MAX_IDLE_TIMEOUT	65536	/* max idle timer value in seconds */
+
+/* PCI config registers, all at F0 */
+#define PCI_PMER1		0x80	/* power management enable register 1 */
+#define PCI_PMER2		0x81	/* power management enable register 2 */
+#define PCI_SUSCFG		0x96	/* suspend configuration register */
+#define PCI_PHDDTC		0x98	/* primary hdd timer count */
+#define PCI_SHDDTC		0xac	/* secondary hdd timer count */
+#define PCI_FDDTC		0x9a	/* floppy disk timer count */
+#define PCI_PRTTC		0x9c	/* parallel/serial timer count */
+#define PCI_KBCTC		0x9e	/* keyboard/mouse timer count */
+
+/* PMER1 bits */
+#define GPM			(1<<0)	/* global power management */
+#define GIT			(1<<1)	/* globally enable PM device idle timers */
+#define GTR			(1<<2)	/* globally enable IO traps */
+/* 3 - 5 not implemented (set to 0)
+ * 4 - 7 reserved (set to 0) */
+
+/* PMER2 bits */
+#define HDDTMR			(1<<0)	/* primary harddisk timer enable */
+#define FDDTMR			(1<<1)	/* floppy disk timer enable */
+#define PRTTMR			(1<<2)	/* parallel/serial port timer enable */
+#define KBCTMR			(1<<3)	/* keyboard/mouse timer enable */
+/* 4 - 7 not implemented (set to 0) */
+
+/* SUSCFG bits */
+#define SUSCFG			(1<<2)	/* enable powering down a GX processor */
+#define PWRSVE_ISA		(1<<3)	/* stop ISA clock */
+#define PWRSVE			(1<<4)	/* active idle */
+
+/* for restoring on exit */
+static u8 pci_pmer1;
+static u8 pci_pmer2;
+static u8 pci_suscfg;
+
+static struct pci_dev *cs5530;
+static int timeout = 1800;
+static int active_idle = 1;
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "idle timer range is 1-1092 minutes, default is 30");
+MODULE_PARM(active_idle, "i");
+MODULE_PARM_DESC(active_idle, "enable(1) / disable(0) active idle mode, default is 1");
+
+
+/* Configure PM abilities */
+static int __init cs5530pm_config(void)
+{
+	u8 byte_reg;
+	
+	/* save for restoring later */
+	pci_read_config_byte(cs5530, PCI_PMER1, &pci_pmer1);
+	pci_read_config_byte(cs5530, PCI_PMER2, &pci_pmer2);
+	pci_read_config_byte(cs5530, PCI_SUSCFG, &pci_suscfg);
+
+	/* enable power management, idle timers */
+	printk(KERN_INFO PFX "Enabling enhanced power management abilities\n");
+	if (pci_pmer1 & GPM)
+		printk(KERN_DEBUG PFX "Found GPM already enabled, continuing...\n");
+
+	byte_reg = pci_pmer1 | GPM | GIT;
+	pci_write_config_byte(cs5530, PCI_PMER1, byte_reg);
+
+	/* set timeout values, should be done before enabling specific timers */
+	timeout *= 60;
+	if ((timeout > MAX_IDLE_TIMEOUT) || (timeout <= 0))
+		timeout = MAX_IDLE_TIMEOUT;
+
+	printk(KERN_INFO PFX "Enabling idle timers, ");
+	pci_write_config_word(cs5530, PCI_PHDDTC, timeout & 0x0000ffff);
+	pci_write_config_word(cs5530, PCI_SHDDTC, timeout & 0x0000ffff);
+	pci_write_config_word(cs5530, PCI_FDDTC, timeout & 0x0000ffff);
+	pci_write_config_word(cs5530, PCI_PRTTC, timeout & 0x0000ffff);
+	pci_write_config_word(cs5530, PCI_KBCTC, timeout & 0x0000ffff);
+	pci_write_config_word(cs5530, PCI_PRTTC, timeout & 0x0000ffff);
+
+	/* enable specific devices */
+	byte_reg = pci_pmer2 | HDDTMR | FDDTMR | PRTTMR | KBCTMR;
+	pci_write_config_byte(cs5530, PCI_PMER2, byte_reg);
+	printk(KERN_INFO PFX "timeout: %d min(s)\n", timeout / 60);
+
+	/* enable active idle and GX processor suspend */
+	if (active_idle) {
+		printk(KERN_INFO PFX "Switching to active idle mode\n");
+		byte_reg = pci_suscfg | PWRSVE | PWRSVE_ISA | SUSCFG;
+		pci_write_config_byte(cs5530, PCI_SUSCFG, byte_reg);
+	}
+	
+	return 0;
+}
+
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id cs5530_pci_tbl[] __initdata = {
+	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_LEGACY, PCI_ANY_ID, PCI_ANY_ID },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE (pci, cs5530_pci_tbl);
+
+static int __init cs5530pm_init(void)
+{
+	pci_for_each_dev(cs5530) {
+		if (pci_match_device (cs5530_pci_tbl, cs5530) != NULL)
+			goto found_one;
+	}
+
+	return -ENODEV;
+
+found_one:
+	return cs5530pm_config();
+}
+
+
+/*
+ * Restore system back to non enhanced PM state
+ */
+static void __exit cs5530pm_exit (void)
+{
+	pci_write_config_byte(cs5530, PCI_PMER1, pci_pmer1);
+	pci_write_config_byte(cs5530, PCI_PMER2, pci_pmer2);
+	pci_write_config_byte(cs5530, PCI_SUSCFG, pci_suscfg);
+	printk(KERN_DEBUG PFX "Restored PM Settings, exiting...\n");
+}
+
+#ifndef MODULE
+static int __init cs5530_setup(char *str)
+{
+	int ints[4];
+
+	str = get_options (str, ARRAY_SIZE(ints), ints);
+
+	if (ints[0] > 0) {
+		timeout = ints[1];
+		if (ints[0] > 1)
+			active_idle = ints[2];
+	}
+
+	return 1;
+}
+
+__setup("cs5530pm=", cs5530_setup);
+#endif /* MODULE */
+
+
+module_init (cs5530pm_init);
+module_exit (cs5530pm_exit);
+
+MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_DESCRIPTION("National Semiconductor CS5530 Enhanced Power Management");
+MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
+

