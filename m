Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUD1EnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUD1EnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 00:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUD1EnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 00:43:06 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:36049
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S264645AbUD1EmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 00:42:12 -0400
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs -- UPDATED
From: Michael Brown <Michael_E_Brown@Dell.com>
Reply-To: Michael_E_Brown@Dell.com
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040428033020.GA14078@kroah.com>
References: <1083119269.1203.2821.camel@debian>
	 <20040428033020.GA14078@kroah.com>
Content-Type: multipart/mixed; boundary="=-oQJbJpI1vku7Y41Qrc39"
Organization: Dell Inc
Message-Id: <1083127267.1195.2848.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Apr 2004 23:41:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oQJbJpI1vku7Y41Qrc39
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-04-27 at 22:30, Greg KH wrote:
> > +	snprintf(sdev->kobj.name, 7, "smbios" );
> 
> Try using kobject_set_name() instead, it will do the proper thing if the
> string is bigger than the base kobj.name field.

Updated per Greg's comments. One other change, I fixed up a cut and
paste error in the copyright line, no code affected.

built and run tested ok.
--
Michael


--=-oQJbJpI1vku7Y41Qrc39
Content-Description: 
Content-Disposition: attachment; filename=smbios-sysfs-updated.diff
Content-Type: text/x-patch; charset=
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/27 23:29:00-05:00 michael_e_brown@meb-laptop.michaels-house.net 
#   Add driver to present SMBIOS data in sysfs.
# 
# drivers/firmware/smbios.h
#   2004/04/27 23:26:57-05:00 michael_e_brown@meb-laptop.michaels-house.net +53 -0
# 
# drivers/firmware/smbios.h
#   2004/04/27 23:26:57-05:00 michael_e_brown@meb-laptop.michaels-house.net +0 -0
#   BitKeeper file /home/michael_e_brown/kernel/bk/subtrees/smbios-driver-work-fb/drivers/firmware/smbios.h
# 
# drivers/firmware/smbios.c
#   2004/04/27 23:26:56-05:00 michael_e_brown@meb-laptop.michaels-house.net +266 -0
# 
# drivers/firmware/smbios.c
#   2004/04/27 23:26:56-05:00 michael_e_brown@meb-laptop.michaels-house.net +0 -0
#   BitKeeper file /home/michael_e_brown/kernel/bk/subtrees/smbios-driver-work-fb/drivers/firmware/smbios.c
# 
# drivers/firmware/Makefile
#   2004/04/27 23:26:56-05:00 michael_e_brown@meb-laptop.michaels-house.net +1 -0
#   add SMBIOS sysfs driver to build system
# 
# drivers/firmware/Kconfig
#   2004/04/27 23:26:56-05:00 michael_e_brown@meb-laptop.michaels-house.net +8 -0
#   Add SMBIOS sysfs config option
# 
diff -Nru a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- a/drivers/firmware/Kconfig	Tue Apr 27 23:30:02 2004
+++ b/drivers/firmware/Kconfig	Tue Apr 27 23:30:02 2004
@@ -34,4 +34,12 @@
 	  Subsequent efibootmgr releases may be found at:
 	  http://linux.dell.com/efibootmgr
 
+config SMBIOS
+	tristate "BIOS SMBIOS table access driver."
+	help
+	  Say Y or M here if you want to enable access to the SMBIOS table
+	  via driverfs. It exposes /sys/firmware/smbios/ subdirectory tree
+	  containing a binary dump of the SMBIOS table header as well as the SMBIOS
+	  table.
+
 endmenu
