Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTEGMip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTEGMip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:38:45 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:36086 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263146AbTEGMig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:38:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] add module device table support for ccw devices
Date: Wed, 7 May 2003 14:46:19 +0200
User-Agent: KMail/1.5.1
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305071446.19880.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent addition of ieee1394 device table support reminded me that
I had this patch around for a long time. It adds module aliases
to device drivers for s390 ccw devices.

	Arnd <><

Index: ./include/asm-s390/ccwdev.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-s390/ccwdev.h,v
retrieving revision 1.37
diff -u -r1.37 ccwdev.h
--- ./include/asm-s390/ccwdev.h	27 Mar 2003 14:39:43 -0000	1.37
+++ ./include/asm-s390/ccwdev.h	7 May 2003 11:48:06 -0000
@@ -11,38 +11,11 @@
 #define _S390_CCWDEV_H_
 
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
 /* structs from asm/cio.h */
 struct irb;
 struct ccw1;
-
-/* the id is used to identify what hardware a device driver supports. It 
- * is used both by the ccw subsystem driver for probing and from
- * user space for automatic module loading.
- *
- * References:
- *   - struct usb_device_id (include/linux/usb.h)
- *   - devreg_hc_t (include/linux/s390dyn.h)
- *   - chandev_model_info (drivers/s390/misc/chandev.c)
- */
-struct ccw_device_id {
-	__u16	match_flags;	/* which fields to match against */
-
-	__u16	cu_type;	/* control unit type     */
-	__u16	dev_type;	/* device type           */
-	__u8	cu_model;	/* control unit model    */
-	__u8	dev_model;	/* device model          */
-
-	unsigned long driver_info;
-};
-
-enum match_flag {
-	CCW_DEVICE_ID_MATCH_CU_TYPE      = 0x01,
-	CCW_DEVICE_ID_MATCH_CU_MODEL     = 0x02,
-	CCW_DEVICE_ID_MATCH_DEVICE_TYPE  = 0x04,
-	CCW_DEVICE_ID_MATCH_DEVICE_MODEL = 0x08,
-	/* CCW_DEVICE_ID_MATCH_ANY	     = 0x10, */
-};
 
 /* simplified initializers for struct ccw_device:
  * CCW_DEVICE and CCW_DEVICE_DEVTYPE initialize one
Index: ./include/linux/mod_devicetable.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/mod_devicetable.h,v
retrieving revision 1.2
diff -u -r1.2 mod_devicetable.h
--- ./include/linux/mod_devicetable.h	6 May 2003 09:41:26 -0000	1.2
+++ ./include/linux/mod_devicetable.h	7 May 2003 11:48:06 -0000
@@ -130,4 +130,22 @@
 #define USB_DEVICE_ID_MATCH_INT_SUBCLASS	0x0100
 #define USB_DEVICE_ID_MATCH_INT_PROTOCOL	0x0200
 
+/* s390 CCW devices */
+struct ccw_device_id {
+	__u16	match_flags;	/* which fields to match against */
+
+	__u16	cu_type;	/* control unit type     */
+	__u16	dev_type;	/* device type           */
+	__u8	cu_model;	/* control unit model    */
+	__u8	dev_model;	/* device model          */
+
+	kernel_ulong_t driver_info;
+};
+
+#define CCW_DEVICE_ID_MATCH_CU_TYPE		0x01,
+#define CCW_DEVICE_ID_MATCH_CU_MODEL		0x02,
+#define CCW_DEVICE_ID_MATCH_DEVICE_TYPE		0x04,
+#define CCW_DEVICE_ID_MATCH_DEVICE_MODEL	0x08,
+
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
Index: scripts/file2alias.c
===================================================================
RCS file: /home/cvs/linux-2.5/scripts/file2alias.c,v
retrieving revision 1.3
diff -u -r1.3 file2alias.c
--- scripts/file2alias.c	6 May 2003 09:41:41 -0000	1.3
+++ scripts/file2alias.c	7 May 2003 11:48:06 -0000
@@ -147,6 +147,28 @@
 	return 1;
 }
 
+/* looks like: "ccw:tNmNdtNdmN" */ 
+static int do_ccw_entry(const char *filename,
+			struct ccw_device_id *id, char *alias)
+{
+	id->match_flags = TO_NATIVE(id->match_flags);
+	id->cu_type = TO_NATIVE(id->cu_type);
+	id->cu_model = TO_NATIVE(id->cu_model);
+	id->dev_type = TO_NATIVE(id->dev_type);
+	id->dev_model = TO_NATIVE(id->dev_model);
+
+	strcpy(alias, "ccw:");
+	ADD(alias, "t", id->match_flags&CCW_DEVICE_ID_MATCH_CU_TYPE,
+	    id->cu_type);
+	ADD(alias, "m", id->match_flags&CCW_DEVICE_ID_MATCH_CU_MODEL,
+	    id->cu_model);
+	ADD(alias, "dt", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
+	    id->dev_type);
+	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
+	    id->dev_model);
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -210,6 +232,9 @@
 	else if (sym_is(symname, "__mod_ieee1394_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct ieee1394_device_id),
 			 do_ieee1394_entry, mod);
+	else if (sym_is(symname, "__mod_ccw_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
+			 do_ccw_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */

