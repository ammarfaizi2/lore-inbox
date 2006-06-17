Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWFQSYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWFQSYN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFQSYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:24:13 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:14435 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750787AbWFQSYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:24:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YWVSJ4gDdntLEh4JBneisOYFZg1nyemiJmB0OcD8pgDvqexZGCkN3/ywHleeTOeUqarx/aWLDKn7s896zb/pq+jHfx7h5zMNuUTZ9kfyXi6CM0TjJtND6lGy6DoDstH2VyZRwDAE/jgGGndMTQ9vR3SHqKbbmk2/Tb4LJ7YOk+s=
Message-ID: <449448CA.1060601@gmail.com>
Date: Sat, 17 Jun 2006 12:24:10 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 02/20] chardev: GPIO for SCx200 & PC-8736x: modernize
 driver init to 2.6 api
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2/20. patch.api26

Adopt many modern 2.6 coding practices, ala LDD3, chapter 3.
Changes are limited to initialization calls from module init,
ie: cdev_init, cdev_add, *_chrdev_region, mkdev.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.api26
 scx200_gpio.c |   55 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 42 insertions(+), 13 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-1/drivers/char/scx200_gpio.c ax-2/drivers/char/scx200_gpio.c
--- ax-1/drivers/char/scx200_gpio.c	2006-06-17 00:55:59.000000000 -0600
+++ ax-2/drivers/char/scx200_gpio.c	2006-06-17 01:01:13.000000000 -0600
@@ -14,6 +14,9 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#include <linux/types.h>
+#include <linux/cdev.h>
+
 #include <linux/scx200_gpio.h>
 
 #define NAME "scx200_gpio"
@@ -26,6 +29,8 @@ static int major = 0;		/* default to dyn
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
+extern void scx200_gpio_dump(unsigned index);
+
 static ssize_t scx200_gpio_write(struct file *file, const char __user *data,
 				 size_t len, loff_t *ppos)
 {
@@ -108,33 +113,57 @@ static struct file_operations scx200_gpi
 	.release = scx200_gpio_release,
 };
 
+struct cdev *scx200_devices;
+int num_devs = 32;
+
 static int __init scx200_gpio_init(void)
 {
-	int r;
+	int rc, i;
+	dev_t dev = MKDEV(major, 0);
 
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 GPIO Driver\n");
 
 	if (!scx200_gpio_present()) {
-		printk(KERN_ERR NAME ": no SCx200 gpio pins available\n");
+		printk(KERN_ERR NAME ": no SCx200 gpio present\n");
 		return -ENODEV;
 	}
-
-	r = register_chrdev(major, NAME, &scx200_gpio_fops);
-	if (r < 0) {
-		printk(KERN_ERR NAME ": unable to register character device\n");
-		return r;
-	}
-	if (!major) {
-		major = r;
-		printk(KERN_DEBUG NAME ": got dynamic major %d\n", major);
+	if (major)
+		rc = register_chrdev_region(dev, num_devs, "scx200_gpio");
+	else {
+		rc = alloc_chrdev_region(&dev, 0, num_devs, "scx200_gpio");
+		major = MAJOR(dev);
+	}
+	if (rc < 0) {
+		printk(KERN_ERR NAME ": SCx200 chrdev_region: %d\n", rc);
+		return rc;
+	}
+	scx200_devices = kzalloc(num_devs * sizeof(struct cdev), GFP_KERNEL);
+	if (!scx200_devices) {
+		rc = -ENOMEM;
+		goto fail_malloc;
+	}
+	for (i = 0; i < num_devs; i++) {
+		struct cdev *cdev = &scx200_devices[i];
+		cdev_init(cdev, &scx200_gpio_fops);
+		cdev->owner = THIS_MODULE;
+		cdev->ops = &scx200_gpio_fops;
+		rc = cdev_add(cdev, MKDEV(major, i), 1);
+		/* Fail gracefully if need be */
+		if (rc)
+			printk(KERN_ERR NAME "Error %d on minor %d", rc, i);
 	}
 
-	return 0;
+	return 0;		/* succeed */
+
+fail_malloc:
+	unregister_chrdev_region(dev, num_devs);
+	return rc;
 }
 
 static void __exit scx200_gpio_cleanup(void)
 {
-	unregister_chrdev(major, NAME);
+	kfree(scx200_devices);
+	unregister_chrdev_region(MKDEV(major, 0), num_devs);
 }
 
 module_init(scx200_gpio_init);


