Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264691AbUELBng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbUELBng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUELBnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:43:35 -0400
Received: from fed1rmmtai11.cox.net ([68.230.241.48]:16810 "EHLO
	fed1rmmtai11.cox.net") by vger.kernel.org with ESMTP
	id S264691AbUELBld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:41:33 -0400
Date: Tue, 11 May 2004 16:02:44 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, wim@iguana.be, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Watchdog timer for Intel IXP4xx CPUs
Message-ID: <20040511230244.GA8718@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040511212235.GA7729@plexity.net> <20040511143352.096bc071.akpm@osdl.org> <20040511215008.GA8063@plexity.net> <40A155AC.5090009@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <40A155AC.5090009@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On May 11 2004, at 18:37, Jeff Garzik was caught saying:
> Deepak Saxena wrote:
> >On May 11 2004, at 14:33, Andrew Morton was caught saying:
> >+#ifdef CONFIG_WATCHDOG_NOWAYOUT
> >+static int nowayout = 1;
> >+#else
> >+static int nowayout = 0;
> >+#endif
> >+static int heartbeat = 60;	/* (secs) Default is 1 minute */
> >+static unsigned long wdt_status = 0;	
> >+static unsigned long boot_status = 0;
> 
> Wastes bss(?) space to explicitly zero statics.

My mother always told me to initialize my variables but this
is easily fixed. 

> >+static void 
> >+wdt_disable(void)
> >+{
> >+	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
> >+	*IXP4XX_OSWE = 0;
> >+	*IXP4XX_OSWK = 0;
> >+}
> 
> Are these magic CPU addresses you're writing to?  Normally one uses bus 
> macros to read/write to devices.  But SoC and embedded stuff is often 
> special...

Yep, these are mapped in in platform setup code in arch/arm/mach-ixp4xx.

> >+ixp4xx_wdt_open(struct inode *inode, struct file *file)
> >+{
> >+	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
> >+		return -EBUSY;
> >+
> >+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
> >+
> >+	wdt_enable();
> >+
> >+	return 0;
> >+}
> 
> You typically want semaphores rather than bit tests.
> 
> And what about blocking on multiple openers?

I'm just copying other wdt driver in the tree do, so I'm assuming
it's "standard practice" to just -EBUSY on multiple users. 
Documentation/watchdog/watchdog-api.txt doesn't really specify the
behavior, so this may just be from historical reasons. In practice
you will only have one application managing the watchdog.

> >+static ssize_t 
> >+ixp4xx_wdt_write(struct file *file, const char *data, size_t len, loff_t 
> >*ppos)
> >+{
> >+	/* Can't seek (pwrite) on this device  */
> >+	if (ppos != &file->f_pos)
> >+		return -ESPIPE;
> >+
> >+	if (len) {
> >+		if (!nowayout) {
> >+			size_t i;
> >+
> >+			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
> >+
> >+			for (i = 0; i != len; i++) {
> >+				char c;
> >+
> >+				if (get_user(c, data + i))
> >+					return -EFAULT;
> >+				if (c == 'V')
> >+					set_bit(WDT_OK_TO_CLOSE, 
> >&wdt_status);
> >+			}
> >+		}
> >+		wdt_enable();
> >+	}
> 
> do other watchdog drivers really twiddle a bit like this on each write?


They use a separate variable but it amounts to the same behavior.
Clear it then reset it after we read the user command.  (see i8xx_tco.c)
I decided to twiddle a bit instead of using another static. 

Updated patch attached with variable init removed.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ixp4xx-wdt

diff -uNr -X dontdiff linux-2.5-bk/drivers/char/watchdog/Kconfig linux-2.6-ds/drivers/char/watchdog/Kconfig
--- linux-2.5-bk/drivers/char/watchdog/Kconfig	2004-04-21 11:48:09.000000000 -0700
+++ linux-2.6-ds/drivers/char/watchdog/Kconfig	2004-05-10 15:11:24.000000000 -0700
@@ -84,6 +84,17 @@
 
 	  Not sure? It's safe to say N.
 
+config IXP4XX_WATCHDOG
+	tristate "IXP4xx Watchdog"
+	depends on WATCHDOG && ARCH_IXP4XX
+	help
+	  Say Y here if to include support for the watchdog timer 
+	  in the Intel IXP4xx network processors. This driver can
+	  be built as a module by choosing M. The module will
+	  be called ixp4xx_wdt.
+
+	  Say N if you are unsure.
+
 config SA1100_WATCHDOG
 	tristate "SA1100 watchdog"
 	depends on WATCHDOG && ARCH_SA1100
diff -uNr -X dontdiff linux-2.5-bk/drivers/char/watchdog/Makefile linux-2.6-ds/drivers/char/watchdog/Makefile
--- linux-2.5-bk/drivers/char/watchdog/Makefile	2004-04-21 11:48:09.000000000 -0700
+++ linux-2.6-ds/drivers/char/watchdog/Makefile	2004-05-10 15:11:24.000000000 -0700
@@ -35,3 +35,4 @@
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
+obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
diff -uNr -X dontdiff linux-2.5-bk/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6-ds/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.5-bk/drivers/char/watchdog/ixp4xx_wdt.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6-ds/drivers/char/watchdog/ixp4xx_wdt.c	2004-05-11 16:02:59.000000000 -0700
@@ -0,0 +1,233 @@
+/*
+ * drivers/watchdog/ixp4xx_wdt.c
+ *
+ * Watchdog driver for Intel IXP4xx network processors
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
+static int heartbeat = 60;	/* (secs) Default is 1 minute */
+static unsigned long wdt_status;	
+static unsigned long boot_status;
+
+#define WDT_TICK_RATE (IXP4XX_PERIPHERAL_BUS_CLOCK * 1000000UL)
+
+#define	WDT_IN_USE		0
+#define	WDT_OK_TO_CLOSE		1
+
+static void
+wdt_enable(void)
+{
+	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
+	*IXP4XX_OSWE = 0;
+	*IXP4XX_OSWT = WDT_TICK_RATE * heartbeat;
+	*IXP4XX_OSWE = IXP4XX_WDT_COUNT_ENABLE | IXP4XX_WDT_RESET_ENABLE;
+	*IXP4XX_OSWK = 0;
+}
+
+static void 
+wdt_disable(void)
+{
+	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
+	*IXP4XX_OSWE = 0;
+	*IXP4XX_OSWK = 0;
+}
+
+static int
+ixp4xx_wdt_open(struct inode *inode, struct file *file)
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
+ixp4xx_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
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
+		wdt_enable();
+	}
+
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options	= WDIOF_CARDRESET | WDIOF_MAGICCLOSE |
+			  WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity	= "IXP4xx Watchdog",
+};
+
+
+static int 
+ixp4xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, 
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
+		ret = put_user(boot_status, (int *)arg);
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
+		wdt_enable();
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
+	return ret;
+}
+
+static int
+ixp4xx_wdt_release(struct inode *inode, struct file *file)
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
+static struct file_operations ixp4xx_wdt_fops =
+{
+	.owner		= THIS_MODULE,
+	.write		= ixp4xx_wdt_write,
+	.ioctl		= ixp4xx_wdt_ioctl,
+	.open		= ixp4xx_wdt_open,
+	.release	= ixp4xx_wdt_release,
+};
+
+static struct miscdevice ixp4xx_wdt_miscdev =
+{
+	.minor		= WATCHDOG_MINOR,
+	.name		= "IXP4xx Watchdog",
+	.fops		= &ixp4xx_wdt_fops,
+};
+
+static int __init ixp4xx_wdt_init(void)
+{
+	int ret;
+	unsigned long processor_id;
+
+	asm("mrc p15, 0, %0, cr0, cr0, 0;" : "=r"(processor_id) :);
+	if (!(processor_id & 0xf)) {
+		printk("IXP4XXX Watchdog: Rev. A0 CPU detected - "
+			"watchdog disabled\n");
+
+		return -ENODEV;
+	}
+
+	ret = misc_register(&ixp4xx_wdt_miscdev);
+	if (ret == 0)
+		printk("IXP4xx Watchdog Timer: heartbeat %d sec\n", heartbeat);
+
+	boot_status = (*IXP4XX_OSST & IXP4XX_OSST_TIMER_WARM_RESET) ? 
+			WDIOF_CARDRESET : 0;
+
+	return ret;
+}
+
+static void __exit ixp4xx_wdt_exit(void)
+{
+	misc_deregister(&ixp4xx_wdt_miscdev);
+}
+
+
+module_init(ixp4xx_wdt_init);
+module_exit(ixp4xx_wdt_exit);
+
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net">);
+MODULE_DESCRIPTION("IXP4xx Network Processor Watchdog");
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

--cWoXeonUoKmBZSoM--
