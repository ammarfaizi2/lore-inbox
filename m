Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265715AbUFDK3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUFDK3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbUFDK3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:29:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57764 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265715AbUFDK3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:29:02 -0400
Date: Fri, 4 Jun 2004 16:14:18 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: p_gortmaker@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lost RTC interrupts
Message-ID: <20040604104418.GA3911@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Paul,

The calculation for the number of interrupts lost when the
RTC stops generating interrupts seems to be broken for HZ=1000

Also, the following patch returns more accurate lost interrupt
data (At the cost of some accounting for every interrupt)
Let me know if you think the accounting is unnecessary

Thanks
Dinakar

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtc-lost-ticks.patch"

diff -Naurp linux-2.6.7-rc2/drivers/char/rtc.c linux-2.6.7-rc2-rtc/drivers/char/rtc.c
--- linux-2.6.7-rc2/drivers/char/rtc.c	2004-05-30 11:56:50.000000000 +0530
+++ linux-2.6.7-rc2-rtc/drivers/char/rtc.c	2004-06-03 13:09:04.000000000 +0530
@@ -169,6 +169,9 @@ static unsigned long rtc_freq = 0;	/* Cu
 static unsigned long rtc_irq_data = 0;	/* our output to the world	*/
 static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
 
+static unsigned long prev_jiffies = 0;
+static unsigned long rtcticks_in_pjiffies = 0;
+
 #ifdef RTC_IRQ
 /*
  * rtc_task_lock nests inside rtc_lock.
@@ -239,6 +242,12 @@ irqreturn_t rtc_interrupt(int irq, void 
 
 	spin_unlock (&rtc_lock);
 
+	if (jiffies != prev_jiffies) {
+		prev_jiffies = jiffies;
+		rtcticks_in_pjiffies = 0;
+	}
+	rtcticks_in_pjiffies++;
+		
 	/* Now do the rest of the actions */
 	spin_lock(&rtc_task_lock);
 	if (rtc_callback)
@@ -1094,7 +1103,7 @@ static void rtc_dropped_irq(unsigned lon
 	if (rtc_status & RTC_TIMER_ON)
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
-	rtc_irq_data += ((rtc_freq/HZ)<<8);
+	rtc_irq_data += ((rtc_freq/HZ * 2*HZ/100 - rtcticks_in_pjiffies)<<8);
 	rtc_irq_data &= ~0xff;
 	rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);	/* restart */
 
@@ -1102,6 +1111,9 @@ static void rtc_dropped_irq(unsigned lon
 
 	spin_unlock_irq(&rtc_lock);
 
+	prev_jiffies = jiffies;
+	rtcticks_in_pjiffies = 1;
+		
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 
 	/* Now we have new data */

--IJpNTDwzlM2Ie8A6--
