Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbUDNJK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbUDNJK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:10:27 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:37098 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263997AbUDNJJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:09:48 -0400
Date: Wed, 14 Apr 2004 11:09:44 +0200
From: Romain Lievin <lkml@lievin.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: [PATCH] tiglusb: fixes bad argument with usb_clear_halt
Message-ID: <20040414090944.GA23028@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the first set of 2 patches (2.4 & 2.6) fixes a mis-use of usb_clear_halt when clearing STALL condition: previous releases of this driver passes as second argument the endpoint instead of the pipe ! Result: all requests failed.

Other modifications are clean-up and better checking of the timeout value (ioctl).

Driver is now working fine !

The second set updates documentation.

Please apply, Romain.
==========================[ src24 ]=============================
diff -Naur linux-2.4.25.orig/drivers/usb/tiglusb.c linux-2.4.25/drivers/usb/tiglusb.c
--- linux-2.4.25.orig/drivers/usb/tiglusb.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.25/drivers/usb/tiglusb.c	2004-04-14 09:53:52.000000000 +0200
@@ -3,7 +3,7 @@
  * tiglusb -- Texas Instruments' USB GraphLink (aka SilverLink) driver.
  * Target: Texas Instruments graphing calculators (http://lpg.ticalc.org).
  *
- * Copyright (C) 2001-2002:
+ * Copyright (C) 2001-2004:
  *   Romain Lievin <roms@lpg.ticalc.org>
  *   Julien BLACHE <jb@technologeek.org>
  * under the terms of the GNU General Public License.
@@ -14,11 +14,14 @@
  * and the website at:  http://lpg.ticalc.org/prj_usb/
  * for more info.
  *
+ * History:
  *   1.0x, Romain & Julien: initial submit.
  *   1.03, Greg Kroah: modifications.
  *   1.04, Julien: clean-up & fixes; Romain: 2.4 backport.
  *   1.05, Randy Dunlap: bug fix with the timeout parameter (divide-by-zero).
  *   1.06, Romain: synched with 2.5, version/firmware changed (confusing).
+ *   1.07, Romain: fixed bad use of usb_clear_halt (invalid argument);
+ *          timeout argument checked in ioctl + clean-up.
  */
 
 #include <linux/module.h>
@@ -38,8 +41,8 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "1.06"
-#define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org> & Julien Blache <jb@jblache.org>"
+#define DRIVER_VERSION "1.07"
+#define DRIVER_AUTHOR  "Romain Lievin <roms@tilp.info> & Julien Blache <jb@jblache.org>"
 #define DRIVER_DESC    "TI-GRAPH LINK USB (aka SilverLink) driver"
 #define DRIVER_LICENSE "GPL"
 
@@ -75,13 +78,13 @@
 	unsigned int pipe;
 
 	pipe = usb_sndbulkpipe (dev, 1);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
+	if (usb_clear_halt (dev, pipe)) {
 		err ("clear_pipe (r), request failed");
 		return -1;
 	}
 
 	pipe = usb_sndbulkpipe (dev, 2);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
+	if (usb_clear_halt (dev, pipe)) {
 		err ("clear_pipe (w), request failed");
 		return -1;
 	}
@@ -181,15 +184,14 @@
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
 			       &bytes_read, HZ * 10 / timeout);
 	if (result == -ETIMEDOUT) {	/* NAK */
-		ret = result;
-		if (!bytes_read) {
+		if (!bytes_read)
 			dbg ("quirk !");
-		}
 		warn ("tiglusb_read, NAK received.");
+		ret = result;
 		goto out;
 	} else if (result == -EPIPE) {	/* STALL -- shouldn't happen */
 		warn ("clear_halt request to remove STALL condition.");
-		if (usb_clear_halt (s->dev, usb_pipeendpoint (pipe)))
+		if (usb_clear_halt (s->dev, pipe))
 			err ("clear_halt, request failed");
 		clear_device (s->dev);
 		ret = result;
@@ -244,7 +246,7 @@
 		goto out;
 	} else if (result == -EPIPE) {	/* STALL -- shouldn't happen */
 		warn ("clear_halt request to remove STALL condition.");
-		if (usb_clear_halt (s->dev, usb_pipeendpoint (pipe)))
+		if (usb_clear_halt (s->dev, pipe))
 			err ("clear_halt, request failed");
 		clear_device (s->dev);
 		ret = result;
@@ -284,15 +286,16 @@
 
 	switch (cmd) {
 	case IOCTL_TIUSB_TIMEOUT:
-		timeout = arg;	// timeout value in tenth of seconds
+		if (arg > 0)
+			timeout = (int)arg;
+		else
+			ret = -EINVAL;
 		break;
 	case IOCTL_TIUSB_RESET_DEVICE:
-		dbg ("IOCTL_TIGLUSB_RESET_DEVICE");
 		if (clear_device (s->dev))
 			ret = -EIO;
 		break;
 	case IOCTL_TIUSB_RESET_PIPES:
-		dbg ("IOCTL_TIGLUSB_RESET_PIPES");
 		if (clear_pipes (s->dev))
 			ret = -EIO;
 		break;
@@ -430,7 +433,7 @@
 
 #ifndef MODULE
 /*
- * You can use 'tiusb=timeout'
+ * You can use 'tiusb=timeout' to set timeout.
  */
 static int __init
 tiglusb_setup (char *str)
@@ -440,10 +443,11 @@
 	str = get_options (str, ARRAY_SIZE (ints), ints);
 
 	if (ints[0] > 0) {
-		timeout = ints[1];
+		if (ints[1] > 0)
+			timeout = ints[1];
+		else
+			info ("tiglusb: wrong timeout value (0), using default value.");
 	}
-	if (!timeout)
-		timeout = TIMAXTIME;
 
 	return 1;
 }
@@ -466,8 +470,6 @@
 		init_waitqueue_head (&s->wait);
 		init_waitqueue_head (&s->remove_ok);
 	}
