Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWCANUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWCANUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWCANUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:20:16 -0500
Received: from mout0.freenet.de ([194.97.50.131]:9181 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1030199AbWCANUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:20:11 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Kumar Gala <galak@kernel.crashing.org>, dsaxena@plexity.net
Subject: Re: [PATCH] Generic hardware RNG support
Date: Wed, 1 Mar 2006 14:19:38 +0100
User-Agent: KMail/1.8.3
References: <200602281229.12887.mbuesch@freenet.de> <20060301004039.GA14229@plexity.net> <81D78F6B-7492-4DE0-A82D-F647869B3A40@kernel.crashing.org>
In-Reply-To: <81D78F6B-7492-4DE0-A82D-F647869B3A40@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6759086.XHRdj0l7Cc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603011419.39100.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6759086.XHRdj0l7Cc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 01 March 2006 03:57, you wrote:
> > Hi, I'll email you the patchset off-list so you can look at the API
> > and write the bcm43xx driver against it.  They are a few months old =20
> > and
> > need updating to 2.6.latest and it is on my 2.6.18 TODO. If you =20
> > search the
> > archives there were a few small issues left such as separating out =20
> > all the
> > x86 stuff into separate amd, via, and intel code instead of having =20
> > a single
> > file.
>=20
> Are the patches in any state to include in -mm?

What about something like the following patch.
This is a merge of Deepak Saxena's and my stuff. It brings
the best features from both patches. :)

This is only compile-tested, yet.

diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random/core.c linux-2.6.16-rc5-mm1/drivers/char/hw_=
random/core.c
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random/core.c	1970-01-01 01=
:00:00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random/core.c	2006-03-01 14:07:56.=
000000000 +0100
@@ -0,0 +1,352 @@
+/*
+        Added support for the AMD Geode LX RNG
+	(c) Copyright 2004-2005 Advanced Micro Devices, Inc.
+
+	derived from
+
+ 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
+	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
+=20
+ 	derived from
+=20
+        Hardware driver for the AMD 768 Random Number Generator (RNG)
+        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+
+ 	derived from
+=20
+	Hardware driver for Intel i810 Random Number Generator (RNG)
+	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+
+	Added generic RNG API
+	Copyright 2006 Michael Buesch <mbuesch@freenet.de>
+	Copyright 2005 (c) MontaVista Software, Inc.
+
+	Please read Documentation/hw_random.txt for details on use.
+
+	----------------------------------------------------------
+	This software may be used and distributed according to the terms
+        of the GNU General Public License, incorporated herein by referenc=
e.
+
+ */
+
+
+#include <linux/hw_random.h>
+#include <linux/pci.h>
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
+#ifdef __i386__
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+#endif
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+#define RNG_MODULE_NAME		"hw_random"
+#define RNG_DRIVER_NAME		RNG_MODULE_NAME " hardware driver"
+#define PFX RNG_MODULE_NAME	": "
+
+
+/*
+ * debugging macros
+ */
+
+/* pr_debug() collapses to a no-op if DEBUG is not defined */
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## a=
rgs)
+
+
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
+#ifdef RNG_NDEBUG
+#define assert(expr)							\
+		if(!(expr)) {						\
+		printk(KERN_DEBUG PFX "Assertion failed! %s,%s,%s,"	\
+		"line=3D%d\n", #expr, __FILE__, __FUNCTION__, __LINE__);	\
+		}
+#else
+#define assert(expr)
+#endif
+
+#define RNG_MISCDEV_MINOR		183 /* official */
+
+
+static int rng_dev_open (struct inode *inode, struct file *filp);
+static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t s=
ize,
+				loff_t * offp);
+
+static struct file_operations rng_chrdev_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D rng_dev_open,
+	.read		=3D rng_dev_read,
+};
+
+static struct miscdevice rng_miscdev =3D {
+	.minor		=3D RNG_MISCDEV_MINOR,
+	.name		=3D RNG_MODULE_NAME,
+	.fops		=3D &rng_chrdev_ops,
+};
+
+static struct hwrng *current_rng;
+static LIST_HEAD(rng_list);
+static DEFINE_MUTEX(rng_mutex);
+
+
+/***********************************************************************
+ *
+ * /dev/hwrandom character device handling (major 10, minor 183)
+ *
+ */
+
+static int rng_dev_open (struct inode *inode, struct file *filp)
+{
+	/* enforce read-only access to this chrdev */
+	if ((filp->f_mode & FMODE_READ) =3D=3D 0)
+		return -EINVAL;
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+	return 0;
+}
+
+
+static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t s=
ize,
+				loff_t * offp)
+{
+	unsigned int have_data;
+	u32 data =3D 0;
+	ssize_t ret =3D 0;
+	int err;
+
+	while (size) {
+		err =3D mutex_lock_interruptible(&rng_mutex);
+		if (err)
+			return err;
+		if (!current_rng) {
+			mutex_unlock(&rng_mutex);
+			return -ENODEV;
+		}
+		have_data =3D 0;
+		if (current_rng->data_present =3D=3D NULL ||
+		    current_rng->data_present(current_rng))
+			have_data =3D current_rng->data_read(current_rng, &data);
+		mutex_unlock(&rng_mutex);
+
+		while (have_data && size) {
+			if (put_user((u8)data, buf++)) {
+				ret =3D ret ? : -EFAULT;
+				break;
+			}
+			size--;
+			ret++;
+			have_data--;
+			data>>=3D8;
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
+
+static ssize_t hwrng_attr_current_store(struct class_device *class,
+					const char *buf, size_t len)
+{
+	int err =3D -ENODEV;
+	struct hwrng *rng;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	err =3D mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	err =3D -ENODEV;
+	list_for_each_entry(rng, &rng_list, list) {
+		if (strncmp(rng->name, buf, len) =3D=3D 0) {
+			if (rng->init) {
+				err =3D rng->init(rng);
+				if (err)
+					break;
+			}
+			if (current_rng && current_rng->cleanup)
+				current_rng->cleanup(current_rng);
+			current_rng =3D rng;
+			err =3D 0;
+			break;
+		}
+	}
+	mutex_unlock(&rng_mutex);
+
+	return err ? err : len;
+}
+
+static ssize_t hwrng_attr_current_show(struct class_device *class,
+				       char *buf)
+{
+	int err;
+	ssize_t ret;
+	const char *name;
+
+	err =3D mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	if (current_rng)
+		name =3D current_rng->name;
+	else
+		name =3D "none";
+	ret =3D sprintf(buf, "%s\n", name);
+	mutex_unlock(&rng_mutex);
+
+	return ret;
+}
+
+static ssize_t hwrng_attr_available_show(struct class_device *class,
+					 char *buf)
+{
+	int err;
+	ssize_t ret =3D 0;
+	struct hwrng *rng;
+
+	err =3D mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	buf[0] =3D '\0';
+	list_for_each_entry(rng, &rng_list, list) {
+		ret +=3D strlen(rng->name);
+		strcat(buf, rng->name);
+		ret +=3D 1;
+		strcat(buf, " ");
+	}
+	strcat(buf, "\n");
+	ret +=3D 1;
+	mutex_unlock(&rng_mutex);
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
+			 hwrng_attr_current_show,
+			 hwrng_attr_current_store);
+static CLASS_DEVICE_ATTR(rng_available, S_IRUGO,
+			 hwrng_attr_available_show,
+			 NULL);
+
+
+static void unregister_miscdev(void)
+{
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_available);
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_current);
+	misc_deregister(&rng_miscdev);
+}
+
+static int register_miscdev(void)
+{
+	int err;
+
+	err =3D misc_register(&rng_miscdev);
+	if (err)
+		goto out;
+	err =3D class_device_create_file(rng_miscdev.class,
+				       &class_device_attr_rng_current);
+	if (err)
+		goto err_misc_dereg;
+	err =3D class_device_create_file(rng_miscdev.class,
+				       &class_device_attr_rng_available);
+	if (err)
+		goto err_remove_current;
+out:
+	return err;
+
+err_remove_current:
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_current);
+err_misc_dereg:
+	misc_deregister(&rng_miscdev);
+	goto out;
+}
+
+int hwrng_register(struct hwrng *rng)
+{
+	int must_register_misc;
+	int err;
+	struct hwrng *old_current;
+
+	if (rng->name =3D=3D NULL)
+		return -EINVAL;
+	if (rng->data_read =3D=3D NULL)
+		return -EINVAL;
+
+	mutex_lock(&rng_mutex);
+	must_register_misc =3D (current_rng =3D=3D NULL);
+	old_current =3D current_rng;
+	if (!current_rng) {
+		if (rng->init) {
+			err =3D rng->init(rng);
+			if (err) {
+				mutex_unlock(&rng_mutex);
+				return err;
+			}
+		}
+		current_rng =3D rng;
+	}
+	INIT_LIST_HEAD(&rng->list);
+	list_add_tail(&rng->list, &rng_list);
+	err =3D 0;
+	if (must_register_misc) {
+		err =3D register_miscdev();
+		if (err) {
+			if (rng->cleanup)
+				rng->cleanup(rng);
+			list_del(&rng->list);
+			current_rng =3D old_current;
+		}
+	}
+
+	mutex_unlock(&rng_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(hwrng_register);
+
+void hwrng_unregister(struct hwrng *rng)
+{
+	mutex_lock(&rng_mutex);
+	list_del(&rng->list);
+	if (current_rng =3D=3D rng) {
+		if (rng->cleanup)
+			rng->cleanup(rng);
+		if (list_empty(&rng_list))
+			current_rng =3D NULL;
+		else
+			current_rng =3D list_entry(rng_list.prev, struct hwrng, list);
+	}
+	if (list_empty(&rng_list))
+		unregister_miscdev();
+	mutex_unlock(&rng_mutex);
+}
+EXPORT_SYMBOL_GPL(hwrng_unregister);
+
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random/ixp4xx-rng.c linux-2.6.16-rc5-mm1/drivers/ch=
ar/hw_random/ixp4xx-rng.c
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random/ixp4xx-rng.c	1970-01=
=2D01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random/ixp4xx-rng.c	2006-03-01 14:=
05:37.000000000 +0100
@@ -0,0 +1,62 @@
+/*
+ * drivers/char/rng/ixp4xx-rng.c
+ *
+ * RNG driver for Intel IXP4xx family of NPUs
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
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/hw_random.h>
+
+#include <asm/io.h>
+#include <asm/hardware.h>
+
+
+static u32* __iomem rng_base;
+
+
+static int ixp4xx_rng_data_read(struct hwrng *rng, u32 *buffer)
+{
+	*buffer =3D __raw_readl(rng_base);
+
+	return 4;
+}
+
+struct hwrng ixp4xx_rng_ops =3D {
+	.name		=3D "ixp4xx",
+	.data_read	=3D ixp4xx_rng_data_read,
+};
+
+static int __init ixp4xx_rng_init(void)
+{
+	rng_base =3D (u32* __iomem) ioremap(0x70002100, 4);
+	if (!rng_base) return -ENOMEM;
+
+	return hwrng_register(&ixp4xx_rng_ops);
+}
+
+static void __exit ixp4xx_rng_exit(void)
+{
+	hwrng_unregister(&ixp4xx_rng_ops);
+	iounmap(rng_base);
+}
+
+subsys_initcall(ixp4xx_rng_init);
+module_exit(ixp4xx_rng_exit);
+
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver for IXP4xx");
+MODULE_LICENSE("GPL");
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random/Kconfig linux-2.6.16-rc5-mm1/drivers/char/hw=
_random/Kconfig
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random/Kconfig	1970-01-01 0=
1:00:00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random/Kconfig	2006-03-01 14:06:25=
=2E000000000 +0100
@@ -0,0 +1,47 @@
+#
+# Hardware Random Number Generator (RNG) configuration
+#
+
+
+config HW_RANDOM
+	bool "Hardware Random Number Generator Core support"
+	default y
+	---help---
+	  Hardware Random Number Generator Core infrastructure.
+
+config X86_RNG
+	tristate "Intel/AMD/VIA HW Random Number Generator support"
+	depends on HW_RANDOM && (X86 || IA64) && PCI
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
+	depends on HW_RANDOM && ARCH_IXP4XX
+	---help---
+	  This driver provides kernel-side support for the Random
+	  Number Generator hardware found on the Intel IXP4xx NPU.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ixp4xx-rng.
+
+config OMAP_RNG
+	tristate "OMAP Random Number Generator support"
+	depends on HW_RANDOM && (ARCH_OMAP16XX || ARCH_OMAP24XX)
+ 	---help---
+ 	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on OMAP16xx and OMAP24xx multimedia
+	  processors.
+=20
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap-rng.
+
+ 	  If unsure, say N.
+
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random/Makefile linux-2.6.16-rc5-mm1/drivers/char/h=
w_random/Makefile
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random/Makefile	1970-01-01 =
01:00:00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random/Makefile	2006-03-01 14:07:2=
5.000000000 +0100
@@ -0,0 +1,8 @@
+#
+# Makefile for HW Random Number Generator (RNG) device drivers.
+#
+
+obj-$(CONFIG_HW_RANDOM) +=3D core.o
+obj-$(CONFIG_IXP4XX_RNG) +=3D ixp4xx-rng.o
+obj-$(CONFIG_X86_RNG) +=3D x86-rng.o
+obj-$(CONFIG_OMAP_RNG) +=3D omap-rng.o
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random/omap-rng.c linux-2.6.16-rc5-mm1/drivers/char=
/hw_random/omap-rng.c
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random/omap-rng.c	1970-01-0=
1 01:00:00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random/omap-rng.c	2006-03-01 14:05=
:34.000000000 +0100
@@ -0,0 +1,209 @@
+/*
+ * driver/char/hw_random/omap-rng.c
+ *
+ * RNG driver for TI OMAP CPU family
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * Mostly based on original driver:
+ *
+ * Copyright (C) 2005 Nokia Corporation
+ * Author: Juha Yrj=EF=BF=BD=EF=BF=BD<juha.yrjola@nokia.com>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * TODO:
+ *
+ * - Make status updated be interrupt driven so we don't poll
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/random.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/hw_random.h>
+
+#include <asm/io.h>
+#include <asm/hardware/clock.h>
+
+#define RNG_OUT_REG		0x00		/* Output register */
+#define RNG_STAT_REG		0x04		/* Status register
+							[0] =3D STAT_BUSY */
+#define RNG_ALARM_REG		0x24		/* Alarm register
+							[7:0] =3D ALARM_COUNTER */
+#define RNG_CONFIG_REG		0x28		/* Configuration register
+							[11:6] =3D RESET_COUNT
+							[5:3]  =3D RING2_DELAY
+							[2:0]  =3D RING1_DELAY */
+#define RNG_REV_REG		0x3c		/* Revision register
+							[7:0] =3D REV_NB */
+#define RNG_MASK_REG		0x40		/* Mask and reset register
+							[2] =3D IT_EN
+							[1] =3D SOFTRESET
+							[0] =3D AUTOIDLE */
+#define RNG_SYSSTATUS		0x44		/* System status
+							[0] =3D RESETDONE */
+
+static void __iomem *rng_base;
+static struct clk *rng_ick;
+static struct device *rng_dev;
+
+static u32 omap_rng_read_reg(int reg)
+{
+	return __raw_readl(rng_base + reg);
+}
+
+static void omap_rng_write_reg(int reg, u32 val)
+{
+	__raw_writel(val, rng_base + reg);
+}
+
+/* REVISIT: Does the status bit really work on 16xx? */
+static int omap_rng_data_present(struct hwrng *rng)
+{
+	return omap_rng_read_reg(RNG_STAT_REG) ? 0 : 1;
+}
+
+static int omap_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	*data =3D omap_rng_read_reg(RNG_OUT_REG);
+
+	return 4;
+}
+
+static struct hwrng omap_rng_ops =3D {
+	.name		=3D "omap",
+	.data_present	=3D omap_rng_data_present,
+	.data_read	=3D omap_rng_data_read,
+};
+
+static int __init omap_rng_probe(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct resource *res, *mem;
+	int ret;
+
+	/*
+	 * A bit ugly, and it will never actually happen but there can
+	 * be only one RNG and this catches any bork
+	 */
+	if (rng_dev)
+		BUG();
+
+    	if (cpu_is_omap24xx()) {
+		rng_ick =3D clk_get(NULL, "rng_ick");
+		if (IS_ERR(rng_ick)) {
+			dev_err(dev, "Could not get rng_ick\n");
+			ret =3D PTR_ERR(rng_ick);
+			return ret;
+		}
+		else {
+			clk_use(rng_ick);
+		}
+	}
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res)
+		return -ENOENT;
+
+	mem =3D request_mem_region(res->start, res->end - res->start + 1,
+				 pdev->name);
+	if (mem =3D=3D NULL)
+		return -EBUSY;
+
+	dev_set_drvdata(dev, mem);
+	rng_base =3D (u32 __iomem *)io_p2v(res->start);
+
+	ret =3D hwrng_register(&omap_rng_ops);
+	if (ret) {
+		release_resource(mem);
+		rng_base =3D NULL;
+		return ret;
+	}
+
+	dev_info(dev, "OMAP Random Number Generator ver. %02x\n",
+		omap_rng_read_reg(RNG_REV_REG));
+	omap_rng_write_reg(RNG_MASK_REG, 0x1);
+
+	rng_dev =3D dev;
+
+	return 0;
+}
+
+static int __exit omap_rng_remove(struct device *dev)
+{
+	struct resource *mem =3D dev_get_drvdata(dev);
+
+	hwrng_unregister(&omap_rng_ops);
+
+	omap_rng_write_reg(RNG_MASK_REG, 0x0);
+
+	if (cpu_is_omap24xx()) {
+		clk_unuse(rng_ick);
+		clk_put(rng_ick);
+	}
+
+	release_resource(mem);
+	rng_base =3D NULL;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 =
level)
+{
+	omap_rng_write_reg(RNG_MASK_REG, 0x0);
+
+	return 0;
+}
+
+static int omap_rng_resume(struct device *dev, pm_message_t message, u32 l=
evel)
+{
+	omap_rng_write_reg(RNG_MASK_REG, 0x1);
+
+	return 1;
+}
+
+#else
+
+#define	omap_rng_suspend	NULL
+#define	omap_rng_resume		NULL
+
+#endif
+
+
+static struct device_driver omap_rng_driver =3D {
+	.name		=3D "omap_rng",
+	.bus		=3D &platform_bus_type,
+	.probe		=3D omap_rng_probe,
+	.remove		=3D __exit_p(omap_rng_remove),
+	.suspend	=3D omap_rng_suspend,
+	.resume		=3D omap_rng_resume
+};
+
+static int __init omap_rng_init(void)
+{
+	if (!cpu_is_omap16xx() && !cpu_is_omap24xx())
+		return -ENODEV;
+
+	return driver_register(&omap_rng_driver);
+}
+
+static void __exit omap_rng_exit(void)
+{
+	driver_unregister(&omap_rng_driver);
+}
+
+module_init(omap_rng_init);
+module_exit(omap_rng_exit);
+
+MODULE_AUTHOR("Deepak Saxena (and others)");
+MODULE_LICENSE("GPL");
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random/x86-rng.c linux-2.6.16-rc5-mm1/drivers/char/=
hw_random/x86-rng.c
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random/x86-rng.c	1970-01-01=
 01:00:00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random/x86-rng.c	2006-03-01 14:14:=
