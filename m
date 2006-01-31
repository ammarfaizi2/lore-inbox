Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWAaOTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWAaOTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWAaOTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:19:35 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:29513 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1750876AbWAaOTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:19:35 -0500
Message-ID: <43DF688E.7020805@indt.org.br>
Date: Tue, 31 Jan 2006 09:39:26 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: [patch 5/5] MMC OMAP driver
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2006 13:37:44.0075 (UTC) FILETIME=[83C575B0:01C6266B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch by Tuukka Tikkanen provides a write work-around for broken
MMC cards that set READY_FOR_DATA when it's not set.

Signed-off-by: Tuukka Tikkanen

Index: linux-2.6.15-mmc_omap/drivers/mmc/Kconfig
===================================================================
--- linux-2.6.15-mmc_omap.orig/drivers/mmc/Kconfig	2006-01-26 17:03:43.000000000 -0400
+++ linux-2.6.15-mmc_omap/drivers/mmc/Kconfig	2006-01-26 17:04:57.000000000 -0400
@@ -29,6 +29,14 @@ config MMC_BLOCK
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.

+config MMC_BLOCK_BROKEN_RFD
+	boolean "Write work-around for incompatible cards"
+	depends on MMC_BLOCK
+	default n
+	help
+	  Say y here if your MMC card fails write operations. Some cards
+  	  lie about being ready to receive data while they actually are not.
+
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA && MMC
Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc_block.c
===================================================================
--- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc_block.c	2006-01-26 17:04:52.000000000 -0400
+++ linux-2.6.15-mmc_omap/drivers/mmc/mmc_block.c	2006-01-26 17:04:57.000000000 -0400
@@ -234,6 +234,13 @@ static int mmc_blk_issue_rq(struct mmc_q
 				       req->rq_disk->disk_name, err);
 				goto cmd_err;
 			}
+#ifdef CONFIG_MMC_BLOCK_BROKEN_RFD
+			/* Work-around for broken cards setting READY_FOR_DATA
+			 * when not actually ready.
+			 */
+			if (R1_CURRENT_STATE(cmd.resp[0]) == 7)
+				cmd.resp[0] &= ~R1_READY_FOR_DATA;
+#endif
 		} while (!(cmd.resp[0] & R1_READY_FOR_DATA));

 #if 0
