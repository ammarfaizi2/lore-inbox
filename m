Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUDSI5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264316AbUDSI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:56:46 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:4327 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264307AbUDSI4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:56:05 -0400
Date: Mon, 19 Apr 2004 10:55:59 +0200
From: Romain Lievin <lkml@lievin.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah <greg@kroah.com>
Subject: [PATCH] tiglusb: wrong timeout value
Message-ID: <20040419085559.GA13904@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch (cumulative; 2.4 & 2.6) fixes another bug in the tiglusb driver. The formula used to calculate jiffies from timeout is wrong.
The new formula is ok and takes care of integer computation/rounding.
This is the same kind of bug than in the tipar char driver.

Please apply, Romain.
======================[ cut here ]===========================
diff -Naur linux-2.6.5.orig/drivers/usb/misc/tiglusb.c linux-2.6.5/drivers/usb/misc/tiglusb.c
--- linux-2.6.5.orig/drivers/usb/misc/tiglusb.c	2004-04-04 05:36:14.000000000 +0200
+++ linux-2.6.5/drivers/usb/misc/tiglusb.c	2004-04-19 10:47:59.000000000 +0200
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
 
@@ -72,15 +74,15 @@
 {
 	unsigned int pipe;
 
-	pipe = usb_sndbulkpipe (dev, 1);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
-		err ("clear_pipe (r), request failed");
+	pipe = usb_sndbulkpipe (dev, 2);
+	if (usb_clear_halt (dev, pipe)) {
+		err ("clear_pipe (w), request failed");
 		return -1;
 	}
 
-	pipe = usb_sndbulkpipe (dev, 2);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
-		err ("clear_pipe (w), request failed");
+	pipe = usb_rcvbulkpipe (dev, 1);
+	if (usb_clear_halt (dev, pipe)) {
+		err ("clear_pipe (r), request failed");
 		return -1;
 	}
 
@@ -181,17 +183,16 @@
 
 	pipe = usb_rcvbulkpipe (s->dev, 1);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
-			       &bytes_read, HZ * 10 / timeout);
+			       &bytes_read, (HZ * timeout) / 10);
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
@@ -243,7 +244,7 @@
 
 	pipe = usb_sndbulkpipe (s->dev, 2);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_write,
-			       &bytes_written, HZ * 10 / timeout);
+			       &bytes_written, (HZ * timeout) / 10);
 
 	if (result == -ETIMEDOUT) {	/* NAK */
 		warn ("tiglusb_write, NAK received.");
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
 

======================[ cut here ]===========================
diff -Naur linux-2.4.26.orig/drivers/usb/tiglusb.c linux-2.4.26/drivers/usb/tiglusb.c
--- linux-2.4.26.orig/drivers/usb/tiglusb.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.26/drivers/usb/tiglusb.c	2004-04-19 10:42:14.000000000 +0200
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
+ *   1.07, Romain: fixed bad use of usb_clear_halt (invalid argument),
+ *         checking for a valid timeout, fixed wrong timeout formula, clean-up.
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
 
@@ -74,15 +77,15 @@
 {
 	unsigned int pipe;
 
-	pipe = usb_sndbulkpipe (dev, 1);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
-		err ("clear_pipe (r), request failed");
+	pipe = usb_sndbulkpipe (dev, 2);
+	if (usb_clear_halt (dev, pipe)) {
+		err ("clear_pipe (w), request failed");
 		return -1;
 	}
 
-	pipe = usb_sndbulkpipe (dev, 2);
-	if (usb_clear_halt (dev, usb_pipeendpoint (pipe))) {
-		err ("clear_pipe (w), request failed");
+	pipe = usb_rcvbulkpipe (dev, 1);
+	if (usb_clear_halt (dev, pipe)) {
+		err ("clear_pipe (r), request failed");
 		return -1;
 	}
 
@@ -179,17 +182,16 @@
 
 	pipe = usb_rcvbulkpipe (s->dev, 1);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
-			       &bytes_read, HZ * 10 / timeout);
+			       &bytes_read, (HZ * timeout) / 10);
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
@@ -236,7 +238,7 @@
 
 	pipe = usb_sndbulkpipe (s->dev, 2);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_write,
-			       &bytes_written, HZ * 10 / timeout);
+			       &bytes_written, (HZ * timeout) / 10);
 
 	if (result == -ETIMEDOUT) {	/* NAK */
 		warn ("tiglusb_write, NAK received.");
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
 

======================[ cut here ]===========================
-- 
Romain Liévin (roms):         <lkml@lievin.net>
Web site:                     http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






