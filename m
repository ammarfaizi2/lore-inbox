Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310189AbSCKQVt>; Mon, 11 Mar 2002 11:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310187AbSCKQVm>; Mon, 11 Mar 2002 11:21:42 -0500
Received: from [212.18.235.99] ([212.18.235.99]:25352 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S310189AbSCKQVZ>;
	Mon, 11 Mar 2002 11:21:25 -0500
From: Justin Cormack <justin@street-vision.com>
Message-Id: <200203111621.g2BGLFT03840@street-vision.com>
Subject: Re: Linux 2.4.19-pre2-ac4
To: alan@lxorguk.ukuu.org.uk
Date: Mon, 11 Mar 2002 16:21:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Big flush of all the small changes in the pending queue. Various submissions
> that didn't apply were simply discarded

ok, here is a resubmit against pre2-ac4 for wafer5823wdt



diff -urN linux-2.4.19-pre2-ac4-orig/Documentation/Configure.help linux-2.4.19-pre2-ac4/Documentation/Configure.help
--- linux-2.4.19-pre2-ac4-orig/Documentation/Configure.help	Sun Mar 10 16:30:02 2002
+++ linux-2.4.19-pre2-ac4/Documentation/Configure.help	Sun Mar 10 16:44:36 2002
@@ -17897,6 +17897,17 @@
   inserted in and removed from the running kernel whenever you want).
   The module is called shwdt.o. If you want to compile it as a module,
   say M here and read Documentation/modules.txt.
+
+Wafer 5823 Watchdog
+CONFIG_WAFER_WDT
+  This is a driver for the hardware watchdog on the ICP Wafer 5823
+  Single Board Computer (and probably other similar models).
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>. The module will be called
+  wafer5823wdt.o
 	      
 Machine Check Exception
 CONFIG_X86_MCE
diff -urN linux-2.4.19-pre2-ac4-orig/drivers/char/Config.in linux-2.4.19-pre2-ac4/drivers/char/Config.in
--- linux-2.4.19-pre2-ac4-orig/drivers/char/Config.in	Sun Mar 10 16:30:03 2002
+++ linux-2.4.19-pre2-ac4/drivers/char/Config.in	Sun Mar 10 16:38:41 2002
@@ -204,6 +204,7 @@
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  AMD "Elan" SC520 Watchdog Timer' CONFIG_SC520_WDT
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
+   tristate '  ICP ELectronics Wafer 5823 Watchdog' CONFIG_WAFER_WDT
    if [ "$CONFIG_SGI_IP22" = "y" ]; then
       dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
    fi
diff -urN linux-2.4.19-pre2-ac4-orig/drivers/char/Makefile linux-2.4.19-pre2-ac4/drivers/char/Makefile
--- linux-2.4.19-pre2-ac4-orig/drivers/char/Makefile	Sun Mar 10 16:30:03 2002
+++ linux-2.4.19-pre2-ac4/drivers/char/Makefile	Sun Mar 10 18:58:28 2002
@@ -252,6 +252,7 @@
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
+obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 
 subdir-$(CONFIG_MWAVE) += mwave
