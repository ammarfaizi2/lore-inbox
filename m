Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTEIXl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTEIXkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:40:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51405 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263584AbTEIXk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:40:27 -0400
Date: Fri, 9 May 2003 16:53:59 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver core changes for 2.5.69
Message-ID: <20030509235359.GB3517@kroah.com>
References: <20030509235142.GA3506@kroah.com> <20030509235346.GA3517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509235346.GA3517@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1097, 2003/05/09 16:26:28-07:00, greg@kroah.com

[PATCH] driver core: Add driver symlink to class devices in sysfs.

Thanks to Mike Anderson for the idea for this.


 drivers/base/class.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri May  9 16:40:29 2003
+++ b/drivers/base/class.c	Fri May  9 16:40:29 2003
@@ -133,6 +133,21 @@
 		sysfs_remove_link(&class_dev->kobj, "device");
 }
 
+static int class_device_driver_link(struct class_device * class_dev)
+{
+	if ((class_dev->dev) && (class_dev->dev->driver))
+		return sysfs_create_link(&class_dev->kobj,
+					 &class_dev->dev->driver->kobj, "driver");
+	return 0;
+}
+
+static void class_device_driver_unlink(struct class_device * class_dev)
+{
+	if ((class_dev->dev) && (class_dev->dev->driver))
+		sysfs_remove_link(&class_dev->kobj, "driver");
+}
+
+
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_class_dev_attr(_attr) container_of(_attr,struct class_device_attribute,attr)
 
@@ -265,6 +280,7 @@
 	}
 
 	class_device_dev_link(class_dev);
+	class_device_driver_link(class_dev);
 
  register_done:
 	if (error && parent)
@@ -298,6 +314,7 @@
 
 	if (class_dev->dev) {
 		class_device_dev_unlink(class_dev);
+		class_device_driver_unlink(class_dev);
 		put_device(class_dev->dev);
 	}
 	
