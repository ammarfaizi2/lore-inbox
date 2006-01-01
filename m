Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWAAPfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWAAPfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWAAPfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:35:12 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41917 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932160AbWAAPfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:35:11 -0500
Date: Sun, 1 Jan 2006 10:34:43 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Knecht <markknecht@gmail.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rc7-rt1
In-Reply-To: <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0601011031370.27965@gandalf.stny.rr.com>
References: <20051228172643.GA26741@elte.hu>  <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
  <1136051113.6039.109.camel@localhost.localdomain> 
 <1136054936.6039.125.camel@localhost.localdomain>
 <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Jan 2006, Mark Knecht wrote:
>
> Hi all,
>    Happy New Year.
>
>    Is this the same problem Steven? It happened when running MythTV
> for the first time. Rerunning MythTV did not cause a second problem
> and the program then ran fine.
>
> - Mark
>
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at include/linux/timer.h:83

Looking at the above...

> invalid operand: 0000 [1] PREEMPT
> CPU 0

...

>
> Code: 0f 0b 68 9d 5f 42 80 c2 53 00 48 8b 35 25 54 2a 00 48 c7 c7
> RIP <ffffffff802ae2fa>{rtc_do_ioctl+730} RSP <ffff81000adb9e08>
>

And that rtc_do_ioctl, I would say "Yes".

Try out this patch and see if it fixes the problem.  I'm reposting it just
so you don't need to go back and look for it.

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

