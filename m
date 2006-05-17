Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWEQAUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWEQAUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWEQAUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:20:25 -0400
Received: from mx0.towertech.it ([213.215.222.73]:27065 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932385AbWEQATy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:19:54 -0400
Date: Wed, 17 May 2006 02:14:14 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>,
       Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] rtc subsystem, add capability checks
Message-ID: <20060517021414.13d3733b@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Centralize CAP_SYS_XXX checks to avoid
duplicate code and missing checks in the drivers.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

---
 drivers/rtc/class.c      |    1 +
 drivers/rtc/rtc-dev.c    |   29 ++++++++++++++++++++++-------
 drivers/rtc/rtc-sa1100.c |    4 ----
 drivers/rtc/rtc-vr41xx.c |    8 --------
 include/linux/rtc.h      |    1 +
 5 files changed, 24 insertions(+), 19 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-dev.c	2006-05-17 01:26:01.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-dev.c	2006-05-17 01:58:46.000000000 +0200
@@ -127,6 +127,28 @@ static int rtc_dev_ioctl(struct inode *i
 	struct rtc_wkalrm alarm;
 	void __user *uarg = (void __user *) arg;
 
+	/* check that the calles has appropriate permissions
+	 * for certain ioctls. doing this check here is useful
+	 * to avoid duplicate code in each driver.
+	 */
+	switch (cmd) {
+	case RTC_EPOCH_SET:
+	case RTC_SET_TIME:
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+		break;
+
+	case RTC_IRQP_SET:
+		if (arg > rtc->max_user_freq && !capable(CAP_SYS_RESOURCE))
+			return -EACCES;
+		break;
+
+	case RTC_PIE_ON:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EACCES;
+		break;
+	}
+
 	/* avoid conflicting IRQ users */
 	if (cmd == RTC_PIE_ON || cmd == RTC_PIE_OFF || cmd == RTC_IRQP_SET) {
 		spin_lock(&rtc->irq_task_lock);
@@ -185,9 +207,6 @@ static int rtc_dev_ioctl(struct inode *i
 		break;
 
 	case RTC_SET_TIME:
-		if (!capable(CAP_SYS_TIME))
-			return -EACCES;
-
 		if (copy_from_user(&tm, uarg, sizeof(tm)))
 			return -EFAULT;
 
@@ -203,10 +222,6 @@ static int rtc_dev_ioctl(struct inode *i
 			err = -EINVAL;
 			break;
 		}
-		if (!capable(CAP_SYS_TIME)) {
-			err = -EACCES;
-			break;
-		}
 		rtc_epoch = arg;
 		err = 0;
 #endif
--- linux-rtc.orig/include/linux/rtc.h	2006-05-17 01:18:22.000000000 +0200
+++ linux-rtc/include/linux/rtc.h	2006-05-17 01:53:43.000000000 +0200
@@ -155,6 +155,7 @@ struct rtc_device
 	struct rtc_task *irq_task;
 	spinlock_t irq_task_lock;
 	int irq_freq;
+	int max_user_freq;
 };
 #define to_rtc_device(d) container_of(d, struct rtc_device, class_dev)
 
--- linux-rtc.orig/drivers/rtc/class.c	2006-05-17 01:18:19.000000000 +0200
+++ linux-rtc/drivers/rtc/class.c	2006-05-17 02:01:10.000000000 +0200
@@ -69,6 +69,7 @@ struct rtc_device *rtc_device_register(c
 	rtc->id = id;
 	rtc->ops = ops;
 	rtc->owner = owner;
+	rtc->max_user_freq = 64;
 	rtc->class_dev.dev = dev;
 	rtc->class_dev.class = rtc_class;
 	rtc->class_dev.release = rtc_device_release;
--- linux-rtc.orig/drivers/rtc/rtc-sa1100.c	2006-05-17 01:23:26.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-sa1100.c	2006-05-17 02:02:50.000000000 +0200
@@ -229,8 +229,6 @@ static int sa1100_rtc_ioctl(struct devic
 		spin_unlock_irq(&sa1100_rtc_lock);
 		return 0;
 	case RTC_PIE_ON:
-		if ((rtc_freq > 64) && !capable(CAP_SYS_RESOURCE))
-			return -EACCES;
 		spin_lock_irq(&sa1100_rtc_lock);
 		OSMR1 = TIMER_FREQ/rtc_freq + OSCR;
 		OIER |= OIER_E1;
@@ -242,8 +240,6 @@ static int sa1100_rtc_ioctl(struct devic
 	case RTC_IRQP_SET:
 		if (arg < 1 || arg > TIMER_FREQ)
 			return -EINVAL;
-		if ((arg > 64) && (!capable(CAP_SYS_RESOURCE)))
-			return -EACCES;
 		rtc_freq = arg;
 		return 0;
 	}
--- linux-rtc.orig/drivers/rtc/rtc-vr41xx.c	2006-05-17 01:22:29.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-vr41xx.c	2006-05-17 02:03:47.000000000 +0200
@@ -81,7 +81,6 @@ MODULE_LICENSE("GPL");
 
 #define RTC_FREQUENCY		32768
 #define MAX_PERIODIC_RATE	6553
-#define MAX_USER_PERIODIC_RATE	64
 
 static void __iomem *rtc1_base;
 static void __iomem *rtc2_base;
@@ -240,9 +239,6 @@ static int vr41xx_rtc_ioctl(struct devic
 		if (arg > MAX_PERIODIC_RATE)
 			return -EINVAL;
 
-		if (arg > MAX_USER_PERIODIC_RATE && capable(CAP_SYS_RESOURCE) == 0)
-			return -EACCES;
-
 		periodic_frequency = arg;
 
 		count = RTC_FREQUENCY;
@@ -263,10 +259,6 @@ static int vr41xx_rtc_ioctl(struct devic
 		/* Doesn't support before 1900 */
 		if (arg < 1900)
 			return -EINVAL;
-
-		if (capable(CAP_SYS_TIME) == 0)
-			return -EACCES;
-
 		epoch = arg;
 		break;
 	default:
