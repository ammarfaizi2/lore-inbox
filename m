Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVAHI30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVAHI30 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVAHI2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:28:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:27526 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261939AbVAHFsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:51 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632632984@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:43 -0800
Message-Id: <11051632633234@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.32, 2004/12/22 13:06:36-08:00, jbarnes@engr.sgi.com

[PATCH] PCI: add legacy resources to sysfs for pci busses

This patch adds legacy_io and legacy_mem files to the pci_bus class hierarchy
in sysfs.  The files can be used (if the platform supports them) to access
legacy I/O port space and legacy ISA memory space--useful for things like x86
emulators or VGA card POSTing.  The interfaces are documented in
Documentation/filesystems/sysfs-pci.txt.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/filesystems/sysfs-pci.txt |   26 +++++++++-
 drivers/pci/pci-sysfs.c                 |   70 +++++++++++++++++++++++++++
 drivers/pci/probe.c                     |   82 ++++++++++++++++++++++++++------
 include/linux/pci.h                     |    2 
 4 files changed, 164 insertions(+), 16 deletions(-)


diff -Nru a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
--- a/Documentation/filesystems/sysfs-pci.txt	2005-01-07 15:40:01 -08:00
+++ b/Documentation/filesystems/sysfs-pci.txt	2005-01-07 15:40:01 -08:00
@@ -3,7 +3,7 @@
 sysfs, usually mounted at /sys, provides access to PCI resources on platforms
 that support it.  For example, a given bus might look like this:
 
-     pci0000:17
+     /sys/devices/pci0000:17
      |-- 0000:17:00.0
      |   |-- class
      |   |-- config
@@ -56,9 +56,33 @@
 from userspace.  Note that some platforms don't support mmapping of certain
 resources, so be sure to check the return value from any attempted mmap.
 
