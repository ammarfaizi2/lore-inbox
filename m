Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVDEU2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVDEU2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVDEU2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:28:13 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:41897 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261947AbVDEUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:06:25 -0400
Message-Id: <20050405194446.040549000@delft.aura.cs.cmu.edu>
References: <20050405193859.506836000@delft.aura.cs.cmu.edu>
Date: Tue, 05 Apr 2005 15:39:00 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: jaharkes@cs.cmu.edu, Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: [patch 1/5] Hotplug firmware loader for Keyspan usb-serial driver
Content-Disposition: inline; filename=keyspan-ihex_parser
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A simple Intel HEX format parser/loader.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>


 include/linux/ihex_parser.h |   23 +++++
 lib/Kconfig                 |    8 +
 lib/Makefile                |    2 
 lib/ihex_parser.c           |  181 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)

Index: linux/lib/Makefile
===================================================================
--- linux.orig/lib/Makefile	2005-04-05 15:21:30.000000000 -0400
+++ linux/lib/Makefile	2005-04-05 15:21:45.000000000 -0400
@@ -34,6 +34,8 @@ obj-$(CONFIG_ZLIB_INFLATE) += zlib_infla
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon/
 
+obj-$(CONFIG_IHEX_PARSER) += ihex_parser.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
Index: linux/lib/ihex_parser.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/lib/ihex_parser.c	2005-04-05 15:29:55.000000000 -0400
@@ -0,0 +1,181 @@
+/*
+ * Parser/loader for IHEX formatted data.
+ *
+ * Copyright (C) 2005 Jan Harkes <jaharkes@cs.cmu.edu>
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License version
+ *     2 as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/ihex_parser.h>
+
+MODULE_AUTHOR("Jan Harkes <jaharkes@cs.cmu.edu>");
+MODULE_DESCRIPTION("IHEX formatted data parser");
+MODULE_LICENSE("GPL");
+
+#ifndef QUIET
+#define dbg(msg, ...) printk(KERN_WARNING "%s: line %d: " msg, __FUNCTION__, line, ## __VA_ARGS__)
+#else
+#define dbg(msg, ...) do {} while(0)
+#endif
+
+/**
+ * nibble/hex are little helpers to parse hexadecimal numbers to a byte value
+ **/
+static __u8 nibble(const __u8 n)
+{
+       if      (n >= '0' && n <= '9') return n - '0';
+       else if (n >= 'A' && n <= 'F') return n - ('A' - 10);
+       else if (n >= 'a' && n <= 'f') return n - ('a' - 10);
+       return 0;
+}
+static __u8 hex(const __u8 *data, __u8 *crc)
+{
+       __u8 val = (nibble(data[0]) << 4) | nibble(data[1]);
+       *crc += val;
+       return val;
+}
+
+/**
+ * load_ihex:
+ *
+ * Description:
+ *     @data  is expected to point at a block of Intel HEX formatted data.
+ *     @size  is the size of the data block.
+ *
+ *     @load will be called for each record that is found in the IHEX data.
+ *
+ *     @context will be passed on to @load.
+ *
+ **/
+int load_ihex(const u8 *data, const size_t size, void *context,
+	      int (*load)(struct ihex_record *record, void *context))
+{
+	struct ihex_record *record;
+	__u32 offset = 0;
+	__u8 type, crc = 0;
+	int i, j, err = 0;
+	int line = 1;
+
+	record = kmalloc(sizeof(*record), GFP_KERNEL);
+	if (!record) {
+		dbg("Allocation failed\n");
+		return -ENOMEM;
+	}
+
+	i = 0;
+next_record:
+	/* search for the start of record character */
+	while (i < size) {
+		if (data[i] == '\n') line++;
+		if (data[i++] == ':') break;
+	}
+
+	/* Minimum record length would be about 10 characters */
+	if (i + 10 > size) {
+		dbg("Can't find valid record\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	record->len = hex(data + i, &crc);
+	i += 2;
+
+	/* now check if we have enough data to read everything */
+	if (i + 8 + (record->len * 2) > size) {
+		dbg("Not enough data to read complete record\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	record->address  = hex(data + i, &crc) << 8; i += 2;
+	record->address |= hex(data + i, &crc); i += 2;
+	record->address += offset;
+	type = hex(data + i, &crc); i += 2;
+
+	for (j = 0; j < record->len; j++, i += 2)
+		record->data[j] = hex(data + i, &crc);
+
+	/* check CRC */
+	(void)hex(data + i, &crc); i += 2;
+	if (crc != 0) {
+		dbg("CRC failure\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	/* Done reading the record */
+	switch (type) {
+	case 0:
+		/* old style EOF record? */
+		if (!record->len)
+			break;
+
+		err = load(record, context);
+		if (err < 0) {
+			dbg("Firmware load failed (err %d)\n", err);
+			break;
+		} else
+		    err = 0;
+		goto next_record;
+
+	case 1: /* End-Of-File Record */
+		if (record->address || record->len) {
+			dbg("Bad EOF record (type 01) format\n");
+			err = -EINVAL;
+		}
+		break;
+
+	case 2: /* Extended Segment Address Record (HEX86) */
+	case 4: /* Extended Linear Address Record (HEX386) */
+		if (record->address || record->len != 2) {
+			dbg("Bad HEX86/HEX386 record (type %02X)\n", type);
+			err = -EINVAL;
+			break;
+		}
+
+		/* We shouldn't really be using the offset for HEX86 because
+		 * the wraparound case is specified quite differently. */
+		offset = record->data[0] << 8 | record->data[1];
+		offset <<= (type == 2 ? 4 : 16);
+		goto next_record;
+
+	case 3: /* Start Segment Address Record */
+	case 5: /* Start Linear Address Record */
+		if (record->address || record->len != 4) {
+			dbg("Bad Start Address record (type %02X)\n", type);
+			err = -EINVAL;
+			break;
+		}
+
+		/* These records contain the CS/IP or EIP where execution
+		 * starts. Don't really know what to do with them. */
+		goto next_record;
+
+	default:
+		dbg("Unknown record (type %02X)\n", type);
+		err = -EINVAL;
+		break; /* unknown record type */
+	}
+done:
+	kfree(record);
+	return err;
+}
+
+static int __init no_init(void)
+{
+	return 0;
+}
+
+static void __exit no_exit(void)
+{
+}
+
+module_init(no_init);
+module_exit(no_exit);
+
+EXPORT_SYMBOL(load_ihex);
+
Index: linux/include/linux/ihex_parser.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/ihex_parser.h	2005-04-05 15:21:45.000000000 -0400
@@ -0,0 +1,23 @@
+/*
+ * Definitions for parser/loader for IHEX formatted data.
+ *
+ * Copyright (C) 2005 Jan Harkes <jaharkes@cs.cmu.edu>
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License version
+ *     2 as published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_IHEX_PARSER_H
+#define _LINUX_IHEX_PARSER_H
+
+struct ihex_record {
+       __u32 address;
+       __u8  len;
+       __u8  data[255];
+};
+
+int load_ihex(const u8 *data, const size_t size, void *context,
+	      int (*load)(struct ihex_record *record, void *context));
+
+#endif
Index: linux/lib/Kconfig
===================================================================
--- linux.orig/lib/Kconfig	2005-04-05 15:08:37.000000000 -0400
+++ linux/lib/Kconfig	2005-04-05 15:21:45.000000000 -0400
@@ -57,5 +57,13 @@ config REED_SOLOMON_ENC16
 config REED_SOLOMON_DEC16
 	boolean
 
+config IHEX_PARSER
+	tristate "Intel HEX formatted data parser"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require IHEX parsing, but a module built outside the
+	  kernel tree does. Such modules that need to parse Intel HEX
+	  formatted data require M here.
+
 endmenu
 

--

