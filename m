Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWIDNUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWIDNUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWIDNUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:20:31 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:6604 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S964917AbWIDNUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:20:30 -0400
Date: Mon, 04 Sep 2006 22:22:22 +0900 (JST)
Message-Id: <20060904.222222.59464886.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, akpm@osdl.org
Subject: [PATCH] RTC: more XSTP/VDET support for rtc-rs5c348 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the chip detected "oscillator stop" condition, show an warning
message.  And initialize it with the Epoch time instead of leaving it
with unknown date/time.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 0964d1d..2558906 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -23,7 +23,7 @@ #include <linux/rtc.h>
 #include <linux/workqueue.h>
 #include <linux/spi/spi.h>
 
-#define DRV_VERSION "0.1"
+#define DRV_VERSION "0.2"
 
 #define RS5C348_REG_SECS	0
 #define RS5C348_REG_MINS	1
@@ -175,8 +175,15 @@ static int __devinit rs5c348_probe(struc
 		goto kfree_exit;
 	if (ret & (RS5C348_BIT_XSTP | RS5C348_BIT_VDET)) {
 		u8 buf[2];
+		struct rtc_time tm;
 		if (ret & RS5C348_BIT_VDET)
 			dev_warn(&spi->dev, "voltage-low detected.\n");
+		if (ret & RS5C348_BIT_XSTP)
+			dev_warn(&spi->dev, "oscillator-stop detected.\n");
+		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
+		ret = rs5c348_rtc_set_time(&spi->dev, &tm);
+		if (ret < 0)
+			goto kfree_exit;
 		buf[0] = RS5C348_CMD_W(RS5C348_REG_CTL2);
 		buf[1] = 0;
 		ret = spi_write_then_read(spi, buf, sizeof(buf), NULL, 0);
