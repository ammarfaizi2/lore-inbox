Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVEYM1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVEYM1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVEYM1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:27:04 -0400
Received: from webapps.arcom.com ([194.200.159.168]:37895 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262319AbVEYM0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:26:46 -0400
Subject: [UINPUT] Allow EV_ABS to work in uinput.c
From: Ian Campbell <icampbell@arcom.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Wed, 25 May 2005 13:26:38 +0100
Message-Id: <1117023999.20237.8.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2005 12:35:34.0484 (UTC) FILETIME=[3F13C940:01C56126]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

uinput_alloc_device() is supposed to return the number of bytes read,
the value is returned to uinput_write() and from there to userspace. If
EV_ABS is set then it returns the value from uinput_validate_absbits()
instead, which is zero when everything is ok instead of the count.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

%patch
Index: 2.6/drivers/input/misc/uinput.c
===================================================================
--- 2.6.orig/drivers/input/misc/uinput.c	2005-05-25 10:45:56.000000000 +0100
+++ 2.6/drivers/input/misc/uinput.c	2005-05-25 10:47:02.000000000 +0100
@@ -216,9 +216,11 @@
 	/* check if absmin/absmax/absfuzz/absflat are filled as
 	 * told in Documentation/input/input-programming.txt */
 	if (test_bit(EV_ABS, dev->evbit)) {
-		retval = uinput_validate_absbits(dev);
-		if (retval < 0)
+		int err = uinput_validate_absbits(dev);
+		if (err < 0) {
+			retval = err;
 			kfree(dev->name);
+		}
 	}
 
 exit:


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

