Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWGKP1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWGKP1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGKP1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:27:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:37126 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751284AbWGKP1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:27:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=DZnTyvwlw3zNNAU69uKjweH8LUI6BiqHn23X0Ii52oRlQ7VnV9Ll/CWeyst7do8cq/rW08nE7Q6FXtayn0dCxBUHn2Y1xNZ0X6uCb6rs7IFJbB7ie/B0ZJpLqK/uSfqhsq3E5NS8wjG0Byb3kEH4xcx9oF64XbdarPD4NZlE73Y=
Message-ID: <44B3C376.4060307@gmail.com>
Date: Tue, 11 Jul 2006 09:27:50 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 02/02 ] scx200_gpio: use 1 cdev for N minors, not N
 for N
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch removes the scx200_gpio's  cdev-array & ksalloc,
replacing it with a single static struct cdev, which is sufficient
for all the pins.

cdev_put is commented out since kernel wont link properly with it,
and its apparently not needed.

With these patches, this driver continues to work with Chris Boot's
leds_48xx driver, which is also new in -mm1.

Signed-off-by  Jim Cromie <jim.cromie@gmail.com>

---

$ diffstat diff.scx-1-cdev
 scx200_gpio.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)



diff -ruNp -X dontdiff -X exclude-diffs x-1/drivers/char/scx200_gpio.c x-2/drivers/char/scx200_gpio.c
--- x-1/drivers/char/scx200_gpio.c	2006-07-10 20:19:17.000000000 -0600
+++ x-2/drivers/char/scx200_gpio.c	2006-07-10 20:45:05.000000000 -0600
@@ -63,7 +63,6 @@ static int scx200_gpio_release(struct in
 	return 0;
 }
 
-
 static const struct file_operations scx200_gpio_fops = {
 	.owner   = THIS_MODULE,
 	.write   = nsc_gpio_write,
@@ -72,11 +71,11 @@ static const struct file_operations scx2
 	.release = scx200_gpio_release,
 };
 
-struct cdev *scx200_devices;
+struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
 
 static int __init scx200_gpio_init(void)
 {
-	int rc, i;
+	int rc;
 	dev_t devid;
 
 	if (!scx200_gpio_present()) {
@@ -107,25 +106,12 @@ static int __init scx200_gpio_init(void)
 		dev_err(&pdev->dev, "SCx200 chrdev_region err: %d\n", rc);
 		goto undo_platform_device_add;
 	}
-	scx200_devices = kzalloc(MAX_PINS * sizeof(struct cdev), GFP_KERNEL);
-	if (!scx200_devices) {
-		rc = -ENOMEM;
-		goto undo_chrdev_region;
-	}
-	for (i = 0; i < MAX_PINS; i++) {
-		struct cdev *cdev = &scx200_devices[i];
-		cdev_init(cdev, &scx200_gpio_fops);
-		cdev->owner = THIS_MODULE;
-		rc = cdev_add(cdev, MKDEV(major, i), 1);
-		/* tolerate 'minor' errors */
-		if (rc)
-			dev_err(&pdev->dev, "Error %d on minor %d", rc, i);
-	}
+
+	cdev_init(&scx200_gpio_cdev, &scx200_gpio_fops);
+	cdev_add(&scx200_gpio_cdev, devid, MAX_PINS);
 
 	return 0; /* succeed */
 
-undo_chrdev_region:
-	unregister_chrdev_region(devid, MAX_PINS);
 undo_platform_device_add:
 	platform_device_del(pdev);
 undo_malloc:
@@ -136,7 +122,9 @@ undo_malloc:
 
 static void __exit scx200_gpio_cleanup(void)
 {
-	kfree(scx200_devices);
+	cdev_del(&scx200_gpio_cdev);
+	/* cdev_put(&scx200_gpio_cdev); */
+
 	unregister_chrdev_region(MKDEV(major, 0), MAX_PINS);
 	platform_device_unregister(pdev);
 }


