Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbUKKXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUKKXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbUKKXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:06:19 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33669 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262410AbUKKXFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:05:05 -0500
Subject: [PATCH 1/3] Fix sysdev time support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100213485.6031.18.camel@desktop.cunninghams>
References: <1100213485.6031.18.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1100213785.6031.29.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 09:58:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make time_suspend and time_resume call get_cmos_time once only, so as to
eliminate unnecessary 1 second delays in suspending and resuming.

diff -ruN 990-old/arch/i386/kernel/time.c 990-new/arch/i386/kernel/time.c
--- 990-old/arch/i386/kernel/time.c	2004-11-12 08:12:58.275103280 +1100
+++ 990-new/arch/i386/kernel/time.c	2004-11-12 07:16:41.000000000 +1100
@@ -323,20 +323,22 @@
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
+	long cmos_time = get_cmos_time();
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
+	sleep_start = cmos_time;
 	return 0;
 }
 
 static int time_resume(struct sys_device *dev)
 {
 	unsigned long flags;
-	unsigned long sec = get_cmos_time() + clock_cmos_diff;
-	unsigned long sleep_length = get_cmos_time() - sleep_start;
+	unsigned long cmos_time = get_cmos_time();
+	unsigned long sec = cmos_time + clock_cmos_diff;
+	unsigned long sleep_length = cmos_time - sleep_start;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