11.000000000 +0100
@@ -0,0 +1,593 @@
+/*
+ * drivers/char/rng/x86.c
+ *
+ * RNG driver for Intel/AMD/VIA RNGs
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * with the majority of the code coming from:
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
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/random.h>
+#include <linux/miscdevice.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/hw_random.h>
+
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+
+#include <asm/io.h>
+
+
+/*
+ * debugging macros
+ */
+
+/* pr_debug() collapses to a no-op if DEBUG is not defined */
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## a=
rgs)
+
+#define RNG_VERSION "1.1.0"
+#define RNG_MODULE_NAME "x86-rng"
+#define RNG_DRIVER_NAME RNG_MODULE_NAME " hardware driver " RNG_VERSION
+#define PFX RNG_MODULE_NAME ": "
+
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
+#ifdef RNG_NDEBUG
+#define assert(expr)							\
+		if(!(expr)) {						\
+		printk(KERN_DEBUG PFX "Assertion failed! %s,%s,%s,"	\
+		"line=3D%d\n", #expr, __FILE__, __FUNCTION__, __LINE__);	\
+		}
+#else
+#define assert(expr)
+#endif
+
+static struct hwrng *x86_rng_ops;
+
+static int __init intel_init (struct hwrng *rng);
+static void intel_cleanup(struct hwrng *rng);
+static int intel_data_present (struct hwrng *rng);
+static int intel_data_read (struct hwrng *rng, u32 *data);
+
+static int __init amd_init (struct hwrng *rng);
+static void amd_cleanup(struct hwrng *rng);
+static int amd_data_present (struct hwrng *rng);
+static int amd_data_read (struct hwrng *rng, u32 *data);
+
+#ifdef __i386__
+static int __init via_init(struct hwrng *rng);
+static void via_cleanup(struct hwrng *rng);
+static int via_data_present (struct hwrng *rng);
+static int via_data_read (struct hwrng *rng, u32 *data);
+#endif
+
+static int __init geode_init(struct hwrng *rng);
+static void geode_cleanup(struct hwrng *rng);
+static int geode_data_present (struct hwrng *rng);
+static int geode_data_read (struct hwrng *rng, u32 *data);
+
+enum {
+	rng_hw_none,
+	rng_hw_intel,
+	rng_hw_amd,
+#ifdef __i386__
+	rng_hw_via,
+#endif
+	rng_hw_geode,
+};
+
+static struct hwrng rng_vendor_ops[] =3D {
+	{ /* rng_hw_none */
+	}, { /* rng_hw_intel */
+		.name		=3D "intel",
+		.init		=3D intel_init,
+		.cleanup	=3D intel_cleanup,
+		.data_present	=3D intel_data_present,
+		.data_read	=3D intel_data_read,
+	}, { /* rng_hw_amd */
+		.name		=3D "amd",
+		.init		=3D amd_init,
+		.cleanup	=3D amd_cleanup,
+		.data_present	=3D amd_data_present,
+		.data_read	=3D amd_data_read,
+	},
+#ifdef __i386__
+	{ /* rng_hw_via */
+		.name		=3D "via",
+		.init		=3D via_init,
+		.cleanup	=3D via_cleanup,
+		.data_present	=3D via_data_present,
+		.data_read	=3D via_data_read,
+	},
+#endif
+	{ /* rng_hw_geode */
+		.name		=3D "geode",
+		.init		=3D geode_init,
+		.cleanup	=3D geode_cleanup,
+		.data_present	=3D geode_data_present,
+		.data_read	=3D geode_data_read,
+	},
+};
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id rng_pci_tbl[] =3D {
+	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
+	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
+
+	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_geode },
+
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
+
+
+/***********************************************************************
+ *
+ * Intel RNG operations
+ *
+ */
+
+/*
+ * RNG registers (offsets from rng_mem)
+ */
+#define INTEL_RNG_HW_STATUS			0
+#define         INTEL_RNG_PRESENT		0x40
+#define         INTEL_RNG_ENABLED		0x01
+#define INTEL_RNG_STATUS			1
+#define         INTEL_RNG_DATA_PRESENT		0x01
+#define INTEL_RNG_DATA				2
+
+/*
+ * Magic address at which Intel PCI bridges locate the RNG
+ */
+#define INTEL_RNG_ADDR				0xFFBC015F
+#define INTEL_RNG_ADDR_LEN			3
+
+static inline u8 intel_hwstatus (void __iomem *rng_mem)
+{
+	assert (rng_mem !=3D NULL);
+	return readb (rng_mem + INTEL_RNG_HW_STATUS);
+}
+
+static inline u8 intel_hwstatus_set (void __iomem *rng_mem, u8 hw_status)
+{
+	assert (rng_mem !=3D NULL);
+	writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);
+	return intel_hwstatus (rng_mem);
+}
+
+static int intel_data_present(struct hwrng *rng)
+{
+	void __iomem *rng_mem =3D (void __iomem *)rng->priv;
+
+	assert (rng_mem !=3D NULL);
+	return (readb (rng_mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT) ?
+		1 : 0;
+}
+
+static int intel_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *rng_mem =3D (void __iomem *)rng->priv;
+
+	assert (rng_mem !=3D NULL);
+	*data =3D readb (rng_mem + INTEL_RNG_DATA);
+
+	return 1;
+}
+
+static int __init intel_init(struct hwrng *rng)
+{
+	void __iomem *rng_mem;
+	int rc;
+	u8 hw_status;
+
+	DPRINTK ("ENTER\n");
+
+	rng_mem =3D ioremap (INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
+	if (rng_mem =3D=3D NULL) {
+		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
+		rc =3D -EBUSY;
+		goto err_out;
+	}
+	rng->priv =3D (unsigned long)rng_mem;
+
+	/* Check for Intel 82802 */
+	hw_status =3D intel_hwstatus (rng_mem);
+	if ((hw_status & INTEL_RNG_PRESENT) =3D=3D 0) {
+		printk (KERN_ERR PFX "RNG not detected\n");
+		rc =3D -ENODEV;
+		goto err_out_free_map;
+	}
+
+	/* turn RNG h/w on, if it's off */
+	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0)
+		hw_status =3D intel_hwstatus_set (rng_mem, hw_status | INTEL_RNG_ENABLED=
);
+	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0) {
+		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
+		rc =3D -EIO;
+		goto err_out_free_map;
+	}
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out_free_map:
+	iounmap (rng_mem);
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+static void intel_cleanup(struct hwrng *rng)
+{
+	void __iomem *rng_mem =3D (void __iomem *)rng->priv;
+	u8 hw_status;
+
+	hw_status =3D intel_hwstatus (rng_mem);
+	if (hw_status & INTEL_RNG_ENABLED)
+		intel_hwstatus_set (rng_mem, hw_status & ~INTEL_RNG_ENABLED);
+	else
+		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
+	iounmap(rng_mem);
+}
+
+/***********************************************************************
+ *
+ * AMD RNG operations
+ *
+ */
+
+static struct pci_dev *amd_pdev;
+
+static int amd_data_present (struct hwrng *rng)
+{
+	u32 pmbase =3D (u32)rng->priv;
+
+      	return !!(inl(pmbase + 0xF4) & 1);
+}
+
+
+static int amd_data_read (struct hwrng *rng, u32 *data)
+{
+	u32 pmbase =3D (u32)rng->priv;
+
+	*data =3D inl(pmbase + 0xF0);
+
+	return 4;
+}
+
+static int __init amd_init(struct hwrng *rng)
+{
+	u32 pmbase;
+	int rc;
+	u8 rnen;
+
+	DPRINTK ("ENTER\n");
+
+	amd_pdev =3D (struct pci_dev *)rng->priv;
+	pci_read_config_dword(amd_pdev, 0x58, &pmbase);
+
+	pmbase &=3D 0x0000FF00;
+
+	if (pmbase =3D=3D 0)
+	{
+		printk (KERN_ERR PFX "power management base not set\n");
+		rc =3D -EIO;
+		goto err_out;
+	}
+	rng->priv =3D (unsigned long)pmbase;
+
+	pci_read_config_byte(amd_pdev, 0x40, &rnen);
+	rnen |=3D (1 << 7);	/* RNG on */
+	pci_write_config_byte(amd_pdev, 0x40, rnen);
+
+	pci_read_config_byte(amd_pdev, 0x41, &rnen);
+	rnen |=3D (1 << 7);	/* PMIO enable */
+	pci_write_config_byte(amd_pdev, 0x41, rnen);
+
+	pr_info( PFX "AMD768 system management I/O registers at 0x%X.\n",
+			pmbase);
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+static void amd_cleanup(struct hwrng *rng)
+{
+	u8 rnen;
+
+	pci_read_config_byte(amd_pdev, 0x40, &rnen);
+	rnen &=3D ~(1 << 7);	/* RNG off */
+	pci_write_config_byte(amd_pdev, 0x40, rnen);
+	amd_pdev =3D NULL;
+
+	/* FIXME: twiddle pmio, also? */
+}
+
+#ifdef __i386__
+/***********************************************************************
+ *
+ * VIA RNG operations
+ *
+ */
+
+enum {
+	VIA_STRFILT_CNT_SHIFT	=3D 16,
+	VIA_STRFILT_FAIL	=3D (1 << 15),
+	VIA_STRFILT_ENABLE	=3D (1 << 14),
+	VIA_RAWBITS_ENABLE	=3D (1 << 13),
+	VIA_RNG_ENABLE		=3D (1 << 6),
+	VIA_XSTORE_CNT_MASK	=3D 0x0F,
+
+	VIA_RNG_CHUNK_8		=3D 0x00,	/* 64 rand bits, 64 stored bits */
+	VIA_RNG_CHUNK_4		=3D 0x01,	/* 32 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_4_MASK	=3D 0xFFFFFFFF,
+	VIA_RNG_CHUNK_2		=3D 0x02,	/* 16 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_2_MASK	=3D 0xFFFF,
+	VIA_RNG_CHUNK_1		=3D 0x03,	/* 8 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_1_MASK	=3D 0xFF,
+};
+
+/*
+ * Investigate using the 'rep' prefix to obtain 32 bits of random data
+ * in one insn.  The upside is potentially better performance.  The
+ * downside is that the instruction becomes no longer atomic.  Due to
+ * this, just like familiar issues with /dev/random itself, the worst
+ * case of a 'rep xstore' could potentially pause a cpu for an
+ * unreasonably long time.  In practice, this condition would likely
+ * only occur when the hardware is failing.  (or so we hope :))
+ *
+ * Another possible performance boost may come from simply buffering
+ * until we have 4 bytes, thus returning a u32 at a time,
+ * instead of the current u8-at-a-time.
+ */
+
+static inline u32 xstore(u32 *addr, u32 edx_in)
+{
+	u32 eax_out;
+
+	asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=3D%0) */"
+		:"=3Dm"(*addr), "=3Da"(eax_out)
+		:"D"(addr), "d"(edx_in));
+
+	return eax_out;
+}
+
+static int via_data_present(struct hwrng *rng)
+{
+	u32 bytes_out;
+	u32 *via_rng_datum =3D (u32 *)(&rng->priv);
+
+	/* We choose the recommended 1-byte-per-instruction RNG rate,
+	 * for greater randomness at the expense of speed.  Larger
+	 * values 2, 4, or 8 bytes-per-instruction yield greater
+	 * speed at lesser randomness.
+	 *
+	 * If you change this to another VIA_CHUNK_n, you must also
+	 * change the ->n_bytes values in rng_vendor_ops[] tables.
+	 * VIA_CHUNK_8 requires further code changes.
+	 *
+	 * A copy of MSR_VIA_RNG is placed in eax_out when xstore
+	 * completes.
+	 */
+
+	*via_rng_datum =3D 0; /* paranoia, not really necessary */
+	bytes_out =3D xstore(via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MAS=
K;
+	if (bytes_out =3D=3D 0)
+		return 0;
+
+	return 1;
+}
+
+static int via_data_read(struct hwrng *rng, u32 *data)
+{
+	u32 via_rng_datum =3D (u32)rng->priv;
+
+	*data =3D via_rng_datum;
+
+	return 1;
+}
+
+static int __init via_init(struct hwrng *rng)
+{
+	u32 lo, hi, old_lo;
+
+	/* Control the RNG via MSR.  Tread lightly and pay very close
+	 * close attention to values written, as the reserved fields
+	 * are documented to be "undefined and unpredictable"; but it
+	 * does not say to write them as zero, so I make a guess that
+	 * we restore the values we find in the register.
+	 */
+	rdmsr(MSR_VIA_RNG, lo, hi);
+
+	old_lo =3D lo;
+	lo &=3D ~(0x7f << VIA_STRFILT_CNT_SHIFT);
+	lo &=3D ~VIA_XSTORE_CNT_MASK;
+	lo &=3D ~(VIA_STRFILT_ENABLE | VIA_STRFILT_FAIL | VIA_RAWBITS_ENABLE);
+	lo |=3D VIA_RNG_ENABLE;
+
+	if (lo !=3D old_lo)
+		wrmsr(MSR_VIA_RNG, lo, hi);
+
+	/* perhaps-unnecessary sanity check; remove after testing if
+	   unneeded */
+	rdmsr(MSR_VIA_RNG, lo, hi);
+	if ((lo & VIA_RNG_ENABLE) =3D=3D 0) {
+		printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void via_cleanup(struct hwrng *rng)
+{
+	/* do nothing */
+}
+#endif
+
+/***********************************************************************
+ *
+ * AMD Geode RNG operations
+ *
+ */
+
+#define GEODE_RNG_DATA_REG   0x50
+#define GEODE_RNG_STATUS_REG 0x54
+
+static int geode_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *geode_rng_base =3D (void __iomem *)rng->priv;
+
+	assert(geode_rng_base !=3D NULL);
+	*data =3D readl(geode_rng_base + GEODE_RNG_DATA_REG);
+
+	return 4;
+}
+
+static int geode_data_present(struct hwrng *rng)
+{
+	void __iomem *geode_rng_base =3D (void __iomem *)rng->priv;
+	u32 val;
+
+	assert(geode_rng_base !=3D NULL);
+	val =3D readl(geode_rng_base + GEODE_RNG_STATUS_REG);
+
+	return !!val;
+}
+
+static void geode_cleanup(struct hwrng *rng)
+{
+	void __iomem *geode_rng_base =3D (void __iomem *)rng->priv;
+
+	iounmap(geode_rng_base);
+  	geode_rng_base =3D NULL;
+}
+
+static int geode_init(struct hwrng *rng)
+{
+	void __iomem *geode_rng_base;
+	struct pci_dev *dev =3D (struct pci_dev *)rng->priv;
+	unsigned long rng_base =3D pci_resource_start(dev, 0);
+
+	if (rng_base =3D=3D 0)
+		return 1;
+
+	geode_rng_base =3D ioremap(rng_base, 0x58);
+
+	if (geode_rng_base =3D=3D NULL) {
+		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
+		return -EBUSY;
+	}
+	rng->priv =3D (unsigned long)geode_rng_base;
+
+	return 0;
+}
+
+
+/*
+ * rng_init - initialize RNG module
+ */
+static int __init x86_rng_init(void)
+{
+	int rc;
+	struct pci_dev *pdev =3D NULL;
+	const struct pci_device_id *ent;
+
+	DPRINTK ("ENTER\n");
+
+	/* Probe for Intel, AMD RNGs */
+	for_each_pci_dev(pdev) {
+		ent =3D pci_match_id(rng_pci_tbl, pdev);
+		if (ent) {
+			x86_rng_ops =3D &rng_vendor_ops[ent->driver_data];
+			goto match;
+		}
+	}
+
+	/* Probe for VIA RNG */
+	if (cpu_has_xstore) {
+		x86_rng_ops =3D &rng_vendor_ops[rng_hw_via];
+		pdev =3D NULL;
+		goto match;
+	}
+
+	DPRINTK ("EXIT, returning -ENODEV\n");
+	return -ENODEV;
+
+match:
+	x86_rng_ops->priv =3D (unsigned long)pdev;
+	rc =3D hwrng_register(x86_rng_ops);
+	if (rc)
+		return rc;
+
+	pr_info( RNG_DRIVER_NAME " loaded\n");
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+}
+
+/*
+ * rng_init - shutdown RNG module
+ */
+static void __exit x86_rng_exit (void)
+{
+	DPRINTK ("ENTER\n");
+
+	hwrng_unregister(x86_rng_ops);
+
+	DPRINTK ("EXIT\n");
+}
+
+subsys_initcall(x86_rng_init);
+module_exit(x86_rng_exit);
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W RNG driver for Intel/AMD/VIA chipsets");
+MODULE_LICENSE("GPL");
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/hw_random.c linux-2.6.16-rc5-mm1/drivers/char/hw_rando=
m.c
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/hw_random.c	2006-03-01 13:18:5=
8.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/hw_random.c	1970-01-01 01:00:00.00000=
0000 +0100
@@ -1,698 +0,0 @@
=2D/*
=2D        Added support for the AMD Geode LX RNG
=2D	(c) Copyright 2004-2005 Advanced Micro Devices, Inc.
=2D
=2D	derived from
=2D
=2D 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
=2D	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
=2D=20
=2D 	derived from
=2D=20
=2D        Hardware driver for the AMD 768 Random Number Generator (RNG)
=2D        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
=2D
=2D 	derived from
=2D=20
=2D	Hardware driver for Intel i810 Random Number Generator (RNG)
=2D	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
=2D	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
=2D
=2D	Please read Documentation/hw_random.txt for details on use.
=2D
=2D	----------------------------------------------------------
=2D	This software may be used and distributed according to the terms
=2D        of the GNU General Public License, incorporated herein by refere=
nce.
=2D
=2D */
=2D
=2D
=2D#include <linux/module.h>
=2D#include <linux/kernel.h>
=2D#include <linux/fs.h>
=2D#include <linux/init.h>
=2D#include <linux/pci.h>
=2D#include <linux/interrupt.h>
=2D#include <linux/spinlock.h>
=2D#include <linux/random.h>
=2D#include <linux/miscdevice.h>
=2D#include <linux/smp_lock.h>
=2D#include <linux/mm.h>
=2D#include <linux/delay.h>
=2D
=2D#ifdef __i386__
=2D#include <asm/msr.h>
=2D#include <asm/cpufeature.h>
=2D#endif
=2D
=2D#include <asm/io.h>
=2D#include <asm/uaccess.h>
=2D
=2D
=2D/*
=2D * core module and version information
=2D */
=2D#define RNG_VERSION "1.0.0"
=2D#define RNG_MODULE_NAME "hw_random"
=2D#define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
=2D#define PFX RNG_MODULE_NAME ": "
=2D
=2D
=2D/*
=2D * debugging macros
=2D */
=2D
=2D/* pr_debug() collapses to a no-op if DEBUG is not defined */
=2D#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ##=
 args)
=2D
=2D
=2D#undef RNG_NDEBUG        /* define to enable lightweight runtime checks =
*/
=2D#ifdef RNG_NDEBUG
=2D#define assert(expr)							\
=2D		if(!(expr)) {						\
=2D		printk(KERN_DEBUG PFX "Assertion failed! %s,%s,%s,"	\
=2D		"line=3D%d\n", #expr, __FILE__, __FUNCTION__, __LINE__);	\
=2D		}
=2D#else
=2D#define assert(expr)
=2D#endif
=2D
=2D#define RNG_MISCDEV_MINOR		183 /* official */
=2D
=2Dstatic int rng_dev_open (struct inode *inode, struct file *filp);
=2Dstatic ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t=
 size,
=2D				loff_t * offp);
=2D
=2Dstatic int __init intel_init (struct pci_dev *dev);
=2Dstatic void intel_cleanup(void);
=2Dstatic unsigned int intel_data_present (void);
=2Dstatic u32 intel_data_read (void);
=2D
=2Dstatic int __init amd_init (struct pci_dev *dev);
=2Dstatic void amd_cleanup(void);
=2Dstatic unsigned int amd_data_present (void);
=2Dstatic u32 amd_data_read (void);
=2D
=2D#ifdef __i386__
=2Dstatic int __init via_init(struct pci_dev *dev);
=2Dstatic void via_cleanup(void);
=2Dstatic unsigned int via_data_present (void);
=2Dstatic u32 via_data_read (void);
=2D#endif
=2D
=2Dstatic int __init geode_init(struct pci_dev *dev);
=2Dstatic void geode_cleanup(void);
=2Dstatic unsigned int geode_data_present (void);
=2Dstatic u32 geode_data_read (void);
=2D
=2Dstruct rng_operations {
=2D	int (*init) (struct pci_dev *dev);
=2D	void (*cleanup) (void);
=2D	unsigned int (*data_present) (void);
=2D	u32 (*data_read) (void);
=2D	unsigned int n_bytes; /* number of bytes per ->data_read */
=2D};
=2Dstatic struct rng_operations *rng_ops;
=2D
=2Dstatic struct file_operations rng_chrdev_ops =3D {
=2D	.owner		=3D THIS_MODULE,
=2D	.open		=3D rng_dev_open,
=2D	.read		=3D rng_dev_read,
=2D};
=2D
=2D
=2Dstatic struct miscdevice rng_miscdev =3D {
=2D	RNG_MISCDEV_MINOR,
=2D	RNG_MODULE_NAME,
=2D	&rng_chrdev_ops,
=2D};
=2D
=2Denum {
=2D	rng_hw_none,
=2D	rng_hw_intel,
=2D	rng_hw_amd,
=2D#ifdef __i386__
=2D	rng_hw_via,
=2D#endif
=2D	rng_hw_geode,
=2D};
=2D
=2Dstatic struct rng_operations rng_vendor_ops[] =3D {
=2D	/* rng_hw_none */
=2D	{ },
=2D
=2D	/* rng_hw_intel */
=2D	{ intel_init, intel_cleanup, intel_data_present,
=2D	  intel_data_read, 1 },
=2D
=2D	/* rng_hw_amd */
=2D	{ amd_init, amd_cleanup, amd_data_present, amd_data_read, 4 },
=2D
=2D#ifdef __i386__
=2D	/* rng_hw_via */
=2D	{ via_init, via_cleanup, via_data_present, via_data_read, 1 },
=2D#endif
=2D
=2D	/* rng_hw_geode */
=2D	{ geode_init, geode_cleanup, geode_data_present, geode_data_read, 4 }
=2D};
=2D
=2D/*
=2D * Data for PCI driver interface
=2D *
=2D * This data only exists for exporting the supported
=2D * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
=2D * register a pci_driver, because someone else might one day
=2D * want to register another driver on the same PCI id.
=2D */
=2Dstatic struct pci_device_id rng_pci_tbl[] =3D {
=2D	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
=2D	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
=2D
=2D	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
=2D	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
=2D	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
=2D	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
=2D	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
=2D	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
=2D
=2D	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES,
=2D	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_geode },
=2D
=2D	{ 0, },	/* terminate list */
=2D};
=2DMODULE_DEVICE_TABLE (pci, rng_pci_tbl);
=2D
=2D
=2D/***********************************************************************
=2D *
=2D * Intel RNG operations
=2D *
=2D */
=2D
=2D/*
=2D * RNG registers (offsets from rng_mem)
=2D */
=2D#define INTEL_RNG_HW_STATUS			0
=2D#define         INTEL_RNG_PRESENT		0x40
=2D#define         INTEL_RNG_ENABLED		0x01
=2D#define INTEL_RNG_STATUS			1
=2D#define         INTEL_RNG_DATA_PRESENT		0x01
=2D#define INTEL_RNG_DATA				2
=2D
=2D/*
=2D * Magic address at which Intel PCI bridges locate the RNG
=2D */
=2D#define INTEL_RNG_ADDR				0xFFBC015F
=2D#define INTEL_RNG_ADDR_LEN			3
=2D
=2D/* token to our ioremap'd RNG register area */
=2Dstatic void __iomem *rng_mem;
=2D
=2Dstatic inline u8 intel_hwstatus (void)
=2D{
=2D	assert (rng_mem !=3D NULL);
=2D	return readb (rng_mem + INTEL_RNG_HW_STATUS);
=2D}
=2D
=2Dstatic inline u8 intel_hwstatus_set (u8 hw_status)
=2D{
=2D	assert (rng_mem !=3D NULL);
=2D	writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);
=2D	return intel_hwstatus ();
=2D}
=2D
=2Dstatic unsigned int intel_data_present(void)
=2D{
=2D	assert (rng_mem !=3D NULL);
=2D
=2D	return (readb (rng_mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT) ?
=2D		1 : 0;
=2D}
=2D
=2Dstatic u32 intel_data_read(void)
=2D{
=2D	assert (rng_mem !=3D NULL);
=2D
=2D	return readb (rng_mem + INTEL_RNG_DATA);
=2D}
=2D
=2Dstatic int __init intel_init (struct pci_dev *dev)
=2D{
=2D	int rc;
=2D	u8 hw_status;
=2D
=2D	DPRINTK ("ENTER\n");
=2D
=2D	rng_mem =3D ioremap (INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
=2D	if (rng_mem =3D=3D NULL) {
=2D		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
=2D		rc =3D -EBUSY;
=2D		goto err_out;
=2D	}
=2D
=2D	/* Check for Intel 82802 */
=2D	hw_status =3D intel_hwstatus ();
=2D	if ((hw_status & INTEL_RNG_PRESENT) =3D=3D 0) {
=2D		printk (KERN_ERR PFX "RNG not detected\n");
=2D		rc =3D -ENODEV;
=2D		goto err_out_free_map;
=2D	}
=2D
=2D	/* turn RNG h/w on, if it's off */
=2D	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0)
=2D		hw_status =3D intel_hwstatus_set (hw_status | INTEL_RNG_ENABLED);
=2D	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0) {
=2D		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
=2D		rc =3D -EIO;
=2D		goto err_out_free_map;
=2D	}
=2D
=2D	DPRINTK ("EXIT, returning 0\n");
=2D	return 0;
=2D
=2Derr_out_free_map:
=2D	iounmap (rng_mem);
=2D	rng_mem =3D NULL;
=2Derr_out:
=2D	DPRINTK ("EXIT, returning %d\n", rc);
=2D	return rc;
=2D}
=2D
=2Dstatic void intel_cleanup(void)
=2D{
=2D	u8 hw_status;
=2D
=2D	hw_status =3D intel_hwstatus ();
=2D	if (hw_status & INTEL_RNG_ENABLED)
=2D		intel_hwstatus_set (hw_status & ~INTEL_RNG_ENABLED);
=2D	else
=2D		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
=2D	iounmap(rng_mem);
=2D	rng_mem =3D NULL;
=2D}
=2D
=2D/***********************************************************************
=2D *
=2D * AMD RNG operations
=2D *
=2D */
=2D
=2Dstatic u32 pmbase;			/* PMxx I/O base */
=2Dstatic struct pci_dev *amd_dev;
=2D
=2Dstatic unsigned int amd_data_present (void)
=2D{
=2D      	return inl(pmbase + 0xF4) & 1;
=2D}
=2D
=2D
=2Dstatic u32 amd_data_read (void)
=2D{
=2D	return inl(pmbase + 0xF0);
=2D}
=2D
=2Dstatic int __init amd_init (struct pci_dev *dev)
=2D{
=2D	int rc;
=2D	u8 rnen;
=2D
=2D	DPRINTK ("ENTER\n");
=2D
=2D	pci_read_config_dword(dev, 0x58, &pmbase);
=2D
=2D	pmbase &=3D 0x0000FF00;
=2D
=2D	if (pmbase =3D=3D 0)
=2D	{
=2D		printk (KERN_ERR PFX "power management base not set\n");
=2D		rc =3D -EIO;
=2D		goto err_out;
=2D	}
=2D
=2D	pci_read_config_byte(dev, 0x40, &rnen);
=2D	rnen |=3D (1 << 7);	/* RNG on */
=2D	pci_write_config_byte(dev, 0x40, rnen);
=2D
=2D	pci_read_config_byte(dev, 0x41, &rnen);
=2D	rnen |=3D (1 << 7);	/* PMIO enable */
=2D	pci_write_config_byte(dev, 0x41, rnen);
=2D
=2D	pr_info( PFX "AMD768 system management I/O registers at 0x%X.\n",
=2D			pmbase);
=2D
=2D	amd_dev =3D dev;
=2D
=2D	DPRINTK ("EXIT, returning 0\n");
=2D	return 0;
=2D
=2Derr_out:
=2D	DPRINTK ("EXIT, returning %d\n", rc);
=2D	return rc;
=2D}
=2D
=2Dstatic void amd_cleanup(void)
=2D{
=2D	u8 rnen;
=2D
=2D	pci_read_config_byte(amd_dev, 0x40, &rnen);
=2D	rnen &=3D ~(1 << 7);	/* RNG off */
=2D	pci_write_config_byte(amd_dev, 0x40, rnen);
=2D
=2D	/* FIXME: twiddle pmio, also? */
=2D}
=2D
=2D#ifdef __i386__
=2D/***********************************************************************
=2D *
=2D * VIA RNG operations
=2D *
=2D */
=2D
=2Denum {
=2D	VIA_STRFILT_CNT_SHIFT	=3D 16,
=2D	VIA_STRFILT_FAIL	=3D (1 << 15),
=2D	VIA_STRFILT_ENABLE	=3D (1 << 14),
=2D	VIA_RAWBITS_ENABLE	=3D (1 << 13),
=2D	VIA_RNG_ENABLE		=3D (1 << 6),
=2D	VIA_XSTORE_CNT_MASK	=3D 0x0F,
=2D
=2D	VIA_RNG_CHUNK_8		=3D 0x00,	/* 64 rand bits, 64 stored bits */
=2D	VIA_RNG_CHUNK_4		=3D 0x01,	/* 32 rand bits, 32 stored bits */
=2D	VIA_RNG_CHUNK_4_MASK	=3D 0xFFFFFFFF,
=2D	VIA_RNG_CHUNK_2		=3D 0x02,	/* 16 rand bits, 32 stored bits */
=2D	VIA_RNG_CHUNK_2_MASK	=3D 0xFFFF,
=2D	VIA_RNG_CHUNK_1		=3D 0x03,	/* 8 rand bits, 32 stored bits */
=2D	VIA_RNG_CHUNK_1_MASK	=3D 0xFF,
=2D};
=2D
=2Dstatic u32 via_rng_datum;
=2D
=2D/*
=2D * Investigate using the 'rep' prefix to obtain 32 bits of random data
=2D * in one insn.  The upside is potentially better performance.  The
=2D * downside is that the instruction becomes no longer atomic.  Due to
=2D * this, just like familiar issues with /dev/random itself, the worst
=2D * case of a 'rep xstore' could potentially pause a cpu for an
=2D * unreasonably long time.  In practice, this condition would likely
=2D * only occur when the hardware is failing.  (or so we hope :))
=2D *
=2D * Another possible performance boost may come from simply buffering
=2D * until we have 4 bytes, thus returning a u32 at a time,
=2D * instead of the current u8-at-a-time.
=2D */
=2D
=2Dstatic inline u32 xstore(u32 *addr, u32 edx_in)
=2D{
=2D	u32 eax_out;
=2D
=2D	asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=3D%0) */"
=2D		:"=3Dm"(*addr), "=3Da"(eax_out)
=2D		:"D"(addr), "d"(edx_in));
=2D
=2D	return eax_out;
=2D}
=2D
=2Dstatic unsigned int via_data_present(void)
=2D{
=2D	u32 bytes_out;
=2D
=2D	/* We choose the recommended 1-byte-per-instruction RNG rate,
=2D	 * for greater randomness at the expense of speed.  Larger
=2D	 * values 2, 4, or 8 bytes-per-instruction yield greater
=2D	 * speed at lesser randomness.
=2D	 *
=2D	 * If you change this to another VIA_CHUNK_n, you must also
=2D	 * change the ->n_bytes values in rng_vendor_ops[] tables.
=2D	 * VIA_CHUNK_8 requires further code changes.
=2D	 *
=2D	 * A copy of MSR_VIA_RNG is placed in eax_out when xstore
=2D	 * completes.
=2D	 */
=2D	via_rng_datum =3D 0; /* paranoia, not really necessary */
=2D	bytes_out =3D xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_=
MASK;
=2D	if (bytes_out =3D=3D 0)
=2D		return 0;
=2D
=2D	return 1;
=2D}
=2D
=2Dstatic u32 via_data_read(void)
=2D{
=2D	return via_rng_datum;
=2D}
=2D
=2Dstatic int __init via_init(struct pci_dev *dev)
=2D{
=2D	u32 lo, hi, old_lo;
=2D
=2D	/* Control the RNG via MSR.  Tread lightly and pay very close
=2D	 * close attention to values written, as the reserved fields
=2D	 * are documented to be "undefined and unpredictable"; but it
=2D	 * does not say to write them as zero, so I make a guess that
=2D	 * we restore the values we find in the register.
=2D	 */
=2D	rdmsr(MSR_VIA_RNG, lo, hi);
=2D
=2D	old_lo =3D lo;
=2D	lo &=3D ~(0x7f << VIA_STRFILT_CNT_SHIFT);
=2D	lo &=3D ~VIA_XSTORE_CNT_MASK;
=2D	lo &=3D ~(VIA_STRFILT_ENABLE | VIA_STRFILT_FAIL | VIA_RAWBITS_ENABLE);
=2D	lo |=3D VIA_RNG_ENABLE;
=2D
=2D	if (lo !=3D old_lo)
=2D		wrmsr(MSR_VIA_RNG, lo, hi);
=2D
=2D	/* perhaps-unnecessary sanity check; remove after testing if
=2D	   unneeded */
=2D	rdmsr(MSR_VIA_RNG, lo, hi);
=2D	if ((lo & VIA_RNG_ENABLE) =3D=3D 0) {
=2D		printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
=2D		return -ENODEV;
=2D	}
=2D
=2D	return 0;
=2D}
=2D
=2Dstatic void via_cleanup(void)
=2D{
=2D	/* do nothing */
=2D}
=2D#endif
=2D
=2D/***********************************************************************
=2D *
=2D * AMD Geode RNG operations
=2D *
=2D */
=2D
=2Dstatic void __iomem *geode_rng_base =3D NULL;
=2D
=2D#define GEODE_RNG_DATA_REG   0x50
=2D#define GEODE_RNG_STATUS_REG 0x54
=2D
=2Dstatic u32 geode_data_read(void)
=2D{
=2D	u32 val;
=2D
=2D	assert(geode_rng_base !=3D NULL);
=2D	val =3D readl(geode_rng_base + GEODE_RNG_DATA_REG);
=2D	return val;
=2D}
=2D
=2Dstatic unsigned int geode_data_present(void)
=2D{
=2D	u32 val;
=2D
=2D	assert(geode_rng_base !=3D NULL);
=2D	val =3D readl(geode_rng_base + GEODE_RNG_STATUS_REG);
=2D	return val;
=2D}
=2D
=2Dstatic void geode_cleanup(void)
=2D{
=2D	iounmap(geode_rng_base);
=2D  	geode_rng_base =3D NULL;
=2D}
=2D
=2Dstatic int geode_init(struct pci_dev *dev)
=2D{
=2D	unsigned long rng_base =3D pci_resource_start(dev, 0);
=2D
=2D	if (rng_base =3D=3D 0)
=2D		return 1;
=2D
=2D	geode_rng_base =3D ioremap(rng_base, 0x58);
=2D
=2D	if (geode_rng_base =3D=3D NULL) {
=2D		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
=2D		return -EBUSY;
=2D	}
=2D
=2D	return 0;
=2D}
=2D
=2D/***********************************************************************
=2D *
=2D * /dev/hwrandom character device handling (major 10, minor 183)
=2D *
=2D */
=2D
=2Dstatic int rng_dev_open (struct inode *inode, struct file *filp)
=2D{
=2D	/* enforce read-only access to this chrdev */
=2D	if ((filp->f_mode & FMODE_READ) =3D=3D 0)
=2D		return -EINVAL;
=2D	if (filp->f_mode & FMODE_WRITE)
=2D		return -EINVAL;
=2D
=2D	return 0;
=2D}
=2D
=2D
=2Dstatic ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t=
 size,
