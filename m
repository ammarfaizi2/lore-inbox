Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVGaUDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVGaUDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVGaUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:03:46 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:31492 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261969AbVGaUCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:02:25 -0400
Date: Sun, 31 Jul 2005 22:02:24 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (10/11) hwmon vs i2c, second round
Message-Id: <20050731220224.23136906.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see very little reason why vid_from_reg and vid_to_reg are inlined.
The former is not exactly short, and they are never called in speed
critical areas. Uninlining them should cause little performance loss
if any, and saves a signficant space and compilation time as well.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/hwmon-vid.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon-vid.h |   90 ++---------------------------------------
 2 files changed, 104 insertions(+), 85 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/hwmon/hwmon-vid.c	2005-07-31 17:00:12.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/hwmon-vid.c	2005-07-31 20:55:47.000000000 +0200
@@ -3,6 +3,10 @@
 
     Copyright (c) 2004 Rudolf Marek <r.marek@sh.cvut.cz>
 
+    Partly imported from i2c-vid.h of the lm_sensors project
+    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+    With assistance from Trent Piepho <xyzzy@speakeasy.org>
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -23,6 +27,99 @@
 #include <linux/kernel.h>
 #include <linux/hwmon-vid.h>
 
+/*
+    Common code for decoding VID pins.
+
+    References:
+
+    For VRM 8.4 to 9.1, "VRM x.y DC-DC Converter Design Guidelines",
+    available at http://developer.intel.com/.
+
+    For VRD 10.0 and up, "VRD x.y Design Guide",
+    available at http://developer.intel.com/.
+
+    AMD Opteron processors don't follow the Intel specifications.
+    I'm going to "make up" 2.4 as the spec number for the Opterons.
+    No good reason just a mnemonic for the 24x Opteron processor
+    series.
+
+    Opteron VID encoding is:
+       00000  =  1.550 V
+       00001  =  1.525 V
+        . . . .
+       11110  =  0.800 V
+       11111  =  0.000 V (off)
+*/
+
+/* vrm is the VRM/VRD document version multiplied by 10.
+   val is the 4-, 5- or 6-bit VID code.
+   Returned value is in mV to avoid floating point in the kernel. */
+int vid_from_reg(int val, int vrm)
+{
+	int vid;
+
+	switch(vrm) {
+
+	case  0:
+		return 0;
+
+	case 100:               /* VRD 10.0 */
+		if((val & 0x1f) == 0x1f)
+			return 0;
+		if((val & 0x1f) <= 0x09 || val == 0x0a)
+			vid = 10875 - (val & 0x1f) * 250;
+		else
+			vid = 18625 - (val & 0x1f) * 250;
+		if(val & 0x20)
+			vid -= 125;
+		vid /= 10;      /* only return 3 dec. places for now */
+		return vid;
+
+	case 24:                /* Opteron processor */
+		return(val == 0x1f ? 0 : 1550 - val * 25);
+
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return(val == 0x1f ? 0 :
+		                       1850 - val * 25);
+
+	case 85:		/* VRM 8.5 */
+		return((val & 0x10  ? 25 : 0) +
+		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
+		       ((val & 0x0f) * 50));
+
+	case 84:		/* VRM 8.4 */
+		val &= 0x0f;
+				/* fall through */
+	default:		/* VRM 8.2 */
+		return(val == 0x1f ? 0 :
+		       val & 0x10  ? 5100 - (val) * 100 :
+		                     2050 - (val) * 50);
+	}
+}
+
+/* vrm is the VRM/VRD document version multiplied by 10.
+   val is in mV to avoid floating point in the kernel.
+   Returned value is the 4-, 5- or 6-bit VID code.
+   Note that only VRM 9.x is supported for now. */
+int vid_to_reg(int val, int vrm)
+{
+	switch (vrm) {
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return ((val >= 1100) && (val <= 1850) ?
+			((18499 - val * 10) / 25 + 5) / 10 : -1);
+	default:
+		return -1;
+	}
+}
+
+
+/*
+    After this point is the code to automatically determine which
+    VRM/VRD specification should be used depending on the CPU.
+*/
+
 struct vrm_model {
 	u8 vendor;
 	u8 eff_family;
@@ -96,6 +193,8 @@
 }
 #endif
 
