Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbWKGQi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWKGQi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWKGQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:38:26 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:16281 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932738AbWKGQiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:38:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ic4SpXD3YmIxtSnZ4MSmDIwOkJsGYPHQ1HqLrmCf92RWyeWWB0ycsCt5ralHtteh49iSBCIEjlJmao24UfHtY/d8R9EZ0P4M9bKI42iWhqtYGskchNV4d1wurZVKkFIMnd5JstDCJob40QIewObBnaxGi75wxgvyFjXf+R83GOg=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 1/5] video sysfs support - take 2: Add dev argument for backlight_device_register.
Date: Wed, 8 Nov 2006 00:33:55 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611080033.56035.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch set adds generic abstract layer support for acpi video driver to have
generic user interface to control backlight and output switch control by leveraging
the existing backlight sysfs class driver, and by adding a new video output sysfs 
class driver.

Patch 1/5:  adds dev argument for backlight_device_register to link the class device
to real device object. The platform specific driver should find a way to get the real
device object for their video device.

signed-off-by: Luming Yu <Luming.yu@intel.com>
---
 drivers/acpi/asus_acpi.c            |    2 +-
 drivers/acpi/ibm_acpi.c             |    2 +-
 drivers/acpi/toshiba_acpi.c         |    3 ++-
 drivers/video/backlight/backlight.c |    7 +++++--
 include/linux/backlight.h           |    2 +-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index a36436f..4d24efc 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1401,7 +1401,7 @@ static int __init asus_acpi_init(void)
 		return -ENODEV;
 	}
 
-	asus_backlight_device = backlight_device_register("asus", NULL,
+	asus_backlight_device = backlight_device_register("asus",NULL,NULL,
 							  &asus_backlight_data);
         if (IS_ERR(asus_backlight_device)) {
 		printk(KERN_ERR "Could not register asus backlight device\n");
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 9658253..ba52b78 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -2072,7 +2072,7 @@ #endif
 		}
 	}
 
-	ibm_backlight_device = backlight_device_register("ibm", NULL,
+	ibm_backlight_device = backlight_device_register("ibm",NULL,NULL,
 							 &ibm_backlight_data);
         if (IS_ERR(ibm_backlight_device)) {
 		printk(IBM_ERR "Could not register ibm backlight device\n");
diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index 2f35f89..88aeccb 100644
--- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -590,7 +590,8 @@ static int __init toshiba_acpi_init(void
 			remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
 	}
 
-	toshiba_backlight_device = backlight_device_register("toshiba", NULL,
+	toshiba_backlight_device = backlight_device_register("toshiba",NULL,
+						NULL,
 						&toshiba_backlight_data);
         if (IS_ERR(toshiba_backlight_device)) {
 		printk(KERN_ERR "Could not register toshiba backlight device\n");
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..1d97cdf 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -190,8 +190,10 @@ static int fb_notifier_callback(struct n
  * Creates and registers new backlight class_device. Returns either an
  * ERR_PTR() or a pointer to the newly allocated device.
  */
-struct backlight_device *backlight_device_register(const char *name, void *devdata,
-						   struct backlight_properties *bp)
+struct backlight_device *backlight_device_register(const char *name,
+	struct device *dev,
+	void *devdata,
+	struct backlight_properties *bp)
 {
 	int i, rc;
 	struct backlight_device *new_bd;
@@ -206,6 +208,7 @@ struct backlight_device *backlight_devic
 	new_bd->props = bp;
 	memset(&new_bd->class_dev, 0, sizeof(new_bd->class_dev));
 	new_bd->class_dev.class = &backlight_class;
+	new_bd->class_dev.dev = dev;
 	strlcpy(new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
 	class_set_devdata(&new_bd->class_dev, devdata);
 
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 75e91f5..a5cf1be 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -54,7 +54,7 @@ struct backlight_device {
 };
 
 extern struct backlight_device *backlight_device_register(const char *name,
-	void *devdata, struct backlight_properties *bp);
+	struct device *dev,void *devdata,struct backlight_properties *bp);
 extern void backlight_device_unregister(struct backlight_device *bd);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, class_dev)
