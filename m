Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVCJEAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVCJEAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVCJAx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:53:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:60319 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262636AbVCJAmf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:35 -0500
Cc: gregkh@suse.de
Subject: [PATCH] USB: move usb core to use class_simple instead of it's own class functions.
In-Reply-To: <11104148851950@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:46 -0800
Message-Id: <1110414886692@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2051, 2005/03/09 12:17:18-08:00, gregkh@suse.de

[PATCH] USB: move usb core to use class_simple instead of it's own class functions.

This is needed if the class code is going to be made easier to use, and it makes the code
smaller and easier to understand.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/usb/core/file.c |   55 ++++++++++++++++--------------------------------
 1 files changed, 19 insertions(+), 36 deletions(-)


diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	2005-03-09 16:28:31 -08:00
+++ b/drivers/usb/core/file.c	2005-03-09 16:28:31 -08:00
@@ -66,16 +66,7 @@
 	.open =		usb_open,
 };
 
-static void release_usb_class_dev(struct class_device *class_dev)
-{
-	dbg("%s - %s", __FUNCTION__, class_dev->class_id);
-	kfree(class_dev);
-}
-
-static struct class usb_class = {
-	.name		= "usb",
-	.release	= &release_usb_class_dev,
-};
+static struct class_simple *usb_class;
 
 int usb_major_init(void)
 {
@@ -87,9 +78,9 @@
 		goto out;
 	}
 
-	error = class_register(&usb_class);
-	if (error) {
-		err("class_register failed for usb devices");
+	usb_class = class_simple_create(THIS_MODULE, "usb");
+	if (IS_ERR(usb_class)) {
+		err("class_simple_create failed for usb devices");
 		unregister_chrdev(USB_MAJOR, "usb");
 		goto out;
 	}
@@ -102,7 +93,7 @@
 
 void usb_major_cleanup(void)
 {
-	class_unregister(&usb_class);
+	class_simple_destroy(usb_class);
 	devfs_remove("usb");
 	unregister_chrdev(USB_MAJOR, "usb");
 }
@@ -134,7 +125,6 @@
 	int minor_base = class_driver->minor_base;
 	int minor = 0;
 	char name[BUS_ID_SIZE];
-	struct class_device *class_dev;
 	char *temp;
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
@@ -174,22 +164,18 @@
 	devfs_mk_cdev(MKDEV(USB_MAJOR, minor), class_driver->mode, name);
 
 	/* create a usb class device for this usb interface */
-	class_dev = kmalloc(sizeof(*class_dev), GFP_KERNEL);
-	if (class_dev) {
-		memset(class_dev, 0x00, sizeof(struct class_device));
-		class_dev->devt = MKDEV(USB_MAJOR, minor);
-		class_dev->class = &usb_class;
-		class_dev->dev = &intf->dev;
-
-		temp = strrchr(name, '/');
-		if (temp && (temp[1] != 0x00))
-			++temp;
-		else
-			temp = name;
-		snprintf(class_dev->class_id, BUS_ID_SIZE, "%s", temp);
-		class_set_devdata(class_dev, (void *)(long)intf->minor);
-		class_device_register(class_dev);
-		intf->class_dev = class_dev;
+	temp = strrchr(name, '/');
+	if (temp && (temp[1] != 0x00))
+		++temp;
+	else
+		temp = name;
+	intf->class_dev = class_simple_device_add(usb_class, MKDEV(USB_MAJOR, minor), &intf->dev, "%s", temp);
+	if (IS_ERR(intf->class_dev)) {
+		spin_lock (&minor_lock);
+		usb_minors[intf->minor] = NULL;
+		spin_unlock (&minor_lock);
+		devfs_remove (name);
+		retval = PTR_ERR(intf->class_dev);
 	}
 exit:
 	return retval;
@@ -232,11 +218,8 @@
 
 	snprintf(name, BUS_ID_SIZE, class_driver->name, intf->minor - minor_base);
 	devfs_remove (name);
-
-	if (intf->class_dev) {
-		class_device_unregister(intf->class_dev);
-		intf->class_dev = NULL;
-	}
+	class_simple_device_remove(MKDEV(USB_MAJOR, intf->minor));
+	intf->class_dev = NULL;
 	intf->minor = -1;
 }
 EXPORT_SYMBOL(usb_deregister_dev);

