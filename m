Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVJ1HgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVJ1HgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVJ1HgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:36:18 -0400
Received: from [85.8.13.51] ([85.8.13.51]:52882 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965178AbVJ1HgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:36:17 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] wbsd suspend support
Date: Fri, 28 Oct 2005 09:36:23 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051028073622.4122.98642.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Proper handling of suspend/resume in the wbsd driver.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |  119 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1033,13 +1033,16 @@ static void wbsd_set_ios(struct mmc_host
 	}
 	else
 	{
-		setup &= ~WBSD_DAT3_H;
+		if (setup & WBSD_DAT3_H)
+		{
+			setup &= ~WBSD_DAT3_H;
 
-		/*
-		 * We cannot resume card detection immediatly
-		 * because of capacitance and delays in the chip.
-		 */
-		mod_timer(&host->ignore_timer, jiffies + HZ/100);
+			/*
+			 * We cannot resume card detection immediatly
+			 * because of capacitance and delays in the chip.
+			 */
+			mod_timer(&host->ignore_timer, jiffies + HZ/100);
+		}
 	}
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
 
@@ -1461,8 +1464,10 @@ static int __devinit wbsd_scan(struct wb
 		{
 			id = 0xFFFF;
 
-			outb(unlock_codes[j], config_ports[i]);
-			outb(unlock_codes[j], config_ports[i]);
+			host->config = config_ports[i];
+			host->unlock_code = unlock_codes[j];
+
+			wbsd_unlock_config(host);
 
 			outb(WBSD_CONF_ID_HI, config_ports[i]);
 			id = inb(config_ports[i] + 1) << 8;
@@ -1470,13 +1475,13 @@ static int __devinit wbsd_scan(struct wb
 			outb(WBSD_CONF_ID_LO, config_ports[i]);
 			id |= inb(config_ports[i] + 1);
 
+			wbsd_lock_config(host);
+
 			for (k = 0;k < sizeof(valid_ids)/sizeof(int);k++)
 			{
 				if (id == valid_ids[k])
 				{
 					host->chip_id = id;
-					host->config = config_ports[i];
-					host->unlock_code = unlock_codes[i];
 
 					return 0;
 				}
@@ -1487,13 +1492,14 @@ static int __devinit wbsd_scan(struct wb
 				DBG("Unknown hardware (id %x) found at %x\n",
 					id, config_ports[i]);
 			}
-
-			outb(LOCK_CODE, config_ports[i]);
 		}
 
 		release_region(config_ports[i], 2);
 	}
 
+	host->config = 0;
+	host->unlock_code = 0;
+
 	return -ENODEV;
 }
 
@@ -1695,8 +1701,10 @@ static void __devexit wbsd_release_resou
  * Configure the resources the chip should use.
  */
 
-static void __devinit wbsd_chip_config(struct wbsd_host* host)
+static void wbsd_chip_config(struct wbsd_host* host)
 {
+	wbsd_unlock_config(host);
+
 	/*
 	 * Reset the chip.
 	 */
@@ -1729,16 +1737,20 @@ static void __devinit wbsd_chip_config(s
 	 */
 	wbsd_write_config(host, WBSD_CONF_ENABLE, 1);
 	wbsd_write_config(host, WBSD_CONF_POWER, 0x20);
+
+	wbsd_lock_config(host);
 }
 
 /*
  * Check that configured resources are correct.
  */
 
-static int __devinit wbsd_chip_validate(struct wbsd_host* host)
+static int wbsd_chip_validate(struct wbsd_host* host)
 {
 	int base, irq, dma;
 
+	wbsd_unlock_config(host);
+
 	/*
 	 * Select SD/MMC function.
 	 */
@@ -1754,6 +1766,8 @@ static int __devinit wbsd_chip_validate(
 
 	dma = wbsd_read_config(host, WBSD_CONF_DRQ);
 
+	wbsd_lock_config(host);
+
 	/*
 	 * Validate against given configuration.
 	 */
@@ -1767,6 +1781,20 @@ static int __devinit wbsd_chip_validate(
 	return 1;
 }
 
+/*
+ * Powers down the SD function
+ */
+
+static void wbsd_chip_poweroff(struct wbsd_host* host)
+{
+	wbsd_unlock_config(host);
+
+	wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
+	wbsd_write_config(host, WBSD_CONF_ENABLE, 0);
+
+	wbsd_lock_config(host);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Devices setup and shutdown                                                *
@@ -1840,7 +1868,11 @@ static int __devinit wbsd_init(struct de
 	 */
 #ifdef CONFIG_PM
 	if (host->config)
+	{
+		wbsd_unlock_config(host);
 		wbsd_write_config(host, WBSD_CONF_PME, 0xA0);
+		wbsd_lock_config(host);
+	}
 #endif
 	/*
 	 * Allow device to initialise itself properly.
@@ -1881,16 +1913,11 @@ static void __devexit wbsd_shutdown(stru
 
 	mmc_remove_host(mmc);
 
+	/*
+	 * Power down the SD/MMC function.
+	 */
 	if (!pnp)
-	{
-		/*
-		 * Power down the SD/MMC function.
-		 */
-		wbsd_unlock_config(host);
-		wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
-		wbsd_write_config(host, WBSD_CONF_ENABLE, 0);
-		wbsd_lock_config(host);
-	}
+		wbsd_chip_poweroff(host);
 
 	wbsd_release_resources(host);
 
@@ -1951,23 +1978,59 @@ static void __devexit wbsd_pnp_remove(st
  */
 
 #ifdef CONFIG_PM
+
 static int wbsd_suspend(struct device *dev, pm_message_t state, u32 level)
 {
-	DBGF("Not yet supported\n");
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct wbsd_host *host;
+	int ret;
+
+	if (!mmc || (level != SUSPEND_DISABLE))
+		return 0;
+
+	DBG("Suspending...\n");
+
+	ret = mmc_suspend_host(mmc, state);
+	if (!ret)
+		return ret;
+
+	host = mmc_priv(mmc);
+
+	wbsd_chip_poweroff(host);
 
 	return 0;
 }
 
 static int wbsd_resume(struct device *dev, u32 level)
 {
-	DBGF("Not yet supported\n");
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct wbsd_host *host;
 
-	return 0;
+	if (!mmc || (level != RESUME_ENABLE))
+		return 0;
+
+	DBG("Resuming...\n");
+
+	host = mmc_priv(mmc);
+
+	wbsd_chip_config(host);
+
+	/*
+	 * Allow device to initialise itself properly.
+	 */
+	mdelay(5);
+
+	wbsd_init_device(host);
+
+	return mmc_resume_host(mmc);
 }
-#else
+
+#else /* CONFIG_PM */
+
 #define wbsd_suspend NULL
 #define wbsd_resume NULL
-#endif
+
+#endif /* CONFIG_PM */
 
 static struct platform_device *wbsd_device;
 

