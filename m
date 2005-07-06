Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVGFUGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVGFUGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVGFUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:06:32 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:41457 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262227AbVGFS0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:26:52 -0400
Message-ID: <42CC2257.4030400@am.sony.com>
Date: Wed, 06 Jul 2005 11:26:31 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: George Anzinger <george@mvista.com>
Subject: [PATCH] Fix posix_bump_timer args
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes posix_bump_timer() consistent with common convention 
by expecting a pointer to the structure be passed.

Please apply.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--
--- linux-2.6.12.1.orig/include/linux/posix-timers.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.1/include/linux/posix-timers.h.bump	2005-07-06 10:58:52.000000000 -0700
@@ -108,7 +108,7 @@
 #define posix_bump_timer(timr, now)					\
          do {								\
               long delta, orun;						\
-	      delta = now.jiffies - (timr)->it.real.timer.expires;	\
+	      delta = (now)->jiffies - (timr)->it.real.timer.expires;	\
               if (delta >= 0) {						\
 	           orun = 1 + (delta / (timr)->it.real.incr);		\
 	          (timr)->it.real.timer.expires +=			\

--- linux-2.6.12.1.orig/kernel/posix-timers.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.1/kernel/posix-timers.c.bump	2005-07-06 10:54:48.000000000 -0700
@@ -384,11 +384,11 @@
 		spin_lock(&abs_list.lock);
 		add_clockset_delta(timr, &new_wall_to);
 
-		posix_bump_timer(timr, now);
+		posix_bump_timer(timr, &now);
 
 		spin_unlock(&abs_list.lock);
 	} else {
-		posix_bump_timer(timr, now);
+		posix_bump_timer(timr, &now);
 	}
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
@@ -810,7 +810,7 @@
 	if (expires) {
 		if (timr->it_requeue_pending & REQUEUE_PENDING ||
 		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-			posix_bump_timer(timr, now);
+			posix_bump_timer(timr, &now);
 			expires = timr->it.real.timer.expires;
 		}
 		else


