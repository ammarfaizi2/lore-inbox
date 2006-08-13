Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWHMVLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWHMVLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWHMVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:11:04 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:34710 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751472AbWHMVLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:11:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 1/2] i386: Detect clock skew during suspend
Date: Sun, 13 Aug 2006 23:06:02 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <200608132303.00012.rjw@sisk.pl>
In-Reply-To: <200608132303.00012.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608132306.02079.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detect the situations in which the time after a resume from disk would
be earlier than the time before the suspend and prevent them from
happening on i386.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/i386/kernel/time.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc4-mm1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/arch/i386/kernel/time.c
+++ linux-2.6.18-rc4-mm1/arch/i386/kernel/time.c
@@ -285,16 +285,19 @@ void notify_arch_cmos_timer(void)
 	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
-static long clock_cmos_diff, sleep_start;
+static long clock_cmos_diff;
+static unsigned long sleep_start;
 
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	unsigned long ctime =  get_cmos_time();
+
+	clock_cmos_diff = -ctime;
 	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
+	sleep_start = ctime;
 	return 0;
 }
 
@@ -302,16 +305,25 @@ static int timer_resume(struct sys_devic
 {
 	unsigned long flags;
 	unsigned long sec;
-	unsigned long sleep_length;
+	unsigned long ctime = get_cmos_time();
+	long sleep_length = (ctime - sleep_start) * HZ;
 	struct timespec ts;
+
+	if (sleep_length < 0) {
+		printk(KERN_WARNING "Time skew detected in timer resume!\n");
+		/* The time after the resume must not be earlier than the time
+		 * before the suspend or some nasty things will happen
+		 */
+		sleep_length = 0;
+		ctime = sleep_start;
+	}
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
 	setup_pit_timer();
-	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
 
+	sec = ctime + clock_cmos_diff;
 	ts.tv_sec = sec;
 	ts.tv_nsec = 0;
 	do_settimeofday(&ts);

