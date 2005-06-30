Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbVF3VY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVF3VY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVF3VW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:22:28 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:52636 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S263152AbVF3VSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:18:48 -0400
Message-ID: <37114.127.0.0.1.1120166322.squirrel@localhost>
In-Reply-To: <20050630194540.GA15389@suse.de>
References: <20050630060206.GA23321@kroah.com>
    <34128.127.0.0.1.1120152169.squirrel@localhost>
    <20050630194540.GA15389@suse.de>
Date: Thu, 30 Jun 2005 16:18:42 -0500 (CDT)
Subject: [PATCH] add class_interface pointer to add and remove functions
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Greg KH" <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, June 30, 2005 2:45 pm, Greg KH said:
> On Thu, Jun 30, 2005 at 12:22:49PM -0500, John Lenz wrote:
>> As long as there are a whole bunch of class API changes going on, I would
>> request that the class_interface add and remove functions get passed the
>> class_interface pointer as well as the class_device.  This way, the same
>> function can be used on multiple class_interfaces.
>
> I'm sorry, I seem to have missed the patch in this email that implements
> this feature...
>

Here is a patch that updates every usage of class_interface I could find.

Signed-off-by: John Lenz <lenz@cs.wisc.edu>

Index: linux-2.6.12/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.12.orig/drivers/message/i2o/device.c	2005-06-30 11:54:55.000000000 -0500
+++ linux-2.6.12/drivers/message/i2o/device.c	2005-06-30 16:00:55.756158383 -0500
@@ -385,7 +385,7 @@
  *
  *	Returns 0 on success or negative error code on failure.
  */
-static int i2o_device_class_add(struct class_device *cd)
+static int i2o_device_class_add(struct class_interface *class_intf, struct class_device *cd)
 {
 	struct i2o_device *i2o_dev, *tmp;
 	struct i2o_controller *c;
Index: linux-2.6.12/drivers/base/class.c
===================================================================
--- linux-2.6.12.orig/drivers/base/class.c	2005-06-30 11:54:52.000000000 -0500
+++ linux-2.6.12/drivers/base/class.c	2005-06-30 15:58:53.321286879 -0500
@@ -505,7 +505,7 @@
 		list_add_tail(&class_dev->node, &parent->children);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->add)
-				class_intf->add(class_dev);
+				class_intf->add(class_intf, class_dev);
 		up(&parent->sem);
 	}
 	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
@@ -585,7 +585,7 @@
 		list_del_init(&class_dev->node);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->remove)
-				class_intf->remove(class_dev);
+				class_intf->remove(class_intf, class_dev);
 		up(&parent->sem);
 	}

@@ -688,7 +688,7 @@
 	list_add_tail(&class_intf->node, &parent->interfaces);
 	if (class_intf->add) {
 		list_for_each_entry(class_dev, &parent->children, node)
-			class_intf->add(class_dev);
+			class_intf->add(class_intf, class_dev);
 	}
 	up(&parent->sem);

@@ -707,7 +707,7 @@
 	list_del_init(&class_intf->node);
 	if (class_intf->remove) {
 		list_for_each_entry(class_dev, &parent->children, node)
-			class_intf->remove(class_dev);
+			class_intf->remove(class_intf, class_dev);
 	}
 	up(&parent->sem);

Index: linux-2.6.12/drivers/pcmcia/ds.c
===================================================================
--- linux-2.6.12.orig/drivers/pcmcia/ds.c	2005-06-30 11:54:56.000000000 -0500
+++ linux-2.6.12/drivers/pcmcia/ds.c	2005-06-30 16:02:14.382619884 -0500
@@ -1148,7 +1148,7 @@
 	.requery = pcmcia_bus_rescan,
 };

-static int __devinit pcmcia_bus_add_socket(struct class_device *class_dev)
+static int __devinit pcmcia_bus_add_socket(struct class_interface *class_intf, struct class_device *class_dev)
 {
 	struct pcmcia_socket *socket = class_get_devdata(class_dev);
 	int ret;
@@ -1183,7 +1183,7 @@
 	return 0;
 }

