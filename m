Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVALUZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVALUZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVALUYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:24:18 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:42113 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261402AbVALURg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:17:36 -0500
Subject: Re: [PATCH] Add attribute container to the generic device model
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112070802.GB2085@kroah.com>
References: <1105506370.10378.26.camel@mulgrave>
	 <20050112070802.GB2085@kroah.com>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 14:17:25 -0600
Message-Id: <1105561045.8030.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about the attached.  It makes all the symbols EXPORT_SYMBOL_GPL,
updates the docs for the attribute_container_add_device function and
also integrates with the driver_init() function of drivers/base.

James

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/12 14:06:25-06:00 jejb@titanic.il.steeleye.com 
#   update
# 
# include/linux/attribute_container.h
#   2005/01/12 13:55:02-06:00 jejb@titanic.il.steeleye.com +61 -0
# 
# include/linux/attribute_container.h
#   2005/01/12 13:55:02-06:00 jejb@titanic.il.steeleye.com +0 -0
#   BitKeeper file /home/jejb/BK/BUILD-2.6/include/linux/attribute_container.h
# 
# drivers/base/attribute_container.c
#   2005/01/12 13:55:00-06:00 jejb@titanic.il.steeleye.com +274 -0
# 
# drivers/base/init.c
#   2005/01/12 13:55:00-06:00 jejb@titanic.il.steeleye.com +2 -1
#   update
# 
# drivers/base/attribute_container.c
#   2005/01/12 13:55:00-06:00 jejb@titanic.il.steeleye.com +0 -0
#   BitKeeper file /home/jejb/BK/BUILD-2.6/drivers/base/attribute_container.c
# 
# drivers/base/Makefile
#   2005/01/12 13:55:00-06:00 jejb@titanic.il.steeleye.com +2 -1
#   update
# 
diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	2005-01-12 14:06:54 -06:00
+++ b/drivers/base/Makefile	2005-01-12 14:06:54 -06:00
@@ -2,7 +2,8 @@
 
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
-			   cpu.o firmware.o init.o map.o dmapool.o
+			   cpu.o firmware.o init.o map.o dmapool.o \
+			   attribute_container.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
diff -Nru a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/base/attribute_container.c	2005-01-12 14:06:54 -06:00
@@ -0,0 +1,274 @@
+/*
+ * attribute_container.c - implementation of a simple container for classes
+ *
+ * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
+ *
+ * This file is licensed under GPLv2
+ *
+ * The basic idea here is to enable a device to be attached to an
+ * aritrary numer of classes without having to allocate storage for them.
+ * Instead, the contained classes select the devices they need to attach
+ * to via a matching function.
+ */
+
+#include <linux/attribute_container.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/module.h>
+
+/* This is a private structure used to tie the classdev and the
+ * container .. it should never be visible outside this file */
+struct internal_container {
+	struct list_head node;
+	struct attribute_container *cont;
+	struct class_device classdev;
+};
+
+/**
+ * attribute_container_classdev_to_container - given a classdev, return the container
+ *
+ * @classdev: the class device created by attribute_container_add_device.
+ *
+ * Returns the container associated with this classdev.
+ */
+struct attribute_container *
+attribute_container_classdev_to_container(struct class_device *classdev)
+{
+	struct internal_container *ic =
+		container_of(classdev, struct internal_container, classdev);
+	return ic->cont;
+}
+EXPORT_SYMBOL_GPL(attribute_container_classdev_to_container);
+
+static struct list_head attribute_container_list;
+
+static DECLARE_MUTEX(attribute_container_mutex);
+
+/**
+ * attribute_container_register - register an attribute container
+ *
+ * @cont: The container to register.  This must be allocated by the
+ *        callee and should also be zeroed by it.
+ */
+int
+attribute_container_register(struct attribute_container *cont)
+{
+	INIT_LIST_HEAD(&cont->node);
+	INIT_LIST_HEAD(&cont->containers);
+		
+	down(&attribute_container_mutex);
+	list_add_tail(&cont->node, &attribute_container_list);
+	up(&attribute_container_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(attribute_container_register);
+
+/**
+ * attribute_container_unregister - remove a container registration
+ *
+ * @cont: previously registered container to remove
+ */
+int
+attribute_container_unregister(struct attribute_container *cont)
+{
+	int retval = -EBUSY;
+	down(&attribute_container_mutex);
+	if (!list_empty(&cont->containers))
+		goto out;
+	retval = 0;
+	list_del(&cont->node);
+ out:
+	up(&attribute_container_mutex);
+	return retval;
+		
+}
+EXPORT_SYMBOL_GPL(attribute_container_unregister);
+
+/* private function used as class release */
+static void attribute_container_release(struct class_device *classdev)
+{
+	struct internal_container *ic 
+		= container_of(classdev, struct internal_container, classdev);
+	struct device *dev = classdev->dev;
+
+	kfree(ic);
+	put_device(dev);
+}
+
+/**
+ * attribute_container_add_device - see if any container is interested in dev
+ *
+ * @dev: device to add attributes to
+ * @fn:	 function to trigger addition of class device.
+ *
+ * This function allocates storage for the class device(s) to be
+ * attached to dev (one for each matching attribute_container).  If no
+ * fn is provided, the code will simply register the class device via
+ * class_device_add.  If a function is provided, it is expected to add
+ * the class device at the appropriate time.  One of the things that
+ * might be necessary is to allocate and initialise the classdev and
+ * then add it a later time.  To do this, call this routine for
+ * allocation and initialisation and then use
+ * attribute_container_device_trigger() to call class_device_add() on
+ * it.  Note: after this, the class device contains a reference to dev
+ * which is not relinquished until the release of the classdev.
+ */
+void
+attribute_container_add_device(struct device *dev,
+			       int (*fn)(struct attribute_container *,
+					 struct device *,
+					 struct class_device *))
+{
+	struct attribute_container *cont;
+
+	down(&attribute_container_mutex);
+	list_for_each_entry(cont, &attribute_container_list, node) {
+		struct internal_container *ic;
+
+		if (attribute_container_no_classdevs(cont))
+			continue;
+
+		if (!cont->match(cont, dev))
+			continue;
+		ic = kmalloc(sizeof(struct internal_container), GFP_KERNEL);
+		if (!ic) {
+			dev_printk(KERN_ERR, dev, "failed to allocate class container\n");
+			continue;
+		}
+		memset(ic, 0, sizeof(struct internal_container));
+		INIT_LIST_HEAD(&ic->node);
+		ic->cont = cont;
+		class_device_initialize(&ic->classdev);
+		ic->classdev.dev = get_device(dev);
+		ic->classdev.class = cont->class;
+		cont->class->release = attribute_container_release;
+		strcpy(ic->classdev.class_id, dev->bus_id);
+		if (fn)
+			fn(cont, dev, &ic->classdev);
+		else
+			class_device_add(&ic->classdev);
+		list_add_tail(&ic->node, &cont->containers);
+	}
+	up(&attribute_container_mutex);
+}
+
+/**
+ * attribute_container_remove_device - make device eligible for removal.
+ *
+ * @dev:  The generic device
+ * @fn:	  A function to call to remove the device
+ *
+ * This routine triggers device removal.  If fn is NULL, then it is
+ * simply done via class_device_unregister (note that if something
+ * still has a reference to the classdev, then the memory occupied
+ * will not be freed until the classdev is released).  If you want a
+ * two phase release: remove from visibility and then delete the
+ * device, then you should use this routine with a fn that calls
+ * class_device_del() and then use
+ * attribute_container_device_trigger() to do the final put on the
+ * classdev.
+ */
+void
+attribute_container_remove_device(struct device *dev,
+				  void (*fn)(struct attribute_container *,
+					     struct device *,
+					     struct class_device *))
+{
+	struct attribute_container *cont;
+
+	down(&attribute_container_mutex);
+	list_for_each_entry(cont, &attribute_container_list, node) {
+		struct internal_container *ic, *tmp;
+
+		if (attribute_container_no_classdevs(cont))
+			continue;
+
+		if (!cont->match(cont, dev))
+			continue;
+		list_for_each_entry_safe(ic, tmp, &cont->containers, node) {
+			if (dev != ic->classdev.dev)
+				continue;
+			list_del(&ic->node);
+			if (fn)
+				fn(cont, dev, &ic->classdev);
+			else
+				class_device_unregister(&ic->classdev);
+		}
+	}
+	up(&attribute_container_mutex);
+}
+EXPORT_SYMBOL_GPL(attribute_container_remove_device);
+
+/**
+ * attribute_container_device_trigger - execute a trigger for each matching classdev
+ *
+ * @dev:  The generic device to run the trigger for
+ * @fn	  the function to execute for each classdev.
+ *
+ * This funcion is for executing a trigger when you need to know both
+ * the container and the classdev.  If you only care about the
+ * container, then use attribute_container_trigger() instead.
+ */
+void
+attribute_container_device_trigger(struct device *dev, 
+				   int (*fn)(struct attribute_container *,
+					     struct device *,
+					     struct class_device *))
+{
+	struct attribute_container *cont;
+
+	down(&attribute_container_mutex);
+	list_for_each_entry(cont, &attribute_container_list, node) {
+		struct internal_container *ic, *tmp;
+
+		if (!cont->match(cont, dev))
+			continue;
+
+		list_for_each_entry_safe(ic, tmp, &cont->containers, node) {
+			if (dev == ic->classdev.dev)
+				fn(cont, dev, &ic->classdev);
+		}
+	}
+	up(&attribute_container_mutex);
+}
+EXPORT_SYMBOL_GPL(attribute_container_device_trigger);
+
+/**
+ * attribute_container_trigger - trigger a function for each matching container
+ *
+ * @dev:  The generic device to activate the trigger for
+ * @fn:	  the function to trigger
+ *
+ * This routine triggers a function that only needs to know the
+ * matching containers (not the classdev) associated with a device.
+ * It is more lightweight than attribute_container_device_trigger, so
+ * should be used in preference unless the triggering function
+ * actually needs to know the classdev.
+ */
+void
+attribute_container_trigger(struct device *dev,
+			    int (*fn)(struct attribute_container *,
+				      struct device *))
+{
+	struct attribute_container *cont;
+
+	down(&attribute_container_mutex);
+	list_for_each_entry(cont, &attribute_container_list, node) {
+		if (cont->match(cont, dev))
+			fn(cont, dev);
+	}
+	up(&attribute_container_mutex);
+}
+EXPORT_SYMBOL_GPL(attribute_container_trigger);
+     
+
+int __init
+attribute_container_init(void)
+{
+	INIT_LIST_HEAD(&attribute_container_list);
+	return 0;
+}
diff -Nru a/drivers/base/init.c b/drivers/base/init.c
--- a/drivers/base/init.c	2005-01-12 14:06:54 -06:00
+++ b/drivers/base/init.c	2005-01-12 14:06:54 -06:00
@@ -17,7 +17,7 @@
 extern int platform_bus_init(void);
 extern int system_bus_init(void);
 extern int cpu_dev_init(void);
-
+extern int attribute_container_init(void);
 /**
  *	driver_init - initialize driver model.
  *
@@ -39,4 +39,5 @@
 	platform_bus_init();
 	system_bus_init();
 	cpu_dev_init();
+	attribute_container_init();
 }
diff -Nru a/include/linux/attribute_container.h b/include/linux/attribute_container.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/attribute_container.h	2005-01-12 14:06:54 -06:00
@@ -0,0 +1,61 @@
+/*
+ * class_container.h - a generic container for all classes
+ *
+ * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
+ *
+ * This file is licensed under GPLv2
+ */
+
+#ifndef _ATTRIBUTE_CONTAINER_H_
+#define _ATTRIBUTE_CONTAINER_H_
+
+#include <linux/device.h>
+#include <linux/list.h>
+
+struct attribute_container {
+	struct list_head	node;
+	struct list_head	containers;
+	struct class		*class;
+	struct class_device_attribute **attrs;
+	int (*match)(struct attribute_container *, struct device *);
+#define	ATTRIBUTE_CONTAINER_NO_CLASSDEVS	0x01
+	unsigned long		flags;
+};
+
+static inline int
+attribute_container_no_classdevs(struct attribute_container *atc)
+{
+	return atc->flags & ATTRIBUTE_CONTAINER_NO_CLASSDEVS;
+}
+
+static inline void
+attribute_container_set_no_classdevs(struct attribute_container *atc)
+{
+	atc->flags |= ATTRIBUTE_CONTAINER_NO_CLASSDEVS;
+}
+
+int attribute_container_register(struct attribute_container *cont);
+int attribute_container_unregister(struct attribute_container *cont);
+void attribute_container_create_device(struct device *dev,
+				       int (*fn)(struct attribute_container *,
+						 struct device *,
+						 struct class_device *));
+void attribute_container_add_device(struct device *dev,
+				    int (*fn)(struct attribute_container *,
+					      struct device *,
+					      struct class_device *));
+void attribute_container_remove_device(struct device *dev,
+				       void (*fn)(struct attribute_container *,
+						  struct device *,
+						  struct class_device *));
+void attribute_container_device_trigger(struct device *dev, 
+					int (*fn)(struct attribute_container *,
+						  struct device *,
+						  struct class_device *));
+void attribute_container_trigger(struct device *dev, 
+				 int (*fn)(struct attribute_container *,
+					   struct device *));
+
+struct class_device_attribute **attribute_container_classdev_to_attrs(const struct class_device *classdev);
+
+#endif


