Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVIYNyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVIYNyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 09:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVIYNyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 09:54:51 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:40373 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751319AbVIYNyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 09:54:50 -0400
Message-ID: <4336AF0B.D4141552@tv-sign.ru>
Date: Sun, 25 Sep 2005 18:07:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, George Anzinger <george@mvista.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] posix-timers: use schedule_timeout() in common_nsleep()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

common_nsleep() reimplements schedule_timeout_interruptible()
for unknown reason.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc2/kernel/posix-timers.c~4_SCTO	2005-09-24 18:03:10.000000000 +0400
+++ 2.6.14-rc2/kernel/posix-timers.c	2005-09-25 20:20:48.000000000 +0400
@@ -1317,13 +1317,6 @@ sys_clock_getres(clockid_t which_clock, 
 	return error;
 }
 
-static void nanosleep_wake_up(unsigned long __data)
-{
-	struct task_struct *p = (struct task_struct *) __data;
-
-	wake_up_process(p);
-}
-
 /*
  * The standard says that an absolute nanosleep call MUST wake up at
  * the requested time in spite of clock settings.  Here is what we do:
@@ -1464,7 +1457,6 @@ static int common_nsleep(clockid_t which
 			 int flags, struct timespec *tsave)
 {
 	struct timespec t, dum;
-	struct timer_list new_timer;
 	DECLARE_WAITQUEUE(abs_wqueue, current);
 	u64 rq_time = (u64)0;
 	s64 left;
@@ -1473,10 +1465,6 @@ static int common_nsleep(clockid_t which
 	    &current_thread_info()->restart_block;
 
 	abs_wqueue.flags = 0;
-	init_timer(&new_timer);
-	new_timer.expires = 0;
-	new_timer.data = (unsigned long) current;
-	new_timer.function = nanosleep_wake_up;
 	abs = flags & TIMER_ABSTIME;
 
 	if (restart_block->fn == clock_nanosleep_restart) {
@@ -1512,13 +1500,8 @@ static int common_nsleep(clockid_t which
 		if (left < (s64)0)
 			break;
 
-		new_timer.expires = jiffies + left;
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_timer(&new_timer);
-
-		schedule();
+		schedule_timeout_interruptible(left);
 
-		del_timer_sync(&new_timer);
 		left = rq_time - get_jiffies_64();
 	} while (left > (s64)0 && !test_thread_flag(TIF_SIGPENDING));
