Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVBHMdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVBHMdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVBHMdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:33:45 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:60644 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261527AbVBHMab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:30:31 -0500
Date: Tue, 8 Feb 2005 21:30:18 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc3-mm1] add TANBAC TB0219 base board driver
Message-Id: <20050208213018.3c2f3420.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds GPIO/LED/DIPSW driver for TANBAC TB0219.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Kconfig a/arch/mips/Kconfig
--- a-orig/arch/mips/Kconfig	Tue Feb  8 00:19:49 2005
+++ a/arch/mips/Kconfig	Tue Feb  8 00:53:47 2005
@@ -122,10 +122,6 @@
 	  The TANBAC TB0229 (VR4131DIMM) is a MIPS-based platform manufactured by TANBAC.
 	  Please refer to <http://www.tanbac.co.jp/> about VR4131DIMM.
 
-config TANBAC_TB0219
-	bool "Added TANBAC TB0219 Base board support"
-	depends on TANBAC_TB0229
-
 config VICTOR_MPC30X
 	bool "Support for Victor MP-C303/304"
 	select DMA_NONCOHERENT
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile a/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- a-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Thu Feb  3 10:56:11 2005
+++ a/arch/mips/vr41xx/tanbac-tb0229/Makefile	Tue Feb  8 00:53:47 2005
@@ -3,5 +3,3 @@
 #
 
 obj-y				:= setup.o
