Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUGDC1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUGDC1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 22:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbUGDC1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 22:27:55 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:25424 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265331AbUGDC1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 22:27:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: PPC64: vio_find_node removal?
Date: Sat, 3 Jul 2004 21:27:43 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
References: <200407011454.55440.dtor_core@ameritech.net> <200407011751.25738.dtor_core@ameritech.net> <22B73F26-CC34-11D8-BDBD-000A95A0560C@us.ibm.com>
In-Reply-To: <22B73F26-CC34-11D8-BDBD-000A95A0560C@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407032127.46043.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 July 2004 09:28 am, Hollis Blanchard wrote:
> On Jul 1, 2004, at 5:51 PM, Dmitry Torokhov wrote:
> >
> > Ok, so if we add call to kobject_get in kset_find_obj we can just add
> > kobject_put right in vio_find_name because there can be only one-to-one
> > match between a slot and a vio device and we don't need refcounting 
> > there,
> > right?
> 
> Hmm. Yes, I agree that we need kobject_get and _put between 
> kset_find_obj() and vio_find_name().

I tried putting kobject_put in vio_find_name but it felt extremely dirty.
So I moved it to the caller - rpaphp_vio::register_vio_slot(). What do
you think? (I am also CC-ing Greg KH so he can apply if there is an
agreement.)


===================================================================


ChangeSet@1.1778.5.4, 2004-07-03 21:19:34-05:00, dtor_core@ameritech.net
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
--- a/drivers/base/bus.c	2004-07-03 21:25:37 -05:00
+++ b/drivers/base/bus.c	2004-07-03 21:25:37 -05:00
@@ -607,6 +607,8 @@
  *
  *	Call kset_find_obj() to iterate over list of buses to
  *	find a bus by name. Return bus if found.
+ *
+ *	Note that kset_find_obj increments bus' reference count.
  */
 
 struct bus_type * find_bus(char * name)
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-07-03 21:25:37 -05:00
+++ b/drivers/base/core.c	2004-07-03 21:25:37 -05:00
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
--- a/drivers/pci/hotplug/rpaphp_vio.c	2004-07-03 21:25:37 -05:00
+++ b/drivers/pci/hotplug/rpaphp_vio.c	2004-07-03 21:25:37 -05:00
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
--- a/lib/kobject.c	2004-07-03 21:25:37 -05:00
+++ b/lib/kobject.c	2004-07-03 21:25:37 -05:00
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
