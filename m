Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVFUA0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVFUA0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFUA0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:26:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:50148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261779AbVFTW76 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:58 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Use device_for_each_child() to unregister devices in scsi_remove_target().
In-Reply-To: <11193083662356@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083663269@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Use device_for_each_child() to unregister devices in scsi_remove_target().

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: gregkh-2.6/drivers/scsi/scsi_sysfs.c
===================================================================

---
commit 20b1e674230b642be662c5975923a0160ab9cbdc
tree 749e1384c57576bfbe3ffd1414df321cc783296f
parent 0293a509405dccecc30783a5d729d615b68d6a77
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 19:03:59 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:19 -0700

 drivers/scsi/scsi_sysfs.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -669,6 +669,13 @@ void __scsi_remove_target(struct scsi_ta
 	scsi_target_reap(starget);
 }
 
+static int __remove_child (struct device * dev, void * data)
+{
+	if (scsi_is_target_device(dev))
+		__scsi_remove_target(to_scsi_target(dev));
+	return 0;
+}
+
 /**
  * scsi_remove_target - try to remove a target and all its devices
  * @dev: generic starget or parent of generic stargets to be removed
@@ -679,7 +686,7 @@ void __scsi_remove_target(struct scsi_ta
  */
 void scsi_remove_target(struct device *dev)
 {
-	struct device *rdev, *idev, *next;
+	struct device *rdev;
 
 	if (scsi_is_target_device(dev)) {
 		__scsi_remove_target(to_scsi_target(dev));
@@ -687,10 +694,7 @@ void scsi_remove_target(struct device *d
 	}
 
 	rdev = get_device(dev);
-	list_for_each_entry_safe(idev, next, &dev->children, node) {
-		if (scsi_is_target_device(idev))
-			__scsi_remove_target(to_scsi_target(idev));
-	}
+	device_for_each_child(dev, NULL, __remove_child);
 	put_device(rdev);
 }
 EXPORT_SYMBOL(scsi_remove_target);

