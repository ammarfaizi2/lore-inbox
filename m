Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265857AbTL3WYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbTL3WNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:13:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:52417 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265857AbTL3WGd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:33 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219702175@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <10728219701628@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.31, 2003/12/17 16:04:10-08:00, mhoffman@lightlink.com

[PATCH] I2C: improve chip detection in w83781d.c driver

This patch improves chip detection.  It was forward ported from the
lm_sensors project CVS, from these revisions:

	1.104 (Khali) Enhance chip detection (stricter).
	1.108 (Khali) Fix W83627HF detection.


 drivers/i2c/chips/w83781d.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Tue Dec 30 12:30:38 2003
+++ b/drivers/i2c/chips/w83781d.c	Tue Dec 30 12:30:38 2003
@@ -24,10 +24,11 @@
     Supports following chips:
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    as99127f	7	3	1?	3	0x30	0x12c3	yes	no
-    asb100 "bach" (type_name = as99127f)	0x30	0x0694	yes	no
-    w83781d	7	3	0	3	0x10	0x5ca3	yes	yes
-    w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)
+    as99127f	7	3	1?	3	0x31	0x12c3	yes	no
+    as99127f rev.2 (type_name = 1299127f)	0x31	0x5ca3	yes	no
+    asb100 "bach" (type_name = as99127f)	0x31	0x0694	yes	no
+    w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
+    w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
     w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
@@ -1264,7 +1265,7 @@
 			goto ERROR2;
 		}
 		/* If Winbond SMBus, check address at 0x48.
-		   Asus doesn't support */
+		   Asus doesn't support, except for as99127f rev.2 */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 == 0xa3)) ||
 				  ((val1 & 0x80) && (val2 == 0x5c)))) {
 			if (w83781d_read_value
@@ -1295,18 +1296,17 @@
 			goto ERROR2;
 		}
 
-		/* mask off lower bit, not reliable */
-		val1 =
-		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
-		if (val1 == 0x10 && vendid == winbond)
+		val1 = w83781d_read_value(new_client, W83781D_REG_WCHIPID);
+		if ((val1 == 0x10 || val1 == 0x11) && vendid == winbond)
 			kind = w83781d;
 		else if (val1 == 0x30 && vendid == winbond)
 			kind = w83782d;
-		else if (val1 == 0x40 && vendid == winbond && !is_isa)
+		else if (val1 == 0x40 && vendid == winbond && !is_isa
+				&& address == 0x2d)
 			kind = w83783s;
-		else if ((val1 == 0x20 || val1 == 0x90) && vendid == winbond)
+		else if ((val1 == 0x21 || val1 == 0x90) && vendid == winbond)
 			kind = w83627hf;
-		else if (val1 == 0x30 && vendid == asus && !is_isa)
+		else if (val1 == 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
 		else if (val1 == 0x60 && vendid == winbond && is_isa)
 			kind = w83697hf;

