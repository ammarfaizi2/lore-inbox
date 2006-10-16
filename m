Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWJPJIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWJPJIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbWJPJIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:08:07 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:48271 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1161252AbWJPJIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:08:06 -0400
Date: Mon, 16 Oct 2006 12:06:09 +0300
From: Timo Teras <timo.teras@solidboot.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: MMC: When rescanning cards check existing cards after mmc_setup()
Message-ID: <20061016090609.GB17596@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some broken cards seem to process CMD1 even in stand-by state. The result is
that the card replies with ILLEGAL_COMMAND error for the next command sent
after rescanning. Currently the next command is select card, which would
return the error. But the CMD7 does actually succeed and retries of the
command will timeout. The solution is to poll card status after the CMD1
which clears the cached error.

Signed-off-by: Timo Teras <timo.teras@solidboot.com>

---

 drivers/mmc/mmc.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

97675ada7049d12523aa9e9908d4613dfd333641
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ee8863c..3324b6e 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1178,14 +1178,17 @@ static void mmc_rescan(void *data)
 {
 	struct mmc_host *host = data;
 	struct list_head *l, *n;
+	unsigned char power_mode;
 
 	mmc_claim_host(host);
 
-	if (host->ios.power_mode == MMC_POWER_ON)
-		mmc_check_cards(host);
+	power_mode = host->ios.power_mode;
 
 	mmc_setup(host);
 
+	if (power_mode == MMC_POWER_ON)
+		mmc_check_cards(host);
+
 	if (!list_empty(&host->cards)) {
 		/*
 		 * (Re-)calculate the fastest clock rate which the
-- 
1.2.3.g90cc1

