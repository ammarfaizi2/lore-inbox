Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVKVVGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVKVVGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVKVVGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:06:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965185AbVKVVGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:06:52 -0500
Date: Tue, 22 Nov 2005 13:06:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Takashi Iwai <tiwai@suse.de>
Subject: [patch 03/23] [PATCH] Fix soft lockup with ALSA rtc-timer
Message-ID: <20051122210613.GD28140@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-soft-lockup-with-ALSA-rtc-timer.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fixed the soft lockup of ALSA rtc-timer due to the wrong irq
handling in rtc_control().  The call of rtc_control() can be atomic.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/rtc.c |   65 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

--- linux-2.6.14.2.orig/drivers/char/rtc.c
+++ linux-2.6.14.2/drivers/char/rtc.c
@@ -149,8 +149,22 @@ static void get_rtc_alm_time (struct rtc
 #ifdef RTC_IRQ
 static void rtc_dropped_irq(unsigned long data);
 
-static void set_rtc_irq_bit(unsigned char bit);
-static void mask_rtc_irq_bit(unsigned char bit);
+static void set_rtc_irq_bit_locked(unsigned char bit);
+static void mask_rtc_irq_bit_locked(unsigned char bit);
+
+static inline void set_rtc_irq_bit(unsigned char bit)
+{
+	spin_lock_irq(&rtc_lock);
+	set_rtc_irq_bit_locked(bit);
+	spin_unlock_irq(&rtc_lock);
+}
+
+static void mask_rtc_irq_bit(unsigned char bit)
+{
+	spin_lock_irq(&rtc_lock);
+	mask_rtc_irq_bit_locked(bit);
+	spin_unlock_irq(&rtc_lock);
+}
 #endif
 
 static int rtc_proc_open(struct inode *inode, struct file *file);
@@ -401,18 +415,19 @@ static int rtc_do_ioctl(unsigned int cmd
 	}
 	case RTC_PIE_OFF:	/* Mask periodic int. enab. bit	*/
 	{
-		mask_rtc_irq_bit(RTC_PIE);
+		unsigned long flags; /* can be called from isr via rtc_control() */
+		spin_lock_irqsave (&rtc_lock, flags);
+		mask_rtc_irq_bit_locked(RTC_PIE);
 		if (rtc_status & RTC_TIMER_ON) {
-			spin_lock_irq (&rtc_lock);
 			rtc_status &= ~RTC_TIMER_ON;
 			del_timer(&rtc_irq_timer);
-			spin_unlock_irq (&rtc_lock);
 		}
+		spin_unlock_irqrestore (&rtc_lock, flags);
 		return 0;
 	}
 	case RTC_PIE_ON:	/* Allow periodic ints		*/
 	{
-
+		unsigned long flags; /* can be called from isr via rtc_control() */
 		/*
 		 * We don't really want Joe User enabling more
 		 * than 64Hz of interrupts on a multi-user machine.
@@ -421,14 +436,14 @@ static int rtc_do_ioctl(unsigned int cmd
 			(!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
+		spin_lock_irqsave (&rtc_lock, flags);
 		if (!(rtc_status & RTC_TIMER_ON)) {
-			spin_lock_irq (&rtc_lock);
 			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
 			add_timer(&rtc_irq_timer);
 			rtc_status |= RTC_TIMER_ON;
-			spin_unlock_irq (&rtc_lock);
 		}
-		set_rtc_irq_bit(RTC_PIE);
+		set_rtc_irq_bit_locked(RTC_PIE);
+		spin_unlock_irqrestore (&rtc_lock, flags);
 		return 0;
 	}
 	case RTC_UIE_OFF:	/* Mask ints from RTC updates.	*/
@@ -609,6 +624,7 @@ static int rtc_do_ioctl(unsigned int cmd
 	{
 		int tmp = 0;
 		unsigned char val;
+		unsigned long flags; /* can be called from isr via rtc_control() */
 
 		/* 
 		 * The max we can do is 8192Hz.
@@ -631,9 +647,9 @@ static int rtc_do_ioctl(unsigned int cmd
 		if (arg != (1<<tmp))
 			return -EINVAL;
 
-		spin_lock_irq(&rtc_lock);
+		spin_lock_irqsave(&rtc_lock, flags);
 		if (hpet_set_periodic_freq(arg)) {
-			spin_unlock_irq(&rtc_lock);
+			spin_unlock_irqrestore(&rtc_lock, flags);
 			return 0;
 		}
 		rtc_freq = arg;
@@ -641,7 +657,7 @@ static int rtc_do_ioctl(unsigned int cmd
 		val = CMOS_READ(RTC_FREQ_SELECT) & 0xf0;
 		val |= (16 - tmp);
 		CMOS_WRITE(val, RTC_FREQ_SELECT);
-		spin_unlock_irq(&rtc_lock);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 		return 0;
 	}
 #endif
@@ -844,12 +860,15 @@ int rtc_control(rtc_task_t *task, unsign
 #ifndef RTC_IRQ
 	return -EIO;
 #else
-	spin_lock_irq(&rtc_task_lock);
+	unsigned long flags;
+	if (cmd != RTC_PIE_ON && cmd != RTC_PIE_OFF && cmd != RTC_IRQP_SET)
+		return -EINVAL;
+	spin_lock_irqsave(&rtc_task_lock, flags);
 	if (rtc_callback != task) {
-		spin_unlock_irq(&rtc_task_lock);
+		spin_unlock_irqrestore(&rtc_task_lock, flags);
 		return -ENXIO;
 	}
-	spin_unlock_irq(&rtc_task_lock);
+	spin_unlock_irqrestore(&rtc_task_lock, flags);
 	return rtc_do_ioctl(cmd, arg, 1);
 #endif
 }
@@ -1306,40 +1325,32 @@ static void get_rtc_alm_time(struct rtc_
  * meddles with the interrupt enable/disable bits.
  */
 
-static void mask_rtc_irq_bit(unsigned char bit)
+static void mask_rtc_irq_bit_locked(unsigned char bit)
 {
 	unsigned char val;
 
-	spin_lock_irq(&rtc_lock);
-	if (hpet_mask_rtc_irq_bit(bit)) {
-		spin_unlock_irq(&rtc_lock);
+	if (hpet_mask_rtc_irq_bit(bit))
 		return;
-	}
 	val = CMOS_READ(RTC_CONTROL);
 	val &=  ~bit;
 	CMOS_WRITE(val, RTC_CONTROL);
 	CMOS_READ(RTC_INTR_FLAGS);
 
 	rtc_irq_data = 0;
-	spin_unlock_irq(&rtc_lock);
 }
 
-static void set_rtc_irq_bit(unsigned char bit)
+static void set_rtc_irq_bit_locked(unsigned char bit)
 {
 	unsigned char val;
 
-	spin_lock_irq(&rtc_lock);
-	if (hpet_set_rtc_irq_bit(bit)) {
-		spin_unlock_irq(&rtc_lock);
+	if (hpet_set_rtc_irq_bit(bit))
 		return;
-	}
 	val = CMOS_READ(RTC_CONTROL);
 	val |= bit;
 	CMOS_WRITE(val, RTC_CONTROL);
 	CMOS_READ(RTC_INTR_FLAGS);
 
 	rtc_irq_data = 0;
-	spin_unlock_irq(&rtc_lock);
 }
 #endif
 

--
