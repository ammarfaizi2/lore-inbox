Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbULUXnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbULUXnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbULUXnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:43:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:4822 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261901AbULUXnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:43:19 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Date: Tue, 21 Dec 2004 15:42:47 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, willy@debian.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <20041221214623.GB10362@kroah.com> <200412211405.09536.jbarnes@engr.sgi.com>
In-Reply-To: <200412211405.09536.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3TLyBqnfo7yYT8E"
Message-Id: <200412211542.47997.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3TLyBqnfo7yYT8E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, December 21, 2004 2:05 pm, Jesse Barnes wrote:
> On Tuesday, December 21, 2004 1:46 pm, Greg KH wrote:
> > You are passing the wrong things around :)
> >
> > A struct pci_bus is a struct class_device, not a struct device.  I think
> > you need to rethink your goal of putting the files into the pci device
> > directory, or just put the files into the proper /sys/class/pci_bus/*
> > directory as your code assumes is happening.
>
> Something like this then?  I added bin file support to class.c and use that
> instead from probe.c.  I also fixed the container_of stuff in pci-sysfs.c.

Here it is w/o the ia64 stuff.  That way people can buy off on the API and not 
worry about the platform stuff.  I can send that to Tony separately if 
there's agreement on this part.  I'd like to create a symlink 
from /sys/class/pci_bus/<bus>/legacy_* to /sys/devices/pci<foo>/legacy_* too, 
how do I do that?

 drivers/base/class.c    |   16 ++++++++++
 drivers/pci/pci-sysfs.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c     |   39 ++++++++++++++++++++++++++
 include/linux/pci.h     |    2 +
 4 files changed, 127 insertions(+)

Thanks,
Jesse

--Boundary-00=_3TLyBqnfo7yYT8E
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sysfs-legacy-resource-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-legacy-resource-5.patch"

===== drivers/base/class.c 1.56 vs edited =====
--- 1.56/drivers/base/class.c	2004-11-12 03:45:39 -08:00
+++ edited/drivers/base/class.c	2004-12-21 13:59:00 -08:00
@@ -179,6 +179,22 @@
 		sysfs_remove_file(&class_dev->kobj, &attr->attr);
 }
 
+int class_device_create_bin_file(struct class_device *class_dev,
+				 struct bin_attribute *attr)
+{
+	int error = -EINVAL;
+	if (class_dev)
+		error = sysfs_create_bin_file(&class_dev->kobj, attr);
+	return error;
+}
+
+void class_device_remove_bin_file(struct class_device *class_dev,
+				  struct bin_attribute *attr)
+{
+	if (class_dev)
+		sysfs_remove_bin_file(&class_dev->kobj, attr);
+}
+
 static int class_device_dev_link(struct class_device * class_dev)
 {
 	if (class_dev->dev)
===== drivers/pci/pci-sysfs.c 1.14 vs edited =====
--- 1.14/drivers/pci/pci-sysfs.c	2004-12-21 11:28:57 -08:00
+++ edited/drivers/pci/pci-sysfs.c	2004-12-21 14:03:35 -08:00
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
===== drivers/pci/probe.c 1.72 vs edited =====
--- 1.72/drivers/pci/probe.c	2004-11-11 12:53:33 -08:00
+++ edited/drivers/pci/probe.c	2004-12-21 13:58:10 -08:00
@@ -764,6 +764,42 @@
 	return max;
 }
 
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
+#else /* !HAVE_PCI_LEGACY */
+static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
+#endif /* HAVE_PCI_LEGACY */
+
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	int error;
@@ -807,6 +843,9 @@
 	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
 	if (error)
 		goto class_dev_create_file_err;
+
+	/* Create legacy_io and legacy_mem files for this bus */
+	pci_create_legacy_files(b);
 
 	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
 	if (error)
===== include/linux/pci.h 1.143 vs edited =====
--- 1.143/include/linux/pci.h	2004-12-21 11:21:50 -08:00
+++ edited/include/linux/pci.h	2004-12-21 12:32:38 -08:00
@@ -594,6 +594,8 @@
 	unsigned short  pad2;
 	struct device		*bridge;
 	struct class_device	class_dev;
+	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
+	struct bin_attribute	*legacy_mem; /* legacy mem */
 };
 
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)

--Boundary-00=_3TLyBqnfo7yYT8E--
