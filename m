Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWCDECL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWCDECL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWCDECK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:02:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:29585 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751751AbWCDECJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:02:09 -0500
Subject: [-mm PATCH] time: i386 conversion part 3 - lock jiffies_64
	manipulation
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1141444689.9727.105.camel@cog.beaverton.ibm.com>
References: <1141444689.9727.105.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 20:02:06 -0800
Message-Id: <1141444927.9727.110.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew,

This should merge TOD my changes with Atsushi's jiffies/jiffies_64 fix
that is in your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff -ru mmmerge/arch/i386/kernel/time.c mytree/arch/i386/kernel/time.c
--- mmmerge/arch/i386/kernel/time.c	2006-03-03 19:44:22.000000000 -0800
+++ mytree/arch/i386/kernel/time.c	2006-03-03 19:44:45.000000000 -0800
@@ -266,6 +266,7 @@
 
 static int timer_resume(struct sys_device *dev)
 {
+	unsigned long flags;
 	unsigned long sec;
 	unsigned long sleep_length;
 
@@ -276,8 +277,10 @@
 	setup_pit_timer();
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+	write_seqlock_irqsave(&xtime_lock, flags);
 	jiffies_64 += sleep_length;
 	wall_jiffies += sleep_length;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	touch_softlockup_watchdog();
 	return 0;
 }


