Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWD1QQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWD1QQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWD1QQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:16:16 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:25582 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030492AbWD1QQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:16:15 -0400
Date: Sat, 29 Apr 2006 01:16:48 +0900 (JST)
Message-Id: <20060429.011648.25910123.anemo@mba.ocn.ne.jp>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] RTC: rtc-dev UIE emulation
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Import genrtc's RTC UIE emulation (CONFIG_GEN_RTC_X) to rtc-dev driver
with slight adjustments.  This makes UIE-less chips/drivers work
better with programs doing read/poll on /dev/rtc, such as hwclock.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d090d..29ca46c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -73,6 +73,12 @@ config RTC_INTF_DEV
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-dev.
 
+config RTC_INTF_DEV_X
+	bool "Extended RTC operation"
+	depends on RTC_INTF_DEV
+	help
+	  Provides an emulation for RTC_UIE.
+
 comment "RTC drivers"
 	depends on RTC_CLASS
 
diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index b1e3e61..0bbd181 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -48,6 +48,93 @@ static int rtc_dev_open(struct inode *in
 	return err;
 }
 
+#ifdef CONFIG_RTC_INTF_DEV_X
+/*
+ * Routine to poll RTC seconds field for change as often as possible,
+ * after first RTC_UIE use timer to reduce polling
+ */
+static void rtc_uie_task(void *data)
+{
+	struct rtc_device *rtc = data;
+	struct rtc_time tm;
+	unsigned int tmp = rtc_read_time(&rtc->class_dev, &tm) ? 0 : tm.tm_sec;
+	int num = 0;
+
+	spin_lock_irq(&rtc->irq_lock);
+	if (rtc->stop_rtc_timers) {
+		rtc->stask_active = 0;
+		spin_unlock_irq(&rtc->irq_lock);
+		return;
+	}
+
+	if (rtc->oldsecs != tmp) {
+		num = (tmp + 60 - rtc->oldsecs) % 60;
+		rtc->oldsecs = tmp;
+
+		rtc->timer_task.expires = jiffies + HZ - (HZ/10);
+		rtc->ttask_active = 1;
+		rtc->stask_active = 0;
+		add_timer(&rtc->timer_task);
+	} else if (schedule_work(&rtc->uie_task) == 0)
+		rtc->stask_active = 0;
+	spin_unlock_irq(&rtc->irq_lock);
+	if (num)
+		rtc_update_irq(&rtc->class_dev, num, RTC_UF | RTC_IRQF);
+}
+
+static void rtc_uie_timer(unsigned long data)
+{
+	struct rtc_device *rtc = (struct rtc_device *)data;
+	unsigned long flags;
+	spin_lock_irqsave(&rtc->irq_lock, flags);
+	rtc->ttask_active = 0;
+	rtc->stask_active = 1;
+	if ((schedule_work(&rtc->uie_task) == 0))
+		rtc->stask_active = 0;
+	spin_unlock_irqrestore(&rtc->irq_lock, flags);
+}
+
+static void clear_uie(struct rtc_device *rtc)
+{
+	spin_lock_irq(&rtc->irq_lock);
+	rtc->stop_rtc_timers = 1;
+	if (rtc->ttask_active) {
+		spin_unlock_irq(&rtc->irq_lock);
+		del_timer_sync(&rtc->timer_task);
+		spin_lock(&rtc->irq_lock);
+		rtc->ttask_active = 0;
+	}
+	while (rtc->stask_active) {
+		spin_unlock_irq(&rtc->irq_lock);
+		schedule();
+		spin_lock_irq(&rtc->irq_lock);
+	}
+	rtc->irq_active = 0;
+	spin_unlock_irq(&rtc->irq_lock);
+}
+
+static void set_uie(struct rtc_device *rtc)
+{
+	int start = 0;
+	spin_lock_irq(&rtc->irq_lock);
+	if (!rtc->irq_active)
+		start = rtc->irq_active = 1;
+	rtc->irq_data = 0;
+	spin_unlock_irq(&rtc->irq_lock);
+	if (start) {
+		struct rtc_time tm;
+		rtc->stop_rtc_timers = 0;
+		INIT_WORK(&rtc->uie_task, rtc_uie_task, rtc);
+		rtc->oldsecs = rtc_read_time(&rtc->class_dev, &tm) ?
+			0 : tm.tm_sec;
+		setup_timer(&rtc->timer_task, rtc_uie_timer,
+			    (unsigned long)rtc);
+		rtc->stask_active = 1;
+		if (schedule_work(&rtc->uie_task) == 0)
+			rtc->stask_active = 0;
+	}
+}
+#endif /* CONFIG_RTC_INTF_DEV_X */
 
 static ssize_t
 rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
@@ -227,6 +314,15 @@ static int rtc_dev_ioctl(struct inode *i
 			return -EFAULT;
 		break;
 
+#ifdef CONFIG_RTC_INTF_DEV_X
+	case RTC_UIE_OFF:
+		clear_uie(rtc);
+		return 0;
+
+	case RTC_UIE_ON:
+	        set_uie(rtc);
+		return 0;
+#endif
 	default:
 		err = -EINVAL;
 		break;
@@ -239,6 +335,9 @@ static int rtc_dev_release(struct inode 
 {
 	struct rtc_device *rtc = to_rtc_device(file->private_data);
 
+#ifdef CONFIG_RTC_INTF_DEV_X
+	clear_uie(rtc);
+#endif
 	if (rtc->ops->release)
 		rtc->ops->release(rtc->class_dev.dev);
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index ab61cd1..29199c3 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -155,6 +155,15 @@ struct rtc_device
 	struct rtc_task *irq_task;
 	spinlock_t irq_task_lock;
 	int irq_freq;
+#ifdef CONFIG_RTC_INTF_DEV_X
+	struct work_struct uie_task;
+	struct timer_list timer_task;
+	unsigned int oldsecs;
+	unsigned int irq_active :1;
+	unsigned int stop_rtc_timers :1;	/* don't requeue tasks */
+	unsigned int stask_active :1;		/* schedule_work */
+	unsigned int ttask_active :1;		/* timer_task */
+#endif
 };
 #define to_rtc_device(d) container_of(d, struct rtc_device, class_dev)
 
