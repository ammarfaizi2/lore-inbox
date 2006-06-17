Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWFQSfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWFQSfr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFQSfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:35:47 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:22899 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750816AbWFQSfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:35:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rBPa0HB3ksbIUZZXkhLS0bV52stHlyLZA286TidaIzFX1nwuuqZTT9Y65r9LW3QWRTIcVY55GJAiQ55ZBEnPodQ6XQRlTpzYKN1K9U/YfRlbBcHPtM7MfcMNRE8upr5qaXbkL5T/qESlWgyTPWI39kQyiOeGxOkfUdQneAoETdU=
Message-ID: <44944B7F.8070104@gmail.com>
Date: Sat, 17 Jun 2006 12:35:43 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 14/20] chardev: GPIO for SCx200 & PC-8736x: add platform_device
 for use w dev_dbg
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

14/20. patch.pdev-pc8736x

Adds platform-device to (just introduced) driver, and uses it to
replace many printks with dev_dbg() etc.  This could trivially be
merged into previous patch, but this way matches better with the
corresponding patch that does the same change to scx200_gpio.


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.pdev-pc8736x
 pc8736x_gpio.c |   76 +++++++++++++++++++++++++++++++++------------------------
 1 files changed, 45 insertions(+), 31 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-13/drivers/char/pc8736x_gpio.c ax-14/drivers/char/pc8736x_gpio.c
--- ax-13/drivers/char/pc8736x_gpio.c	2006-06-17 01:39:58.000000000 -0600
+++ ax-14/drivers/char/pc8736x_gpio.c	2006-06-17 01:42:57.000000000 -0600
@@ -17,13 +17,14 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/nsc_gpio.h>
+#include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-#define NAME "pc8736x_gpio"
+#define DEVNAME "pc8736x_gpio"
 
 MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
-MODULE_DESCRIPTION("NatSemi SCx200 GPIO Pin Driver");
+MODULE_DESCRIPTION("NatSemi PC-8736x GPIO Pin Driver");
 MODULE_LICENSE("GPL");
 
 static int major = 0;		/* default to dynamic major */
@@ -42,6 +43,8 @@ static unsigned pc8736x_gpio_base;
 
 #define SIO_CF1		0x21	/* chip config, bit0 is chip enable */
 
+#define PC8736X_GPIO_SIZE	16
+
 #define SIO_UNIT_SEL	0x7	/* unit select reg */
 #define SIO_UNIT_ACT	0x30	/* unit enable */
 #define SIO_GPIO_UNIT	0x7	/* unit number of GPIO */
