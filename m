Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422856AbWJRUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422856AbWJRUJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWJRUJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36330 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422842AbWJRUJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:37 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/16] driver core fixes: device_add() cleanup on error
Date: Wed, 18 Oct 2006 13:09:01 -0700
Message-Id: <11612021771048-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021733101-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return code of device_create_file() and correct cleanup in
the error case in device_add().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index aee3743..365f709 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -433,14 +433,16 @@ int device_add(struct device *dev)
 	if (dev->driver)
 		dev->uevent_attr.attr.owner = dev->driver->owner;
 	dev->uevent_attr.store = store_uevent;
-	device_create_file(dev, &dev->uevent_attr);
+	error = device_create_file(dev, &dev->uevent_attr);
+	if (error)
+		goto attrError;
 
 	if (MAJOR(dev->devt)) {
 		struct device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			goto PMError;
+			goto ueventattrError;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
@@ -450,7 +452,7 @@ int device_add(struct device *dev)
 		error = device_create_file(dev, attr);
 		if (error) {
 			kfree(attr);
-			goto attrError;
+			goto ueventattrError;
 		}
 
 		dev->devt_attr = attr;
@@ -507,6 +509,8 @@ int device_add(struct device *dev)
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
 	}
+ ueventattrError:
+	device_remove_file(dev, &dev->uevent_attr);
  attrError:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
-- 
1.4.2.4

