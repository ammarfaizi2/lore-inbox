Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWFVSuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWFVSuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWFVSuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:50:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:24479 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161173AbWFVSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:50:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=tCHvAminlXUSiJXcyeEuQMTzI+87XKe9stS5IQuFz+9XSsjuf88z1KrYo/DV7U4ozjIzDjNMy3u/Ri1voKeXFYEDcnEydRhk/UkKm09gQTsk13QmnlPcUZ5h5IYs1Okt7mfwr8Ka8x4vJKQprICY8Skzs6P6X6heVIt9v4aRwh8=
Message-ID: <449AE659.40407@gmail.com>
Date: Thu, 22 Jun 2006 12:50:01 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 01/11 ] gpio-patchset-fixups: static-numpins
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff.2-fix-static-numpins

Theres currently no reason to expose number of pins, so make it static
until a reason presents itself.  Also, change name to be less generic.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

$ diffstat diff.2-fix-static-numpins
 scx200_gpio.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.17-mm1-sk/drivers/char/scx200_gpio.c 2/drivers/char/scx200_gpio.c
--- ../linux-2.6.17-mm1-sk/drivers/char/scx200_gpio.c	2006-06-21 07:04:24.000000000 -0600
+++ 2/drivers/char/scx200_gpio.c	2006-06-21 18:04:16.000000000 -0600
@@ -72,7 +72,7 @@ static struct file_operations scx200_gpi
 };
 
 struct cdev *scx200_devices;
-int num_devs = 32;
+static int num_pins = 32;
 
 static int __init scx200_gpio_init(void)
 {
@@ -97,21 +97,21 @@ static int __init scx200_gpio_init(void)
 	scx200_access.dev = &pdev->dev;
 
 	if (major)
-		rc = register_chrdev_region(dev, num_devs, "scx200_gpio");
+		rc = register_chrdev_region(dev, num_pins, "scx200_gpio");
 	else {
-		rc = alloc_chrdev_region(&dev, 0, num_devs, "scx200_gpio");
+		rc = alloc_chrdev_region(&dev, 0, num_pins, "scx200_gpio");
 		major = MAJOR(dev);
 	}
 	if (rc < 0) {
 		dev_err(&pdev->dev, "SCx200 chrdev_region err: %d\n", rc);
 		goto undo_platform_device_add;
 	}
-	scx200_devices = kzalloc(num_devs * sizeof(struct cdev), GFP_KERNEL);
+	scx200_devices = kzalloc(num_pins * sizeof(struct cdev), GFP_KERNEL);
 	if (!scx200_devices) {
 		rc = -ENOMEM;
 		goto undo_chrdev_region;
 	}
-	for (i = 0; i < num_devs; i++) {
+	for (i = 0; i < num_pins; i++) {
 		struct cdev *cdev = &scx200_devices[i];
 		cdev_init(cdev, &scx200_gpio_fops);
 		cdev->owner = THIS_MODULE;
@@ -124,7 +124,7 @@ static int __init scx200_gpio_init(void)
 	return 0; /* succeed */
 
 undo_chrdev_region:
-        unregister_chrdev_region(dev, num_devs);
+	unregister_chrdev_region(dev, num_pins);
 undo_platform_device_add:
 	platform_device_put(pdev);
 	kfree(pdev);		/* undo platform_device_alloc */
@@ -134,7 +134,7 @@ undo_platform_device_add:
 static void __exit scx200_gpio_cleanup(void)
 {
 	kfree(scx200_devices);
-	unregister_chrdev_region(MKDEV(major, 0), num_devs);
+	unregister_chrdev_region(MKDEV(major, 0), num_pins);
 	platform_device_put(pdev);
 	platform_device_unregister(pdev);
 	/* kfree(pdev); */


