Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUCQXOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCQXOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:14:03 -0500
Received: from linux.us.dell.com ([143.166.224.162]:44221 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262138AbUCQXIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:08:50 -0500
Date: Wed, 17 Mar 2004 17:08:08 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] move EDD code from i386-specific locations to generic
Message-ID: <20040317230808.GC30399@lists.us.dell.com>
References: <20040317230540.GA30399@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20040317230540.GA30399@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

EDD: move edd.c from arch/i386/kernel to new dir drivers/firmware

Fix up makefiles and Kconfigs

 arch/i386/kernel/edd.c      |  837 ---------------------------------------=
-----
 b/arch/i386/Kconfig         |   11=20
 b/arch/i386/kernel/Makefile |    1=20
 b/drivers/Makefile          |    1=20
 b/drivers/firmware/Kconfig  |   19=20
 b/drivers/firmware/Makefile |    4=20
 b/drivers/firmware/edd.c    |  837 +++++++++++++++++++++++++++++++++++++++=
+++++
 7 files changed, 862 insertions, 848 deletions

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/Kconfig	Tue Mar 16 10:03:36 2004
@@ -637,16 +637,7 @@
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
=20
-config EDD
-	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTA=
L)"
-	depends on EXPERIMENTAL
-	help
-	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
-	  Services real mode BIOS calls to determine which disk
-	  BIOS tries boot from.  This information is then exported via driverfs.
-
-	  This option is experimental, but believed to be safe,
-	  and most disk controller BIOS vendors do not yet implement this feature.
+source "drivers/firmware/Kconfig"
=20
 choice
 	prompt "High Memory Support"
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/kernel/Makefile	Tue Mar 16 10:03:36 2004
@@ -25,7 +25,6 @@
 obj-$(CONFIG_X86_IO_APIC)	+=3D io_apic.o
 obj-$(CONFIG_X86_NUMAQ)		+=3D numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+=3D summit.o
-obj-$(CONFIG_EDD)             	+=3D edd.o
 obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Tue Mar 16 10:03:36 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,837 +0,0 @@
