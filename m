Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUIRKDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUIRKDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 06:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269176AbUIRKDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 06:03:07 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:31363 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269175AbUIRKAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 06:00:14 -0400
Message-ID: <414C0730.3020503@drzeus.cx>
Date: Sat, 18 Sep 2004 12:00:16 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-18275-1095501638-0001-2"
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 3/3] MMC compatibility fix - OCR mask
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-18275-1095501638-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch avoids using a emtpy OCR mask for the initial power up. Since 
some cards do not like a one bit-mask a routine has been added which 
grows the mask to three bits (one extra bit on each side) if necessary.


--=_hades.drzeus.cx-18275-1095501638-0001-2
Content-Type: text/x-patch; name="mmc-ocr.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-ocr.patch"

Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 63)
+++ linux-wbsd/drivers/mmc/mmc.c	(revision 64)
@@ -300,6 +300,31 @@
 	return ocr;
 }
 
+/*
+ * Calculate a OCR mask to use for initial scanning.
+ * All zeroes and all ones cannot be used with some cards.
+ * Just on bit cannot be used either so extend the OCR
+ * if needed.
+ */
+
+static u32 mmc_select_scan_ocr(struct mmc_host *host)
+{
+	u32 ocr;
+
+	ocr = host->ocr_avail;
+
+	/* Check if we have more than one bit */
+	if (ocr & (ocr << 1))
+		return ocr;
+	if (ocr & (ocr >> 1))
+		return ocr;
+
+	/* Extend the mask to surrounding bits */
+	ocr |= (ocr << 1) | (ocr >> 1);
+
+	return ocr;
+}
+
 static void mmc_decode_cid(struct mmc_cid *cid, u32 *resp)
 {
 	memset(cid, 0, sizeof(struct mmc_cid));
@@ -589,7 +614,9 @@
 
 		mmc_power_up(host);
 
-		err = mmc_send_op_cond(host, 0, &ocr);
+		ocr = mmc_select_scan_ocr(host);
+
+		err = mmc_send_op_cond(host, ocr, &ocr);
 		if (err != MMC_ERR_NONE)
 			return;
 

--=_hades.drzeus.cx-18275-1095501638-0001-2--
