Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWHaWLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHaWLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWHaWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:11:52 -0400
Received: from outmx016.isp.belgacom.be ([195.238.4.115]:51083 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S964794AbWHaWLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:11:51 -0400
Date: Fri, 1 Sep 2006 00:11:39 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
To: linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] fix drivers/char/s3c2410-rtc.c: add missing base address
Message-ID: <20060831221139.GA14511@g5.pc.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apply to drivers/char/s3c2410-rtc.c the same fix the commit
9a654518e1b774b8e8f74a819fd12a931e7672c9 did on drivers/rtc/rtc-s3c.c:
prefix all the readb()/writeb() with the base address returned by ioremap()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
----

diff --git a/drivers/char/s3c2410-rtc.c b/drivers/char/s3c2410-rtc.c
index 5458ef1..e840adc 100644
--- a/drivers/char/s3c2410-rtc.c
+++ b/drivers/char/s3c2410-rtc.c
@@ -72,7 +72,7 @@ static void s3c2410_rtc_setaie(int to)
 
 	pr_debug("%s: aie=%d\n", __FUNCTION__, to);
 
-	tmp = readb(S3C2410_RTCALM);
+	tmp = readb(s3c2410_rtc_base + S3C2410_RTCALM);
 
 	if (to)
 		tmp |= S3C2410_RTCALM_ALMEN;
@@ -80,7 +80,7 @@ static void s3c2410_rtc_setaie(int to)
 		tmp &= ~S3C2410_RTCALM_ALMEN;
 
 
-	writeb(tmp, S3C2410_RTCALM);
+	writeb(tmp, s3c2410_rtc_base + S3C2410_RTCALM);
 }
 
 static void s3c2410_rtc_setpie(int to)
@@ -90,12 +90,12 @@ static void s3c2410_rtc_setpie(int to)
 	pr_debug("%s: pie=%d\n", __FUNCTION__, to);
 
 	spin_lock_irq(&s3c2410_rtc_pie_lock);
-	tmp = readb(S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
+	tmp = readb(s3c2410_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
 
 	if (to)
 		tmp |= S3C2410_TICNT_ENABLE;
 
-	writeb(tmp, S3C2410_TICNT);
+	writeb(tmp, s3c2410_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c2410_rtc_pie_lock);
 }
 
@@ -104,13 +104,13 @@ static void s3c2410_rtc_setfreq(int freq
 	unsigned int tmp;
 
 	spin_lock_irq(&s3c2410_rtc_pie_lock);
-	tmp = readb(S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
+	tmp = readb(s3c2410_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
 
 	s3c2410_rtc_freq = freq;
 
 	tmp |= (128 / freq)-1;
 
-	writeb(tmp, S3C2410_TICNT);
+	writeb(tmp, s3c2410_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c2410_rtc_pie_lock);
 }
 
@@ -121,12 +121,12 @@ static int s3c2410_rtc_gettime(struct rt
 	unsigned int have_retried = 0;
 
  retry_get_time:
-	rtc_tm->tm_min  = readb(S3C2410_RTCMIN);
-	rtc_tm->tm_hour = readb(S3C2410_RTCHOUR);
-	rtc_tm->tm_mday = readb(S3C2410_RTCDATE);
-	rtc_tm->tm_mon  = readb(S3C2410_RTCMON);
-	rtc_tm->tm_year = readb(S3C2410_RTCYEAR);
-	rtc_tm->tm_sec  = readb(S3C2410_RTCSEC);
+	rtc_tm->tm_min  = readb(s3c2410_rtc_base + S3C2410_RTCMIN);
+	rtc_tm->tm_hour = readb(s3c2410_rtc_base + S3C2410_RTCHOUR);
+	rtc_tm->tm_mday = readb(s3c2410_rtc_base + S3C2410_RTCDATE);
+	rtc_tm->tm_mon  = readb(s3c2410_rtc_base + S3C2410_RTCMON);
+	rtc_tm->tm_year = readb(s3c2410_rtc_base + S3C2410_RTCYEAR);
+	rtc_tm->tm_sec  = readb(s3c2410_rtc_base + S3C2410_RTCSEC);
 
 	/* the only way to work out wether the system was mid-update
 	 * when we read it is to check the second counter, and if it
@@ -165,10 +165,10 @@ static int s3c2410_rtc_settime(struct rt
 
 	writeb(BIN2BCD(tm->tm_sec),  S3C2410_RTCSEC);
 	writeb(BIN2BCD(tm->tm_min),  S3C2410_RTCMIN);
-	writeb(BIN2BCD(tm->tm_hour), S3C2410_RTCHOUR);
-	writeb(BIN2BCD(tm->tm_mday), S3C2410_RTCDATE);
-	writeb(BIN2BCD(tm->tm_mon + 1), S3C2410_RTCMON);
-	writeb(BIN2BCD(tm->tm_year - 100), S3C2410_RTCYEAR);
+	writeb(BIN2BCD(tm->tm_hour), s3c2410_rtc_base + S3C2410_RTCHOUR);
+	writeb(BIN2BCD(tm->tm_mday), s3c2410_rtc_base + S3C2410_RTCDATE);
+	writeb(BIN2BCD(tm->tm_mon + 1), s3c2410_rtc_base + S3C2410_RTCMON);
+	writeb(BIN2BCD(tm->tm_year - 100), s3c2410_rtc_base + S3C2410_RTCYEAR);
 
 	return 0;
 }
@@ -178,14 +178,14 @@ static int s3c2410_rtc_getalarm(struct r
 	struct rtc_time *alm_tm = &alrm->time;
 	unsigned int alm_en;
 
-	alm_tm->tm_sec  = readb(S3C2410_ALMSEC);
-	alm_tm->tm_min  = readb(S3C2410_ALMMIN);
-	alm_tm->tm_hour = readb(S3C2410_ALMHOUR);
-	alm_tm->tm_mon  = readb(S3C2410_ALMMON);
-	alm_tm->tm_mday = readb(S3C2410_ALMDATE);
-	alm_tm->tm_year = readb(S3C2410_ALMYEAR);
+	alm_tm->tm_sec  = readb(s3c2410_rtc_base + S3C2410_ALMSEC);
+	alm_tm->tm_min  = readb(s3c2410_rtc_base + S3C2410_ALMMIN);
+	alm_tm->tm_hour = readb(s3c2410_rtc_base + S3C2410_ALMHOUR);
+	alm_tm->tm_mon  = readb(s3c2410_rtc_base + S3C2410_ALMMON);
+	alm_tm->tm_mday = readb(s3c2410_rtc_base + S3C2410_ALMDATE);
+	alm_tm->tm_year = readb(s3c2410_rtc_base + S3C2410_ALMYEAR);
 
-	alm_en = readb(S3C2410_RTCALM);
+	alm_en = readb(s3c2410_rtc_base + S3C2410_RTCALM);
 
 	pr_debug("read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
 		 alm_en,
@@ -248,32 +248,32 @@ static int s3c2410_rtc_setalarm(struct r
 		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
 
 	if (alrm->enabled || 1) {
-		alrm_en = readb(S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
-		writeb(0x00, S3C2410_RTCALM);
+		alrm_en = readb(s3c2410_rtc_base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
+		writeb(0x00, s3c2410_rtc_base + S3C2410_RTCALM);
 
 		if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
 			alrm_en |= S3C2410_RTCALM_SECEN;
-			writeb(BIN2BCD(tm->tm_sec), S3C2410_ALMSEC);
+			writeb(BIN2BCD(tm->tm_sec), s3c2410_rtc_base + S3C2410_ALMSEC);
 		}
 
 		if (tm->tm_min < 60 && tm->tm_min >= 0) {
 			alrm_en |= S3C2410_RTCALM_MINEN;
-			writeb(BIN2BCD(tm->tm_min), S3C2410_ALMMIN);
+			writeb(BIN2BCD(tm->tm_min), s3c2410_rtc_base + S3C2410_ALMMIN);
 		}
 
 		if (tm->tm_hour < 24 && tm->tm_hour >= 0) {
 			alrm_en |= S3C2410_RTCALM_HOUREN;
-			writeb(BIN2BCD(tm->tm_hour), S3C2410_ALMHOUR);
+			writeb(BIN2BCD(tm->tm_hour), s3c2410_rtc_base + S3C2410_ALMHOUR);
 		}
 
 		pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
 
-		writeb(alrm_en, S3C2410_RTCALM);
+		writeb(alrm_en, s3c2410_rtc_base + S3C2410_RTCALM);
 		enable_irq_wake(s3c2410_rtc_alarmno);
 	} else {
-		alrm_en = readb(S3C2410_RTCALM);
+		alrm_en = readb(s3c2410_rtc_base + S3C2410_RTCALM);
 		alrm_en &= ~S3C2410_RTCALM_ALMEN;
-		writeb(alrm_en, S3C2410_RTCALM);
+		writeb(alrm_en, s3c2410_rtc_base + S3C2410_RTCALM);
 		disable_irq_wake(s3c2410_rtc_alarmno);
 	}
 
@@ -323,7 +323,7 @@ static int s3c2410_rtc_ioctl(unsigned in
 
 static int s3c2410_rtc_proc(char *buf)
 {
-	unsigned int rtcalm = readb(S3C2410_RTCALM);
+	unsigned int rtcalm = readb(s3c2410_rtc_base + S3C2410_RTCALM);
 	unsigned int ticnt = readb (S3C2410_TICNT);
 	char *p = buf;
 
@@ -390,33 +390,33 @@ static void s3c2410_rtc_enable(struct pl
 		return;
 
 	if (!en) {
-		tmp = readb(S3C2410_RTCCON);
-		writeb(tmp & ~S3C2410_RTCCON_RTCEN, S3C2410_RTCCON);
+		tmp = readb(s3c2410_rtc_base + S3C2410_RTCCON);
+		writeb(tmp & ~S3C2410_RTCCON_RTCEN, s3c2410_rtc_base + S3C2410_RTCCON);
 
-		tmp = readb(S3C2410_TICNT);
-		writeb(tmp & ~S3C2410_TICNT_ENABLE, S3C2410_TICNT);
+		tmp = readb(s3c2410_rtc_base + S3C2410_TICNT);
+		writeb(tmp & ~S3C2410_TICNT_ENABLE, s3c2410_rtc_base + S3C2410_TICNT);
 	} else {
 		/* re-enable the device, and check it is ok */
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
+		if ((readb(s3c2410_rtc_base + S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
 			dev_info(&pdev->dev, "rtc disabled, re-enabling\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp | S3C2410_RTCCON_RTCEN , S3C2410_RTCCON);
+			tmp = readb(s3c2410_rtc_base + S3C2410_RTCCON);
+			writeb(tmp | S3C2410_RTCCON_RTCEN , s3c2410_rtc_base + S3C2410_RTCCON);
 		}
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
+		if ((readb(s3c2410_rtc_base + S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
 			dev_info(&pdev->dev, "removing S3C2410_RTCCON_CNTSEL\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp& ~S3C2410_RTCCON_CNTSEL , S3C2410_RTCCON);
+			tmp = readb(s3c2410_rtc_base + S3C2410_RTCCON);
+			writeb(tmp& ~S3C2410_RTCCON_CNTSEL , s3c2410_rtc_base + S3C2410_RTCCON);
 		}
 
-		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
+		if ((readb(s3c2410_rtc_base + S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
 			dev_info(&pdev->dev, "removing S3C2410_RTCCON_CLKRST\n");
 
-			tmp = readb(S3C2410_RTCCON);
-			writeb(tmp & ~S3C2410_RTCCON_CLKRST, S3C2410_RTCCON);
+			tmp = readb(s3c2410_rtc_base + S3C2410_RTCCON);
+			writeb(tmp & ~S3C2410_RTCCON_CLKRST, s3c2410_rtc_base + S3C2410_RTCCON);
 		}
 	}
 }
@@ -489,13 +489,13 @@ static int s3c2410_rtc_probe(struct plat
 	s3c2410_rtc_mem = res;
 	pr_debug("s3c2410_rtc_base=%p\n", s3c2410_rtc_base);
 
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(S3C2410_RTCCON));
+ 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(s3c2410_rtc_base + S3C2410_RTCCON));
 
 	/* check to see if everything is setup correctly */
 
 	s3c2410_rtc_enable(pdev, 1);
 
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(S3C2410_RTCCON));
+ 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(s3c2410_rtc_base + S3C2410_RTCCON));
 
 	s3c2410_rtc_setfreq(s3c2410_rtc_freq);
 
@@ -527,7 +527,7 @@ static int s3c2410_rtc_suspend(struct pl
 
 	/* save TICNT for anyone using periodic interrupts */
 
-	ticnt_save = readb(S3C2410_TICNT);
+	ticnt_save = readb(s3c2410_rtc_base + S3C2410_TICNT);
 
 	/* calculate time delta for suspend */
 
@@ -551,7 +551,7 @@ static int s3c2410_rtc_resume(struct pla
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	restore_time_delta(&s3c2410_rtc_delta, &time);
 
-	writeb(ticnt_save, S3C2410_TICNT);
+	writeb(ticnt_save, s3c2410_rtc_base + S3C2410_TICNT);
 	return 0;
 }
 #else
