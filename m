Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbUDOSJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUDORq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:46:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:23990 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263120AbUDORmK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:10 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509122975@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509122685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.10, 2004/03/26 14:24:35-08:00, romain@lievin.net

[PATCH] tipar char driver (divide by zero)

A patch about the tipar.c char driver has been sent on lkml by Sebastien
Bourdeau. It fixes a divide-by-zero error when we try to read/write data
after setting the timeout to 0.


 drivers/char/tipar.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)


diff -Nru a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c	Thu Apr 15 10:20:45 2004
+++ b/drivers/char/tipar.c	Thu Apr 15 10:20:45 2004
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

