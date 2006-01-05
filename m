Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWAEAzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWAEAzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWAEAuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:62137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750963AbWAEAtw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:52 -0500
Cc: gregkh@suse.de
Subject: [PATCH] Driver core: only all userspace bind/unbind if CONFIG_HOTPLUG is enabled
In-Reply-To: <11364221712844@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <1136422171299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: only all userspace bind/unbind if CONFIG_HOTPLUG is enabled

Thanks to drivers making their id tables __devinit, we can't allow
userspace to bind or unbind drivers from devices manually through sysfs.
So we only allow this if CONFIG_HOTPLUG is enabled.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 874c6241b2e49e52680d32a50d4909c7768d5cb9
tree 815b08ab6793cd45346c3d5f6a3875f36c0bfc91
parent a96b204208443ab7e23c681f7ddabe807a741d0c
author Greg Kroah-Hartman <gregkh@suse.de> Tue, 13 Dec 2005 15:17:34 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 drivers/base/bus.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index e3f915a..29f6af5 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -428,6 +428,26 @@ static void driver_remove_attrs(struct b
 	}
 }
 
+#ifdef CONFIG_HOTPLUG
+/*
+ * Thanks to drivers making their tables __devinit, we can't allow manual
+ * bind and unbind from userspace unless CONFIG_HOTPLUG is enabled.
+ */
+static void add_bind_files(struct device_driver *drv)
+{
+	driver_create_file(drv, &driver_attr_unbind);
+	driver_create_file(drv, &driver_attr_bind);
+}
+
+static void remove_bind_files(struct device_driver *drv)
+{
+	driver_remove_file(drv, &driver_attr_bind);
+	driver_remove_file(drv, &driver_attr_unbind);
+}
+#else
+static inline void add_bind_files(struct device_driver *drv) {}
+static inline void remove_bind_files(struct device_driver *drv) {}
+#endif
 
 /**
  *	bus_add_driver - Add a driver to the bus.
@@ -457,8 +477,7 @@ int bus_add_driver(struct device_driver 
 		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
-		driver_create_file(drv, &driver_attr_unbind);
-		driver_create_file(drv, &driver_attr_bind);
+		add_bind_files(drv);
 	}
 	return error;
 }
@@ -476,8 +495,7 @@ int bus_add_driver(struct device_driver 
 void bus_remove_driver(struct device_driver * drv)
 {
 	if (drv->bus) {
-		driver_remove_file(drv, &driver_attr_bind);
-		driver_remove_file(drv, &driver_attr_unbind);
+		remove_bind_files(drv);
 		driver_remove_attrs(drv->bus, drv);
 		klist_remove(&drv->knode_bus);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);