-static void pcmcia_bus_remove_socket(struct class_device *class_dev)
+static void pcmcia_bus_remove_socket(struct class_interface *class_intf, struct class_device *class_dev)
 {
 	struct pcmcia_socket *socket = class_get_devdata(class_dev);

Index: linux-2.6.12/drivers/scsi/sg.c
===================================================================
--- linux-2.6.12.orig/drivers/scsi/sg.c	2005-06-30 11:54:57.000000000 -0500
+++ linux-2.6.12/drivers/scsi/sg.c	2005-06-30 16:06:23.123755439 -0500
@@ -104,8 +104,8 @@

 #define SG_DEV_ARR_LUMP 32	/* amount to over allocate sg_dev_arr by */

-static int sg_add(struct class_device *);
-static void sg_remove(struct class_device *);
+static int sg_add(struct class_interface *class_intf, struct class_device *);
+static void sg_remove(struct class_interface *class_intf, struct class_device *);

 static Scsi_Request *dummy_cmdp;	/* only used for sizeof */

@@ -1507,7 +1507,7 @@
 }

 static int
-sg_add(struct class_device *cl_dev)
+sg_add(struct class_interface *class_intf, struct class_device *cl_dev)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->dev);
 	struct gendisk *disk;
@@ -1583,7 +1583,7 @@
 }

 static void
-sg_remove(struct class_device *cl_dev)
+sg_remove(struct class_interface *class_intf, struct class_device *cl_dev)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->dev);
 	Sg_device *sdp = NULL;
Index: linux-2.6.12/drivers/pcmcia/socket_sysfs.c
===================================================================
--- linux-2.6.12.orig/drivers/pcmcia/socket_sysfs.c	2005-06-30 11:54:56.000000000 -0500
+++ linux-2.6.12/drivers/pcmcia/socket_sysfs.c	2005-06-30 16:04:24.233249703 -0500
@@ -342,7 +342,7 @@
 	.write = pccard_store_cis,
 };

-static int __devinit pccard_sysfs_add_socket(struct class_device *class_dev)
+static int __devinit pccard_sysfs_add_socket(struct class_interface *class_intf, struct class_device *class_dev)
 {
 	struct class_device_attribute **attr;
 	int ret = 0;
@@ -358,7 +358,7 @@
 	return ret;
 }

-static void __devexit pccard_sysfs_remove_socket(struct class_device *class_dev)
+static void __devexit pccard_sysfs_remove_socket(struct class_interface *class_intf, struct class_device *class_dev)
 {
 	struct class_device_attribute **attr;

Index: linux-2.6.12/drivers/pcmcia/rsrc_nonstatic.c
===================================================================
--- linux-2.6.12.orig/drivers/pcmcia/rsrc_nonstatic.c	2005-06-30 11:54:56.000000000 -0500
+++ linux-2.6.12/drivers/pcmcia/rsrc_nonstatic.c	2005-06-30 16:03:49.738193763 -0500
@@ -994,7 +994,7 @@
 	NULL,
 };

-static int __devinit pccard_sysfs_add_rsrc(struct class_device *class_dev)
+static int __devinit pccard_sysfs_add_rsrc(struct class_interface *class_intf, struct class_device *class_dev)
 {
 	struct pcmcia_socket *s = class_get_devdata(class_dev);
 	struct class_device_attribute **attr;
@@ -1011,7 +1011,7 @@
 	return ret;
 }

-static void __devexit pccard_sysfs_remove_rsrc(struct class_device *class_dev)
+static void __devexit pccard_sysfs_remove_rsrc(struct class_interface *class_intf, struct class_device *class_dev)
 {
 	struct pcmcia_socket *s = class_get_devdata(class_dev);
 	struct class_device_attribute **attr;
Index: linux-2.6.12/include/linux/device.h
===================================================================
--- linux-2.6.12.orig/include/linux/device.h	2005-06-30 11:54:59.000000000 -0500
+++ linux-2.6.12/include/linux/device.h	2005-06-30 15:59:44.921353866 -0500
@@ -246,8 +246,8 @@
 	struct list_head	node;
 	struct class		*class;

-	int (*add)	(struct class_device *);
-	void (*remove)	(struct class_device *);
+	int (*add)	(struct class_interface *, struct class_device *);
+	void (*remove)	(struct class_interface *, struct class_device *);
 };

 extern int class_interface_register(struct class_interface *);