diff -urN linux-2.4.19-pre2-ac4-orig/drivers/char/wafer5823wdt.c linux-2.4.19-pre2-ac4/drivers/char/wafer5823wdt.c
--- linux-2.4.19-pre2-ac4-orig/drivers/char/wafer5823wdt.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19-pre2-ac4/drivers/char/wafer5823wdt.c	Sun Mar 10 16:46:46 2002
@@ -0,0 +1,250 @@
+/*
+ *	ICP Wafer 5823 Single Board Computer WDT driver for Linux 2.4.x
+ *      http://www.icpamerica.com/wafer_5823.php
+ *      May also work on other similar models
+ *
+ *	(c) Copyright 2002 Justin Cormack <justin@street-vision.com>
+ *
+ *      Release 0.01
+ *
+ *	Based on advantechwdt.c which is based on wdt.c.
+ *	Original copyright messages:
+ *
+ *	(c) Copyright 1996-1997 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *	
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
+ *	warranty for any of this software. This material is provided 
+ *	"AS-IS" and at no charge.	
+ *
+ *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+
+static int wafwdt_is_open;
+static spinlock_t wafwdt_lock;
+
+/*
+ *	You must set these - there is no sane way to probe for this board.
+ *
+ *      To enable, write the timeout value in seconds (1 to 255) to I/O
+ *      port WDT_START, then read the port to start the watchdog. To pat
+ *      the dog, read port WDT_STOP to stop the timer, then read WDT_START
+ *      to restart it again.
+ */
+
+#define WDT_START 0x443
+#define WDT_STOP 0x843
+
+#define WD_TIMO 60		/* 1 minute */
+
+/*
+ *	Kernel methods.
+ */
+
+static void
+wafwdt_ping(void)
+{
+	/* pat watchdog */
+        spin_lock(&wafwdt_lock);
+	inb_p(WDT_STOP);
+	inb_p(WDT_START);
+        spin_unlock(&wafwdt_lock);
+}
+
+static void
+wafwdt_start(void)
+{
+	/* start up watchdog */
+	outb_p(WD_TIMO, WDT_START);
+	inb_p(WDT_START);
+}
+
+static void
+wafwdt_stop(void)
+{
+	/* stop watchdog */
+	inb_p(WDT_STOP);
+}
+
+static ssize_t
+wafwdt_write(struct file *file, const char *buf, size_t count, loff_t * ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (count) {
+		wafwdt_ping();
+		return 1;
+	}
+	return 0;
+}
+
+static ssize_t
+wafwdt_read(struct file *file, char *buf, size_t count, loff_t * ppos)
+{
+	return -EINVAL;
+}
+
+static int
+wafwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	     unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		WDIOF_KEEPALIVEPING, 1, "Wafer 5823 WDT"
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user
+		    ((struct watchdog_info *) arg, &ident, sizeof (ident)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+		if (copy_to_user((int *) arg, &wafwdt_is_open, sizeof (int)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wafwdt_ping();
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+static int
+wafwdt_open(struct inode *inode, struct file *file)
+{
+	switch (MINOR(inode->i_rdev)) {
+	case WATCHDOG_MINOR:
+		if (test_and_set_bit(0, &wafwdt_is_open))
+			return -EBUSY;
+		wafwdt_start();
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int
+wafwdt_close(struct inode *inode, struct file *file)
+{
+        if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	        if (test_and_clear_bit(0, &wafwdt_is_open))
+		        wafwdt_stop();
+#else
+		wafwdt_is_open = 0;
+#endif
+        }
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int
+wafwdt_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Turn the WDT off */
+		wafwdt_stop();
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations wafwdt_fops = {
+	owner:THIS_MODULE,
+	read:wafwdt_read,
+	write:wafwdt_write,
+	ioctl:wafwdt_ioctl,
+	open:wafwdt_open,
+	release:wafwdt_close,
+};
+
+static struct miscdevice wafwdt_miscdev = {
+	WATCHDOG_MINOR,
+	"watchdog",
+	&wafwdt_fops
+};
+
+/*
+ *	The WDT needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off. 
+ */
+
+static struct notifier_block wafwdt_notifier = {
+	wafwdt_notify_sys,
+	NULL,
+	0
+};
+
+static int __init
+wafwdt_init(void)
+{
+	printk
+	    (KERN_INFO "WDT driver for Wafer 5823 single board computer initialising.\n");
+
+	spin_lock_init(&wafwdt_lock);
+	misc_register(&wafwdt_miscdev);
+#if WDT_START != WDT_STOP
+	request_region(WDT_STOP, 1, "Wafer 5823 WDT");
+#endif
+	request_region(WDT_START, 1, "Wafer 5823 WDT");
+	register_reboot_notifier(&wafwdt_notifier);
+	return 0;
+}
+
+static void __exit
+wafwdt_exit(void)
+{
+	misc_deregister(&wafwdt_miscdev);
+	unregister_reboot_notifier(&wafwdt_notifier);
+#if WDT_START != WDT_STOP
+	release_region(WDT_STOP, 1);
+#endif
+	release_region(WDT_START, 1);
+}
+
+module_init(wafwdt_init);
+module_exit(wafwdt_exit);
+
+MODULE_LICENSE("GPL");
+
+/* end of wafer5823wdt.c */
