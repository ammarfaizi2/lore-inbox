Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWAIWQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWAIWQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWAIWQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:16:27 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:59064 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751340AbWAIWQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:16:26 -0500
Message-ID: <43C2E0E6.30600@indt.org.br>
Date: Mon, 09 Jan 2006 18:17:10 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 5/5] Add MMC password protection (lock/unlock) support V3
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050803020203070408050701"
X-OriginalArrivalTime: 09 Jan 2006 22:15:31.0472 (UTC) FILETIME=[344B8900:01C6156A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050803020203070408050701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit







--------------050803020203070408050701
Content-Type: text/x-patch;
 name="mmc_omap_blklen.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_blklen.diff"

The MMC_LOCK_UNLOCK command requires the block length to be exactly the
password length + 2 bytes, but hardware-specific drivers force a "power of 2"
block size.

This patch sends the exact block size (password + 2 bytes) to the host. OMAP
specific.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/omap.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/omap.c	2005-12-27 17:42:49.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/omap.c	2005-12-27 17:43:57.000000000 -0400
@@ -889,8 +889,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
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

--------------050803020203070408050701--
