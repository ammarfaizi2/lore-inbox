Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270982AbUJVOkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbUJVOkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271300AbUJVOkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:40:05 -0400
Received: from users.ccur.com ([208.248.32.211]:40895 "EHLO mig.iccur.com")
	by vger.kernel.org with ESMTP id S270982AbUJVOjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:39:55 -0400
Date: Fri, 22 Oct 2004 10:39:53 -0400
From: Joe Korty <joe.korty@ccur.com>
To: roland@redhat.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] posix timers using == instead of & for bitmask tests
Message-ID: <20041022143953.GA17881@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 22 Oct 2004 14:39:54.0653 (UTC) FILETIME=[FEDEFCD0:01C4B844]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make posix-timers do a get_task_struct / put_task_struct if either
SIGEV_SIGNAL or SIGEV_THREAD_ID is set.  Currently the get/put is done
only if both are set.

Compiles but is otherwise untested.

Joe

--- base/kernel/posix-timers.c	2004-10-18 17:54:22.000000000 -0400
+++ new/kernel/posix-timers.c	2004-10-22 10:25:51.000000000 -0400
@@ -548,7 +548,7 @@
 	}
 	sigqueue_free(tmr->sigq);
 	if (unlikely(tmr->it_process) &&
-	    tmr->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+	    (tmr->it_sigev_notify & (SIGEV_SIGNAL | SIGEV_THREAD_ID)))
 		put_task_struct(tmr->it_process);
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -650,7 +650,7 @@
 				list_add(&new_timer->list,
 					 &process->signal->posix_timers);
 				spin_unlock_irqrestore(&process->sighand->siglock, flags);
-				if (new_timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+				if (new_timer->it_sigev_notify & (SIGEV_SIGNAL | SIGEV_THREAD_ID))
 					get_task_struct(process);
 			} else {
 				spin_unlock_irqrestore(&process->sighand->siglock, flags);
@@ -1101,7 +1101,7 @@
 	 * they got something (see the lock code above).
 	 */
 	if (timer->it_process) {
-		if (timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+		if (timer->it_sigev_notify & (SIGEV_SIGNAL | SIGEV_THREAD_ID))
 			put_task_struct(timer->it_process);
 		timer->it_process = NULL;
 	}
@@ -1138,7 +1138,7 @@
 	 * they got something (see the lock code above).
 	 */
 	if (timer->it_process) {
-		if (timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+		if (timer->it_sigev_notify & (SIGEV_SIGNAL | SIGEV_THREAD_ID))
 			put_task_struct(timer->it_process);
 		timer->it_process = NULL;
 	}
