Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVHAUva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVHAUva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVHAUvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:51:24 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:50181 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261255AbVHAUuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:50:06 -0400
Date: Mon, 1 Aug 2005 22:50:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2.6] (10/11, revised) hwmon vs i2c, second round
Message-Id: <20050801225008.67594fea.khali@linux-fr.org>
In-Reply-To: <20050731220224.23136906.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
	<20050731220224.23136906.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see very little reason why vid_from_reg is inlined. It is not
exactly short, its parameters are seldom known in advance, and it is
never called in speed critical areas. Uninlining it should cause
little performance loss if any, and saves a signficant space as well
as compilation time.

As suggested by Alexey Dobriyan, I am leaving vid_to_reg inline for now,
as it is short and has a single user so far.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/hwmon-vid.c |   82 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon-vid.h |   83 ++++------------------------------------------
 2 files changed, 91 insertions(+), 74 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/hwmon/hwmon-vid.c	2005-07-31 21:13:11.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/hwmon-vid.c	2005-08-01 19:55:25.000000000 +0200
@@ -3,6 +3,10 @@
 
     Copyright (c) 2004 Rudolf Marek <r.marek@sh.cvut.cz>
 
+    Partly imported from i2c-vid.h of the lm_sensors project
+    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+    With assistance from Trent Piepho <xyzzy@speakeasy.org>
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -23,6 +27,83 @@
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
+
+/*
+    After this point is the code to automatically determine which
+    VRM/VRD specification should be used depending on the CPU.
+*/
+
 struct vrm_model {
 	u8 vendor;
 	u8 eff_family;
@@ -96,6 +177,7 @@
 }
 #endif
 
+EXPORT_SYMBOL(vid_from_reg);
 EXPORT_SYMBOL(vid_which_vrm);
 
 MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
--- linux-2.6.13-rc4.orig/include/linux/hwmon-vid.h	2005-07-31 21:13:23.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/hwmon-vid.h	2005-08-01 19:56:08.000000000 +0200
@@ -20,83 +20,16 @@
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
+/* vrm is the VRM/VRD document version multiplied by 10.
+   val is in mV to avoid floating point in the kernel.
+   Returned value is the 4-, 5- or 6-bit VID code.
+   Note that only VRM 9.x is supported for now. */
 static inline int vid_to_reg(int val, int vrm)
 {
 	switch (vrm) {
@@ -108,3 +41,5 @@
 		return -1;
 	}
 }
+
+#endif /* _LINUX_HWMON_VID_H */


-- 
Jean Delvare
