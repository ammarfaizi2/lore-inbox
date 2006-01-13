Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423038AbWAMW1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423038AbWAMW1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423034AbWAMW1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:27:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:29578 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423035AbWAMW1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:27:47 -0500
Date: Fri, 13 Jan 2006 16:18:58 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: wim@iguana.be, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linuxppc-dev@ozlabs.org>,
       <iinuxppc-embedded@gate.crashing.org>, <dave@cray.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-ID: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for the PowerPC MPC83xx watchdog.  The MPC83xx has a simple
watchdog that once enabled it can not be stopped, has some simple timeout
range selection, and the ability to either reset the processor or take
a machine check.

Signed-off-by: Dave Updegraff <dave@cray.org>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 829b5a27d84d8ea95f6ba7314702c11127b5102c
tree 1eb3a840aea5ff2de729e510458d24688e4da59e
parent ae97a598202f4076627acaba0fcc1884f0c703d7
author Kumar Gala <galak@kernel.crashing.org> Fri, 13 Jan 2006 16:22:58 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 13 Jan 2006 16:22:58 -0600

 drivers/char/watchdog/Kconfig       |    4 +
 drivers/char/watchdog/Makefile      |    1 
 drivers/char/watchdog/mpc83xx_wdt.c |  230 +++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+), 0 deletions(-)

diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index a654479..32c035b 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -401,6 +401,10 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config 83xx_WDT
+	tristate "MPC83xx Watchdog Timer"
+	depends on WATCHDOG && PPC_83xx
+
 config MV64X60_WDT
 	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
 	depends on WATCHDOG && MV64X60
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index cfd0a39..4342b0d 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 
 # PowerPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_83xx_WDT) += mpc83xx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
 