-/*
- * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002, 2003, 2004 Dell Inc.
- *  by Matt Domsch <Matt_Domsch@dell.com>
- *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
- *  legacy CHS by Patrick J. LoPresti <patl@users.sourceforge.net>
- *
- * BIOS Enhanced Disk Drive Services (EDD)
- * conformant to T13 Committee www.t13.org
- *   projects 1572D, 1484D, 1386D, 1226DT
- *
- * This code takes information provided by BIOS EDD calls
- * fn41 - Check Extensions Present and
- * fn48 - Get Device Parametes with EDD extensions
- * made in setup.S, copied to safe structures in setup.c,
- * and presents it in sysfs.
- *
- * Please see http://domsch.com/linux/edd30/results.html for
- * the list of BIOSs which have been reported to implement EDD.
- * If you don't see yours listed, please send a report as described there.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License v2.0 as published =
by
- * the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-/*
- * Known issues:
- * - refcounting of struct device objects could be improved.
- *
- * TODO:
- * - Add IDE and USB disk device support
- * - move edd.[ch] to better locations if/when one is decided
- */
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/stat.h>
-#include <linux/err.h>
-#include <linux/ctype.h>
-#include <linux/slab.h>
-#include <linux/limits.h>
-#include <linux/device.h>
-#include <linux/pci.h>
-#include <linux/device.h>
-#include <linux/blkdev.h>
-#include <asm/edd.h>
-/* FIXME - this really belongs in include/scsi/scsi.h */
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
-
-MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
-MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
-MODULE_LICENSE("GPL");
-
-#define EDD_VERSION "0.13 2004-Mar-09"
-#define EDD_DEVICE_NAME_SIZE 16
-#define REPORT_URL "http://linux.dell.com/edd/results.html"
-
-#define left (PAGE_SIZE - (p - buf) - 1)
-
-struct edd_device {
-	struct edd_info *info;
-	struct kobject kobj;
-};
-
-struct edd_attribute {
-	struct attribute attr;
-	ssize_t(*show) (struct edd_device * edev, char *buf);
-	int (*test) (struct edd_device * edev);
-};
-
-/* forward declarations */
-static int edd_dev_is_type(struct edd_device *edev, const char *type);
-static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
-
-static struct edd_device *edd_devices[EDDMAXNR];
-
-#define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
-struct edd_attribute edd_attr_##_name =3D { 	\
-	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },	\
-	.show	=3D _show,				\
-	.test	=3D _test,				\
-};
-
-static inline struct edd_info *
-edd_dev_get_info(struct edd_device *edev)
-{
-	return edev->info;
-}
-
-static inline void
-edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
-{
-	edev->info =3D info;
-}
-
-#define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
-#define to_edd_device(obj) container_of(obj,struct edd_device,kobj)
-
-static ssize_t
-edd_attr_show(struct kobject * kobj, struct attribute *attr, char *buf)
-{
-	struct edd_device *dev =3D to_edd_device(kobj);
-	struct edd_attribute *edd_attr =3D to_edd_attr(attr);
-	ssize_t ret =3D 0;
-
-	if (edd_attr->show)
-		ret =3D edd_attr->show(dev, buf);
-	return ret;
-}
-
-static struct sysfs_ops edd_attr_ops =3D {
-	.show =3D edd_attr_show,
-};
-
-static ssize_t
-edd_show_host_bus(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	int i;
-
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	for (i =3D 0; i < 4; i++) {
-		if (isprint(info->params.host_bus_type[i])) {
-			p +=3D scnprintf(p, left, "%c", info->params.host_bus_type[i]);
-		} else {
-			p +=3D scnprintf(p, left, " ");
-		}
-	}
-
-	if (!strncmp(info->params.host_bus_type, "ISA", 3)) {
-		p +=3D scnprintf(p, left, "\tbase_address: %x\n",
-			     info->params.interface_path.isa.base_address);
-	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
-		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
-		p +=3D scnprintf(p, left,
-			     "\t%02x:%02x.%d  channel: %u\n",
-			     info->params.interface_path.pci.bus,
-			     info->params.interface_path.pci.slot,
-			     info->params.interface_path.pci.function,
-			     info->params.interface_path.pci.channel);
-	} else if (!strncmp(info->params.host_bus_type, "IBND", 4) ||
-		   !strncmp(info->params.host_bus_type, "XPRS", 4) ||
-		   !strncmp(info->params.host_bus_type, "HTPT", 4)) {
-		p +=3D scnprintf(p, left,
-			     "\tTBD: %llx\n",
-			     info->params.interface_path.ibnd.reserved);
-
-	} else {
-		p +=3D scnprintf(p, left, "\tunknown: %llx\n",
-			     info->params.interface_path.unknown.reserved);
-	}
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_interface(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	int i;
-
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	for (i =3D 0; i < 8; i++) {
-		if (isprint(info->params.interface_type[i])) {
-			p +=3D scnprintf(p, left, "%c", info->params.interface_type[i]);
-		} else {
-			p +=3D scnprintf(p, left, " ");
-		}
-	}
-	if (!strncmp(info->params.interface_type, "ATAPI", 5)) {
-		p +=3D scnprintf(p, left, "\tdevice: %u  lun: %u\n",
-			     info->params.device_path.atapi.device,
-			     info->params.device_path.atapi.lun);
-	} else if (!strncmp(info->params.interface_type, "ATA", 3)) {
-		p +=3D scnprintf(p, left, "\tdevice: %u\n",
-			     info->params.device_path.ata.device);
-	} else if (!strncmp(info->params.interface_type, "SCSI", 4)) {
-		p +=3D scnprintf(p, left, "\tid: %u  lun: %llu\n",
-			     info->params.device_path.scsi.id,
-			     info->params.device_path.scsi.lun);
-	} else if (!strncmp(info->params.interface_type, "USB", 3)) {
-		p +=3D scnprintf(p, left, "\tserial_number: %llx\n",
-			     info->params.device_path.usb.serial_number);
-	} else if (!strncmp(info->params.interface_type, "1394", 4)) {
-		p +=3D scnprintf(p, left, "\teui: %llx\n",
-			     info->params.device_path.i1394.eui);
-	} else if (!strncmp(info->params.interface_type, "FIBRE", 5)) {
-		p +=3D scnprintf(p, left, "\twwid: %llx lun: %llx\n",
-			     info->params.device_path.fibre.wwid,
-			     info->params.device_path.fibre.lun);
-	} else if (!strncmp(info->params.interface_type, "I2O", 3)) {
-		p +=3D scnprintf(p, left, "\tidentity_tag: %llx\n",
-			     info->params.device_path.i2o.identity_tag);
-	} else if (!strncmp(info->params.interface_type, "RAID", 4)) {
-		p +=3D scnprintf(p, left, "\tidentity_tag: %x\n",
-			     info->params.device_path.raid.array_number);
-	} else if (!strncmp(info->params.interface_type, "SATA", 4)) {
-		p +=3D scnprintf(p, left, "\tdevice: %u\n",
-			     info->params.device_path.sata.device);
-	} else {
-		p +=3D scnprintf(p, left, "\tunknown: %llx %llx\n",
-			     info->params.device_path.unknown.reserved1,
-			     info->params.device_path.unknown.reserved2);
-	}
-
-	return (p - buf);
-}
-
-/**
- * edd_show_raw_data() - copies raw data to buffer for userspace to parse
- *
- * Returns: number of bytes written, or -EINVAL on failure
- */
-static ssize_t
-edd_show_raw_data(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	ssize_t len =3D sizeof (info->params);
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE))
-		len =3D info->params.length;
-
-	/* In case of buggy BIOSs */
-	if (len > (sizeof(info->params)))
-		len =3D sizeof(info->params);
-
-	memcpy(buf, &info->params, len);
-	return len;
-}
-
-static ssize_t
-edd_show_version(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%02x\n", info->version);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_disk80_sig(struct edd_device *edev, char *buf)
-{
-	char *p =3D buf;
-	p +=3D scnprintf(p, left, "0x%08x\n", edd_disk80_sig);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_extensions(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
-		p +=3D scnprintf(p, left, "Fixed disk access\n");
-	}
-	if (info->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
-		p +=3D scnprintf(p, left, "Device locking and ejecting\n");
-	}
-	if (info->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
-		p +=3D scnprintf(p, left, "Enhanced Disk Drive support\n");
-	}
-	if (info->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
-		p +=3D scnprintf(p, left, "64-bit extensions\n");
-	}
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_info_flags(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	if (info->params.info_flags & EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT)
-		p +=3D scnprintf(p, left, "DMA boundary error transparent\n");
-	if (info->params.info_flags & EDD_INFO_GEOMETRY_VALID)
-		p +=3D scnprintf(p, left, "geometry valid\n");
-	if (info->params.info_flags & EDD_INFO_REMOVABLE)
-		p +=3D scnprintf(p, left, "removable\n");
-	if (info->params.info_flags & EDD_INFO_WRITE_VERIFY)
-		p +=3D scnprintf(p, left, "write verify\n");
-	if (info->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
-		p +=3D scnprintf(p, left, "media change notification\n");
-	if (info->params.info_flags & EDD_INFO_LOCKABLE)
-		p +=3D scnprintf(p, left, "lockable\n");
-	if (info->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
-		p +=3D scnprintf(p, left, "no media present\n");
-	if (info->params.info_flags & EDD_INFO_USE_INT13_FN50)
-		p +=3D scnprintf(p, left, "use int13 fn50\n");
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D snprintf(p, left, "0x%x\n", info->legacy_cylinders);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_legacy_heads(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D snprintf(p, left, "0x%x\n", info->legacy_heads);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_legacy_sectors(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D snprintf(p, left, "0x%x\n", info->legacy_sectors);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_default_cylinders(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_default_heads(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_heads);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_default_sectors_per_track(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%x\n", info->params.sectors_per_track);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_sectors(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
-	return (p - buf);
-}
-
-
-/*
- * Some device instances may not have all the above attributes,
- * or the attribute values may be meaningless (i.e. if
- * the device is < EDD 3.0, it won't have host_bus and interface
- * information), so don't bother making files for them.  Likewise
- * if the default_{cylinders,heads,sectors_per_track} values
- * are zero, the BIOS doesn't provide sane values, don't bother
- * creating files for them either.
- */
-
-static int
-edd_has_legacy_cylinders(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->legacy_cylinders > 0;
-}
-
-static int
-edd_has_legacy_heads(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->legacy_heads > 0;
-}
-
-static int
-edd_has_legacy_sectors(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->legacy_sectors > 0;
-}
-
-static int
-edd_has_default_cylinders(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->params.num_default_cylinders > 0;
-}
-
-static int
-edd_has_default_heads(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->params.num_default_heads > 0;
-}
-
-static int
-edd_has_default_sectors_per_track(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->params.sectors_per_track > 0;
-}
-
-static int
-edd_has_edd30(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	int i, nonzero_path =3D 0;
-	char c;
-
-	if (!edev || !info)
-		return 0;
-
-	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE)) {
-		return 0;
-	}
-
-	for (i =3D 30; i <=3D 73; i++) {
-		c =3D *(((uint8_t *) info) + i + 4);
-		if (c) {
-			nonzero_path++;
-			break;
-		}
-	}
-	if (!nonzero_path) {
-		return 0;
-	}
-
-	return 1;
-}
-
-static int
-edd_has_disk80_sig(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return 0;
-	return info->device =3D=3D 0x80;
-}
-
-static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
-static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
-static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
-static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
-static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
-static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
-		       edd_has_legacy_cylinders);
-static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
-		       edd_has_legacy_heads);
-static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
-		       edd_has_legacy_sectors);
-static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
-		       edd_has_default_cylinders);
-static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
-		       edd_has_default_heads);
-static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
-		       edd_show_default_sectors_per_track,
-		       edd_has_default_sectors_per_track);
-static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
-static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
-static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_d=
isk80_sig);
-
-
-/* These are default attributes that are added for every edd
- * device discovered.
- */
-static struct attribute * def_attrs[] =3D {
-	&edd_attr_raw_data.attr,
-	&edd_attr_version.attr,
-	&edd_attr_extensions.attr,
-	&edd_attr_info_flags.attr,
-	&edd_attr_sectors.attr,
-	NULL,
-};
-
-/* These attributes are conditional and only added for some devices. */
-static struct edd_attribute * edd_attrs[] =3D {
-	&edd_attr_legacy_cylinders,
-	&edd_attr_legacy_heads,
-	&edd_attr_legacy_sectors,
-	&edd_attr_default_cylinders,
-	&edd_attr_default_heads,
-	&edd_attr_default_sectors_per_track,
-	&edd_attr_interface,
-	&edd_attr_host_bus,
-	&edd_attr_mbr_signature,
-	NULL,
-};
-
-/**
- *	edd_release - free edd structure
- *	@kobj:	kobject of edd structure
- *
- *	This is called when the refcount of the edd structure
- *	reaches 0. This should happen right after we unregister,
- *	but just in case, we use the release callback anyway.
- */
-
-static void edd_release(struct kobject * kobj)
-{
-	struct edd_device * dev =3D to_edd_device(kobj);
-	kfree(dev);
-}
-
-static struct kobj_type ktype_edd =3D {
-	.release	=3D edd_release,
-	.sysfs_ops	=3D &edd_attr_ops,
-	.default_attrs	=3D def_attrs,
-};
-
-static decl_subsys(edd,&ktype_edd,NULL);
-
-
-/**
- * edd_dev_is_type() - is this EDD device a 'type' device?
- * @edev
- * @type - a host bus or interface identifier string per the EDD spec
- *
- * Returns 1 (TRUE) if it is a 'type' device, 0 otherwise.
- */
-static int
-edd_dev_is_type(struct edd_device *edev, const char *type)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-
-	if (edev && type && info) {
-		if (!strncmp(info->params.host_bus_type, type, strlen(type)) ||
-		    !strncmp(info->params.interface_type, type, strlen(type)))
-			return 1;
-	}
-	return 0;
-}
-
-/**
- * edd_get_pci_dev() - finds pci_dev that matches edev
- * @edev - edd_device
- *
- * Returns pci_dev if found, or NULL
- */
-static struct pci_dev *
-edd_get_pci_dev(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-
-	if (edd_dev_is_type(edev, "PCI")) {
-		return pci_find_slot(info->params.interface_path.pci.bus,
-				     PCI_DEVFN(info->params.interface_path.pci.slot,
-					       info->params.interface_path.pci.
-					       function));
-	}
-	return NULL;
-}
-
-static int
-edd_create_symlink_to_pcidev(struct edd_device *edev)
-{
-
-	struct pci_dev *pci_dev =3D edd_get_pci_dev(edev);
-	if (!pci_dev)
-		return 1;
-	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
-}
-
-/*
- * FIXME - as of 15-Jan-2003, there are some non-"scsi_device"s on the
- * scsi_bus list.  The following functions could possibly mis-access
- * memory in that case.  This is actually a problem with the SCSI
- * layer, which is being addressed there.  Until then, don't use the
- * SCSI functions.
- */
-
-#undef CONFIG_SCSI
-#undef CONFIG_SCSI_MODULE
-#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
-
-struct edd_match_data {
-	struct edd_device	* edev;
-	struct scsi_device	* sd;
-};
-
-/**
- * edd_match_scsidev()
- * @edev - EDD device is a known SCSI device
- * @sd - scsi_device with host who's parent is a PCI controller
- *=20
- * returns 1 if a match is found, 0 if not.
- */
-static int edd_match_scsidev(struct device * dev, void * d)
-{
-	struct edd_match_data * data =3D (struct edd_match_data *)d;
-	struct edd_info *info =3D edd_dev_get_info(data->edev);
-	struct scsi_device * sd =3D to_scsi_device(dev);
-
-	if (info) {
-		if ((sd->channel =3D=3D info->params.interface_path.pci.channel) &&
-		    (sd->id =3D=3D info->params.device_path.scsi.id) &&
-		    (sd->lun =3D=3D info->params.device_path.scsi.lun)) {
-			data->sd =3D sd;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/**
- * edd_find_matching_device()
- * @edev - edd_device to match
- *
- * Search the SCSI devices for a drive that matches the EDD=20
- * device descriptor we have. If we find a match, return it,
- * otherwise, return NULL.
- */
-
-static struct scsi_device *
-edd_find_matching_scsi_device(struct edd_device *edev)
-{
-	struct edd_match_data data;
-	struct bus_type * scsi_bus =3D find_bus("scsi");
-
-	if (!scsi_bus) {
-		return NULL;
-	}
-
-	data.edev =3D edev;
-
-	if (edd_dev_is_type(edev, "SCSI")) {
-		if (bus_for_each_dev(scsi_bus,NULL,&data,edd_match_scsidev))
-			return data.sd;
-	}
-	return NULL;
-}
-
-static int
-edd_create_symlink_to_scsidev(struct edd_device *edev)
-{
-	struct pci_dev *pci_dev;
-	int rc =3D -EINVAL;
-
-	pci_dev =3D edd_get_pci_dev(edev);
-	if (pci_dev) {
-		struct scsi_device * sdev =3D edd_find_matching_scsi_device(edev);
-		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
-			rc =3D sysfs_create_link(&edev->kobj,
-					       &sdev->sdev_driverfs_dev.kobj,
-					       "disc");
-			put_device(&sdev->sdev_driverfs_dev);
-		}
-	}
-	return rc;
-}
-
-#else
-static int
-edd_create_symlink_to_scsidev(struct edd_device *edev)
-{
-	return -ENOSYS;
-}
-#endif
-
-
-static inline void
-edd_device_unregister(struct edd_device *edev)
-{
-	kobject_unregister(&edev->kobj);
-}
-
-static void edd_populate_dir(struct edd_device * edev)
-{
-	struct edd_attribute * attr;
-	int error =3D 0;
-	int i;
-
-	for (i =3D 0; (attr =3D edd_attrs[i]) && !error; i++) {
-		if (!attr->test ||
-		    (attr->test && attr->test(edev)))
-			error =3D sysfs_create_file(&edev->kobj,&attr->attr);
-	}
-
-	if (!error) {
-		edd_create_symlink_to_pcidev(edev);
-		edd_create_symlink_to_scsidev(edev);
-	}
-}
-
-static int
-edd_device_register(struct edd_device *edev, int i)
-{
-	int error;
-
-	if (!edev)
-		return 1;
-	memset(edev, 0, sizeof (*edev));
-	edd_dev_set_info(edev, &edd[i]);
-	snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x",
-		 edd[i].device);
-	kobj_set_kset_s(edev,edd_subsys);
-	error =3D kobject_register(&edev->kobj);
-	if (!error)
-		edd_populate_dir(edev);
-	return error;
-}
-
-/**
- * edd_init() - creates sysfs tree of EDD data
- *
- * This assumes that eddnr and edd were
- * assigned in setup.c already.
- */
-static int __init
-edd_init(void)
-{
-	unsigned int i;
-	int rc=3D0;
-	struct edd_device *edev;
-
-	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
-	       EDD_VERSION, eddnr);
-	printk(KERN_INFO "Please report your BIOS at %s\n", REPORT_URL);
-
-	if (!eddnr) {
-		printk(KERN_INFO "EDD information not available.\n");
-		return 1;
-	}
-
-	rc =3D firmware_register(&edd_subsys);
-	if (rc)
-		return rc;
-
-	for (i =3D 0; i < eddnr && i < EDDMAXNR && !rc; i++) {
-		edev =3D kmalloc(sizeof (*edev), GFP_KERNEL);
-		if (!edev)
-			return -ENOMEM;
-
-		rc =3D edd_device_register(edev, i);
-		if (rc) {
-			kfree(edev);
-			break;
-		}
-		edd_devices[i] =3D edev;
-	}
-
-	if (rc)
-		firmware_unregister(&edd_subsys);
-	return rc;
-}
-
-static void __exit
-edd_exit(void)
-{
-	int i;
-	struct edd_device *edev;
-
-	for (i =3D 0; i < eddnr && i < EDDMAXNR; i++) {
-		if ((edev =3D edd_devices[i]))
-			edd_device_unregister(edev);
-	}
-	firmware_unregister(&edd_subsys);
-}
-
-late_initcall(edd_init);
-module_exit(edd_exit);
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	Tue Mar 16 10:03:36 2004
+++ b/drivers/Makefile	Tue Mar 16 10:03:36 2004
@@ -49,3 +49,4 @@
 obj-$(CONFIG_MCA)		+=3D mca/
 obj-$(CONFIG_EISA)		+=3D eisa/
 obj-$(CONFIG_CPU_FREQ)		+=3D cpufreq/
