Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318936AbSIIWVA>; Mon, 9 Sep 2002 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSIIWU7>; Mon, 9 Sep 2002 18:20:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13323 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318936AbSIIWS0>;
	Mon, 9 Sep 2002 18:18:26 -0400
Date: Mon, 9 Sep 2002 15:20:16 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909222016.GH7433@kroah.com>
References: <20020909221627.GE7433@kroah.com> <20020909221955.GG7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909221955.GG7433@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.625   -> 1.626  
#	 drivers/pci/probe.c	1.10    -> 1.11   
#	 include/linux/pci.h	1.40    -> 1.41   
#	  drivers/pci/proc.c	1.17    -> 1.18   
#	drivers/pci/Makefile	1.13    -> 1.14   
#	drivers/pci/hotplug.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	greg@kroah.com	1.626
# PCI: hotplug core cleanup to get pci hotplug working again
# 
# - removed pci_announce_device_to_drivers() prototype as the function is long gone
# - always call /sbin/hotplug when pci devices are added to the system if
#   so configured (this includes during the system bring up.)
# --------------------------------------------
#
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Mon Sep  9 15:09:49 2002
+++ b/drivers/pci/Makefile	Mon Sep  9 15:09:49 2002
@@ -6,10 +6,8 @@
 			probe.o proc.o search.o compat.o
 
 obj-y		+= access.o probe.o pci.o pool.o quirks.o \
-			compat.o names.o pci-driver.o search.o
+			compat.o names.o pci-driver.o search.o hotplug.o
 obj-$(CONFIG_PM)  += power.o
-obj-$(CONFIG_HOTPLUG)  += hotplug.o
-
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Mon Sep  9 15:09:49 2002
+++ b/drivers/pci/hotplug.c	Mon Sep  9 15:09:49 2002
@@ -7,8 +7,8 @@
 #define TRUE	(!FALSE)
 #endif
 
-static void
-run_sbin_hotplug(struct pci_dev *pdev, int insert)
+#ifdef CONFIG_HOTPLUG
+static void run_sbin_hotplug(struct pci_dev *pdev, int insert)
 {
 	int i;
 	char *argv[3], *envp[8];
@@ -45,13 +45,18 @@
 
 	call_usermodehelper (argv [0], argv, envp);
 }
+#else
+static void run_sbin_hotplug(struct pci_dev *pdev, int insert) { }
+#endif
 
 /**
- * pci_insert_device - insert a hotplug device
+ * pci_insert_device - insert a pci device
  * @dev: the device to insert
  * @bus: where to insert it
  *
- * Add a new device to the device lists and notify userspace (/sbin/hotplug).
+ * Link the device to both the global PCI device chain and the 
+ * per-bus list of devices, add the /proc entry, and notify
+ * userspace (/sbin/hotplug).
  */
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
@@ -78,11 +83,11 @@
 }
 
 /**
- * pci_remove_device - remove a hotplug device
+ * pci_remove_device - remove a pci device
  * @dev: the device to remove
  *
- * Delete the device structure from the device lists and 
- * notify userspace (/sbin/hotplug).
+ * Delete the device structure from the device lists,
+ * remove the /proc entry, and notify userspace (/sbin/hotplug).
  */
 void
 pci_remove_device(struct pci_dev *dev)
@@ -94,10 +99,11 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
 #endif
-
 	/* notify userspace of hotplug device removal */
 	run_sbin_hotplug(dev, FALSE);
 }
 
+#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_insert_device);
 EXPORT_SYMBOL(pci_remove_device);
+#endif
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Mon Sep  9 15:09:49 2002
+++ b/drivers/pci/probe.c	Mon Sep  9 15:09:49 2002
@@ -479,10 +479,10 @@
 
 		/*
 		 * Link the device to both the global PCI device chain and
-		 * the per-bus list of devices.
+		 * the per-bus list of devices and call /sbin/hotplug if we
+		 * should.
 		 */
-		list_add_tail(&dev->global_list, &pci_devices);
-		list_add_tail(&dev->bus_list, &bus->devices);
+		pci_insert_device (dev, bus);
 
 		/* Fix up broken headers */
 		pci_fixup_device(PCI_FIXUP_HEADER, dev);
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Mon Sep  9 15:09:49 2002
+++ b/drivers/pci/proc.c	Mon Sep  9 15:09:49 2002
@@ -18,6 +18,8 @@
 
 #define PCI_CFG_SPACE_SIZE 256
 
+static int proc_initialized;	/* = 0 */
+
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
@@ -410,6 +412,9 @@
 	struct proc_dir_entry *de, *e;
 	char name[16];
 
+	if (!proc_initialized)
+		return -EACCES;
+
 	if (!(de = bus->procdir)) {
 		sprintf(name, "%02x", bus->number);
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
@@ -446,6 +451,9 @@
 {
 	struct proc_dir_entry *de = bus->procdir;
 
+	if (!proc_initialized)
+		return -EACCES;
+
 	if (!de) {
 		char name[16];
 		sprintf(name, "%02x", bus->number);
@@ -595,6 +603,7 @@
 		entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
 		if (entry)
 			entry->proc_fops = &proc_bus_pci_dev_operations;
+		proc_initialized = 1;
 		pci_for_each_dev(dev) {
 			pci_proc_attach_device(dev);
 		}
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Mon Sep  9 15:09:49 2002
+++ b/include/linux/pci.h	Mon Sep  9 15:09:49 2002
@@ -634,7 +634,6 @@
 void pci_remove_device(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
 const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
-void pci_announce_device_to_drivers(struct pci_dev *);
 unsigned int pci_do_scan_bus(struct pci_bus *bus);
 struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
 