diff --git a/drivers/char/watchdog/mpc83xx_wdt.c b/drivers/char/watchdog/mpc83xx_wdt.c
new file mode 100644
index 0000000..5734839
--- /dev/null
+++ b/drivers/char/watchdog/mpc83xx_wdt.c
@@ -0,0 +1,230 @@
+/*
+ * mpc83xx_wdt.c - MPC83xx watchdog userspace interface
+ *
+ * Authors: Dave Updegraff <dave@cray.org>
+ * 	    Kumar Gala <galak@kernel.crashing.org>
+ * 		Attribution: from 83xx_wst: Florian Schirmer <jolt@tuxbox.org>
+ * 				..and from sc520_wdt
+ *
+ * Note: it appears that you can only actually ENABLE or DISABLE the thing
+ * once after POR. Once enabled, you cannot disable, and vice versa.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+struct mpc83xx_wdt {
+	__be32 res0;
+	__be32 swcrr; /* System watchdog control register */
+#define SWCRR_SWTC 0xFFFF0000 /* Software Watchdog Time Count. */
+#define SWCRR_SWEN 0x00000004 /* Watchdog Enable bit. */
+#define SWCRR_SWRI 0x00000002 /* Software Watchdog Reset/Interrupt Select bit.*/
+#define SWCRR_SWPR 0x00000001 /* Software Watchdog Counter Prescale bit. */
+	__be32 swcnr; /* System watchdog count register */
+	u8 res1[2];
+	__be16 swsrr; /* System watchdog service register */
+	u8 res2[0xF0];
+};
+
+static struct mpc83xx_wdt __iomem *wd_base;
+
+static ushort timeout = 0xffff;
+module_param(timeout, ushort, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in ticks. (0<timeout<65536, default=65535");
+
+static int reset = 1;
+module_param(reset, bool, 0);
+MODULE_PARM_DESC(reset, "Watchdog Interrupt/Reset Mode. 0 = interrupt, 1 = reset");
+
+/* We always prescale, but if someone really doesn't want to they can set this to 0 */
+static int prescale = 1;
+static unsigned int timeout_sec;
+
+static unsigned long wdt_is_open;
+static spinlock_t wdt_spinlock;
+
+static void mpc83xx_wdt_keepalive(void)
+{
+	/* Ping the WDT */
+	spin_lock(&wdt_spinlock);
+	out_be16(&wd_base->swsrr, 0x556c);
+	out_be16(&wd_base->swsrr, 0xaa39);
+	spin_unlock(&wdt_spinlock);
+}
+
+static ssize_t mpc83xx_wdt_write(struct file * file, const char __user * buf,
+				 size_t count, loff_t * ppos)
+{
+	if(count)
+		mpc83xx_wdt_keepalive();
+	return count;
+}
+
+static int mpc83xx_wdt_open(struct inode * inode, struct file * file)
+{
+	u32 tmp = SWCRR_SWEN;
+	if (test_and_set_bit(0, &wdt_is_open))
+		return -EBUSY;
+
+	/* Once we start the watchdog we can't stop it */
+	__module_get(THIS_MODULE);
+
+	/* Good, fire up the show */
+	if (prescale)
+		tmp |= SWCRR_SWPR;
+	if (reset)
+		tmp |= SWCRR_SWRI;
+
+	tmp |= timeout << 16;
+
+	out_be32(&wd_base->swcrr, tmp);
+
+	return nonseekable_open(inode, file);
+}
+
+static int mpc83xx_wdt_release(struct inode * inode, struct file * file)
+{
+	printk(KERN_CRIT "Unexpected close, not stopping watchdog!\n");
+	mpc83xx_wdt_keepalive();
+	clear_bit(0, &wdt_is_open);
+	return 0;
+}
+
+static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd,
+	unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	static struct watchdog_info ident = {
+		.options = WDIOF_KEEPALIVEPING,
+		.firmware_version = 1,
+		.identity = "MPC83xx",
+	};
+
+	switch(cmd)
+	{
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
+		case WDIOC_KEEPALIVE:
+			mpc83xx_wdt_keepalive();
+			return 0;
+		case WDIOC_GETTIMEOUT:
+			return put_user(timeout_sec, p);
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+}
+
+static struct file_operations mpc83xx_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= mpc83xx_wdt_write,
+	.ioctl		= mpc83xx_wdt_ioctl,
+	.open		= mpc83xx_wdt_open,
+	.release	= mpc83xx_wdt_release,
+};
+
+static struct miscdevice mpc83xx_wdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &mpc83xx_wdt_fops,
+};
+
+static int __devinit mpc83xx_wdt_probe(struct platform_device *dev)
+{
+	struct resource *r;
+	int ret;
+	unsigned int *freq = dev->dev.platform_data;
+
+	/* get a pointer to the register memory */
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+
+	if (!r) {
+		ret = -ENODEV;
+		goto err_out;
+	}
+
+	wd_base = (struct mpc83xx_wdt *)
+		ioremap(r->start, sizeof (struct mpc83xx_wdt));
+
+	if (wd_base == NULL) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	ret = misc_register(&mpc83xx_wdt_miscdev);
+	if (ret) {
+		printk(KERN_ERR "cannot register miscdev on minor=%d (err=%d)\n",
+			   WATCHDOG_MINOR, ret);
+		goto err_unmap;
+	}
+
+	/* Calculate the timeout in seconds */
+	if (prescale)
+		timeout_sec = (timeout * 0x10000) / (*freq);
+	else
+		timeout_sec = timeout / (*freq);
+
+	printk(KERN_INFO "WDT driver for MPC83xx initialized. "
+		"mode:%s timeout=%d (%d seconds)\n",
+		reset ? "reset":"interrupt", timeout, timeout_sec);
+
+	spin_lock_init(&wdt_spinlock);
+
+	return 0;
+
+err_unmap:
+	iounmap(wd_base);
+err_out:
+	return ret;
+}
+
+static int __devexit mpc83xx_wdt_remove(struct platform_device *dev)
+{
+	misc_deregister(&mpc83xx_wdt_miscdev);
+	iounmap(wd_base);
+
+	return 0;
+}
+
+static struct platform_driver mpc83xx_wdt_driver = {
+	.probe		= mpc83xx_wdt_probe,
+	.remove		= __devexit_p(mpc83xx_wdt_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "mpc83xx_wdt",
+	},
+};
+
+static int __init mpc83xx_wdt_init(void)
+{
+	return platform_driver_register(&mpc83xx_wdt_driver);
+}
+
+static void __exit mpc83xx_wdt_exit(void)
+{
+	platform_driver_unregister(&mpc83xx_wdt_driver);
+}
+
+module_init(mpc83xx_wdt_init);
+module_exit(mpc83xx_wdt_exit);
+
+MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
+MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx uProcessor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

