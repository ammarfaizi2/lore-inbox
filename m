Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVBJPwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVBJPwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVBJPwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:52:10 -0500
Received: from sd291.sivit.org ([194.146.225.122]:31707 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262149AbVBJPqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:46:15 -0500
Date: Thu, 10 Feb 2005 16:47:52 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 5/5] sonypi: add fan and temperature status/control
Message-ID: <20050210154752.GJ3493@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

1. FAN Status/Control: you can now get the fan status (running or not) and
   also set the fan speed (for <5 seconds only). The problem is that there
   is an auto regulator that kicks in within about 5 seconds after that to
   restart the fan if it is above a threshold temperature (39 Degree C in
   my Vaio). It is useful just to get the fan status (primarily). It also
   appears that you can change the speed by increasing the values (much
   like the LCD control) - there are effectively only about 6 speeds (it
   seems - not sure, but from what I've played with on my Vaio).

2. Temperature: you can get the current temperature (same as reported by
   ACPI). This is primarily useful for APM users (since ACPI already gives
   this). I have used this to detect when the fan comes on in my Vaio (39
   Degree C).

From: Narayanan R S <nars@kadamba.org>
Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 drivers/char/sonypi.c  |   32 ++++++++++++++++++++++++++++++++
 include/linux/sonypi.h |   11 ++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

===================================================================

Index: include/linux/sonypi.h
===================================================================
--- a/include/linux/sonypi.h	(revision 26830)
+++ b/include/linux/sonypi.h	(revision 26831)
@@ -1,8 +1,10 @@
 /*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2005 Stelian Pop <stelian@popies.net>
  *
+ * Copyright (C) 2005 Narayanan R S <nars@kadamba.org>
+
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
@@ -118,6 +120,13 @@
 #define SONYPI_IOCGBLUE		_IOR('v', 8, __u8)
 #define SONYPI_IOCSBLUE		_IOW('v', 9, __u8)
 
+/* get/set fan state on/off */
+#define SONYPI_IOCGFAN		_IOR('v', 10, __u8)
+#define SONYPI_IOCSFAN		_IOW('v', 11, __u8)
+
+/* get temperature (C) */
+#define SONYPI_IOCGTEMP		_IOR('v', 12, __u8)
+
 #ifdef __KERNEL__
 
 /* used only for communication between v4l and sonypi */
Index: drivers/char/sonypi.c
===================================================================
--- a/drivers/char/sonypi.c	(revision 26830)
+++ b/drivers/char/sonypi.c	(revision 26831)
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2001-2005 Stelian Pop <stelian@popies.net>
  *
+ * Copyright (C) 2005 Narayanan R S <nars@kadamba.org>
+ *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
@@ -126,6 +128,10 @@ MODULE_PARM_DESC(useinput,
 #define SONYPI_BAT2_MAXTK	0xb8
 #define SONYPI_BAT2_FULL	0xba
 
+/* FAN0 information (reverse engineered from ACPI tables) */
+#define SONYPI_FAN0_STATUS	0x93
+#define SONYPI_TEMP_STATUS	0xC1
+
 /* ioports used for brightness and type2 events */
 #define SONYPI_DATA_IOPORT	0x62
 #define SONYPI_CST_IOPORT	0x66
@@ -1009,6 +1015,32 @@ static int sonypi_misc_ioctl(struct inod
 		}
 		sonypi_setbluetoothpower(val8);
 		break;
+	/* FAN Controls */
+	case SONYPI_IOCGFAN:
+		if (sonypi_ec_read(SONYPI_FAN0_STATUS, &val8)) {
+			ret = -EIO;
+			break;
+		}
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
+			ret = -EFAULT;
+		break;
+	case SONYPI_IOCSFAN:
+		if (copy_from_user(&val8, (u8 *)arg, sizeof(val8))) {
+			ret = -EFAULT;
+			break;
+		}
+		if (sonypi_ec_write(SONYPI_FAN0_STATUS, val8))
+			ret = -EIO;
+		break;
+	/* GET Temperature (useful under APM) */
+	case SONYPI_IOCGTEMP:
+		if (sonypi_ec_read(SONYPI_TEMP_STATUS, &val8)) {
+			ret = -EIO;
+			break;
+		}
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
+			ret = -EFAULT;
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
Stelian Pop <stelian@popies.net>
