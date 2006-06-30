Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWF3Ars@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWF3Ars (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWF3Arr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:47:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964829AbWF3Aro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:47:44 -0400
Date: Thu, 29 Jun 2006 17:50:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ben Dooks <ben@fluff.org.uk>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [RFC] RTC: class driver for Samsung S3C series SoC
Message-Id: <20060629175018.10ac28c8.akpm@osdl.org>
In-Reply-To: <20060629225325.GA11799@home.fluff.org>
References: <20060629225325.GA11799@home.fluff.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben@fluff.org.uk> wrote:
>
> This is a renamed and tested version of the
> previous S3C24XX RTC class driver.
> 
> The driver has been renamed from the original
> s3c2410-rtc, which is now too narrow for the
> range of devices supported.
> 
> The rtc-s3c has been chosen as there is the
> distinct possibility of this driver being
> carried forward into newer Samsung SoC
> silicon.
> 
> +#undef S3C24XX_VA_RTC
> +#define S3C24XX_VA_RTC s3c_rtc_base

This appears to be unused?

> +static int s3c_rtc_open(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
> +			  SA_INTERRUPT,  "s3c2410-rtc alarm", rtc_dev);
> +
> +	if (ret)
> +		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_alarmno, ret);

I suspect you wanted a `return ret;' here.

> +	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
> +			  SA_INTERRUPT,  "s3c2410-rtc tick", rtc_dev);
> +
> +	if (ret) {
> +		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_tickno, ret);
> +		goto tick_err;
> +	}
> +
> +	return ret;
> +
> + tick_err:
> +	free_irq(s3c_rtc_alarmno, rtc_dev);
> +	return ret;
> +}

Are you sure you want spaces in the interrupt identifiers?  It'll make
parsing of /proc/interrupts harder, although I don't know that we're at all
consistent about that.


From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/rtc/rtc-s3c.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

diff -puN drivers/rtc/rtc-s3c.c~rtc-class-driver-for-samsung-s3c-series-soc-tidy drivers/rtc/rtc-s3c.c
--- a/drivers/rtc/rtc-s3c.c~rtc-class-driver-for-samsung-s3c-series-soc-tidy
+++ a/drivers/rtc/rtc-s3c.c
@@ -34,9 +34,6 @@
 /* I have yet to find an S3C implementation with more than one
  * of these rtc blocks in */
 
-#undef S3C24XX_VA_RTC
-#define S3C24XX_VA_RTC s3c_rtc_base
-
 static struct resource *s3c_rtc_mem;
 
 static void __iomem *s3c_rtc_base;
@@ -45,6 +42,7 @@ static int s3c_rtc_tickno  = NO_IRQ;
 static int s3c_rtc_freq    = 1;
 
 static DEFINE_SPINLOCK(s3c_rtc_pie_lock);
+static unsigned int tick_count;
 
 /* IRQ Handlers */
 
@@ -56,8 +54,6 @@ static irqreturn_t s3c_rtc_alarmirq(int 
 	return IRQ_HANDLED;
 }
 
-static unsigned int tick_count;
-
 static irqreturn_t s3c_rtc_tickirq(int irq, void *id, struct pt_regs *r)
 {
 	struct rtc_device *rdev = id;
@@ -153,7 +149,6 @@ static int s3c_rtc_gettime(struct device
 	return 0;
 }
 
-
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	/* the rtc gets round the y2k problem by just not supporting it */
@@ -193,29 +188,25 @@ static int s3c_rtc_getalarm(struct devic
 
 	/* decode the alarm enable field */
 
-	if (alm_en & S3C2410_RTCALM_SECEN) {
+	if (alm_en & S3C2410_RTCALM_SECEN)
 		BCD_TO_BIN(alm_tm->tm_sec);
-	} else {
+	else
 		alm_tm->tm_sec = 0xff;
-	}
 
-	if (alm_en & S3C2410_RTCALM_MINEN) {
+	if (alm_en & S3C2410_RTCALM_MINEN)
 		BCD_TO_BIN(alm_tm->tm_min);
-	} else {
+	else
 		alm_tm->tm_min = 0xff;
-	}
 
-	if (alm_en & S3C2410_RTCALM_HOUREN) {
+	if (alm_en & S3C2410_RTCALM_HOUREN)
 		BCD_TO_BIN(alm_tm->tm_hour);
-	} else {
+	else
 		alm_tm->tm_hour = 0xff;
-	}
 
-	if (alm_en & S3C2410_RTCALM_DAYEN) {
+	if (alm_en & S3C2410_RTCALM_DAYEN)
 		BCD_TO_BIN(alm_tm->tm_mday);
-	} else {
+	else
 		alm_tm->tm_mday = 0xff;
-	}
 
 	if (alm_en & S3C2410_RTCALM_MONEN) {
 		BCD_TO_BIN(alm_tm->tm_mon);
@@ -224,11 +215,10 @@ static int s3c_rtc_getalarm(struct devic
 		alm_tm->tm_mon = 0xff;
 	}
 
-	if (alm_en & S3C2410_RTCALM_YEAREN) {
+	if (alm_en & S3C2410_RTCALM_YEAREN)
 		BCD_TO_BIN(alm_tm->tm_year);
-	} else {
+	else
 		alm_tm->tm_year = 0xffff;
-	}
 
 	return 0;
 }
@@ -352,8 +342,10 @@ static int s3c_rtc_open(struct device *d
 	ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
 			  SA_INTERRUPT,  "s3c2410-rtc alarm", rtc_dev);
 
-	if (ret)
+	if (ret) {
 		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_alarmno, ret);
+		return ret;
+	}
 
 	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
 			  SA_INTERRUPT,  "s3c2410-rtc tick", rtc_dev);
_

