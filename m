Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWEDJcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWEDJcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWEDJcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:32:06 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:43669 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751459AbWEDJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:32:04 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 4 May 2006 02:31:53 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       Carlos Aguiar <carlos.aguiar@indt.org.br>,
       Juha Yrjola <juha.yrjola@nokia.com>
Subject: Re: MMC: 2/2 Fix MMC_POWER_UP on some OMAP boards
Message-ID: <20060504093152.GJ8664@atomide.com>
References: <20060504072439.GE8664@atomide.com> <20060504072630.GF8664@atomide.com> <20060504075433.GA2839@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20060504075433.GA2839@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King <rmk+lkml@arm.linux.org.uk> [060504 00:54]:
> On Thu, May 04, 2006 at 12:26:30AM -0700, Tony Lindgren wrote:
> > MMC spec says that we must not enable clock prior to the power
> > stabilizing. But at least omap16xx needs clock divisor configured
> > during MMC_POWER_UP.
> 
> In which case it's probably better to treat MMC_POWER_UP the same as
> MMC_POWER_OFF and just use MMC_POWER_ON and wait for your host to
> complete it's power stabilisation.  No need for this additional
> complexity.

Nice, that makes things cleaner. Here's the patch:


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-mmc-powerup

Change OMAP MMC to use MMC_POWER_UP to power-up the card,
and set clock divisor with MMC_POWER_ON. Also separate
clock divisor calculation into a separate function.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -893,48 +893,56 @@ static void mmc_omap_power(struct mmc_om
 	}
 }
 
-static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+static inline int mmc_omap_calc_divisor(struct mmc_host *mmc,
+					struct mmc_ios *ios)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
+	int func_clk_rate = clk_get_rate(host->fclk);
 	int dsor;
-	int realclock, i;
-
-	realclock = ios->clock;
 
 	if (ios->clock == 0)
-		dsor = 0;
-	else {
-		int func_clk_rate = clk_get_rate(host->fclk);
-
-		dsor = func_clk_rate / realclock;
-		if (dsor < 1)
-			dsor = 1;
+		return 0;
 
-		if (func_clk_rate / dsor > realclock)
-			dsor++;
+	dsor = func_clk_rate / ios->clock;
+	if (dsor < 1)
+		dsor = 1;
 
-		if (dsor > 250)
-			dsor = 250;
+	if (func_clk_rate / dsor > ios->clock)
 		dsor++;
 
-		if (ios->bus_width == MMC_BUS_WIDTH_4)
-			dsor |= 1 << 15;
-	}
+	if (dsor > 250)
+		dsor = 250;
+	dsor++;
+
+	if (ios->bus_width == MMC_BUS_WIDTH_4)
+		dsor |= 1 << 15;
+
+	return dsor;
+}
+
+static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	int dsor;
+	int i;
+
+	dsor = mmc_omap_calc_divisor(mmc, ios);
+	host->bus_mode = ios->bus_mode;
+	host->hw_bus_mode = host->bus_mode;
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_omap_power(host, 0);
 		break;
 	case MMC_POWER_UP:
-	case MMC_POWER_ON:
+		/* Cannot touch dsor yet, just power up MMC */
 		mmc_omap_power(host, 1);
-		dsor |= 1<<11;
+		return;
+	case MMC_POWER_ON:
+		dsor |= 1 << 11;
 		break;
 	}
 
-	host->bus_mode = ios->bus_mode;
-	host->hw_bus_mode = host->bus_mode;
-
 	clk_enable(host->fclk);
 
 	/* On insanely high arm_per frequencies something sometimes
@@ -943,11 +951,12 @@ static void mmc_omap_set_ios(struct mmc_
 	 * Writing to the CON register twice seems to do the trick. */
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host->base, CON, dsor);
-	if (ios->power_mode == MMC_POWER_UP) {
+
+	if (ios->power_mode == MMC_POWER_ON) {
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host->base, IE, 0);
 		OMAP_MMC_WRITE(host->base, STAT, 0xffff);
-		OMAP_MMC_WRITE(host->base, CMD, 1<<7);
+		OMAP_MMC_WRITE(host->base, CMD, 1 << 7);
 		while (0 == (OMAP_MMC_READ(host->base, STAT) & 1));
 		OMAP_MMC_WRITE(host->base, STAT, 1);
 	}

--VV4b6MQE+OnNyhkM--
