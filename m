Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWFQSZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWFQSZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFQSZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:25:12 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:42595 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWFQSZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:25:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=llw6RlOnwJgHxQJYE9GKKWmyK+IvhI6DMFh0cZ0NgVAQzR93hcuI3KeFV22GNBjVXQD9SAQfNqIp2BX6G3QFth31u7enKjOHw9zhSub/hPpXXBjwyrGI5OBwfrySy+VI13WZfAFCxX5akVzGJHaeuHQZuhWtc9qy2gaV4qBotrE=
Message-ID: <44944904.9050302@gmail.com>
Date: Sat, 17 Jun 2006 12:25:08 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 03/20] chardev: GPIO for SCx200 & PC-8736x: add platforn_device
 for use w dev_dbg
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3/20. patch.platform-dev-2

Add a platform-device to scx200_gpio, and use its struct device dev
member (ie: devp) in dev_dbg() once.

There are 2 alternatives here (Im soliciting guidance/commentary):

- use isa_device, if/when its added to the kernel.

- alter scx200.c to EXPORT_GPL its private devp so that both
scx200_gpio, and the (to be added) nsc_gpio module can use it.
Since the available devp is in 'grandparent', this seems like
too much 'action at a distance'.


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.platform-dev-2
 scx200_gpio.c |   40 +++++++++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-2/drivers/char/scx200_gpio.c ax-3/drivers/char/scx200_gpio.c
--- ax-2/drivers/char/scx200_gpio.c	2006-06-17 01:01:13.000000000 -0600
+++ ax-3/drivers/char/scx200_gpio.c	2006-06-17 01:04:20.000000000 -0600
@@ -6,11 +6,13 @@
    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com> */
 
 #include <linux/config.h>
+#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -20,6 +22,9 @@
 #include <linux/scx200_gpio.h>
 
 #define NAME "scx200_gpio"
+#define DEVNAME NAME
+
+static struct platform_device *pdev;
 
 MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
 MODULE_DESCRIPTION("NatSemi SCx200 GPIO Pin Driver");
@@ -121,12 +126,20 @@ static int __init scx200_gpio_init(void)
 	int rc, i;
 	dev_t dev = MKDEV(major, 0);
 
-	printk(KERN_DEBUG NAME ": NatSemi SCx200 GPIO Driver\n");
-
 	if (!scx200_gpio_present()) {
 		printk(KERN_ERR NAME ": no SCx200 gpio present\n");
 		return -ENODEV;
 	}
+
+	/* support dev_dbg() with pdev->dev */
+	pdev = platform_device_alloc(DEVNAME, 0);
+	if (!pdev)
+		return -ENODEV;
+
+	rc = platform_device_add(pdev);
+	if (rc)
+		goto undo_platform_device_add;
+
 	if (major)
 		rc = register_chrdev_region(dev, num_devs, "scx200_gpio");
 	else {
@@ -134,29 +147,31 @@ static int __init scx200_gpio_init(void)
 		major = MAJOR(dev);
 	}
 	if (rc < 0) {
-		printk(KERN_ERR NAME ": SCx200 chrdev_region: %d\n", rc);
-		return rc;
+		dev_err(&pdev->dev, "SCx200 chrdev_region err: %d\n", rc);
+		goto undo_platform_device_add;
 	}
 	scx200_devices = kzalloc(num_devs * sizeof(struct cdev), GFP_KERNEL);
 	if (!scx200_devices) {
 		rc = -ENOMEM;
-		goto fail_malloc;
+		goto undo_chrdev_region;
 	}
 	for (i = 0; i < num_devs; i++) {
 		struct cdev *cdev = &scx200_devices[i];
 		cdev_init(cdev, &scx200_gpio_fops);
 		cdev->owner = THIS_MODULE;
-		cdev->ops = &scx200_gpio_fops;
 		rc = cdev_add(cdev, MKDEV(major, i), 1);
-		/* Fail gracefully if need be */
+		/* tolerate 'minor' errors */
 		if (rc)
-			printk(KERN_ERR NAME "Error %d on minor %d", rc, i);
+			dev_err(&pdev->dev, "Error %d on minor %d", rc, i);
 	}
 
-	return 0;		/* succeed */
+	return 0; /* succeed */
 
-fail_malloc:
-	unregister_chrdev_region(dev, num_devs);
+undo_chrdev_region:
+        unregister_chrdev_region(dev, num_devs);
+undo_platform_device_add:
+	platform_device_put(pdev);
+	kfree(pdev);		/* undo platform_device_alloc */
 	return rc;
 }
 
@@ -164,6 +179,9 @@ static void __exit scx200_gpio_cleanup(v
 {
 	kfree(scx200_devices);
 	unregister_chrdev_region(MKDEV(major, 0), num_devs);
+	platform_device_put(pdev);
+	platform_device_unregister(pdev);
+	/* kfree(pdev); */
 }
 
 module_init(scx200_gpio_init);