-	if (timeout <= 0)
-               timeout = TIMAXTIME;
 
 	/* register device */
 	if (register_chrdev (TIUSB_MAJOR, "tiglusb", &tiglusb_fops)) {
@@ -487,12 +489,6 @@
 
 	info (DRIVER_DESC ", version " DRIVER_VERSION);
 
-       if (timeout <= 0)
-               timeout = TIMAXTIME;
-
-	if (!timeout)
-		timeout = TIMAXTIME;
-
 	return 0;
 }
 

==========================[ src26 ]=============================
diff -Naur linux-2.6.5.orig/drivers/usb/misc/tiglusb.c linux-2.6.5/drivers/usb/misc/tiglusb.c
--- linux-2.6.5.orig/drivers/usb/misc/tiglusb.c	2004-04-04 05:36:14.000000000 +0200
+++ linux-2.6.5/drivers/usb/misc/tiglusb.c	2004-04-14 09:51:29.000000000 +0200
@@ -3,7 +3,7 @@
  * tiglusb -- Texas Instruments' USB GraphLink (aka SilverLink) driver.
  * Target: Texas Instruments graphing calculators (http://lpg.ticalc.org).
  *
- * Copyright (C) 2001-2002:
+ * Copyright (C) 2001-2004:
  *   Romain Lievin <roms@lpg.ticalc.org>
  *   Julien BLACHE <jb@technologeek.org>
  * under the terms of the GNU General Public License.
@@ -20,6 +20,8 @@
  *   1.04, Julien: clean-up & fixes; Romain: 2.4 backport.
  *   1.05, Randy Dunlap: bug fix with the timeout parameter (divide-by-zero).
  *   1.06, Romain: synched with 2.5, version/firmware changed (confusing).
+ *   1.07, Romain: fixed bad use of usb_clear_halt (invalid argument);
+ *          timeout argument checked in ioctl + clean-up.
  */
 
 #include <linux/module.h>
@@ -38,8 +40,8 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "1.06"
-#define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org> & Julien Blache <jb@jblache.org>"
+#define DRIVER_VERSION "1.07"
+#define DRIVER_AUTHOR  "Romain Lievin <roms@tilp.info> & Julien Blache <jb@jblache.org>"
 #define DRIVER_DESC    "TI-GRAPH LINK USB (aka SilverLink) driver"
 #define DRIVER_LICENSE "GPL"
 
@@ -73,13 +75,13 @@
 	unsigned int pipe;
 
 	pipe = usb_sndbulkpipe (dev, 1);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
+	if (usb_clear_halt (dev, pipe)) {
 		err ("clear_pipe (r), request failed");
 		return -1;
 	}
 
 	pipe = usb_sndbulkpipe (dev, 2);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
+	if (usb_clear_halt (dev, pipe)) {
 		err ("clear_pipe (w), request failed");
 		return -1;
 	}
@@ -183,15 +185,14 @@
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
 			       &bytes_read, HZ * 10 / timeout);
 	if (result == -ETIMEDOUT) {	/* NAK */
-		ret = result;
-		if (!bytes_read) {
+		if (!bytes_read)
 			dbg ("quirk !");
-		}
 		warn ("tiglusb_read, NAK received.");
+		ret = result;
 		goto out;
 	} else if (result == -EPIPE) {	/* STALL -- shouldn't happen */
 		warn ("clear_halt request to remove STALL condition.");
-		if (usb_clear_halt (s->dev, usb_pipeendpoint (pipe)))
+		if (usb_clear_halt (s->dev, pipe))
 			err ("clear_halt, request failed");
 		clear_device (s->dev);
 		ret = result;
@@ -251,7 +252,7 @@
 		goto out;
 	} else if (result == -EPIPE) {	/* STALL -- shouldn't happen */
 		warn ("clear_halt request to remove STALL condition.");
-		if (usb_clear_halt (s->dev, usb_pipeendpoint (pipe)))
+		if (usb_clear_halt (s->dev, pipe))
 			err ("clear_halt, request failed");
 		clear_device (s->dev);
 		ret = result;
@@ -292,15 +293,16 @@
 
 	switch (cmd) {
 	case IOCTL_TIUSB_TIMEOUT:
-		timeout = arg;	// timeout value in tenth of seconds
+		if (arg > 0)
+			timeout = arg;
+		else
+			ret = -EINVAL;
 		break;
 	case IOCTL_TIUSB_RESET_DEVICE:
-		dbg ("IOCTL_TIGLUSB_RESET_DEVICE");
 		if (clear_device (s->dev))
 			ret = -EIO;
 		break;
 	case IOCTL_TIUSB_RESET_PIPES:
-		dbg ("IOCTL_TIGLUSB_RESET_PIPES");
 		if (clear_pipes (s->dev))
 			ret = -EIO;
 		break;
@@ -447,7 +449,7 @@
 
 #ifndef MODULE
 /*
- * You can use 'tiusb=timeout'
+ * You can use 'tiusb=timeout' to set timeout.
  */
 static int __init
 tiglusb_setup (char *str)
@@ -457,10 +459,11 @@
 	str = get_options (str, ARRAY_SIZE (ints), ints);
 
 	if (ints[0] > 0) {
-		timeout = ints[1];
+		if (ints[1] > 0)
+			timeout = ints[1];
+		else
+			info ("tiglusb: wrong timeout value (0), using default value.");
 	}
-	if (timeout <= 0)
-		timeout = TIMAXTIME;
 
 	return 1;
 }
@@ -502,9 +505,6 @@
 
 	info (DRIVER_DESC ", version " DRIVER_VERSION);
 
-	if (timeout <= 0)
-		timeout = TIMAXTIME;
-
 	return 0;
 }
 

