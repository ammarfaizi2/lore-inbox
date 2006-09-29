Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161314AbWI2Rwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbWI2Rwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWI2Rwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:52:51 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:26109 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751186AbWI2Rwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:52:49 -0400
Date: Sat, 30 Sep 2006 02:54:57 +0900 (JST)
Message-Id: <20060930.025457.93019373.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, akpm@osdl.org
Subject: [PATCH] RTC: rtc-ds1553, rtc-ds1742 update
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check return value of sysfs_create_bin_file().
Fix polarity of RTC_BATT_FLAG bit in DS1742.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 2090014..b55af5a 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -18,7 +18,7 @@ #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#define DRV_VERSION "0.1"
+#define DRV_VERSION "0.2"
 
 #define RTC_REG_SIZE		0x2000
 #define RTC_OFFSET		0x1ff0
@@ -357,9 +357,13 @@ static int __init ds1553_rtc_probe(struc
 	pdata->rtc = rtc;
 	pdata->last_jiffies = jiffies;
 	platform_set_drvdata(pdev, pdata);
-	sysfs_create_bin_file(&pdev->dev.kobj, &ds1553_nvram_attr);
+	ret = sysfs_create_bin_file(&pdev->dev.kobj, &ds1553_nvram_attr);
+	if (ret)
+		goto out;
 	return 0;
  out:
+	if (pdata->rtc)
+		rtc_device_unregister(pdata->rtc);
 	if (pdata->irq >= 0)
 		free_irq(pdata->irq, pdev);
 	if (ioaddr)
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 8e47e5a..ff95512 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -17,7 +17,7 @@ #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#define DRV_VERSION "0.1"
+#define DRV_VERSION "0.2"
 
 #define RTC_REG_SIZE		0x800
 #define RTC_OFFSET		0x7f8
@@ -196,7 +196,7 @@ static int __init ds1742_rtc_probe(struc
 		writeb(sec, ioaddr + RTC_SECONDS);
 		writeb(cen & RTC_CENTURY_MASK, ioaddr + RTC_CONTROL);
 	}
-	if (readb(ioaddr + RTC_DAY) & RTC_BATT_FLAG)
+	if (!(readb(ioaddr + RTC_DAY) & RTC_BATT_FLAG))
 		dev_warn(&pdev->dev, "voltage-low detected.\n");
 
 	rtc = rtc_device_register(pdev->name, &pdev->dev,
@@ -208,9 +208,13 @@ static int __init ds1742_rtc_probe(struc
 	pdata->rtc = rtc;
 	pdata->last_jiffies = jiffies;
 	platform_set_drvdata(pdev, pdata);
-	sysfs_create_bin_file(&pdev->dev.kobj, &ds1742_nvram_attr);
+	ret = sysfs_create_bin_file(&pdev->dev.kobj, &ds1742_nvram_attr);
+	if (ret)
+		goto out;
 	return 0;
  out:
+	if (pdata->rtc)
+		rtc_device_unregister(pdata->rtc);
 	if (ioaddr)
 		iounmap(ioaddr);
 	if (pdata->baseaddr)

