Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVJORhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVJORhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 13:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVJORhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 13:37:08 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:32499 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1750965AbVJORhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 13:37:06 -0400
Subject: [PATCH / 2.6.13.4] fix black/white-only svideo input in vpx3220
	decoder
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, shadowlord@utanet.at,
       mjpeg-developer@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-IJXZ4Y1dtPcjjw6axxzf"
Date: Sat, 15 Oct 2005 13:38:18 -0400
Message-Id: <1129397898.2684.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IJXZ4Y1dtPcjjw6axxzf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached patch fixes the fact that the svideo input will only give input
in black/white in some circumstances. Reason is that in the PCI
controller driver (zr36067), after setting input, we reset norm, which
overwrites the input register with the default. This patch makes it
always set the correct value for the input when changing norm.

Patch is against 2.6.13.4 because I couldn't find a pre-made
2.6.14-current tarball to generate the patch against. Shouldn't matter
still, since the vpx3220 driver didn't change much in between, afaik.

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Cheers,
Ronald

--=-IJXZ4Y1dtPcjjw6axxzf
Content-Disposition: attachment; filename=vpx3220-color-svideo.patch
Content-Type: text/x-patch; name=vpx3220-color-svideo.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.13.4/drivers/media/video/vpx3220-old.c	2005-10-15 13:34:29.000000000 -0400
+++ linux-2.6.13.4/drivers/media/video/vpx3220.c	2005-10-15 13:34:40.000000000 -0400
@@ -410,6 +410,12 @@
 	case DECODER_SET_NORM:
 	{
 		int *iarg = arg, data;
+		int temp_input;
+
+		/* Here we back up the input selection because it gets
+		   overwritten when we fill the registers with the
+                   choosen video norm */		
+		temp_input = vpx3220_fp_read(client, 0xf2);
 
 		dprintk(1, KERN_DEBUG "%s: DECODER_SET_NORM %d\n",
 			I2C_NAME(client), *iarg);
@@ -449,6 +455,10 @@
 
 		}
 		decoder->norm = *iarg;
+
+		/* And here we set the backed up video input again */
+		vpx3220_fp_write(client, 0xf2, temp_input | 0x0010);
+		udelay(10);
 	}
 		break;
 

--=-IJXZ4Y1dtPcjjw6axxzf--

