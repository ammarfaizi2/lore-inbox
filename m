Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267609AbUG2O4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267609AbUG2O4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267627AbUG2OyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:54:24 -0400
Received: from styx.suse.cz ([82.119.242.94]:59029 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264750AbUG2OIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:06 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 1/47] Add 64-bit compatible ioctls for hiddev.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <20040729140728.GA18817@ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101941048@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1612.1.20, 2004-05-19 00:13:58+02:00, akropel1@rochester.rr.com
  input: Add 64-bit compatible ioctls for hiddev.


 drivers/usb/input/hiddev.c   |    2 +-
 fs/compat_ioctl.c            |    2 ++
 include/linux/compat_ioctl.h |   17 +++++++++++++++++
 include/linux/hiddev.h       |    8 +++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Thu Jul 29 14:42:28 2004
+++ b/drivers/usb/input/hiddev.c	Thu Jul 29 14:42:28 2004
@@ -642,7 +642,7 @@
 				goto inval;
 
 			if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
-				if (uref_multi->num_values >= HID_MAX_USAGES || 
+				if (uref_multi->num_values >= HID_MAX_MULTI_USAGES || 
 				    uref->usage_index >= field->maxusage || 
 				   (uref->usage_index + uref_multi->num_values) >= field->maxusage)
 					goto inval;
diff -Nru a/fs/compat_ioctl.c b/fs/compat_ioctl.c
--- a/fs/compat_ioctl.c	Thu Jul 29 14:42:28 2004
+++ b/fs/compat_ioctl.c	Thu Jul 29 14:42:28 2004
@@ -114,6 +114,8 @@
 #include <linux/filter.h>
 #include <linux/msdos_fs.h>
 
+#include <linux/hiddev.h>
+
 #undef INCLUDES
 #endif
 
diff -Nru a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
--- a/include/linux/compat_ioctl.h	Thu Jul 29 14:42:28 2004
+++ b/include/linux/compat_ioctl.h	Thu Jul 29 14:42:28 2004
@@ -720,3 +720,20 @@
 COMPATIBLE_IOCTL(SIOCGIWRETRY)
 COMPATIBLE_IOCTL(SIOCSIWPOWER)
 COMPATIBLE_IOCTL(SIOCGIWPOWER)
+/* hiddev */
+COMPATIBLE_IOCTL(HIDIOCGVERSION)
+COMPATIBLE_IOCTL(HIDIOCAPPLICATION)
+COMPATIBLE_IOCTL(HIDIOCGDEVINFO)
+COMPATIBLE_IOCTL(HIDIOCGSTRING)
+COMPATIBLE_IOCTL(HIDIOCINITREPORT)
+COMPATIBLE_IOCTL(HIDIOCGREPORT)
+COMPATIBLE_IOCTL(HIDIOCSREPORT)
+COMPATIBLE_IOCTL(HIDIOCGREPORTINFO)
+COMPATIBLE_IOCTL(HIDIOCGFIELDINFO)
+COMPATIBLE_IOCTL(HIDIOCGUSAGE)
+COMPATIBLE_IOCTL(HIDIOCSUSAGE)
+COMPATIBLE_IOCTL(HIDIOCGUCODE)
+COMPATIBLE_IOCTL(HIDIOCGFLAG)
+COMPATIBLE_IOCTL(HIDIOCSFLAG)
+COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
+COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
diff -Nru a/include/linux/hiddev.h b/include/linux/hiddev.h
--- a/include/linux/hiddev.h	Thu Jul 29 14:42:28 2004
+++ b/include/linux/hiddev.h	Thu Jul 29 14:42:28 2004
@@ -128,10 +128,11 @@
 
 /* hiddev_usage_ref_multi is used for sending multiple bytes to a control.
  * It really manifests itself as setting the value of consecutive usages */
+#define HID_MAX_MULTI_USAGES 1024
 struct hiddev_usage_ref_multi {
 	struct hiddev_usage_ref uref;
 	__u32 num_values;
-	__s32 values[HID_MAX_USAGES];
+	__s32 values[HID_MAX_MULTI_USAGES];
 };
 
 /* FIELD_INDEX_NONE is returned in read() data from the kernel when flags
@@ -213,6 +214,11 @@
  */
 
 #ifdef CONFIG_USB_HIDDEV
+struct hid_device;
+struct hid_usage;
+struct hid_field;
+struct hid_report;
+
 int hiddev_connect(struct hid_device *);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,

