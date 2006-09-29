Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161447AbWI2Gkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161447AbWI2Gkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWI2Gkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:40:35 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:51046 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161447AbWI2Gkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:40:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=qRwyLZzCsWC03MrjfoJ+RYG39D/0PIWEcHrh9b0spfeNhjINg/eqKrTLf3F7jUvzLurC0KLd3C8bJq39ZbHg8DUnYSxXBrrPXCMPIwW1Too/JbmPZDg1/M2QTYdKw0rRdliRKP1YNlySpT8VbfcvssktmmQTG15fi1yUgFHmBQs=  ;
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.18-git] AT91rm9200 RTC can issue system wakeup events
Date: Thu, 28 Sep 2006 23:40:31 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609282340.31792.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ RESEND ]

This lets the at91rm9200 RTC alarm be a system wakeup irq, according
to the setting of /sys/devices/platform/at91_rtc/power/wakeup.  User
code can set the alarm, put the system into a low power mode, and then
rely on it waking up no later than the specified moment.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/drivers/rtc/rtc-at91.c
===================================================================
--- at91.orig/drivers/rtc/rtc-at91.c	2006-07-30 01:17:33.000000000 -0700
+++ at91/drivers/rtc/rtc-at91.c	2006-07-30 01:44:19.000000000 -0700
@@ -307,6 +307,7 @@ static int __init at91_rtc_probe(struct 
 		return PTR_ERR(rtc);
 	}
 	platform_set_drvdata(pdev, rtc);
+	device_init_wakeup(&pdev->dev, 1);
 
 	printk(KERN_INFO "AT91 Real Time Clock driver.\n");
 	return 0;
@@ -327,6 +328,7 @@ static int __devexit at91_rtc_remove(str
 
 	rtc_device_unregister(rtc);
 	platform_set_drvdata(pdev, NULL);
+	device_init_wakeup(&pdev->dev, 0);
 
 	return 0;
 }
@@ -336,6 +338,7 @@ static int __devexit at91_rtc_remove(str
 /* AT91RM9200 RTC Power management control */
 
 static struct timespec at91_rtc_delta;
+static u32 at91_rtc_imr;
 
 static int at91_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -349,6 +352,18 @@ static int at91_rtc_suspend(struct platf
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	save_time_delta(&at91_rtc_delta, &time);
 
+	/* this IRQ is shared with DBGU and other hardware which isn't
+	 * necessarily doing PM like we are...
+	 */
+	at91_rtc_imr = at91_sys_read(AT91_RTC_IMR)
+			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
+	if (at91_rtc_imr) {
+		if (device_may_wakeup(&pdev->dev))
+			enable_irq_wake(AT91_ID_SYS);
+		else
+			at91_sys_write(AT91_RTC_IDR, at91_rtc_imr);
+	}
+
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
 		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
 		tm.tm_hour, tm.tm_min, tm.tm_sec);
@@ -367,6 +382,13 @@ static int at91_rtc_resume(struct platfo
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	restore_time_delta(&at91_rtc_delta, &time);
 
+	if (at91_rtc_imr) {
+		if (device_may_wakeup(&pdev->dev))
+			disable_irq_wake(AT91_ID_SYS);
+		else
+			at91_sys_write(AT91_RTC_IER, at91_rtc_imr);
+	}
+
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
 		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
 		tm.tm_hour, tm.tm_min, tm.tm_sec);
