Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755614AbWKQJgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbWKQJgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbWKQJgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:36:23 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:56192 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755616AbWKQJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:36:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=6OpObVToXBtoczBSrqinLgobUlqsuOxV7RVBwO9yzSGQTM1qTfEKWeooGgOYCUayB9PERzR8GvXwzfGHVLyUUdXcny3UvRIQrQRhIFi5alQOQISROzf5L2XlJ3QhpCFag+OBmxDRmX6Qg3mHaLDjRp9PGR3XGOT8H+1uZNz212s=  ;
X-YMail-OSG: coRJPZIVM1n11.rbMaUXwLYdomLu7PrSXCpoUeRiaW4vPKfaWgGswsHv27FJ13kFXZ283hN6sKMjEXFEf5UWtXWG9hFW4E4c06wpqRmW6pExpaxhyOpi4A--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-rc6] rtc class locking bugfixes
Date: Thu, 16 Nov 2006 23:27:37 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611162327.37306.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a lockdep warning when running "rtctest" so I though it'd be good
to see what was up.

 - The warning was for rtc->irq_task_lock, gotten from rtc_update_irq()
   by irq handlerss ... but in a handful of other cases, grabbed without
   blocking IRQs.

 - Some callers to rtc_update_irq() were not ensuring IRQs were blocked,
   yet the routine expects that; make sure all callers block IRQs.

It would appear that RTC API tests haven't been part of anyone's kernel
regression test suite recently, at least not with lockdep running.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/interface.c
===================================================================
--- g26.orig/drivers/rtc/interface.c	2006-06-28 22:02:19.000000000 -0700
+++ g26/drivers/rtc/interface.c	2006-11-16 21:54:35.000000000 -0800
@@ -145,6 +145,13 @@ int rtc_set_alarm(struct class_device *c
 }
 EXPORT_SYMBOL_GPL(rtc_set_alarm);
 
