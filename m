Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUJDNTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUJDNTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUJDNTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:19:19 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:17280 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266835AbUJDNTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:19:08 -0400
Date: Mon, 4 Oct 2004 14:10:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: fix process start times after resume
Message-ID: <20041004121018.GA25734@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently, process start times change after swsusp (because they are
derived from jiffies and current time, oops). This should fix
it. Please apply,

								Pavel

Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c	2004-10-01 12:24:26.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2004-10-01 00:53:07.000000000 +0200
@@ -319,7 +319,7 @@
 	return retval;
 }
 
-static long clock_cmos_diff;
+static long clock_cmos_diff, sleep_start;
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
@@ -328,6 +328,7 @@
 	 */
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
+	sleep_start = get_cmos_time();
 	return 0;
 }
 
@@ -335,10 +336,13 @@
 {
 	unsigned long flags;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sleep_length = get_cmos_time() - sleep_start;
+
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
+	jiffies += sleep_length * HZ;
 	return 0;
 }
 
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
