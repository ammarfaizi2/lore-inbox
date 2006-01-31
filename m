Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWAaNiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWAaNiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAaNiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:38:17 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:26803 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1750817AbWAaNiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:38:16 -0500
Message-ID: <43DF67AA.1040509@indt.org.br>
Date: Tue, 31 Jan 2006 09:35:38 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: [patch 2/5] MMC OMAP driver
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2006 13:33:55.0878 (UTC) FILETIME=[FBC15C60:01C6266A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ATP and Transcend cards failing repeatedly in the card select command
(CMD7) due to illegal instruction after CMD2.  Doing an extra status inquiry
when leaving the card identification mode seems to fix this problem.
The attached patch does the extra probing in mmc_setup() during
low clock which is perhaps an overkill. One could do it also in
mmc_rescan() after switching back to higher clock.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc.c	2006-01-30 10:29:29.000000000 -0400
+++ linux-2.6.15-mmc_omap/drivers/mmc/mmc.c	2006-01-30 10:29:31.000000000 -0400
@@ -1087,6 +1087,14 @@ static void mmc_setup(struct mmc_host *h
 	 */
 	host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
 	host->ops->set_ios(host, &host->ios);
+	
+	/*
+	 * Some already detected cards get confused in the card identification
+	 * mode and futher commands can fail. Doing an extra status inquiry
+	 * after the identification mode seems to get cards back to their
+	 * senses.
+	 */
+	mmc_check_cards(host);

 	mmc_read_csds(host);

