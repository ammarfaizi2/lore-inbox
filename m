Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbUDFRyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbUDFRyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:54:19 -0400
Received: from tench.street-vision.com ([212.18.235.100]:9898 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S263925AbUDFRyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:54:17 -0400
Subject: [PATCH] [libata] quick fix for vendor and model names
From: Justin Cormack <justin@street-vision.com>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-lwr4OZLgl3fKrwDGPXPO"
Message-Id: <1081274055.18070.29.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Apr 2004 18:54:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lwr4OZLgl3fKrwDGPXPO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

ok, so transport attributes arent happening for libata. Howabout this
little patch to fix up the vendor and model names in the common case
when they are 3 chars + 16 chars (like almost all hard drives) so the
model names arent truncated in this case. Otherwise leaves things as
they are.

Justin



--=-lwr4OZLgl3fKrwDGPXPO
Content-Disposition: attachment; filename=libata-hackpatch
Content-Type: text/x-patch; name=libata-hackpatch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.5-orig/drivers/scsi/libata-scsi.c linux-2.6.5/drivers/scsi/libata-scsi.c
--- linux-2.6.5-orig/drivers/scsi/libata-scsi.c	2004-04-04 03:36:57.000000000 +0000
+++ linux-2.6.5/drivers/scsi/libata-scsi.c	2004-04-06 17:10:57.000000000 +0000
@@ -464,11 +464,17 @@
 	memcpy(rbuf, hdr, sizeof(hdr));
 
 	if (buflen > 36) {
-		memcpy(&rbuf[8], args->dev->vendor, 8);
-		memcpy(&rbuf[16], args->dev->product, 16);
+	        /* hack for common ata vendor/product strings */
+	        if (args->dev->product[3] == ' ') {
+		        memcpy(&rbuf[8], args->dev->product, 4);
+			memset(&rbuf[12], ' ', 4);
+		        memcpy(&rbuf[16], &args->dev->product[4], 16);
+	        } else {
+		        memcpy(&rbuf[8], args->dev->vendor, 8);
+		        memcpy(&rbuf[16], args->dev->product, 16);
+		}
 		memcpy(&rbuf[32], DRV_VERSION, 4);
 	}
-
 	if (buflen > 63) {
 		const u8 versions[] = {
 			0x60,	/* SAM-3 (no version claimed) */

--=-lwr4OZLgl3fKrwDGPXPO--

