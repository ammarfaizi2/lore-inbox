Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVLNNeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVLNNeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVLNNeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:34:19 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:19140 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932521AbVLNNeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:34:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=Q8krrxtkDctJaTUqQ5yPq+d5ZHkjeczT+rHY63WYSvSWHJaL4YOetVG7vWYYwAbgV51M5hTJiEbxdfEo+NKBdO/sfTjJaUMTuEgZFEXXUWwfz/1HPWcE9xs3vUSSnUxjpCm5/bSVuLmo4CRKSbsPSHJ1M9W/a833gdQhlyFaXTw=
Message-ID: <e55525570512140534m33c22498y9b1ee67f8dd029f5@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:34:16 -0400
From: Anderson Briglia <briglia.anderson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 5/5] [RFC] Add MMC password protection (lock/unlock) support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7279_10184456.1134567256915"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7279_10184456.1134567256915
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_7279_10184456.1134567256915
Content-Type: text/x-patch; name=mmc_omap_blklen.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmc_omap_blklen.diff"

The MMC_LOCK_UNLOCK command requires the block length to be exactly the
password length + 2 bytes, but hardware-specific drivers force a "power of 2"
block size.

This patch sends the exact block size (password + 2 bytes) to the host. OMAP
specific.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.14-omap2/drivers/mmc/omap.c
===================================================================
--- linux-2.6.14-omap2.orig/drivers/mmc/omap.c	2005-12-09 11:31:50.000000000 -0400
+++ linux-2.6.14-omap2/drivers/mmc/omap.c	2005-12-12 14:56:08.000000000 -0400
@@ -891,8 +891,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
 		return;
 	}
 
-
-	block_size = 1 << data->blksz_bits;
+	/*  password protection: we need to send the exact block size to the
+	 *  card (password + 2), not a 2-exponent. */
+	if (req->cmd->opcode == MMC_LOCK_UNLOCK)
+		block_size = data->sg[0].length;
+	else
+		block_size = 1 << data->blksz_bits;
 
 	OMAP_MMC_WRITE(host->base, NBLK, data->blocks - 1);
 	OMAP_MMC_WRITE(host->base, BLEN, block_size - 1);

--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil



------=_Part_7279_10184456.1134567256915--