+EXPORT_SYMBOL(vid_from_reg);
+EXPORT_SYMBOL(vid_to_reg);
 EXPORT_SYMBOL(vid_which_vrm);
 
 MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
--- linux-2.6.13-rc4.orig/include/linux/hwmon-vid.h	2005-07-31 17:00:35.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/hwmon-vid.h	2005-07-31 20:55:47.000000000 +0200
@@ -20,91 +20,11 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/*
-    This file contains common code for decoding VID pins.
-    This file is #included in various chip drivers in this directory.
-    As the user is unlikely to load more than one driver which
-    includes this code we don't worry about the wasted space.
-    Reference: VRM x.y DC-DC Converter Design Guidelines,
-    available at http://developer.intel.com
-*/
-
-/*
-    AMD Opteron processors don't follow the Intel VRM spec.
-    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
-    No good reason just a mnemonic for the 24x Opteron processor
-    series
-
-    Opteron VID encoding is:
-
-       00000  =  1.550 V
-       00001  =  1.525 V
-        . . . .
-       11110  =  0.800 V
-       11111  =  0.000 V (off)
- */
-
-/*
-    Legal val values 0x00 - 0x1f; except for VRD 10.0, 0x00 - 0x3f.
-    vrm is the Intel VRM document version.
-    Note: vrm version is scaled by 10 and the return value is scaled by 1000
-    to avoid floating point in the kernel.
-*/
+#ifndef _LINUX_HWMON_VID_H
+#define _LINUX_HWMON_VID_H
 
+int vid_from_reg(int val, int vrm);
+int vid_to_reg(int val, int vrm);
 int vid_which_vrm(void);
 
-static inline int vid_from_reg(int val, int vrm)
-{
-	int vid;
-
-	switch(vrm) {
-
-	case  0:
-		return 0;
-
-	case 100:               /* VRD 10.0 */
-		if((val & 0x1f) == 0x1f)
-			return 0;
-		if((val & 0x1f) <= 0x09 || val == 0x0a)
-			vid = 10875 - (val & 0x1f) * 250;
-		else
-			vid = 18625 - (val & 0x1f) * 250;
-		if(val & 0x20)
-			vid -= 125;
-		vid /= 10;      /* only return 3 dec. places for now */
-		return vid;
-
-	case 24:                /* Opteron processor */
-		return(val == 0x1f ? 0 : 1550 - val * 25);
-
-	case 91:		/* VRM 9.1 */
-	case 90:		/* VRM 9.0 */
-		return(val == 0x1f ? 0 :
-		                       1850 - val * 25);
-
-	case 85:		/* VRM 8.5 */
-		return((val & 0x10  ? 25 : 0) +
-		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
-		       ((val & 0x0f) * 50));
-
-	case 84:		/* VRM 8.4 */
-		val &= 0x0f;
-				/* fall through */
-	default:		/* VRM 8.2 */
-		return(val == 0x1f ? 0 :
-		       val & 0x10  ? 5100 - (val) * 100 :
-		                     2050 - (val) * 50);
-	}
-}
-
-static inline int vid_to_reg(int val, int vrm)
-{
-	switch (vrm) {
-	case 91:		/* VRM 9.1 */
-	case 90:		/* VRM 9.0 */
-		return ((val >= 1100) && (val <= 1850) ?
-			((18499 - val * 10) / 25 + 5) / 10 : -1);
-	default:
-		return -1;
-	}
-}
+#endif /* _LINUX_HWMON_VID_H */


-- 
Jean Delvare