+Accessing legacy resources through sysfs
+
+Legacy I/O port and ISA memory resources are also provided in sysfs if the
+underlying platform supports them.  They're located in the PCI class heirarchy,
+e.g.
+
+	/sys/class/pci_bus/0000:17/
+	|-- bridge -> ../../../devices/pci0000:17
+	|-- cpuaffinity
+	|-- legacy_io
+	`-- legacy_mem
+
+The legacy_io file is a read/write file that can be used by applications to
+do legacy port I/O.  The application should open the file, seek to the desired
+port (e.g. 0x3e8) and do a read or a write of 1, 2 or 4 bytes.  The legacy_mem
+file should be mmapped with an offset corresponding to the memory offset
+desired, e.g. 0xa0000 for the VGA frame buffer.  The application can then
+simply dereference the returned pointer (after checking for errors of course)
+to access legacy memory space.
+
 Supporting PCI access on new platforms
 
 In order to support PCI resource mapping as described above, Linux platform
 code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.
 Platforms are free to only support subsets of the mmap functionality, but
 useful return codes should be provided.
+
+Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
+wishing to support legacy functionality should define it and provide
+pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions.
\ No newline at end of file
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-01-07 15:40:01 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-01-07 15:40:01 -08:00
@@ -179,6 +179,76 @@
 	return count;
 }
 
+#ifdef HAVE_PCI_LEGACY
+/**
+ * pci_read_legacy_io - read byte(s) from legacy I/O port space
+ * @kobj: kobject corresponding to file to read from
+ * @buf: buffer to store results
+ * @off: offset into legacy I/O port space
+ * @count: number of bytes to read
+ *
+ * Reads 1, 2, or 4 bytes from legacy I/O port space using an arch specific
+ * callback routine (pci_legacy_read).
+ */
+ssize_t
+pci_read_legacy_io(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+                                                      struct class_device,
+						      kobj));
+
+        /* Only support 1, 2 or 4 byte accesses */
+        if (count != 1 && count != 2 && count != 4)
+                return -EINVAL;
+
+        return pci_legacy_read(bus, off, (u32 *)buf, count);
+}
+
+/**
+ * pci_write_legacy_io - write byte(s) to legacy I/O port space
+ * @kobj: kobject corresponding to file to read from
+ * @buf: buffer containing value to be written
+ * @off: offset into legacy I/O port space
+ * @count: number of bytes to write
+ *
+ * Writes 1, 2, or 4 bytes from legacy I/O port space using an arch specific
+ * callback routine (pci_legacy_write).
+ */
+ssize_t
+pci_write_legacy_io(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+						      struct class_device,
+						      kobj));
+        /* Only support 1, 2 or 4 byte accesses */
+        if (count != 1 && count != 2 && count != 4)
+                return -EINVAL;
+
+        return pci_legacy_write(bus, off, *(u32 *)buf, count);
+}
+
+/**
+ * pci_mmap_legacy_mem - map legacy PCI memory into user memory space
+ * @kobj: kobject corresponding to device to be mapped
+ * @attr: struct bin_attribute for this file
+ * @vma: struct vm_area_struct passed to mmap
+ *
+ * Uses an arch specific callback, pci_mmap_legacy_page_range, to mmap
+ * legacy memory space (first meg of bus space) into application virtual
+ * memory space.
+ */
+int
+pci_mmap_legacy_mem(struct kobject *kobj, struct bin_attribute *attr,
+                    struct vm_area_struct *vma)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+                                                      struct class_device,
+						      kobj));
+
+        return pci_mmap_legacy_page_range(bus, vma);
+}
+#endif /* HAVE_PCI_LEGACY */
+
 #ifdef HAVE_PCI_MMAP
 /**
  * pci_mmap_resource - map a PCI resource into user memory space
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-01-07 15:40:01 -08:00
+++ b/drivers/pci/probe.c	2005-01-07 15:40:01 -08:00
@@ -27,12 +27,76 @@
 
 LIST_HEAD(pci_devices);
 
+#ifdef HAVE_PCI_LEGACY
+/**
+ * pci_create_legacy_files - create legacy I/O port and memory files
+ * @b: bus to create files under
+ *
+ * Some platforms allow access to legacy I/O port and ISA memory space on
+ * a per-bus basis.  This routine creates the files and ties them into
+ * their associated read, write and mmap files from pci-sysfs.c
+ */
+static void pci_create_legacy_files(struct pci_bus *b)
+{
+	b->legacy_io = kmalloc(sizeof(struct bin_attribute) * 2,
+			       GFP_ATOMIC);
+	if (b->legacy_io) {
+		b->legacy_io->attr.name = "legacy_io";
+		b->legacy_io->size = 0xffff;
+		b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
+		b->legacy_io->attr.owner = THIS_MODULE;
+		b->legacy_io->read = pci_read_legacy_io;
+		b->legacy_io->write = pci_write_legacy_io;
+		class_device_create_bin_file(&b->class_dev, b->legacy_io);
+
+		/* Allocated above after the legacy_io struct */
+		b->legacy_mem = b->legacy_io + 1;
+		b->legacy_mem->attr.name = "legacy_mem";
+		b->legacy_mem->size = 1024*1024;
+		b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
+		b->legacy_mem->attr.owner = THIS_MODULE;
+		b->legacy_mem->mmap = pci_mmap_legacy_mem;
+		class_device_create_bin_file(&b->class_dev, b->legacy_mem);
+	}
+}
+
+static void pci_remove_legacy_files(struct pci_bus *b)
+{
+	class_device_remove_bin_file(&b->class_dev, b->legacy_io);
+	class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
+	kfree(b->legacy_io); /* both are allocated here */
+}
+#else /* !HAVE_PCI_LEGACY */
+static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
+static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+#endif /* HAVE_PCI_LEGACY */
+
+/*
+ * PCI Bus Class Devices
+ */
+static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
+{
+	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+	int ret;
+
+	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
+	if (ret < PAGE_SIZE)
+		buf[ret++] = '\n';
+	return ret;
+}
+static CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
+
 /*
  * PCI Bus Class
  */
 static void release_pcibus_dev(struct class_device *class_dev)
 {
 	struct pci_bus *pci_bus = to_pci_bus(class_dev);
+
+	pci_remove_legacy_files(pci_bus);
+	class_device_remove_file(&pci_bus->class_dev,
+				 &class_device_attr_cpuaffinity);
+	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
 	if (pci_bus->bridge)
 		put_device(pci_bus->bridge);
 	kfree(pci_bus);
@@ -50,21 +114,6 @@
 postcore_initcall(pcibus_class_init);
 
 /*
- * PCI Bus Class Devices
- */
-static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
-{
-	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
-	int ret;
-
-	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
-	if (ret < PAGE_SIZE)
-		buf[ret++] = '\n';
-	return ret;
-}
-static CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
-
-/*
  * Translate the low bits of the PCI base
  * to the resource type
  */
@@ -807,6 +856,9 @@
 	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
 	if (error)
 		goto class_dev_create_file_err;
+
+	/* Create legacy_io and legacy_mem files for this bus */
+	pci_create_legacy_files(b);
 
 	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
 	if (error)
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-01-07 15:40:01 -08:00
+++ b/include/linux/pci.h	2005-01-07 15:40:01 -08:00
@@ -594,6 +594,8 @@
 	unsigned short  pad2;
 	struct device		*bridge;
 	struct class_device	class_dev;
+	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
+	struct bin_attribute	*legacy_mem; /* legacy mem */
 };
 
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)

