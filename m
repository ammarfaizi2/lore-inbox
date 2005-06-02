Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFBVQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFBVQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:16:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30407 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261312AbVFBVEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:04:02 -0400
Date: Thu, 2 Jun 2005 14:03:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: torvalds@osdl.org, akpm@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][1/5] RapidIO support: core
Message-ID: <20050602140359.B24818@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a RapidIO subsystem to the kernel. RIO is a switched
fabric interconnect used in higher-end embedded applications.
The curious can look at the specs over at http://www.rapidio.org

The core code implements enumeration/discovery, management of
devices/resources, and interfaces for RIO drivers.

There's a lot more to do to take advantages of all the hardware
features. However, this should provide a good base for folks
with RIO hardware to start contributing.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Index: Documentation/DocBook/Makefile
===================================================================
--- 3c5e9440c6a37c3355b50608836a23c8fa4eec99/Documentation/DocBook/Makefile  (mode:100644)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/Documentation/DocBook/Makefile  (mode:100644)
@@ -10,7 +10,7 @@
 	    kernel-hacking.xml kernel-locking.xml deviceiobook.xml \
 	    procfs-guide.xml writing_usb_driver.xml scsidrivers.xml \
 	    sis900.xml kernel-api.xml journal-api.xml lsm.xml usb.xml \
-	    gadget.xml libata.xml mtdnand.xml librs.xml
+	    gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml
 
 ###
 # The build process is as follows (targets):
Index: Documentation/DocBook/rapidio.tmpl
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/Documentation/DocBook/rapidio.tmpl  (mode:100644)
@@ -0,0 +1,160 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+        "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" [
+	<!ENTITY rapidio SYSTEM "rapidio.xml">
+	]>
+
+<book id="RapidIO-Guide">
+ <bookinfo>
+  <title>RapidIO Subsystem Guide</title>
+  
+  <authorgroup>
+   <author>
+    <firstname>Matt</firstname>
+    <surname>Porter</surname>
+    <affiliation>
+     <address>
+      <email>mporter@kernel.crashing.org</email>
+      <email>mporter@mvista.com</email>
+     </address>
+    </affiliation>
+   </author>
+  </authorgroup>
+
+  <copyright>
+   <year>2005</year>
+   <holder>MontaVista Software, Inc.</holder>
+  </copyright>
+
+  <legalnotice>
+   <para>
+     This documentation is free software; you can redistribute
+     it and/or modify it under the terms of the GNU General Public
+     License version 2 as published by the Free Software Foundation.
+   </para>
+      
+   <para>
+     This program is distributed in the hope that it will be
+     useful, but WITHOUT ANY WARRANTY; without even the implied
+     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+     See the GNU General Public License for more details.
+   </para>
+      
+   <para>
+     You should have received a copy of the GNU General Public
+     License along with this program; if not, write to the Free
+     Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+     MA 02111-1307 USA
+   </para>
+      
+   <para>
+     For more details see the file COPYING in the source
+     distribution of Linux.
+   </para>
+  </legalnotice>
+ </bookinfo>
+
+<toc></toc>
+
+  <chapter id="intro">
+      <title>Introduction</title>
+  <para>
+	RapidIO is a high speed switched fabric interconnect with
+	features aimed at the embedded market.  RapidIO provides
+	support for memory-mapped I/O as well as message-based
+	transactions over the switched fabric network. RapidIO has
+	a standardized discovery mechanism not unlike the PCI bus
+	standard that allows simple detection of devices in a
+	network.
+  </para>
+  <para>
+  	This documentation is provided for developers intending
+	to support RapidIO on new architectures, write new drivers,
+	or to understand the subsystem internals.
+  </para>
+  </chapter>
+  
+  <chapter id="bugs">
+     <title>Known Bugs and Limitations</title>
+
+     <sect1>
+     	<title>Bugs</title>
+	  <para>None. ;)</para>
+     </sect1>
+     <sect1>
+     	<title>Limitations</title>
+	  <para>
+	    <orderedlist>
+	      <listitem><para>Access/management of RapidIO memory regions is not supported</para></listitem>
+	      <listitem><para>Multiple host enumeration is not supported</para></listitem>
+	    </orderedlist>
+	 </para>
+     </sect1>
+  </chapter>
+
+  <chapter id="drivers">
+     	<title>RapidIO driver interface</title>
+	<para>
+		Drivers are provided a set of calls in order
+		to interface with the subsystem to gather info
+		on devices, request/map memory region resources,
+		and manage mailboxes/doorbells.
+	</para>
+	<sect1>
+		<title>Functions</title>
+!Iinclude/linux/rio_drv.h
+!Edrivers/rio/rio-driver.c
+!Edrivers/rio/rio.c
+	</sect1>
+  </chapter>	
+
+  <chapter id="internals">
+     <title>Internals</title>
+
+     <para>
+     This chapter contains the autogenerated documentation of the RapidIO
+     subsystem.
+     </para>
+
+     <sect1><title>Structures</title>
+!Iinclude/linux/rio.h
+     </sect1>
+     <sect1><title>Enumeration and Discovery</title>
+!Idrivers/rio/rio-scan.c
+     </sect1>
+     <sect1><title>Driver functionality</title>
+!Idrivers/rio/rio.c
+!Idrivers/rio/rio-access.c
+     </sect1>
+     <sect1><title>Device model support</title>
+!Idrivers/rio/rio-driver.c
+     </sect1>
+     <sect1><title>Sysfs support</title>
+!Idrivers/rio/rio-sysfs.c
+     </sect1>
+     <sect1><title>PPC32 support</title>
+!Iarch/ppc/kernel/rio.c
+!Earch/ppc/syslib/ppc85xx_rio.c
+!Iarch/ppc/syslib/ppc85xx_rio.c
+     </sect1>
+  </chapter>
+
+  <chapter id="credits">
+     <title>Credits</title>
+	<para>
+		The following people have contributed to the RapidIO
+		subsystem directly or indirectly:
+		<orderedlist>
+			<listitem><para>Matt Porter<email>mporter@kernel.crashing.org</email></para></listitem>
+			<listitem><para>Randy Vinson<email>rvinson@mvista.com</email></para></listitem>
+			<listitem><para>Dan Malek<email>dan@embeddedalley.com</email></para></listitem>
+		</orderedlist>
+	</para>
+	<para>
+		The following people have contributed to this document:
+		<orderedlist>
+			<listitem><para>Matt Porter<email>mporter@kernel.crashing.org</email></para></listitem>
+		</orderedlist>
+	</para>
+  </chapter>
+</book>
Index: drivers/Makefile
===================================================================
--- 3c5e9440c6a37c3355b50608836a23c8fa4eec99/drivers/Makefile  (mode:100644)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/Makefile  (mode:100644)
@@ -7,6 +7,7 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
+obj-$(CONFIG_RAPIDIO)		+= rio/
 obj-y				+= video/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
