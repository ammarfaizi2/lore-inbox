Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVDDKBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDDKBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDDKBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:01:21 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:3466 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261205AbVDDKBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:01:05 -0400
Message-ID: <42511043.7050501@linuxtv.org>
Date: Mon, 04 Apr 2005 12:00:35 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020108060608010805050903"
X-SA-Exim-Connect-IP: 84.137.213.165
Subject: [PATCH] Fix Oops in MXB driver (v4l2 subsystem)
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108060608010805050903
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus, Andrew,

the attached patch fixes a NULL pointer dereference Oops in my 
"Multimedia eXtension Board" driver.

The tda9840 i2c driver dereferences the argument pointer, but the MXB 
driver is supplying a NULL pointer for one of the commands. The patch 
makes this one command behave like the others, ie. it expects an int 
argument.

Please apply.

Thanks!
Michael Hunold.


--------------020108060608010805050903
Content-Type: text/x-patch;
 name="mxb_tda9840_oops.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mxb_tda9840_oops.diff"

diff -ura a/drivers/media/video/mxb.c linux-2.6.11.6/drivers/media/video/mxb.c
--- a/drivers/media/video/mxb.c	2005-04-04 11:31:06.000000000 +0200
+++ linux-2.6.11.6/drivers/media/video/mxb.c	2005-04-04 11:17:28.000000000 +0200
@@ -731,7 +731,7 @@
 		t->signal = 0xffff;
 		t->afc = 0;		
 
-		byte = mxb->tda9840->driver->command(mxb->tda9840,TDA9840_DETECT, NULL);
+		mxb->tda9840->driver->command(mxb->tda9840,TDA9840_DETECT, &byte);
 		t->audmode = mxb->cur_mode;
 		
 		if( byte < 0 ) {
diff -ura a/drivers/media/video/tda9840.c linux-2.6.11.6/drivers/media/video/tda9840.c
--- a/drivers/media/video/tda9840.c	2005-04-04 11:31:23.000000000 +0200
+++ linux-2.6.11.6/drivers/media/video/tda9840.c	2005-04-04 11:21:50.000000000 +0200
@@ -120,7 +120,8 @@
 			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
 		break;
 
-	case TDA9840_DETECT:
+	case TDA9840_DETECT: {
+		int *ret = (int *)arg;
 
 		byte = i2c_smbus_read_byte_data(client, STEREO_ADJUST);
 		if (byte == -1) {
@@ -134,8 +135,10 @@
 		}
 
 		dprintk("TDA9840_DETECT: byte: 0x%02x\n", byte);
-		return ((byte & 0x60) >> 5);
-
+		*ret = ((byte & 0x60) >> 5);
+		result = 0;
+		break;
+	}
 	case TDA9840_TEST:
 		dprintk("TDA9840_TEST: 0x%02x\n", byte);
 

--------------020108060608010805050903--
