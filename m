Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSF3NlR>; Sun, 30 Jun 2002 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSF3NlQ>; Sun, 30 Jun 2002 09:41:16 -0400
Received: from [193.14.93.89] ([193.14.93.89]:31236 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S315171AbSF3NlM>;
	Sun, 30 Jun 2002 09:41:12 -0400
From: Christer Weinigel <wingel@nano-system.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: SCx200 patches part 1/3 -- Watchdog driver
Date: 30 Jun 2002 15:43:29 +0200
Message-ID: <m3sn347ugu.fsf@acolyte.hack.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the forst patch out of three that adds support for the
National Semiconductor SCx200 processor.  The patches are fairly
standalone, except that the two next patches both need some header
file changes from this patch.

This patch adds a watchdog driver for the SCx200 processors, and also
changes some header files that are needed.

The patch is against a 2.4.19-pre10 kernel.

  /Christer

diff -urw ./linux/Documentation/Configure.help.orig ./linux/Documentation/Configure.help
--- ./linux/Documentation/Configure.help.orig	Sun Jun 30 12:53:14 2002
+++ ./linux/Documentation/Configure.help	Sun Jun 30 14:46:16 2002
@@ -24982,6 +24982,13 @@
   information:  http://www.candelatech.com/~greear/vlan.html  If unsure,
   you can safely say 'N'.
 
+NatSemi SCx200 Watchdog
+CONFIG_SCx200_WDT
+  Enable the built-in watchdog timer support on the National 
+  Semiconductor SCx200 processors.
+
+  If compiled as a module, it will be called scx200_watchdog.o.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
diff -urw ./linux/MAINTAINERS.orig ./linux/MAINTAINERS
--- ./linux/MAINTAINERS.orig	Fri Jun 28 14:06:10 2002
+++ ./linux/MAINTAINERS	Sun Jun 30 15:07:54 2002
@@ -1403,6 +1403,12 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+SCx200 CPU SUPPORT
+P:	Christer Weinigel
+M:	wingel@nano-system.com
+W:	http://www.nano-system.com
+S:	Supported
+
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Bent Hagemark
 M:	bh@sgi.com
diff -urw ./linux/drivers/char/Config.in.orig ./linux/drivers/char/Config.in
--- ./linux/drivers/char/Config.in.orig	Fri Jun 28 14:06:20 2002
+++ ./linux/drivers/char/Config.in	Sun Jun 30 12:40:30 2002
@@ -198,6 +198,7 @@
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD 
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    dep_tristate '  SC1200 Watchdog Timer (EXPERIMENTAL)' CONFIG_SC1200_WDT $CONFIG_EXPERIMENTAL
+   tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WDT
    tristate '  Software Watchdog' CONFIG_SOFT_WATCHDOG
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  WDT Watchdog timer' CONFIG_WDT
diff -urw ./linux/drivers/char/Makefile.orig ./linux/drivers/char/Makefile
--- ./linux/drivers/char/Makefile.orig	Fri Jun 28 14:06:20 2002
+++ ./linux/drivers/char/Makefile	Sun Jun 30 12:40:30 2002
@@ -260,6 +260,7 @@
 obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 
diff -urw ./linux/drivers/char/scx200_wdt.c.orig ./linux/drivers/char/scx200_wdt.c
--- ./linux/drivers/char/scx200_wdt.c.orig	Sun Jun 30 12:40:30 2002
+++ ./linux/drivers/char/scx200_wdt.c	Sun Jun 30 12:40:30 2002
@@ -0,0 +1,279 @@
+/* linux/drivers/char/scx200_wdt.c 
+
+   National Semiconductor SCx200 Watchdog support
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Som code taken from:
+   National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
+   (c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+
+   This program is free software; you can redistribute it and/or
+   modify it under the terms of the GNU General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The author(s) of this software shall not be held liable for damages
+   of any nature resulting due to the use of this software. This
+   software is provided AS-IS with no warranties. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <linux/scx200.h>
+
+#define NAME "scx200_wdt"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 Watchdog Driver");
+MODULE_LICENSE("GPL");
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+#define CONFIG_WATCHDOG_NOWAYOUT 0
+#endif
+
+static int margin = 60;		/* in seconds */
+MODULE_PARM(margin, "i");
+MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
+
+static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
+MODULE_PARM(nowayout, "i");
+MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
+
+static u16 wdto_restart;
+static struct semaphore open_semaphore;
+static unsigned expect_close;
+
+/* Bits of the WDCNFG register */
+#define W_ENABLE 0x00fa		/* Enable watchdog */
+#define W_DISABLE 0x0000	/* Disable watchdog */
+
+/* The scaling factor for the timer, this depends on the value of W_ENABLE */
+#define W_SCALE (32768/1024)
+
+static void scx200_wdt_ping(void)
+{
+	outw(wdto_restart, SCx200_CB_BASE + SCx200_WDT_WDTO);
+}
+
+static void scx200_wdt_update_margin(void)
+{
+	printk(KERN_INFO NAME ": timer margin %d seconds\n", margin);
+	wdto_restart = margin * W_SCALE;
+}
+
+static void scx200_wdt_enable(void)
+{
+	printk(KERN_DEBUG NAME ": enabling watchdog timer, wdto_restart = %d\n", 
+	       wdto_restart);
+
+	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
+	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
+	outw(W_ENABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
+
+	scx200_wdt_ping();
+}
+
+static void scx200_wdt_disable(void)
+{
+	printk(KERN_DEBUG NAME ": disabling watchdog timer\n");
+		
+	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
+	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
+	outw(W_DISABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
+}
+
+static int scx200_wdt_open(struct inode *inode, struct file *file)
+{
+        /* only allow one at a time */
+        if (down_trylock(&open_semaphore))
+                return -EBUSY;
+	scx200_wdt_enable();
+	expect_close = 0;
+
+	return 0;
+}
+
+static int scx200_wdt_release(struct inode *inode, struct file *file)
+{
+	if (!expect_close) {
+		printk(KERN_WARNING NAME ": watchdog device closed unexpectedly, will not disable the watchdog timer\n");
+	} else if (!nowayout) {
+		scx200_wdt_disable();
+	}
+        up(&open_semaphore);
+
+	return 0;
+}
+
+static int scx200_wdt_notify_sys(struct notifier_block *this, 
+				      unsigned long code, void *unused)
+{
+        if (code == SYS_HALT || code == SYS_POWER_OFF)
+		if (!nowayout)
+			scx200_wdt_disable();
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block scx200_wdt_notifier =
+{
+        notifier_call: scx200_wdt_notify_sys
+};
+
+static ssize_t scx200_wdt_write(struct file *file, const char *data, 
+				     size_t len, loff_t *ppos)
+{
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/* check for a magic close character */
+	if (len) 
+	{
+		size_t i;
+
+		scx200_wdt_ping();
+
+		expect_close = 0;
+		for (i = 0; i < len; ++i) {
+			char c;
+			if (get_user(c, data+i))
+				return -EFAULT;
+			if (c == 'V')
+				expect_close = 1;
+		}
+
+		return len;
+	}
+
+	return 0;
+}
+
+static int scx200_wdt_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		identity: "NatSemi SCx200 Watchdog",
+		firmware_version: 1, 
+		options: (
+#ifdef WDIOF_SETTIMEOUT
+			WDIOF_SETTIMEOUT | 
+#endif
+			WDIOF_KEEPALIVEPING),
+	};
+	int new_margin;
+	
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	case WDIOC_GETSUPPORT:
+		if(copy_to_user((struct watchdog_info *)arg, &ident, 
+				sizeof(ident)))
+			return -EFAULT;
+		return 0;
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, (int *)arg);
+	case WDIOC_KEEPALIVE:
+		scx200_wdt_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if (new_margin < 1)
+			return -EINVAL;
+		margin = new_margin;
+		scx200_wdt_update_margin();
+		scx200_wdt_ping();
+#ifdef WDIOC_GETTIMEOUT
+	case WDIOC_GETTIMEOUT:
+#endif
+		return put_user(margin, (int *)arg);
+	}
+}
+
+static struct file_operations scx200_wdt_fops = {
+	owner: THIS_MODULE,
+	write: scx200_wdt_write,
+	ioctl: scx200_wdt_ioctl,
+	open: scx200_wdt_open,
+	release: scx200_wdt_release,
+};
+
+static struct miscdevice scx200_wdt_miscdev = {
+	minor: WATCHDOG_MINOR,
+	name: NAME,
+	fops: &scx200_wdt_fops,
+};
+
+static int __init scx200_wdt_init(void)
+{
+	int r;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 Watchdog Driver\n");
+
+	/* First check that this really is a NatSemi SCx200 CPU */
+	if ((pci_find_device(PCI_VENDOR_ID_NS, 
+			     PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+			     NULL)) == NULL)
+		return -ENODEV;
+
+	/* More sanity checks, verify that the configuration block is there */
+	if (!scx200_cb_probe(SCx200_CB_BASE)) {
+		printk(KERN_WARNING NAME ": no configuration block found\n");
+		return -ENODEV;
+	}
+
+	if (!request_region(SCx200_CB_BASE + SCx200_WDT_OFFSET, 
+			    SCx200_WDT_SIZE, 
+			    "NatSemi SCx200 Watchdog")) {
+		printk(KERN_WARNING NAME ": watchdog I/O region busy\n");
+		return -EBUSY;
+	}
+
+	scx200_wdt_update_margin();
+	scx200_wdt_disable();
+
+	sema_init(&open_semaphore, 1);
+
+	r = misc_register(&scx200_wdt_miscdev);
+	if (r)
+		return r;
+
+	r = register_reboot_notifier(&scx200_wdt_notifier);
+        if (r) {
+                printk(KERN_ERR NAME ": unable to register reboot notifier");
+		misc_deregister(&scx200_wdt_miscdev);
+                return r;
+        }
+
+	return 0;
+}
+
+static void __exit scx200_wdt_cleanup(void)
+{
+        unregister_reboot_notifier(&scx200_wdt_notifier);
+	misc_deregister(&scx200_wdt_miscdev);
+	release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+		       SCx200_WDT_SIZE);
+}
+
+module_init(scx200_wdt_init);
+module_exit(scx200_wdt_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
+        c-basic-offset: 8
+    End:
+*/
diff -urw ./linux/include/linux/pci_ids.h.orig ./linux/include/linux/pci_ids.h
--- ./linux/include/linux/pci_ids.h.orig	Fri Jun 28 14:06:44 2002
+++ ./linux/include/linux/pci_ids.h	Sun Jun 30 12:40:30 2002
@@ -287,6 +287,12 @@
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
 #define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_83820		0x0022
+#define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
+#define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
+#define PCI_DEVICE_ID_NS_SCx200_IDE	0x0502
+#define PCI_DEVICE_ID_NS_SCx200_AUDIO	0x0503
+#define PCI_DEVICE_ID_NS_SCx200_VIDEO	0x0504
+#define PCI_DEVICE_ID_NS_SCx200_XBUS	0x0505
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
 #define PCI_VENDOR_ID_TSENG		0x100c
diff -urw ./linux/include/linux/scx200.h.orig ./linux/include/linux/scx200.h
--- ./linux/include/linux/scx200.h.orig	Sun Jun 30 12:40:30 2002
+++ ./linux/include/linux/scx200.h	Sun Jun 30 12:40:30 2002
@@ -0,0 +1,56 @@
+/* linux/include/linux/scx200.h
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Defines for the National Semiconductor SCx200 Processors
+*/
+
+/* Interesting stuff for the National Semiconductor SCx200 CPU */
+
+/* F0 PCI Header/Bridge Configuration Registers */
+#define SCx200_DOCCS_BASE 0x78	/* DOCCS Base Address Register */
+#define SCx200_DOCCS_CTRL 0x7c	/* DOCCS Control Register */
+
+/* GPIO Register Block */
+#define SCx200_GPIO_SIZE 0x2c	/* Size of GPIO register block */
+
+/* General Configuration Block */
+#define SCx200_CB_BASE 0x9000	/* Base fixed at 0x9000 according to errata */
+
+/* Watchdog Timer */
+#define SCx200_WDT_OFFSET 0x00	/* offset within configuration block */
+#define SCx200_WDT_SIZE 0x05	/* size */
+
+#define SCx200_WDT_WDTO 0x00	/* Time-Out Register */
+#define SCx200_WDT_WDCNFG 0x02	/* Configuration Register */
+#define SCx200_WDT_WDSTS 0x04	/* Status Register */
+#define SCx200_WDT_WDSTS_WDOVF (1<<0) /* Overflow bit */
+
+/* High Resolution Timer */
+#define SCx200_TIMER_OFFSET 0x08
+#define SCx200_TIMER_SIZE 0x05
+
+/* Clock Generators */
+#define SCx200_CLOCKGEN_OFFSET 0x10
+#define SCx200_CLOCKGEN_SIZE 0x10
+
+/* Pin Multiplexing and Miscellaneous Configuration Registers */
+#define SCx200_MISC_OFFSET 0x30
+#define SCx200_MISC_SIZE 0x10
+
+#define SCx200_PMR 0x30		/* Pin Multiplexing Register */
+#define SCx200_MCR 0x34		/* Miscellaneous Configuration Register */
+#define SCx200_INTSEL 0x38	/* Interrupt Selection Register */
+#define SCx200_IID 0x3c		/* IA On a Chip Identification Number Reg */
+#define SCx200_REV 0x3d		/* Revision Register */
+#define SCx200_CBA 0x3e		/* Configuration Base Address Register */
+
+/* Verify that the configuration block really is there */
+#define scx200_cb_probe(base) (inw((base) + SCx200_CBA) == (base))
+
+/*
+    Local variables:
+        compile-command: "make -C ../.. modules"
+        c-basic-offset: 8
+    End:
+*/





-- 
"Just how much can I get away with and still go to heaven?"
