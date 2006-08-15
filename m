Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWHOUxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWHOUxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWHOUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:53:21 -0400
Received: from host-84-9-202-173.bulldogdsl.com ([84.9.202.173]:9851 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750701AbWHOUxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:53:21 -0400
Date: Tue, 15 Aug 2006 21:53:20 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] rtc-s3c.c: fix time setting checks
Message-ID: <20060815205320.GE8907@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the year check on setting the time with the S3C24XX
RTC driver. Also move the debug to before the set to see
what is going on if it does fail.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.18-rc4-rtc1/drivers/rtc/rtc-s3c.c linux-2.6.18-rc4-rtc2/drivers/rtc/rtc-s3c.c
--- linux-2.6.18-rc4-rtc1/drivers/rtc/rtc-s3c.c	2006-08-11 22:13:21.000000000 +0100
+++ linux-2.6.18-rc4-rtc2/drivers/rtc/rtc-s3c.c	2006-08-15 21:50:23.000000000 +0100
@@ -153,24 +153,25 @@ static int s3c_rtc_gettime(struct device
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	void __iomem *base = s3c_rtc_base;
+	int year = tm->tm_year - 100;
 
-	/* the rtc gets round the y2k problem by just not supporting it */
+	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
+		 tm->tm_year, tm->tm_mon, tm->tm_mday,
+		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+
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
