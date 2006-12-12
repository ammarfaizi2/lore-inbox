Return-Path: <linux-kernel-owner+w=401wt.eu-S932431AbWLLUYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWLLUYQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWLLUYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:24:16 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:38012 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932431AbWLLUYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:24:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MhExxcwzh9E16Nlq6erzC6uAxGWd+13Lg8d8t0WafiGvr7yZ2jkMqzq8RYk/2r7y2vYtPM+Yypx3erYkEONCEpK8vyEMU17xsQDHHsACjrNflJAkaxzl/cU9dFvYQUsXHJbPOm98uvMfrnGpQvHDBDDjWFWmBgeXoD94oFJ1PIw=  ;
X-YMail-OSG: eqypd3cVM1mQnmjPzVEWObVhnv_nEuRVBciL9UnHsHQETJAjBYj5wH9jAYgS1Zmj7KTOmAjnhJXbSGm0ZgAk0IAfxR.b2yQoCraoCMPd.bcrLt2EUujjS2yduAlrKB2XgHzrLWh1UE4FeM4-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-git] rtc framework:  rtc_wkalrm.enabled reporting updates
Date: Tue, 12 Dec 2006 11:49:13 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612121149.13913.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a glitch in the procfs dumping of whether the alarm IRQ is enabled:
use the traditional name (from drivers/char/rtc.c and many other places)
of "alarm_IRQ", not "alrm_wakeup" (which didn't even match the efirtc
code, which originated that reporting API).

Also, update a few of the RTC drivers to stop providing that duplicate
status, and/or to expose it properly when reporting the alarm state.
We really don't want every RTC driver doing their own thing here...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 drivers/rtc/rtc-at91rm9200.c |    5 +++--
 drivers/rtc/rtc-omap.c       |    3 +--
 drivers/rtc/rtc-proc.c       |    2 +-
 drivers/rtc/rtc-s3c.c        |    6 ++----
 drivers/rtc/rtc-sa1100.c     |    4 +---
 5 files changed, 8 insertions(+), 12 deletions(-)

Index: g26/drivers/rtc/rtc-proc.c
===================================================================
--- g26.orig/drivers/rtc/rtc-proc.c	2006-12-12 11:25:07.000000000 -0800
+++ g26/drivers/rtc/rtc-proc.c	2006-12-12 11:25:41.000000000 -0800
@@ -65,7 +65,7 @@ static int rtc_proc_show(struct seq_file
 			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
 		else
 			seq_printf(seq, "**\n");
-		seq_printf(seq, "alrm_wakeup\t: %s\n",
+		seq_printf(seq, "alarm_IRQ\t: %s\n",
 				alrm.enabled ? "yes" : "no");
 		seq_printf(seq, "alrm_pending\t: %s\n",
 				alrm.pending ? "yes" : "no");
Index: g26/drivers/rtc/rtc-at91rm9200.c
===================================================================
--- g26.orig/drivers/rtc/rtc-at91rm9200.c	2006-12-12 11:13:18.000000000 -0800
+++ g26/drivers/rtc/rtc-at91rm9200.c	2006-12-12 11:25:41.000000000 -0800
@@ -137,6 +137,9 @@ static int at91_rtc_readalarm(struct dev
 	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	tm->tm_year = at91_alarm_year - 1900;
 
+	alrm->enabled = (at91_sys_read(AT91_RTC_IMR) & AT91_RTC_ALARM)
+			? 1 : 0;
+
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
 		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
@@ -223,8 +226,6 @@ static int at91_rtc_proc(struct device *
 {
 	unsigned long imr = at91_sys_read(AT91_RTC_IMR);
 
-	seq_printf(seq, "alarm_IRQ\t: %s\n",
-			(imr & AT91_RTC_ALARM) ? "yes" : "no");
 	seq_printf(seq, "update_IRQ\t: %s\n",
 			(imr & AT91_RTC_ACKUPD) ? "yes" : "no");
 	seq_printf(seq, "periodic_IRQ\t: %s\n",
Index: g26/drivers/rtc/rtc-s3c.c
===================================================================
--- g26.orig/drivers/rtc/rtc-s3c.c	2006-12-12 11:08:08.000000000 -0800
+++ g26/drivers/rtc/rtc-s3c.c	2006-12-12 11:25:41.000000000 -0800
@@ -191,6 +191,8 @@ static int s3c_rtc_getalarm(struct devic
 
 	alm_en = readb(base + S3C2410_RTCALM);
 
+	alrm->enabled = (alm_en & S3C2410_RTCALM_ALMEN) ? 1 : 0;
+
 	pr_debug("read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
 		 alm_en,
 		 alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
@@ -331,12 +333,8 @@ static int s3c_rtc_ioctl(struct device *
 
 static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	unsigned int rtcalm = readb(s3c_rtc_base + S3C2410_RTCALM);
 	unsigned int ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
 
-	seq_printf(seq, "alarm_IRQ\t: %s\n",
-		   (rtcalm & S3C2410_RTCALM_ALMEN) ? "yes" : "no" );
-
 	seq_printf(seq, "periodic_IRQ\t: %s\n",
 		     (ticnt & S3C2410_TICNT_ENABLE) ? "yes" : "no" );
 
Index: g26/drivers/rtc/rtc-sa1100.c
===================================================================
--- g26.orig/drivers/rtc/rtc-sa1100.c	2006-12-12 11:08:08.000000000 -0800
+++ g26/drivers/rtc/rtc-sa1100.c	2006-12-12 11:25:41.000000000 -0800
@@ -289,9 +289,7 @@ static int sa1100_rtc_set_alarm(struct d
 
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	seq_printf(seq, "trim/divider\t: 0x%08lx\n", RTTR);
-	seq_printf(seq, "alarm_IRQ\t: %s\n",
-			(RTSR & RTSR_ALE) ? "yes" : "no" );
+	seq_printf(seq, "trim/divider\t: 0x%08x\n", (u32) RTTR);
 	seq_printf(seq, "update_IRQ\t: %s\n",
 			(RTSR & RTSR_HZE) ? "yes" : "no");
 	seq_printf(seq, "periodic_IRQ\t: %s\n",
Index: g26/drivers/rtc/rtc-omap.c
===================================================================
--- g26.orig/drivers/rtc/rtc-omap.c	2006-12-12 11:08:08.000000000 -0800
+++ g26/drivers/rtc/rtc-omap.c	2006-12-12 11:25:41.000000000 -0800
@@ -279,9 +279,8 @@ static int omap_rtc_read_alarm(struct de
 	local_irq_enable();
 
 	bcd2tm(&alm->time);
-	alm->pending = !!(rtc_read(OMAP_RTC_INTERRUPTS_REG)
+	alm->enabled = !!(rtc_read(OMAP_RTC_INTERRUPTS_REG)
 			& OMAP_RTC_INTERRUPTS_IT_ALARM);
-	alm->enabled = alm->pending && device_may_wakeup(dev);
 
 	return 0;
 }
