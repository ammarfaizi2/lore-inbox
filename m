Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVIVRtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVIVRtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVIVRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:49:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38039 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750719AbVIVRtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:49:32 -0400
Subject: [patch] hdaps: small update.
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>, Mr Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 22 Sep 2005 13:50:10 -0400
Message-Id: <1127411411.5692.39.camel@molly>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr Morton & Greg,

Attached patch is a small hdaps update:

	- Handle dmi_system_check() elegantly, now that my bugfix
	  is upstream.
	- Add support for the X41 and R52.
	- Cleanup some comments do I do not have to keep updating
	  them with each new whitelisted laptop.

Diffed and tested against 2.6.14-rc2-git1.

	Robert Love

--

Small hdaps update.

Signed-off-by: Robert Love <rml@novell.com>

 drivers/hwmon/Kconfig |    9 ++++-----
 drivers/hwmon/hdaps.c |   21 +++++++++------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff -urN linux-2.6.14-rc2-git1/drivers/hwmon/hdaps.c linux/drivers/hwmon/hdaps.c
--- linux-2.6.14-rc2-git1/drivers/hwmon/hdaps.c	2005-09-22 10:48:51.000000000 -0400
+++ linux/drivers/hwmon/hdaps.c	2005-09-22 13:42:44.000000000 -0400
@@ -4,9 +4,9 @@
  * Copyright (C) 2005 Robert Love <rml@novell.com>
  * Copyright (C) 2005 Jesper Juhl <jesper.juhl@gmail.com>
  *
- * The HardDisk Active Protection System (hdaps) is present in the IBM ThinkPad
- * T41, T42, T43, R50, R50p, R51, and X40, at least.  It provides a basic
- * two-axis accelerometer and other data, such as the device's temperature.
+ * The HardDisk Active Protection System (hdaps) is present in IBM ThinkPads
+ * starting with the R40, T41, and X40.  It provides a basic two-axis
+ * accelerometer and other data, such as the device's temperature.
  *
  * This driver is based on the document by Mark A. Smith available at
  * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html and a lot of trial
@@ -487,24 +487,19 @@
 
 /* Module stuff */
 
-/*
- * XXX: We should be able to return nonzero and halt the detection process.
- * But there is a bug in dmi_check_system() where a nonzero return from the
- * first match will result in a return of failure from dmi_check_system().
- * I fixed this; the patch is 2.6-git.  Once in a released tree, we can make
- * hdaps_dmi_match_invert() return hdaps_dmi_match(), which in turn returns 1.
- */
+/* hdaps_dmi_match - found a match.  return one, short-circuiting the hunt. */
 static int hdaps_dmi_match(struct dmi_system_id *id)
 {
 	printk(KERN_INFO "hdaps: %s detected.\n", id->ident);
-	return 0;
+	return 1;
 }
 
+/* hdaps_dmi_match_invert - found an inverted match. */
 static int hdaps_dmi_match_invert(struct dmi_system_id *id)
 {
 	hdaps_invert = 1;
 	printk(KERN_INFO "hdaps: inverting axis readings.\n");
-	return 0;
+	return hdaps_dmi_match(id);
 }
 
 #define HDAPS_DMI_MATCH_NORMAL(model)	{		\
@@ -534,6 +529,7 @@
 		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad R52"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad T41p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T41"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad T42p"),
@@ -541,6 +537,7 @@
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T43"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41 Tablet"),
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
 		{ .ident = NULL }
 	};
 
diff -urN linux-2.6.14-rc2-git1/drivers/hwmon/Kconfig linux/drivers/hwmon/Kconfig
--- linux-2.6.14-rc2-git1/drivers/hwmon/Kconfig	2005-09-22 10:48:51.000000000 -0400
+++ linux/drivers/hwmon/Kconfig	2005-09-22 10:55:26.000000000 -0400
@@ -418,12 +418,11 @@
 	help
 	  This driver provides support for the IBM Hard Drive Active Protection
 	  System (hdaps), which provides an accelerometer and other misc. data.
-	  Supported laptops include the IBM ThinkPad T41, T42, T43, and R51.
-	  The accelerometer data is readable via sysfs.
+	  ThinkPads starting with the R50, T41, and X40 are supported.  The
+	  accelerometer data is readable via sysfs.
 
-	  This driver also provides an input class device, allowing the
-	  laptop to act as a pinball machine-esque mouse.  This is off by
-	  default but enabled via sysfs or the module parameter "mousedev".
+	  This driver also provides an absolute input class device, allowing
+	  the laptop to act as a pinball machine-esque joystick.
 
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.


