Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVDDQLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVDDQLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDDQLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:11:11 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:22421 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261277AbVDDQKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:10:39 -0400
Message-ID: <425166F9.1040800@kroon.co.za>
Date: Mon, 04 Apr 2005 18:10:33 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050328
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Sebastian Piechocki <sebekpi@poczta.onet.pl>
Subject: i8042 controller on Toshiba Satellite P10 notebook - patch
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030506070308090802040202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030506070308090802040202
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all

A while back there was quite a discussion on this issue and then
specifically "i8042 timing issues".  I refer you to
http://lkml.org/lkml/2005/1/27/11 for more detail.

It turns out that it was the case that the i8042 controller responds too
late on commands, for example, we issue a AUX_LOOP command, whilst
waiting for the response it would time out, however, when issuing
AUX_TEST we will get the response for AUX_LOOP.  It turns out this is
also true for the MUX and KBD parts of the driver.  The attached patch
resolves this issue by providing a configurable option to issue commands
that expects results twice (not sure whether this is a good idea - but
it seems all commands either set some value or query some value).
Between the two commands it calls i8042_flush() to make sure that there
are not any earlier responses in the buffer.

I've built the patch against linux-2.6.11.6 and it should apply cleanly
(I've attached the patch cause it is about 80 lines in length and I fear
mozilla will break the formatting).

The patch fixes the problem for me - not sure how many other people out
there has the same issue.  It provides a configurable option which can
be selected in the kernel configuration to actually enable this (albeit
enabling it should only result in a minor performance hit should it be
enabled needlessly - I think).  Should the option not be enabled the
code remains 100% unchanged (except for one extra level of indentation).

I'm not sure what the policy regarding #ifdefs are, especially
considering they enclose the endpoints of a loop, please review and comment.

Jaco
-- 
There are only 10 kinds of people in this world,
  those that understand binary and those that don't.
http://www.kroon.co.za/

--------------030506070308090802040202
Content-Type: text/plain;
 name="i8042_delayed_response_kludge-2.6.11.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8042_delayed_response_kludge-2.6.11.6.patch"

diff -rau linux-2.6.11.6.orig/drivers/input/serio/Kconfig linux-2.6.11.6/drivers/input/serio/Kconfig
--- linux-2.6.11.6.orig/drivers/input/serio/Kconfig	2005-03-26 05:28:21.000000000 +0200
+++ linux-2.6.11.6/drivers/input/serio/Kconfig	2005-04-04 12:01:01.000000000 +0200
@@ -31,6 +31,19 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called i8042.
 
+config SERIO_I8042_DELAYEDRESPONSEKLUDGE
+	tristate "i8042 delayed response kludge"
+	default n
+	depends on SERIO_I8042
+	---help---
+	  The Toshiba Satellite P10 series has a delayed response on the i8042
+	  device which controls the mouse/keyboard.  Whilst the keyboard can
+	  function without this kludge it is required for the touchpad.  Whilst
+	  the kludge should not break other systems I highly recommend saying N
+	  on all systems but those who suffer this problem.
+
+	  If unsure, say N.
+
 config SERIO_SERPORT
 	tristate "Serial port line discipline"
 	default y
diff -rau linux-2.6.11.6.orig/drivers/input/serio/i8042.c linux-2.6.11.6/drivers/input/serio/i8042.c
--- linux-2.6.11.6.orig/drivers/input/serio/i8042.c	2005-03-26 05:28:15.000000000 +0200
+++ linux-2.6.11.6/drivers/input/serio/i8042.c	2005-04-04 12:26:15.000000000 +0200
@@ -185,24 +185,41 @@
 	unsigned long flags;
 	int retval = 0, i = 0;
 
+#ifdef CONFIG_SERIO_I8042_DELAYEDRESPONSEKLUDGE
+	int kludge = 0;
+
+	if((command >> 8) & 0xf)
+		kludge = 1;
+#endif
+	
 	if (i8042_noloop && command == I8042_CMD_AUX_LOOP)
 		return -1;
-
+	
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	retval = i8042_wait_write();
-	if (!retval) {
-		dbg("%02x -> i8042 (command)", command & 0xff);
-		i8042_write_command(command & 0xff);
-	}
-
-	if (!retval)
-		for (i = 0; i < ((command >> 12) & 0xf); i++) {
-			if ((retval = i8042_wait_write())) break;
-			dbg("%02x -> i8042 (parameter)", param[i]);
-			i8042_write_data(param[i]);
+#ifdef CONFIG_SERIO_I8042_DELAYEDRESPONSEKLUDGE
+	do {
+#endif
+		retval = i8042_wait_write();
+		if (!retval) {
+			dbg("%02x -> i8042 (command)", command & 0xff);
+			i8042_write_command(command & 0xff);
 		}
 
+		if (!retval)
+			for (i = 0; i < ((command >> 12) & 0xf); i++) {
+				if ((retval = i8042_wait_write())) break;
+				dbg("%02x -> i8042 (parameter)", param[i]);
+				i8042_write_data(param[i]);
+			}
+		
+#ifdef CONFIG_SERIO_I8042_DELAYEDRESPONSEKLUDGE
+		if(kludge)
+			i8042_flush();
+
+	} while(!retval && kludge--);
+#endif
+
 	if (!retval)
 		for (i = 0; i < ((command >> 8) & 0xf); i++) {
 			if ((retval = i8042_wait_read())) break;

--------------030506070308090802040202--