diff -Nru a/drivers/firmware/Makefile b/drivers/firmware/Makefile
--- a/drivers/firmware/Makefile	Tue Apr 27 23:30:02 2004
+++ b/drivers/firmware/Makefile	Tue Apr 27 23:30:02 2004
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
+obj-$(CONFIG_SMBIOS)            += smbios.o
diff -Nru a/drivers/firmware/smbios.c b/drivers/firmware/smbios.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/smbios.c	Tue Apr 27 23:30:02 2004
@@ -0,0 +1,266 @@
+/*
+ * linux/drivers/firmware/smbios.c
+ *  Copyright (C) 2004 Dell Inc.
+ *  by Michael Brown <Michael_E_Brown@dell.com>
+ *  vim:noet:ts=8:sw=8:filetype=c:textwidth=80:
+ *
+ * BIOS SMBIOS Table access
+ * conformant to DMTF SMBIOS definition
+ *   at http://www.dmtf.org/standards/smbios
+ *
+ * This code takes information provided by SMBIOS tables
+ * and presents it in sysfs as:
+ *    /sys/firmware/smbios/smbios
+ *				|--> /table_entry_point
+ *				|--> /table
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include "smbios.h"
+
+MODULE_AUTHOR("Michael Brown <Michael_E_Brown@Dell.com>");
+MODULE_DESCRIPTION("sysfs interface to SMBIOS information");
+MODULE_LICENSE("GPL");
+
+#define SMBIOS_VERSION "1.0 2004-04-19"
+
+struct smbios_device {
+	struct smbios_table_entry_point table_eps;
+	unsigned int smbios_table_real_length;
+	struct kobject kobj;
+};
+
+/* there shall be only one */
+static struct smbios_device the_smbios_device;
+
+#define to_smbios_device(obj) container_of(obj,struct smbios_device,kobj)
+
+/* don't currently have any "normal" attributes, so we don't need a way to
+ * show them. */
+static struct sysfs_ops smbios_attr_ops = { };
+
+static __init int
+checksum_eps(struct smbios_table_entry_point *table_eps)
+{
+	u8 *p = (u8 *)table_eps;
+	u8 checksum = 0;
+	int i=0;
+	for (i=0; i < table_eps->eps_length && i < sizeof(*table_eps); ++i) {
+		checksum += p[i];
+	}
+	return( checksum == 0 );
+}
+
+static __init int
+find_table_entry_point(struct smbios_device *sdev)
+{
+	struct smbios_table_entry_point *table_eps = &(sdev->table_eps);
+	u32 fp = 0xF0000;
+	while (fp < 0xFFFFF) {
+		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
+		if (memcmp(table_eps->anchor, "_SM_", 4)==0 &&
+					checksum_eps(table_eps)) {
+			return 0;
+		}
+		fp += 16;
+	}
+
+	printk(KERN_INFO "SMBIOS table entry point not found in "
+			"0xF0000 - 0xFFFFF\n");
+	return -ENODEV;
+}
+
+static __init int
+find_table_max_address(struct smbios_device *sdev)
+{
+	/* break out on one of three conditions:
+	 *   -- hit table_eps.table_length
+	 *   -- hit number of items that table claims we have
+	 *   -- hit structure type 127
+	 */
+
+	u8 *buf = ioremap(sdev->table_eps.table_address,
+			sdev->table_eps.table_length);
+	u8 *ptr = buf;
+	int count = 0, keep_going = 1;
+	int max_count = sdev->table_eps.table_num_structs;
+	int max_length = sdev->table_eps.table_length;
+	while(keep_going && ((ptr - buf) <= max_length) && count < max_count){
+		if( ptr[0] == 0x7F )   /* ptr[0] is type */
+			keep_going = 0;
+
+		ptr += ptr[1]; /* ptr[1] is length, skip structure */
+		/* skip strings at end of structure */
+		while((ptr-buf) < max_length && (ptr[0] || ptr[1]))
+			++ptr;
+
+		/* string area ends in double-null. skip it. */
+		ptr += 2;
+		++count;
+	}
+	sdev->smbios_table_real_length = (ptr - buf);
+	iounmap(buf);
+
+	if( count != max_count )
+		printk(KERN_INFO "Warning: SMBIOS table structure count"
+				" does not match count specified in the"
+				" table entry point.\n"
+				" Table entry point count: %d\n"
+				" Actual count: %d\n",
+				max_count, count );
+
+	if(keep_going != 0)
+		printk(KERN_INFO "Warning: SMBIOS table does not end with a"
+				" structure type 127. This may indicate a"
+				" truncated table.");
+
+	if(sdev->smbios_table_real_length != max_length)
+		printk(KERN_INFO "Warning: BIOS specified SMBIOS table length"
+				" does not match calculated length.\n"
+				" BIOS specified: %d\n"
+				" calculated length: %d\n",
+				max_length, sdev->smbios_table_real_length);
+
+	return sdev->smbios_table_real_length;
+}
+
+static ssize_t
+smbios_read_table_entry_point(struct kobject *kobj, char *buffer,
+				loff_t pos, size_t size)
+{
+	struct smbios_device *sdev = to_smbios_device(kobj);
+	const char *p = (const char *)&(sdev->table_eps);
+	unsigned int count =
+		size > sizeof(sdev->table_eps) ?
+			sizeof(sdev->table_eps) : size;
+	memcpy( buffer, p, count );
+	return count;
+}
+
+static ssize_t
+smbios_read_table(struct kobject *kobj, char *buffer,
+				loff_t pos, size_t size)
+{
+	struct smbios_device *sdev = to_smbios_device(kobj);
+	u8 *buf;
+	unsigned int count = sdev->smbios_table_real_length - pos;
+	int i = 0;
+	count = count < size ? count : size;
+
+	if (pos > sdev->smbios_table_real_length)
+		return 0;
+
+	buf = ioremap(sdev->table_eps.table_address, sdev->smbios_table_real_length);
+	if (buf == NULL)
+		return -ENXIO;
+
+	/* memcpy( buffer, buf+pos, count ); */
+	for (i = 0; i < count; ++i) {
+		buffer[i] = readb( buf+pos+i );
+	}
+
+	iounmap(buf);
+
+	return count;
+}
+
+static struct bin_attribute tep_attr = {
+	.attr = {.name = "table_entry_point", .owner = THIS_MODULE, .mode = 0444},
+	.size = sizeof(struct smbios_table_entry_point),
+	.read = smbios_read_table_entry_point,
+	/* not writeable */
+};
+
+static struct bin_attribute table_attr = {
+	.attr = { .name = "table", .owner = THIS_MODULE, .mode = 0444 },
+	/* size set later, we don't know it here. */
+	.read = smbios_read_table,
+	/* not writeable */
+};
+
+/* no default attributes yet. */
+static struct attribute * def_attrs[] = { NULL, };
+
+static struct kobj_type ktype_smbios = {
+	.sysfs_ops	= &smbios_attr_ops,
+	.default_attrs	= def_attrs,
+	/* statically allocated, no release method necessary */
+};
+
+static decl_subsys(smbios,&ktype_smbios,NULL);
+
+static inline void
+smbios_device_unregister(struct smbios_device *sdev)
+{
+	sysfs_remove_bin_file(&sdev->kobj, &tep_attr );
+	sysfs_remove_bin_file(&sdev->kobj, &table_attr );
+	kobject_unregister(&sdev->kobj);
+}
+
+static int
+smbios_device_register(struct smbios_device *sdev)
+{
+	int error;
+
+	if (!sdev)
+		return 1;
+
+	kobject_set_name(&sdev->kobj, "smbios");
+	kobj_set_kset_s(sdev,smbios_subsys);
+	error = kobject_register(&sdev->kobj);
+	if (!error){
+		sysfs_create_bin_file(&sdev->kobj, &tep_attr );
+		sysfs_create_bin_file(&sdev->kobj, &table_attr );
+	}
+	return error;
+}
+
+static int __init
+smbios_init(void)
+{
+	int rc=0;
+
+	printk(KERN_INFO "SMBIOS facility v%s\n", SMBIOS_VERSION );
+
+	rc = find_table_entry_point(&the_smbios_device);
+	if (rc)
+		return rc;
+
+	table_attr.size = find_table_max_address(&the_smbios_device);
+
+	rc = firmware_register(&smbios_subsys);
+	if (rc)
+		return rc;
+
+	rc = smbios_device_register(&the_smbios_device);
+
+	if (rc)
+		firmware_unregister(&smbios_subsys);
+
+	return rc;
+}
+
+static void __exit
+smbios_exit(void)
+{
+	smbios_device_unregister(&the_smbios_device);
+	firmware_unregister(&smbios_subsys);
+}
+
+late_initcall(smbios_init);
+module_exit(smbios_exit);
diff -Nru a/drivers/firmware/smbios.h b/drivers/firmware/smbios.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/smbios.h	Tue Apr 27 23:30:02 2004
@@ -0,0 +1,53 @@
+/*
+ * linux/drivers/firmware/smbios.c
+ *  Copyright (C) 2002, 2003, 2004 Dell Inc.
+ *  by Michael Brown <Michael_E_Brown@dell.com>
+ *  vim:noet:ts=8:sw=8:filetype=c:textwidth=80:
+ *
+ * BIOS SMBIOS Table access 
+ * conformant to DMTF SMBIOS definition
+ *   at http://www.dmtf.org/standards/smbios
+ *
+ * This code takes information provided by SMBIOS tables
+ * and presents it in sysfs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LINUX_SMBIOS_H
+#define _LINUX_SMBIOS_H
+
+#include <linux/types.h>
+
+struct smbios_table_entry_point {
+	u8 anchor[4];
+	u8 checksum;
+	u8 eps_length;
+	u8 major_ver;
+	u8 minor_ver;
+	u16 max_struct_size;
+	u8 revision;
+	u8 formatted_area[5];
+	u8 dmi_anchor[5];
+	u8 intermediate_checksum;
+	u16 table_length;
+	u32 table_address;
+	u16 table_num_structs;
+	u8 smbios_bcd_revision;
+} __attribute__ ((packed));
+
+struct smbios_structure_header {
+	u8 type;
+	u8 length;
+	u16 handle;
+} __attribute__ ((packed));
+
+#endif				/* _LINUX_SMBIOS_H */

--=-oQJbJpI1vku7Y41Qrc39--

