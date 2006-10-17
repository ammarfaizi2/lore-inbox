Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWJQMeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWJQMeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWJQMeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:34:44 -0400
Received: from community1.interfree.it ([213.158.70.73]:48539 "EHLO
	community1.interfree.it") by vger.kernel.org with ESMTP
	id S1750800AbWJQMen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:34:43 -0400
Date: 17 Oct 2006 12:34:40 -0000
Message-ID: <20061017123440.4321.qmail@community1.interfree.it>
X-Originating-IP: [81.80.37.124]
From: ggaleotti@interfree.it
Reply-To: ggaleotti@interfree.it
To: akpm@osdl.org, wim@iguana.be, linux-kernel@vger.kernel.org
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
Subject: [patch 1/1] watchdog driver for Digital-Logic MSM-P5XEN PC104 unit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A simple watchdog driver for Digital-Logic's MSM-P5XEN PC104 unit.
The watchdog is a LTC1232 controlled by a single I/O port @ 0x1037.
The watchdog must be refreshed (writing a single byte) to the device
at least every 600 msecs (which is a little of overhead, but PC104
industrial applications requires a high degree of safety/reliability.)

Signed-off by: Gabriele Galeotti <ggaleotti@interfree.it>
---

--- linux-2.6.18.1/MAINTAINERS.orig	2006-10-17 14:45:27.000000000 +0200
+++ linux-2.6.18.1/MAINTAINERS	2006-10-17 14:43:02.000000000 +0200
@@ -3355,6 +3355,12 @@ M:	fuganti@netbank.com.br
 W:	http://cvs.conectiva.com.br/drivers/ZFL-watchdog/
 S:	Maintained
 
+DIGITAL-LOGIC PC104 MSM-P5XEN WATCHDOG DRIVER
+P:	Gabriele Galeotti
+M:	ggaleotti@interfree.it
+W:	http://ggaleotti.interfree.it
+S:	Maintained
+
 ZR36067 VIDEO FOR LINUX DRIVER
 P:	Ronald Bultje
 M:	rbultje@ronald.bitfreak.net
--- linux-2.6.18.1/drivers/char/watchdog/Kconfig.orig	2006-10-17 14:44:45.000000000 +0200
+++ linux-2.6.18.1/drivers/char/watchdog/Kconfig	2006-10-17 14:46:59.000000000 +0200
@@ -433,6 +433,20 @@ config SBC_EPX_C3_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sbc_epx_c3.
 
+config DLPC104_WATCHDOG
+	tristate "Digital-Logic MSM-P5XEN PC104 unit Watchdog"
+	depends on WATCHDOG && X86
+	---help---
+	  This is the driver for the built-in watchdog timer on the MSM-P5XEN
+	  PC104 unit made by Digital-Logic. If you fail to refresh the watchdog
+	  at least every 600 msecs (writing a byte to the device), it will
+	  reboot your machine. The watchdog chip is a LTC1232 controlled by a
+	  single I/O port @ 0x1037.
+
+	  *Note*: This hardware watchdog is not probeable nor configurable.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called dlpc104.
 
 # PowerPC Architecture
 
--- linux-2.6.18.1/drivers/char/watchdog/Makefile.orig	2006-10-17 14:44:26.000000000 +0200
+++ linux-2.6.18.1/drivers/char/watchdog/Makefile	2006-10-17 14:47:35.000000000 +0200
@@ -55,6 +55,7 @@ obj-$(CONFIG_W83877F_WDT) += w83877f_wdt
 obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
+obj-$(CONFIG_DLPC104_WATCHDOG) += dlpc104.o
 
 # PowerPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
--- linux-2.6.18.1/drivers/char/watchdog/dlpc104.c.orig	2006-10-17 14:48:39.000000000 +0200
+++ linux-2.6.18.1/drivers/char/watchdog/dlpc104.c	2006-10-17 14:48:27.000000000 +0200
@@ -0,0 +1,228 @@
+
+/*
+ * dlpc104: watchdog driver for Digital-Logic MSM-P5XEN PC104 unit
+ *
+ * Copyright (c) 2006 Gabriele Galeotti <ggaleotti@interfree.it>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Version 0.1 (06/10/2006):
+ * - first version
+ *
+ * Please see ggaleotti.interfree.it for latest version.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include <linux/atmdev.h>
+#include <linux/miscdevice.h>
+
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+
+#define WDT_IOBASE 0x1000
+#define WDT_OFFSET 0x37
+
+static int io_base = WDT_IOBASE;
+module_param(io_base, int, 0);
+MODULE_PARM_DESC(io_base, "I/O base address (default=0x1000)");
+
+static struct timer_list wdt_timer;
+
+static void
+wdt_enable(unsigned long data)
+{
+	(void)data;
+
+	outb(inb(io_base + WDT_OFFSET) & 0xf7, io_base + WDT_OFFSET);
+}
+
+static void
+wdt_disable(void)
+{
+	outb(inb(io_base + WDT_OFFSET) | 0x08, io_base + WDT_OFFSET);
+}
+
+static void
+wdt_ping(void)
+{
+	/*
+	 * Clear-pulse trailing edge scheduling.
+	 *
+	 * We use mod_timer() rather than add_timer() because a timer could
+	 * be already activated.
+	 * kernel/timer.c:
+	 * "... since add_timer() cannot modify an already running timer."
+	 */
+	mod_timer(&wdt_timer, jiffies + (HZ / 10));
+
+	wdt_disable();
+}
+
+static int
+dl_wdt_open(struct inode *inode, struct file *file)
+{
+	wdt_enable(0);
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t
+dl_wdt_write(struct file *file, const char *data, size_t length, loff_t *ppos)
+{
+	(void)file;
+	(void)data;
+	(void)ppos;
+
+	if (length != 0)
+	{
+		wdt_ping();
+	}
+
+	return length;
+}
+
+static int
+dl_wdt_close(struct inode *inode, struct file *file)
+{
+	del_timer(&wdt_timer);
+
+	wdt_disable();
+
+	return 0;
+}
+
+static struct watchdog_info identity = {
+	.options  = 0,
+	.identity = "DLPC104 Watchdog",
+	};
+
+static int
+dl_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int return_status;
+
+	switch (cmd)
+	{
+		case WDIOC_GETSUPPORT:
+			return_status = copy_to_user((struct watchdog_info *)arg, &identity, sizeof(identity)) ? -EFAULT : 0;
+			break;
+		default:
+			return_status = -ENOIOCTLCMD;
+			break;
+	}
+
+	return return_status;
+}
+
+static int
+wdt_notify_sys(struct notifier_block *this, unsigned long code,	void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+	{
+		del_timer(&wdt_timer);
+		wdt_disable();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct file_operations dlmodule_fops = {
+	.owner   = THIS_MODULE,
+	.llseek  = no_llseek,
+	.write   = dl_wdt_write,
+	.ioctl   = dl_wdt_ioctl,
+	.open    = dl_wdt_open,
+	.release = dl_wdt_close
+	};
+
+static struct miscdevice dlmodule_miscdevice = {
+	.minor = WATCHDOG_MINOR,
+	.name  = "watchdog",
+	.fops  = &dlmodule_fops,
+	};
+
+/*
+ * The WDT needs to learn about soft shutdowns in order to turn the timebomb
+ * registers off.
+ */
+static struct notifier_block wdt_notifier = {
+	.notifier_call = wdt_notify_sys,
+	};
+
+static int __init
+dlmodule_init(void)
+{
+	int result;
+
+	if (!request_region(io_base + WDT_OFFSET, 1, "DLPC104 Watchdog"))
+	{
+		printk(KERN_ERR "DLPC104 Watchdog: I/O region busy.\n");
+		result = -EBUSY;
+		goto exit_0;
+	}
+
+	result = register_reboot_notifier(&wdt_notifier);
+	if (result != 0)
+	{
+		printk (KERN_ERR "DLPC104 Watchdog: cannot register reboot notifier.\n");
+		goto exit_1;
+	}
+
+	result = misc_register(&dlmodule_miscdevice);
+	if (result != 0)
+	{
+		printk(KERN_ERR "DLPC104 Watchdog: cannot register.\n");
+		goto exit_2;
+	}
+
+	init_timer(&wdt_timer);
+	wdt_timer.function = wdt_enable;
+	wdt_timer.data = 0;
+
+	printk("Digital-Logic MSM-P5XEN PC104 Watchdog driver loaded.\n");
+
+	return 0;
+
+exit_2:	unregister_reboot_notifier(&wdt_notifier);
+exit_1: release_region(io_base + WDT_OFFSET, 1);
+exit_0: return result;
+}
+
+static void __exit
+dlmodule_exit(void)
+{
+	del_timer(&wdt_timer);
+	wdt_disable();
+
+	release_region(io_base + WDT_OFFSET, 1);
+
+	unregister_reboot_notifier(&wdt_notifier);
+
+	misc_deregister(&dlmodule_miscdevice);
+}
+
+/*
+ * Module parameters & definitions.
+ */
+
+MODULE_AUTHOR("Gabriele Galeotti <ggaleotti@interfree.it>");
+MODULE_DESCRIPTION("Digital-Logic PC104 watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0.1");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
+module_init(dlmodule_init);
+module_exit(dlmodule_exit);
+


------------------------------------------------------------
Sei stanco di girare a vuoto? 
Con il nuovo motore di ricerca Interfree trovi di tutto. 
Vieni a trovarci: http://search.interfree.it/

Lo Staff di Interfree 
------------------------------------------------------------

