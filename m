Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVAHJsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVAHJsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVAHJqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:46:52 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:19421 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261918AbVAHJk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:40:56 -0500
Subject: Patch 1/3: Reduce number of get_cmos_time_calls.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, John Stultz <johnstul@us.ibm.com>,
       David Shaohua <shaohua.li@intel.com>
In-Reply-To: <1105176732.5478.20.camel@desktop.cunninghams>
References: <1105176732.5478.20.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1105177073.5478.33.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 08 Jan 2005 20:42:10 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the number of calls to get_cmos_time. Since get_cmos_time waits
for the start of a new second, two consecutive calls add one full second
to the time to suspend/resume.

Signed-off-by: Nigel Cunningham <ncunningham@linuxmail.org>

diff -ruNp 911-old/arch/i386/kernel/time.c 911-new/arch/i386/kernel/time.c
--- 911-old/arch/i386/kernel/time.c	2005-01-08 19:36:46.107382632 +1100
+++ 911-new/arch/i386/kernel/time.c	2005-01-08 19:36:25.439524624 +1100
@@ -326,9 +326,11 @@ static int timer_suspend(struct sys_devi
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	long cmos_time = get_cmos_time();
+	
+	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
+	sleep_start = cmos_time;
 	return 0;
 }
 
@@ -337,13 +339,15 @@ static int timer_resume(struct sys_devic
 	unsigned long flags;
 	unsigned long sec;
 	unsigned long sleep_length;
+	unsigned long cmos_time;
 
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
-	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+	cmos_time = get_cmos_time();
+	sec = cmos_time + clock_cmos_diff;
+	sleep_length = (cmos_time - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;