+/**
+ * rtc_update_irq - report RTC periodic, alarm, and/or update irqs
+ * @class_dev: the rtc's class device
+ * @num: how many irqs are being reported (usually one)
+ * @events: mask of RTC_IRQF with one or more of RTC_PF, RTC_AF, RTC_UF
+ * Context: in_interrupt(), irqs blocked
+ */
 void rtc_update_irq(struct class_device *class_dev,
 		unsigned long num, unsigned long events)
 {
@@ -201,12 +208,12 @@ int rtc_irq_register(struct class_device
 	if (task == NULL || task->func == NULL)
 		return -EINVAL;
 
-	spin_lock(&rtc->irq_task_lock);
+	spin_lock_irq(&rtc->irq_task_lock);
 	if (rtc->irq_task == NULL) {
 		rtc->irq_task = task;
 		retval = 0;
 	}
-	spin_unlock(&rtc->irq_task_lock);
+	spin_unlock_irq(&rtc->irq_task_lock);
 
 	return retval;
 }
@@ -216,10 +223,10 @@ void rtc_irq_unregister(struct class_dev
 {
 	struct rtc_device *rtc = to_rtc_device(class_dev);
 
-	spin_lock(&rtc->irq_task_lock);
+	spin_lock_irq(&rtc->irq_task_lock);
 	if (rtc->irq_task == task)
 		rtc->irq_task = NULL;
-	spin_unlock(&rtc->irq_task_lock);
+	spin_unlock_irq(&rtc->irq_task_lock);
 }
 EXPORT_SYMBOL_GPL(rtc_irq_unregister);
 
Index: g26/drivers/rtc/rtc-dev.c
===================================================================
--- g26.orig/drivers/rtc/rtc-dev.c	2006-11-16 19:44:52.000000000 -0800
+++ g26/drivers/rtc/rtc-dev.c	2006-11-16 21:37:45.000000000 -0800
@@ -61,7 +61,9 @@ static void rtc_uie_task(void *data)
 	int err;
 
 	err = rtc_read_time(&rtc->class_dev, &tm);
-	spin_lock_irq(&rtc->irq_lock);
+
+	local_irq_disable();
+	spin_lock(&rtc->irq_lock);
 	if (rtc->stop_uie_polling || err) {
 		rtc->uie_task_active = 0;
 	} else if (rtc->oldsecs != tm.tm_sec) {
@@ -74,11 +76,11 @@ static void rtc_uie_task(void *data)
 	} else if (schedule_work(&rtc->uie_task) == 0) {
 		rtc->uie_task_active = 0;
 	}
-	spin_unlock_irq(&rtc->irq_lock);
+	spin_unlock(&rtc->irq_lock);
 	if (num)
 		rtc_update_irq(&rtc->class_dev, num, RTC_UF | RTC_IRQF);
+	local_irq_enable();
 }
-
 static void rtc_uie_timer(unsigned long data)
 {
 	struct rtc_device *rtc = (struct rtc_device *)data;
@@ -238,10 +240,10 @@ static int rtc_dev_ioctl(struct inode *i
 
 	/* avoid conflicting IRQ users */
 	if (cmd == RTC_PIE_ON || cmd == RTC_PIE_OFF || cmd == RTC_IRQP_SET) {
-		spin_lock(&rtc->irq_task_lock);
+		spin_lock_irq(&rtc->irq_task_lock);
 		if (rtc->irq_task)
 			err = -EBUSY;
-		spin_unlock(&rtc->irq_task_lock);
+		spin_unlock_irq(&rtc->irq_task_lock);
 
 		if (err < 0)
 			return err;
Index: g26/drivers/rtc/rtc-at91.c
===================================================================
--- g26.orig/drivers/rtc/rtc-at91.c	2006-11-16 18:47:20.000000000 -0800
+++ g26/drivers/rtc/rtc-at91.c	2006-11-16 19:46:11.000000000 -0800
@@ -292,7 +292,8 @@ static int __init at91_rtc_probe(struct 
 					AT91_RTC_CALEV);
 
 	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
-				IRQF_SHARED, "at91_rtc", pdev);
+				IRQF_DISABLED | IRQF_SHARED,
+				"at91_rtc", pdev);
 	if (ret) {
 		printk(KERN_ERR "at91_rtc: IRQ %d already in use.\n",
 				AT91_ID_SYS);
Index: g26/drivers/rtc/rtc-ds1553.c
===================================================================
--- g26.orig/drivers/rtc/rtc-ds1553.c	2006-10-13 15:41:11.000000000 -0700
+++ g26/drivers/rtc/rtc-ds1553.c	2006-11-16 19:47:08.000000000 -0800
@@ -340,7 +340,8 @@ static int __init ds1553_rtc_probe(struc
 
 	if (pdata->irq >= 0) {
 		writeb(0, ioaddr + RTC_INTERRUPTS);
-		if (request_irq(pdata->irq, ds1553_rtc_interrupt, IRQF_SHARED,
+		if (request_irq(pdata->irq, ds1553_rtc_interrupt,
+				IRQF_DISABLED | IRQF_SHARED,
 				pdev->name, pdev) < 0) {
 			dev_warn(&pdev->dev, "interrupt not available.\n");
 			pdata->irq = -1;
Index: g26/drivers/rtc/rtc-test.c
===================================================================
--- g26.orig/drivers/rtc/rtc-test.c	2006-10-05 19:43:53.000000000 -0700
+++ g26/drivers/rtc/rtc-test.c	2006-11-16 19:50:33.000000000 -0800
@@ -99,6 +99,7 @@ static ssize_t test_irq_store(struct dev
 	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
 
 	retval = count;
+	local_irq_disable();
 	if (strncmp(buf, "tick", 4) == 0)
 		rtc_update_irq(&rtc->class_dev, 1, RTC_PF | RTC_IRQF);
 	else if (strncmp(buf, "alarm", 5) == 0)
@@ -107,6 +108,7 @@ static ssize_t test_irq_store(struct dev
 		rtc_update_irq(&rtc->class_dev, 1, RTC_UF | RTC_IRQF);
 	else
 		retval = -EINVAL;
+	local_irq_enable();
 
 	return retval;
 }