@@ -69,6 +72,8 @@ static int port_offset[] = { 0, 4, 8, 10
 #define PORT_EVT_EN	2
 #define PORT_EVT_STST	3
 
+static struct platform_device *pdev;  /* use in dev_*() */
+
 static inline void superio_outb(int addr, int val)
 {
 	outb_p(addr, superio_cmd);
@@ -148,9 +153,9 @@ static int pc8736x_gpio_get(unsigned min
 	val >>= bit;
 	val &= 1;
 
-	printk(KERN_INFO NAME ": _gpio_get(%d from %x bit %d) == val %d\n",
-	       minor, pc8736x_gpio_base + port_offset[port] + PORT_IN, bit,
-	       val);
+	dev_dbg(&pdev->dev, "_gpio_get(%d from %x bit %d) == val %d\n",
+		minor, pc8736x_gpio_base + port_offset[port] + PORT_IN, bit,
+		val);
 
 	return val;
 }
@@ -164,22 +169,21 @@ static void pc8736x_gpio_set(unsigned mi
 	bit = minor & 7;
 	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
 
-	printk(KERN_INFO NAME
-	       ": addr:%x cur:%x bit-pos:%d cur-bit:%x + new:%d -> bit-new:%d\n",
-	       pc8736x_gpio_base + port_offset[port] + PORT_OUT,
-	       curval, bit, (curval & ~(1 << bit)), val, (val << bit));
+	dev_dbg(&pdev->dev, "addr:%x cur:%x bit-pos:%d cur-bit:%x + new:%d -> bit-new:%d\n",
+		pc8736x_gpio_base + port_offset[port] + PORT_OUT,
+		curval, bit, (curval & ~(1 << bit)), val, (val << bit));
 
 	val = (curval & ~(1 << bit)) | (val << bit);
 
-	printk(KERN_INFO NAME ": gpio_set(minor:%d port:%d bit:%d"
-	       ") %2x -> %2x\n", minor, port, bit, curval, val);
+	dev_dbg(&pdev->dev, "gpio_set(minor:%d port:%d bit:%d)"
+		" %2x -> %2x\n", minor, port, bit, curval, val);
 
 	outb_p(val, pc8736x_gpio_base + port_offset[port] + PORT_OUT);
 
 	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
 	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
 
-	printk(KERN_INFO NAME ": wrote %x, read: %x\n", curval, val);
+	dev_dbg(&pdev->dev, "wrote %x, read: %x\n", curval, val);
 }
 
 static void pc8736x_gpio_set_high(unsigned index)
@@ -194,7 +198,7 @@ static void pc8736x_gpio_set_low(unsigne
 
 static int pc8736x_gpio_current(unsigned index)
 {
-	printk(KERN_WARNING NAME ": pc8736x_gpio_current unimplemented\n");
+	dev_warn(&pdev->dev, "pc8736x_gpio_current unimplemented\n");
 	return 0;
 }
 
@@ -222,7 +226,7 @@ static int pc8736x_gpio_open(struct inod
 	unsigned m = iminor(inode);
 	file->private_data = &pc8736x_access;
 
-	printk(KERN_NOTICE NAME " open %d\n", m);
+	dev_dbg(&pdev->dev, "open %d\n", m);
 
 	if (m > 63)
 		return -EINVAL;
@@ -230,20 +234,30 @@ static int pc8736x_gpio_open(struct inod
 }
 
 static struct file_operations pc8736x_gpio_fops = {
-	.owner = THIS_MODULE,
-	.open = pc8736x_gpio_open,
-	.write = nsc_gpio_write,
-	.read = nsc_gpio_read,
+	.owner	= THIS_MODULE,
+	.open	= pc8736x_gpio_open,
+	.write	= nsc_gpio_write,
+	.read	= nsc_gpio_read,
 };
 
 static int __init pc8736x_gpio_init(void)
 {
 	int r, rc;
 
-	printk(KERN_DEBUG NAME " initializing\n");
+        pdev = platform_device_alloc(DEVNAME, 0);
+        if (!pdev)
+                return -ENOMEM;
+
+        rc = platform_device_add(pdev);
+        if (rc) {
+                platform_device_put(pdev);
+                return -ENODEV;
+        }
+        dev_info(&pdev->dev, "NatSemi pc8736x GPIO Driver Initializing\n");
 
 	if (!pc8736x_superio_present()) {
-		printk(KERN_ERR NAME ": no device found\n");
+		dev_err(&pdev->dev, "no device found\n");
+                platform_device_put(pdev);
 		return -ENODEV;
 	}
 
@@ -252,31 +266,31 @@ static int __init pc8736x_gpio_init(void
 	 */
 	rc = superio_inb(SIO_CF1);
 	if (!(rc & 0x01)) {
-		printk(KERN_ERR NAME ": device not enabled\n");
+		dev_err(&pdev->dev, "device not enabled\n");
 		return -ENODEV;
 	}
 	device_select(SIO_GPIO_UNIT);
 	if (!superio_inb(SIO_UNIT_ACT)) {
-		printk(KERN_ERR NAME ": GPIO unit not enabled\n");
+		dev_err(&pdev->dev, "GPIO unit not enabled\n");
 		return -ENODEV;
 	}
 
-	/* read GPIO unit base address */
+	/* read the GPIO unit base addr that chip responds to */
 	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
 			     | superio_inb(SIO_BASE_LADDR));
 
-	if (request_region(pc8736x_gpio_base, 16, NAME))
-		printk(KERN_INFO NAME ": GPIO ioport %x reserved\n",
-		       pc8736x_gpio_base);
+	if (request_region(pc8736x_gpio_base, 16, DEVNAME))
+		dev_info(&pdev->dev, "GPIO ioport %x reserved\n",
+			 pc8736x_gpio_base);
 
-	r = register_chrdev(major, NAME, &pc8736x_gpio_fops);
+	r = register_chrdev(major, DEVNAME, &pc8736x_gpio_fops);
 	if (r < 0) {
-		printk(KERN_ERR NAME ": unable to register character device\n");
+		dev_err(&pdev->dev, "unable to register character device\n");
 		return r;
 	}
 	if (!major) {
 		major = r;
-		printk(KERN_DEBUG NAME ": got dynamic major %d\n", major);
+		dev_dbg(&pdev->dev, "got dynamic major %d\n", major);
 	}
 
 	return 0;
@@ -284,11 +298,11 @@ static int __init pc8736x_gpio_init(void
 
 static void __exit pc8736x_gpio_cleanup(void)
 {
-	printk(KERN_DEBUG NAME " cleanup\n");
+	dev_dbg(&pdev->dev, " cleanup\n");
 
 	release_region(pc8736x_gpio_base, 16);
 
-	unregister_chrdev(major, NAME);
+	unregister_chrdev(major, DEVNAME);
 }
 
 module_init(pc8736x_gpio_init);