==========================[ doc24 ]=============================
diff -Naur linux-2.4.25.orig/Documentation/usb/silverlink.txt linux-2.4.25/Documentation/usb/silverlink.txt
--- linux-2.4.25.orig/Documentation/usb/silverlink.txt	2002-11-29 00:53:08.000000000 +0100
+++ linux-2.4.25/Documentation/usb/silverlink.txt	2004-04-14 10:49:35.000000000 +0200
@@ -8,7 +8,7 @@
 INTRODUCTION:
 
 This is a driver for the TI-GRAPH LINK USB (aka SilverLink) cable, a cable 
-designed by TI for connecting their TI8x/9x calculators to a computer 
+designed by TI for connecting their TI8x/9x graphing handhelds to a computer 
 (PC or Mac usually).
 
 If you need more information, please visit the 'SilverLink drivers' homepage 
@@ -16,10 +16,8 @@
 
 WHAT YOU NEED:
 
-A TI calculator of course and a program capable to communicate with your 
-calculator.
-TiLP will work for sure (since I am his developer !). yal92 may be able to use
-it by changing tidev for tiglusb (may require some hacking...).
+A TI calculator/handheld of course and a program capable to communicate with 
+your calculator. A good choice is TiLP (http://www.tilp.info).
 
 HOW TO USE IT:
 
@@ -58,14 +56,19 @@
 QUIRKS:
 
 The following problem seems to be specific to the link cable since it appears 
-on all platforms (Linux, Windows, Mac OS-X). 
+on all platforms (Linux, Windows, Mac OS-X). A guy told me it was a common but
+weird behaviour with Cypress microcontrollers (it uses an CY7C64013).
 
-In some very particular cases, the driver returns with success but
+In some very particular cases, the driver returns with success (no error) but
 without any data. The application should retry a read operation at least once.
 
+This problem and the need to issue IOCTL_TIUSB_RESET_PIPES before doing any
+packet transfer (like TI's software do) make this driver difficult to use in 
+pure raw access.
+
 HOW TO CONTACT US:
 
-You can email me at roms@lpg.ticalc.org. Please prefix the subject line
+You can email me at roms@tilp.info. Please prefix the subject line
 with "TIGLUSB: " so that I am certain to notice your message.
 You can also mail JB at jb@jblache.org: he has written the first release of 
 this driver but he better knows the Mac OS-X driver.
@@ -73,4 +76,4 @@
 CREDITS:
 
 The code is based on dabusb.c, printer.c and scanner.c !
-The driver has been developed independantly of Texas Instruments.
+The driver has been developed without any support from Texas Instruments Inc.

==========================[ doc26 ]=============================
diff -Naur linux-2.6.5.orig/Documentation/usb/silverlink.txt linux-2.6.5/Documentation/usb/silverlink.txt
--- linux-2.6.5.orig/Documentation/usb/silverlink.txt	2004-04-04 05:36:56.000000000 +0200
+++ linux-2.6.5/Documentation/usb/silverlink.txt	2004-04-14 10:51:10.000000000 +0200
@@ -8,7 +8,7 @@
 INTRODUCTION:
 
 This is a driver for the TI-GRAPH LINK USB (aka SilverLink) cable, a cable 
-designed by TI for connecting their TI8x/9x calculators to a computer 
+designed by TI for connecting their TI8x/9x graphing handhelds to a computer 
 (PC or Mac usually).
 
 If you need more information, please visit the 'SilverLink drivers' homepage 
@@ -16,10 +16,8 @@
 
 WHAT YOU NEED:
 
-A TI calculator of course and a program capable to communicate with your 
-calculator.
-TiLP will work for sure (since I am his developer !). yal92 may be able to use
-it by changing tidev for tiglusb (may require some hacking...).
+A TI calculator/handheld of course and a program capable to communicate with 
+your calculator. A good choice is TiLP (http://www.tilp.info).
 
 HOW TO USE IT:
 
@@ -58,14 +56,19 @@
 QUIRKS:
 
 The following problem seems to be specific to the link cable since it appears 
-on all platforms (Linux, Windows, Mac OS-X). 
+on all platforms (Linux, Windows, Mac OS-X). A guy told me it was a common but
+weird behaviour with Cypress microcontrollers (it uses an CY7C64013).
 
-In some very particular cases, the driver returns with success but
+In some very particular cases, the driver returns with success (no error) but
 without any data. The application should retry a read operation at least once.
 
+This problem and the need to issue IOCTL_TIUSB_RESET_PIPES before doing any
+packet transfer (like TI's software do) make this driver difficult to use in 
+pure raw access.
+
 HOW TO CONTACT US:
 
-You can email me at roms@lpg.ticalc.org. Please prefix the subject line
+You can email me at roms@tilp.info. Please prefix the subject line
 with "TIGLUSB: " so that I am certain to notice your message.
 You can also mail JB at jb@jblache.org: he has written the first release of 
 this driver but he better knows the Mac OS-X driver.
@@ -73,4 +76,4 @@
 CREDITS:
 
 The code is based on dabusb.c, printer.c and scanner.c !
-The driver has been developed independently of Texas Instruments.
+The driver has been developed without any support from Texas Instruments Inc.

-- 
Romain Liévin (roms):         <romain@lievin.net>
Web site:                     http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






