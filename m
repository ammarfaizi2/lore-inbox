Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVCREAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVCREAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVCREAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:18 -0500
Received: from soundwarez.org ([217.160.171.123]:38799 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261220AbVCREAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:05 -0500
Date: Fri, 18 Mar 2005 05:00:02 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 1/6] kobject/hotplug split - kobject add/remove
Message-ID: <20050318040002.GA498@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_add() and kobject_del() don't emit hotplug events anymore.
The user should do it itself if it has finished populating the device
directory.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== lib/kobject.c 1.58 vs edited =====
--- 1.58/lib/kobject.c	2005-03-09 18:04:09 +01:00
+++ edited/lib/kobject.c	2005-03-18 02:17:18 +01:00
@@ -184,8 +184,6 @@ int kobject_add(struct kobject * kobj)
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
-	} else {
-		kobject_hotplug(kobj, KOBJ_ADD);
 	}
 
 	return error;
@@ -207,7 +205,8 @@ int kobject_register(struct kobject * ko
 			printk("kobject_register failed for %s (%d)\n",
 			       kobject_name(kobj),error);
 			dump_stack();
-		}
+		} else
+			kobject_hotplug(kobj, KOBJ_ADD);
 	} else
 		error = -EINVAL;
 	return error;
@@ -301,7 +300,6 @@ int kobject_rename(struct kobject * kobj
 
 void kobject_del(struct kobject * kobj)
 {
-	kobject_hotplug(kobj, KOBJ_REMOVE);
 	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
@@ -314,6 +312,7 @@ void kobject_del(struct kobject * kobj)
 void kobject_unregister(struct kobject * kobj)
 {
 	pr_debug("kobject %s: unregistering\n",kobject_name(kobj));
+	kobject_hotplug(kobj, KOBJ_REMOVE);
 	kobject_del(kobj);
 	kobject_put(kobj);
 }

