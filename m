Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757376AbWKWPqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbWKWPqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757396AbWKWPqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:46:04 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:14984 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1757376AbWKWPqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:46:03 -0500
Date: Thu, 23 Nov 2006 18:46:06 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: drzeus-mmc@drzeus.cx
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix random SD/MMC card recognition failures on ARM
 Versatile
Message-Id: <20061123184606.bb203ae6.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pierre,

currently sometimes the SD/MMC card inserted results in recognition failure on ARM Versatile board:

   <<<Plug in MMC card>>>

root@versatile:~# mmcblk0: mmc0:0001 SDMB-32 31360KiB
 mmcblk0:<3>mmcblk0: error 3 transferring data
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
mmcblk0: error 3 transferring data
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
 unable to read partition table

This patch fixes the problem.

 drivers/mmc/mmci.c |    2 ++
 1 file changed, 2 insertions(+)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6.18/drivers/mmc/mmci.c
===================================================================
--- linux-2.6.18.orig/drivers/mmc/mmci.c
+++ linux-2.6.18/drivers/mmc/mmci.c
@@ -41,6 +41,8 @@ static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
 	writel(0, host->base + MMCICOMMAND);
+	writel(0, host->base + MMCIDATACTRL);
+	writel(0, host->base + MMCIMASK1);
 
 	host->mrq = NULL;
 	host->cmd = NULL;
