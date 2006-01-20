Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161472AbWATC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161472AbWATC4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWATCzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:42 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41965
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161472AbWATCzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:15 -0500
Message-Id: <20060120021343.296071000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/7] [hrtimers] Set correct initial expiry time for relative
	SIGEV_NONE timers
Content-Disposition: inline;
	filename=0007-hrtimers-Set-correct-initial-expiry-time-for-relative-SIGEV_NONE-timers.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The expiry time for relative timers with SIGEV_NONE set was never
updated to the correct value.

Pointed out by George Anzinger.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 kernel/posix-timers.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

a1f15939b7af18c5abcd4810ccd512467c77a6b1
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 28e72fd..e2fa4c0 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -724,8 +724,13 @@ common_timer_set(struct k_itimer *timr, 
 	timr->it.real.interval = timespec_to_ktime(new_setting->it_interval);
 
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
+	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
+		/* Setup correct expiry time for relative timers */
+		if (mode == HRTIMER_REL)
+			timer->expires = ktime_add(timer-expires,
+						   timer->base->get_time());
 		return 0;
+	}
 
 	hrtimer_start(timer, timer->expires, mode);
 	return 0;
-- 
1.0.8

--

