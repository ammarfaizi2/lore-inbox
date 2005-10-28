Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVJ1GmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVJ1GmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVJ1GbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:23274 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965109AbVJ1GbF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:05 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Driver core: pass interface to class interface methods
In-Reply-To: <1130481022335@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:23 -0700
Message-Id: <11304810233647@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: pass interface to class interface methods

Driver core: pass interface to class intreface methods

Pass interface as argument to add() and remove() class interface
methods. This way a subsystem can implement generic add/remove
handlers and then call interface-specific ones.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6f5ace97359fa038cffb977dcf057764197f0df5
tree 704698b1aea6b88af22a5c3cf7f81e2dc9d4b313
parent b02f028de21efe6ba60d1896462a219f1356ea34
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:36 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:00 -0700

 drivers/base/class.c            |    8 ++++----
 drivers/pcmcia/ds.c             |    6 ++++--
 drivers/pcmcia/rsrc_nonstatic.c |    6 ++++--
 drivers/pcmcia/socket_sysfs.c   |    6 ++++--
 drivers/scsi/sg.c               |    8 ++++----
 include/linux/device.h          |    4 ++--
 6 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 8df58c5..73d44cf 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -532,7 +532,7 @@ int class_device_add(struct class_device
 		list_add_tail(&class_dev->node, &parent->children);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->add)
-				class_intf->add(class_dev);
+				class_intf->add(class_dev, class_intf);
 		up(&parent->sem);
 	}
 
@@ -612,7 +612,7 @@ void class_device_del(struct class_devic
 		list_del_init(&class_dev->node);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->remove)
-				class_intf->remove(class_dev);
+				class_intf->remove(class_dev, class_intf);
 		up(&parent->sem);
 	}
 
@@ -729,7 +729,7 @@ int class_interface_register(struct clas
 	list_add_tail(&class_intf->node, &parent->interfaces);
 	if (class_intf->add) {
 		list_for_each_entry(class_dev, &parent->children, node)
-			class_intf->add(class_dev);
+			class_intf->add(class_dev, class_intf);
 	}
 	up(&parent->sem);
 
@@ -748,7 +748,7 @@ void class_interface_unregister(struct c
 	list_del_init(&class_intf->node);
 	if (class_intf->remove) {
 		list_for_each_entry(class_dev, &parent->children, node)
-			class_intf->remove(class_dev);
+			class_intf->remove(class_dev, class_intf);
 	}
 	up(&parent->sem);
 
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 080608c..39d096b 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
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
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index f9a5c70..fc87e7e 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
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
diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index 1040a6c..4a3150a 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
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
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index ad94367..f0d8b4e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 95d607a..a53a822 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -251,8 +251,8 @@ struct class_interface {
 	struct list_head	node;
 	struct class		*class;
 
-	int (*add)	(struct class_device *);
-	void (*remove)	(struct class_device *);
+	int (*add)	(struct class_device *, struct class_interface *);
+	void (*remove)	(struct class_device *, struct class_interface *);
 };
 
 extern int class_interface_register(struct class_interface *);

