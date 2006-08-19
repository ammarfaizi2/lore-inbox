Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWHSQul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWHSQul (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWHSQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:50:41 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:863 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422686AbWHSQuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:50:40 -0400
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Sat, 19 Aug 2006 09:44:39 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <200608162247.41632.david-b@pacbell.net> <1155944198.5361.81.camel@localhost.localdomain> <200608190939.11421.david-b@pacbell.net>
In-Reply-To: <200608190939.11421.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608190944.40724.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 9:39 am, David Brownell wrote:
> > So if we go w/  the "it may not be available, so always assume it isn't"
> > way of thinking, it forces us to rely upon the RTC driver(s) to resume
> > time (which means every RTC, no matter how simple has to have
> > suspend/resume hooks and call settimeofday at least). 
> 
> No, that was the point of my comment about using the new class level
> suspend/resume calls.  The RTC drivers wouldn't be responsible for
> that; the RTC framework would be.  RTC drivers may still want the
> suspend/resume hooks to make sure they issue system wakeup events,
> and so on, but no longer for maintaining the wall clock.  I'll send
> a patch (of the "it compiles" type) later.

Welcome to "later"!

------------------------

Preliminary RTC class suspend/resume support:

 - Inlining the same code used by ARM, save and restore the delta between
   a selected RTC and the current system time.

 - Removes calls to that ARM code from the AT91 and S3C RTCs; the AT91
   calls are left as stubs, because a pending patch still needs those
   (currently empty) routines to properly issue system wakeup events.

 - Selects rtc0 by default, else CONFIG_RTC_HCTOSYS_DEVICE.  We expect all RTCs
   to be powered during "real" sleep states, but swsusp/hibernation requires
   something that's also battery-backed.

Depends on new class suspend/resume methods, added by a patch in the MM tree.

(Preliminary because untested, and because of a FIXME ... nothing recovers
from unregistering the selected RTC; that could happen only with badly written
RTC drivers though.)


Index: g26/drivers/rtc/class.c
===================================================================
--- g26.orig/drivers/rtc/class.c	2006-08-19 09:20:36.000000000 -0700
+++ g26/drivers/rtc/class.c	2006-08-19 09:20:37.000000000 -0700
@@ -29,6 +29,86 @@ static void rtc_device_release(struct cl
 	kfree(rtc);
 }
 
+#ifdef	CONFIG_PM
+
+/*
+ * Re-initialize wall clock on resume, to match the delta (calculated
+ * during suspend) between that and an appropriate RTC.
+ *
+ * We assume any RTC is good enough, meaning it stays running during
+ * system sleep states; but prefer the CONFIG_RTC_HCTOSYS_DEVICE on
+ * the grounds that it's expected to be battery-backed and thus will
+ * stay running even during the "off" states used by swsusp.
+ *
+ * REVISIT ... we should probably have a way to tell if a given RTC
+ * will stay powered during the target system state, rather than just
+ * assume a "valid" configuration (where no RTC that powers off will
+ * be selected, and no selected RTC will be removed).  That could let
+ * us get rid of the need for CONFIG_RTC_HCTOSYS_DEVICE too...
+ */
+
+static struct class_device	*sleep_rtc;
+static struct timespec		delta;
+
+static int rtc_suspend(struct device *dev, pm_message_t mesg)
+{
+	struct rtc_time tm;
+	struct timespec time;
+
+	if (!sleep_rtc || dev != sleep_rtc->dev)
+		return 0;
+
+	time.tv_nsec = 0;
+
+	rtc_read_time(sleep_rtc, &tm);
+	rtc_tm_to_time(&tm, &time.tv_sec);
+
+	set_normalized_timespec(&delta,
+				xtime.tv_sec - time.tv_sec,
+				xtime.tv_nsec - time.tv_nsec);
+
+	pr_debug("%s:  %s %4d-%02d-%02d %02d:%02d:%02d\n",
+		sleep_rtc->class_id, "suspend",
+		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
+		tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	return 0;
+}
+
+static int rtc_resume(struct device *dev)
+{
+	struct rtc_time tm;
+	struct timespec time;
+
+	/* REVISIT some swsusp configurations may feed us an RTC that
+	 * lost power ... we should probably try detecting that, and
+	 * refuse to update the time using a bogus clock.
+	 */
+
+	if (!sleep_rtc || dev != sleep_rtc->dev)
+		return 0;
+
+	time.tv_nsec = 0;
+
+	rtc_read_time(sleep_rtc, &tm);
+	rtc_tm_to_time(&tm, &time.tv_sec);
+
+	set_normalized_timespec(&time,
+				xtime.tv_sec - time.tv_sec,
+				xtime.tv_nsec - time.tv_nsec);
+	do_settimeofday(&time);
+
+	pr_debug("%s:  %s %4d-%02d-%02d %02d:%02d:%02d\n",
+		sleep_rtc->class_id, "resume",
+		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
+		tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	return 0;
+}
+
+#endif
+
+
 /**
  * rtc_device_register - register w/ RTC class
  * @dev: the device to register
@@ -85,6 +165,21 @@ struct rtc_device *rtc_device_register(c
 	if (err)
 		goto exit_kfree;
 
+#ifdef	CONFIG_PM
+	mutex_lock(&idr_lock);
+#ifdef CONFIG_RTC_HCTOSYS_DEVICE
+	if (sleep_rtc && strncmp(rtc->class_dev.class_id,
+				CONFIG_RTC_HCTOSYS_DEVICE,
+				BUS_ID_SIZE) == 0) {
+		rtc_class_close(sleep_rtc);
+		sleep_rtc = NULL;
+	}
+#endif
+	if (!sleep_rtc)
+		sleep_rtc = rtc_class_open(rtc->class_dev.class_id);
+	mutex_unlock(&idr_lock);
+#endif
+
 	dev_info(dev, "rtc core: registered %s as %s\n",
 			rtc->name, rtc->class_dev.class_id);
 
@@ -113,6 +208,17 @@ EXPORT_SYMBOL_GPL(rtc_device_register);
  */
 void rtc_device_unregister(struct rtc_device *rtc)
 {
+#ifdef	CONFIG_PM
+	mutex_lock(&idr_lock);
+	if (&rtc->class_dev == sleep_rtc) {
+		rtc_class_close(sleep_rtc);
+		sleep_rtc = NULL;
+		/* FIXME */
+		printk(KERN_WARNING "rtc: now what to use during sleep??\n");
+	}
+	mutex_unlock(&idr_lock);
+#endif
+
 	mutex_lock(&rtc->ops_lock);
 	rtc->ops = NULL;
 	mutex_unlock(&rtc->ops_lock);
@@ -134,6 +240,10 @@ static int __init rtc_init(void)
 		printk(KERN_ERR "%s: couldn't create class\n", __FILE__);
 		return PTR_ERR(rtc_class);
 	}
+#ifdef	CONFIG_PM
+	rtc_class->suspend = rtc_suspend;
+	rtc_class->resume = rtc_resume;
+#endif
 	return 0;
 }
 
Index: g26/drivers/rtc/rtc-at91.c
===================================================================
--- g26.orig/drivers/rtc/rtc-at91.c	2006-08-19 09:20:36.000000000 -0700
+++ g26/drivers/rtc/rtc-at91.c	2006-08-19 09:20:37.000000000 -0700
@@ -339,38 +339,13 @@ static struct timespec at91_rtc_delta;
 
 static int at91_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec = 0;
-
-	/* calculate time delta for suspend */
-	at91_rtc_readtime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	save_time_delta(&at91_rtc_delta, &time);
-
-	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
-		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec);
-
+	/* STUB, pending merge of rtc wakeup patch */
 	return 0;
 }
 
 static int at91_rtc_resume(struct platform_device *pdev)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec = 0;
