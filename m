Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWAGXCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWAGXCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWAGXCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:02:15 -0500
Received: from [85.8.13.51] ([85.8.13.51]:49345 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1161048AbWAGXCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:02:13 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] wbsd pnp suspend
Date: Sun, 08 Jan 2006 00:02:01 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060107230201.28473.19968.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the wbsd driver to use the new suspend/resume functions added to
the PnP layer.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |  106 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index 4f13bd2..60afc12 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1980,37 +1980,53 @@ static void __devexit wbsd_pnp_remove(st
 
 #ifdef CONFIG_PM
 
-static int wbsd_suspend(struct platform_device *dev, pm_message_t state)
+static int wbsd_suspend(struct wbsd_host *host, pm_message_t state)
+{
+	BUG_ON(host == NULL);
+
+	return mmc_suspend_host(host->mmc, state);
+}
+
+static int wbsd_resume(struct wbsd_host *host)
+{
+	BUG_ON(host == NULL);
+
+	wbsd_init_device(host);
+
+	return mmc_resume_host(host->mmc);
+}
+
+static int wbsd_platform_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = platform_get_drvdata(dev);
 	struct wbsd_host *host;
 	int ret;
 
-	if (!mmc)
+	if (mmc == NULL)
 		return 0;
 
-	DBG("Suspending...\n");
-
-	ret = mmc_suspend_host(mmc, state);
-	if (!ret)
-		return ret;
+	DBGF("Suspending...\n");
 
 	host = mmc_priv(mmc);
 
+	ret = wbsd_suspend(host, state);
+	if (ret)
+		return ret;
+
 	wbsd_chip_poweroff(host);
 
 	return 0;
 }
 
-static int wbsd_resume(struct platform_device *dev)
+static int wbsd_platform_resume(struct platform_device *dev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(dev);
 	struct wbsd_host *host;
 
-	if (!mmc)
+	if (mmc == NULL)
 		return 0;
 
-	DBG("Resuming...\n");
+	DBGF("Resuming...\n");
 
 	host = mmc_priv(mmc);
 
@@ -2021,15 +2037,70 @@ static int wbsd_resume(struct platform_d
 	 */
 	mdelay(5);
 
-	wbsd_init_device(host);
+	return wbsd_resume(host);
+}
+
+#ifdef CONFIG_PNP
+
+static int wbsd_pnp_suspend(struct pnp_dev *pnp_dev, pm_message_t state)
+{
+	struct mmc_host *mmc = dev_get_drvdata(&pnp_dev->dev);
+	struct wbsd_host *host;
+
+	if (mmc == NULL)
+		return 0;
+
+	DBGF("Suspending...\n");
+
+	host = mmc_priv(mmc);
 
-	return mmc_resume_host(mmc);
+	return wbsd_suspend(host, state);
 }
 
+static int wbsd_pnp_resume(struct pnp_dev *pnp_dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(&pnp_dev->dev);
+	struct wbsd_host *host;
+
+	if (mmc == NULL)
+		return 0;
+
+	DBGF("Resuming...\n");
+
+	host = mmc_priv(mmc);
+
+	/*
+	 * See if chip needs to be configured.
+	 */
+	if (host->config != 0)
+	{
+		if (!wbsd_chip_validate(host))
+		{
+			printk(KERN_WARNING DRIVER_NAME
+				": PnP active but chip not configured! "
+				"You probably have a buggy BIOS. "
+				"Configuring chip manually.\n");
+			wbsd_chip_config(host);
+		}
+	}
+
+	/*
+	 * Allow device to initialise itself properly.
+	 */
+	mdelay(5);
+
+	return wbsd_resume(host);
+}
+
+#endif /* CONFIG_PNP */
+
 #else /* CONFIG_PM */
 
-#define wbsd_suspend NULL
-#define wbsd_resume NULL
+#define wbsd_platform_suspend NULL
+#define wbsd_platform_resume NULL
+
+#define wbsd_pnp_suspend NULL
+#define wbsd_pnp_resume NULL
 
 #endif /* CONFIG_PM */
 
@@ -2039,8 +2110,8 @@ static struct platform_driver wbsd_drive
 	.probe		= wbsd_probe,
 	.remove		= __devexit_p(wbsd_remove),
 
-	.suspend	= wbsd_suspend,
-	.resume		= wbsd_resume,
+	.suspend	= wbsd_platform_suspend,
+	.resume		= wbsd_platform_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
 	},
@@ -2053,6 +2124,9 @@ static struct pnp_driver wbsd_pnp_driver
 	.id_table	= pnp_dev_table,
 	.probe		= wbsd_pnp_probe,
 	.remove		= __devexit_p(wbsd_pnp_remove),
+
+	.suspend	= wbsd_pnp_suspend,
+	.resume		= wbsd_pnp_resume,
 };
 
 #endif /* CONFIG_PNP */

