Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUDPG0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 02:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUDPG0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 02:26:43 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:16857 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262532AbUDPG0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 02:26:37 -0400
Date: Fri, 16 Apr 2004 08:26:35 +0200
From: Romain Lievin <lkml@lievin.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] tipar char driver (divide by zero)
Message-ID: <20040416062635.GA32021@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a set of 2 patches (2.4 & 2.6) about the tipar.c char driver. It fixes a divide-by-zero error when we try to read/write data after setting timeout to 0.

Please apply...

Romain.
============================[cut here]==========================
diff -Naur linux-2.4.23/drivers/char/tipar.c linux/drivers/char/tipar.c
--- linux-2.4.23/drivers/char/tipar.c	2003-06-01 05:06:24.000000000 +0200
+++ linux/drivers/char/tipar.c	2004-03-21 22:19:54.000000000 +0100
@@ -66,7 +66,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "1.18"
+#define DRIVER_VERSION "1.19"
 #define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org>"
 #define DRIVER_DESC    "Device driver for TI/PC parallel link cables"
 #define DRIVER_LICENSE "GPL"
@@ -364,11 +364,14 @@
 
 	switch (cmd) {
 	case IOCTL_TIPAR_DELAY:
-	  delay = (int)arg;    //get_user(delay, &arg);
-	  break;
+		delay = (int)arg;    //get_user(delay, &arg);
+		break;
 	case IOCTL_TIPAR_TIMEOUT:
-	  timeout = (int)arg;  //get_user(timeout, &arg);
-	  break;
+		if (arg != 0)
+                        timeout = (int)arg;
+                else
+                        retval = -EINVAL;
+		break;
 	default:
 		retval = -ENOTTY;
 		break;
@@ -402,7 +405,10 @@
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (ints[0] > 0) {
-		timeout = ints[1];
+		if (ints[1] != 0)
+                        timeout = ints[1];
+                else
+                        printk("tipar: wrong timeout value (0), using default value instead.");
 		if (ints[0] > 1) {
 			delay = ints[2];
 		}

============================[cut here]==========================
diff -Naur linux-2.6.3/drivers/char/tipar.c linux/drivers/char/tipar.c
--- linux-2.6.3/drivers/char/tipar.c	2004-02-18 04:58:48.000000000 +0100
+++ linux/drivers/char/tipar.c	2004-03-21 22:11:11.000000000 +0100
@@ -67,7 +67,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "1.17"
+#define DRIVER_VERSION "1.19"
 #define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org>"
 #define DRIVER_DESC    "Device driver for TI/PC parallel link cables"
 #define DRIVER_LICENSE "GPL"
@@ -361,10 +361,13 @@
 
 	switch (cmd) {
 	case IOCTL_TIPAR_DELAY:
-	  delay = (int)arg;    //get_user(delay, &arg);
-	  break;
+		delay = (int)arg;    //get_user(delay, &arg);
+		break;
 	case IOCTL_TIPAR_TIMEOUT:
-	  timeout = (int)arg;  //get_user(timeout, &arg);
+		if (arg != 0)
+                        timeout = (int)arg;
+                else
+                        retval = -EINVAL;
 	  break;
 	default:
 		retval = -ENOTTY;
@@ -399,7 +402,10 @@
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (ints[0] > 0) {
-		timeout = ints[1];
+		if (ints[1] != 0)
+                        timeout = ints[1];
+                else
+                        printk("tipar: wrong timeout value (0), using default value instead.");
 		if (ints[0] > 1) {
 			delay = ints[2];
 		}

-- 
Romain Liévin (roms):         <romain@lievin.net>
Web site:                     http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






