Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUD1TUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUD1TUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUD1TS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:18:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:5833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264957AbUD1Qv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:51:26 -0400
Date: Wed, 28 Apr 2004 09:50:41 -0700
From: Greg KH <greg@kroah.com>
To: Michael Brown <Michael_E_Brown@Dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
Message-ID: <20040428165040.GA32040@kroah.com>
References: <1083119269.1203.2821.camel@debian> <20040428033020.GA14078@kroah.com> <1083123515.1203.2826.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083123515.1203.2826.camel@debian>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 10:38:35PM -0500, Michael Brown wrote:
> On Tue, 2004-04-27 at 22:30, Greg KH wrote:
> > 
> > > /sys/firmware/smbios/smbios/table_entry_point
> > > /sys/firmware/smbios/smbios/table
> > 
> > Why repeat the "smbios" directory?  Is this a limitation in the sysfs
> > interface right now?  Or are you going to put more files in the main
> > smbios directory some day?
> 
> >From what I could tell (please correct me if I am wrong), you can add
> only subsystems to the firmware directory. The first "smbios" is for the
> subsystem. Then, you can only add devices to the subsystem. The second
> "smbios" is for the device.
> 
> I really would like to get rid of one myself, but it was not obvious to
> me how to do this. No, I do not plan on adding new objects in there.

Ok, here are 2 patches.  The first small one is on top of your latest
version.  It gets rid of the extra subdirectory, and removes the
unneeded kobject from your static structure (NEVER USE A KOBJECT IN A
STATIC STRUCTURE!!!!)

The secone one is against a clean 2.6.6-rc3 kernel that has your latest
version + my changes.

If you approve of my changes, I'd be glad to add the driver to my bk
trees to have it show up in the next -mm release, and I will push it off
to Linus after 2.6.6 is out.  Sound ok?

thanks,

greg k-h

----------------------------------
# My cleanups to the smbios driver.

diff -Nru a/drivers/firmware/smbios.c b/drivers/firmware/smbios.c
--- a/drivers/firmware/smbios.c	Wed Apr 28 09:45:59 2004
+++ b/drivers/firmware/smbios.c	Wed Apr 28 09:45:59 2004
@@ -10,9 +10,9 @@
  *
  * This code takes information provided by SMBIOS tables
  * and presents it in sysfs as:
- *    /sys/firmware/smbios/smbios
- *				|--> /table_entry_point
- *				|--> /table
+ *    /sys/firmware/smbios
+ *			|--> /table_entry_point
+ *			|--> /table
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License v2.0 as published by
@@ -42,7 +42,6 @@
 struct smbios_device {
 	struct smbios_table_entry_point table_eps;
 	unsigned int smbios_table_real_length;
-	struct kobject kobj;
 };
 
 /* there shall be only one */
@@ -143,7 +142,7 @@
 smbios_read_table_entry_point(struct kobject *kobj, char *buffer,
 				loff_t pos, size_t size)
 {
-	struct smbios_device *sdev = to_smbios_device(kobj);
+	struct smbios_device *sdev = &the_smbios_device;
 	const char *p = (const char *)&(sdev->table_eps);
 	unsigned int count =
 		size > sizeof(sdev->table_eps) ?
@@ -156,7 +155,7 @@
 smbios_read_table(struct kobject *kobj, char *buffer,
 				loff_t pos, size_t size)
 {
-	struct smbios_device *sdev = to_smbios_device(kobj);
+	struct smbios_device *sdev = &the_smbios_device;
 	u8 *buf;
 	unsigned int count = sdev->smbios_table_real_length - pos;
 	int i = 0;
@@ -204,30 +203,16 @@
 
 static decl_subsys(smbios,&ktype_smbios,NULL);
 
-static inline void
-smbios_device_unregister(struct smbios_device *sdev)
+static void smbios_device_unregister(void)
 {
-	sysfs_remove_bin_file(&sdev->kobj, &tep_attr );
-	sysfs_remove_bin_file(&sdev->kobj, &table_attr );
-	kobject_unregister(&sdev->kobj);
+	sysfs_remove_bin_file(&smbios_subsys.kset.kobj, &tep_attr );
+	sysfs_remove_bin_file(&smbios_subsys.kset.kobj, &table_attr );
 }
 
-static int
-smbios_device_register(struct smbios_device *sdev)
+static void __init smbios_device_register(void)
 {
-	int error;
-
-	if (!sdev)
-		return 1;
-
-	kobject_set_name(&sdev->kobj, "smbios");
-	kobj_set_kset_s(sdev,smbios_subsys);
-	error = kobject_register(&sdev->kobj);
-	if (!error){
-		sysfs_create_bin_file(&sdev->kobj, &tep_attr );
-		sysfs_create_bin_file(&sdev->kobj, &table_attr );
-	}
-	return error;
+	sysfs_create_bin_file(&smbios_subsys.kset.kobj, &tep_attr );
+	sysfs_create_bin_file(&smbios_subsys.kset.kobj, &table_attr );
 }
 
 static int __init
@@ -247,10 +232,7 @@
 	if (rc)
 		return rc;
 
-	rc = smbios_device_register(&the_smbios_device);
-
-	if (rc)
-		firmware_unregister(&smbios_subsys);
+	smbios_device_register();
 
 	return rc;
 }
@@ -258,7 +240,7 @@
 static void __exit
 smbios_exit(void)
 {
-	smbios_device_unregister(&the_smbios_device);
+	smbios_device_unregister();
 	firmware_unregister(&smbios_subsys);
 }
 



----------------------------------

# Whole smbios driver with my cleanup in it.

diff -Nru a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- a/drivers/firmware/Kconfig	Wed Apr 28 09:39:53 2004
+++ b/drivers/firmware/Kconfig	Wed Apr 28 09:39:53 2004
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
--- a/drivers/firmware/Makefile	Wed Apr 28 09:39:53 2004
+++ b/drivers/firmware/Makefile	Wed Apr 28 09:39:53 2004
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
+obj-$(CONFIG_SMBIOS)            += smbios.o
diff -Nru a/drivers/firmware/smbios.c b/drivers/firmware/smbios.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/smbios.c	Wed Apr 28 09:39:53 2004
@@ -0,0 +1,248 @@
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
+ *    /sys/firmware/smbios
+ *			|--> /table_entry_point
+ *			|--> /table
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
+	struct smbios_device *sdev = &the_smbios_device;
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
+	struct smbios_device *sdev = &the_smbios_device;
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
+static void smbios_device_unregister(void)
+{
+	sysfs_remove_bin_file(&smbios_subsys.kset.kobj, &tep_attr );
+	sysfs_remove_bin_file(&smbios_subsys.kset.kobj, &table_attr );
+}
+
+static void __init smbios_device_register(void)
+{
+	sysfs_create_bin_file(&smbios_subsys.kset.kobj, &tep_attr );
+	sysfs_create_bin_file(&smbios_subsys.kset.kobj, &table_attr );
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
+	smbios_device_register();
+
+	return rc;
+}
+
+static void __exit
+smbios_exit(void)
+{
+	smbios_device_unregister();
+	firmware_unregister(&smbios_subsys);
+}
+
+late_initcall(smbios_init);
+module_exit(smbios_exit);
diff -Nru a/drivers/firmware/smbios.h b/drivers/firmware/smbios.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/smbios.h	Wed Apr 28 09:39:53 2004
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
