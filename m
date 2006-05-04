Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWEDHYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWEDHYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWEDHYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:24:53 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:7067 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750740AbWEDHYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:24:52 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 4 May 2006 00:24:40 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: MMC: 1/2 Make OMAP MMC work
Message-ID: <20060504072439.GE8664@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-mmc-compile

This patch makes OMAP MMC work again:

- Fix compile errors
- Do not ioremap base as it is already statically mapped
- Clean-up platform device handling
- Fix compile warnings

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -162,8 +162,8 @@ static u64 mmc1_dmamask = 0xffffffff;
 
 static struct resource mmc1_resources[] = {
 	{
-		.start		= IO_ADDRESS(OMAP_MMC1_BASE),
-		.end		= IO_ADDRESS(OMAP_MMC1_BASE) + 0x7f,
+		.start		= OMAP_MMC1_BASE,
+		.end		= OMAP_MMC1_BASE + 0x7f,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
@@ -191,8 +191,8 @@ static u64 mmc2_dmamask = 0xffffffff;
 
 static struct resource mmc2_resources[] = {
 	{
-		.start		= IO_ADDRESS(OMAP_MMC2_BASE),
-		.end		= IO_ADDRESS(OMAP_MMC2_BASE) + 0x7f,
+		.start		= OMAP_MMC2_BASE,
+		.end		= OMAP_MMC2_BASE + 0x7f,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index becb3c6..7c8b6ce 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -61,6 +61,7 @@ struct mmc_omap_host {
 	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	struct clk *		iclk;
 	struct clk *		fclk;
+	struct resource		*res;
 	void __iomem		*base;
 	int			irq;
 	unsigned char		bus_mode;
@@ -340,8 +341,6 @@ static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
 	int n;
-	void __iomem *reg;
-	u16 *p;
 
 	if (host->buffer_bytes_left == 0) {
 		host->sg_idx++;
@@ -658,8 +657,8 @@ static void mmc_omap_dma_cb(int lch, u16
 	struct mmc_data *mmcdat = host->data;
 
 	if (unlikely(host->dma_ch < 0)) {
-		dev_err(mmc_dev(host->mmc), "DMA callback while DMA not
-				enabled\n");
+		dev_err(mmc_dev(host->mmc),
+			"DMA callback while DMA not enabled\n");
 		return;
 	}
 	/* FIXME: We really should do something to _handle_ the errors */
@@ -973,20 +972,20 @@ static int __init mmc_omap_probe(struct 
 	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
 	struct mmc_host *mmc;
 	struct mmc_omap_host *host = NULL;
+	struct resource *r;
 	int ret = 0;
+	int irq;
 	
-	if (platform_get_resource(pdev, IORESOURCE_MEM, 0) ||
-			platform_get_irq(pdev, IORESOURCE_IRQ, 0)) {
-		dev_err(&pdev->dev, "mmc_omap_probe: invalid resource type\n");
-		return -ENODEV;
-	}
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!r || irq < 0)
+		return -ENXIO;
 
-	if (!request_mem_region(pdev->resource[0].start,
+	r = request_mem_region(pdev->resource[0].start,
 				pdev->resource[0].end - pdev->resource[0].start + 1,
-				pdev->name)) {
-		dev_dbg(&pdev->dev, "request_mem_region failed\n");
+			       pdev->name);
+	if (!r)
 		return -EBUSY;
-	}
 
 	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
 	if (!mmc) {
@@ -1003,6 +1002,8 @@ static int __init mmc_omap_probe(struct 
 	host->dma_timer.data = (unsigned long) host;
 
 	host->id = pdev->id;
+	host->res = r;
+	host->irq = irq;
 
 	if (cpu_is_omap24xx()) {
 		host->iclk = clk_get(&pdev->dev, "mmc_ick");
@@ -1032,13 +1033,9 @@ static int __init mmc_omap_probe(struct 
 	host->dma_ch = -1;
 
 	host->irq = pdev->resource[1].start;
-	host->base = ioremap(pdev->res.start, SZ_4K);
-	if (!host->base) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	host->base = (void __iomem*)IO_ADDRESS(r->start);
 
-	 if (minfo->wire4)
+	if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	mmc->ops = &mmc_omap_ops;
@@ -1057,8 +1054,8 @@ static int __init mmc_omap_probe(struct 
 
 	if (host->power_pin >= 0) {
 		if ((ret = omap_request_gpio(host->power_pin)) != 0) {
-			dev_err(mmc_dev(host->mmc), "Unable to get GPIO
-					pin for MMC power\n");
+			dev_err(mmc_dev(host->mmc),
+				"Unable to get GPIO pin for MMC power\n");
 			goto out;
 		}
 		omap_set_gpio_direction(host->power_pin, 0);
@@ -1100,7 +1097,7 @@ static int __init mmc_omap_probe(struct 
 				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 		}
 		if (ret) {
-			dev_wan(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
+			dev_warn(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
 			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;

--9zSXsLTf0vkW971A--
