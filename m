Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263411AbUD2Fkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbUD2Fkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 01:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUD2Fkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 01:40:49 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:18898
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S263411AbUD2Fkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 01:40:33 -0400
Subject: [PATCH 2.4] add SMBIOS information to /proc/smbios/
From: Michael Brown <mebrown@michaels-house.net>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Cc: mebrown@michaels-house.net, michael_e_brown@dell.com
Content-Type: text/plain
Message-Id: <1083217173.1198.2876.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Apr 2004 00:39:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	Below is a small patch for 2.4. The purpose of the patch is to export
the BIOS-provided SMBIOS tables via /proc/smbios/.

	This has been submitted against 2.6. Greg KH has agreed to forward to
mainline for the 2.6.7 release cycle. Original discussion thread for the
2.6 version, with rationale is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108311953028747&w=1

	In short, the normal way for userspace programs to access SMBIOS is
through /dev/mem. This will break in the near future as platforms move
SMBIOS tables into highmem. 

	This patch adds two files, smbios.c and smbios.h. It does not modify
any other code in the tree. It is also small, ~250 lines. Thus, I
believe that this is appropriate for 2.4.

Please apply.
--
Michael Brown


-----Forwarded Message-----
From: michael_e_brown@localhost.localdomain
To: mebrown@michaels-house.net
Subject: 2.4 patch for smbios
Date: Thu, 29 Apr 2004 00:22:03 -0500

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/29 00:16:35-05:00 michael_e_brown@meb-laptop.michaels-house.net 
#   rename smbios to proper smbios.c
# 
# drivers/char/Makefile
#   2004/04/29 00:09:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +1 -1
#   rename smbios driver to 'smbios'.
# 
# drivers/char/smbios.c
#   2004/04/29 00:08:51-05:00 michael_e_brown@meb-laptop.michaels-house.net +0 -0
#   Rename: drivers/char/procsmbios.c -> drivers/char/smbios.c
# 
# ChangeSet
#   2004/04/28 23:51:19-05:00 michael_e_brown@meb-laptop.michaels-house.net 
#   Add SMBIOS driver that exports system SMBIOS information as files in /proc/smbios.
# 
# drivers/char/smbios.h
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +53 -0
# 
# drivers/char/procsmbios.c
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +251 -0
# 
# drivers/char/smbios.h
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +0 -0
#   BitKeeper file /home/michael_e_brown/kernel/bk/subtrees/smbios-24-driver/drivers/char/smbios.h
# 
# drivers/char/procsmbios.c
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +0 -0
#   BitKeeper file /home/michael_e_brown/kernel/bk/subtrees/smbios-24-driver/drivers/char/procsmbios.c
# 
# drivers/char/Makefile
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +1 -0
#   Add SMBIOS driver to build system
# 
# drivers/char/Config.in
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +1 -0
#   Add config option to turn on SMBIOS proc driver
# 
# Documentation/Configure.help
#   2004/04/28 23:50:15-05:00 michael_e_brown@meb-laptop.michaels-house.net +14 -0
#   Add help text for SMBIOS driver
# 
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Apr 29 00:20:17 2004
+++ b/Documentation/Configure.help	Thu Apr 29 00:20:17 2004
@@ -19914,6 +19914,20 @@
 
   If unsure, say N.
 
+SMBIOS table information in /proc
+CONFIG_SMBIOS
+  This driver creates two files in /proc, /proc/smbios/table_entry_point
+  and /proc/smbios/table. These two files contain the contents of the 
+  BIOS-generated SMBIOS tables. Generally, PC-like architectures made
+  after 1997 have this, it is safe to enable on any system.
+  
+  To compile this driver as a module ( = code which can be inserted in
+  and removed from the running kernel whenever you want), say M here
+  and read <file:Documentation/modules.txt>. The module will be called
+  smbios.o.
+  
+  If unsure, say N.
+
 Sony Vaio Programmable I/O Control Device support
 CONFIG_SONYPI
   This driver enables access to the Sony Programmable I/O Control
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Thu Apr 29 00:20:17 2004
+++ b/drivers/char/Config.in	Thu Apr 29 00:20:17 2004
@@ -333,6 +333,7 @@
 if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_X86" = "y" -a "$CONFIG_X86_64" != "y" ]; then
    dep_tristate 'Sony Vaio Programmable I/O Control Device support (EXPERIMENTAL)' CONFIG_SONYPI $CONFIG_PCI
 fi
+tristate 'SMBIOS table information in /proc' CONFIG_SMBIOS
 
 mainmenu_option next_comment
 comment 'Ftape, the floppy tape device driver'
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Thu Apr 29 00:20:17 2004
+++ b/drivers/char/Makefile	Thu Apr 29 00:20:17 2004
@@ -265,6 +265,7 @@
 obj-$(CONFIG_HW_RANDOM) += hw_random.o
 obj-$(CONFIG_AMD_PM768) += amd76x_pm.o
 obj-$(CONFIG_BRIQ_PANEL) += briq_panel.o
