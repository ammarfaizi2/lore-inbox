Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030857AbWKPQvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030857AbWKPQvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031186AbWKPQvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:51:54 -0500
Received: from styx.suse.cz ([82.119.242.94]:4569 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030857AbWKPQvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:51:53 -0500
Date: Thu, 16 Nov 2006 17:52:01 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, vojtech@suse.cz
Subject: [PATCH for 2.6.19] Fix xtime losing ticks
Message-ID: <20061116165201.GA18128@dwarf.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xtime is not properly incremented when main timer ticks are lost.
Whatever the number of ticks elapsed is, only one tick worth of time
is added to xtime. This patch fixes that.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>

Index: linux-2.6.19-rc5/kernel/timer.c
===================================================================
--- linux-2.6.19-rc5.orig/kernel/timer.c
+++ linux-2.6.19-rc5/kernel/timer.c
@@ -904,7 +904,7 @@ static void clocksource_adjust(struct cl
  *
  * Called from the timer interrupt, must hold a write on xtime_lock.
  */
-static void update_wall_time(void)
+static void update_wall_time(unsigned long ticks)
 {
 	cycle_t offset;
 
@@ -915,7 +915,7 @@ static void update_wall_time(void)
 #ifdef CONFIG_GENERIC_TIME
 	offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;
 #else
-	offset = clock->cycle_interval;
+	offset = ticks * clock->cycle_interval;
 #endif
 	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
 
@@ -1053,7 +1053,7 @@ void run_local_timers(void)
  */
 static inline void update_times(unsigned long ticks)
 {
-	update_wall_time();
+	update_wall_time(ticks);
 	calc_load(ticks);
 }
   
-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, SUSE CR