=2D				loff_t * offp)
=2D{
=2D	static DEFINE_SPINLOCK(rng_lock);
=2D	unsigned int have_data;
=2D	u32 data =3D 0;
=2D	ssize_t ret =3D 0;
=2D
=2D	while (size) {
=2D		spin_lock(&rng_lock);
=2D
=2D		have_data =3D 0;
=2D		if (rng_ops->data_present()) {
=2D			data =3D rng_ops->data_read();
=2D			have_data =3D rng_ops->n_bytes;
=2D		}
=2D
=2D		spin_unlock (&rng_lock);
=2D
=2D		while (have_data && size) {
=2D			if (put_user((u8)data, buf++)) {
=2D				ret =3D ret ? : -EFAULT;
=2D				break;
=2D			}
=2D			size--;
=2D			ret++;
=2D			have_data--;
=2D			data>>=3D8;
=2D		}
=2D
=2D		if (filp->f_flags & O_NONBLOCK)
=2D			return ret ? : -EAGAIN;
=2D
=2D		if(need_resched())
=2D			schedule_timeout_interruptible(1);
=2D		else
=2D			udelay(200);	/* FIXME: We could poll for 250uS ?? */
=2D
=2D		if (signal_pending (current))
=2D			return ret ? : -ERESTARTSYS;
=2D	}
=2D	return ret;
=2D}
=2D
=2D
=2D
=2D/*
=2D * rng_init_one - look for and attempt to init a single RNG
=2D */
=2Dstatic int __init rng_init_one (struct pci_dev *dev)
=2D{
=2D	int rc;
=2D
=2D	DPRINTK ("ENTER\n");
=2D
=2D	assert(rng_ops !=3D NULL);
=2D
=2D	rc =3D rng_ops->init(dev);
=2D	if (rc)
=2D		goto err_out;
=2D
=2D	rc =3D misc_register (&rng_miscdev);
=2D	if (rc) {
=2D		printk (KERN_ERR PFX "misc device register failed\n");
=2D		goto err_out_cleanup_hw;
=2D	}
=2D
=2D	DPRINTK ("EXIT, returning 0\n");
=2D	return 0;
=2D
=2Derr_out_cleanup_hw:
=2D	rng_ops->cleanup();
=2Derr_out:
=2D	DPRINTK ("EXIT, returning %d\n", rc);
=2D	return rc;
=2D}
=2D
=2D
=2D
=2DMODULE_AUTHOR("The Linux Kernel team");
=2DMODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
=2DMODULE_LICENSE("GPL");
=2D
=2D
=2D/*
=2D * rng_init - initialize RNG module
=2D */
=2Dstatic int __init rng_init (void)
=2D{
=2D	int rc;
=2D	struct pci_dev *pdev =3D NULL;
=2D	const struct pci_device_id *ent;
=2D
=2D	DPRINTK ("ENTER\n");
=2D
=2D	/* Probe for Intel, AMD, Geode RNGs */
=2D	for_each_pci_dev(pdev) {
=2D		ent =3D pci_match_id(rng_pci_tbl, pdev);
=2D		if (ent) {
=2D			rng_ops =3D &rng_vendor_ops[ent->driver_data];
=2D			goto match;
=2D		}
=2D	}
=2D
=2D#ifdef __i386__
=2D	/* Probe for VIA RNG */
=2D	if (cpu_has_xstore) {
=2D		rng_ops =3D &rng_vendor_ops[rng_hw_via];
=2D		pdev =3D NULL;
=2D		goto match;
=2D	}
=2D#endif
=2D
=2D	DPRINTK ("EXIT, returning -ENODEV\n");
=2D	return -ENODEV;
=2D
=2Dmatch:
=2D	rc =3D rng_init_one (pdev);
=2D	if (rc)
=2D		return rc;
=2D
=2D	pr_info( RNG_DRIVER_NAME " loaded\n");
=2D
=2D	DPRINTK ("EXIT, returning 0\n");
=2D	return 0;
=2D}
=2D
=2D
=2D/*
=2D * rng_init - shutdown RNG module
=2D */
=2Dstatic void __exit rng_cleanup (void)
=2D{
=2D	DPRINTK ("ENTER\n");
=2D
=2D	misc_deregister (&rng_miscdev);
=2D
=2D	if (rng_ops->cleanup)
=2D		rng_ops->cleanup();
=2D
=2D	DPRINTK ("EXIT\n");
=2D}
=2D
=2D
=2Dmodule_init (rng_init);
=2Dmodule_exit (rng_cleanup);
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/Kconfig linux-2.6.16-rc5-mm1/drivers/char/Kconfig
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/Kconfig	2006-03-01 13:18:58.00=
0000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/Kconfig	2006-03-01 13:48:16.000000000=
 +0100
