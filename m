Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUH2T2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUH2T2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUH2T2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:28:21 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:3084 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S268281AbUH2T2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:28:07 -0400
Subject: [PATCH] 3/3: 2.6.8 zr36067 driver - correct subfrequency carrier
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Douglas Fraser <ds-fraser@comcast.net>,
       mjpeg-developer@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-qQShQpnlsV6mgoHpLFGg"
Message-Id: <1093807763.26498.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 21:29:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qQShQpnlsV6mgoHpLFGg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached patch changes the subfrequency carrier value in the adv7175
video output driver which is part of the zr36067 driver package. The
practical consequence is that the picture will be more stable on
non-passthrough video mode in NTSC. It does not affect PAL/SECAM. Patch
originally submitted by Douglas Fraser <ds-fraser@comcast.net> (8/21).

Ronald

Signed-off-by: Ronald Bultje <rbultje@ronald.bitfreak.net>
Signed-off-by: Douglas Fraser <ds-fraser@comcast.net>

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

--=-qQShQpnlsV6mgoHpLFGg
Content-Disposition: attachment; filename=zoran-adv7175-scf.diff
Content-Type: text/x-patch; name=zoran-adv7175-scf.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux/drivers/media/video/adv7175.c
--- linux~zoran-adv7175-scf/drivers/media/video/adv7175.c	2004-08-14 12:56:22.000000000 +0200
+++ linux/drivers/media/video/adv7175.c	2004-08-29 18:33:18.392719048 +0200
@@ -156,6 +156,22 @@
 	return ret;
 }
 
+static void
+set_subcarrier_freq (struct i2c_client *client,
+		     int                pass_through)
+{
+	/* for some reason pass_through NTSC needs
+	 * a different sub-carrier freq to remain stable. */
+	if(pass_through)
+		adv7175_write(client, 0x02, 0x00);
+	else
+		adv7175_write(client, 0x02, 0x55);
+
+	adv7175_write(client, 0x03, 0x55);
+	adv7175_write(client, 0x04, 0x55);
+	adv7175_write(client, 0x05, 0x25);
+}
+
 #ifdef ENCODER_DUMP
 static void
 dump (struct i2c_client *client)
@@ -322,6 +338,10 @@
 
 		case 0:
 			adv7175_write(client, 0x01, 0x00);
+
+			if (encoder->norm == VIDEO_MODE_NTSC)
+				set_subcarrier_freq(client, 1);
+
 			adv7175_write(client, 0x0c, TR1CAPT);	/* TR1 */
 			if (encoder->norm == VIDEO_MODE_SECAM)
 				adv7175_write(client, 0x0d, 0x49);	// Disable genlock
@@ -334,6 +354,10 @@
 
 		case 1:
 			adv7175_write(client, 0x01, 0x00);
+
+			if (encoder->norm == VIDEO_MODE_NTSC)
+				set_subcarrier_freq(client, 0);
+
 			adv7175_write(client, 0x0c, TR1PLAY);	/* TR1 */
 			adv7175_write(client, 0x0d, 0x49);
 			adv7175_write(client, 0x07, TR0MODE | TR0RST);
@@ -343,6 +367,10 @@
 
 		case 2:
 			adv7175_write(client, 0x01, 0x80);
+
+			if (encoder->norm == VIDEO_MODE_NTSC)
+				set_subcarrier_freq(client, 0);
+
 			adv7175_write(client, 0x0d, 0x49);
 			adv7175_write(client, 0x07, TR0MODE | TR0RST);
 			adv7175_write(client, 0x07, TR0MODE);

--=-qQShQpnlsV6mgoHpLFGg--

