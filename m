Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUGOAqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUGOAqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUGOAfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:35:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:31104 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266034AbUGOAT7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:19:59 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <1089850703420@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:23 -0700
Message-Id: <10898507033692@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.4, 2004/07/08 16:46:10-07:00, dtor_core@ameritech.net

[PATCH] Driver core: kset_find_obj should increment refcount of the found object

kset_find_obj should increment refcount of the found object so users of
the function can safely use returned object

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c               |    2 ++
 drivers/base/core.c              |   10 ++++++++++
 drivers/pci/hotplug/rpaphp_vio.c |    9 ++++++++-
 lib/kobject.c                    |    7 ++++---
 4 files changed, 24 insertions(+), 4 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-07-14 17:11:41 -07:00
+++ b/drivers/base/bus.c	2004-07-14 17:11:41 -07:00
@@ -607,6 +607,8 @@
  *
  *	Call kset_find_obj() to iterate over list of buses to
  *	find a bus by name. Return bus if found.
+ *
+ *	Note that kset_find_obj increments bus' reference count.
  */
 
 struct bus_type * find_bus(char * name)
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-07-14 17:11:41 -07:00
+++ b/drivers/base/core.c	2004-07-14 17:11:41 -07:00
@@ -378,6 +378,16 @@
 	return error;
 }
 
+/**
+ *	device_find - locate device on a bus by name.
+ *	@name:	name of the device.
+ *	@bus:	bus to scan for the device.
+ *
+ *	Call kset_find_obj() to iterate over list of devices on
+ *	a bus to find device by name. Return device if found.
+ *
+ *	Note that kset_find_obj increments device's reference count.
+ */
 struct device *device_find(const char *name, struct bus_type *bus)
 {
 	struct kobject *k = kset_find_obj(&bus->devices, name);
diff -Nru a/drivers/pci/hotplug/rpaphp_vio.c b/drivers/pci/hotplug/rpaphp_vio.c
--- a/drivers/pci/hotplug/rpaphp_vio.c	2004-07-14 17:11:41 -07:00
+++ b/drivers/pci/hotplug/rpaphp_vio.c	2004-07-14 17:11:41 -07:00
@@ -86,7 +86,14 @@
 	}
 	slot->dev_type = VIO_DEV;
 	slot->dev.vio_dev = vio_find_node(dn);
-	if (!slot->dev.vio_dev)
+	if (slot->dev.vio_dev) {
+		/*
+		 * rpaphp is the only owner of vio devices and
+		 * does not need extra reference taken by
+		 * vio_find_node
+		 */
+		put_device(&slot->dev.vio_dev->dev);
+	} else
 		slot->dev.vio_dev = vio_register_device_node(dn);
 	if (slot->dev.vio_dev)
 		slot->state = CONFIGURED;
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-07-14 17:11:41 -07:00
+++ b/lib/kobject.c	2004-07-14 17:11:41 -07:00
@@ -537,7 +537,8 @@
  *	@name:	object's name.
  *
  *	Lock kset via @kset->subsys, and iterate over @kset->list,
- *	looking for a matching kobject. Return object if found.
+ *	looking for a matching kobject. If matching object is found
+ *	take a reference and return the object.
  */
 
 struct kobject * kset_find_obj(struct kset * kset, const char * name)
@@ -548,8 +549,8 @@
 	down_read(&kset->subsys->rwsem);
 	list_for_each(entry,&kset->list) {
 		struct kobject * k = to_kobj(entry);
-		if (kobject_name(k) && (!strcmp(kobject_name(k),name))) {
-			ret = k;
+		if (kobject_name(k) && !strcmp(kobject_name(k),name)) {
+			ret = kobject_get(k);
 			break;
 		}
 	}

