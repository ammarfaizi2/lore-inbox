Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUG1WKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUG1WKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUG1WKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:10:43 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64422 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265373AbUG1WIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:08:07 -0400
Date: Wed, 28 Jul 2004 15:08:06 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Watchdog driver for Intel IXP2000 Network Processor
Message-ID: <20040728220806.GA7057@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Following patch adds support for the watchdog driver embedded in Intel's
IXP2000 family of network processors.  The architecture-specific bits
of IXP2000 support will be merged upstream via the ARM tree once all
the various drivers have been merged.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	Wed Jul 28 14:55:53 2004
+++ b/drivers/char/watchdog/Kconfig	Wed Jul 28 14:55:53 2004
@@ -95,6 +95,17 @@
 
 	  Say N if you are unsure.
 
+config IXP2000_WATCHDOG
+	tristate "IXP2000 Watchdog"
+	depends on WATCHDOG && ARCH_IXP2000
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in the Intel IXP2000(2400, 2800, 2850) network processors. 
+	  This driver can be built as a module by choosing M. The module 
+	  will be called ixp2000_wdt.
+
+	  Say N if you are unsure.
+
 config SA1100_WATCHDOG
 	tristate "SA1100/PXA2xx watchdog"
 	depends on WATCHDOG && ( ARCH_SA1100 || ARCH_PXA )
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Wed Jul 28 14:55:53 2004
+++ b/drivers/char/watchdog/Makefile	Wed Jul 28 14:55:53 2004
@@ -36,3 +36,4 @@
 obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
+obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
diff -Nru a/drivers/char/watchdog/ixp2000_wdt.c b/drivers/char/watchdog/ixp2000_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/watchdog/ixp2000_wdt.c	Wed Jul 28 14:55:53 2004
@@ -0,0 +1,223 @@
+/*
+ * drivers/watchdog/ixp2000_wdt.c
+ *
+ * Watchdog driver for Intel IXP2000 network processors
+ *
+ * Adapted from the IXP4xx watchdog driver by Lennert Buytenhek.
+ * The original version carries these notices:
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2004 (c) MontaVista, Software, Inc.
+ * Based on sa1100 driver, Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/init.h>
+
+#include <asm/hardware.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+static unsigned int heartbeat = 60;	/* (secs) Default is 1 minute */
+static unsigned long wdt_status;
+
+#define	WDT_IN_USE		0
+#define	WDT_OK_TO_CLOSE		1
+
+static unsigned long wdt_tick_rate;
+
+static void
+wdt_enable(void)
+{
+	ixp2000_reg_write(IXP2000_RESET0, *(IXP2000_RESET0) | WDT_RESET_ENABLE);
+	ixp2000_reg_write(IXP2000_TWDE, WDT_ENABLE);
+	ixp2000_reg_write(IXP2000_T4_CLD, heartbeat * wdt_tick_rate);
+	ixp2000_reg_write(IXP2000_T4_CTL, TIMER_DIVIDER_256 | TIMER_ENABLE);
+}
+
+static void
+wdt_disable(void)
+{
+	ixp2000_reg_write(IXP2000_T4_CTL, 0);
+}
+
+static void
+wdt_keepalive(void)
+{
+	ixp2000_reg_write(IXP2000_T4_CLD, heartbeat * wdt_tick_rate);
+}
+
+static int
+ixp2000_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
+		return -EBUSY;
+
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	wdt_enable();
+
+	return 0;
+}
+
+static ssize_t
+ixp2000_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	/* Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
+			}
+		}
+		wdt_keepalive();
+	}
+
+	return len;
+}
+
+
+static struct watchdog_info ident = {
+	.options	= WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT |
+				WDIOF_KEEPALIVEPING,
+	.identity	= "IXP2000 Watchdog",
+};
+
+static int
+ixp2000_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+			unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	int time;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user((struct watchdog_info *)arg, &ident,
+				   sizeof(ident)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(time, (int *)arg);
+		if (ret)
+			break;
+
+		if (time <= 0 || time > 60) {
+			ret = -EINVAL;
+			break;
+		}
+
+		heartbeat = time;
+		wdt_keepalive();
+		/* Fall through */
+
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(heartbeat, (int *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wdt_enable();
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+ixp2000_wdt_release(struct inode *inode, struct file *file)
+{
+	if (test_bit(WDT_OK_TO_CLOSE, &wdt_status)) {
+		wdt_disable();
+	} else {
+		printk(KERN_CRIT "WATCHDOG: Device closed unexpectdly - "
+					"timer will not stop\n");
+	}
+
+	clear_bit(WDT_IN_USE, &wdt_status);
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	return 0;
+}
+
+
+static struct file_operations ixp2000_wdt_fops =
+{
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= ixp2000_wdt_write,
+	.ioctl		= ixp2000_wdt_ioctl,
+	.open		= ixp2000_wdt_open,
+	.release	= ixp2000_wdt_release,
+};
+
+static struct miscdevice ixp2000_wdt_miscdev =
+{
+	.minor		= WATCHDOG_MINOR,
+	.name		= "IXP2000 Watchdog",
+	.fops		= &ixp2000_wdt_fops,
+};
+
+static int __init ixp2000_wdt_init(void)
+{
+	wdt_tick_rate = (*IXP2000_T1_CLD * HZ)/ 256;;
+
+	return misc_register(&ixp2000_wdt_miscdev);
+}
+
+static void __exit ixp2000_wdt_exit(void)
+{
+	misc_deregister(&ixp2000_wdt_miscdev);
+}
+
+module_init(ixp2000_wdt_init);
+module_exit(ixp2000_wdt_exit);
+
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net">);
+MODULE_DESCRIPTION("IXP2000 Network Processor Watchdog");
+
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds (default 60s)");
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