@@ -652,20 +652,7 @@
=20
 	  If you're not sure, say N.
=20
=2Dconfig HW_RANDOM
=2D	tristate "Intel/AMD/VIA HW Random Number Generator support"
=2D	depends on (X86 || IA64) && PCI
=2D	---help---
=2D	  This driver provides kernel-side support for the Random Number
=2D	  Generator hardware found on Intel i8xx-based motherboards,
=2D	  AMD 76x-based motherboards, and Via Nehemiah CPUs.
=2D
=2D	  Provides a character driver, used to read() entropy data.
=2D
=2D	  To compile this driver as a module, choose M here: the
=2D	  module will be called hw_random.
=2D
=2D	  If unsure, say N.
+source "drivers/char/hw_random/Kconfig"
=20
 config NVRAM
 	tristate "/dev/nvram support"
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/drivers/char/Makefile linux-2.6.16-rc5-mm1/drivers/char/Makefile
=2D-- linux-2.6.16-rc5-mm1.orig/drivers/char/Makefile	2006-03-01 13:18:57.0=
00000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/char/Makefile	2006-03-01 13:27:47.00000000=
0 +0100
@@ -74,7 +74,7 @@
 obj-$(CONFIG_TOSHIBA) +=3D toshiba.o
 obj-$(CONFIG_I8K) +=3D i8k.o
 obj-$(CONFIG_DS1620) +=3D ds1620.o
