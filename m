Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVAMBF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVAMBF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVAMBCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:02:50 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:33763 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261428AbVAMA7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:59:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix a bug in timer_suspend() on x86_64
Date: Thu, 13 Jan 2005 01:59:16 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org, Pavel Machek <pavel@suse.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501130002.37311.rjw@sisk.pl> <1105572485.2941.1.camel@desktop.cunninghams>
In-Reply-To: <1105572485.2941.1.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130159.16818.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is intended to fix a bug in timer_suspend() on x86_64 that causes 
hard lockups on suspend with swsusp and provide some optimizations.  It is 
based on the Nigel Cunningham's patches to to reduce delay in 
arch/kernel/time.c.  The patch is against 2.6.10-mm3 and 2.6.11-rc1.  Please 
consider for applying.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.10-mm3-orig/arch/x86_64/kernel/time.c	2005-01-13 
01:46:10.000000000 +0100
+++ linux-2.6.10-mm3/arch/x86_64/kernel/time.c	2005-01-13 01:32:05.000000000 
+0100
@@ -955,16 +955,19 @@
 
 __setup("report_lost_ticks", time_setup);
 
-static long clock_cmos_diff, sleep_start;
+static long clock_cmos_diff;
+static unsigned long sleep_start;
 
 static int timer_suspend(struct sys_device *dev, u32 state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	long cmos_time =  get_cmos_time();
+
+	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();
-	sleep_start = jiffies;
+	sleep_start = cmos_time;
 	return 0;
 }
 
@@ -973,7 +976,7 @@
 	unsigned long flags;
 	unsigned long sec;
 	unsigned long ctime = get_cmos_time();
-	unsigned long sleep_length = ctime - sleep_start;
+	unsigned long sleep_length = (ctime - sleep_start) * HZ;
 
 	if (vxtime.hpet_address)
 		hpet_reenable();
@@ -983,7 +986,8 @@
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock,flags);
-	jiffies += sleep_length * HZ;
+	jiffies += sleep_length;
+	wall_jiffies += sleep_length;
 	return 0;
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
