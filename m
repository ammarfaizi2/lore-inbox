Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbUJ0Iv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUJ0Iv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUJ0Iv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:51:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18658 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262336AbUJ0IvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:51:09 -0400
Date: Wed, 27 Oct 2004 10:52:21 +0200
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
Message-ID: <20041027085221.GA16742@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027082831.GA15192@elte.hu> <20041027084401.GA15989@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027084401.GA15989@elte.hu>
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

> > does the quick hack below help?
> 
> here's a more complete fix.

third time lucky?

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
 
@@ -238,10 +238,17 @@ irqreturn_t rtc_interrupt(int irq, void 
 		rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
 	}
 
-	if (rtc_status & RTC_TIMER_ON)
+	if (rtc_status & RTC_TIMER_ON) {
+		spin_unlock (&rtc_lock);
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
+		spin_unlock (&rtc_lock);
 
 	/* Now do the rest of the actions */
 	spin_lock(&rtc_task_lock);
@@ -404,8 +411,8 @@ static int rtc_do_ioctl(unsigned int cmd
 		if (rtc_status & RTC_TIMER_ON) {
 			spin_lock_irq (&rtc_lock);
 			rtc_status &= ~RTC_TIMER_ON;
-			del_timer(&rtc_irq_timer);
 			spin_unlock_irq (&rtc_lock);
+			del_timer(&rtc_irq_timer); // FIXME
 		}
 		return 0;
 	}
@@ -730,9 +737,10 @@ static int rtc_release(struct inode *ino
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
@@ -808,6 +816,7 @@ int rtc_unregister(rtc_task_t *task)
 	return -EIO;
 #else
 	unsigned char tmp;
+	int rm_timer;
 
 	spin_lock_irq(&rtc_lock);
 	spin_lock(&rtc_task_lock);
@@ -827,13 +836,16 @@ int rtc_unregister(rtc_task_t *task)
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
@@ -1094,17 +1106,19 @@ static void rtc_dropped_irq(unsigned lon
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
 
