Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWHKVU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWHKVU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHKVU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:20:28 -0400
Received: from host-84-9-212-181.bulldogdsl.com ([84.9.212.181]:21862 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932345AbWHKVU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:20:27 -0400
Date: Fri, 11 Aug 2006 22:20:25 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org, apkm@osdl.org
Subject: [PATCH] drivers/rtc: fix rtc-s3c.c
Message-ID: <20060811212025.GA22116@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In the cleanups of drivers/rtc/s3c-rtc.c, the base address
for the registers got broken. This patch fixes that by
ensuring the readb/writeb are all prefixed with the base
returned from ioremap()ing the registers.

Also fix check for valid year range, which was the wrong
way around.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.18-rc4/drivers/rtc/rtc-s3c.c linux-2.6.18-rc4-rtc1/drivers/rtc/rtc-s3c.c
--- linux-2.6.18-rc4/drivers/rtc/rtc-s3c.c	2006-08-11 11:03:50.000000000 +0100
+++ linux-2.6.18-rc4-rtc1/drivers/rtc/rtc-s3c.c	2006-08-11 22:13:21.000000000 +0100
@@ -69,12 +69,12 @@ static void s3c_rtc_setaie(int to)
 
 	pr_debug("%s: aie=%d\n", __FUNCTION__, to);
 
-	tmp = readb(S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
+	tmp = readb(s3c_rtc_base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
 
 	if (to)
 		tmp |= S3C2410_RTCALM_ALMEN;
 
-	writeb(tmp, S3C2410_RTCALM);
+	writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
 }
 
 static void s3c_rtc_setpie(int to)
@@ -84,12 +84,12 @@ static void s3c_rtc_setpie(int to)
 	pr_debug("%s: pie=%d\n", __FUNCTION__, to);
 
 	spin_lock_irq(&s3c_rtc_pie_lock);
-	tmp = readb(S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
+	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
 
 	if (to)
 		tmp |= S3C2410_TICNT_ENABLE;
 
-	writeb(tmp, S3C2410_TICNT);
+	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c_rtc_pie_lock);
 }
 
@@ -98,29 +98,30 @@ static void s3c_rtc_setfreq(int freq)
 	unsigned int tmp;
 
 	spin_lock_irq(&s3c_rtc_pie_lock);
-	tmp = readb(S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
+	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
 
 	s3c_rtc_freq = freq;
 
 	tmp |= (128 / freq)-1;
 
-	writeb(tmp, S3C2410_TICNT);
+	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c_rtc_pie_lock);
 }
 
 /* Time read/write */
 
 static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
