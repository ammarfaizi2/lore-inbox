Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbVLRTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbVLRTQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLRTQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:16:36 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:19534 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932708AbVLRTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:16:36 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-rc5-mm3 2/3] SPI, mtd_dataflash updates
Date: Sun, 18 Dec 2005 10:39:52 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4zapD6dUl99m9Wi"
Message-Id: <200512181039.52933.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4zapD6dUl99m9Wi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Mostly getting rid of some #ifdeffery; maybe the MTD folk would
like such cleanup in other mapping drivers?

- Dave

--Boundary-00=_4zapD6dUl99m9Wi
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi-dataflash-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi-dataflash-update.patch"

This is a minor cleanup of the MTD DataFlash driver, most notably
removing inlined #ifdeffery by defining a new mtd_has_partitions()
test.  Maybe the MTD folk would want to pull in that test, to help
clean up some of the other mapping-aware drivers.

It also moves the Kconfig entry so that this driver isn't presented
as yet another M-Systems disk-on-chip product.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- mm3.orig.orig/drivers/mtd/devices/mtd_dataflash.c	2005-12-18 10:18:38.000000000 -0800
+++ mm3.orig/drivers/mtd/devices/mtd_dataflash.c	2005-12-18 10:18:51.000000000 -0800
@@ -96,6 +96,12 @@ struct dataflash {
 	struct mtd_info		mtd;
 };
 
+#ifdef CONFIG_MTD_PARTITIONS
+#define	mtd_has_partitions()	(1)
+#else
+#define	mtd_has_partitions()	(0)
+#endif
+
 /* ......................................................................... */
 
 /*
@@ -477,8 +483,7 @@ add_dataflash(struct spi_device *spi, ch
 	dev_info(&spi->dev, "%s (%d KBytes)\n", name, device->size/1024);
 	dev_set_drvdata(&spi->dev, priv);
 
-#ifdef CONFIG_MTD_PARTITIONS
-	{
+	if (mtd_has_partitions()) {
 		struct mtd_partition	*parts;
 		int			nr_parts = 0;
 
@@ -497,12 +502,10 @@ add_dataflash(struct spi_device *spi, ch
 			priv->partitioned = 1;
 			return add_mtd_partitions(device, parts, nr_parts);
 		}
-	}
-#else
-	if (pdata->nr_parts)
+	} else if (pdata->nr_parts)
 		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
 				pdata->nr_parts, device->name);
-#endif
+
 	return add_mtd_device(device) == 1 ? -ENODEV : 0;
 }
 
@@ -570,17 +573,6 @@ static int __devinit dataflash_probe(str
 		DEBUG(MTD_DEBUG_LEVEL1, "%s: add_dataflash --> %d\n",
 				spi->dev.bus_id, status);
 
-#ifdef	DATAFLASH_TEST
-	else {
-		struct dataflash	*flash;
-
-		flash = dev_get_drvdata(&spi->dev);
-
-		dataflash_test1(flash);
-		dataflash_test2(flash);
-	}
-#endif
-
 	return status;
 }
 
@@ -591,11 +583,9 @@ static int __devexit dataflash_remove(st
 
 	DEBUG(MTD_DEBUG_LEVEL1, "%s: remove\n", spi->dev.bus_id);
 
-#ifdef CONFIG_MTD_PARTITIONS
-	if (flash->partitioned)
+	if (mtd_has_partitions() && flash->partitioned)
 		status = del_mtd_partitions(&flash->mtd);
 	else
-#endif
 		status = del_mtd_device(&flash->mtd);
 	if (status == 0)
 		kfree(flash);
--- mm3.orig.orig/drivers/mtd/devices/Kconfig	2005-12-18 10:18:38.000000000 -0800
+++ mm3.orig/drivers/mtd/devices/Kconfig	2005-12-18 10:18:51.000000000 -0800
@@ -47,6 +47,14 @@ config MTD_MS02NV
 	  accelerator.  Say Y here if you have a DECstation 5000/2x0 or a
 	  DECsystem 5900 equipped with such a module.
 
+config MTD_DATAFLASH
+	tristate "Support for AT45xxx DataFlash"
+	depends on MTD && SPI_MASTER && EXPERIMENTAL
+	help
+	  This enables access to AT45xxx DataFlash chips, using SPI.
+	  Sometimes DataFlash chips are packaged inside MMC-format
+	  cards; at this writing, the MMC stack won't handle those.
+
 config MTD_SLRAM
 	tristate "Uncached system RAM"
 	depends on MTD
@@ -255,13 +263,5 @@ config MTD_DOCPROBE_55AA
 	  LinuxBIOS or if you need to recover a DiskOnChip Millennium on which
 	  you have managed to wipe the first block.
 
-config MTD_DATAFLASH
-	tristate "Support for AT45xxx DataFlash"
-	depends on MTD && SPI_MASTER && EXPERIMENTAL
-	help
-	  This enables access to AT45xxx DataFlash chips, using SPI.
-	  Sometimes DataFlash chips are packaged inside MMC-format
-	  cards; at this writing, the MMC stack won't handle those.
-
 endmenu
 

--Boundary-00=_4zapD6dUl99m9Wi--
