Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbULVQ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbULVQ67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbULVQ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:58:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57239 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261866AbULVQ6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:58:35 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add legacy resources to sysfs
Date: Wed, 22 Dec 2004 08:58:17 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, willy@debian.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <20041222160952.GB9358@kroah.com> <1103733278.31693.83.camel@gaston>
In-Reply-To: <1103733278.31693.83.camel@gaston>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qeayBhrHfHVymjC"
Message-Id: <200412220858.18287.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qeayBhrHfHVymjC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday, December 22, 2004 8:34 am, Benjamin Herrenschmidt wrote:
> Oh, I misread. If it's in /sys/class/pci_bus/(instance)/file it's fine,
> sorry, my fault.

Ok, then here's the latest.  Bjorn is on vacation so unless willy has 
objections I think it's good to go.  I'll send the ia64 part separately to 
Tony as it's totally standalone.

This patch adds legacy_io and legacy_mem files to the pci_bus class hierarchy 
in sysfs.  The files can be used (if the platform supports them) to access 
legacy I/O port space and legacy ISA memory space--useful for things like x86 
emulators or VGA card POSTing.  The interfaces are documented in 
Documentation/filesystems/sysfs-pci.txt.

 Documentation/filesystems/sysfs-pci.txt |   26 +++++++++++
 drivers/pci/pci-sysfs.c                 |   70 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c                     |   39 +++++++++++++++++
 include/linux/pci.h                     |    2
 4 files changed, 136 insertions(+), 1 deletion(-)

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_qeayBhrHfHVymjC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sysfs-legacy-resource-8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-legacy-resource-8.patch"

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
===== Documentation/filesystems/sysfs-pci.txt 1.1 vs edited =====
--- 1.1/Documentation/filesystems/sysfs-pci.txt	2004-12-21 11:50:26 -08:00
+++ edited/Documentation/filesystems/sysfs-pci.txt	2004-12-21 16:57:43 -08:00
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

--Boundary-00=_qeayBhrHfHVymjC--