-{
+{	
 	unsigned int have_retried = 0;
+	void __iomem *base = s3c_rtc_base;
 
  retry_get_time:
-	rtc_tm->tm_min  = readb(S3C2410_RTCMIN);
-	rtc_tm->tm_hour = readb(S3C2410_RTCHOUR);
-	rtc_tm->tm_mday = readb(S3C2410_RTCDATE);
-	rtc_tm->tm_mon  = readb(S3C2410_RTCMON);
-	rtc_tm->tm_year = readb(S3C2410_RTCYEAR);
-	rtc_tm->tm_sec  = readb(S3C2410_RTCSEC);
+	rtc_tm->tm_min  = readb(base + S3C2410_RTCMIN);
+	rtc_tm->tm_hour = readb(base + S3C2410_RTCHOUR);
+	rtc_tm->tm_mday = readb(base + S3C2410_RTCDATE);
+	rtc_tm->tm_mon  = readb(base + S3C2410_RTCMON);
+	rtc_tm->tm_year = readb(base + S3C2410_RTCYEAR);
+	rtc_tm->tm_sec  = readb(base + S3C2410_RTCSEC);
 
 	/* the only way to work out wether the system was mid-update
 	 * when we read it is to check the second counter, and if it
@@ -151,17 +152,25 @@ static int s3c_rtc_gettime(struct device
 
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
+	void __iomem *base = s3c_rtc_base;
+
 	/* the rtc gets round the y2k problem by just not supporting it */
 
-	if (tm->tm_year < 100)
+	if (tm->tm_year > 100) {
+		dev_err(dev, "rtc only supports 100 years\n");
 		return -EINVAL;
+	}
 
-	writeb(BIN2BCD(tm->tm_sec),  S3C2410_RTCSEC);
-	writeb(BIN2BCD(tm->tm_min),  S3C2410_RTCMIN);
-	writeb(BIN2BCD(tm->tm_hour), S3C2410_RTCHOUR);
-	writeb(BIN2BCD(tm->tm_mday), S3C2410_RTCDATE);
-	writeb(BIN2BCD(tm->tm_mon + 1), S3C2410_RTCMON);
-	writeb(BIN2BCD(tm->tm_year - 100), S3C2410_RTCYEAR);
+	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
+		 tm->tm_year, tm->tm_mon, tm->tm_mday,
+		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	writeb(BIN2BCD(tm->tm_sec),  base + S3C2410_RTCSEC);
+	writeb(BIN2BCD(tm->tm_min),  base + S3C2410_RTCMIN);
+	writeb(BIN2BCD(tm->tm_hour), base + S3C2410_RTCHOUR);
+	writeb(BIN2BCD(tm->tm_mday), base + S3C2410_RTCDATE);
+	writeb(BIN2BCD(tm->tm_mon + 1), base + S3C2410_RTCMON);
+	writeb(BIN2BCD(tm->tm_year - 100), base + S3C2410_RTCYEAR);
 
 	return 0;
 }
@@ -169,16 +178,17 @@ static int s3c_rtc_settime(struct device
 static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_time *alm_tm = &alrm->time;
+	void __iomem *base = s3c_rtc_base;
 	unsigned int alm_en;
 
-	alm_tm->tm_sec  = readb(S3C2410_ALMSEC);
-	alm_tm->tm_min  = readb(S3C2410_ALMMIN);
-	alm_tm->tm_hour = readb(S3C2410_ALMHOUR);
-	alm_tm->tm_mon  = readb(S3C2410_ALMMON);
-	alm_tm->tm_mday = readb(S3C2410_ALMDATE);
-	alm_tm->tm_year = readb(S3C2410_ALMYEAR);
+	alm_tm->tm_sec  = readb(base + S3C2410_ALMSEC);
+	alm_tm->tm_min  = readb(base + S3C2410_ALMMIN);
+	alm_tm->tm_hour = readb(base + S3C2410_ALMHOUR);
+	alm_tm->tm_mon  = readb(base + S3C2410_ALMMON);
+	alm_tm->tm_mday = readb(base + S3C2410_ALMDATE);
+	alm_tm->tm_year = readb(base + S3C2410_ALMYEAR);
 
-	alm_en = readb(S3C2410_RTCALM);
+	alm_en = readb(base + S3C2410_RTCALM);
 
 	pr_debug("read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
 		 alm_en,
@@ -226,6 +236,7 @@ static int s3c_rtc_getalarm(struct devic
 static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_time *tm = &alrm->time;
+	void __iomem *base = s3c_rtc_base;
 	unsigned int alrm_en;
 
 	pr_debug("s3c_rtc_setalarm: %d, %02x/%02x/%02x %02x.%02x.%02x\n",
@@ -234,32 +245,32 @@ static int s3c_rtc_setalarm(struct devic
 		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
 
 
-	alrm_en = readb(S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
-	writeb(0x00, S3C2410_RTCALM);
+	alrm_en = readb(base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
+	writeb(0x00, base + S3C2410_RTCALM);
 
 	if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
 		alrm_en |= S3C2410_RTCALM_SECEN;
-		writeb(BIN2BCD(tm->tm_sec), S3C2410_ALMSEC);
+		writeb(BIN2BCD(tm->tm_sec), base + S3C2410_ALMSEC);
 	}
 
 	if (tm->tm_min < 60 && tm->tm_min >= 0) {
 		alrm_en |= S3C2410_RTCALM_MINEN;
-		writeb(BIN2BCD(tm->tm_min), S3C2410_ALMMIN);
+		writeb(BIN2BCD(tm->tm_min), base + S3C2410_ALMMIN);
 	}
 
 	if (tm->tm_hour < 24 && tm->tm_hour >= 0) {
 		alrm_en |= S3C2410_RTCALM_HOUREN;
-		writeb(BIN2BCD(tm->tm_hour), S3C2410_ALMHOUR);
+		writeb(BIN2BCD(tm->tm_hour), base + S3C2410_ALMHOUR);
 	}
 
 	pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
 
-	writeb(alrm_en, S3C2410_RTCALM);
+	writeb(alrm_en, base + S3C2410_RTCALM);
 
 	if (0) {
-		alrm_en = readb(S3C2410_RTCALM);
+		alrm_en = readb(base + S3C2410_RTCALM);
 		alrm_en &= ~S3C2410_RTCALM_ALMEN;
-		writeb(alrm_en, S3C2410_RTCALM);
+		writeb(alrm_en, base + S3C2410_RTCALM);
 		disable_irq_wake(s3c_rtc_alarmno);
 	}
 
@@ -319,8 +330,8 @@ static int s3c_rtc_ioctl(struct device *
 
 static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	unsigned int rtcalm = readb(S3C2410_RTCALM);
-	unsigned int ticnt = readb (S3C2410_TICNT);
+	unsigned int rtcalm = readb(s3c_rtc_base + S3C2410_RTCALM);
+	unsigned int ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
 
 	seq_printf(seq, "alarm_IRQ\t: %s\n",
 		   (rtcalm & S3C2410_RTCALM_ALMEN) ? "yes" : "no" );
@@ -387,39 +398,40 @@ static struct rtc_class_ops s3c_rtcops =
 
 static void s3c_rtc_enable(struct platform_device *pdev, int en)
 {
+	void __iomem *base = s3c_rtc_base;
 	unsigned int tmp;
 
 	if (s3c_rtc_base == NULL)
 		return;
 
 	if (!en) {
-		tmp = readb(S3C2410_RTCCON);
-		writeb(tmp & ~S3C2410_RTCCON_RTCEN, S3C2410_RTCCON);
+		tmp = readb(base + S3C2410_RTCCON);
+		writeb(tmp & ~S3C2410_RTCCON_RTCEN, base + S3C2410_RTCCON);
 
-		tmp = readb(S3C2410_TICNT);
-		writeb(tmp & ~S3C2410_TICNT_ENABLE, S3C2410_TICNT);
+		tmp = readb(base + S3C2410_TICNT);
+		writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
 	} else {
 		/* re-enable the device, and check it is ok */
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
+		if ((readb(base+S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
 			dev_info(&pdev->dev, "rtc disabled, re-enabling\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp | S3C2410_RTCCON_RTCEN , S3C2410_RTCCON);
+			tmp = readb(base + S3C2410_RTCCON);
+			writeb(tmp|S3C2410_RTCCON_RTCEN, base+S3C2410_RTCCON);
 		}
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
+		if ((readb(base + S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
 			dev_info(&pdev->dev, "removing RTCCON_CNTSEL\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp& ~S3C2410_RTCCON_CNTSEL , S3C2410_RTCCON);
+			tmp = readb(base + S3C2410_RTCCON);
+			writeb(tmp& ~S3C2410_RTCCON_CNTSEL, base+S3C2410_RTCCON);
 		}
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
+		if ((readb(base + S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
 			dev_info(&pdev->dev, "removing RTCCON_CLKRST\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp & ~S3C2410_RTCCON_CLKRST, S3C2410_RTCCON);
+			tmp = readb(base + S3C2410_RTCCON);
+			writeb(tmp & ~S3C2410_RTCCON_CLKRST, base+S3C2410_RTCCON);
 		}
 	}
 }
@@ -475,8 +487,8 @@ static int s3c_rtc_probe(struct platform
 	}
 
 	s3c_rtc_mem = request_mem_region(res->start,
-					     res->end-res->start+1,
-					     pdev->name);
+					 res->end-res->start+1,
+					 pdev->name);
 
 	if (s3c_rtc_mem == NULL) {
 		dev_err(&pdev->dev, "failed to reserve memory region\n");
@@ -495,7 +507,8 @@ static int s3c_rtc_probe(struct platform
 
 	s3c_rtc_enable(pdev, 1);
 
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(S3C2410_RTCCON));
+ 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", 
+		 readb(s3c_rtc_base + S3C2410_RTCCON));
 
 	s3c_rtc_setfreq(s3c_rtc_freq);
 
@@ -543,7 +556,7 @@ static int s3c_rtc_suspend(struct platfo
 
 	/* save TICNT for anyone using periodic interrupts */
 
-	ticnt_save = readb(S3C2410_TICNT);
+	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
 
 	/* calculate time delta for suspend */
 
@@ -567,7 +580,7 @@ static int s3c_rtc_resume(struct platfor
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	restore_time_delta(&s3c_rtc_delta, &time);
 
-	writeb(ticnt_save, S3C2410_TICNT);
+	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
 	return 0;
 }
 #else
diff -urpN -X ../dontdiff linux-2.6.18-rc4/include/asm-arm/arch-s3c2410/regs-rtc.h linux-2.6.18-rc4-rtc1/include/asm-arm/arch-s3c2410/regs-rtc.h
--- linux-2.6.18-rc4/include/asm-arm/arch-s3c2410/regs-rtc.h	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.18-rc4-rtc1/include/asm-arm/arch-s3c2410/regs-rtc.h	2006-08-11 22:14:31.000000000 +0100
@@ -18,7 +18,7 @@
 #ifndef __ASM_ARCH_REGS_RTC_H
 #define __ASM_ARCH_REGS_RTC_H __FILE__
 
-#define S3C2410_RTCREG(x) ((x) + S3C24XX_VA_RTC)
+#define S3C2410_RTCREG(x) (x)
 
 #define S3C2410_RTCCON	      S3C2410_RTCREG(0x40)
 #define S3C2410_RTCCON_RTCEN  (1<<0)

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2618-rc4-fix-s3c-rtc.patch"

diff -urpN -X ../dontdiff linux-2.6.18-rc4/drivers/rtc/rtc-s3c.c linux-2.6.18-rc4-rtc1/drivers/rtc/rtc-s3c.c
--- linux-2.6.18-rc4/drivers/rtc/rtc-s3c.c	2006-08-11 11:03:50.000000000 +0100
+++ linux-2.6.18-rc4-rtc1/drivers/rtc/rtc-s3c.c	2006-08-11 22:13:21.000000000 +0100
@@ -69,12 +69,12 @@ static void s3c_rtc_setaie(int to)
 
 	pr_debug("%s: aie=%d\n", __FUNCTION__, to);
 
-	tmp = readb(S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
+	tmp = readb(s3c_rtc_base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
 
 	if (to)
 		tmp |= S3C2410_RTCALM_ALMEN;
 
-	writeb(tmp, S3C2410_RTCALM);
+	writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
 }
 
 static void s3c_rtc_setpie(int to)
@@ -84,12 +84,12 @@ static void s3c_rtc_setpie(int to)
 	pr_debug("%s: pie=%d\n", __FUNCTION__, to);
 
 	spin_lock_irq(&s3c_rtc_pie_lock);
-	tmp = readb(S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
+	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
 
 	if (to)
 		tmp |= S3C2410_TICNT_ENABLE;
 
-	writeb(tmp, S3C2410_TICNT);
+	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c_rtc_pie_lock);
 }
 
@@ -98,29 +98,30 @@ static void s3c_rtc_setfreq(int freq)
 	unsigned int tmp;
 
 	spin_lock_irq(&s3c_rtc_pie_lock);
-	tmp = readb(S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
+	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
 
 	s3c_rtc_freq = freq;
 
 	tmp |= (128 / freq)-1;
 
-	writeb(tmp, S3C2410_TICNT);
+	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c_rtc_pie_lock);
 }
 
 /* Time read/write */
 
 static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
-{
+{	
 	unsigned int have_retried = 0;
+	void __iomem *base = s3c_rtc_base;
 
  retry_get_time:
-	rtc_tm->tm_min  = readb(S3C2410_RTCMIN);
-	rtc_tm->tm_hour = readb(S3C2410_RTCHOUR);
-	rtc_tm->tm_mday = readb(S3C2410_RTCDATE);
-	rtc_tm->tm_mon  = readb(S3C2410_RTCMON);
-	rtc_tm->tm_year = readb(S3C2410_RTCYEAR);
-	rtc_tm->tm_sec  = readb(S3C2410_RTCSEC);
+	rtc_tm->tm_min  = readb(base + S3C2410_RTCMIN);
+	rtc_tm->tm_hour = readb(base + S3C2410_RTCHOUR);
+	rtc_tm->tm_mday = readb(base + S3C2410_RTCDATE);
+	rtc_tm->tm_mon  = readb(base + S3C2410_RTCMON);
+	rtc_tm->tm_year = readb(base + S3C2410_RTCYEAR);
+	rtc_tm->tm_sec  = readb(base + S3C2410_RTCSEC);
 
 	/* the only way to work out wether the system was mid-update
 	 * when we read it is to check the second counter, and if it
@@ -151,17 +152,25 @@ static int s3c_rtc_gettime(struct device
 
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
+	void __iomem *base = s3c_rtc_base;
+
 	/* the rtc gets round the y2k problem by just not supporting it */
 
-	if (tm->tm_year < 100)
+	if (tm->tm_year > 100) {
+		dev_err(dev, "rtc only supports 100 years\n");
 		return -EINVAL;
+	}
 
-	writeb(BIN2BCD(tm->tm_sec),  S3C2410_RTCSEC);
-	writeb(BIN2BCD(tm->tm_min),  S3C2410_RTCMIN);
-	writeb(BIN2BCD(tm->tm_hour), S3C2410_RTCHOUR);
-	writeb(BIN2BCD(tm->tm_mday), S3C2410_RTCDATE);
-	writeb(BIN2BCD(tm->tm_mon + 1), S3C2410_RTCMON);
-	writeb(BIN2BCD(tm->tm_year - 100), S3C2410_RTCYEAR);
+	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
+		 tm->tm_year, tm->tm_mon, tm->tm_mday,
+		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	writeb(BIN2BCD(tm->tm_sec),  base + S3C2410_RTCSEC);
+	writeb(BIN2BCD(tm->tm_min),  base + S3C2410_RTCMIN);
+	writeb(BIN2BCD(tm->tm_hour), base + S3C2410_RTCHOUR);
+	writeb(BIN2BCD(tm->tm_mday), base + S3C2410_RTCDATE);
+	writeb(BIN2BCD(tm->tm_mon + 1), base + S3C2410_RTCMON);
+	writeb(BIN2BCD(tm->tm_year - 100), base + S3C2410_RTCYEAR);
 
 	return 0;
 }
@@ -169,16 +178,17 @@ static int s3c_rtc_settime(struct device
 static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_time *alm_tm = &alrm->time;
+	void __iomem *base = s3c_rtc_base;
 	unsigned int alm_en;
 
-	alm_tm->tm_sec  = readb(S3C2410_ALMSEC);
-	alm_tm->tm_min  = readb(S3C2410_ALMMIN);
-	alm_tm->tm_hour = readb(S3C2410_ALMHOUR);
-	alm_tm->tm_mon  = readb(S3C2410_ALMMON);
-	alm_tm->tm_mday = readb(S3C2410_ALMDATE);
-	alm_tm->tm_year = readb(S3C2410_ALMYEAR);
+	alm_tm->tm_sec  = readb(base + S3C2410_ALMSEC);
+	alm_tm->tm_min  = readb(base + S3C2410_ALMMIN);
+	alm_tm->tm_hour = readb(base + S3C2410_ALMHOUR);
+	alm_tm->tm_mon  = readb(base + S3C2410_ALMMON);
+	alm_tm->tm_mday = readb(base + S3C2410_ALMDATE);
+	alm_tm->tm_year = readb(base + S3C2410_ALMYEAR);
 
-	alm_en = readb(S3C2410_RTCALM);
+	alm_en = readb(base + S3C2410_RTCALM);
 
 	pr_debug("read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
 		 alm_en,
@@ -226,6 +236,7 @@ static int s3c_rtc_getalarm(struct devic
 static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_time *tm = &alrm->time;
+	void __iomem *base = s3c_rtc_base;
 	unsigned int alrm_en;
 
 	pr_debug("s3c_rtc_setalarm: %d, %02x/%02x/%02x %02x.%02x.%02x\n",
@@ -234,32 +245,32 @@ static int s3c_rtc_setalarm(struct devic
 		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
 
 
-	alrm_en = readb(S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
-	writeb(0x00, S3C2410_RTCALM);
+	alrm_en = readb(base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
+	writeb(0x00, base + S3C2410_RTCALM);
 
 	if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
 		alrm_en |= S3C2410_RTCALM_SECEN;
-		writeb(BIN2BCD(tm->tm_sec), S3C2410_ALMSEC);
+		writeb(BIN2BCD(tm->tm_sec), base + S3C2410_ALMSEC);
 	}
 
 	if (tm->tm_min < 60 && tm->tm_min >= 0) {
 		alrm_en |= S3C2410_RTCALM_MINEN;
-		writeb(BIN2BCD(tm->tm_min), S3C2410_ALMMIN);
+		writeb(BIN2BCD(tm->tm_min), base + S3C2410_ALMMIN);
 	}
 
 	if (tm->tm_hour < 24 && tm->tm_hour >= 0) {
 		alrm_en |= S3C2410_RTCALM_HOUREN;
-		writeb(BIN2BCD(tm->tm_hour), S3C2410_ALMHOUR);
+		writeb(BIN2BCD(tm->tm_hour), base + S3C2410_ALMHOUR);
 	}
 
 	pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
 
-	writeb(alrm_en, S3C2410_RTCALM);
+	writeb(alrm_en, base + S3C2410_RTCALM);
 
 	if (0) {
-		alrm_en = readb(S3C2410_RTCALM);
+		alrm_en = readb(base + S3C2410_RTCALM);
 		alrm_en &= ~S3C2410_RTCALM_ALMEN;
-		writeb(alrm_en, S3C2410_RTCALM);
+		writeb(alrm_en, base + S3C2410_RTCALM);
 		disable_irq_wake(s3c_rtc_alarmno);
 	}
 
@@ -319,8 +330,8 @@ static int s3c_rtc_ioctl(struct device *
 
 static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	unsigned int rtcalm = readb(S3C2410_RTCALM);
-	unsigned int ticnt = readb (S3C2410_TICNT);
+	unsigned int rtcalm = readb(s3c_rtc_base + S3C2410_RTCALM);
+	unsigned int ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
 
 	seq_printf(seq, "alarm_IRQ\t: %s\n",
 		   (rtcalm & S3C2410_RTCALM_ALMEN) ? "yes" : "no" );
@@ -387,39 +398,40 @@ static struct rtc_class_ops s3c_rtcops =
 
 static void s3c_rtc_enable(struct platform_device *pdev, int en)
 {
+	void __iomem *base = s3c_rtc_base;
 	unsigned int tmp;
 
 	if (s3c_rtc_base == NULL)
 		return;
 
 	if (!en) {
-		tmp = readb(S3C2410_RTCCON);
-		writeb(tmp & ~S3C2410_RTCCON_RTCEN, S3C2410_RTCCON);
+		tmp = readb(base + S3C2410_RTCCON);
+		writeb(tmp & ~S3C2410_RTCCON_RTCEN, base + S3C2410_RTCCON);
 
-		tmp = readb(S3C2410_TICNT);
-		writeb(tmp & ~S3C2410_TICNT_ENABLE, S3C2410_TICNT);
+		tmp = readb(base + S3C2410_TICNT);
+		writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
 	} else {
 		/* re-enable the device, and check it is ok */
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
+		if ((readb(base+S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
 			dev_info(&pdev->dev, "rtc disabled, re-enabling\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp | S3C2410_RTCCON_RTCEN , S3C2410_RTCCON);
+			tmp = readb(base + S3C2410_RTCCON);
+			writeb(tmp|S3C2410_RTCCON_RTCEN, base+S3C2410_RTCCON);
 		}
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
+		if ((readb(base + S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
 			dev_info(&pdev->dev, "removing RTCCON_CNTSEL\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp& ~S3C2410_RTCCON_CNTSEL , S3C2410_RTCCON);
+			tmp = readb(base + S3C2410_RTCCON);
+			writeb(tmp& ~S3C2410_RTCCON_CNTSEL, base+S3C2410_RTCCON);
 		}
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
+		if ((readb(base + S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
 			dev_info(&pdev->dev, "removing RTCCON_CLKRST\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp & ~S3C2410_RTCCON_CLKRST, S3C2410_RTCCON);
+			tmp = readb(base + S3C2410_RTCCON);
+			writeb(tmp & ~S3C2410_RTCCON_CLKRST, base+S3C2410_RTCCON);
 		}
 	}
 }
@@ -475,8 +487,8 @@ static int s3c_rtc_probe(struct platform
 	}
 
 	s3c_rtc_mem = request_mem_region(res->start,
-					     res->end-res->start+1,
-					     pdev->name);
+					 res->end-res->start+1,
+					 pdev->name);
 
 	if (s3c_rtc_mem == NULL) {
 		dev_err(&pdev->dev, "failed to reserve memory region\n");
@@ -495,7 +507,8 @@ static int s3c_rtc_probe(struct platform
 
 	s3c_rtc_enable(pdev, 1);
 
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(S3C2410_RTCCON));
+ 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", 
+		 readb(s3c_rtc_base + S3C2410_RTCCON));
 
 	s3c_rtc_setfreq(s3c_rtc_freq);
 
@@ -543,7 +556,7 @@ static int s3c_rtc_suspend(struct platfo
 
 	/* save TICNT for anyone using periodic interrupts */
 
-	ticnt_save = readb(S3C2410_TICNT);
+	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
 
 	/* calculate time delta for suspend */
 
@@ -567,7 +580,7 @@ static int s3c_rtc_resume(struct platfor
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	restore_time_delta(&s3c_rtc_delta, &time);
 
-	writeb(ticnt_save, S3C2410_TICNT);
+	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
 	return 0;
 }
 #else
diff -urpN -X ../dontdiff linux-2.6.18-rc4/include/asm-arm/arch-s3c2410/regs-rtc.h linux-2.6.18-rc4-rtc1/include/asm-arm/arch-s3c2410/regs-rtc.h
--- linux-2.6.18-rc4/include/asm-arm/arch-s3c2410/regs-rtc.h	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.18-rc4-rtc1/include/asm-arm/arch-s3c2410/regs-rtc.h	2006-08-11 22:14:31.000000000 +0100
@@ -18,7 +18,7 @@
 #ifndef __ASM_ARCH_REGS_RTC_H
 #define __ASM_ARCH_REGS_RTC_H __FILE__
 
-#define S3C2410_RTCREG(x) ((x) + S3C24XX_VA_RTC)
+#define S3C2410_RTCREG(x) (x)
 
 #define S3C2410_RTCCON	      S3C2410_RTCREG(0x40)
 #define S3C2410_RTCCON_RTCEN  (1<<0)

--oyUTqETQ0mS9luUI--