-
-	at91_rtc_readtime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	restore_time_delta(&at91_rtc_delta, &time);
-
-	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
-		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec);
-
+	/* STUB, pending merge of rtc wakeup patch */
 	return 0;
 }
 #else
Index: g26/drivers/rtc/rtc-s3c.c
===================================================================
--- g26.orig/drivers/rtc/rtc-s3c.c	2006-08-19 09:20:36.000000000 -0700
+++ g26/drivers/rtc/rtc-s3c.c	2006-08-19 09:20:37.000000000 -0700
@@ -536,37 +536,15 @@ static int ticnt_save;
 
 static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec = 0;
-
 	/* save TICNT for anyone using periodic interrupts */
-
 	ticnt_save = readb(S3C2410_TICNT);
-
-	/* calculate time delta for suspend */
-
-	s3c_rtc_gettime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	save_time_delta(&s3c_rtc_delta, &time);
 	s3c_rtc_enable(pdev, 0);
-
 	return 0;
 }
 
 static int s3c_rtc_resume(struct platform_device *pdev)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec = 0;
-
 	s3c_rtc_enable(pdev, 1);
-	s3c_rtc_gettime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	restore_time_delta(&s3c_rtc_delta, &time);
-
 	writeb(ticnt_save, S3C2410_TICNT);
 	return 0;
 }
