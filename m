Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUJHC0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUJHC0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 22:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUJHCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 22:25:20 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:15391 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267359AbUJHCUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 22:20:41 -0400
Message-ID: <9e4733910410071920531730a3@mail.gmail.com>
Date: Thu, 7 Oct 2004 22:20:39 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040908235046.GB8361@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_224_9388821.1097202039886"
References: <20040908031537.92163.qmail@web14929.mail.yahoo.com>
	 <20040908235046.GB8361@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_224_9388821.1097202039886
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Linus has requested that the sysfs rom attribute be changed to require
enabling before it works. echo "0" to the attribute to disable,
echoing anything else enables the rom output. The concern is that
something like a file browser could inadvertently read the attribute
and change the state of the hardware without the user's knowledge.

The attached patch includes the previous patch plus the enabling logic.

[root@smirl 0000:02:02.0]#
[root@smirl 0000:02:02.0]# cat rom
cat: rom: Invalid argument
[root@smirl 0000:02:02.0]# echo "1" >rom
[root@smirl 0000:02:02.0]# hexdump -C -n 20 rom
00000000  55 aa 60 e9 d6 01 00 00  00 00 00 00 00 00 00 00  |U.`.............|
00000010  00 00 00 00                                       |....|
00000014
[root@smirl 0000:02:02.0]# echo "0" >rom
[root@smirl 0000:02:02.0]# hexdump -C -n 20 rom
hexdump: rom: Invalid argument
[root@smirl 0000:02:02.0]#





-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_224_9388821.1097202039886
Content-Type: text/x-patch; name="pci-sysfs-rom-23.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pci-sysfs-rom-23.patch"

diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c=092004-10-07 22:11:55 -04:00
+++ b/arch/i386/pci/fixup.c=092004-10-07 22:11:55 -04:00
@@ -255,3 +255,41 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE=
2, pci_fixup_nforce2);
=20
+/*
+ * Fixup to mark boot BIOS video selected by BIOS before it changes
+ *
+ * From information provided by "Jon Smirl" <jonsmirl@yahoo.com>
+ *
+ * The standard boot ROM sequence for an x86 machine uses the BIOS
+ * to select an initial video card for boot display. This boot video=20
+ * card will have it's BIOS copied to C0000 in system RAM.=20
+ * IORESOURCE_ROM_SHADOW is used to associate the boot video
+ * card with this copy. On laptops this copy has to be used since
+ * the main ROM may be compressed or combined with another image.
+ * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
+ * is marked here since the boot video device will be the only enabled
+ * video device at this point.
+ *
+ */static void __devinit pci_fixup_video(struct pci_dev *pdev)
+{
+=09struct pci_dev *bridge;
+=09struct pci_bus *bus;
+=09u16 l;
+
+=09if ((pdev->class >> 8) !=3D PCI_CLASS_DISPLAY_VGA)
+=09=09return;
+
+=09/* Is VGA routed to us? */
+=09bus =3D pdev->bus;
+=09while (bus) {
+=09=09bridge =3D bus->self;
+=09=09if (bridge) {
+=09=09=09pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
+=09=09=09if (!(l & PCI_BRIDGE_CTL_VGA))
+=09=09=09=09return;
+=09=09}
+=09=09bus =3D bus->parent;
+=09}
+=09pdev->resource[PCI_ROM_RESOURCE].flags |=3D IORESOURCE_ROM_SHADOW;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile=092004-10-07 22:11:55 -04:00
+++ b/drivers/pci/Makefile=092004-10-07 22:11:55 -04:00
@@ -3,7 +3,8 @@
 #
=20
 obj-y=09=09+=3D access.o bus.o probe.o remove.o pci.o quirks.o \
-=09=09=09names.o pci-driver.o search.o pci-sysfs.o
+=09=09=09names.o pci-driver.o search.o pci-sysfs.o \
+=09=09=09rom.o
 obj-$(CONFIG_PROC_FS) +=3D proc.o
=20
 ifndef CONFIG_SPARC64
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c=092004-10-07 22:11:55 -04:00
+++ b/drivers/pci/pci-sysfs.c=092004-10-07 22:11:55 -04:00
@@ -5,6 +5,8 @@
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com=
>
  *
  * File attributes for PCI devices
  *
@@ -20,6 +22,8 @@
=20
 #include "pci.h"
=20
+static int sysfs_initialized;=09/* =3D 0 */
+
 /* show configuration fields */
 #define pci_config_attr(field, format_string)=09=09=09=09\
 static ssize_t=09=09=09=09=09=09=09=09\
@@ -164,6 +168,65 @@
 =09return count;
 }
=20
+/**
+ * pci_write_rom - used to enable access to the PCI ROM display
+ * @kobj: kernel object handle
+ * @buf: user input
+ * @off: file offset
+ * @count: number of byte in input
+ *
+ * writing anything except 0 enables it
+ */
+static ssize_t
+pci_write_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(container_of(kobj, struct device, k=
obj));
+
+=09if ((off =3D=3D  0) && (*buf =3D=3D '0') && (count =3D=3D 2))
+=09=09pdev->rom_attr_enabled =3D 0;
+=09else
+=09=09pdev->rom_attr_enabled =3D 1;
+
+=09return count;
+}
+
+/**
+ * pci_read_rom - read a PCI ROM
+ * @kobj: kernel object handle
+ * @buf: where to put the data we read from the ROM
+ * @off: file offset
+ * @count: number of bytes to read
+ *
+ * Put @count bytes starting at @off into @buf from the ROM in the PCI
+ * device corresponding to @kobj.
+ */
+static ssize_t
+pci_read_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(container_of(kobj, struct device, k=
obj));
+=09void __iomem *rom;
+=09size_t size;
+
+=09if (!pdev->rom_attr_enabled)
+=09=09return -EINVAL;
+=09
+=09rom =3D pci_map_rom(pdev, &size);=09/* size starts out as PCI window si=
ze */
+=09if (!rom)
+=09=09return 0;
+=09=09
+=09if (off >=3D size)
+=09=09count =3D 0;
+=09else {
+=09=09if (off + count > size)
+=09=09=09count =3D size - off;
+=09=09
+=09=09memcpy_fromio(buf, rom + off, count);
+=09}
+=09pci_unmap_rom(pdev, rom);
+=09=09
+=09return count;
+}
+
 static struct bin_attribute pci_config_attr =3D {
 =09.attr =3D=09{
 =09=09.name =3D "config",
@@ -186,13 +249,68 @@
 =09.write =3D pci_write_config,
 };
=20
-void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+int pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
+=09if (!sysfs_initialized)
+=09=09return -EACCES;
+
 =09if (pdev->cfg_size < 4096)
 =09=09sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 =09else
 =09=09sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
=20
+=09/* If the device has a ROM, try to expose it in sysfs. */
+=09if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+=09=09struct bin_attribute *rom_attr;
+=09=09
+=09=09rom_attr =3D kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+=09=09if (rom_attr) {
+=09=09=09pdev->rom_attr =3D rom_attr;
+=09=09=09rom_attr->size =3D pci_resource_len(pdev, PCI_ROM_RESOURCE);
+=09=09=09rom_attr->attr.name =3D "rom";
+=09=09=09rom_attr->attr.mode =3D S_IRUSR;
+=09=09=09rom_attr->attr.owner =3D THIS_MODULE;
+=09=09=09rom_attr->read =3D pci_read_rom;
+=09=09=09rom_attr->write =3D pci_write_rom;
+=09=09=09sysfs_create_bin_file(&pdev->dev.kobj, rom_attr);
+=09=09}
+=09}
 =09/* add platform-specific attributes */
 =09pcibios_add_platform_entries(pdev);
+=09
+=09return 0;
+}
+
+/**
+ * pci_remove_sysfs_dev_files - cleanup PCI specific sysfs files
+ * @pdev: device whose entries we should free
+ *
+ * Cleanup when @pdev is removed from sysfs.
+ */
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
+{
+=09if (pdev->cfg_size < 4096)
+=09=09sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
+=09else
+=09=09sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+
+=09if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+=09=09if (pdev->rom_attr) {
+=09=09=09sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
+=09=09=09kfree(pdev->rom_attr);
+=09=09}
+=09}
 }
+
+static int __init pci_sysfs_init(void)
+{
+=09struct pci_dev *pdev =3D NULL;
+=09
+=09sysfs_initialized =3D 1;
+=09while ((pdev =3D pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) !=3D NU=
LL)
+=09=09pci_create_sysfs_dev_files(pdev);
+
+=09return 0;
+}
+
+__initcall(pci_sysfs_init);
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h=092004-10-07 22:11:55 -04:00
+++ b/drivers/pci/pci.h=092004-10-07 22:11:55 -04:00
@@ -2,7 +2,9 @@
=20
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 =09=09=09 char *buffer, int buffer_size);
-extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern int pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *re=
s,
 =09=09=09=09  unsigned long size, unsigned long align,
 =09=09=09=09  unsigned long min, unsigned int type_mask,
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c=092004-10-07 22:11:55 -04:00
+++ b/drivers/pci/probe.c=092004-10-07 22:11:55 -04:00
@@ -170,7 +170,7 @@
 =09=09if (sz && sz !=3D 0xffffffff) {
 =09=09=09sz =3D pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
 =09=09=09if (sz) {
-=09=09=09=09res->flags =3D (l & PCI_ROM_ADDRESS_ENABLE) |
+=09=09=09=09res->flags =3D (l & IORESOURCE_ROM_ENABLE) |
 =09=09=09=09  IORESOURCE_MEM | IORESOURCE_PREFETCH |
 =09=09=09=09  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 =09=09=09=09res->start =3D l & PCI_ROM_ADDRESS_MASK;
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c=092004-10-07 22:11:55 -04:00
+++ b/drivers/pci/remove.c=092004-10-07 22:11:55 -04:00
@@ -16,6 +16,7 @@
=20
  =09msi_remove_pci_irq_vectors(dev);
=20
+=09pci_cleanup_rom(dev);
 =09for (i =3D 0; i < PCI_NUM_RESOURCES; i++) {
 =09=09struct resource *res =3D dev->resource + i;
 =09=09if (res->parent)
@@ -26,6 +27,7 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 =09pci_proc_detach_device(dev);
+=09pci_remove_sysfs_dev_files(dev);
 =09device_unregister(&dev->dev);
=20
 =09/* Remove the device from the device lists, and prevent any further
diff -Nru a/drivers/pci/rom.c b/drivers/pci/rom.c
--- /dev/null=09Wed Dec 31 16:00:00 196900
+++ b/drivers/pci/rom.c=092004-10-07 22:11:55 -04:00
@@ -0,0 +1,225 @@
+/*
+ * drivers/pci/rom.c
+ *
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com=
>
+ *
+ * PCI ROM access routines
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
+/**
+ * pci_enable_rom - enable ROM decoding for a PCI device
+ * @dev: PCI device to enable
+ *
+ * Enable ROM decoding on @dev.  This involves simply turning on the last
+ * bit of the PCI ROM BAR.  Note that some cards may share address decoder=
s
+ * between the ROM and other resources, so enabling it may disable access
+ * to MMIO registers or other card memory.
+ */
+static void
+pci_enable_rom(struct pci_dev *pdev)
+{
+=09u32 rom_addr;
+=09
+=09pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
+=09rom_addr |=3D PCI_ROM_ADDRESS_ENABLE;
+=09pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+}
+
+/**
+ * pci_disable_rom - disable ROM decoding for a PCI device
+ * @dev: PCI device to disable
+ *
+ * Disable ROM decoding on a PCI device by turning off the last bit in the
+ * ROM BAR.
+ */
+static void
+pci_disable_rom(struct pci_dev *pdev)
+{
+=09u32 rom_addr;
+=09pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
+=09rom_addr &=3D ~PCI_ROM_ADDRESS_ENABLE;
+=09pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+}
+
+/**
+ * pci_map_rom - map a PCI ROM to kernel space
+ * @dev: pointer to pci device struct
+ * @size: pointer to receive size of pci window over ROM
+ * @return: kernel virtual pointer to image of ROM
+ *
+ * Map a PCI ROM into kernel space. If ROM is boot video ROM,
+ * the shadow BIOS copy will be returned instead of the=20
+ * actual ROM.
+ */
+void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
+{
+=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
+=09loff_t start;
+=09void __iomem *rom;
+=09void __iomem *image;
+=09int last_image;
+=09
+=09if (res->flags & IORESOURCE_ROM_SHADOW) {=09/* IORESOURCE_ROM_SHADOW on=
ly set on x86 */
+=09=09start =3D (loff_t)0xC0000; =09/* primary video rom always starts her=
e */
+=09=09*size =3D 0x20000;=09=09/* cover C000:0 through E000:0 */
+=09} else {
+=09=09if (res->flags & IORESOURCE_ROM_COPY) {
+=09=09=09*size =3D pci_resource_len(pdev, PCI_ROM_RESOURCE);
+=09=09=09return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE)=
;
+=09=09} else {
+=09=09=09/* assign the ROM an address if it doesn't have one */
+=09=09=09if (res->parent =3D=3D NULL)
+=09=09=09=09pci_assign_resource(pdev, PCI_ROM_RESOURCE);
+=09
+=09=09=09start =3D pci_resource_start(pdev, PCI_ROM_RESOURCE);
+=09=09=09*size =3D pci_resource_len(pdev, PCI_ROM_RESOURCE);
+=09=09=09if (*size =3D=3D 0)
+=09=09=09=09return NULL;
+=09=09=09
+=09=09=09/* Enable ROM space decodes */
+=09=09=09pci_enable_rom(pdev);
+=09=09}
+=09}
+=09
+=09rom =3D ioremap(start, *size);
+=09if (!rom) {
+=09=09/* restore enable if ioremap fails */
+=09=09if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | =
IORESOURCE_ROM_COPY)))
+=09=09=09pci_disable_rom(pdev);
+=09=09return NULL;
+=09}=09=09
+
+=09/* Try to find the true size of the ROM since sometimes the PCI window =
*/
+=09/* size is much larger than the actual size of the ROM. */
+=09/* True size is important if the ROM is going to be copied. */
+=09image =3D rom;
+=09do {
+=09=09void __iomem *pds;
+=09=09/* Standard PCI ROMs start out with these bytes 55 AA */
+=09=09if (readb(image) !=3D 0x55)
+=09=09=09break;
+=09=09if (readb(image + 1) !=3D 0xAA)
+=09=09=09break;
+=09=09/* get the PCI data structure and check its signature */
+=09=09pds =3D image + readw(image + 24);
+=09=09if (readb(pds) !=3D 'P')
+=09=09=09break;
+=09=09if (readb(pds + 1) !=3D 'C')
+=09=09=09break;
+=09=09if (readb(pds + 2) !=3D 'I')
+=09=09=09break;
+=09=09if (readb(pds + 3) !=3D 'R')
+=09=09=09break;
+=09=09last_image =3D readb(pds + 21) & 0x80;
+=09=09/* this length is reliable */
+=09=09image +=3D readw(pds + 16) * 512;
+=09} while (!last_image);
+
+=09*size =3D image - rom;
+
+=09return rom;
+}
+
+/**
+ * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
+ * @dev: pointer to pci device struct
+ * @size: pointer to receive size of pci window over ROM
+ * @return: kernel virtual pointer to image of ROM
+ *
+ * Map a PCI ROM into kernel space. If ROM is boot video ROM,
+ * the shadow BIOS copy will be returned instead of the=20
+ * actual ROM.
+ */
+void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
+{
+=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
+=09void __iomem *rom;
+=09
+=09rom =3D pci_map_rom(pdev, size);
+=09if (!rom)
+=09=09return NULL;
+=09=09
+=09if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW))
+=09=09return rom;
+=09=09
+=09res->start =3D (unsigned long)kmalloc(*size, GFP_KERNEL);
+=09if (!res->start)=20
+=09=09return rom;
+
+=09res->end =3D res->start + *size;=20
+=09memcpy_fromio((void*)res->start, rom, *size);
+=09pci_unmap_rom(pdev, rom);
+=09res->flags |=3D IORESOURCE_ROM_COPY;
+=09
+=09return (void __iomem *)res->start;
+}
+
+/**
+ * pci_unmap_rom - unmap the ROM from kernel space
+ * @dev: pointer to pci device struct
+ * @rom: virtual address of the previous mapping
+ *
+ * Remove a mapping of a previously mapped ROM
+ */
+void=20
+pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
+{
+=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
+
+=09if (res->flags & IORESOURCE_ROM_COPY)
+=09=09return;
+=09=09
+=09iounmap(rom);
+=09=09
+=09/* Disable again before continuing, leave enabled if pci=3Drom */
+=09if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW)))
+=09=09pci_disable_rom(pdev);
+}
+
+/**
+ * pci_remove_rom - disable the ROM and remove its sysfs attribute
+ * @dev: pointer to pci device struct
+ *
+ */
+void=20
+pci_remove_rom(struct pci_dev *pdev)=20
+{
+=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
+=09
+=09if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
+=09=09sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
+=09if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IOR=
ESOURCE_ROM_COPY)))
+=09=09pci_disable_rom(pdev);
+}
+
+/**
+ * pci_cleanup_rom - internal routine for freeing the ROM copy created=20
+ * by pci_map_rom_copy called from remove.c
+ * @dev: pointer to pci device struct
+ *
+ */
+void=20
+pci_cleanup_rom(struct pci_dev *pdev)=20
+{
+=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
+=09if (res->flags & IORESOURCE_ROM_COPY) {
+=09=09kfree((void*)res->start);
+=09=09res->flags &=3D ~IORESOURCE_ROM_COPY;
+=09=09res->start =3D 0;
+=09=09res->end =3D 0;
+=09}
+}
+
+EXPORT_SYMBOL(pci_map_rom);
+EXPORT_SYMBOL(pci_map_rom_copy);
+EXPORT_SYMBOL(pci_unmap_rom);
+EXPORT_SYMBOL(pci_remove_rom);
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c=092004-10-07 22:11:55 -04:00
+++ b/drivers/pci/setup-res.c=092004-10-07 22:11:55 -04:00
@@ -56,7 +56,7 @@
 =09if (resno < 6) {
 =09=09reg =3D PCI_BASE_ADDRESS_0 + 4 * resno;
 =09} else if (resno =3D=3D PCI_ROM_RESOURCE) {
-=09=09new |=3D res->flags & PCI_ROM_ADDRESS_ENABLE;
+=09=09new |=3D res->flags & IORESOURCE_ROM_ENABLE;
 =09=09reg =3D dev->rom_base_reg;
 =09} else {
 =09=09/* Hmm, non-standard resource. */
diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h=092004-10-07 22:11:55 -04:00
+++ b/include/linux/ioport.h=092004-10-07 22:11:55 -04:00
@@ -82,6 +82,11 @@
 #define IORESOURCE_MEM_SHADOWABLE=09(1<<5)=09/* dup: IORESOURCE_SHADOWABLE=
 */
 #define IORESOURCE_MEM_EXPANSIONROM=09(1<<6)
=20
+/* PCI ROM control bits (IORESOURCE_BITS) */
+#define IORESOURCE_ROM_ENABLE=09=09(1<<0)=09/* ROM is enabled, same as PCI=
_ROM_ADDRESS_ENABLE */
+#define IORESOURCE_ROM_SHADOW=09=09(1<<1)=09/* ROM is copy at C000:0 */
+#define IORESOURCE_ROM_COPY=09=09(1<<2)=09/* ROM is alloc'd copy, resource=
 field overlaid */
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h=092004-10-07 22:11:55 -04:00
+++ b/include/linux/pci.h=092004-10-07 22:11:55 -04:00
@@ -537,6 +537,8 @@
 =09unsigned int=09is_busmaster:1; /* device is busmaster */
 =09
 =09u32=09=09saved_config_space[16]; /* config space saved at suspend time =
*/
+=09struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM e=
ntry */
+=09int rom_attr_enabled;=09=09/* has display of the rom attribute been ena=
bled? */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE=0996
 #define PCI_NAME_HALF=09__stringify(43)=09/* less than half to handle slop=
 */
@@ -777,6 +779,12 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
+
+/* ROM control related routines */
+void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size);
+void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size);
+void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
+void pci_remove_rom(struct pci_dev *pdev);
=20
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);

------=_Part_224_9388821.1097202039886--
