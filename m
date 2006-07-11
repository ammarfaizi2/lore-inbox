Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWGKPYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWGKPYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWGKPYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:24:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:57209 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750970AbWGKPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:24:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=mIh8S23V/Z/DXQGqHXfnWPIVrvu57GRbn1YozL8n7ltDieUvfKhpeXkWW4sh3BE5qSj8dtGUniktA4/l/LqzYWVRqPaZeYLD8KsPk7IvXlmSK2WrwNQ3/Ohfx/BzcFfsfJpnmGWREchaSfGEyabgNh+AckAIK93WwMEhyJEy6DU=
Message-ID: <44B3C2B6.9070400@gmail.com>
Date: Tue, 11 Jul 2006 09:24:38 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 01/02 ] scx200_gpio: 1 cdev for N minors - cleanup,
 prep 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch is mostly cleanup of scx200_gpio :
- drop #include <linux/config.h>
- s/DEVNAME/DRVNAME/    apparently a convention
- replace variable num_pins with  #define MAX_PINS
- s/dev/devid/   to clarify that its a dev_t, not a struct device dev.
- move devid = MKDEV(major,0)  into branch where its needed.

2 minor 'changes' :
- reduced MAX_PINS from 64 to 32.  Ive never tested other pins,
and theyre all multiplexed with other functions, some of which may be
in use on my soekris 4801, so I dont know what testing should yield.
If you (AKPM) think it should stay unchanged, please feel free to 
s/32/64/ the
patch directly, and consider this my Ack.  Otherwize I'll defer,
go read the datasheet, and see what I can do, when.

+EXPORT_SYMBOL(scx200_access);
This exposes the driver's vtable, which another driver can use
along with #include <linux/nsc_gpio.h>, to manipulate a gpio-pin.

Signed-off-by  Jim Cromie <jim.cromie@gmail.com>

---

$ diffstat diff.scx-normalize
 scx200_gpio.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs x-0/drivers/char/scx200_gpio.c x-1/drivers/char/scx200_gpio.c
--- x-0/drivers/char/scx200_gpio.c	2006-07-06 13:19:16.000000000 -0600
+++ x-1/drivers/char/scx200_gpio.c	2006-07-10 20:19:17.000000000 -0600
@@ -5,7 +5,6 @@
 
    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com> */
 
-#include <linux/config.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -22,19 +21,20 @@
 #include <linux/scx200_gpio.h>
 #include <linux/nsc_gpio.h>
 
-#define NAME "scx200_gpio"
-#define DEVNAME NAME
+#define DRVNAME "scx200_gpio"
 
 static struct platform_device *pdev;
 
 MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
-MODULE_DESCRIPTION("NatSemi SCx200 GPIO Pin Driver");
+MODULE_DESCRIPTION("NatSemi/AMD SCx200 GPIO Pin Driver");
 MODULE_LICENSE("GPL");
 
 static int major = 0;		/* default to dynamic major */
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
+#define MAX_PINS 32		/* 64 later, when known ok */
+
 struct nsc_gpio_ops scx200_access = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= scx200_gpio_configure,
@@ -46,13 +46,14 @@ struct nsc_gpio_ops scx200_access = {
 	.gpio_change	= scx200_gpio_change,
 	.gpio_current	= scx200_gpio_current
 };
+EXPORT_SYMBOL(scx200_access);
 
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
 	file->private_data = &scx200_access;
 
-	if (m > 63)
+	if (m >= MAX_PINS)
 		return -EINVAL;
 	return nonseekable_open(inode, file);
 }
@@ -72,20 +73,19 @@ static const struct file_operations scx2
 };
 
 struct cdev *scx200_devices;
-static int num_pins = 32;
 
 static int __init scx200_gpio_init(void)
 {
 	int rc, i;
-	dev_t dev = MKDEV(major, 0);
+	dev_t devid;
 
 	if (!scx200_gpio_present()) {
-		printk(KERN_ERR NAME ": no SCx200 gpio present\n");
+		printk(KERN_ERR DRVNAME ": no SCx200 gpio present\n");
 		return -ENODEV;
 	}
 
 	/* support dev_dbg() with pdev->dev */
-	pdev = platform_device_alloc(DEVNAME, 0);
+	pdev = platform_device_alloc(DRVNAME, 0);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -96,22 +96,23 @@ static int __init scx200_gpio_init(void)
 	/* nsc_gpio uses dev_dbg(), so needs this */
 	scx200_access.dev = &pdev->dev;
 
-	if (major)
-		rc = register_chrdev_region(dev, num_pins, "scx200_gpio");
-	else {
-		rc = alloc_chrdev_region(&dev, 0, num_pins, "scx200_gpio");
-		major = MAJOR(dev);
+	if (major) {
+		devid = MKDEV(major, 0);
+		rc = register_chrdev_region(devid, MAX_PINS, "scx200_gpio");
+	} else {
+		rc = alloc_chrdev_region(&devid, 0, MAX_PINS, "scx200_gpio");
+		major = MAJOR(devid);
 	}
 	if (rc < 0) {
 		dev_err(&pdev->dev, "SCx200 chrdev_region err: %d\n", rc);
 		goto undo_platform_device_add;
 	}
-	scx200_devices = kzalloc(num_pins * sizeof(struct cdev), GFP_KERNEL);
+	scx200_devices = kzalloc(MAX_PINS * sizeof(struct cdev), GFP_KERNEL);
 	if (!scx200_devices) {
 		rc = -ENOMEM;
 		goto undo_chrdev_region;
 	}
-	for (i = 0; i < num_pins; i++) {
+	for (i = 0; i < MAX_PINS; i++) {
 		struct cdev *cdev = &scx200_devices[i];
 		cdev_init(cdev, &scx200_gpio_fops);
 		cdev->owner = THIS_MODULE;
@@ -124,7 +125,7 @@ static int __init scx200_gpio_init(void)
 	return 0; /* succeed */
 
 undo_chrdev_region:
-	unregister_chrdev_region(dev, num_pins);
+	unregister_chrdev_region(devid, MAX_PINS);
 undo_platform_device_add:
 	platform_device_del(pdev);
 undo_malloc:
@@ -136,9 +137,8 @@ undo_malloc:
 static void __exit scx200_gpio_cleanup(void)
 {
 	kfree(scx200_devices);
-	unregister_chrdev_region(MKDEV(major, 0), num_pins);
+	unregister_chrdev_region(MKDEV(major, 0), MAX_PINS);
 	platform_device_unregister(pdev);
-	/* kfree(pdev); */
 }
 
 module_init(scx200_gpio_init);


