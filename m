Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVDEE13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDEE13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 00:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDEE13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 00:27:29 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:36021 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261495AbVDEE1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 00:27:04 -0400
Date: Tue, 5 Apr 2005 00:26:06 -0400
To: Greg KH <greg@kroah.com>, Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/04] Load keyspan firmware with hotplug
Message-ID: <20050405042606.GB10171@delft.aura.cs.cmu.edu>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050405042329.GA10171@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405042329.GA10171@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adding firmware_load_ihex, to load IHEX formatted firmware images.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>


 drivers/base/firmware_class.c |  151 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware.h      |   26 +++++++
 2 files changed, 177 insertions(+)

Index: linux/include/linux/firmware.h
===================================================================
--- linux.orig/include/linux/firmware.h	2005-03-29 16:32:45.000000000 -0500
+++ linux/include/linux/firmware.h	2005-03-29 16:33:11.000000000 -0500
@@ -1,12 +1,34 @@
+/*
+ * Definitions for hotplug firmware loader
+ *
+ * Copyright (C) 2003 Manuel Estrada Sainz <ranty@debian.org>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ *
+ * 2005-03-10  Jan Harkes <jaharkes@cs.cmu.edu>
+ *	Added parser for IHEX formatted firmware files.
+ */
+
 #ifndef _LINUX_FIRMWARE_H
 #define _LINUX_FIRMWARE_H
+
 #include <linux/module.h>
 #include <linux/types.h>
 #define FIRMWARE_NAME_MAX 30 
+
 struct firmware {
 	size_t size;
 	u8 *data;
 };
+
+struct ihex_record {
+	__u32 address;
+	__u8  len;
+	__u8  data[255];
+};
+
 struct device;
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
@@ -15,6 +37,10 @@ int request_firmware_nowait(
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
 
+int firmware_load_ihex(const struct firmware *fw, void *context,
+		       int (*load)(struct ihex_record *record, void *context));
+
 void release_firmware(const struct firmware *fw);
 void register_firmware(const char *name, const u8 *data, size_t size);
+
 #endif
Index: linux/drivers/base/firmware_class.c
===================================================================
--- linux.orig/drivers/base/firmware_class.c	2005-03-29 16:32:45.000000000 -0500
+++ linux/drivers/base/firmware_class.c	2005-03-29 16:33:11.000000000 -0500
@@ -5,6 +5,8 @@
  *
  * Please see Documentation/firmware_class/ for more information.
  *
+ * 2005-03-10 Jan Harkes <jaharkes@cs.cmu.edu>
+ *	Added parser for IHEX formatted firmware files.
  */
 
 #include <linux/device.h>
@@ -553,6 +555,153 @@ request_firmware_nowait(
 	return 0;
 }
 
+#ifdef VERBOSE_MSGS
+#define dbg(msg, ...) printk(KERN_WARNING "%s: line %d: " msg, __FUNCTION__, line, ## __VA_ARGS__)
+#else
+#define dbg(msg, ...) do {} while(0)
+#endif
+
+/**
+ * nibble/hex are little helpers to parse hexadecimal numbers to a byte value
+ **/
+static __u8 nibble(__u8 n)
+{
+	if      (n >= '0' && n <= '9') return n - '0';
+	else if (n >= 'A' && n <= 'F') return n - ('A' - 10);
+	else if (n >= 'a' && n <= 'f') return n - ('a' - 10);
+	return 0;
+}
+static __u8 hex(__u8 *data, __u8 *crc)
+{
+	__u8 val = (nibble(data[0]) << 4) | nibble(data[1]);
+	*crc += val;
+	return val;
+}
+
+/**
+ * firmware_load_ihex:
+ *
+ * Description:
+ *	@fw is expected to contain Intel HEX formatted data.
+ *
+ *	@load will be called for each record that is found in the IHEX data.
+ *
+ *	@context will be passed on to @load.
+ *
+ **/
+int firmware_load_ihex(const struct firmware *fw, void *context,
+		       int (*load)(struct ihex_record *record, void *context))
+{
+	struct ihex_record *record;
+	__u32 offset = 0;
+	__u8 type, crc = 0;
+	int i, j, err = 0;
+	int line = 1;
+
+	record = kmalloc(sizeof(*record), GFP_KERNEL);
+	if (!record) {
+	    dbg("Allocation failed\n");
+	    return -ENOMEM;
+	}
+
+	i = 0;
+next_record:
+	/* search for the start of record character */
+	while (i < fw->size) {
+		if (fw->data[i] == '\n') line++;
+		if (fw->data[i++] == ':') break;
+	}
+
+	/* Minimum record length would be about 10 characters */
+	if (i + 10 > fw->size) {
+		dbg("Can't find valid record\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	record->len = hex(fw->data + i, &crc);
+	i += 2;
+
+	/* now check if we have enough data to read everything */
+	if (i + 8 + (record->len * 2) > fw->size) {
+		dbg("Not enough data to read complete record\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	record->address  = hex(fw->data + i, &crc) << 8; i += 2;
+	record->address |= hex(fw->data + i, &crc); i += 2;
+	record->address += offset;
+	type = hex(fw->data + i, &crc); i += 2;
+
+	for (j = 0; j < record->len; j++, i += 2)
+		record->data[j] = hex(fw->data + i, &crc);
+
+	/* check CRC */
+	(void)hex(fw->data + i, &crc); i += 2;
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
+		}
+		goto next_record;
+
+	case 1: /* End-Of-File Record */
+		if (record->address || record->len) {
+		    dbg("Bad EOF record (type 01) format\n");
+		    err = -EINVAL;
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
 static int __init
 firmware_class_init(void)
 {
@@ -584,3 +733,5 @@ EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
 EXPORT_SYMBOL(register_firmware);
+EXPORT_SYMBOL(firmware_load_ihex);
+
