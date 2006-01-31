Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWAaVD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWAaVD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWAaVD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:03:59 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:65224 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751487AbWAaVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:03:58 -0500
Message-Id: <20060131202547.535444000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Date: Tue, 31 Jan 2006 16:16:41 -0400
From: Carlos Aguiar <carlos.aguiar@indt.org.br>
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 5/6] Add MMC password protection (lock/unlock) support V4
Content-Disposition: inline; filename=mmc_omap_blklen.diff
X-OriginalArrivalTime: 31 Jan 2006 20:25:51.0911 (UTC) FILETIME=[87A8B370:01C626A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC_LOCK_UNLOCK command requires the block length to be exactly the
password length + 2 bytes, but hardware-specific drivers force a "power of 2"
block size.

This patch sends the exact block size (password + 2 bytes) to the host. OMAP
specific.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-01-31 15:17:44.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-01-31 15:22:33.000000000 -0400
@@ -888,8 +888,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
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
