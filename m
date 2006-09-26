Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWIZFms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWIZFms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIZFk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:3042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751478AbWIZFk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:28 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 45/47] Driver core: Fix potential deadlock in driver core
Date: Mon, 25 Sep 2006 22:38:05 -0700
Message-Id: <115924922922-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249226922-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-gi
 t-send-email-greg@kroah.com> <11592492221573-git-send-email-greg@kroah.com> <1159249226922-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

There is a potential deadlock in the driver core.  It boils down to
the fact that bus_remove_device() calls klist_remove() instead of
klist_del(), thereby waiting until the reference count of the
klist_node in the bus's klist of devices drops to 0.  The refcount
can't reach 0 so long as a modprobe process is trying to bind a new
driver to the device being removed, by calling __driver_attach().  The
problem is that __driver_attach() tries to acquire the device's
parent's semaphore, but the caller of bus_remove_device() is quite
likely to own that semaphore already.

It isn't sufficient just to replace klist_remove() with klist_del().
Doing so runs the risk that the device would remain on the bus's klist
of devices for some time, and so could be bound to another driver even
after it was unregistered.  What's needed is a new way to distinguish
whether or not a device is registered, based on a criterion other than
whether its klist_node is linked into the bus's klist of devices.  That
way driver binding can fail when the device is unregistered, even if
it is still linked into the klist.

This patch (as782) implements the solution, by adding a new bitflag to
indiate when a struct device is registered, by testing the flag before
allowing a driver to bind a device, and by changing the definition of
the device_is_registered() inline.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c     |    8 ++++++--
 drivers/base/dd.c      |    2 ++
 include/linux/device.h |    3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index aa685a2..636af53 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -392,6 +392,7 @@ out:
  *	bus_attach_device - add device to bus
  *	@dev:	device tried to attach to a driver
  *
+ *	- Add device to bus's list of devices.
  *	- Try to attach to driver.
  */
 int bus_attach_device(struct device * dev)
@@ -400,11 +401,13 @@ int bus_attach_device(struct device * de
 	int ret = 0;
 
 	if (bus) {
+		dev->is_registered = 1;
 		ret = device_attach(dev);
 		if (ret >= 0) {
 			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 			ret = 0;
-		}
+		} else
+			dev->is_registered = 0;
 	}
 	return ret;
 }
@@ -425,7 +428,8 @@ void bus_remove_device(struct device * d
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		klist_remove(&dev->knode_bus);
+		dev->is_registered = 0;
+		klist_del(&dev->knode_bus);
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 319a73b..b5f43c3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -162,6 +162,8 @@ int driver_probe_device(struct device_dr
 	struct task_struct *probe_task;
 	int ret = 0;
 
+	if (!device_is_registered(dev))
+		return -ENODEV;
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		goto done;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 74246ef..662e6a1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -329,6 +329,7 @@ struct device {
 
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
+	unsigned		is_registered:1;
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 
@@ -381,7 +382,7 @@ dev_set_drvdata (struct device *dev, voi
 
 static inline int device_is_registered(struct device *dev)
 {
-	return klist_node_attached(&dev->knode_bus);
+	return dev->is_registered;
 }
 
 /*
-- 
1.4.2.1

