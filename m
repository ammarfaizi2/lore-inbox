Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVALFV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVALFV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVALFV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:21:26 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:4017 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261242AbVALFQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:16:44 -0500
Subject: [PATCH] add a generic device transport class
From: James Bottomley <James.Bottomley@SteelEye.com>
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Content-Type: text/plain
Date: Tue, 11 Jan 2005 23:16:50 -0600
Message-Id: <1105507010.13794.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Transport classes are a mechanism for providing transport specific
services to drivers that the more generic command processing layers
don't care about.  A good example is the SCSI mid-layer not caring about
parallel transfer characteristics or providing services for domain
validation.  Transport classes usually provide a transport specific API
at one end and a class interface at the other (for the user to
interrogate and set parameters).

Originally, transport classes were SCSI specific.  However, this code is
generic to the device model.  As long as you have a generic device
representing a storage interface (or device) then you can attach a
transport class to it.  The new code also allows an arbitrary number of
transport classes to be attached to a device, unlike SCSI which only
allowed one.  This is going to be important for things like SATA and SAS
which share the PHY layer (and hence should be capable of sharing a PHY
transport class).

The generic transport class is designed to operate identically to the
current SCSI transport classes, except that it uses generic devices
rather than SCSI devices.
 
We have five events:
 
 setup
 add
 -----
 configure
 -----
 remove
 destroy

With callbacks for setup configure and remove.

There's also an anonymous transport class which can only respond to 
configure events (and which has no attributes).

