Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262630AbSJHAHJ>; Mon, 7 Oct 2002 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263410AbSJHAFM>; Mon, 7 Oct 2002 20:05:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34216 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263940AbSJHADj>;
	Mon, 7 Oct 2002 20:03:39 -0400
Date: Mon, 7 Oct 2002 17:11:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] Rename driverfs to kfs
In-Reply-To: <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071711320.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.573.1.138, 2002-10-07 15:18:01-07:00, mochel@osdl.org
  ACPI: move driverfs.c to kfs.c

diff -Nru a/drivers/acpi/Makefile b/drivers/acpi/Makefile
--- a/drivers/acpi/Makefile	Mon Oct  7 15:40:22 2002
+++ b/drivers/acpi/Makefile	Mon Oct  7 15:40:22 2002
@@ -32,7 +32,7 @@
 #
 # ACPI Bus and Device Drivers
 #
-obj-$(CONFIG_ACPI_BUS)		+= bus.o driverfs.o
+obj-$(CONFIG_ACPI_BUS)		+= bus.o kfs.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
diff -Nru a/drivers/acpi/driverfs.c b/drivers/acpi/driverfs.c
--- a/drivers/acpi/driverfs.c	Mon Oct  7 15:40:22 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,46 +0,0 @@
-/*
- * driverfs.c - ACPI bindings for driverfs.
- *
- * Copyright (c) 2002 Patrick Mochel
- * Copyright (c) 2002 The Open Source Development Lab
- *
- */
-
-#include <linux/stat.h>
-#include <linux/init.h>
-#include <linux/kfs.h>
-
-#include "acpi_bus.h"
-
-static struct driver_dir_entry acpi_dir = {
-	.name		= "acpi",
-	.mode	= (S_IRWXU | S_IRUGO | S_IXUGO),
-};
- 
-/* driverfs ops for ACPI attribute files go here, when/if
- * there are ACPI attribute files. 
- * For now, we just have directory creation and removal.
- */
-
-void acpi_remove_dir(struct acpi_device * dev)
-{
-	if (dev)
-		driverfs_remove_dir(&dev->driverfs_dir);
-}
-
-int acpi_create_dir(struct acpi_device * dev)
-{
-	struct driver_dir_entry * parent;
-
-	parent = dev->parent ? &dev->parent->driverfs_dir : &acpi_dir;
-	dev->driverfs_dir.name = dev->pnp.bus_id;
-	dev->driverfs_dir.mode  = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
-	return driverfs_create_dir(&dev->driverfs_dir,parent);
-}
-
-static int __init acpi_driverfs_init(void)
-{
-	return driverfs_create_dir(&acpi_dir,NULL);
-}
-
-subsys_initcall(acpi_driverfs_init);
diff -Nru a/drivers/acpi/kfs.c b/drivers/acpi/kfs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/acpi/kfs.c	Mon Oct  7 15:40:22 2002
@@ -0,0 +1,46 @@
+/*
+ * driverfs.c - ACPI bindings for driverfs.
+ *
+ * Copyright (c) 2002 Patrick Mochel
+ * Copyright (c) 2002 The Open Source Development Lab
+ *
+ */
+
+#include <linux/stat.h>
+#include <linux/init.h>
+#include <linux/kfs.h>
+
+#include "acpi_bus.h"
+
+static struct driver_dir_entry acpi_dir = {
+	.name		= "acpi",
+	.mode	= (S_IRWXU | S_IRUGO | S_IXUGO),
+};
+ 
+/* driverfs ops for ACPI attribute files go here, when/if
+ * there are ACPI attribute files. 
+ * For now, we just have directory creation and removal.
+ */
+
+void acpi_remove_dir(struct acpi_device * dev)
+{
+	if (dev)
+		driverfs_remove_dir(&dev->driverfs_dir);
+}
+
+int acpi_create_dir(struct acpi_device * dev)
+{
+	struct driver_dir_entry * parent;
+
+	parent = dev->parent ? &dev->parent->driverfs_dir : &acpi_dir;
+	dev->driverfs_dir.name = dev->pnp.bus_id;
+	dev->driverfs_dir.mode  = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
+	return driverfs_create_dir(&dev->driverfs_dir,parent);
+}
+
+static int __init acpi_driverfs_init(void)
+{
+	return driverfs_create_dir(&acpi_dir,NULL);
+}
+
+subsys_initcall(acpi_driverfs_init);

