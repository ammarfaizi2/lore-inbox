Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVLGRdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVLGRdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVLGRdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:33:06 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:42690 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751262AbVLGRdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:33:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=PaCwtySWvRIaNSv1EYQwzcHh/g9SeTG0LS7Q5TqQyKoGvwCtOVinm1g/bdr0zR8/iVKjsF1qJt8UgXChkPqDQXo2gAjcxlgcfawhJoLIdn6wdQwgTviMPiiIiyXBnm5lfU4UVDx0UOI86jBoj9C1pL4S3zW+WJFka8fM0DFS+x8=
Message-ID: <808c8e9d0512070933re472072x43f35d454be699f1@mail.gmail.com>
Date: Wed, 7 Dec 2005 11:33:04 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] i386: CS5535 chip support - GPIO
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1960_10976397.1133976784559"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1960_10976397.1133976784559
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Provides a simple GPIO char driver for the AMD CS5535, modeled after
the scx200_gpio driver.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>

------=_Part_1960_10976397.1133976784559
Content-Type: text/plain; name=cs5535-gpio.patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cs5535-gpio.patch.txt"

 drivers/char/Kconfig       |    9 +
 drivers/char/Makefile      |    1 
 drivers/char/cs5535_gpio.c |  209 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

Index: linux-2.6.14/drivers/char/cs5535_gpio.c
===================================================================
--- /dev/null
+++ linux-2.6.14/drivers/char/cs5535_gpio.c
@@ -0,0 +1,209 @@
+/*
+ * linux/drivers/char/cs5535_gpio.c
+ *
+ * AMD CS5535 GPIO driver.
+ * Allows a user space process to play with the GPIO pins.
+ *
+ * Heavily inspired by scx200_gpio, by Christer Weinigel
+ *
+ * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the smems of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cdev.h>
+#include <linux/ioport.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+
+#define NAME			"cs5535_gpio"
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("AMD CS5535 GPIO Pin Driver");
+MODULE_LICENSE("GPL");
+
+static int major = 0;		/* default to dynamic major */
+module_param(major, int, 0);
+MODULE_PARM_DESC(major, "Major device number");
+
+/* These are defined in cs5535.c */
+extern u32 cs5535_gpio_base;
+extern u32 cs5535_gpio_mask;
+
+static struct cdev cs5535_gpio_cdev;
+
+/* reserve 32 entries even though some aren't usable */
+#define CS5535_GPIO_COUNT	32
+
+/* IO block size */
+#define CS5535_GPIO_SIZE	256
+
+struct gpio_regmap {
+	u32 rd_offset;
+	u32 wr_offset;
+	char on;
+	char off;
+};
+static struct gpio_regmap rm[] =
+{
+	{ 0x30, 0x00, '1', '0' },	/* GPIOx_READ_BACK / GPIOx_OUT_VAL */
+	{ 0x20, 0x20, 'I', 'i' },	/* GPIOx_IN_EN */
+	{ 0x04, 0x04, 'O', 'o' },	/* GPIOx_OUT_EN */
+	{ 0x08, 0x08, 't', 'T' },	/* GPIOx_OUT_OD_EN */
+	{ 0x18, 0x18, 'P', 'p' },	/* GPIOL_OUT_PU_EN */
+	{ 0x1c, 0x1c, 'D', 'd' },	/* GPIOx_OUT_PD_EN */
+};
+
+
+/**
+ * Gets the register offset for the GPIO bank.
+ * Low (0-15) starts at 0x00, high (16-31) starts at 0x80
+ */
+static inline u32 cs5535_lowhigh_base(int reg)
+{
+	return (reg & 0x10) << 3;
+}
+
+static ssize_t cs5535_gpio_write(struct file *file, const char __user *data,
+				 size_t len, loff_t *ppos)
+{
+	u32	m = iminor(file->f_dentry->d_inode);
+	int	i, j;
+	u32	base = cs5535_gpio_base + cs5535_lowhigh_base(m);
+	u32	m0, m1;
+	char	c;
+
+	/**
+	 * Creates the mask for atomic bit programming.
+	 * The high 16 bits and the low 16 bits are used to set the mask.
+	 * For example, GPIO 15 maps to 31,15: 0,1 => On; 1,0=> Off
+	 */
+	m1 = 1 << (m & 0x0F);
+	m0 = m1 << 16;
+
+	for (i = 0; i < len; ++i) {
+		if (get_user(c, data+i))
+			return -EFAULT;
+
+		for (j = 0; j < ARRAY_SIZE(rm); j++) {
+			if (c == rm[j].on) {
+				outl(m1, base + rm[j].wr_offset);
+				break;
+			} else if (c == rm[j].off) {
+				outl(m0, base + rm[j].wr_offset);
+				break;
+			}
+		}
+	}
+	*ppos = 0;
+	return len;
+}
+
+static ssize_t cs5535_gpio_read(struct file *file, char __user *buf,
+				size_t len, loff_t *ppos)
+{
+	u32	m = iminor(file->f_dentry->d_inode);
+	u32	base = cs5535_gpio_base + cs5535_lowhigh_base(m);
+	int	mask = 1 << (m & 0x0f);
+	int	i;
+	char	ch;
+	ssize_t	count = 0;
+
+	if (*ppos >= ARRAY_SIZE(rm))
+		return 0;
+
+	for (i = *ppos; (i < (*ppos + len)) && (i < ARRAY_SIZE(rm)); i++) {
+		ch = (inl(base + rm[i].rd_offset) & mask) ?
+		     rm[i].on : rm[i].off;
+
+		if (put_user(ch, buf+count))
+			return -EFAULT;
+
+		count++;
+	}
+
+	/* add a line-feed if there is room */
+	if ((i == ARRAY_SIZE(rm)) && (count < len)) {
+		put_user('\n', buf + count);
+		count++;
+	}
+
+	*ppos += count;
+	return count;
+}
+
+static int cs5535_gpio_open(struct inode *inode, struct file *file)
+{
+	u32 m = iminor(inode);
+
+	/* the mask says which pins are usable by this driver */
+	if ((cs5535_gpio_mask & (1 << m)) == 0)
+		return -EINVAL;
+
+	return nonseekable_open(inode, file);
+}
+
+static struct file_operations cs5535_gpio_fops = {
+	.owner	= THIS_MODULE,
+	.write	= cs5535_gpio_write,
+	.read	= cs5535_gpio_read,
+	.open	= cs5535_gpio_open
+};
+
+static int __init cs5535_gpio_init(void)
+{
+	dev_t dev_id;
+	int retval;
+
+	if (cs5535_gpio_base == 0) {
+		printk(KERN_WARNING NAME ": GPIO not available\n");
+		return -ENODEV;
+	}
+
+	if (request_region(cs5535_gpio_base, CS5535_GPIO_SIZE, NAME) == 0) {
+		printk(KERN_ERR NAME ": can't allocate I/O for GPIO\n");
+		return -ENODEV;
+	}
+
+	printk(KERN_DEBUG NAME ": AMD CS5535 GPIO Driver: mask=%x\n",
+	       cs5535_gpio_mask);
+
+	if (major) {
+		dev_id = MKDEV(major, 0);
+		retval = register_chrdev_region(dev_id, CS5535_GPIO_COUNT,
+						NAME);
+	} else {
+		retval = alloc_chrdev_region(&dev_id, 0, CS5535_GPIO_COUNT,
+					     NAME);
+		major = MAJOR(dev_id);
+	}
+
+	if (retval) {
+		release_region(cs5535_gpio_base, CS5535_GPIO_SIZE);
+		return -1;
+	}
+
+	cdev_init(&cs5535_gpio_cdev, &cs5535_gpio_fops);
+	cdev_add(&cs5535_gpio_cdev, dev_id, CS5535_GPIO_COUNT);
+
+	return 0;
+}
+
+static void __exit cs5535_gpio_cleanup(void)
+{
+	dev_t dev_id = MKDEV(major, 0);
+	unregister_chrdev_region(dev_id, CS5535_GPIO_COUNT);
+	release_region(cs5535_gpio_base, CS5535_GPIO_SIZE);
+}
+
+module_init(cs5535_gpio_init);
+module_exit(cs5535_gpio_cleanup);
Index: linux-2.6.14/drivers/char/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/char/Kconfig
+++ linux-2.6.14/drivers/char/Kconfig
@@ -936,6 +936,15 @@ config SCx200_GPIO
 
 	  If compiled as a module, it will be called scx200_gpio.
 
+config CS5535_GPIO
+	tristate "AMD CS5535 GPIO (Geode GX)"
+	depends on CS5535
+	help
+	  Give userspace access to the GPIO pins on the AMD CS5535 Geode GX
+	  companion device.
+
+	  If compiled as a module, it will be called cs5535_gpio.
+
 config GPIO_VR41XX
 	tristate "NEC VR4100 series General-purpose I/O Unit support"
 	depends on CPU_VR41XX
Index: linux-2.6.14/drivers/char/Makefile
===================================================================
--- linux-2.6.14.orig/drivers/char/Makefile
+++ linux-2.6.14/drivers/char/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
+obj-$(CONFIG_CS5535_GPIO) += cs5535_gpio.o
 obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
 obj-$(CONFIG_TELCLOCK) += tlclk.o

------=_Part_1960_10976397.1133976784559--
