Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUCCEwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUCCEbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:31:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:37506 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262361AbUCCEWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:00 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <10782873972560@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:38 -0800
Message-Id: <107828739888@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.72.2, 2004/02/19 15:38:41-08:00, shemminger@osdl.org

[PATCH] propogate errors from misc_register to caller

The patch to check for / in class_device is not enough.
The misc_register function needs to check return value of the things it calls!


 drivers/char/misc.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)


diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Tue Mar  2 19:52:14 2004
+++ b/drivers/char/misc.c	Tue Mar  2 19:52:14 2004
@@ -212,6 +212,9 @@
 int misc_register(struct miscdevice * misc)
 {
 	struct miscdevice *c;
+	struct class_device *class;
+	dev_t dev;
+	int err;
 	
 	down(&misc_sem);
 	list_for_each_entry(c, &misc_list, list) {
@@ -240,19 +243,30 @@
 		snprintf(misc->devfs_name, sizeof(misc->devfs_name),
 				"misc/%s", misc->name);
 	}
+	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-	class_simple_device_add(misc_class, MKDEV(MISC_MAJOR, misc->minor),
-				misc->dev, misc->name);
-	devfs_mk_cdev(MKDEV(MISC_MAJOR, misc->minor),
-			S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, misc->devfs_name);
+	class = class_simple_device_add(misc_class, dev,
+					misc->dev, misc->name);
+	if (IS_ERR(class)) {
+		err = PTR_ERR(class);
+		goto out;
+	}
+
+	err = devfs_mk_cdev(dev, S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, 
+			    misc->devfs_name);
+	if (err) {
+		class_simple_device_remove(dev);
+		goto out;
+	}
 
 	/*
 	 * Add it to the front, so that later devices can "override"
 	 * earlier defaults
 	 */
 	list_add(&misc->list, &misc_list);
+ out:
 	up(&misc_sem);
-	return 0;
+	return err;
 }
 
 /**

