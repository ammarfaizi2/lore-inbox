Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWIOLUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWIOLUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIOLUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:20:11 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:53428 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751259AbWIOLUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:20:09 -0400
Date: Fri, 15 Sep 2006 13:20:28 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Martin Waitz <tali@admingilde.org>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [01/12] driver core fixes: make_class_name() retval check
Message-ID: <20060915132028.16281a71@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060914120133.GS17042@admingilde.org>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
	<20060913183834.3a71bbbe@gondolin.boeblingen.de.ibm.com>
	<20060914120133.GS17042@admingilde.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 14:01:33 +0200,
Martin Waitz <tali@admingilde.org> wrote:

> perhaps it makes sense to return NULL in make_class_name on error,
> to have consistent error return values?

It should make the code a bit nicer, I think. But I'm not sure if it's
worth the hassle (config_sysfs_deprecated.patch moves make_class_name()
under CONFIG_SYSFS_DEPRECATED).

Anyway, here is a patch against the latest version of Greg's tree:


From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make make_class_name() return NULL on error and fixup callers in the
driver core.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 class.c |   12 ++++++++----
 core.c  |    7 +++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff -Naurp linux-2.6.18-rc7/drivers/base/class.c linux-2.6.18-rc7+CH/drivers/base/class.c
--- linux-2.6.18-rc7/drivers/base/class.c	2006-09-15 10:38:55.000000000 +0200
+++ linux-2.6.18-rc7+CH/drivers/base/class.c	2006-09-15 12:18:30.000000000 +0200
@@ -360,7 +360,7 @@ char *make_class_name(const char *name, 
 
 	class_name = kmalloc(size, GFP_KERNEL);
 	if (!class_name)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	strcpy(class_name, name);
 	strcat(class_name, ":");
@@ -407,8 +407,11 @@ static int make_deprecated_class_device_
 		return 0;
 
 	class_name = make_class_name(class_dev->class->name, &class_dev->kobj);
-	error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  class_name);
+	if (!class_name)
+		error = sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, class_name);
+	else
+		error = -ENOMEM;
 	kfree(class_name);
 	return error;
 }
@@ -769,7 +772,8 @@ void class_device_del(struct class_devic
 #ifdef CONFIG_SYSFS_DEPRECATED
 		class_name = make_class_name(class_dev->class->name,
 					     &class_dev->kobj);
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		if (class_name)
+			sysfs_remove_link(&class_dev->dev->kobj, class_name);
 #endif
 		sysfs_remove_link(&class_dev->kobj, "device");
 	}
diff -Naurp linux-2.6.18-rc7/drivers/base/core.c linux-2.6.18-rc7+CH/drivers/base/core.c
--- linux-2.6.18-rc7/drivers/base/core.c	2006-09-15 10:39:03.000000000 +0200
+++ linux-2.6.18-rc7+CH/drivers/base/core.c	2006-09-15 11:01:58.000000000 +0200
@@ -443,7 +443,9 @@ int device_add(struct device *dev)
 		if ((parent) && (!device_is_virtual(dev))) {
 			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
 			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
+			if (class_name)
+				sysfs_create_link(&dev->parent->kobj,
+						  &dev->kobj, class_name);
 		}
 #endif
 	}
@@ -574,7 +576,8 @@ void device_del(struct device * dev)
 			char *class_name = NULL;
 
 			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_remove_link(&dev->parent->kobj, class_name);
+			if (class_name)
+				sysfs_remove_link(&dev->parent->kobj, class_name);
 			kfree(class_name);
 #endif
 			sysfs_remove_link(&dev->kobj, "device");
