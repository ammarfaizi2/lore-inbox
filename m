Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965329AbWHOJYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbWHOJYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965332AbWHOJYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:24:31 -0400
Received: from host-84-9-202-173.bulldogdsl.com ([84.9.202.173]:23638 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S965329AbWHOJYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:24:30 -0400
Date: Tue, 15 Aug 2006 10:24:29 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] rtc-s3c.c: fix time setting checks
Message-ID: <20060815092429.GA13940@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checking of the range for the year when
setting time with the S3C24XX RTC driver

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.18-rc4-all1/drivers/rtc/rtc-s3c.c linux-2.6.18-rc4-all2/drivers/rtc/rtc-s3c.c
--- linux-2.6.18-rc4-all1/drivers/rtc/rtc-s3c.c	2006-08-14 09:04:57.000000000 +0100
+++ linux-2.6.18-rc4-all2/drivers/rtc/rtc-s3c.c	2006-08-14 09:59:47.000000000 +0100
@@ -11,6 +11,8 @@
  * S3C2410/S3C2440/S3C24XX Internal RTC Driver
 */
 
+//B#define DEBUG
+
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/string.h>
@@ -153,24 +155,25 @@ static int s3c_rtc_gettime(struct device
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	void __iomem *base = s3c_rtc_base;
+	int year = tm->tm_year - 100;
+
+	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
+		 tm->tm_year, tm->tm_mon, tm->tm_mday,
+		 tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-	/* the rtc gets round the y2k problem by just not supporting it */
+	/* we get around y2k by simply not supporting it */
 
-	if (tm->tm_year > 100) {
+	if (year < 0 || year >= 100) {
 		dev_err(dev, "rtc only supports 100 years\n");
 		return -EINVAL;
 	}
 
-	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
-		 tm->tm_year, tm->tm_mon, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
-
 	writeb(BIN2BCD(tm->tm_sec),  base + S3C2410_RTCSEC);
 	writeb(BIN2BCD(tm->tm_min),  base + S3C2410_RTCMIN);
 	writeb(BIN2BCD(tm->tm_hour), base + S3C2410_RTCHOUR);
 	writeb(BIN2BCD(tm->tm_mday), base + S3C2410_RTCDATE);
 	writeb(BIN2BCD(tm->tm_mon + 1), base + S3C2410_RTCMON);
-	writeb(BIN2BCD(tm->tm_year - 100), base + S3C2410_RTCYEAR);
+	writeb(BIN2BCD(year), base + S3C2410_RTCYEAR);
 
 	return 0;
 }
