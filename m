Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbUJ0I1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUJ0I1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbUJ0I1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:27:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7891 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262330AbUJ0I13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:27:29 -0400
Date: Wed, 27 Oct 2004 10:28:31 +0200
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
Message-ID: <20041027082831.GA15192@elte.hu>
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F16BB.3030300@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Running amlat still hard locks the system. The last time this happened
> I got this in the log:
> 
>  Oct 26 21:43:56 porky kernel: BUG: sleeping function called from 
> invalid context amlat(3963) at kernel/mutex.c:28
> Oct 26 21:43:56 porky kernel: in_atomic():1 [00000001], irqs_disabled():1
> Oct 26 21:43:56 porky kernel:  [<c011c7da>] __might_sleep+0xca/0xe0 (12)
> Oct 26 21:43:56 porky kernel:  [<c0137d89>] _mutex_lock+0x39/0x50 (36)
> Oct 26 21:43:56 porky kernel:  [<c0137df6>]  _mutex_lock_irqsave+0x16/0x20 (24)
> Oct 26 21:43:56 porky kernel:  [<c012977d>] __mod_timer+0x4d/0x1f0 (12)
> Oct 26 21:43:56 porky kernel:  [<c01f6535>] rtc_do_ioctl+0x185/0x970 (44)

does the quick hack below help?

	Ingo

--- linux/drivers/char/rtc.c.orig
+++ linux/drivers/char/rtc.c
@@ -238,11 +238,11 @@ irqreturn_t rtc_interrupt(int irq, void 
 		rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
 	}
 
+	spin_unlock (&rtc_lock);
+
 	if (rtc_status & RTC_TIMER_ON)
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
-	spin_unlock (&rtc_lock);
-
 	/* Now do the rest of the actions */
 	spin_lock(&rtc_task_lock);
 	if (rtc_callback)
@@ -1094,10 +1094,6 @@ static void rtc_dropped_irq(unsigned lon
 		return;
 	}
 
-	/* Just in case someone disabled the timer from behind our back... */
-	if (rtc_status & RTC_TIMER_ON)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
-
 	rtc_irq_data += ((rtc_freq/HZ)<<8);
 	rtc_irq_data &= ~0xff;
 	rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);	/* restart */
@@ -1106,6 +1102,10 @@ static void rtc_dropped_irq(unsigned lon
 
 	spin_unlock_irq(&rtc_lock);
 
+	/* Just in case someone disabled the timer from behind our back... */
+	if (rtc_status & RTC_TIMER_ON)
+		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 
 	/* Now we have new data */
