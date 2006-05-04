Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWEDH0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWEDH0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWEDH0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:26:39 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49568 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1751421AbWEDH0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:26:39 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 4 May 2006 00:26:30 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: MMC: 2/2 Fix MMC_POWER_UP on some OMAP boards
Message-ID: <20060504072630.GF8664@atomide.com>
References: <20060504072439.GE8664@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20060504072439.GE8664@atomide.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-mmc-16xx-startup-clock

MMC spec says that we must not enable clock prior to the power
stabilizing. But at least omap16xx needs clock divisor configured
during MMC_POWER_UP.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -899,9 +899,16 @@ static void mmc_omap_set_ios(struct mmc_
 	int dsor;
 	int realclock, i;
 
-	realclock = ios->clock;
+	/* According to the MMC spec we must not enable clock prior to
+	 * power stabilizing. But at least omap16xx needs clock dsor
+	 * configured during MMC_POWER_UP.
+	 */
+	if ((ios->power_mode == MMC_POWER_UP) && (ios->clock == 0))
+		realclock = mmc->f_min;
+	else
+		realclock = ios->clock;
 
-	if (ios->clock == 0)
+	if (realclock == 0)
 		dsor = 0;
 	else {
 		int func_clk_rate = clk_get_rate(host->fclk);

--1SQmhf2mF2YjsYvc--
