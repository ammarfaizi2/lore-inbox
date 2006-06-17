Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWFQSel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWFQSel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFQSel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:34:41 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:57201 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750823AbWFQSek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:34:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sZG7Vo3Q9tDxv6WP1WsGoZGkEMs5Hlsskg9IaKFgZAQ/Upf+EC+hTMGOAC+n0Va+R7yiuHbIBuT4/yAMTCy06kcc54BJTI9jxw3jP7RFUjqBCgWPyx4AKq2yI9ZfpEfW2izBsr7kj3q3hgjuyL42oe5T9KiE2dGhOVchLJPkI2s=
Message-ID: <44944B3D.8040604@gmail.com>
Date: Sat, 17 Jun 2006 12:34:37 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 13/20] chardev: GPIO for SCx200 & PC-8736x:  add new pc8736x_gpio
 module
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

13/20. patch.add-pc8736x-gpio

Add the brand new pc8736x_gpio driver.  This is mostly based upon
scx200_gpio.c, but the platform_dev is treated separately, since its
fairly big too.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.add-pc8736x-gpio
 Makefile       |    2 
 nsc_gpio.c     |    1 
 pc8736x_gpio.c |  295 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+), 2 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-12/drivers/char/Makefile ax-13/drivers/char/Makefile
--- ax-12/drivers/char/Makefile	2006-06-17 01:27:04.000000000 -0600
+++ ax-13/drivers/char/Makefile	2006-06-17 01:39:58.000000000 -0600
@@ -81,7 +81,7 @@ obj-$(CONFIG_COBALT_LCD)	+= lcd.o
 obj-$(CONFIG_PPDEV)		+= ppdev.o
 obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
 obj-$(CONFIG_NWFLASH)		+= nwflash.o
-obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o nsc_gpio.o
+obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o nsc_gpio.o pc8736x_gpio.o
 obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio.o
 obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