-
-obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c a/arch/mips/vr41xx/tanbac-tb0229/tb0219.c
--- a-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	Thu Feb  3 10:55:23 2005
+++ a/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	Thu Jan  1 09:00:00 1970
@@ -1,44 +0,0 @@
-/*
- *  tb0219.c, Setup for the TANBAC TB0219
- *
- *  Copyright (C) 2003  Megasolution Inc. <matsu@megasolution.jp>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/reboot.h>
-
-#define TB0219_RESET_REGS	KSEG1ADDR(0x0a00000e)
-
-#define tb0219_hard_reset()	writew(0, TB0219_RESET_REGS)
-
-static void tanbac_tb0219_restart(char *command)
-{
-	local_irq_disable();
-	tb0219_hard_reset();
-	while (1);
-}
-
-static int __init tanbac_tb0219_setup(void)
-{
-	_machine_restart = tanbac_tb0219_restart;
-
-	return 0;
-}
-
-early_initcall(tanbac_tb0219_setup);
diff -urN -X dontdiff a-orig/drivers/char/Kconfig a/drivers/char/Kconfig
--- a-orig/drivers/char/Kconfig	Tue Feb  8 00:19:53 2005
+++ a/drivers/char/Kconfig	Tue Feb  8 00:53:47 2005
@@ -835,6 +835,10 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonypi.
 
+config TANBAC_TB0219
+	tristate "TANBAC TB0219 base board support"
+	depends TANBAC_TB0229
+
 
 menu "Ftape, the floppy tape device driver"
 
diff -urN -X dontdiff a-orig/drivers/char/Makefile a/drivers/char/Makefile
--- a-orig/drivers/char/Makefile	Tue Feb  8 00:19:53 2005
+++ a/drivers/char/Makefile	Tue Feb  8 00:53:47 2005
@@ -81,6 +81,7 @@
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
+obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
 
 obj-$(CONFIG_WATCHDOG)	+= watchdog/
 obj-$(CONFIG_MWAVE) += mwave/
diff -urN -X dontdiff a-orig/drivers/char/tb0219.c a/drivers/char/tb0219.c
--- a-orig/drivers/char/tb0219.c	Thu Jan  1 09:00:00 1970
+++ a/drivers/char/tb0219.c	Tue Feb  8 21:13:24 2005
@@ -0,0 +1,347 @@
+/*
+ *  Driver for TANBAC TB0219 base board.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+#include <asm/reboot.h>
+
+MODULE_AUTHOR("Yoichi Yuasa <yuasa@hh.iij4u.or.jp>");
+MODULE_DESCRIPTION("TANBAC TB0219 base board driver");
+MODULE_LICENSE("GPL");
+
+static int major;	/* default is dynamic major device number */
+module_param(major, int, 0);
+MODULE_PARM_DESC(major, "Major device number");
+
+static void (*old_machine_restart)(char *command);
+static void __iomem *tb0219_base;
+static spinlock_t tb0219_lock;
+
+#define tb0219_read(offset)		readw(tb0219_base + (offset))
+#define tb0219_write(offset, value)	writew((value), tb0219_base + (offset))
+
+#define TB0219_START	0x0a000000UL
+#define TB0219_SIZE	0x20UL
+
+#define TB0219_LED			0x00
+#define TB0219_GPIO_INPUT		0x02
+#define TB0219_GPIO_OUTPUT		0x04
+#define TB0219_DIP_SWITCH		0x06
+#define TB0219_MISC			0x08
+#define TB0219_RESET			0x0e
+#define TB0219_PCI_SLOT1_IRQ_STATUS	0x10
+#define TB0219_PCI_SLOT2_IRQ_STATUS	0x12
+#define TB0219_PCI_SLOT3_IRQ_STATUS	0x14
+
+typedef enum {
+	TYPE_LED,
+	TYPE_GPIO_OUTPUT,
+} tb0219_type_t;
+
+/*
+ * Minor device number
+ *	 0 = 7 segment LED
+ *
+ *	16 = GPIO IN 0
+ *	17 = GPIO IN 1
+ *	18 = GPIO IN 2
+ *	19 = GPIO IN 3
+ *	20 = GPIO IN 4
+ *	21 = GPIO IN 5
+ *	22 = GPIO IN 6
+ *	23 = GPIO IN 7
+ *
+ *	32 = GPIO OUT 0
+ *	33 = GPIO OUT 1
+ *	34 = GPIO OUT 2
+ *	35 = GPIO OUT 3
+ *	36 = GPIO OUT 4
+ *	37 = GPIO OUT 5
+ *	38 = GPIO OUT 6
+ *	39 = GPIO OUT 7
+ *
+ *	48 = DIP switch 1
+ *	49 = DIP switch 2
+ *	50 = DIP switch 3
+ *	51 = DIP switch 4
+ *	52 = DIP switch 5
+ *	53 = DIP switch 6
+ *	54 = DIP switch 7
+ *	55 = DIP switch 8
+ */
+
+static inline char get_led(void)
+{
+	return (char)tb0219_read(TB0219_LED);
+}
+
+static inline char get_gpio_input_pin(unsigned int pin)
+{
+	uint16_t values;
+
+	values = tb0219_read(TB0219_GPIO_INPUT);
+	if (values & (1 << pin))
+		return '1';
+
+	return '0';
+}
+
+static inline char get_gpio_output_pin(unsigned int pin)
+{
+	uint16_t values;
+
+	values = tb0219_read(TB0219_GPIO_OUTPUT);
+	if (values & (1 << pin))
+		return '1';
+
+	return '0';
+}
+
+static inline char get_dip_switch(unsigned int pin)
+{
+	uint16_t values;
+
+	values = tb0219_read(TB0219_DIP_SWITCH);
+	if (values & (1 << pin))
+		return '1';
+
+	return '0';
+}
+
+static inline int set_led(char command)
+{
+	tb0219_write(TB0219_LED, command);
+
+	return 0;
+}
+
+static inline int set_gpio_output_pin(unsigned int pin, char command)
+{
+	unsigned long flags;
+	uint16_t value;
+
+	if (command != '0' && command != '1')
+		return -EINVAL;
+
+	spin_lock_irqsave(&tb0219_lock, flags);
+	value = tb0219_read(TB0219_GPIO_OUTPUT);
+	if (command == '0')
+		value &= ~(1 << pin);
+	else
+		value |= 1 << pin;
+	tb0219_write(TB0219_GPIO_OUTPUT, value);
+	spin_unlock_irqrestore(&tb0219_lock, flags);
+
+	return 0;
+
+}
+
+static ssize_t tanbac_tb0219_read(struct file *file, char __user *buf, size_t len,
+                                  loff_t *ppos)
+{
+	unsigned int minor;
+	char value;
+
+	minor = iminor(file->f_dentry->d_inode);
+	switch (minor) {
+	case 0:
+		value = get_led();
+		break;
+	case 16 ... 23:
+		value = get_gpio_input_pin(minor - 16);
+		break;
+	case 32 ... 39:
+		value = get_gpio_output_pin(minor - 32);
+		break;
+	case 48 ... 55:
+		value = get_dip_switch(minor - 48);
+		break;
+	default:
+		return -EBADF;
+	}
+
+	if (len <= 0)
+		return -EFAULT;
+
+	if (put_user(value, buf))
+		return -EFAULT;
+
+	return 1;
+}
+
+static ssize_t tanbac_tb0219_write(struct file *file, const char __user *data,
+                                   size_t len, loff_t *ppos)
+{
+	unsigned int minor;
+	tb0219_type_t type;
+	size_t i;
+	int retval = 0;
+	char c;
+
+	minor = iminor(file->f_dentry->d_inode);
+	switch (minor) {
+	case 0:
+		type = TYPE_LED;
+		break;
+	case 32 ... 39:
+		type = TYPE_GPIO_OUTPUT;
+		break;
+	default:
+		return -EBADF;
+	}
+
+	for (i = 0; i < len; i++) {
+		if (get_user(c, data + i))
+			return -EFAULT;
+
+		switch (type) {
+		case TYPE_LED:
+			retval = set_led(c);
+			break;
+		case TYPE_GPIO_OUTPUT:
+			retval = set_gpio_output_pin(minor - 32, c);
+			break;
+		}
+
+		if (retval < 0)
+			break;
+	}
+
+	return i;
+}
+
+static int tanbac_tb0219_open(struct inode *inode, struct file *file)
+{
+	unsigned int minor;
+
+	minor = iminor(inode);
+	switch (minor) {
+	case 0:
+	case 16 ... 23:
+	case 32 ... 39:
+	case 48 ... 55:
+		return nonseekable_open(inode, file);
+	default:
+		break;
+	}
+
+	return -EBADF;
+}
+
+static int tanbac_tb0219_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static struct file_operations tb0219_fops = {
+	.owner		= THIS_MODULE,
+	.read		= tanbac_tb0219_read,
+	.write		= tanbac_tb0219_write,
+	.open		= tanbac_tb0219_open,
+	.release	= tanbac_tb0219_release,
+};
+
+static void tb0219_restart(char *command)
+{
+	tb0219_write(TB0219_RESET, 0);
+}
+
+static int tb0219_probe(struct device *dev)
+{
+	int retval;
+
+	if (request_mem_region(TB0219_START, TB0219_SIZE, "TB0219") == NULL)
+		return -EBUSY;
+
+	tb0219_base = ioremap(TB0219_START, TB0219_SIZE);
+	if (tb0219_base == NULL) {
+		release_mem_region(TB0219_START, TB0219_SIZE);
+		return -ENOMEM;
+	}
+
+	retval = register_chrdev(major, "TB0219", &tb0219_fops);
+	if (retval < 0) {
+		iounmap(tb0219_base);
+		tb0219_base = NULL;
+		release_mem_region(TB0219_START, TB0219_SIZE);
+		return retval;
+	}
+
+	spin_lock_init(&tb0219_lock);
+
+	old_machine_restart = _machine_restart;
+	_machine_restart = tb0219_restart;
+
+	if (major == 0) {
+		major = retval;
+		printk(KERN_INFO "TB0219: major number %d\n", major);
+	}
+
+	return 0;
+}
+
+static int tb0219_remove(struct device *dev)
+{
+	_machine_restart = old_machine_restart;
+
+	iounmap(tb0219_base);
+	tb0219_base = NULL;
+
+	release_mem_region(TB0219_START, TB0219_SIZE);
+
+	return 0;
+}
+
+static struct platform_device *tb0219_platform_device;
+
+static struct device_driver tb0219_device_driver = {
+	.name		= "TB0219",
+	.bus		= &platform_bus_type,
+	.probe		= tb0219_probe,
+	.remove		= tb0219_remove,
+};
+
+static int __devinit tanbac_tb0219_init(void)
+{
+	int retval;
+
+	tb0219_platform_device = platform_device_register_simple("TB0219", -1, NULL, 0);
+	if (IS_ERR(tb0219_platform_device))
+		return PTR_ERR(tb0219_platform_device);
+
+	retval = driver_register(&tb0219_device_driver);
+	if (retval < 0)
+		platform_device_unregister(tb0219_platform_device);
+
+	return retval;
+}
+
+static void __devexit tanbac_tb0219_exit(void)
+{
+	driver_unregister(&tb0219_device_driver);
+
+	platform_device_unregister(tb0219_platform_device);
+}
+
+module_init(tanbac_tb0219_init);
+module_exit(tanbac_tb0219_exit);
