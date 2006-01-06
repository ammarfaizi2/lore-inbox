Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965353AbWAFXk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbWAFXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965355AbWAFXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:40:29 -0500
Received: from [85.8.13.51] ([85.8.13.51]:36289 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965353AbWAFXk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:40:28 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Minimise protocol awareness in Au1x00 driver
Date: Sat, 07 Jan 2006 00:40:13 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk, jordan.crouse@amd.com
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060106234012.31480.88314.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Au1x00 MMC/SD driver currently contains switch statements based on
protocol opcodes, not on desired behaviour.

Unfortunately the AMD specification is not detailed enough to determine
how the controller will behave for the response settings. For now, it will
have to suffice to warn when we have an unknown response type.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/au1xmmc.c |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index aaf0463..23cdcac 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -207,26 +207,33 @@ static int au1xmmc_send_command(struct a
 	case MMC_RSP_R3:
 		mmccmd |= SD_CMD_RT_3;
 		break;
+	default:
+		printk(KERN_ERR "%s: Unsupported response type (%x).\n",
+			mmc_hostname(host->mmc), cmd->flags);
+		return MMC_ERR_INVALID;
 	}
 
-	switch(cmd->opcode) {
-	case MMC_READ_SINGLE_BLOCK:
-	case SD_APP_SEND_SCR:
-		mmccmd |= SD_CMD_CT_2;
-		break;
-	case MMC_READ_MULTIPLE_BLOCK:
-		mmccmd |= SD_CMD_CT_4;
-		break;
-	case MMC_WRITE_BLOCK:
-		mmccmd |= SD_CMD_CT_1;
-		break;
-
-	case MMC_WRITE_MULTIPLE_BLOCK:
-		mmccmd |= SD_CMD_CT_3;
-		break;
-	case MMC_STOP_TRANSMISSION:
+	if (host->mrq->data && (host->mrq->data->stop == cmd))
 		mmccmd |= SD_CMD_CT_7;
-		break;
+	else if (!cmd->data)
+		mmccmd |= SD_CMD_CT_0;
+	else {
+		if (cmd->data->stop) {
+			if (cmd->data->flags & MMC_DATA_WRITE)
+				mmccmd |= SD_CMD_CT_3;
+			else
+				mmccmd |= SD_CMD_CT_4;
+		} else if (cmd->data->blocks == 1) {
+			if (cmd->data->flags & MMC_DATA_WRITE)
+				mmccmd |= SD_CMD_CT_1;
+			else
+				mmccmd |= SD_CMD_CT_2;
+		} else {
+			printk(KERN_ERR "%s: Multi-block transfer without "
+				"a stop command is not supported.\n",
+				mmc_hostname(host->mmc));
+			return MMC_ERR_INVALID;
+		}
 	}
 
 	au_writel(cmd->arg, HOST_CMDARG(host));

