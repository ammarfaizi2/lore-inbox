Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTDHHPP (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 03:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTDHHPP (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 03:15:15 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.29]:13393 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263893AbTDHHPO (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 03:15:14 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: don't open a connection if no firmware
Date: Tue, 8 Apr 2003 09:26:43 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304080926.43403.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People using Alcatel's closed source firmware loader "speedmgmt" may need
to sleep longer before launching pppd.

--- redux-2.5/drivers/usb/misc/speedtch.c	2003-04-08 08:49:33.000000000 +0200
+++ bollux-2.5/drivers/usb/misc/speedtch.c	2003-04-04 13:44:11.000000000 +0200
@@ -816,9 +816,6 @@
 		return -ENODEV;
 	}
 
-	if (!instance->firmware_loaded)
-		return -EAGAIN;
-
 	if (vcc->qos.aal != ATM_AAL5) {
 		dbg ("unsupported ATM type %d!", vcc->qos.aal);
 		return -EINVAL;
@@ -933,6 +930,11 @@
 	if (vcc->qos.aal != ATM_AAL5)
 		return -EINVAL;
 
+	if (!instance->firmware_loaded) {
+		dbg ("firmware not loaded!");
+		return -EAGAIN;
+	}
+
 	down (&instance->serialize); /* vs self, udsl_atm_close */
 
 	if (udsl_find_vcc (instance, vpi, vci)) {
@@ -967,13 +969,12 @@
 
 	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
 
-	MOD_INC_USE_COUNT;
-
-	if (instance->firmware_loaded)
-		udsl_fire_receivers (instance);
+	udsl_fire_receivers (instance);
 
 	dbg ("udsl_atm_open successful");
 
+	MOD_INC_USE_COUNT;
+
 	return 0;
 }
 
@@ -1041,6 +1042,7 @@
 		int ret;
 
 		if ((ret = usb_set_interface (instance->usb_dev, 1, 1)) < 0) {
+			dbg ("usb_set_interface returned %d!", ret);
 			up (&instance->serialize);
 			return ret;
 		}