+obj-y				+=3D firmware/
diff -Nru a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/Kconfig	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,19 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+menu "Firmware Drivers"
+
+config EDD
+	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTA=
L)"
+	depends on EXPERIMENTAL
+	help
+	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
+	  Services real mode BIOS calls to determine which disk
+	  BIOS tries boot from.  This information is then exported via driverfs.
+
+	  This option is experimental, but believed to be safe,
+	  and most disk controller BIOS vendors do not yet implement this feature.
+
+endmenu
diff -Nru a/drivers/firmware/Makefile b/drivers/firmware/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/Makefile	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,4 @@
+#
+# Makefile for the linux kernel.
+#
+obj-$(CONFIG_EDD)             	+=3D edd.o
diff -Nru a/drivers/firmware/edd.c b/drivers/firmware/edd.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/edd.c	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,837 @@
+/*
+ * linux/arch/i386/kernel/edd.c
+ *  Copyright (C) 2002, 2003, 2004 Dell Inc.
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
+ *  legacy CHS by Patrick J. LoPresti <patl@users.sourceforge.net>
+ *
+ * BIOS Enhanced Disk Drive Services (EDD)
+ * conformant to T13 Committee www.t13.org
+ *   projects 1572D, 1484D, 1386D, 1226DT
+ *
+ * This code takes information provided by BIOS EDD calls
+ * fn41 - Check Extensions Present and
+ * fn48 - Get Device Parametes with EDD extensions
+ * made in setup.S, copied to safe structures in setup.c,
+ * and presents it in sysfs.
+ *
+ * Please see http://domsch.com/linux/edd30/results.html for
+ * the list of BIOSs which have been reported to implement EDD.
+ * If you don't see yours listed, please send a report as described there.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published =
by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Known issues:
+ * - refcounting of struct device objects could be improved.
+ *
+ * TODO:
+ * - Add IDE and USB disk device support
+ * - move edd.[ch] to better locations if/when one is decided
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/blkdev.h>
+#include <linux/edd.h>
+/* FIXME - this really belongs in include/scsi/scsi.h */
+#include <../drivers/scsi/scsi.h>
+#include <../drivers/scsi/hosts.h>
+
+MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
+MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
+MODULE_LICENSE("GPL");
+
+#define EDD_VERSION "0.13 2004-Mar-09"
+#define EDD_DEVICE_NAME_SIZE 16
+#define REPORT_URL "http://linux.dell.com/edd/results.html"
+
+#define left (PAGE_SIZE - (p - buf) - 1)
+
+struct edd_device {
+	struct edd_info *info;
+	struct kobject kobj;
+};
+
+struct edd_attribute {
+	struct attribute attr;
+	ssize_t(*show) (struct edd_device * edev, char *buf);
+	int (*test) (struct edd_device * edev);
+};
+
+/* forward declarations */
+static int edd_dev_is_type(struct edd_device *edev, const char *type);
+static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
+
+static struct edd_device *edd_devices[EDDMAXNR];
+
+#define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
+struct edd_attribute edd_attr_##_name =3D { 	\
+	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },	\
+	.show	=3D _show,				\
+	.test	=3D _test,				\
+};
+
+static inline struct edd_info *
+edd_dev_get_info(struct edd_device *edev)
+{
+	return edev->info;
+}
+
+static inline void
+edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
+{
+	edev->info =3D info;
+}
+
+#define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
+#define to_edd_device(obj) container_of(obj,struct edd_device,kobj)
+
+static ssize_t
+edd_attr_show(struct kobject * kobj, struct attribute *attr, char *buf)
+{
+	struct edd_device *dev =3D to_edd_device(kobj);
+	struct edd_attribute *edd_attr =3D to_edd_attr(attr);
+	ssize_t ret =3D 0;
+
+	if (edd_attr->show)
+		ret =3D edd_attr->show(dev, buf);
+	return ret;
+}
+
+static struct sysfs_ops edd_attr_ops =3D {
+	.show =3D edd_attr_show,
+};
+
+static ssize_t
+edd_show_host_bus(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	int i;
+
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < 4; i++) {
+		if (isprint(info->params.host_bus_type[i])) {
+			p +=3D scnprintf(p, left, "%c", info->params.host_bus_type[i]);
+		} else {
+			p +=3D scnprintf(p, left, " ");
+		}
+	}
+
+	if (!strncmp(info->params.host_bus_type, "ISA", 3)) {
+		p +=3D scnprintf(p, left, "\tbase_address: %x\n",
+			     info->params.interface_path.isa.base_address);
+	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
+		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
+		p +=3D scnprintf(p, left,
+			     "\t%02x:%02x.%d  channel: %u\n",
+			     info->params.interface_path.pci.bus,
+			     info->params.interface_path.pci.slot,
+			     info->params.interface_path.pci.function,
+			     info->params.interface_path.pci.channel);
+	} else if (!strncmp(info->params.host_bus_type, "IBND", 4) ||
+		   !strncmp(info->params.host_bus_type, "XPRS", 4) ||
+		   !strncmp(info->params.host_bus_type, "HTPT", 4)) {
+		p +=3D scnprintf(p, left,
+			     "\tTBD: %llx\n",
+			     info->params.interface_path.ibnd.reserved);
+
+	} else {
+		p +=3D scnprintf(p, left, "\tunknown: %llx\n",
+			     info->params.interface_path.unknown.reserved);
+	}
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_interface(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	int i;
+
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		if (isprint(info->params.interface_type[i])) {
+			p +=3D scnprintf(p, left, "%c", info->params.interface_type[i]);
+		} else {
+			p +=3D scnprintf(p, left, " ");
+		}
+	}
+	if (!strncmp(info->params.interface_type, "ATAPI", 5)) {
+		p +=3D scnprintf(p, left, "\tdevice: %u  lun: %u\n",
+			     info->params.device_path.atapi.device,
+			     info->params.device_path.atapi.lun);
+	} else if (!strncmp(info->params.interface_type, "ATA", 3)) {
+		p +=3D scnprintf(p, left, "\tdevice: %u\n",
+			     info->params.device_path.ata.device);
+	} else if (!strncmp(info->params.interface_type, "SCSI", 4)) {
+		p +=3D scnprintf(p, left, "\tid: %u  lun: %llu\n",
+			     info->params.device_path.scsi.id,
+			     info->params.device_path.scsi.lun);
+	} else if (!strncmp(info->params.interface_type, "USB", 3)) {
+		p +=3D scnprintf(p, left, "\tserial_number: %llx\n",
+			     info->params.device_path.usb.serial_number);
+	} else if (!strncmp(info->params.interface_type, "1394", 4)) {
+		p +=3D scnprintf(p, left, "\teui: %llx\n",
+			     info->params.device_path.i1394.eui);
+	} else if (!strncmp(info->params.interface_type, "FIBRE", 5)) {
+		p +=3D scnprintf(p, left, "\twwid: %llx lun: %llx\n",
+			     info->params.device_path.fibre.wwid,
+			     info->params.device_path.fibre.lun);
+	} else if (!strncmp(info->params.interface_type, "I2O", 3)) {
+		p +=3D scnprintf(p, left, "\tidentity_tag: %llx\n",
+			     info->params.device_path.i2o.identity_tag);
+	} else if (!strncmp(info->params.interface_type, "RAID", 4)) {
+		p +=3D scnprintf(p, left, "\tidentity_tag: %x\n",
+			     info->params.device_path.raid.array_number);
+	} else if (!strncmp(info->params.interface_type, "SATA", 4)) {
+		p +=3D scnprintf(p, left, "\tdevice: %u\n",
+			     info->params.device_path.sata.device);
+	} else {
+		p +=3D scnprintf(p, left, "\tunknown: %llx %llx\n",
+			     info->params.device_path.unknown.reserved1,
+			     info->params.device_path.unknown.reserved2);
+	}
+
+	return (p - buf);
+}
+
+/**
+ * edd_show_raw_data() - copies raw data to buffer for userspace to parse
+ *
+ * Returns: number of bytes written, or -EINVAL on failure
+ */
+static ssize_t
+edd_show_raw_data(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	ssize_t len =3D sizeof (info->params);
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE))
+		len =3D info->params.length;
+
+	/* In case of buggy BIOSs */
+	if (len > (sizeof(info->params)))
+		len =3D sizeof(info->params);
+
+	memcpy(buf, &info->params, len);
+	return len;
+}
+
+static ssize_t
+edd_show_version(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%02x\n", info->version);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_disk80_sig(struct edd_device *edev, char *buf)
+{
+	char *p =3D buf;
+	p +=3D scnprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_extensions(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
+		p +=3D scnprintf(p, left, "Fixed disk access\n");
+	}
+	if (info->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
+		p +=3D scnprintf(p, left, "Device locking and ejecting\n");
+	}
+	if (info->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
+		p +=3D scnprintf(p, left, "Enhanced Disk Drive support\n");
+	}
+	if (info->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
+		p +=3D scnprintf(p, left, "64-bit extensions\n");
+	}
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_info_flags(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	if (info->params.info_flags & EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT)
+		p +=3D scnprintf(p, left, "DMA boundary error transparent\n");
+	if (info->params.info_flags & EDD_INFO_GEOMETRY_VALID)
+		p +=3D scnprintf(p, left, "geometry valid\n");
+	if (info->params.info_flags & EDD_INFO_REMOVABLE)
+		p +=3D scnprintf(p, left, "removable\n");
+	if (info->params.info_flags & EDD_INFO_WRITE_VERIFY)
+		p +=3D scnprintf(p, left, "write verify\n");
+	if (info->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
+		p +=3D scnprintf(p, left, "media change notification\n");
+	if (info->params.info_flags & EDD_INFO_LOCKABLE)
+		p +=3D scnprintf(p, left, "lockable\n");
+	if (info->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
+		p +=3D scnprintf(p, left, "no media present\n");
+	if (info->params.info_flags & EDD_INFO_USE_INT13_FN50)
+		p +=3D scnprintf(p, left, "use int13 fn50\n");
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_cylinders);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_heads(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_heads);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_sectors(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_sectors);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_cylinders(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_heads(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_heads);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_sectors_per_track(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%x\n", info->params.sectors_per_track);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_sectors(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
+	return (p - buf);
+}
+
+
+/*
+ * Some device instances may not have all the above attributes,
+ * or the attribute values may be meaningless (i.e. if
+ * the device is < EDD 3.0, it won't have host_bus and interface
+ * information), so don't bother making files for them.  Likewise
+ * if the default_{cylinders,heads,sectors_per_track} values
+ * are zero, the BIOS doesn't provide sane values, don't bother
+ * creating files for them either.
+ */
+
+static int
+edd_has_legacy_cylinders(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_cylinders > 0;
+}
+
+static int
+edd_has_legacy_heads(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_heads > 0;
+}
+
+static int
+edd_has_legacy_sectors(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_sectors > 0;
+}
+
+static int
+edd_has_default_cylinders(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->params.num_default_cylinders > 0;
+}
+
+static int
+edd_has_default_heads(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->params.num_default_heads > 0;
+}
+
+static int
+edd_has_default_sectors_per_track(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->params.sectors_per_track > 0;
+}
+
+static int
+edd_has_edd30(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	int i, nonzero_path =3D 0;
+	char c;
+
+	if (!edev || !info)
+		return 0;
+
+	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE)) {
+		return 0;
+	}
+
+	for (i =3D 30; i <=3D 73; i++) {
+		c =3D *(((uint8_t *) info) + i + 4);
+		if (c) {
+			nonzero_path++;
+			break;
+		}
+	}
+	if (!nonzero_path) {
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+edd_has_disk80_sig(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 0;
+	return info->device =3D=3D 0x80;
+}
+
+static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
+static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
+static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
+static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
+static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
+static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
+		       edd_has_legacy_cylinders);
+static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
+		       edd_has_legacy_heads);
+static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
+		       edd_has_legacy_sectors);
+static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
+		       edd_has_default_cylinders);
+static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
+		       edd_has_default_heads);
+static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
+		       edd_show_default_sectors_per_track,
+		       edd_has_default_sectors_per_track);
+static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
+static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
+static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_d=
isk80_sig);
+
+
+/* These are default attributes that are added for every edd
+ * device discovered.
+ */
+static struct attribute * def_attrs[] =3D {
+	&edd_attr_raw_data.attr,
+	&edd_attr_version.attr,
+	&edd_attr_extensions.attr,
+	&edd_attr_info_flags.attr,
+	&edd_attr_sectors.attr,
+	NULL,
+};
+
+/* These attributes are conditional and only added for some devices. */
+static struct edd_attribute * edd_attrs[] =3D {
+	&edd_attr_legacy_cylinders,
+	&edd_attr_legacy_heads,
+	&edd_attr_legacy_sectors,
+	&edd_attr_default_cylinders,
+	&edd_attr_default_heads,
+	&edd_attr_default_sectors_per_track,
+	&edd_attr_interface,
+	&edd_attr_host_bus,
+	&edd_attr_mbr_signature,
+	NULL,
+};
+
+/**
+ *	edd_release - free edd structure
+ *	@kobj:	kobject of edd structure
+ *
+ *	This is called when the refcount of the edd structure
+ *	reaches 0. This should happen right after we unregister,
+ *	but just in case, we use the release callback anyway.
+ */
+
+static void edd_release(struct kobject * kobj)
+{
+	struct edd_device * dev =3D to_edd_device(kobj);
+	kfree(dev);
+}
+
+static struct kobj_type ktype_edd =3D {
+	.release	=3D edd_release,
+	.sysfs_ops	=3D &edd_attr_ops,
+	.default_attrs	=3D def_attrs,
+};
+
+static decl_subsys(edd,&ktype_edd,NULL);
+
+
+/**
+ * edd_dev_is_type() - is this EDD device a 'type' device?
+ * @edev
+ * @type - a host bus or interface identifier string per the EDD spec
+ *
+ * Returns 1 (TRUE) if it is a 'type' device, 0 otherwise.
+ */
+static int
+edd_dev_is_type(struct edd_device *edev, const char *type)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+
+	if (edev && type && info) {
+		if (!strncmp(info->params.host_bus_type, type, strlen(type)) ||
+		    !strncmp(info->params.interface_type, type, strlen(type)))
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * edd_get_pci_dev() - finds pci_dev that matches edev
+ * @edev - edd_device
+ *
+ * Returns pci_dev if found, or NULL
+ */
+static struct pci_dev *
+edd_get_pci_dev(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+
+	if (edd_dev_is_type(edev, "PCI")) {
+		return pci_find_slot(info->params.interface_path.pci.bus,
+				     PCI_DEVFN(info->params.interface_path.pci.slot,
+					       info->params.interface_path.pci.
+					       function));
+	}
+	return NULL;
+}
+
+static int
+edd_create_symlink_to_pcidev(struct edd_device *edev)
+{
+
+	struct pci_dev *pci_dev =3D edd_get_pci_dev(edev);
+	if (!pci_dev)
+		return 1;
+	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
+}
+
+/*
+ * FIXME - as of 15-Jan-2003, there are some non-"scsi_device"s on the
+ * scsi_bus list.  The following functions could possibly mis-access
+ * memory in that case.  This is actually a problem with the SCSI
+ * layer, which is being addressed there.  Until then, don't use the
+ * SCSI functions.
+ */
+
+#undef CONFIG_SCSI
+#undef CONFIG_SCSI_MODULE
+#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
+
+struct edd_match_data {
+	struct edd_device	* edev;
+	struct scsi_device	* sd;
+};
+
+/**
+ * edd_match_scsidev()
+ * @edev - EDD device is a known SCSI device
+ * @sd - scsi_device with host who's parent is a PCI controller
+ *=20
+ * returns 1 if a match is found, 0 if not.
+ */
+static int edd_match_scsidev(struct device * dev, void * d)
+{
+	struct edd_match_data * data =3D (struct edd_match_data *)d;
+	struct edd_info *info =3D edd_dev_get_info(data->edev);
+	struct scsi_device * sd =3D to_scsi_device(dev);
+
+	if (info) {
+		if ((sd->channel =3D=3D info->params.interface_path.pci.channel) &&
+		    (sd->id =3D=3D info->params.device_path.scsi.id) &&
+		    (sd->lun =3D=3D info->params.device_path.scsi.lun)) {
+			data->sd =3D sd;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * edd_find_matching_device()
+ * @edev - edd_device to match
+ *
+ * Search the SCSI devices for a drive that matches the EDD=20
+ * device descriptor we have. If we find a match, return it,
+ * otherwise, return NULL.
+ */
+
+static struct scsi_device *
+edd_find_matching_scsi_device(struct edd_device *edev)
+{
+	struct edd_match_data data;
+	struct bus_type * scsi_bus =3D find_bus("scsi");
+
+	if (!scsi_bus) {
+		return NULL;
+	}
+
+	data.edev =3D edev;
+
+	if (edd_dev_is_type(edev, "SCSI")) {
+		if (bus_for_each_dev(scsi_bus,NULL,&data,edd_match_scsidev))
+			return data.sd;
+	}
+	return NULL;
+}
+
+static int
+edd_create_symlink_to_scsidev(struct edd_device *edev)
+{
+	struct pci_dev *pci_dev;
+	int rc =3D -EINVAL;
+
+	pci_dev =3D edd_get_pci_dev(edev);
+	if (pci_dev) {
+		struct scsi_device * sdev =3D edd_find_matching_scsi_device(edev);
+		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
+			rc =3D sysfs_create_link(&edev->kobj,
+					       &sdev->sdev_driverfs_dev.kobj,
+					       "disc");
+			put_device(&sdev->sdev_driverfs_dev);
+		}
+	}
+	return rc;
+}
+
+#else
+static int
+edd_create_symlink_to_scsidev(struct edd_device *edev)
+{
+	return -ENOSYS;
+}
+#endif
+
+
+static inline void
+edd_device_unregister(struct edd_device *edev)
+{
+	kobject_unregister(&edev->kobj);
+}
+
+static void edd_populate_dir(struct edd_device * edev)
+{
+	struct edd_attribute * attr;
+	int error =3D 0;
+	int i;
+
+	for (i =3D 0; (attr =3D edd_attrs[i]) && !error; i++) {
+		if (!attr->test ||
+		    (attr->test && attr->test(edev)))
+			error =3D sysfs_create_file(&edev->kobj,&attr->attr);
+	}
+
+	if (!error) {
+		edd_create_symlink_to_pcidev(edev);
+		edd_create_symlink_to_scsidev(edev);
+	}
+}
+
+static int
+edd_device_register(struct edd_device *edev, int i)
+{
+	int error;
+
+	if (!edev)
+		return 1;
+	memset(edev, 0, sizeof (*edev));
+	edd_dev_set_info(edev, &edd[i]);
+	snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x",
+		 edd[i].device);
+	kobj_set_kset_s(edev,edd_subsys);
+	error =3D kobject_register(&edev->kobj);
+	if (!error)
+		edd_populate_dir(edev);
+	return error;
+}
+
+/**
+ * edd_init() - creates sysfs tree of EDD data
+ *
+ * This assumes that eddnr and edd were
+ * assigned in setup.c already.
+ */
+static int __init
+edd_init(void)
+{
+	unsigned int i;
+	int rc=3D0;
+	struct edd_device *edev;
+
+	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
+	       EDD_VERSION, eddnr);
+	printk(KERN_INFO "Please report your BIOS at %s\n", REPORT_URL);
+
+	if (!eddnr) {
+		printk(KERN_INFO "EDD information not available.\n");
+		return 1;
+	}
+
+	rc =3D firmware_register(&edd_subsys);
+	if (rc)
+		return rc;
+
+	for (i =3D 0; i < eddnr && i < EDDMAXNR && !rc; i++) {
+		edev =3D kmalloc(sizeof (*edev), GFP_KERNEL);
+		if (!edev)
+			return -ENOMEM;
+
+		rc =3D edd_device_register(edev, i);
+		if (rc) {
+			kfree(edev);
+			break;
+		}
+		edd_devices[i] =3D edev;
+	}
+
+	if (rc)
+		firmware_unregister(&edd_subsys);
+	return rc;
+}
+
+static void __exit
+edd_exit(void)
+{
+	int i;
+	struct edd_device *edev;
+
+	for (i =3D 0; i < eddnr && i < EDDMAXNR; i++) {
+		if ((edev =3D edd_devices[i]))
+			edd_device_unregister(edev);
+	}
+	firmware_unregister(&edd_subsys);
+}
+
+late_initcall(edd_init);
+module_exit(edd_exit);

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAWNpYIavu95Lw/AkRArTjAJwJyG9C84muSmLJgogmOh118cMiCQCeORPM
MYyQvCfZl7+SaOVwsL7r0KA=
=y19S
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