diff -ruNp -X dontdiff -X exclude-diffs ax-12/drivers/char/nsc_gpio.c ax-13/drivers/char/nsc_gpio.c
--- ax-12/drivers/char/nsc_gpio.c	2006-06-17 01:36:56.000000000 -0600
+++ ax-13/drivers/char/nsc_gpio.c	2006-06-17 01:39:58.000000000 -0600
@@ -77,7 +77,6 @@ ssize_t nsc_gpio_write(struct file *file
 			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
 			amp->gpio_config(m, ~4, 0);
 			break;
-
 		case 'v':
 			/* View Current pin settings */
 			amp->gpio_dump(m);
diff -ruNp -X dontdiff -X exclude-diffs ax-12/drivers/char/pc8736x_gpio.c ax-13/drivers/char/pc8736x_gpio.c
--- ax-12/drivers/char/pc8736x_gpio.c	1969-12-31 17:00:00.000000000 -0700
+++ ax-13/drivers/char/pc8736x_gpio.c	2006-06-17 01:39:58.000000000 -0600
@@ -0,0 +1,295 @@
+/* linux/drivers/char/pc8736x_gpio.c
+
+   National Semiconductor PC8736x GPIO driver.  Allows a user space
+   process to play with the GPIO pins.
+
+   Copyright (c) 2005 Jim Cromie <jim.cromie@gmail.com>
+
+   adapted from linux/drivers/char/scx200_gpio.c
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>,
+*/
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/nsc_gpio.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define NAME "pc8736x_gpio"
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 GPIO Pin Driver");
+MODULE_LICENSE("GPL");
+
+static int major = 0;		/* default to dynamic major */
+module_param(major, int, 0);
+MODULE_PARM_DESC(major, "Major device number");
+
+static DEFINE_SPINLOCK(pc8736x_gpio_config_lock);
+static unsigned pc8736x_gpio_base;
+
+#define SIO_BASE1       0x2E	/* 1st command-reg to check */
+#define SIO_BASE2       0x4E	/* alt command-reg to check */
+#define SIO_BASE_OFFSET 0x20
+
+#define SIO_SID		0x20	/* SuperI/O ID Register */
+#define SIO_SID_VALUE	0xe9	/* Expected value in SuperI/O ID Register */
+
+#define SIO_CF1		0x21	/* chip config, bit0 is chip enable */
+
+#define SIO_UNIT_SEL	0x7	/* unit select reg */
+#define SIO_UNIT_ACT	0x30	/* unit enable */
+#define SIO_GPIO_UNIT	0x7	/* unit number of GPIO */
+#define SIO_VLM_UNIT	0x0D
+#define SIO_TMS_UNIT	0x0E
+
+/* config-space addrs to read/write each unit's runtime addr */
+#define SIO_BASE_HADDR		0x60
+#define SIO_BASE_LADDR		0x61
+
+/* GPIO config-space pin-control addresses */
+#define SIO_GPIO_PIN_SELECT	0xF0
+#define SIO_GPIO_PIN_CONFIG     0xF1
+#define SIO_GPIO_PIN_EVENT      0xF2
+
+static unsigned char superio_cmd = 0;
+static unsigned char selected_device = 0xFF;	/* bogus start val */
+
+/* GPIO port runtime access, functionality */
+static int port_offset[] = { 0, 4, 8, 10 };	/* non-uniform offsets ! */
+/* static int event_capable[] = { 1, 1, 0, 0 };   ports 2,3 are hobbled */
+
+#define PORT_OUT	0
+#define PORT_IN		1
+#define PORT_EVT_EN	2
+#define PORT_EVT_STST	3
+
+static inline void superio_outb(int addr, int val)
+{
+	outb_p(addr, superio_cmd);
+	outb_p(val, superio_cmd + 1);
+}
+
+static inline int superio_inb(int addr)
+{
+	outb_p(addr, superio_cmd);
+	return inb_p(superio_cmd + 1);
+}
+
+static int pc8736x_superio_present(void)
+     /* try the 2 possible values, read a hardware reg to verify */
+{
+	superio_cmd = SIO_BASE1;
+	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
+		return superio_cmd;
+
+	superio_cmd = SIO_BASE2;
+	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
+		return superio_cmd;
+
+	return 0;
+}
+
+static void device_select(unsigned devldn)
+{
+	superio_outb(SIO_UNIT_SEL, devldn);
+	selected_device = devldn;
+}
+
+static void select_pin(unsigned iminor)
+{
+	/* select GPIO port/pin from device minor number */
+	device_select(SIO_GPIO_UNIT);
+	superio_outb(SIO_GPIO_PIN_SELECT,
+		     ((iminor << 1) & 0xF0) | (iminor & 0x7));
+}
+
+static inline u32 pc8736x_gpio_configure_fn(unsigned index, u32 mask, u32 bits,
+					    u32 func_slct)
+{
+	u32 config, new_config;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pc8736x_gpio_config_lock, flags);
+
+	device_select(SIO_GPIO_UNIT);
+	select_pin(index);
+
+	/* read current config value */
+	config = superio_inb(func_slct);
+
+	/* set new config */
+	new_config = (config & mask) | bits;
+	superio_outb(func_slct, new_config);
+
+	spin_unlock_irqrestore(&pc8736x_gpio_config_lock, flags);
+
+	return config;
+}
+
+static u32 pc8736x_gpio_configure(unsigned index, u32 mask, u32 bits)
+{
+	return pc8736x_gpio_configure_fn(index, mask, bits,
+					 SIO_GPIO_PIN_CONFIG);
+}
+
+static int pc8736x_gpio_get(unsigned minor)
+{
+	int port, bit, val;
+
+	port = minor >> 3;
+	bit = minor & 7;
+	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
+	val >>= bit;
+	val &= 1;
+
+	printk(KERN_INFO NAME ": _gpio_get(%d from %x bit %d) == val %d\n",
+	       minor, pc8736x_gpio_base + port_offset[port] + PORT_IN, bit,
+	       val);
+
+	return val;
+}
+
+static void pc8736x_gpio_set(unsigned minor, int val)
+{
+	int port, bit, curval;
+
+	minor &= 0x1f;
+	port = minor >> 3;
+	bit = minor & 7;
+	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+
+	printk(KERN_INFO NAME
+	       ": addr:%x cur:%x bit-pos:%d cur-bit:%x + new:%d -> bit-new:%d\n",
+	       pc8736x_gpio_base + port_offset[port] + PORT_OUT,
+	       curval, bit, (curval & ~(1 << bit)), val, (val << bit));
+
+	val = (curval & ~(1 << bit)) | (val << bit);
+
+	printk(KERN_INFO NAME ": gpio_set(minor:%d port:%d bit:%d"
+	       ") %2x -> %2x\n", minor, port, bit, curval, val);
+
+	outb_p(val, pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+
+	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
+
+	printk(KERN_INFO NAME ": wrote %x, read: %x\n", curval, val);
+}
+
+static void pc8736x_gpio_set_high(unsigned index)
+{
+	pc8736x_gpio_set(index, 1);
+}
+
+static void pc8736x_gpio_set_low(unsigned index)
+{
+	pc8736x_gpio_set(index, 0);
+}
+
+static int pc8736x_gpio_current(unsigned index)
+{
+	printk(KERN_WARNING NAME ": pc8736x_gpio_current unimplemented\n");
+	return 0;
+}
+
+static void pc8736x_gpio_change(unsigned index)
+{
+	pc8736x_gpio_set(index, !pc8736x_gpio_get(index));
+}
+
+extern void nsc_gpio_dump(unsigned iminor);
+
+static struct nsc_gpio_ops pc8736x_access = {
+	.owner		= THIS_MODULE,
+	.gpio_config	= pc8736x_gpio_configure,
+	.gpio_dump	= nsc_gpio_dump,
+	.gpio_get	= pc8736x_gpio_get,
+	.gpio_set	= pc8736x_gpio_set,
+	.gpio_set_high	= pc8736x_gpio_set_high,
+	.gpio_set_low	= pc8736x_gpio_set_low,
+	.gpio_change	= pc8736x_gpio_change,
+	.gpio_current	= pc8736x_gpio_current
+};
+
+static int pc8736x_gpio_open(struct inode *inode, struct file *file)
+{
+	unsigned m = iminor(inode);
+	file->private_data = &pc8736x_access;
+
+	printk(KERN_NOTICE NAME " open %d\n", m);
+
+	if (m > 63)
+		return -EINVAL;
+	return nonseekable_open(inode, file);
+}
+
+static struct file_operations pc8736x_gpio_fops = {
+	.owner = THIS_MODULE,
+	.open = pc8736x_gpio_open,
+	.write = nsc_gpio_write,
+	.read = nsc_gpio_read,
+};
+
+static int __init pc8736x_gpio_init(void)
+{
+	int r, rc;
+
+	printk(KERN_DEBUG NAME " initializing\n");
+
+	if (!pc8736x_superio_present()) {
+		printk(KERN_ERR NAME ": no device found\n");
+		return -ENODEV;
+	}
+
+	/* Verify that chip and it's GPIO unit are both enabled.
+	   My BIOS does this, so I take minimum action here
+	 */
+	rc = superio_inb(SIO_CF1);
+	if (!(rc & 0x01)) {
+		printk(KERN_ERR NAME ": device not enabled\n");
+		return -ENODEV;
+	}
+	device_select(SIO_GPIO_UNIT);
+	if (!superio_inb(SIO_UNIT_ACT)) {
+		printk(KERN_ERR NAME ": GPIO unit not enabled\n");
+		return -ENODEV;
+	}
+
+	/* read GPIO unit base address */
+	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
+			     | superio_inb(SIO_BASE_LADDR));
+
+	if (request_region(pc8736x_gpio_base, 16, NAME))
+		printk(KERN_INFO NAME ": GPIO ioport %x reserved\n",
+		       pc8736x_gpio_base);
+
+	r = register_chrdev(major, NAME, &pc8736x_gpio_fops);
+	if (r < 0) {
+		printk(KERN_ERR NAME ": unable to register character device\n");
+		return r;
+	}
+	if (!major) {
+		major = r;
+		printk(KERN_DEBUG NAME ": got dynamic major %d\n", major);
+	}
+
+	return 0;
+}
+
+static void __exit pc8736x_gpio_cleanup(void)
+{
+	printk(KERN_DEBUG NAME " cleanup\n");
+
+	release_region(pc8736x_gpio_base, 16);
+
+	unregister_chrdev(major, NAME);
+}
+
+module_init(pc8736x_gpio_init);
+module_exit(pc8736x_gpio_cleanup);


