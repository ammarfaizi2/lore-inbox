Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVL1Sy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVL1Sy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVL1Sy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:54:26 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:47200 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S964869AbVL1SyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:54:25 -0500
Message-Id: <20051228185413.149124000@localhost.localdomain>
References: <20051228184014.571997000@localhost.localdomain>
Date: Wed, 28 Dec 2005 14:40:19 -0400
From: Anderson Lizardo <anderson.lizardo@indt.org.br>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 5/5] Add MMC password protection (lock/unlock) support V2
Content-Disposition: inline; filename=mmc_omap_blklen.diff
X-OriginalArrivalTime: 28 Dec 2005 18:53:52.0595 (UTC) FILETIME=[0BD86A30:01C60BE0]
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

Index: linux-2.6.15-rc4-omap1/drivers/mmc/omap.c
===================================================================
--- linux-2.6.15-rc4-omap1.orig/drivers/mmc/omap.c	2005-12-28 14:30:06.000000000 -0400
+++ linux-2.6.15-rc4-omap1/drivers/mmc/omap.c	2005-12-28 14:31:42.000000000 -0400
@@ -889,8 +889,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
 		return;
 	}
 
-
-	block_size = 1 << data->blksz_bits;
+	/*  password protection: we need to send the exact block size to the
+	 *  card (password + 2), not a power of two */
+	if (req->cmd->opcode == MMC_LOCK_UNLOCK)
+		block_size = data->sg[0].length;
+	else
+		block_size = 1 << data->blksz_bits;
 
 	OMAP_MMC_WRITE(host->base, NBLK, data->blocks - 1);
 	OMAP_MMC_WRITE(host->base, BLEN, block_size - 1);

--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
