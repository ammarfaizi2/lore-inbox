Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVHPWQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVHPWQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVHPWQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:16:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:10385 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750997AbVHPWQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:20 -0400
Date: Tue, 16 Aug 2005 15:15:48 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: [patch 1/7] Driver core: potentially fix use after free in class_device_attr_show
Message-ID: <20050816221548.GB28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-use-after-free-fix-for-class_device_attr_show.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maneesh Soni <maneesh@in.ibm.com>

o moves the code to free devt_attr from class_device_del() to
  class_dev_release() which is called after the last reference to the
  corresponding kobject() is gone. This allows to keep the devt_attr
  alive while the corresponding sysfs file is open.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/class.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/drivers/base/class.c	2005-08-16 14:51:44.000000000 -0700
+++ gregkh-2.6/drivers/base/class.c	2005-08-16 14:56:58.000000000 -0700
@@ -299,6 +299,11 @@ static void class_dev_release(struct kob
 
 	pr_debug("device class '%s': release.\n", cd->class_id);
 
+	if (cd->devt_attr) {
+		kfree(cd->devt_attr);
+		cd->devt_attr = NULL;
+	}
+
 	if (cls->release)
 		cls->release(cd);
 	else {
@@ -591,11 +596,8 @@ void class_device_del(struct class_devic
 
 	if (class_dev->dev)
 		sysfs_remove_link(&class_dev->kobj, "device");
-	if (class_dev->devt_attr) {
+	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
-		kfree(class_dev->devt_attr);
-		class_dev->devt_attr = NULL;
-	}
 	class_device_remove_attrs(class_dev);
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);

--
