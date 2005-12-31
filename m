Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVLaTvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVLaTvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 14:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLaTvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 14:51:51 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60409 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932311AbVLaTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 14:51:50 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Reed <bradreed1@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <20051231202933.4f48acab@galactus.example.org>
References: <20051231202933.4f48acab@galactus.example.org>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 14:51:36 -0500
Message-Id: <1136058696.6039.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
> they all work fine under 2.6.14 and 2.6.14-rt21/22.
> 
> I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
> every video I try and play. Yes, I have nvidia modules loaded, so won't
> get much help, but thought someone might like to know. 
> 
> xine plays the videos fine.
> 
> BTW, other than MPLayer problems, everything else works great.
> 
> Brad
> 
> dmesg shows:
> ------------[ cut here ]------------
> kernel BUG at include/linux/timer.h:83!

Hey guys (Ingo, Thomas and John), second person with the rtc bug.

Bradley and Jan, try the below patch and see if it doesn't deadlock the
system. I'm not sure why they pulled out the mod_timer add_timer and
del_timer from the rtc_lock, but there might be a call back to it.

-- Steve

Index: linux-2.6.15-rc7-rt1/drivers/char/rtc.c
===================================================================
--- linux-2.6.15-rc7-rt1.orig/drivers/char/rtc.c	2005-12-28 14:02:48.000000000 -0500
+++ linux-2.6.15-rc7-rt1/drivers/char/rtc.c	2005-12-31 14:41:58.000000000 -0500
@@ -384,7 +384,6 @@
 }
 
 #ifdef RTC_IRQ
-
 /*
  *	A very tiny interrupt handler. It runs with SA_INTERRUPT set,
  *	but there is possibility of conflicting with the set_rtc_mmss()
@@ -397,8 +396,6 @@
 
 irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	int mod;
-
 	/*
 	 *	Can be an alarm interrupt, update complete interrupt,
 	 *	or a periodic interrupt. We store the status in the
@@ -420,13 +417,10 @@
 		rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
 	}
 
-	mod = 0;
 	if (rtc_status & RTC_TIMER_ON)
-		mod = 1;
+		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
 	spin_unlock (&rtc_lock);
-	if (mod)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
 	/* Now do the rest of the actions */
 	spin_lock(&rtc_task_lock);
@@ -588,24 +582,18 @@
 	case RTC_PIE_OFF:	/* Mask periodic int. enab. bit	*/
 	{
 		unsigned long flags; /* can be called from isr via rtc_control() */
-		int del = 0;
-
 		spin_lock_irqsave (&rtc_lock, flags);
 		mask_rtc_irq_bit_locked(RTC_PIE);
 		if (rtc_status & RTC_TIMER_ON) {
 			rtc_status &= ~RTC_TIMER_ON;
-			del = 1;
+			del_timer(&rtc_irq_timer);
 		}
 		spin_unlock_irqrestore (&rtc_lock, flags);
-		if (del)
-			del_timer(&rtc_irq_timer);
 		return 0;
 	}
 	case RTC_PIE_ON:	/* Allow periodic ints		*/
 	{
 		unsigned long flags; /* can be called from isr via rtc_control() */
-		int add = 0;
-
 		/*
 		 * We don't really want Joe User enabling more
 		 * than 64Hz of interrupts on a multi-user machine.
@@ -617,13 +605,11 @@
 		spin_lock_irqsave (&rtc_lock, flags);
 		if (!(rtc_status & RTC_TIMER_ON)) {
 			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
+			add_timer(&rtc_irq_timer);
 			rtc_status |= RTC_TIMER_ON;
-			add = 1;
 		}
 		set_rtc_irq_bit_locked(RTC_PIE);
 		spin_unlock_irqrestore (&rtc_lock, flags);
-		if (add)
-			add_timer(&rtc_irq_timer);
 		return 0;
 	}
 	case RTC_UIE_OFF:	/* Mask ints from RTC updates.	*/
@@ -914,7 +900,6 @@
 {
 #ifdef RTC_IRQ
 	unsigned char tmp;
-	int del;
 
 	if (rtc_has_irq == 0)
 		goto no_irq;
@@ -933,14 +918,11 @@
 		CMOS_WRITE(tmp, RTC_CONTROL);
 		CMOS_READ(RTC_INTR_FLAGS);
 	}
-	del = 0;
 	if (rtc_status & RTC_TIMER_ON) {
 		rtc_status &= ~RTC_TIMER_ON;
-		del = 1;
+		del_timer(&rtc_irq_timer);
 	}
 	spin_unlock_irq(&rtc_lock);
-	if (del)
-		del_timer(&rtc_irq_timer);
 
 	if (file->f_flags & FASYNC) {
 		rtc_fasync (-1, file, 0);
@@ -1017,7 +999,6 @@
 	return -EIO;
 #else
 	unsigned char tmp;
-	int del;
 
 	spin_lock_irq(&rtc_lock);
 	spin_lock(&rtc_task_lock);
@@ -1037,15 +1018,12 @@
 		CMOS_WRITE(tmp, RTC_CONTROL);
 		CMOS_READ(RTC_INTR_FLAGS);
 	}
-	del = 0;
 	if (rtc_status & RTC_TIMER_ON) {
 		rtc_status &= ~RTC_TIMER_ON;
-		del = 1;
+		del_timer(&rtc_irq_timer);
 	}
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock(&rtc_task_lock);
-	if (del)
-		del_timer(&rtc_irq_timer);
 	spin_unlock_irq(&rtc_lock);
 	return 0;
 #endif
@@ -1307,7 +1285,6 @@
 static void rtc_dropped_irq(unsigned long data)
 {
 	unsigned long freq;
-	int mod;
 
 	spin_lock_irq (&rtc_lock);
 
@@ -1317,9 +1294,8 @@
 	}
 
 	/* Just in case someone disabled the timer from behind our back... */
-	mod = 0;
 	if (rtc_status & RTC_TIMER_ON)
-		mod = 1;
+		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
 	rtc_irq_data += ((rtc_freq/HZ)<<8);
 	rtc_irq_data &= ~0xff;
@@ -1328,8 +1304,6 @@
 	freq = rtc_freq;
 
 	spin_unlock_irq(&rtc_lock);
-	if (mod)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 


