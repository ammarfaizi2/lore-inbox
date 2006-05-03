Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWECQmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWECQmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWECQmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:42:49 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:19156 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030244AbWECQms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:42:48 -0400
Date: Thu, 04 May 2006 01:43:24 +0900 (JST)
Message-Id: <20060504.014324.25910986.anemo@mba.ocn.ne.jp>
To: alessandro.zummo@towertech.it
Cc: akpm@osdl.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: rtc-dev UIE emulation
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060502221535.01692c24@inspiron>
References: <20060430.001003.52129547.anemo@mba.ocn.ne.jp>
	<20060501.233242.59466338.anemo@mba.ocn.ne.jp>
	<20060502221535.01692c24@inspiron>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 22:15:35 +0200, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> > Here is an updated patch.  I think this one reflects all suggestions
> > by Andrew.
> 
>  seems ok to me, just a few comments:

Thank you for comments.  Here is an updated patch.  Kconfig help-text
fixes and initialization cleanup.


Import genrtc's RTC UIE emulation (CONFIG_GEN_RTC_X) to rtc-dev driver
with slight adjustments/refinements.  This makes UIE-less rtc drivers
work better with programs doing read/poll on /dev/rtc.  This emulation
should not harm rtc drivers with UIE support, since rtc_dev_ioctl()
calls underlaying rtc driver's ioctl() first.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d090d..6d3ecf2 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -73,6 +73,13 @@ config RTC_INTF_DEV
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-dev.
 
+config RTC_INTF_DEV_UIE_EMUL
+	bool "RTC UIE emulation on dev interface"
+	depends on RTC_INTF_DEV
+	help
+	  Provides an emulation for RTC_UIE if the underlaying rtc chip
+	  driver did not provide RTC_UIE ioctls.
+
 comment "RTC drivers"
 	depends on RTC_CLASS
 
diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 6c9ad92..12893b7 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -48,6 +48,93 @@ static int rtc_dev_open(struct inode *in
 	return err;
 }
 
+#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
+/*
+ * Routine to poll RTC seconds field for change as often as possible,
+ * after first RTC_UIE use timer to reduce polling
+ */
+static void rtc_uie_task(void *data)
+{
+	struct rtc_device *rtc = data;
+	struct rtc_time tm;
+	int num = 0;
+	int err;
+
+	err = rtc_read_time(&rtc->class_dev, &tm);
+	spin_lock_irq(&rtc->irq_lock);
+	if (rtc->stop_uie_polling || err) {
+		rtc->uie_task_active = 0;
+	} else if (rtc->oldsecs != tm.tm_sec) {
+		num = (tm.tm_sec + 60 - rtc->oldsecs) % 60;
+		rtc->oldsecs = tm.tm_sec;
+		rtc->uie_timer.expires = jiffies + HZ - (HZ/10);
+		rtc->uie_timer_active = 1;
+		rtc->uie_task_active = 0;
+		add_timer(&rtc->uie_timer);
+	} else if (schedule_work(&rtc->uie_task) == 0) {
+		rtc->uie_task_active = 0;
+	}
+	spin_unlock_irq(&rtc->irq_lock);
+	if (num)
+		rtc_update_irq(&rtc->class_dev, num, RTC_UF | RTC_IRQF);
+}
+
+static void rtc_uie_timer(unsigned long data)
+{
+	struct rtc_device *rtc = (struct rtc_device *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc->irq_lock, flags);
+	rtc->uie_timer_active = 0;
+	rtc->uie_task_active = 1;
+	if ((schedule_work(&rtc->uie_task) == 0))
+		rtc->uie_task_active = 0;
+	spin_unlock_irqrestore(&rtc->irq_lock, flags);
+}
+
+static void clear_uie(struct rtc_device *rtc)
+{
+	spin_lock_irq(&rtc->irq_lock);
+	if (rtc->irq_active) {
+		rtc->stop_uie_polling = 1;
+		if (rtc->uie_timer_active) {
+			spin_unlock_irq(&rtc->irq_lock);
+			del_timer_sync(&rtc->uie_timer);
+			spin_lock_irq(&rtc->irq_lock);
+			rtc->uie_timer_active = 0;
+		}
+		if (rtc->uie_task_active) {
+			spin_unlock_irq(&rtc->irq_lock);
+			flush_scheduled_work();
+			spin_lock_irq(&rtc->irq_lock);
+		}
+		rtc->irq_active = 0;
+	}
+	spin_unlock_irq(&rtc->irq_lock);
+}
+
+static int set_uie(struct rtc_device *rtc)
+{
+	struct rtc_time tm;
+	int err;
+
+	err = rtc_read_time(&rtc->class_dev, &tm);
+	if (err)
+		return err;
+	spin_lock_irq(&rtc->irq_lock);
+	if (!rtc->irq_active) {
+		rtc->irq_active = 1;
+		rtc->stop_uie_polling = 0;
+		rtc->oldsecs = tm.tm_sec;
+		rtc->uie_task_active = 1;
+		if (schedule_work(&rtc->uie_task) == 0)
+			rtc->uie_task_active = 0;
+	}
+	rtc->irq_data = 0;
+	spin_unlock_irq(&rtc->irq_lock);
+	return 0;
+}
+#endif /* CONFIG_RTC_INTF_DEV_UIE_EMUL */
 
 static ssize_t
 rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
@@ -232,6 +319,14 @@ static int rtc_dev_ioctl(struct inode *i
 			return -EFAULT;
 		break;
 
+#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
+	case RTC_UIE_OFF:
+		clear_uie(rtc);
+		return 0;
+
+	case RTC_UIE_ON:
+		return set_uie(rtc);
+#endif
 	default:
 		err = -EINVAL;
 		break;
@@ -244,6 +339,9 @@ static int rtc_dev_release(struct inode 
 {
 	struct rtc_device *rtc = to_rtc_device(file->private_data);
 
+#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
+	clear_uie(rtc);
+#endif
 	if (rtc->ops->release)
 		rtc->ops->release(rtc->class_dev.dev);
 
@@ -284,6 +382,10 @@ static int rtc_dev_add_device(struct cla
 	mutex_init(&rtc->char_lock);
 	spin_lock_init(&rtc->irq_lock);
 	init_waitqueue_head(&rtc->irq_queue);
+#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
+	INIT_WORK(&rtc->uie_task, rtc_uie_task, rtc);
+	setup_timer(&rtc->uie_timer, rtc_uie_timer, (unsigned long)rtc);
+#endif
 
 	cdev_init(&rtc->char_dev, &rtc_dev_fops);
 	rtc->char_dev.owner = rtc->owner;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index ab61cd1..4331076 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -155,6 +155,16 @@ struct rtc_device
 	struct rtc_task *irq_task;
 	spinlock_t irq_task_lock;
 	int irq_freq;
+#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
+	struct work_struct uie_task;
+	struct timer_list uie_timer;
+	/* Those fields are protected by rtc->irq_lock */
+	unsigned int oldsecs;
+	unsigned int irq_active:1;
+	unsigned int stop_uie_polling:1;
+	unsigned int uie_task_active:1;
+	unsigned int uie_timer_active:1;
+#endif
 };
 #define to_rtc_device(d) container_of(d, struct rtc_device, class_dev)
 
