Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUCPOrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUCPOov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:44:51 -0500
Received: from styx.suse.cz ([82.208.2.94]:28289 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261898AbUCPOTe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:34 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446776407@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 2/44] Add ioctl to hiddev to set multiple usages at once
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <10794467762838@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.2, 2004-01-26 13:16:54+01:00, jamesl@appliedminds.com
  input: Add a new ioctl to hiddev, which allows multiple usages to
         be set in a single request. Also fixes sizes of fields
         in hiddev structs to use _uXX types.


 drivers/usb/input/hiddev.c |   79 +++++++++++++++++++++++++++++++--------------
 include/linux/hiddev.h     |   74 ++++++++++++++++++++++++------------------
 2 files changed, 98 insertions(+), 55 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Tue Mar 16 13:20:12 2004
+++ b/drivers/usb/input/hiddev.c	Tue Mar 16 13:20:12 2004
@@ -403,7 +403,8 @@
 	struct hiddev_collection_info cinfo;
 	struct hiddev_report_info rinfo;
 	struct hiddev_field_info finfo;
-	struct hiddev_usage_ref uref;
+	struct hiddev_usage_ref_multi uref_multi;
+	struct hiddev_usage_ref *uref = &uref_multi.uref;
 	struct hiddev_devinfo dinfo;
 	struct hid_report *report;
 	struct hid_field *field;
@@ -575,68 +576,98 @@
 		return 0;
 
 	case HIDIOCGUCODE:
-		if (copy_from_user(&uref, (void *) arg, sizeof(uref)))
+		if (copy_from_user(uref, (void *) arg, sizeof(*uref)))
 			return -EFAULT;
 
-		rinfo.report_type = uref.report_type;
-		rinfo.report_id = uref.report_id;
+		rinfo.report_type = uref->report_type;
+		rinfo.report_id = uref->report_id;
 		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
 			return -EINVAL;
 
-		if (uref.field_index >= report->maxfield)
+		if (uref->field_index >= report->maxfield)
 			return -EINVAL;
 
-		field = report->field[uref.field_index];
-		if (uref.usage_index >= field->maxusage)
+		field = report->field[uref->field_index];
+		if (uref->usage_index >= field->maxusage)
 			return -EINVAL;
 
-		uref.usage_code = field->usage[uref.usage_index].hid;
+		uref->usage_code = field->usage[uref->usage_index].hid;
 
-		if (copy_to_user((void *) arg, &uref, sizeof(uref)))
+		if (copy_to_user((void *) arg, uref, sizeof(*uref)))
 			return -EFAULT;
 
 		return 0;
 
 	case HIDIOCGUSAGE:
 	case HIDIOCSUSAGE:
+	case HIDIOCGUSAGES:
+	case HIDIOCSUSAGES:
 	case HIDIOCGCOLLECTIONINDEX:
-		if (copy_from_user(&uref, (void *) arg, sizeof(uref)))
-			return -EFAULT;
+		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
+			if (copy_from_user(&uref_multi, (void *) arg, 
+					   sizeof(uref_multi)))
+				return -EFAULT;
+		} else {
+			if (copy_from_user(uref, (void *) arg, sizeof(*uref)))
+				return -EFAULT;
+		}
 
-		if (cmd != HIDIOCGUSAGE && uref.report_type == HID_REPORT_TYPE_INPUT)
-				return -EINVAL;
+		if (cmd != HIDIOCGUSAGE && 
+		    cmd != HIDIOCGUSAGES &&
+		    uref->report_type == HID_REPORT_TYPE_INPUT)
+			return -EINVAL;
 
-		if (uref.report_id == HID_REPORT_ID_UNKNOWN) {
-			field = hiddev_lookup_usage(hid, &uref);
+		if (uref->report_id == HID_REPORT_ID_UNKNOWN) {
+			field = hiddev_lookup_usage(hid, uref);
 			if (field == NULL)
 				return -EINVAL;
 		} else {
-			rinfo.report_type = uref.report_type;
-			rinfo.report_id = uref.report_id;
+			rinfo.report_type = uref->report_type;
+			rinfo.report_id = uref->report_id;
 			if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
 				return -EINVAL;
 
-			if (uref.field_index >= report->maxfield)
+			if (uref->field_index >= report->maxfield)
 				return -EINVAL;
 
-			field = report->field[uref.field_index];
-			if (uref.usage_index >= field->maxusage)
+			field = report->field[uref->field_index];
+			if (uref->usage_index >= field->maxusage)
 				return -EINVAL;
+
+			if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
+				if (uref_multi.num_values >= HID_MAX_USAGES || 
+				    uref->usage_index >= field->maxusage || 
+				   (uref->usage_index + uref_multi.num_values) >= field->maxusage)
+					return -EINVAL;
+			}
 		}
 
 		switch (cmd) {
 			case HIDIOCGUSAGE:
-				uref.value = field->value[uref.usage_index];
-				if (copy_to_user((void *) arg, &uref, sizeof(uref)))
+				uref->value = field->value[uref->usage_index];
+				if (copy_to_user((void *) arg, uref, sizeof(*uref)))
 					return -EFAULT;
 				return 0;
 
 			case HIDIOCSUSAGE:
-				field->value[uref.usage_index] = uref.value;
+				field->value[uref->usage_index] = uref->value;
 				return 0;
 
 			case HIDIOCGCOLLECTIONINDEX:
-				return field->usage[uref.usage_index].collection_index;
+				return field->usage[uref->usage_index].collection_index;
+			case HIDIOCGUSAGES:
+				for (i = 0; i < uref_multi.num_values; i++)
+					uref_multi.values[i] = 
+					    field->value[uref->usage_index + i];
+				if (copy_to_user((void *) arg, &uref_multi, 
+						 sizeof(uref_multi)))
+					return -EFAULT;
+				return 0;
+			case HIDIOCSUSAGES:
+				for (i = 0; i < uref_multi.num_values; i++)
+					field->value[uref->usage_index + i] = 
+				  	    uref_multi.values[i];
+				return 0;
 		}
 
 		return 0;
