Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265750AbUGHBn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUGHBn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUGHBm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:42:56 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:50288 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265722AbUGHBm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:42:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [RESEND][PATCH 3/4] Driver core updates (needed for serio)
Date: Wed, 7 Jul 2004 20:40:46 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407072038.27158.dtor_core@ameritech.net> <200407072040.01818.dtor_core@ameritech.net>
In-Reply-To: <200407072040.01818.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407072040.48498.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1821, 2004-07-07 18:16:59-05:00, dtor_core@ameritech.net
  Driver core: kset_find_obj should increment refcount of the found object
               so users of the function can safely use returned object
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/bus.c               |    2 ++
 drivers/base/core.c              |   10 ++++++++++
 drivers/pci/hotplug/rpaphp_vio.c |    9 ++++++++-
 lib/kobject.c                    |    7 ++++---
 4 files changed, 24 insertions(+), 4 deletions(-)


===================================================================



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-07-07 19:55:49 -05:00
+++ b/drivers/base/bus.c	2004-07-07 19:55:49 -05:00
@@ -607,6 +607,8 @@
  *
  *	Call kset_find_obj() to iterate over list of buses to
  *	find a bus by name. Return bus if found.
+ *
+ *	Note that kset_find_obj increments bus' reference count.
  */
 
 struct bus_type * find_bus(char * name)
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-07-07 19:55:49 -05:00
+++ b/drivers/base/core.c	2004-07-07 19:55:49 -05:00
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
--- a/drivers/pci/hotplug/rpaphp_vio.c	2004-07-07 19:55:49 -05:00
+++ b/drivers/pci/hotplug/rpaphp_vio.c	2004-07-07 19:55:49 -05:00
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
--- a/lib/kobject.c	2004-07-07 19:55:49 -05:00
+++ b/lib/kobject.c	2004-07-07 19:55:49 -05:00
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
