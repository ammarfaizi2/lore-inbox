Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVLMRFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVLMRFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVLMRFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:05:09 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:2257 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964946AbVLMRFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:05:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=NA70+EuyRlaIVs6urR67coL0lKLqRRCIax/U9wUspZXMVWrxzVkswSqZneZJJNznPgV3ylREeBR9xRPlrzR3fsMx0bTpzuF4XLhfm4XViLCWkd9aF0HqgVqRvlRxPzhwYVBCjEwZy+z9KlmQXs2rtqJ5mtOuqlYRQKVjoRqwOMc=
Message-ID: <808c8e9d0512130904j5f202f7cwe0d195efb12afad0@mail.gmail.com>
Date: Tue, 13 Dec 2005 11:05:02 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386: GPIO driver for AMD CS5535/CS5536
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33415_17999223.1134493502326"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_33415_17999223.1134493502326
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A simple driver for the CS5535 and CS5536 that allows a user-space
program to manipulate GPIO pins.
The CS5535/CS5536 chips are Geode processor companion devices.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
---
Andrew,

This patch assumes that my previous cs5535-gpio patch has been
deleted, which I see you have already done.
I dropped the cs5535-cpu patch because the root cause looks like a BIOS bug=
.
I will work the SMBus driver with Jean on the lm-sensors mailing list.

Thanks,
Ben

------=_Part_33415_17999223.1134493502326
Content-Type: text/plain; name=cs5535-gpio.patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cs5535-gpio.patch.txt"

 drivers/char/Kconfig       |    8 +
 drivers/char/Makefile      |    1 
 drivers/char/cs5535_gpio.c |  250 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h    |    1 
 4 files changed, 260 insertions(+)

--- /dev/null
+++ linux-2.6.15-rc5-mm1/drivers/char/cs5535_gpio.c
@@ -0,0 +1,250 @@
+/*
+ * AMD CS5535/CS5536 GPIO driver.
+ * Allows a user space process to play with the GPIO pins.
+ *
+ * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the smems of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cdev.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+
+#define NAME			"cs5535_gpio"
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("AMD CS5535/CS5536 GPIO Pin Driver");
+MODULE_LICENSE("GPL");
+
+static int major;
+module_param(major, int, 0);
+MODULE_PARM_DESC(major, "Major device number");
+
+static ulong mask;
+module_param(mask, ulong, 0);
+MODULE_PARM_DESC(mask, "GPIO channel mask");
+
+#define MSR_LBAR_GPIO		0x5140000C
+
+static u32 gpio_base;
+
+static struct pci_device_id divil_pci[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) },
+	{ } /* NULL entry */
+};
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
+	u32	rd_offset;
+	u32	wr_offset;
+	char	on;
+	char	off;
+};
+static struct gpio_regmap rm[] =
+{
+	{ 0x30, 0x00, '1', '0' },	/* GPIOx_READ_BACK / GPIOx_OUT_VAL */
+	{ 0x20, 0x20, 'I', 'i' },	/* GPIOx_IN_EN */
+	{ 0x04, 0x04, 'O', 'o' },	/* GPIOx_OUT_EN */
+	{ 0x08, 0x08, 't', 'T' },	/* GPIOx_OUT_OD_EN */
+	{ 0x18, 0x18, 'P', 'p' },	/* GPIOx_OUT_PU_EN */
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
+	u32	base = gpio_base + cs5535_lowhigh_base(m);
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
+	u32	base = gpio_base + cs5535_lowhigh_base(m);
+	int	rd_bit = 1 << (m & 0x0f);
+	int	i;
+	char	ch;
+	ssize_t	count = 0;
+
+	if (*ppos >= ARRAY_SIZE(rm))
+		return 0;
+
+	for (i = *ppos; (i < (*ppos + len)) && (i < ARRAY_SIZE(rm)); i++) {
+		ch = (inl(base + rm[i].rd_offset) & rd_bit) ?
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
+	if ((mask & (1 << m)) == 0)
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
+	dev_t	dev_id;
+	u32	low, hi;
+	int	retval;
+
+	if (pci_dev_present(divil_pci) == 0) {
+		printk(KERN_WARNING NAME ": DIVIL not found\n");
+		return -ENODEV;
+	}
+
+	/* Grab the GPIO I/O range */
+	rdmsr(MSR_LBAR_GPIO, low, hi);
+
+	/* Check the mask and whether GPIO is enabled (sanity check) */
+	if (hi != 0x0000f001) {
+		printk(KERN_WARNING NAME ": GPIO not enabled\n");
+		return -ENODEV;
+	}
+
+	/* Mask off the IO base address */
+	gpio_base = low & 0x0000ff00;
+
+	/**
+	 * Some GPIO pins
+	 *  31-29,23 : reserved (always mask out)
+	 *  28       : Power Button
+	 *  26       : PME#
+	 *  22-16    : LPC
+	 *  14,15    : SMBus
+	 *  9,8      : UART1
+	 *  7        : PCI INTB
+	 *  3,4      : UART2/DDC
+	 *  2        : IDE_IRQ0
+	 *  0        : PCI INTA
+	 *
+	 * If a mask was not specified, be conservative and only allow:
+	 *  1,2,5,6,10-13,24,25,27
+	 */
+	if (mask != 0)
+		mask &= 0x1f7fffff;
+	else
+		mask = 0x0b003c66;
+
+	if (request_region(gpio_base, CS5535_GPIO_SIZE, NAME) == 0) {
+		printk(KERN_ERR NAME ": can't allocate I/O for GPIO\n");
+		return -ENODEV;
+	}
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
+		release_region(gpio_base, CS5535_GPIO_SIZE);
+		return -1;
+	}
+
+	printk(KERN_DEBUG NAME ": base=%#x mask=%#lx major=%d\n",
+	       gpio_base, mask, major);
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
+	if (gpio_base != 0)
+		release_region(gpio_base, CS5535_GPIO_SIZE);
+}
+
+module_init(cs5535_gpio_init);
+module_exit(cs5535_gpio_cleanup);
--- linux-2.6.15-rc5-mm1.orig/drivers/char/Kconfig
+++ linux-2.6.15-rc5-mm1/drivers/char/Kconfig
@@ -936,6 +936,14 @@ config SCx200_GPIO
 
 	  If compiled as a module, it will be called scx200_gpio.
 
+config CS5535_GPIO
+	tristate "AMD CS5535/CS5536 GPIO (Geode Companion Device)"
+	help
+	  Give userspace access to the GPIO pins on the AMD CS5535 and
+	  CS5536 Geode companion devices.
+
+	  If compiled as a module, it will be called cs5535_gpio.
+
 config GPIO_VR41XX
 	tristate "NEC VR4100 series General-purpose I/O Unit support"
 	depends on CPU_VR41XX
--- linux-2.6.15-rc5-mm1.orig/drivers/char/Makefile
+++ linux-2.6.15-rc5-mm1/drivers/char/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
+obj-$(CONFIG_CS5535_GPIO) += cs5535_gpio.o
 obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
 obj-$(CONFIG_TELCLOCK) += tlclk.o
--- linux-2.6.15-rc5-mm1.orig/include/linux/pci_ids.h
+++ linux-2.6.15-rc5-mm1/include/linux/pci_ids.h
@@ -376,6 +376,7 @@
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
 #define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_83820		0x0022
+#define PCI_DEVICE_ID_NS_CS5535_ISA	0x002b
 #define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 #define PCI_DEVICE_ID_NS_CS5535_AUDIO	0x002e
 #define PCI_DEVICE_ID_NS_CS5535_USB	0x002f




------=_Part_33415_17999223.1134493502326--