=2Dobj-$(CONFIG_HW_RANDOM) +=3D hw_random.o
+obj-$(CONFIG_HW_RANDOM) +=3D hw_random/
 obj-$(CONFIG_FTAPE) +=3D ftape/
 obj-$(CONFIG_COBALT_LCD) +=3D lcd.o
 obj-$(CONFIG_PPDEV) +=3D ppdev.o
diff -urNX linux-2.6.16-rc5-mm1/Documentation/dontdiff linux-2.6.16-rc5-mm1=
=2Eorig/include/linux/hw_random.h linux-2.6.16-rc5-mm1/include/linux/hw_ran=
dom.h
=2D-- linux-2.6.16-rc5-mm1.orig/include/linux/hw_random.h	1970-01-01 01:00:=
00.000000000 +0100
+++ linux-2.6.16-rc5-mm1/include/linux/hw_random.h	2006-03-01 14:12:54.0000=
00000 +0100
@@ -0,0 +1,44 @@
+/*
+	Hardware Random Number Generator
+
+	Please read Documentation/hw_random.txt for details on use.
+
+	----------------------------------------------------------
+	This software may be used and distributed according to the terms
+        of the GNU General Public License, incorporated herein by referenc=
e.
+
+ */
+
+#ifndef LINUX_HWRANDOM_H_
+#define LINUX_HWRANDOM_H_
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+struct pci_dev;
+
+struct hwrng {
+	/** Unique name. */
+	const char *name;
+
+	/** Initialization callback. */
+	int (*init) (struct hwrng *rng);
+	/** Cleanup callback. */
+	void (*cleanup) (struct hwrng *rng);
+	/** Is the RNG able to provide data now? */
+	int (*data_present) (struct hwrng *rng);
+	/** Read data from the RNG device.
+	  * Returns the number of random bytes in data.
+	  */
+	int (*data_read) (struct hwrng *rng, u32 *data);
+	/** Private data, for use by the RNG driver. */
+	unsigned long priv;
+
+	/* internal. */
+	struct list_head list;
+};
+
+extern int hwrng_register(struct hwrng *rng);
+extern void hwrng_unregister(struct hwrng *rng);
+
+#endif /* LINUX_HWRANDOM_H_ */


=2D-=20
Greetings Michael.

--nextPart6759086.XHRdj0l7Cc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBZ9rlb09HEdWDKgRAsEkAJ9AY08yVY4SKGtTFuF3HB6uGE7SMgCfW361
HZIq6EHU2YC5KDjFJsyVb1E=
=ZEql
-----END PGP SIGNATURE-----

--nextPart6759086.XHRdj0l7Cc--
