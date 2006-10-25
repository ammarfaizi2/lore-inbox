Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423062AbWJYGmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423062AbWJYGmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423069AbWJYGmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:42:01 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:13698 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1423062AbWJYGmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:42:00 -0400
Date: Wed, 25 Oct 2006 09:37:41 +0300
From: Timo Teras <timo.teras@solidboot.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Timo Teras <timo.teras@solidboot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MMC: Poll card status after rescanning cards
Message-ID: <20061025063741.GA18599@mail.solidboot.com>
References: <20061016090609.GB17596@mail.solidboot.com> <453B4005.8080501@drzeus.cx> <20061024101458.GA17024@mail.solidboot.com> <453E4654.1030809@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453E4654.1030809@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some broken cards seem to process CMD1 even in stand-by state. The result is
that the card replies with ILLEGAL_COMMAND error for the next command sent
after rescanning. Currently the next command is select card, which would
return the error. But CMD7 does actually succeed and retries of the command
will timeout. The workaround is to poll card status after CMD1 to clear the
pending error.

Signed-off-by: Timo Teras <timo.teras@solidboot.com>
---
 drivers/mmc/mmc.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ee8863c..c236646 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1178,14 +1178,29 @@ static void mmc_rescan(void *data)
 {
 	struct mmc_host *host = data;
 	struct list_head *l, *n;
+	unsigned char power_mode;
 
 	mmc_claim_host(host);
 
-	if (host->ios.power_mode == MMC_POWER_ON)
+	/*
+	 * Check for removed cards and newly inserted ones. We check for
+	 * removed cards first so we can intelligently re-select the VDD.
+	 */
+	power_mode = host->ios.power_mode;
+	if (power_mode == MMC_POWER_ON)
 		mmc_check_cards(host);
 
 	mmc_setup(host);
 
+	/*
+	 * Some broken cards process CMD1 even in stand-by state. There is
+	 * no reply, but an ILLEGAL_COMMAND error is cached and returned
+	 * after next command. We poll for card status here to clear any
+	 * possibly pending error.
+	 */
+	if (power_mode == MMC_POWER_ON)
+		mmc_check_cards(host);
+
 	if (!list_empty(&host->cards)) {
 		/*
 		 * (Re-)calculate the fastest clock rate which the
-- 
1.4.1.1

