Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTEZRNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTEZRMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:12:43 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:30156 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261840AbTEZRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:12:17 -0400
Date: Mon, 26 May 2003 19:24:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/10): module alias support.
Message-ID: <20030526172430.GD3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add module alias support for ccw devices.

diffstat:
 include/asm-s390/ccwdev.h       |   29 +----------------------------
 include/linux/mod_devicetable.h |   18 ++++++++++++++++++
 scripts/file2alias.c            |   25 +++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 28 deletions(-)

diff -urN linux-2.5/include/asm-s390/ccwdev.h linux-2.5-s390/include/asm-s390/ccwdev.h
--- linux-2.5/include/asm-s390/ccwdev.h	Mon May  5 01:53:40 2003
+++ linux-2.5-s390/include/asm-s390/ccwdev.h	Mon May 26 19:20:44 2003
@@ -11,39 +11,12 @@
 #define _S390_CCWDEV_H_
 
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
 /* structs from asm/cio.h */
 struct irb;
 struct ccw1;
 
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
-
 /* simplified initializers for struct ccw_device:
  * CCW_DEVICE and CCW_DEVICE_DEVTYPE initialize one
  * entry in your MODULE_DEVICE_TABLE and set the match_flag correctly */
diff -urN linux-2.5/include/linux/mod_devicetable.h linux-2.5-s390/include/linux/mod_devicetable.h
--- linux-2.5/include/linux/mod_devicetable.h	Mon May  5 01:53:55 2003
+++ linux-2.5-s390/include/linux/mod_devicetable.h	Mon May 26 19:20:44 2003
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
+#define CCW_DEVICE_ID_MATCH_CU_TYPE		0x01
+#define CCW_DEVICE_ID_MATCH_CU_MODEL		0x02
+#define CCW_DEVICE_ID_MATCH_DEVICE_TYPE		0x04
+#define CCW_DEVICE_ID_MATCH_DEVICE_MODEL	0x08
+
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff -urN linux-2.5/scripts/file2alias.c linux-2.5-s390/scripts/file2alias.c
--- linux-2.5/scripts/file2alias.c	Mon May  5 01:53:14 2003
+++ linux-2.5-s390/scripts/file2alias.c	Mon May 26 19:20:44 2003
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
