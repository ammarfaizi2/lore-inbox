Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFNJgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFNJgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFNJgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:36:35 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:51205 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVFNJg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:36:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=ZwoDtCJkfGeUU2l0hlqvSDIvd0aM5CrV4XZUVWj7CpsUeigbUr7XATSEO3PHXXHVJQPonNd+t6elo6pOYuvkDEqYhbbDNx8K4Y19y/tuBqRcWLqh0Pwp/2Siv4+2GzGpzP5wvBFwWYIx9Nn1398EpCmRB6qHiWmu2CVD5fX881Q=
Message-ID: <42AEC01A.3060403@gmail.com>
Date: Tue, 14 Jun 2005 11:31:38 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: mingo@elte.hu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Using msleep() instead of HZ
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Ingo suggested me to forward you my patches which do use of msleep in order to
perform short delays instead of using HZ directly.
I already sent him some, but they are against his -RT tree.
This is a modified patch, built against 2.6.12-rc6.

Signed-off by: Luca Falavigna <dktrkranz@gmail.com>

--- ./drivers/char/rtc.c.orig	2005-06-14 11:25:52.000000000 +0000
+++ ./drivers/char/rtc.c	2005-06-14 11:27:21.000000000 +0000
@@ -894,7 +894,6 @@ static int __init rtc_init(void)
 	struct proc_dir_entry *ent;
 #if defined(__alpha__) || defined(__mips__)
 	unsigned int year, ctrl;
-	unsigned long uip_watchdog;
 	char *guess = NULL;
 #endif
 #ifdef __sparc__
@@ -1000,12 +999,8 @@ no_irq:
 	/* Each operating system on an Alpha uses its own epoch.
 	   Let's try to guess which one we are using now. */
 	
-	uip_watchdog = jiffies;
 	if (rtc_is_updating() != 0)
-		while (jiffies - uip_watchdog < 2*HZ/100) {
-			barrier();
-			cpu_relax();
-		}
+		msleep(20);
 	
 	spin_lock_irq(&rtc_lock);
 	year = CMOS_READ(RTC_YEAR);
@@ -1213,7 +1208,6 @@ static int rtc_proc_open(struct inode *i

 void rtc_get_rtc_time(struct rtc_time *rtc_tm)
 {
-	unsigned long uip_watchdog = jiffies;
 	unsigned char ctrl;
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
@@ -1221,7 +1215,7 @@ void rtc_get_rtc_time(struct rtc_time *r

 	/*
 	 * read RTC once any update in progress is done. The update
-	 * can take just over 2ms. We wait 10 to 20ms. There is no need to
+	 * can take just over 2ms. We wait 20ms. There is no need to
 	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
 	 * If you need to know *exactly* when a second has started, enable
 	 * periodic update complete interrupts, (via ioctl) and then
@@ -1230,10 +1224,7 @@ void rtc_get_rtc_time(struct rtc_time *r
 	 */

 	if (rtc_is_updating() != 0)
-		while (jiffies - uip_watchdog < 2*HZ/100) {
-			barrier();
-			cpu_relax();
-		}
+		msleep(20);

 	/*
 	 * Only the values that we read from the RTC are set. We leave
--- ./kernel/irq/autoprobe.c.orig	2005-06-14 11:29:01.000000000 +0000
+++ ./kernel/irq/autoprobe.c	2005-06-14 11:29:08.000000000 +0000
@@ -45,8 +45,7 @@ unsigned long probe_irq_on(void)
 	}

 	/* Wait for longstanding interrupts to trigger. */
-	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ barrier();
+	msleep(20);

 	/*
 	 * enable any unassigned irqs
@@ -68,8 +67,7 @@ unsigned long probe_irq_on(void)
 	/*
 	 * Wait for spurious interrupts to trigger
 	 */
-	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ barrier();
+	msleep(100);

 	/*
 	 * Now filter out any obviously spurious interrupts


I'm a bit late. I'm having troubles with my ISP. Sorry.
Regards,
-- 
					Luca


