Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbUJ0JFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUJ0JFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUJ0JFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:05:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63918 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262338AbUJ0JFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:05:06 -0400
Date: Wed, 27 Oct 2004 11:06:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027090620.GA17621@elte.hu>
References: <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027082831.GA15192@elte.hu> <20041027084401.GA15989@elte.hu> <20041027085221.GA16742@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027085221.GA16742@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> third time lucky?

there was one more piece missing...

i've also uploaded -RT-V0.3.2 with this fix included.

	Ingo

--- linux/drivers/char/rtc.c.orig
+++ linux/drivers/char/rtc.c
@@ -177,7 +177,7 @@ static unsigned long rtc_max_user_freq =
 /*
  * rtc_task_lock nests inside rtc_lock.
  */
-static DECLARE_SPINLOCK(rtc_task_lock);
+static DECLARE_RAW_SPINLOCK(rtc_task_lock);
 static rtc_task_t *rtc_callback = NULL;
 #endif
 
@@ -217,6 +217,8 @@ static inline unsigned char rtc_is_updat
 
 irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long flags;
+
 	/*
 	 *	Can be an alarm interrupt, update complete interrupt,
 	 *	or a periodic interrupt. We store the status in the
@@ -224,7 +226,7 @@ irqreturn_t rtc_interrupt(int irq, void 
 	 *	the last read in the remainder of rtc_irq_data.
 	 */
 
-	spin_lock (&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	rtc_irq_data += 0x100;
 	rtc_irq_data &= ~0xff;
 	if (is_hpet_enabled()) {
@@ -238,16 +240,23 @@ irqreturn_t rtc_interrupt(int irq, void 
 		rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
 	}
 
-	if (rtc_status & RTC_TIMER_ON)
+	if (rtc_status & RTC_TIMER_ON) {
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		/*
+		 * We do the mod_timer outside of the lock because
+		 * it may reschedule under PREEMPT_REALTIME. As long
+		 * as we read the flag race-free it is not a problem
+		 * if two mod_timer()s race:
+		 */
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
-
-	spin_unlock (&rtc_lock);
+	} else
+		spin_unlock_irqrestore(&rtc_lock, flags);
 
 	/* Now do the rest of the actions */
-	spin_lock(&rtc_task_lock);
+	spin_lock_irqsave(&rtc_task_lock, flags);
 	if (rtc_callback)
 		rtc_callback->func(rtc_callback->private_data);
-	spin_unlock(&rtc_task_lock);
+	spin_unlock_irqrestore(&rtc_task_lock, flags);
 	wake_up_interruptible(&rtc_wait);	
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
@@ -404,8 +413,8 @@ static int rtc_do_ioctl(unsigned int cmd
 		if (rtc_status & RTC_TIMER_ON) {
 			spin_lock_irq (&rtc_lock);
 			rtc_status &= ~RTC_TIMER_ON;
-			del_timer(&rtc_irq_timer);
 			spin_unlock_irq (&rtc_lock);
+			del_timer(&rtc_irq_timer); // FIXME
 		}
 		return 0;
 	}
@@ -422,10 +431,9 @@ static int rtc_do_ioctl(unsigned int cmd
 
 		if (!(rtc_status & RTC_TIMER_ON)) {
 			spin_lock_irq (&rtc_lock);
-			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
-			add_timer(&rtc_irq_timer);
 			rtc_status |= RTC_TIMER_ON;
 			spin_unlock_irq (&rtc_lock);
+			mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 		}
 		set_rtc_irq_bit(RTC_PIE);
 		return 0;
@@ -730,9 +738,10 @@ static int rtc_release(struct inode *ino
 	}
 	if (rtc_status & RTC_TIMER_ON) {
 		rtc_status &= ~RTC_TIMER_ON;
-		del_timer(&rtc_irq_timer);
-	}
-	spin_unlock_irq(&rtc_lock);
+		spin_unlock_irq(&rtc_lock);
+		del_timer(&rtc_irq_timer); // FIXME
+	} else
+		spin_unlock_irq(&rtc_lock);
 
 	if (file->f_flags & FASYNC) {
 		rtc_fasync (-1, file, 0);
@@ -808,6 +817,7 @@ int rtc_unregister(rtc_task_t *task)
 	return -EIO;
 #else
 	unsigned char tmp;
+	int rm_timer;
 
 	spin_lock_irq(&rtc_lock);
 	spin_lock(&rtc_task_lock);
@@ -827,13 +837,16 @@ int rtc_unregister(rtc_task_t *task)
 		CMOS_WRITE(tmp, RTC_CONTROL);
 		CMOS_READ(RTC_INTR_FLAGS);
 	}
+	rm_timer = 0;
 	if (rtc_status & RTC_TIMER_ON) {
 		rtc_status &= ~RTC_TIMER_ON;
-		del_timer(&rtc_irq_timer);
+		rm_timer = 1;
 	}
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock(&rtc_task_lock);
 	spin_unlock_irq(&rtc_lock);
+	if (rm_timer)
+		del_timer(&rtc_irq_timer);
 	return 0;
 #endif
 }
@@ -1094,17 +1107,19 @@ static void rtc_dropped_irq(unsigned lon
 		return;
 	}
 
-	/* Just in case someone disabled the timer from behind our back... */
-	if (rtc_status & RTC_TIMER_ON)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
-
 	rtc_irq_data += ((rtc_freq/HZ)<<8);
 	rtc_irq_data &= ~0xff;
 	rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);	/* restart */
 
 	freq = rtc_freq;
 
-	spin_unlock_irq(&rtc_lock);
+	/* Just in case someone disabled the timer from behind our back... */
+	if (rtc_status & RTC_TIMER_ON) {
+		spin_unlock_irq(&rtc_lock);
+		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+	} else
+		spin_unlock_irq(&rtc_lock);
+
 
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 
