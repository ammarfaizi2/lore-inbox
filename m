Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUFVW43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUFVW43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUFVSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:00:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:49589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265084AbUFVRng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:36 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926108744@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:49 -0700
Message-Id: <10879261084005@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.85.5, 2004/06/03 17:05:41-07:00, mochel@digitalimplant.org

[Driver Model] Add default attributes for struct bus_type.

- Similar to default attributes for struct class, this is an array
  of attributes, terminated with an attribute with a NULL name, that
  are added when the bus is registered, and removed when the bus is 
  unregistered. 


 drivers/base/bus.c     |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    2 ++
 2 files changed, 39 insertions(+)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Tue Jun 22 09:48:40 2004
+++ b/drivers/base/bus.c	Tue Jun 22 09:48:40 2004
@@ -549,6 +549,41 @@
 	return k ? to_bus(k) : NULL;
 }
 
+
+/**
+ *	bus_add_attrs - Add default attributes for this bus.
+ *	@bus:	Bus that has just been registered.
+ */
+
+static int bus_add_attrs(struct bus_type * bus)
+{
+	int error = 0;
+	int i;
+
+	if (bus->bus_attrs) {
+		for (i = 0; attr_name(bus->bus_attrs[i]); i++) {
+			if ((error = bus_create_file(bus,&bus->bus_attrs[i])))
+				goto Err;
+		}
+	}
+ Done:
+	return error;
+ Err:
+	while (i >= 0)
+		bus_remove_file(bus,&bus->bus_attrs[i]);
+	goto Done;
+}
+
+static void bus_remove_attrs(struct bus_type * bus)
+{
+	int i;
+	
+	if (bus->bus_attrs) {
+		for (i = 0; attr_name(bus->bus_attrs[i]); i++)
+			bus_remove_file(bus,&bus->bus_attrs[i]);
+	}
+}
+
 /**
  *	bus_register - register a bus with the system.
  *	@bus:	bus.
@@ -582,6 +617,7 @@
 	retval = kset_register(&bus->drivers);
 	if (retval)
 		goto bus_drivers_fail;
+	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n",bus->name);
 	return 0;
@@ -605,6 +641,7 @@
 void bus_unregister(struct bus_type * bus)
 {
 	pr_debug("bus %s: unregistering\n",bus->name);
+	bus_remove_attrs(bus);
 	kset_unregister(&bus->drivers);
 	kset_unregister(&bus->devices);
 	subsystem_unregister(&bus->subsys);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jun 22 09:48:40 2004
+++ b/include/linux/device.h	Tue Jun 22 09:48:40 2004
@@ -54,6 +54,8 @@
 	struct kset		drivers;
 	struct kset		devices;
 
+	struct bus_attribute	* bus_attrs;
+
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp, 

