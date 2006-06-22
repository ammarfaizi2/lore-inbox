Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWFVTDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWFVTDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWFVTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:03:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:20311 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161204AbWFVTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:03:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=AIuOZk5vlEU/lNN/BjX8Qq9dm5UA2xco40ZqZzJVBtfO3iuTPMeIDniiFkboY5hrbihT17CKFP5thO66WOFYYnNVr1KF1LBcoPo+i1j8WEAHSlzDKKgY2Cbo6ggI8blHec3LT/QMCeb1djhXfttDT08IZci1nh1sAO+V2kB8Q+w=
Message-ID: <449AE95E.2010604@gmail.com>
Date: Thu, 22 Jun 2006 13:02:54 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 11/11 ] gpio-patchset-fixups: series
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff.19-fix-pc8736x-modinit-err-undos

Rework the module-init function to properly undo initialization steps on 
failures.


Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs ab-1/drivers/char/pc8736x_gpio.c ab-2/drivers/char/pc8736x_gpio.c
--- ab-1/drivers/char/pc8736x_gpio.c	2006-06-21 11:45:23.000000000 -0600
+++ ab-2/drivers/char/pc8736x_gpio.c	2006-06-21 12:23:01.000000000 -0600
@@ -257,7 +257,7 @@ static void __init pc8736x_init_shadow(v
 
 static int __init pc8736x_gpio_init(void)
 {
-	int r, rc;
+	int rc = 0;
 
 	pdev = platform_device_alloc(DEVNAME, 0);
 	if (!pdev)
@@ -265,15 +265,15 @@ static int __init pc8736x_gpio_init(void
 
 	rc = platform_device_add(pdev);
 	if (rc) {
-		platform_device_put(pdev);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto undo_platform_dev_alloc;
 	}
 	dev_info(&pdev->dev, "NatSemi pc8736x GPIO Driver Initializing\n");
 
 	if (!pc8736x_superio_present()) {
+		rc = -ENODEV;
 		dev_err(&pdev->dev, "no device found\n");
-		platform_device_put(pdev);
-		return -ENODEV;
+		goto undo_platform_dev_add;
 	}
 	pc8736x_access.dev = &pdev->dev;
 
@@ -282,13 +282,15 @@ static int __init pc8736x_gpio_init(void
 	 */
 	rc = superio_inb(SIO_CF1);
 	if (!(rc & 0x01)) {
+		rc = -ENODEV;
 		dev_err(&pdev->dev, "device not enabled\n");
-		return -ENODEV;
+		goto undo_platform_dev_add;
 	}
 	device_select(SIO_GPIO_UNIT);
 	if (!superio_inb(SIO_UNIT_ACT)) {
+		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO unit not enabled\n");
-		return -ENODEV;
+		goto undo_platform_dev_add;
 	}
 
 	/* read the GPIO unit base addr that chip responds to */
@@ -296,24 +298,31 @@ static int __init pc8736x_gpio_init(void
 			     | superio_inb(SIO_BASE_LADDR));
 
 	if (!request_region(pc8736x_gpio_base, 16, DEVNAME)) {
+		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO ioport %x busy\n",
 			pc8736x_gpio_base);
-		return -ENODEV;
+		goto undo_platform_dev_add;
 	}
 	dev_info(&pdev->dev, "GPIO ioport %x reserved\n", pc8736x_gpio_base);
 
-	r = register_chrdev(major, DEVNAME, &pc8736x_gpio_fops);
-	if (r < 0) {
-		dev_err(&pdev->dev, "unable to register character device\n");
-		return r;
+	rc = register_chrdev(major, DEVNAME, &pc8736x_gpio_fops);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "register-chrdev failed: %d\n", rc);
+		goto undo_platform_dev_add;
 	}
 	if (!major) {
-		major = r;
+		major = rc;
 		dev_dbg(&pdev->dev, "got dynamic major %d\n", major);
 	}
 
 	pc8736x_init_shadow();
 	return 0;
+
+undo_platform_dev_add:
+	platform_device_put(pdev);
+undo_platform_dev_alloc:
+	kfree(pdev);
+	return rc;
 }
 
 static void __exit pc8736x_gpio_cleanup(void)


