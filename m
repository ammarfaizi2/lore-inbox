Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTIDRFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTIDRFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:05:13 -0400
Received: from tench.street-vision.com ([212.18.235.100]:50574 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S265237AbTIDREk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:04:40 -0400
Subject: [PATCH] new netcom watchdog driver for 2.4
From: Justin Cormack <justin@street-vision.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 04 Sep 2003 18:04:44 +0100
Message-Id: <1062695086.19081.29.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here is a patch adding a watchdog driver for the Netcom SBCs 
http://www.netcomipc.com.tw/

I also moved softdog to the end of the section in Config.in like it says
it should be.

It is against 2.4.22, but should apply or I will rediff it.

Justin Cormack





diff -urN linux-2.4.22-orig/drivers/char/Config.in
linux-2.4.22/drivers/char/Config.in
--- linux-2.4.22-orig/drivers/char/Config.in	2003-08-25
12:44:41.000000000 +0100
+++ linux-2.4.22/drivers/char/Config.in	2003-09-04 17:53:32.000000000
+0100
@@ -248,6 +248,7 @@
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
    dep_tristate '  AMD 766/768 TCO Timer/Watchdog' CONFIG_AMD7XX_TCO
$CONFIG_EXPERIMENTAL
+   tristate '  Netcom SBC watchdog' CONFIG_NETCOM_WDT
 fi
 endmenu
 
diff -urN linux-2.4.22-orig/drivers/char/Makefile
linux-2.4.22/drivers/char/Makefile
--- linux-2.4.22-orig/drivers/char/Makefile	2003-08-25
12:44:41.000000000 +0100
+++ linux-2.4.22/drivers/char/Makefile	2003-09-04 17:53:26.000000000
+0100
@@ -300,8 +300,9 @@
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
-obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_AMD7XX_TCO) += amd7xx_tco.o
+obj-$(CONFIG_NETCOM_WDT) += netcomwdt.o
+obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -urN linux-2.4.22-orig/drivers/char/netcomwdt.c
linux-2.4.22/drivers/char/netcomwdt.c
--- linux-2.4.22-orig/drivers/char/netcomwdt.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.4.22/drivers/char/netcomwdt.c	2003-09-04 17:53:21.000000000
+0100
@@ -0,0 +1,246 @@
+/*
+ *	Netcom Single Board Computer WDT driver for Linux 2.4.x
+ *      Tested on Netcom NC-679, NC-671, should work on other models
+ *      (all models I have checked documentation for have same driver)
+ *      http://www.netcomipc.com.tw/
+ *
+ *	(c) Copyright 2003 Justin Cormack <justin@street-vision.com>
+ *
+ *      To start watchdog write timeout in seconds to 0x443
+ *      To stop watchdog write any value to 0xk043 where k is 1..d
+ *      (we use 0x1043 which seems to be fine)
+ *
+ *      The documentation claims that the timeout values are 4s-1024s
in
+ *      4s intervals. It even gives a nice table of these values.
However
+ *      this is clearly not the case on the boards I have tested.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+
+static unsigned long ncwdt_is_open;
+static spinlock_t ncwdt_lock;
+static int expect_close = 0;
+
+/*
+ *	You must set these - there is no sane way to probe for this board.
+ */
+
+#define WDT_START 0x443
+#define WDT_STOP 0x1043
+
+#define WD_TIMO 60		/* 1 minute */
+static int wd_margin = WD_TIMO;
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
(default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+static inline void ncwdt_start(void)
+{
+	/* start up watchdog */
+	outb_p(wd_margin, WDT_START);
+}
+
+static inline void ncwdt_stop(void)
+{
+	/* stop watchdog */
+	outb_p(0, WDT_STOP);
+}
+
+
+static void ncwdt_ping(void)
+{
+	/* pat watchdog */
+        spin_lock(&ncwdt_lock);
+	ncwdt_stop();
+	ncwdt_start();
+        spin_unlock(&ncwdt_lock);
+}
+
+static ssize_t ncwdt_write(struct file *file, const char *buf, size_t
count, loff_t * ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
+		ncwdt_ping();
+		return 1;
+	}
+	return 0;
+}
+
+static int ncwdt_ioctl(struct inode *inode, struct file *file, unsigned
int cmd,
+	     unsigned long arg)
+{
+	int new_margin;
+	static struct watchdog_info ident = {
+		WDIOF_KEEPALIVEPING |
+		WDIOF_SETTIMEOUT |
+		WDIOF_MAGICCLOSE,
+		1, "Netcom WDT"
+	};
+	int one=1;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user
+		    ((struct watchdog_info *) arg, &ident, sizeof (ident)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+		if (copy_to_user((int *) arg, &one, sizeof (int)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ncwdt_ping();
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if ((new_margin < 1) || (new_margin > 255))
+			return -EINVAL;
+		wd_margin = new_margin;
+		ncwdt_ping();
+		/* Fall */
+	case WDIOC_GETTIMEOUT:
+		return put_user(wd_margin, (int *)arg);
+
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+static int ncwdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &ncwdt_is_open))
+		return -EBUSY;
+	ncwdt_start();
+	return 0;
+}
+
+static int
+ncwdt_close(struct inode *inode, struct file *file)
+{
+	clear_bit(0, &ncwdt_is_open);
+	if (expect_close) {
+        	ncwdt_stop();
+	} else {
+		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not
stop!\n");
+	}
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int ncwdt_notify_sys(struct notifier_block *this, unsigned long
code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Turn the WDT off */
+		ncwdt_stop();
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations ncwdt_fops = {
+	owner:THIS_MODULE,
+	write:ncwdt_write,
+	ioctl:ncwdt_ioctl,
+	open:ncwdt_open,
+	release:ncwdt_close,
+};
+
+static struct miscdevice ncwdt_miscdev = {
+	WATCHDOG_MINOR,
+	"watchdog",
+	&ncwdt_fops
+};
+
+/*
+ *	The WDT needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off. 
+ */
+
+static struct notifier_block ncwdt_notifier = {
+	ncwdt_notify_sys,
+	NULL,
+	0
+};
+
+static int __init ncwdt_init(void)
+{
+	printk(KERN_INFO "WDT driver for Netcom single board computers
initialising.\n");
+
+	spin_lock_init(&ncwdt_lock);
+	if(!request_region(WDT_STOP, 1, "Netcom WDT"))
+		goto error;
+	if(!request_region(WDT_START, 1, "Netcom WDT"))
+		goto error2;
+	if(misc_register(&ncwdt_miscdev)<0)
+		goto error3;
+	register_reboot_notifier(&ncwdt_notifier);
+	return 0;
+error3:
+	release_region(WDT_START, 1);
+error2:
+	release_region(WDT_STOP, 1);
+error:
+	return -ENODEV;
+}
+
+static void __exit ncwdt_exit(void)
+{
+	misc_deregister(&ncwdt_miscdev);
+	unregister_reboot_notifier(&ncwdt_notifier);
+	release_region(WDT_STOP, 1);
+	release_region(WDT_START, 1);
+}
+
+module_init(ncwdt_init);
+module_exit(ncwdt_exit);
+
+MODULE_AUTHOR("Justin Cormack");
+MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
+
+/* end of netcomwdt.c */


