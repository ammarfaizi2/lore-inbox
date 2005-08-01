Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVHASVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVHASVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVHASS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:18:59 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:10192 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261329AbVHASRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:17:03 -0400
Message-ID: <42EE671B.2010300@brturbo.com.br>
Date: Mon, 01 Aug 2005 15:16:59 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.6-1mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH for 2.6.13-rc4] V4L bug fix to correct tea5767 autodetection
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------080903080903040604080703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080903080903040604080703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch does correct radio chip autodetection to avoid misdetecting
mt20xx microtune as tea5767 chip.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tea5767.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

--------------080903080903040604080703
Content-Type: text/x-patch;
 name="v4l_tea5767_for_2.6.13-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_tea5767_for_2.6.13-rc4.diff"

 linux/drivers/media/video/tea5767.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff -u linux-2.6.13/drivers/media/video/tea5767.c linux/drivers/media/video/tea5767.c
--- linux-2.6.13/drivers/media/video/tea5767.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/tea5767.c	2005-08-01 08:57:59.000000000 -0300
@@ -2,7 +2,7 @@
  * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
  * I2C address is allways 0xC0.
  *
- * $Id: tea5767.c,v 1.21 2005/07/14 03:06:43 mchehab Exp $
+ * $Id: tea5767.c,v 1.27 2005/07/31 12:10:56 mchehab Exp $
  *
  * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
  * This code is placed under the terms of the GNU General Public License
@@ -15,7 +15,6 @@
 #include <linux/videodev.h>
 #include <linux/delay.h>
 #include <media/tuner.h>
-#include <media/tuner.h>
 
 #define PREFIX "TEA5767 "
 
@@ -293,16 +292,16 @@
 
 int tea5767_autodetection(struct i2c_client *c)
 {
-	unsigned char buffer[5] = { 0xff, 0xff, 0xff, 0xff, 0xff };
+	unsigned char buffer[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (5 != (rc = i2c_master_recv(c, buffer, 5))) {
+	if (7 != (rc = i2c_master_recv(c, buffer, 7))) {
 		tuner_warn("It is not a TEA5767. Received %i bytes.\n", rc);
 		return EINVAL;
 	}
 
-	/* If all bytes are the same then it's a TV tuner and not a tea5767 chip. */
+	/* If all bytes are the same then it's a TV tuner and not a tea5767 */
 	if (buffer[0] == buffer[1] && buffer[0] == buffer[2] &&
 	    buffer[0] == buffer[3] && buffer[0] == buffer[4]) {
 		tuner_warn("All bytes are equal. It is not a TEA5767\n");
@@ -319,6 +318,12 @@
 		return EINVAL;
 	}
 
+	/* It seems that tea5767 returns 0xff after the 5th byte */
+	if ((buffer[5] != 0xff) || (buffer[6] != 0xff)) {
+		tuner_warn("Returned more than 5 bytes. It is not a TEA5767\n");
+		return EINVAL;
+	}
+
 	tuner_warn("TEA5767 detected.\n");
 	return 0;
 }
@@ -327,9 +332,6 @@
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (tea5767_autodetection(c) == EINVAL)
-		return EINVAL;
-
 	tuner_info("type set to %d (%s)\n", t->type, "Philips TEA5767HN FM Radio");
 	strlcpy(c->name, "tea5767", sizeof(c->name));
 


--------------080903080903040604080703--