James

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/11 16:10:43-06:00 jejb@titanic.il.steeleye.com 
#   Add a generic transport class using the attribute container
#   
#   The generic transport class is designed to operate identically to the
#   current SCSI transport classes, except that it uses generic devices
#   rather than SCSI devices.
#   
#   We have five events:
#   
#   setup
#   add
#   -----
#   configure
#   -----
#   remove
#   destroy
#   
#   With callbacks for setup configure and remove.
#   
#   There's also an anonymous transport class which can only respond to 
#   configure events (and which has no attributes).
#   
#   Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
# 
# include/linux/transport_class.h
#   2005/01/11 16:10:29-06:00 jejb@titanic.il.steeleye.com +77 -0
# 
# include/linux/transport_class.h
#   2005/01/11 16:10:29-06:00 jejb@titanic.il.steeleye.com +0 -0
#   BitKeeper file /home/jejb/BK/generic-transport-2.6/include/linux/transport_class.h
# 
# drivers/base/transport_class.c
#   2005/01/11 16:10:28-06:00 jejb@titanic.il.steeleye.com +272 -0
# 
# drivers/base/transport_class.c
#   2005/01/11 16:10:28-06:00 jejb@titanic.il.steeleye.com +0 -0
#   BitKeeper file /home/jejb/BK/generic-transport-2.6/drivers/base/transport_class.c
# 
# drivers/base/Makefile
#   2005/01/11 16:10:28-06:00 jejb@titanic.il.steeleye.com +1 -1
#   Add a generic transport class using the attribute container
# 
diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	2005-01-11 23:06:32 -06:00
+++ b/drivers/base/Makefile	2005-01-11 23:06:32 -06:00
@@ -3,7 +3,7 @@
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
-			   attribute_container.o
+			   attribute_container.o transport_class.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
diff -Nru a/drivers/base/transport_class.c b/drivers/base/transport_class.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/base/transport_class.c	2005-01-11 23:06:32 -06:00
@@ -0,0 +1,272 @@
+/*
+ * transport_class.c - implementation of generic transport classes
+ *                     using attribute_containers
+ *
+ * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
+ *
+ * This file is licensed under GPLv2
+ *
+ * The basic idea here is to allow any "device controller" (which
+ * would most often be a Host Bus Adapter" to use the services of one
+ * or more tranport classes for performing transport specific
+ * services.  Transport specific services are things that the generic
+ * command layer doesn't want to know about (speed settings, line
+ * condidtioning, etc), but which the user might be interested in.
+ * Thus, the HBA's use the routines exported by the transport classes
+ * to perform these functions.  The transport classes export certain
+ * values to the user via sysfs using attribute containers.
+ *
+ * Note: because not every HBA will care about every transport
+ * attribute, there's a many to one relationship that goes like this:
+ *
+ * transport class<-----attribute container<----class device
+ *
+ * Usually the attribute container is per-HBA, but the design doesn't
+ * mandate that.  Although most of the services will be specific to
+ * the actual external storage connection used by the HBA, the generic
+ * transport class is framed entirely in terms of generic devices to
+ * allow it to be used by any physical HBA in the system.
+ */
+#include <linux/attribute_container.h>
+#include <linux/transport_class.h>
+
+/**
+ * transport_class_register - register an initial transport class
+ *
+ * @tclass:	a pointer to the transport class structure to be initialised
+ *
+ * The transport class contains an embedded class which is used to
+ * identify it.  The caller should initialise this structure with
+ * zeros and then generic class must have been initialised with the
+ * actual transport class unique name.  There's a macro
+ * DECLARE_TRANSPORT_CLASS() to do this (declared classes still must
+ * be registered).
+ *
+ * Returns 0 on success or error on failure.
+ */
+int transport_class_register(struct transport_class *tclass)
+{
+	return class_register(&tclass->class);
+}
+EXPORT_SYMBOL(transport_class_register);
+
+/**
+ * transport_class_unregister - unregister a previously registered class
+ *
+ * @tclass: The transport class to unregister
+ *
+ * Must be called prior to deallocating the memory for the transport
+ * class.
+ */
+void transport_class_unregister(struct transport_class *tclass)
+{
+	class_unregister(&tclass->class);
+}
+EXPORT_SYMBOL(transport_class_unregister);
+
+static int anon_transport_dummy_function(struct device *dev)
+{
+	/* do nothing */
+	return 0;
+}
+
+/**
+ * anon_transport_class_register - register an anonymous class
+ *
+ * @atc: The anon transport class to register
+ *
+ * The anonymous transport class contains both a transport class and a
+ * container.  The idea of an anonymous class is that it never
+ * actually has any device attributes associated with it (and thus
+ * saves on container storage).  So it can only be used for triggering
+ * events.  Use prezero and then use DECLARE_ANON_TRANSPORT_CLASS() to
+ * initialise the anon transport class storage.
+ */
+int anon_transport_class_register(struct anon_transport_class *atc)
+{
+	int error;
+	atc->container.class = &atc->tclass.class;
+	attribute_container_set_no_classdevs(&atc->container);
+	error = attribute_container_register(&atc->container);
+	if (error)
+		return error;
+	atc->tclass.setup = anon_transport_dummy_function;
+	atc->tclass.remove = anon_transport_dummy_function;
+	return 0;
+}
+EXPORT_SYMBOL(anon_transport_class_register);
+
+/**
+ * anon_transport_class_unregister - unregister an anon class
+ *
+ * @atc: Pointer to the anon transport class to unregister
+ *
+ * Must be called prior to deallocating the memory for the anon
+ * transport class.
+ */
+void anon_transport_class_unregister(struct anon_transport_class *atc)
+{
+	attribute_container_unregister(&atc->container);
+}
+EXPORT_SYMBOL(anon_transport_class_unregister);
+
+static int transport_setup_classdev(struct attribute_container *cont,
+				    struct device *dev,
+				    struct class_device *classdev)
+{
+	struct transport_class *tclass = class_to_transport_class(cont->class);
+
+	if (tclass->setup)
+		tclass->setup(dev);
+
+	return 0;
+}
+
+/**
+ * transport_setup_device - declare a new dev for transport class association
+ *			    but don't make it visible yet.
+ *
+ * @dev: the generic device representing the entity being added
+ *
+ * Usually, dev represents some component in the HBA system (either
+ * the HBA itself or a device remote across the HBA bus).  This
+ * routine is simply a trigger point to see if any set of transport
+ * classes wishes to associate with the added device.  This allocates
+ * storage for the class device and initialises it, but does not yet
+ * add it to the system or add attributes to it (you do this with
+ * transport_add_device).  If you have no need for a separate setup
+ * and add operations, use transport_register_device (see
+ * transport_class.h).
+ */
+
+void transport_setup_device(struct device *dev)
+{
+	attribute_container_add_device(dev, transport_setup_classdev);
+}
+EXPORT_SYMBOL(transport_setup_device);
+
+
+static int transport_add_classdev(struct attribute_container *cont,
+				  struct device *dev,
+				  struct class_device *classdev)
+{
+	struct class_device_attribute **attrs =	cont->attrs;
+	int i, error;
+
+	error = class_device_add(classdev);
+	if (error)
+		return error;
+	for (i = 0; attrs[i]; i++) {
+		error = class_device_create_file(classdev, attrs[i]);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+/**
+ * transport_add_device - declare a new dev for transport class association
+ *
+ * @dev: the generic device representing the entity being added
+ *
+ * Usually, dev represents some component in the HBA system (either
+ * the HBA itself or a device remote across the HBA bus).  This
+ * routine is simply a trigger point used to add the device to the
+ * system and register attributes for it.
+ */
+
+void transport_add_device(struct device *dev)
+{
+	attribute_container_device_trigger(dev, transport_add_classdev);
+}
+EXPORT_SYMBOL(transport_add_device);
+
+static int transport_configure(struct attribute_container *cont,
+			       struct device *dev)
+{
+	struct transport_class *tclass = class_to_transport_class(cont->class);
+
+	if (tclass->configure)
+		tclass->configure(dev);
+
+	return 0;
+}
+
+/**
+ * transport_configure_device - configure an already set up device
+ *
+ * @dev: generic device representing device to be configured
+ *
+ * The idea of configure is simply to provide a point within the setup
+ * process to allow the transport class to extract information from a
+ * device after it has been setup.  This is used in SCSI because we
+ * have to have a setup device to begin using the HBA, but after we
+ * send the initial inquiry, we use configure to extract the device
+ * parameters.  The device need not have been added to be configured.
+ */
+void transport_configure_device(struct device *dev)
+{
+	attribute_container_trigger(dev, transport_configure);
+}
+EXPORT_SYMBOL(transport_configure_device);
+
+static int transport_remove_classdev(struct attribute_container *cont,
+				     struct device *dev,
+				     struct class_device *classdev)
+{
+	struct transport_class *tclass = class_to_transport_class(cont->class);
+
+	if (tclass->remove)
+		tclass->remove(dev);
+
+	return 0;
+}
+
+
+/**
+ * transport_remove_device - remove the visibility of a device
+ *
+ * @dev: generic device to remove
+ *
+ * This call removes the visibility of the device (to the user from
+ * sysfs), but does not destroy it.  To eliminate a device entirely
+ * you must also call transport_destroy_device.  If you don't need to
+ * do remove and destroy as separate operations, use
+ * transport_unregister_device() (see transport_class.h) which will
+ * perform both calls for you.
+ */
+void transport_remove_device(struct device *dev)
+{
+	attribute_container_device_trigger(dev, transport_remove_classdev);
+}
+EXPORT_SYMBOL(transport_remove_device);
+
+static void transport_destroy_classdev(struct attribute_container *cont,
+				      struct device *dev,
+				      struct class_device *classdev)
+{
+	struct transport_class *tclass = class_to_transport_class(cont->class);
+
+	if (tclass->remove != anon_transport_dummy_function)
+		class_device_put(classdev);
+}
+
+
+/**
+ * transport_destroy_device - destroy a removed device
+ *
+ * @dev: device to eliminate from the transport class.
+ *
+ * This call triggers the elimination of storage associated with the
+ * transport classdev.  Note: all it really does is relinquish a
+ * reference to the classdev.  The memory will not be freed until the
+ * last reference goes to zero.  Note also that the classdev retains a
+ * reference count on dev, so dev too will remain for as long as the
+ * transport class device remains around.
+ */
+void transport_destroy_device(struct device *dev)
+{
+	attribute_container_remove_device(dev, transport_destroy_classdev);
+}
+EXPORT_SYMBOL(transport_destroy_device);
diff -Nru a/include/linux/transport_class.h b/include/linux/transport_class.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/transport_class.h	2005-01-11 23:06:32 -06:00
@@ -0,0 +1,77 @@
+/*
+ * transport_class.h - a generic container for all transport classes
+ *
+ * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
+ *
+ * This file is licensed under GPLv2
+ */
+
+#ifndef _TRANSPORT_CLASS_H_
+#define _TRANSPORT_CLASS_H_
+
+#include <linux/device.h>
+#include <linux/attribute_container.h>
+
+struct transport_class {
+	struct class class;
+	int (*setup)(struct device *);
+	int (*configure)(struct device *);
+	int (*remove)(struct device *);
+};
+
+#define DECLARE_TRANSPORT_CLASS(cls, nm, su, rm, cfg)			\
+struct transport_class cls = {						\
+	.class = {							\
+		.name = nm,						\
+	},								\
+	.setup = su,							\
+	.remove = rm,							\
+	.configure = cfg,						\
+}
+
+
+struct anon_transport_class {
+	struct transport_class tclass;
+	struct attribute_container container;
+};
+
+#define DECLARE_ANON_TRANSPORT_CLASS(cls, mtch, cfg)		\
+struct anon_transport_class cls = {				\
+	.tclass = {						\
+		.configure = cfg,				\
+	},							\
+	. container = {						\
+		.match = mtch,					\
+	},							\
+}
+
+#define class_to_transport_class(x) \
+	container_of(x, struct transport_class, class)
+
+void transport_remove_device(struct device *);
+void transport_add_device(struct device *);
+void transport_setup_device(struct device *);
+void transport_configure_device(struct device *);
+void transport_destroy_device(struct device *);
+
+static inline void
+transport_register_device(struct device *dev)
+{
+	transport_setup_device(dev);
+	transport_add_device(dev);
+}
+
+static inline void
+transport_unregister_device(struct device *dev)
+{
+	transport_remove_device(dev);
+	transport_destroy_device(dev);
+}
+
+int transport_class_register(struct transport_class *);
+int anon_transport_class_register(struct anon_transport_class *);
+void transport_class_unregister(struct transport_class *);
+void anon_transport_class_unregister(struct anon_transport_class *);
+
+
+#endif