Index: drivers/rio/Kconfig
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/Kconfig  (mode:100644)
@@ -0,0 +1,18 @@
+#
+# RapidIO configuration
+#
+config RAPIDIO_8_BIT_TRANSPORT
+	bool "8-bit transport addressing"
+	depends on RAPIDIO
+	---help---
+	  By default, the kernel assumes a 16-bit addressed RapidIO
+	  network. By selecting this option, the kernel will support
+	  an 8-bit addressed network.
+
+config RAPIDIO_DISC_TIMEOUT
+	int "Discovery timeout duration (seconds)"
+	depends on RAPIDIO
+	default "30"
+	---help---
+	  Amount of time a discovery node waits for a host to complete
+	  enumeration beforing giving up.
Index: drivers/rio/Makefile
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/Makefile  (mode:100644)
@@ -0,0 +1,6 @@
+#
+# Makefile for RapidIO interconnect services
+#
+obj-y += rio.o rio-access.o rio-driver.o rio-scan.o rio-sysfs.o
+
+obj-$(CONFIG_RAPIDIO)		+= switches/
Index: drivers/rio/rio-access.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/rio-access.c  (mode:100644)
@@ -0,0 +1,175 @@
+/*
+ * RapidIO configuration space access support
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/rio.h>
+#include <linux/module.h>
+
+/*
+ * These interrupt-safe spinlocks protect all accesses to RIO
+ * configuration space and doorbell access.
+ */
+static spinlock_t rio_config_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t rio_doorbell_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ *  Wrappers for all RIO configuration access functions.  They just check
+ *  alignment, do locking and call the low-level functions pointed to
+ *  by rio_mport->ops.
+ */
+
+#define RIO_8_BAD 0
+#define RIO_16_BAD (offset & 1)
+#define RIO_32_BAD (offset & 3)
+
+/**
+ * RIO_LOP_READ - Generate rio_local_read_config_* functions
+ * @size: Size of configuration space read (8, 16, 32 bits)
+ * @type: C type of value argument
+ * @len: Length of configuration space read (1, 2, 4 bytes)
+ *
+ * Generates rio_local_read_config_* functions used to access
+ * configuration space registers on the local device.
+ */
+#define RIO_LOP_READ(size,type,len) \
+int __rio_local_read_config_##size \
+	(struct rio_mport *mport, u32 offset, type *value)		\
+{									\
+	int res;							\
+	unsigned long flags;						\
+	u32 data = 0;							\
+	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
+	spin_lock_irqsave(&rio_config_lock, flags);			\
+	res = mport->ops->lcread(mport->id, offset, len, &data);	\
+	*value = (type)data;						\
+	spin_unlock_irqrestore(&rio_config_lock, flags);		\
+	return res;							\
+}
+
+/**
+ * RIO_LOP_WRITE - Generate rio_local_write_config_* functions
+ * @size: Size of configuration space write (8, 16, 32 bits)
+ * @type: C type of value argument
+ * @len: Length of configuration space write (1, 2, 4 bytes)
+ *
+ * Generates rio_local_write_config_* functions used to access
+ * configuration space registers on the local device.
+ */
+#define RIO_LOP_WRITE(size,type,len) \
+int __rio_local_write_config_##size \
+	(struct rio_mport *mport, u32 offset, type value)		\
+{									\
+	int res;							\
+	unsigned long flags;						\
+	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
+	spin_lock_irqsave(&rio_config_lock, flags);			\
+	res = mport->ops->lcwrite(mport->id, offset, len, value);	\
+	spin_unlock_irqrestore(&rio_config_lock, flags);		\
+	return res;							\
+}
+
+RIO_LOP_READ(8, u8, 1)
+    RIO_LOP_READ(16, u16, 2)
+    RIO_LOP_READ(32, u32, 4)
+    RIO_LOP_WRITE(8, u8, 1)
+    RIO_LOP_WRITE(16, u16, 2)
+    RIO_LOP_WRITE(32, u32, 4)
+
+    EXPORT_SYMBOL(__rio_local_read_config_8);
+EXPORT_SYMBOL(__rio_local_read_config_16);
+EXPORT_SYMBOL(__rio_local_read_config_32);
+EXPORT_SYMBOL(__rio_local_write_config_8);
+EXPORT_SYMBOL(__rio_local_write_config_16);
+EXPORT_SYMBOL(__rio_local_write_config_32);
+
+/**
+ * RIO_OP_READ - Generate rio_mport_read_config_* functions
+ * @size: Size of configuration space read (8, 16, 32 bits)
+ * @type: C type of value argument
+ * @len: Length of configuration space read (1, 2, 4 bytes)
+ *
+ * Generates rio_mport_read_config_* functions used to access
+ * configuration space registers on the local device.
+ */
+#define RIO_OP_READ(size,type,len) \
+int rio_mport_read_config_##size \
+	(struct rio_mport *mport, u16 destid, u8 hopcount, u32 offset, type *value)	\
+{									\
+	int res;							\
+	unsigned long flags;						\
+	u32 data = 0;							\
+	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
+	spin_lock_irqsave(&rio_config_lock, flags);			\
+	res = mport->ops->cread(mport->id, destid, hopcount, offset, len, &data); \
+	*value = (type)data;						\
+	spin_unlock_irqrestore(&rio_config_lock, flags);		\
+	return res;							\
+}
+
+/**
+ * RIO_OP_WRITE - Generate rio_mport_write_config_* functions
+ * @size: Size of configuration space write (8, 16, 32 bits)
+ * @type: C type of value argument
+ * @len: Length of configuration space write (1, 2, 4 bytes)
+ *
+ * Generates rio_mport_write_config_* functions used to access
+ * configuration space registers on the local device.
+ */
+#define RIO_OP_WRITE(size,type,len) \
+int rio_mport_write_config_##size \
+	(struct rio_mport *mport, u16 destid, u8 hopcount, u32 offset, type value)	\
+{									\
+	int res;							\
+	unsigned long flags;						\
+	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
+	spin_lock_irqsave(&rio_config_lock, flags);			\
+	res = mport->ops->cwrite(mport->id, destid, hopcount, offset, len, value); \
+	spin_unlock_irqrestore(&rio_config_lock, flags);		\
+	return res;							\
+}
+
+RIO_OP_READ(8, u8, 1)
+    RIO_OP_READ(16, u16, 2)
+    RIO_OP_READ(32, u32, 4)
+    RIO_OP_WRITE(8, u8, 1)
+    RIO_OP_WRITE(16, u16, 2)
+    RIO_OP_WRITE(32, u32, 4)
+
+    EXPORT_SYMBOL(rio_mport_read_config_8);
+EXPORT_SYMBOL(rio_mport_read_config_16);
+EXPORT_SYMBOL(rio_mport_read_config_32);
+EXPORT_SYMBOL(rio_mport_write_config_8);
+EXPORT_SYMBOL(rio_mport_write_config_16);
+EXPORT_SYMBOL(rio_mport_write_config_32);
+
+/**
+ * rio_mport_send_doorbell - Send a doorbell message
+ *
+ * @mport: RIO master port
+ * @destid: RIO device destination ID
+ * @data: Doorbell message data
+ *
+ * Send a doorbell message to a RIO device. The doorbell message
+ * has a 16-bit info field provided by the data argument.
+ */
+int rio_mport_send_doorbell(struct rio_mport *mport, u16 destid, u16 data)
+{
+	int res;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rio_doorbell_lock, flags);
+	res = mport->ops->dsend(mport->id, destid, data);
+	spin_unlock_irqrestore(&rio_doorbell_lock, flags);
+
+	return res;
+}
+
+EXPORT_SYMBOL(rio_mport_send_doorbell);
Index: drivers/rio/rio-driver.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/rio-driver.c  (mode:100644)
@@ -0,0 +1,229 @@
+/*
+ * RapidIO driver support
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rio.h>
+#include <linux/rio_ids.h>
+
+#include "rio.h"
+
+/**
+ *  rio_match_device - Tell if a RIO device has a matching RIO device id structure
+ *  @id: the RIO device id structure to match against
+ *  @rdev: the RIO device structure to match against
+ *
+ *  Used from driver probe and bus matching to check whether a RIO device
+ *  matches a device id structure provided by a RIO driver. Returns the
+ *  matching &struct rio_device_id or %NULL if there is no match.
+ */
+static const struct rio_device_id *rio_match_device(const struct rio_device_id
+						    *id,
+						    const struct rio_dev *rdev)
+{
+	while (id->vid || id->asm_vid) {
+		if (((id->vid == RIO_ANY_ID) || (id->vid == rdev->vid)) &&
+		    ((id->did == RIO_ANY_ID) || (id->did == rdev->did)) &&
+		    ((id->asm_vid == RIO_ANY_ID)
+		     || (id->asm_vid == rdev->asm_vid))
+		    && ((id->asm_did == RIO_ANY_ID)
+			|| (id->asm_did == rdev->asm_did)))
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
+/**
+ * rio_dev_get - Increments the reference count of the RIO device structure
+ *
+ * @rdev: RIO device being referenced
+ *
+ * Each live reference to a device should be refcounted.
+ *
+ * Drivers for RIO devices should normally record such references in
+ * their probe() methods, when they bind to a device, and release
+ * them by calling rio_dev_put(), in their disconnect() methods.
+ */
+struct rio_dev *rio_dev_get(struct rio_dev *rdev)
+{
+	if (rdev)
+		get_device(&rdev->dev);
+
+	return rdev;
+}
+
+/**
+ * rio_dev_put - Release a use of the RIO device structure
+ *
+ * @rdev: RIO device being disconnected
+ *
+ * Must be called when a user of a device is finished with it.
+ * When the last user of the device calls this function, the
+ * memory of the device is freed.
+ */
+void rio_dev_put(struct rio_dev *rdev)
+{
+	if (rdev)
+		put_device(&rdev->dev);
+}
+
+/**
+ *  rio_device_probe - Tell if a RIO device structure has a matching RIO
+ *                     device id structure
+ *  @id: the RIO device id structure to match against
+ *  @dev: the RIO device structure to match against
+ *
+ * return 0 and set rio_dev->driver when drv claims rio_dev, else error
+ */
+static int rio_device_probe(struct device *dev)
+{
+	struct rio_driver *rdrv = to_rio_driver(dev->driver);
+	struct rio_dev *rdev = to_rio_dev(dev);
+	int error = -ENODEV;
+	const struct rio_device_id *id;
+
+	if (!rdev->driver && rdrv->probe) {
+		if (!rdrv->id_table)
+			return error;
+		id = rio_match_device(rdrv->id_table, rdev);
+		rio_dev_get(rdev);
+		if (id)
+			error = rdrv->probe(rdev, id);
+		if (error >= 0) {
+			rdev->driver = rdrv;
+			error = 0;
+			rio_dev_put(rdev);
+		}
+	}
+	return error;
+}
+
+/**
+ *  rio_device_remove - Remove a RIO device from the system
+ *
+ *  @dev: the RIO device structure to match against
+ *
+ * Remove a RIO device from the system. If it has an associated
+ * driver, then run the driver remove() method.  Then update
+ * the reference count.
+ */
+static int rio_device_remove(struct device *dev)
+{
+	struct rio_dev *rdev = to_rio_dev(dev);
+	struct rio_driver *rdrv = rdev->driver;
+
+	if (rdrv) {
+		if (rdrv->remove)
+			rdrv->remove(rdev);
+		rdev->driver = NULL;
+	}
+
+	rio_dev_put(rdev);
+
+	return 0;
+}
+
+/**
+ *  rio_register_driver - register a new RIO driver
+ *  @rdrv: the RIO driver structure to register
+ *
+ *  Adds a &struct rio_driver to the list of registered drivers
+ *  Returns a negative value on error, otherwise 0. If no error
+ *  occurred, the driver remains registered even if no device
+ *  was claimed during registration.
+ */
+int rio_register_driver(struct rio_driver *rdrv)
+{
+	/* initialize common driver fields */
+	rdrv->driver.name = rdrv->name;
+	rdrv->driver.bus = &rio_bus_type;
+	rdrv->driver.probe = rio_device_probe;
+	rdrv->driver.remove = rio_device_remove;
+
+	/* register with core */
+	return driver_register(&rdrv->driver);
+}
+
+/**
+ *  rio_unregister_driver - unregister a RIO driver
+ *  @rdrv: the RIO driver structure to unregister
+ *
+ *  Deletes the &struct rio_driver from the list of registered RIO
+ *  drivers, gives it a chance to clean up by calling its remove()
+ *  function for each device it was responsible for, and marks those
+ *  devices as driverless.
+ */
+void rio_unregister_driver(struct rio_driver *rdrv)
+{
+	driver_unregister(&rdrv->driver);
+}
+
+/**
+ *  rio_match_bus - Tell if a RIO device structure has a matching RIO
+ *                  driver device id structure
+ *  @dev: the standard device structure to match against
+ *  @drv: the standard driver structure containing the ids to match against
+ *
+ *  Used by a driver to check whether a RIO device present in the
+ *  system is in its list of supported devices. Returns 1 if
+ *  there is a matching &struct rio_device_id or 0 if there is
+ *  no match.
+ */
+static int rio_match_bus(struct device *dev, struct device_driver *drv)
+{
+	struct rio_dev *rdev = to_rio_dev(dev);
+	struct rio_driver *rdrv = to_rio_driver(drv);
+	const struct rio_device_id *id = rdrv->id_table;
+	const struct rio_device_id *found_id;
+
+	if (!id)
+		goto out;
+
+	found_id = rio_match_device(id, rdev);
+
+	if (found_id)
+		return 1;
+
+      out:return 0;
+}
+
+static struct device rio_bus = {
+	.bus_id = "rapidio",
+};
+
+struct bus_type rio_bus_type = {
+	.name = "rapidio",
+	.match = rio_match_bus,
+	.dev_attrs = rio_dev_attrs
+};
+
+/**
+ *  rio_bus_init - Register the RapidIO bus with the device model
+ *
+ *  Registers the RIO bus device and RIO bus type with the Linux
+ *  device model.
+ */
+static int __init rio_bus_init(void)
+{
+	if (device_register(&rio_bus) < 0)
+		printk("RIO: failed to register RIO bus device\n");
+	return bus_register(&rio_bus_type);
+}
+
+postcore_initcall(rio_bus_init);
+
+EXPORT_SYMBOL(rio_register_driver);
+EXPORT_SYMBOL(rio_unregister_driver);
+EXPORT_SYMBOL(rio_bus_type);
+EXPORT_SYMBOL(rio_dev_get);
+EXPORT_SYMBOL(rio_dev_put);
Index: drivers/rio/rio-sysfs.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/rio-sysfs.c  (mode:100644)
@@ -0,0 +1,196 @@
+/*
+ * RapidIO sysfs attributes and support
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/rio.h>
+#include <linux/rio_drv.h>
+#include <linux/stat.h>
+
+#include "rio.h"
+
+/* Sysfs support */
+#define rio_config_attr(field, format_string)					\
+static ssize_t								\
+	field##_show(struct device *dev, char *buf)			\
+{									\
+	struct rio_dev *rdev = to_rio_dev(dev);				\
+									\
+	return sprintf(buf, format_string, rdev->field);		\
+}									\
+
+rio_config_attr(did, "0x%04x\n");
+rio_config_attr(vid, "0x%04x\n");
+rio_config_attr(device_rev, "0x%08x\n");
+rio_config_attr(asm_did, "0x%04x\n");
+rio_config_attr(asm_vid, "0x%04x\n");
+rio_config_attr(asm_rev, "0x%04x\n");
+
+static ssize_t routes_show(struct device *dev, char *buf)
+{
+	struct rio_dev *rdev = to_rio_dev(dev);
+	char *str = buf;
+	int i;
+
+	if (!rdev->rswitch)
+		goto out;
+
+	for (i = 0; i < RIO_MAX_ROUTE_ENTRIES; i++) {
+		if (rdev->rswitch->route_table[i] == RIO_INVALID_ROUTE)
+			continue;
+		str +=
+		    sprintf(str, "%04x %02x\n", i,
+			    rdev->rswitch->route_table[i]);
+	}
+
+      out:
+	return (str - buf);
+}
+
+struct device_attribute rio_dev_attrs[] = {
+	__ATTR_RO(did),
+	__ATTR_RO(vid),
+	__ATTR_RO(device_rev),
+	__ATTR_RO(asm_did),
+	__ATTR_RO(asm_vid),
+	__ATTR_RO(asm_rev),
+	__ATTR_RO(routes),
+	__ATTR_NULL,
+};
+
+static ssize_t
+rio_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct rio_dev *dev =
+	    to_rio_dev(container_of(kobj, struct device, kobj));
+	unsigned int size = 0x100;
+	loff_t init_off = off;
+
+	/* Several chips lock up trying to read undefined config space */
+	if (capable(CAP_SYS_ADMIN))
+		size = 0x80000;
+
+	if (off > size)
+		return 0;
+	if (off + count > size) {
+		size -= off;
+		count = size;
+	} else {
+		size = count;
+	}
+
+	while (off & 3) {
+		unsigned char val;
+		rio_read_config_8(dev, off, &val);
+		buf[off - init_off] = val;
+		off++;
+		if (--size == 0)
+			break;
+	}
+
+	while (size > 3) {
+		unsigned int val;
+		rio_read_config_32(dev, off, &val);
+		buf[off - init_off] = (val >> 24) & 0xff;
+		buf[off - init_off + 1] = (val >> 16) & 0xff;
+		buf[off - init_off + 2] = (val >> 8) & 0xff;
+		buf[off - init_off + 3] = val & 0xff;
+		off += 4;
+		size -= 4;
+	}
+
+	while (size > 0) {
+		unsigned char val;
+		rio_read_config_8(dev, off, &val);
+		buf[off - init_off] = val;
+		off++;
+		--size;
+	}
+
+	return count;
+}
+
+static ssize_t
+rio_write_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct rio_dev *dev =
+	    to_rio_dev(container_of(kobj, struct device, kobj));
+	unsigned int size = count;
+	loff_t init_off = off;
+
+	if (off > 0x200000)
+		return 0;
+	if (off + count > 0x200000) {
+		size = 0x200000 - off;
+		count = size;
+	}
+
+	while (off & 3) {
+		rio_write_config_8(dev, off, buf[off - init_off]);
+		off++;
+		if (--size == 0)
+			break;
+	}
+
+	while (size > 3) {
+		unsigned int val = buf[off - init_off + 3];
+		val |= (unsigned int)buf[off - init_off + 2] << 8;
+		val |= (unsigned int)buf[off - init_off + 1] << 16;
+		val |= (unsigned int)buf[off - init_off] << 24;
+		rio_write_config_32(dev, off, val);
+		off += 4;
+		size -= 4;
+	}
+
+	while (size > 0) {
+		rio_write_config_8(dev, off, buf[off - init_off]);
+		off++;
+		--size;
+	}
+
+	return count;
+}
+
+static struct bin_attribute rio_config_attr = {
+	.attr = {
+		 .name = "config",
+		 .mode = S_IRUGO | S_IWUSR,
+		 .owner = THIS_MODULE,
+		 },
+	.size = 0x200000,
+	.read = rio_read_config,
+	.write = rio_write_config,
+};
+
+/**
+ * rio_create_sysfs_dev_files - create RIO specific sysfs files
+ * @rdev: device whose entries should be created
+ *
+ * Create files when @rdev is added to sysfs.
+ */
+int rio_create_sysfs_dev_files(struct rio_dev *rdev)
+{
+	sysfs_create_bin_file(&rdev->dev.kobj, &rio_config_attr);
+
+	return 0;
+}
+
+/**
+ * rio_remove_sysfs_dev_files - cleanup RIO specific sysfs files
+ * @rdev: device whose entries we should free
+ *
+ * Cleanup when @rdev is removed from sysfs.
+ */
+void rio_remove_sysfs_dev_files(struct rio_dev *rdev)
+{
+	sysfs_remove_bin_file(&rdev->dev.kobj, &rio_config_attr);
+}
Index: drivers/rio/rio.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/rio.c  (mode:100644)
@@ -0,0 +1,503 @@
+/*
+ * RapidIO interconnect services
+ * (RapidIO Interconnect Specification, http://www.rapidio.org)
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/rio.h>
+#include <linux/rio_drv.h>
+#include <linux/rio_ids.h>
+#include <linux/rio_regs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include "rio.h"
+
+static LIST_HEAD(rio_mports);
+
+/**
+ * rio_local_get_device_id - Get the base/extended device id for a port
+ * @port: RIO master port from which to get the deviceid
+ *
+ * Reads the base/extended device id from the local device
+ * implementing the master port. Returns the 8/16-bit device
+ * id.
+ */
+u16 rio_local_get_device_id(struct rio_mport *port)
+{
+	u32 result;
+
+	rio_local_read_config_32(port, RIO_DID_CSR, &result);
+
+	return (RIO_GET_DID(result));
+}
+
+/**
+ * rio_request_inb_mbox - request inbound mailbox service
+ * @mport: RIO master port from which to allocate the mailbox resource
+ * @mbox: Mailbox number to claim
+ * @entries: Number of entries in inbound mailbox queue 
+ * @minb: Callback to execute when inbound message is received
+ *
+ * Requests ownership of an inbound mailbox resource and binds
+ * a callback function to the resource. Returns %0 on success.
+ */
+int rio_request_inb_mbox(struct rio_mport *mport,
+			 int mbox,
+			 int entries,
+			 void (*minb) (struct rio_mport * mport, int mbox,
+				       int slot))
+{
+	int rc = 0;
+
+	struct resource *res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+
+	if (res) {
+		rio_init_mbox_res(res, mbox, mbox);
+
+		/* Make sure this mailbox isn't in use */
+		if ((rc =
+		     request_resource(&mport->riores[RIO_INB_MBOX_RESOURCE],
+				      res)) < 0) {
+			kfree(res);
+			goto out;
+		}
+
+		mport->inb_msg[mbox].res = res;
+
+		/* Hook the inbound message callback */
+		mport->inb_msg[mbox].mcback = minb;
+
+		rc = rio_open_inb_mbox(mport, mbox, entries);
+	} else
+		rc = -ENOMEM;
+
+      out:
+	return rc;
+}
+
+/**
+ * rio_release_inb_mbox - release inbound mailbox message service
+ * @mport: RIO master port from which to release the mailbox resource
+ * @mbox: Mailbox number to release
+ *
+ * Releases ownership of an inbound mailbox resource. Returns 0
+ * if the request has been satisfied.
+ */
+int rio_release_inb_mbox(struct rio_mport *mport, int mbox)
+{
+	rio_close_inb_mbox(mport, mbox);
+
+	/* Release the mailbox resource */
+	return release_resource(mport->inb_msg[mbox].res);
+}
+
+/**
+ * rio_request_outb_mbox - request outbound mailbox service
+ * @mport: RIO master port from which to allocate the mailbox resource
+ * @mbox: Mailbox number to claim
+ * @entries: Number of entries in outbound mailbox queue 
+ * @moutb: Callback to execute when outbound message is sent
+ *
+ * Requests ownership of an outbound mailbox resource and binds
+ * a callback function to the resource. Returns 0 on success.
+ */
+int rio_request_outb_mbox(struct rio_mport *mport,
+			  int mbox,
+			  int entries,
+			  void (*moutb) (struct rio_mport * mport, int mbox,
+					 int slot))
+{
+	int rc = 0;
+
+	struct resource *res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+
+	if (res) {
+		rio_init_mbox_res(res, mbox, mbox);
+
+		/* Make sure this outbound mailbox isn't in use */
+		if ((rc =
+		     request_resource(&mport->riores[RIO_OUTB_MBOX_RESOURCE],
+				      res)) < 0) {
+			kfree(res);
+			goto out;
+		}
+
+		mport->outb_msg[mbox].res = res;
+
+		/* Hook the inbound message callback */
+		mport->outb_msg[mbox].mcback = moutb;
+
+		rc = rio_open_outb_mbox(mport, mbox, entries);
+	} else
+		rc = -ENOMEM;
+
+      out:
+	return rc;
+}
+
+/**
+ * rio_release_outb_mbox - release outbound mailbox message service
+ * @mport: RIO master port from which to release the mailbox resource
+ * @mbox: Mailbox number to release
+ *
+ * Releases ownership of an inbound mailbox resource. Returns 0
+ * if the request has been satisfied.
+ */
+int rio_release_outb_mbox(struct rio_mport *mport, int mbox)
+{
+	rio_close_outb_mbox(mport, mbox);
+
+	/* Release the mailbox resource */
+	return release_resource(mport->outb_msg[mbox].res);
+}
+
+/**
+ * rio_setup_inb_dbell - bind inbound doorbell callback
+ * @mport: RIO master port to bind the doorbell callback
+ * @res: Doorbell message resource
+ * @dinb: Callback to execute when doorbell is received
+ *
+ * Adds a doorbell resource/callback pair into a port's
+ * doorbell event list. Returns 0 if the request has been
+ * satisfied.
+ */
+static int
+rio_setup_inb_dbell(struct rio_mport *mport, struct resource *res,
+		    void (*dinb) (struct rio_mport * mport, u16 src, u16 dst,
+				  u16 info))
+{
+	int rc = 0;
+	struct rio_dbell *dbell;
+
+	if (!(dbell = kmalloc(sizeof(struct rio_dbell), GFP_KERNEL))) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	dbell->res = res;
+	dbell->dinb = dinb;
+
+	list_add_tail(&dbell->node, &mport->dbells);
+
+      out:
+	return rc;
+}
+
+/**
+ * rio_request_inb_dbell - request inbound doorbell message service
+ * @mport: RIO master port from which to allocate the doorbell resource
+ * @start: Doorbell info range start
+ * @end: Doorbell info range end
+ * @dinb: Callback to execute when doorbell is received
+ *
+ * Requests ownership of an inbound doorbell resource and binds
+ * a callback function to the resource. Returns 0 if the request
+ * has been satisfied.
+ */
+int rio_request_inb_dbell(struct rio_mport *mport,
+			  u16 start,
+			  u16 end,
+			  void (*dinb) (struct rio_mport * mport, u16 src,
+					u16 dst, u16 info))
+{
+	int rc = 0;
+
+	struct resource *res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+
+	if (res) {
+		rio_init_dbell_res(res, start, end);
+
+		/* Make sure these doorbells aren't in use */
+		if ((rc =
+		     request_resource(&mport->riores[RIO_DOORBELL_RESOURCE],
+				      res)) < 0) {
+			kfree(res);
+			goto out;
+		}
+
+		/* Hook the doorbell callback */
+		rc = rio_setup_inb_dbell(mport, res, dinb);
+	} else
+		rc = -ENOMEM;
+
+      out:
+	return rc;
+}
+
+/**
+ * rio_release_inb_dbell - release inbound doorbell message service
+ * @mport: RIO master port from which to release the doorbell resource
+ * @start: Doorbell info range start
+ * @end: Doorbell info range end
+ *
+ * Releases ownership of an inbound doorbell resource and removes
+ * callback from the doorbell event list. Returns 0 if the request
+ * has been satisfied.
+ */
+int rio_release_inb_dbell(struct rio_mport *mport, u16 start, u16 end)
+{
+	int rc = 0, found = 0;
+	struct rio_dbell *dbell;
+
+	list_for_each_entry(dbell, &mport->dbells, node) {
+		if ((dbell->res->start == start) && (dbell->res->end == end)) {
+			found = 1;
+			break;
+		}
+	}
+
+	/* If we can't find an exact match, fail */
+	if (!found) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/* Delete from list */
+	list_del(&dbell->node);
+
+	/* Release the doorbell resource */
+	rc = release_resource(dbell->res);
+
+	/* Free the doorbell event */
+	kfree(dbell);
+
+      out:
+	return rc;
+}
+
+/**
+ * rio_request_outb_dbell - request outbound doorbell message range
+ * @rdev: RIO device from which to allocate the doorbell resource
+ * @start: Doorbell message range start
+ * @end: Doorbell message range end
+ *
+ * Requests ownership of a doorbell message range. Returns a resource
+ * if the request has been satisfied or %NULL on failure.
+ */
+struct resource *rio_request_outb_dbell(struct rio_dev *rdev, u16 start,
+					u16 end)
+{
+	struct resource *res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+
+	if (res) {
+		rio_init_dbell_res(res, start, end);
+
+		/* Make sure these doorbells aren't in use */
+		if (request_resource(&rdev->riores[RIO_DOORBELL_RESOURCE], res)
+		    < 0) {
+			kfree(res);
+			res = NULL;
+		}
+	}
+
+	return res;
+}
+
+/**
+ * rio_release_outb_dbell - release outbound doorbell message range
+ * @rdev: RIO device from which to release the doorbell resource
+ * @res: Doorbell resource to be freed
+ *
+ * Releases ownership of a doorbell message range. Returns 0 if the
+ * request has been satisfied.
+ */
+int rio_release_outb_dbell(struct rio_dev *rdev, struct resource *res)
+{
+	int rc = release_resource(res);
+
+	kfree(res);
+
+	return rc;
+}
+
+/**
+ * rio_mport_get_feature - query for devices' extended features
+ * @port: Master port to issue transaction
+ * @local: Indicate a local master port or remote device access
+ * @destid: Destination ID of the device
+ * @hopcount: Number of switch hops to the device
+ * @ftr: Extended feature code
+ *
+ * Tell if a device supports a given RapidIO capability.
+ * Returns the offset of the requested extended feature
+ * block within the device's RIO configuration space or
+ * 0 in case the device does not support it.  Possible
+ * values for @ftr:
+ *
+ * %RIO_EFB_PAR_EP_ID		LP/LVDS EP Devices
+ *
+ * %RIO_EFB_PAR_EP_REC_ID	LP/LVDS EP Recovery Devices
+ *
+ * %RIO_EFB_PAR_EP_FREE_ID	LP/LVDS EP Free Devices
+ *
+ * %RIO_EFB_SER_EP_ID		LP/Serial EP Devices
+ *
+ * %RIO_EFB_SER_EP_REC_ID	LP/Serial EP Recovery Devices
+ *
+ * %RIO_EFB_SER_EP_FREE_ID	LP/Serial EP Free Devices
+ */
+u32
+rio_mport_get_feature(struct rio_mport * port, int local, u16 destid,
+		      u8 hopcount, int ftr)
+{
+	u32 asm_info, ext_ftr_ptr, ftr_header;
+
+	if (local)
+		rio_local_read_config_32(port, RIO_ASM_INFO_CAR, &asm_info);
+	else
+		rio_mport_read_config_32(port, destid, hopcount,
+					 RIO_ASM_INFO_CAR, &asm_info);
+
+	ext_ftr_ptr = asm_info & RIO_EXT_FTR_PTR_MASK;
+
+	while (ext_ftr_ptr) {
+		if (local)
+			rio_local_read_config_32(port, ext_ftr_ptr,
+						 &ftr_header);
+		else
+			rio_mport_read_config_32(port, destid, hopcount,
+						 ext_ftr_ptr, &ftr_header);
+		if (RIO_GET_BLOCK_ID(ftr_header) == ftr)
+			return ext_ftr_ptr;
+		if (!(ext_ftr_ptr = RIO_GET_BLOCK_PTR(ftr_header)))
+			break;
+	}
+
+	return 0;
+}
+
+/**
+ * rio_get_asm - Begin or continue searching for a RIO device by vid/did/asm_vid/asm_did
+ * @vid: RIO vid to match or %RIO_ANY_ID to match all vids
+ * @did: RIO did to match or %RIO_ANY_ID to match all dids
+ * @asm_vid: RIO asm_vid to match or %RIO_ANY_ID to match all asm_vids
+ * @asm_did: RIO asm_did to match or %RIO_ANY_ID to match all asm_dids
+ * @from: Previous RIO device found in search, or %NULL for new search
+ *
+ * Iterates through the list of known RIO devices. If a RIO device is
+ * found with a matching @vid, @did, @asm_vid, @asm_did, the reference
+ * count to the device is incrememted and a pointer to its device
+ * structure is returned. Otherwise, %NULL is returned. A new search
+ * is initiated by passing %NULL to the @from argument. Otherwise, if
+ * @from is not %NULL, searches continue from next device on the global
+ * list. The reference count for @from is always decremented if it is
+ * not %NULL.
+ */
+struct rio_dev *rio_get_asm(u16 vid, u16 did,
+			    u16 asm_vid, u16 asm_did, struct rio_dev *from)
+{
+	struct list_head *n;
+	struct rio_dev *rdev;
+
+	WARN_ON(in_interrupt());
+	spin_lock(&rio_global_list_lock);
+	n = from ? from->global_list.next : rio_devices.next;
+
+	while (n && (n != &rio_devices)) {
+		rdev = rio_dev_g(n);
+		if ((vid == RIO_ANY_ID || rdev->vid == vid) &&
+		    (did == RIO_ANY_ID || rdev->did == did) &&
+		    (asm_vid == RIO_ANY_ID || rdev->asm_vid == asm_vid) &&
+		    (asm_did == RIO_ANY_ID || rdev->asm_did == asm_did))
+			goto exit;
+		n = n->next;
+	}
+	rdev = NULL;
+      exit:
+	rio_dev_put(from);
+	rdev = rio_dev_get(rdev);
+	spin_unlock(&rio_global_list_lock);
+	return rdev;
+}
+
+/**
+ * rio_get_device - Begin or continue searching for a RIO device by vid/did
+ * @vid: RIO vid to match or %RIO_ANY_ID to match all vids
+ * @did: RIO did to match or %RIO_ANY_ID to match all dids
+ * @from: Previous RIO device found in search, or %NULL for new search
+ *
+ * Iterates through the list of known RIO devices. If a RIO device is
+ * found with a matching @vid and @did, the reference count to the
+ * device is incrememted and a pointer to its device structure is returned.
+ * Otherwise, %NULL is returned. A new search is initiated by passing %NULL
+ * to the @from argument. Otherwise, if @from is not %NULL, searches
+ * continue from next device on the global list. The reference count for
+ * @from is always decremented if it is not %NULL.
+ */
+struct rio_dev *rio_get_device(u16 vid, u16 did, struct rio_dev *from)
+{
+	return rio_get_asm(vid, did, RIO_ANY_ID, RIO_ANY_ID, from);
+}
+
+static void rio_fixup_device(struct rio_dev *dev)
+{
+}
+
+static int __devinit rio_init(void)
+{
+	struct rio_dev *dev = NULL;
+
+	while ((dev = rio_get_device(RIO_ANY_ID, RIO_ANY_ID, dev)) != NULL) {
+		rio_fixup_device(dev);
+	}
+	return 0;
+}
+
+device_initcall(rio_init);
+
+int rio_init_mports(void)
+{
+	int rc = 0;
+	struct rio_mport *port;
+
+	list_for_each_entry(port, &rio_mports, node) {
+		if (!request_mem_region(port->iores.start,
+					port->iores.end - port->iores.start,
+					port->name)) {
+			printk(KERN_ERR
+			       "RIO: Error requesting master port region %8.8lx-%8.8lx\n",
+			       port->iores.start, port->iores.end - 1);
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		if (port->host_deviceid >= 0)
+			rio_enum_mport(port);
+		else
+			rio_disc_mport(port);
+	}
+
+      out:
+	return rc;
+}
+
+void rio_register_mport(struct rio_mport *port)
+{
+	list_add_tail(&port->node, &rio_mports);
+}
+
+EXPORT_SYMBOL(rio_local_get_device_id);
+EXPORT_SYMBOL(rio_get_device);
+EXPORT_SYMBOL(rio_get_asm);
+EXPORT_SYMBOL(rio_request_inb_dbell);
+EXPORT_SYMBOL(rio_release_inb_dbell);
+EXPORT_SYMBOL(rio_request_outb_dbell);
+EXPORT_SYMBOL(rio_release_outb_dbell);
+EXPORT_SYMBOL(rio_request_inb_mbox);
+EXPORT_SYMBOL(rio_release_inb_mbox);
+EXPORT_SYMBOL(rio_request_outb_mbox);
+EXPORT_SYMBOL(rio_release_outb_mbox);
Index: drivers/rio/rio.h
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/drivers/rio/rio.h  (mode:100644)
@@ -0,0 +1,57 @@
+/*
+ * RapidIO interconnect services
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/rio.h>
+
+/* Functions internal to the RIO core code */
+
+extern u32 rio_mport_get_feature(struct rio_mport *mport, int local, u16 destid,
+				 u8 hopcount, int ftr);
+extern int rio_create_sysfs_dev_files(struct rio_dev *rdev);
+extern int rio_enum_mport(struct rio_mport *mport);
+extern int rio_disc_mport(struct rio_mport *mport);
+
+/* Structures internal to the RIO core code */
+extern struct device_attribute rio_dev_attrs[];
+extern spinlock_t rio_global_list_lock;
+
+/* Helpers internal to the RIO core code */
+#define DECLARE_RIO_ROUTE_SECTION(section, vid, did, add_hook, get_hook)  \
+        static struct rio_route_ops __rio_route_ops __attribute_used__   \
+	        __attribute__((__section__(#section))) = { vid, did, add_hook, get_hook };
+
+/**
+ * DECLARE_RIO_ROUTE_OPS - Registers switch routing operations
+ * @vid: RIO vendor ID
+ * @did: RIO device ID
+ * @add_hook: Callback that adds a route entry
+ * @get_hook: Callback that gets a route entry
+ *
+ * Manipulating switch route tables in RIO is switch specific. This
+ * registers a switch by vendor and device ID with two callbacks for
+ * modifying and retrieving route entries in a switch. A &struct
+ * rio_route_ops is initialized with the ops and placed into a
+ * RIO-specific kernel section.
+ */
+#define DECLARE_RIO_ROUTE_OPS(vid, did, add_hook, get_hook)		\
+	DECLARE_RIO_ROUTE_SECTION(.rio_route_ops,			\
+			vid, did, add_hook, get_hook)
+
+#ifdef CONFIG_RAPIDIO_8_BIT_TRANSPORT
+#define RIO_GET_DID(x)	((x & 0x00ff0000) >> 16)
+#define RIO_SET_DID(x)	((x & 0x000000ff) << 16)
+#else
+#define RIO_GET_DID(x)	(x & 0xffff)
+#define RIO_SET_DID(x)	(x & 0xffff)
+#endif
Index: include/asm-generic/vmlinux.lds.h
===================================================================
--- 3c5e9440c6a37c3355b50608836a23c8fa4eec99/include/asm-generic/vmlinux.lds.h  (mode:100644)
+++ ca27a54444320b5c022df402fce5cab0f3d9ea94/include/asm-generic/vmlinux.lds.h  (mode:100644)
@@ -32,6 +32,13 @@
 		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
 	}								\
 									\
+	/* RapidIO route ops */						\
+	.rio_route        : AT(ADDR(.rio_route) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start_rio_route_ops) = .;		\
+		*(.rio_route_ops)					\
+		VMLINUX_SYMBOL(__end_rio_route_ops) = .;		\
+	}								\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
