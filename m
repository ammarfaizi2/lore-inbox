Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVJ2TX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVJ2TX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVJ2TX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:23:59 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48062 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932121AbVJ2TX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:23:59 -0400
Message-Id: <20051029192433.428798000@omelas>
References: <20051029191229.562454000@omelas>
Date: Sat, 29 Oct 2005 12:12:31 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, tony@atomide.com
Subject: [patch 2/5] Core HW RNG support
Content-Disposition: inline; filename=rng/add_new_rng_core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the HW RNG core. The core code
simply implements the user space interface and calls HW-specific
function pointers to do the real data gathering. We do this
instead of having each driver re-implement the user space functionality
so we do not end up with a bunch of drivers replicating the exact 
same 50 lines of code (see drivers/watchdog). 

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


Index: linux-2.6-rng/drivers/char/Makefile
===================================================================
--- linux-2.6-rng.orig/drivers/char/Makefile
+++ linux-2.6-rng/drivers/char/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_AGP) += agp/
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
 obj-$(CONFIG_IPMI_HANDLER) += ipmi/
+obj-$(CONFIG_RNG) += rng/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM) += tpm/
Index: linux-2.6-rng/drivers/char/rng/Makefile
===================================================================
--- /dev/null
+++ linux-2.6-rng/drivers/char/rng/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for HW Random Number Generator (RNG) device drivers.
+#
+
+obj-$(CONFIG_IXP4XX_RNG) += ixp4xx-rng.o core.o
+obj-$(CONFIG_X86_RNG) += x86-rng.o core.o
+obj-$(CONFIG_OMAP_RNG) += omap-rng.o core.o
+
Index: linux-2.6-rng/drivers/char/rng/core.c
===================================================================
--- /dev/null
+++ linux-2.6-rng/drivers/char/rng/core.c
@@ -0,0 +1,141 @@
+/*
+ * drivers/rng/core.c
+ *
+ * Core HW Random Number Generator (RNG) driver
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * with parts from:
+ *
+ * Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
+ * (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
+ *
+ * derived from
+ *
+ * Hardware driver for the AMD 768 Random Number Generator (RNG)
+ * (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+ *
+ * derived from
+ *
+ * Hardware driver for Intel i810 Random Number Generator (RNG)
+ * Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+ * Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/random.h>
+#include <linux/miscdevice.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+
+#include <asm/uaccess.h>
+
+#include "rng.h"
+
+#define RNG_MISCDEV_MINOR		183 /* official */
+
+/*
+ * The one and only RNG device.
+ */
+static struct rng_operations *one_rng_to_rule_them_all;
+
+/***********************************************************************
+ *
+ * /dev/hwrandom character device handling (major 10, minor 183)
+ *
+ */
+static int rng_dev_open (struct inode *inode, struct file *filp)
+{
+	/* enforce read-only access to this chrdev */
+	if ((filp->f_mode & FMODE_READ) == 0)
+		return -EINVAL;
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
+				loff_t * offp)
+{
+	static DEFINE_SPINLOCK(rng_lock);
+	unsigned int have_data;
+	u32 data = 0;
+	ssize_t ret = 0;
+
+	while (size) {
+		spin_lock(&rng_lock);
+
+		have_data = 0;
+		if (one_rng_to_rule_them_all->data_present())
+			have_data = one_rng_to_rule_them_all->data_read(&data);
+
+		spin_unlock (&rng_lock);
+
+		while (have_data && size) {
+			if (put_user((u8)data, buf++)) {
+				ret = ret ? : -EFAULT;
+				break;
+			}
+			size--;
+			ret++;
+			have_data--;
+			data>>=8;
+		}
+
+		if (filp->f_flags & O_NONBLOCK)
+			return ret ? : -EAGAIN;
+
+		if(need_resched())
+			schedule_timeout_interruptible(1);
+		else
+			udelay(200);	/* FIXME: We could poll for 250uS ?? */
+
+		if (signal_pending (current))
+			return ret ? : -ERESTARTSYS;
+	}
+	return ret;
+}
+
+static struct file_operations rng_chrdev_ops = {
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
+	.read		= rng_dev_read,
+};
+
+static struct miscdevice rng_miscdev = {
+	RNG_MISCDEV_MINOR,
+	"hw_random",
+	&rng_chrdev_ops,
+};
+
+int __init register_rng(struct rng_operations *rng_ops)
+{
+	int retval;
+
+	one_rng_to_rule_them_all = rng_ops;
+
+	retval = misc_register(&rng_miscdev);
+	if (retval)
+		printk(KERN_ERR "misc device register failed\n");
+
+	return retval;
+}
+
+void __exit rng_unregister(struct rng_operations *rng_ops)
+{
+	misc_deregister(&rng_miscdev);
+}
+
Index: linux-2.6-rng/drivers/char/rng/rng.h
===================================================================
--- /dev/null
+++ linux-2.6-rng/drivers/char/rng/rng.h
@@ -0,0 +1,24 @@
+/*
+ * driver/char/rng/rng.h
+ *
+ * RNG definitions shared by drivers
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+struct rng_operations {
+	/* Is there data in the FIFO? */
+	int (*data_present) (void);
+
+	/* Read data and return number of bytes read (up to 4) */
+	int (*data_read) (u32 *buffer);
+};
+
+int register_rng(struct rng_operations *);
+void unregister_rng(struct rng_operations *);
Index: linux-2.6-rng/drivers/char/rng/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6-rng/drivers/char/rng/Kconfig
@@ -0,0 +1,46 @@
+#
+# Hardware Random Number Generator (RNG) configuration
+#
+# We only support one RNG at a time
+#
+
+config X86_RNG
+	tristate "Intel/AMD/VIA HW Random Number Generator support"
+	depends on (X86 || IA64) && PCI
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Intel i8xx-based motherboards,
+	  AMD 76x-based motherboards, and Via Nehemiah CPUs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called x86-rng.
+
+	  If unsure, say N.
+
+config IXP4XX_RNG
+	tristate "Intel IXP4xx NPU HW Random Number Generator support"
+	depends on ARCH_IXP4XX
+	---help---
+	  This driver provides kernel-side support for the Random
+	  Number Generator hardware found on the Intel IXP4xx NPU.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ixp4xx-rng.
+
+config OMAP_RNG
+	tristate "OMAP Random Number Generator support"
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+ 	---help---
+ 	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on OMAP16xx and OMAP24xx multimedia
+	  processors.
+ 
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap-rng.
+
+ 	  If unsure, say N.
+
+config RNG
+	bool
+	depends on IXP4XX_RNG || X86_RNG || OMAP_RNG
+	default y
Index: linux-2.6-rng/drivers/char/Kconfig
===================================================================
--- linux-2.6-rng.orig/drivers/char/Kconfig
+++ linux-2.6-rng/drivers/char/Kconfig
@@ -644,6 +644,8 @@ config NWFLASH
 
 	  If you're not sure, say N.
 
+source "drivers/char/rng/Kconfig"
+
 config NVRAM
 	tristate "/dev/nvram support"
 	depends on ATARI || X86 || X86_64 || ARM || GENERIC_NVRAM

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
