Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTBFEHI>; Wed, 5 Feb 2003 23:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTBFEF5>; Wed, 5 Feb 2003 23:05:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54032 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265396AbTBFEC6>;
	Wed, 5 Feb 2003 23:02:58 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <1044504489271@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044901818@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.10, 2003/02/06 10:03:53+11:00, stekloff@w-stekloff.beaverton.ibm.com

[PATCH] pci patch for sysfs files

The patch is modeled after your method for creating files for usb. It
makes a single file for pci sysfs files (except for pool, which I haven't
touched yet). It also exposes more pci information to User Space
through sysfs. Finally, it removes the dependence on the proc pci code
for sysfs files.


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Thu Feb  6 14:51:34 2003
+++ b/drivers/pci/Makefile	Thu Feb  6 14:51:34 2003
@@ -3,7 +3,8 @@
 #
 
 obj-y		+= access.o probe.o pci.o pool.o quirks.o \
-			names.o pci-driver.o search.o hotplug.o
+			names.o pci-driver.o search.o hotplug.o \
+			pci-sysfs.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu Feb  6 14:51:34 2003
+++ b/drivers/pci/hotplug.c	Thu Feb  6 14:51:34 2003
@@ -255,6 +255,8 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_attach_device(dev);
 #endif
+	/* add sysfs device files */
+	pci_create_sysfs_dev_files(dev);
 }
 
 static void
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/pci-sysfs.c	Thu Feb  6 14:51:35 2003
@@ -0,0 +1,74 @@
+/*
+ * drivers/pci/pci-sysfs.c
+ *
+ * (C) Copyright 2002 Greg Kroah-Hartman
+ * (C) Copyright 2002 IBM Corp.
+ *
+ * File attributes for PCI devices
+ *
+ * Modeled after usb's driverfs.c 
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+
+#if BITS_PER_LONG == 32
+#define LONG_FORMAT "\t%08lx"
+#else
+#define LONG_FORMAT "\t%16lx"
+#endif
+
+/* show configuration fields */
+#define pci_config_attr(field, format_string)				\
+static ssize_t								\
+show_##field (struct device *dev, char *buf)				\
+{									\
+	struct pci_dev *pdev;						\
+									\
+	pdev = to_pci_dev (dev);					\
+	return sprintf (buf, format_string, pdev->field);		\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+pci_config_attr(vendor, "%x\n");
+pci_config_attr(device, "%x\n");
+pci_config_attr(subsystem_vendor, "%x\n");
+pci_config_attr(subsystem_device, "%x\n");
+pci_config_attr(irq, "%u\n");
+
+/* show resources */
+static ssize_t
+pci_show_resources(struct device * dev, char * buf)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	char * str = buf;
+	int i;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE && pci_resource_start(pci_dev,i); i++) {
+		str += sprintf(str,LONG_FORMAT LONG_FORMAT LONG_FORMAT "\n",
+			       pci_resource_start(pci_dev,i),
+			       pci_resource_end(pci_dev,i),
+			       pci_resource_flags(pci_dev,i));
+	}
+	return (str - buf);
+}
+
+static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
+
+void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	/* current configuration's attributes */
+	device_create_file (dev, &dev_attr_vendor);
+	device_create_file (dev, &dev_attr_device);
+	device_create_file (dev, &dev_attr_subsystem_vendor);
+	device_create_file (dev, &dev_attr_subsystem_device);
+	device_create_file (dev, &dev_attr_irq);
+	device_create_file (dev, &dev_attr_resource);
+}
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Thu Feb  6 14:51:34 2003
+++ b/drivers/pci/pci.h	Thu Feb  6 14:51:34 2003
@@ -2,4 +2,4 @@
 
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
-
+extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Feb  6 14:51:34 2003
+++ b/drivers/pci/proc.c	Thu Feb  6 14:51:34 2003
@@ -373,32 +373,6 @@
 
 struct proc_dir_entry *proc_bus_pci_dir;
 
-/* driverfs files */
-static ssize_t pci_show_irq(struct device * dev, char * buf)
-{
-	struct pci_dev * pci_dev = to_pci_dev(dev);
-	return sprintf(buf,"%u\n",pci_dev->irq);
-}
-
-static DEVICE_ATTR(irq,S_IRUGO,pci_show_irq,NULL);
-
-static ssize_t pci_show_resources(struct device * dev, char * buf)
-{
-	struct pci_dev * pci_dev = to_pci_dev(dev);
-	char * str = buf;
-	int i;
-
-	for (i = 0; i < DEVICE_COUNT_RESOURCE && pci_resource_start(pci_dev,i); i++) {
-		str += sprintf(str,LONG_FORMAT LONG_FORMAT LONG_FORMAT "\n",
-			       pci_resource_start(pci_dev,i),
-			       pci_resource_end(pci_dev,i),
-			       pci_resource_flags(pci_dev,i));
-	}
-	return (str - buf);
-}
-
-static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
-
 int pci_proc_attach_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
@@ -422,8 +396,6 @@
 	e->data = dev;
 	e->size = PCI_CFG_SPACE_SIZE;
 
-	device_create_file(&dev->dev,&dev_attr_irq);
-	device_create_file(&dev->dev,&dev_attr_resource);
 	return 0;
 }
 

