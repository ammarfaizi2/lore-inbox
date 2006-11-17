Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932912AbWKQOWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWKQOWD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933614AbWKQOWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:22:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63503 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932912AbWKQOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:22:00 -0500
Date: Fri, 17 Nov 2006 15:21:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Mironchik <pmironchik@optifacio.net>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/rtc/rtc-rs5c372.c: fix a NULL dereference
Message-ID: <20061117142159.GY31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The correct order is: NULL check before dereference

This was a guaranteed NULL dereference with debugging enabled since 
rs5c372_sysfs_show_osc() does actually pass NULL...

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/rtc/rtc-rs5c372.c.old	2006-11-17 14:15:53.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/rtc/rtc-rs5c372.c	2006-11-17 14:16:53.000000000 +0100
@@ -126,13 +126,13 @@ static int rs5c372_get_trim(struct i2c_c
 		return -EIO;
 	}
 
-	dev_dbg(&client->dev, "%s: raw trim=%x\n", __FUNCTION__, *trim);
-
 	if (osc)
 		*osc = (buf & RS5C372_TRIM_XSL) ? 32000 : 32768;
 
-	if (trim)
+	if (trim) {
 		*trim = buf & RS5C372_TRIM_MASK;
+		dev_dbg(&client->dev, "%s: raw trim=%x\n", __FUNCTION__, *trim);
+	}
 
 	return 0;
 }