diff -Nru a/include/linux/hiddev.h b/include/linux/hiddev.h
--- a/include/linux/hiddev.h	Tue Mar 16 13:20:12 2004
+++ b/include/linux/hiddev.h	Tue Mar 16 13:20:12 2004
@@ -39,33 +39,33 @@
 };
 
 struct hiddev_devinfo {
-	unsigned int bustype;
-	unsigned int busnum;
-	unsigned int devnum;
-	unsigned int ifnum;
-	short vendor;
-	short product;
-	short version;
-	unsigned num_applications;
+	__u32 bustype;
+	__u32 busnum;
+	__u32 devnum;
+	__u32 ifnum;
+	__s16 vendor;
+	__s16 product;
+	__s16 version;
+	__u32 num_applications;
 };
 
 struct hiddev_collection_info {
-	unsigned index;
-	unsigned type;
-	unsigned usage;
-	unsigned level;
+	__u32 index;
+	__u32 type;
+	__u32 usage;
+	__u32 level;
 };
 
 #define HID_STRING_SIZE 256
 struct hiddev_string_descriptor {
-	int index;
+	__s32 index;
 	char value[HID_STRING_SIZE];
 };
 
 struct hiddev_report_info {
-	unsigned report_type;
-	unsigned report_id;
-	unsigned num_fields;
+	__u32 report_type;
+	__u32 report_id;
+	__u32 num_fields;
 };
 
 /* To do a GUSAGE/SUSAGE, fill in at least usage_code,  report_type and 
@@ -88,20 +88,20 @@
 #define HID_REPORT_TYPE_MAX     3
 
 struct hiddev_field_info {
-	unsigned report_type;
-	unsigned report_id;
-	unsigned field_index;
-	unsigned maxusage;
-	unsigned flags;
-	unsigned physical;		/* physical usage for this field */
-	unsigned logical;		/* logical usage for this field */
-	unsigned application;		/* application usage for this field */
+	__u32 report_type;
+	__u32 report_id;
+	__u32 field_index;
+	__u32 maxusage;
+	__u32 flags;
+	__u32 physical;		/* physical usage for this field */
+	__u32 logical;		/* logical usage for this field */
+	__u32 application;		/* application usage for this field */
 	__s32 logical_minimum;
 	__s32 logical_maximum;
 	__s32 physical_minimum;
 	__s32 physical_maximum;
-	unsigned unit_exponent;
-	unsigned unit;
+	__u32 unit_exponent;
+	__u32 unit;
 };
 
 /* Fill in report_type, report_id and field_index to get the information on a
@@ -118,14 +118,22 @@
 #define HID_FIELD_BUFFERED_BYTE		0x100
 
 struct hiddev_usage_ref {
-	unsigned report_type;
-	unsigned report_id;
-	unsigned field_index;
-	unsigned usage_index;
-	unsigned usage_code;
+	__u32 report_type;
+	__u32 report_id;
+	__u32 field_index;
+	__u32 usage_index;
+	__u32 usage_code;
 	__s32 value;
 };
 
+/* hiddev_usage_ref_multi is used for sending multiple bytes to a control.
+ * It really manifests itself as setting the value of consecutive usages */
+struct hiddev_usage_ref_multi {
+	struct hiddev_usage_ref uref;
+	__u32 num_values;
+	__s32 values[HID_MAX_USAGES];
+};
+
 /* FIELD_INDEX_NONE is returned in read() data from the kernel when flags
  * is set to (HIDDEV_FLAG_UREF | HIDDEV_FLAG_REPORT) and a new report has
  * been sent by the device 
@@ -160,6 +168,10 @@
 #define HIDIOCGCOLLECTIONINDEX	_IOW('H', 0x10, struct hiddev_usage_ref)
 #define HIDIOCGCOLLECTIONINFO	_IOWR('H', 0x11, struct hiddev_collection_info)
 #define HIDIOCGPHYS(len)	_IOC(_IOC_READ, 'H', 0x12, len)
+
+/* For writing/reading to multiple/consecutive usages */
+#define HIDIOCGUSAGES		_IOWR('H', 0x13, struct hiddev_usage_ref_multi)
+#define HIDIOCSUSAGES		_IOW('H', 0x14, struct hiddev_usage_ref_multi)
 
 /* 
  * Flags to be used in HIDIOCSFLAG