+obj-$(CONFIG_SMBIOS) += smbios.o
 
 obj-$(CONFIG_ITE_GPIO) += ite_gpio.o
 obj-$(CONFIG_AU1X00_GPIO) += au1000_gpio.o
diff -Nru a/drivers/char/smbios.c b/drivers/char/smbios.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/smbios.c	Thu Apr 29 00:20:17 2004
@@ -0,0 +1,251 @@
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
+ * and presents it in procfs as:
+ *    /proc/smbios
+ *		|--> /table_entry_point
+ *		|--> /table
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
+#include <linux/proc_fs.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include "smbios.h"
+
+MODULE_AUTHOR("Michael Brown <Michael_E_Brown@Dell.com>");
+MODULE_DESCRIPTION("procfs interface to SMBIOS information");
+MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
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
+static struct proc_dir_entry *smbios_dir, *table_eps_file, *table_file;
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
+		if ( ptr[0] == 0x7F )   /* ptr[0] is type */
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
+	if (count != max_count)
+		printk(KERN_INFO "Warning: SMBIOS table structure count"
+				" does not match count specified in the"
+				" table entry point.\n"
+				" Table entry point count: %d\n"
+				" Actual count: %d\n",
+				max_count, count );
+
+	if (keep_going != 0)
+		printk(KERN_INFO "Warning: SMBIOS table does not end with a"
+				" structure type 127. This may indicate a"
+				" truncated table.");
+
+	if (sdev->smbios_table_real_length != max_length)
+		printk(KERN_INFO "Warning: BIOS specified SMBIOS table length"
+				" does not match calculated length.\n"
+				" BIOS specified: %d\n"
+				" calculated length: %d\n",
+				max_length, sdev->smbios_table_real_length);
+
+	return sdev->smbios_table_real_length;
+}
+
+/* simple procfs style. Print the whole thing and let core
+ * handle splitting it out for userspace and setting eof.
+ */
+static ssize_t
+smbios_read_table_entry_point(char *page, char **start,
+				off_t off, int count,
+				int *eof, void *data)
+{
+	unsigned int max_off = sizeof(the_smbios_device.table_eps);
+	MOD_INC_USE_COUNT;
+
+	memcpy(page, &the_smbios_device.table_eps, max_off);
+
+	MOD_DEC_USE_COUNT;
+	return max_off;
+}
+
+/* Use the more flexible procfs style. We tell the core that we can handle
+ * >4k transactions by setting *start. When doing this we also have to handle
+ * our own *eof and make sure not to overrun the page or count given.
+ */
+static ssize_t
+smbios_read_table(char *page, char **start,
+		off_t offset, int count,
+		int *eof, void *data)
+{
+	u8 *buf;
+	int i = 0;
+	int max_off = the_smbios_device.smbios_table_real_length;
+	MOD_INC_USE_COUNT;
+
+	if (offset > max_off)
+		return 0;
+
+	if (count > (max_off - offset))
+		count = max_off - offset;
+
+	buf = ioremap(the_smbios_device.table_eps.table_address, max_off);
+	if (buf == NULL)
+		return -ENXIO;
+
+	/* memcpy( buffer, buf+pos, count ); */
+	for (i = 0; i < count; ++i) {
+		page[i] = readb( buf+offset+i );
+	}
+
+	iounmap(buf);
+
+	*start = page; /* tells procfs that we handle >1 page */
+	MOD_DEC_USE_COUNT;
+	return count;
+}
+
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
+	find_table_max_address(&the_smbios_device);
+
+	rc = -ENOMEM;
+	smbios_dir = proc_mkdir("smbios", NULL);
+	if (smbios_dir == NULL)
+		goto out;
+
+	smbios_dir->owner = THIS_MODULE;
+
+	table_eps_file = create_proc_read_entry( "table_entry_point",
+						0444, smbios_dir,
+						smbios_read_table_entry_point,
+						NULL);
+	if (table_eps_file == NULL)
+		goto no_table_eps_file;
+
+	table_eps_file->owner = THIS_MODULE;
+
+	table_file = create_proc_read_entry( "table",
+						0444, smbios_dir,
+						smbios_read_table,
+						NULL);
+	if (table_file == NULL)
+		goto no_table_file;
+
+	table_file->owner = THIS_MODULE;
+
+	rc = 0;
+	goto out;
+no_table_file:
+	remove_proc_entry( "table_entry_point", smbios_dir );
+
+no_table_eps_file:
+	remove_proc_entry( "smbios", NULL );
+
+out:
+	return rc;
+}
+
+static void __exit
+smbios_exit(void)
+{
+	remove_proc_entry( "table_entry_point", smbios_dir );
+	remove_proc_entry( "table", smbios_dir );
+	remove_proc_entry( "smbios", NULL);
+}
+
+module_init(smbios_init);
+module_exit(smbios_exit);
diff -Nru a/drivers/char/smbios.h b/drivers/char/smbios.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/smbios.h	Thu Apr 29 00:20:17 2004
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


