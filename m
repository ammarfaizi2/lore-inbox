Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422840AbWJRUNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWJRUNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWJRUNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:13:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:24754 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422840AbWJRUJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:50 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/16] Driver core: Don't ignore error returns from probing
Date: Wed, 18 Oct 2006 13:09:05 -0700
Message-Id: <11612021903607-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021872574-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com> <11612021771048-git-send-email-greg@kroah.com> <11612021801495-git-send-email-greg@kroah.com> <11612021841579-git-send-email-greg@kroah.com> <11612021872574-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as797) fixes device_add() in the driver core.  It needs to
pay attention when the driver for a new device reports an error.

At the same time, since bus_remove_device() undoes the effects of both
bus_add_device() and bus_attach_device(), it needs to check whether
the bus_attach_device step failed.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c  |    6 ++++--
 drivers/base/core.c |    5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d516f7d..d7c5ea2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -439,8 +439,10 @@ void bus_remove_device(struct device * d
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		dev->is_registered = 0;
-		klist_del(&dev->knode_bus);
+		if (dev->is_registered) {
+			dev->is_registered = 0;
+			klist_del(&dev->knode_bus);
+		}
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 41f3dca..68ad11a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -479,7 +479,8 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	if ((error = bus_attach_device(dev)))
+		goto AttachError;
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -498,6 +499,8 @@ int device_add(struct device *dev)
  	kfree(class_name);
 	put_device(dev);
 	return error;
+ AttachError:
+	bus_remove_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
-- 
1.4.2.4

