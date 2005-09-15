Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVIOGwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVIOGwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVIOGwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:52:17 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:44377 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030383AbVIOGvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:50 -0400
Message-Id: <20050915064943.382253000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:45:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 05/28] Driver core: pass interface to class intreface methods
Content-Disposition: inline; filename=class-interface-add-pass-interface.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Driver core: pass interface to class intreface methods

Pass interface as argument to add() and remove() class interface
methods. This way a subsystem can implement generic add/remove
handlers and then call interface-specific ones.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c            |    8 ++++----
 drivers/pcmcia/ds.c             |    6 ++++--
 drivers/pcmcia/rsrc_nonstatic.c |    6 ++++--
 drivers/pcmcia/socket_sysfs.c   |    6 ++++--
 drivers/scsi/sg.c               |    8 ++++----
 include/linux/device.h          |    4 ++--
 6 files changed, 22 insertions(+), 16 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -546,7 +546,7 @@ int class_device_add(struct class_device
 		list_add_tail(&class_dev->node, &parent->children);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->add)
-				class_intf->add(class_dev);
+				class_intf->add(class_dev, class_intf);
 		up(&parent->sem);
 	}
 	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
@@ -627,7 +627,7 @@ void class_device_del(struct class_devic
 		list_del_init(&class_dev->node);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->remove)
-				class_intf->remove(class_dev);
+				class_intf->remove(class_dev, class_intf);
 		up(&parent->sem);
 	}
 
@@ -731,7 +731,7 @@ int class_interface_register(struct clas
 	list_add_tail(&class_intf->node, &parent->interfaces);
 	if (class_intf->add) {
 		list_for_each_entry(class_dev, &parent->children, node)
-			class_intf->add(class_dev);
+			class_intf->add(class_dev, class_intf);
 	}
 	up(&parent->sem);
 
@@ -750,7 +750,7 @@ void class_interface_unregister(struct c
 	list_del_init(&class_intf->node);
 	if (class_intf->remove) {
 		list_for_each_entry(class_dev, &parent->children, node)
-			class_intf->remove(class_dev);
+			class_intf->remove(class_dev, class_intf);
 	}
 	up(&parent->sem);
 
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -252,8 +252,8 @@ struct class_interface {
 	struct list_head	node;
 	struct class		*class;
 
-	int (*add)	(struct class_device *);
-	void (*remove)	(struct class_device *);
+	int (*add)	(struct class_device *, struct class_interface *);
+	void (*remove)	(struct class_device *, struct class_interface *);
 };
 
 extern int class_interface_register(struct class_interface *);
Index: work/drivers/pcmcia/ds.c
===================================================================
--- work.orig/drivers/pcmcia/ds.c
+++ work/drivers/pcmcia/ds.c
@@ -1157,7 +1157,8 @@ static struct pcmcia_callback pcmcia_bus
 	.requery = pcmcia_bus_rescan,
 };
 
-static int __devinit pcmcia_bus_add_socket(struct class_device *class_dev)
+static int __devinit pcmcia_bus_add_socket(struct class_device *class_dev,
+					   struct class_interface *class_intf)
 {
 	struct pcmcia_socket *socket = class_get_devdata(class_dev);
 	int ret;
@@ -1192,7 +1193,8 @@ static int __devinit pcmcia_bus_add_sock
 	return 0;
 }
 
-static void pcmcia_bus_remove_socket(struct class_device *class_dev)
+static void pcmcia_bus_remove_socket(struct class_device *class_dev,
+				     struct class_interface *class_intf)
 {
 	struct pcmcia_socket *socket = class_get_devdata(class_dev);
 
Index: work/drivers/pcmcia/rsrc_nonstatic.c
===================================================================
--- work.orig/drivers/pcmcia/rsrc_nonstatic.c
+++ work/drivers/pcmcia/rsrc_nonstatic.c
@@ -994,7 +994,8 @@ static struct class_device_attribute *pc
 	NULL,
 };
 
-static int __devinit pccard_sysfs_add_rsrc(struct class_device *class_dev)
+static int __devinit pccard_sysfs_add_rsrc(struct class_device *class_dev,
+					   struct class_interface *class_intf)
 {
 	struct pcmcia_socket *s = class_get_devdata(class_dev);
 	struct class_device_attribute **attr;
@@ -1011,7 +1012,8 @@ static int __devinit pccard_sysfs_add_rs
 	return ret;
 }
 
-static void __devexit pccard_sysfs_remove_rsrc(struct class_device *class_dev)
+static void __devexit pccard_sysfs_remove_rsrc(struct class_device *class_dev,
+					       struct class_interface *class_intf)
 {
 	struct pcmcia_socket *s = class_get_devdata(class_dev);
 	struct class_device_attribute **attr;
Index: work/drivers/pcmcia/socket_sysfs.c
===================================================================
--- work.orig/drivers/pcmcia/socket_sysfs.c
+++ work/drivers/pcmcia/socket_sysfs.c
@@ -341,7 +341,8 @@ static struct bin_attribute pccard_cis_a
 	.write = pccard_store_cis,
 };
 
-static int __devinit pccard_sysfs_add_socket(struct class_device *class_dev)
+static int __devinit pccard_sysfs_add_socket(struct class_device *class_dev,
+					     struct class_interface *class_intf)
 {
 	struct class_device_attribute **attr;
 	int ret = 0;
@@ -357,7 +358,8 @@ static int __devinit pccard_sysfs_add_so
 	return ret;
 }
 
-static void __devexit pccard_sysfs_remove_socket(struct class_device *class_dev)
+static void __devexit pccard_sysfs_remove_socket(struct class_device *class_dev,
+						 struct class_interface *class_intf)
 {
 	struct class_device_attribute **attr;
 
Index: work/drivers/scsi/sg.c
===================================================================
--- work.orig/drivers/scsi/sg.c
+++ work/drivers/scsi/sg.c
@@ -104,8 +104,8 @@ static int sg_allow_dio = SG_ALLOW_DIO_D
 
 #define SG_DEV_ARR_LUMP 32	/* amount to over allocate sg_dev_arr by */
 
-static int sg_add(struct class_device *);
-static void sg_remove(struct class_device *);
+static int sg_add(struct class_device *, struct class_interface *);
+static void sg_remove(struct class_device *, struct class_interface *);
 
 static Scsi_Request *dummy_cmdp;	/* only used for sizeof */
 
@@ -1506,7 +1506,7 @@ static int sg_alloc(struct gendisk *disk
 }
 
 static int
-sg_add(struct class_device *cl_dev)
+sg_add(struct class_device *cl_dev, struct class_interface *cl_intf)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->dev);
 	struct gendisk *disk;
@@ -1582,7 +1582,7 @@ out:
 }
 
 static void
-sg_remove(struct class_device *cl_dev)
+sg_remove(struct class_device *cl_dev, struct class_interface *cl_intf)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->dev);
 	Sg_device *sdp = NULL;

