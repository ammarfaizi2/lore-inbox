Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUIJUsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUIJUsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUIJUsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:48:42 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:43705 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S267786AbUIJUsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:48:40 -0400
Date: Fri, 10 Sep 2004 13:48:36 -0700
Message-Id: <200409102048.i8AKma39010310@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix task_struct leak in posix-timers
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Classic crosswords
   (2) Solicitous griddles
   (3) Omnipresent invasions
   (4) Wax & Wear Querulous yies
   (5) Treacherous omission miscreants
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timer_create leaks task_structs.  I probably introduced this bug when I did
the cleanup making posix-timers properly per-process.  This patch fixes it.
There is also a fixup for a random indentation snafu at the end.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- vanilla-linux-2.6/kernel/posix-timers.c	2004-09-09 21:51:10.000000000 -0700
+++ linux-2.6/kernel/posix-timers.c	2004-09-10 13:29:23.921986286 -0700
@@ -655,7 +655,8 @@ sys_timer_create(clockid_t which_clock,
 				list_add(&new_timer->list,
 					 &process->signal->posix_timers);
 				spin_unlock_irqrestore(&process->sighand->siglock, flags);
-				get_task_struct(process);
+				if (new_timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+					get_task_struct(process);
 			} else {
 				spin_unlock_irqrestore(&process->sighand->siglock, flags);
 				process = NULL;
@@ -1107,7 +1108,7 @@ retry_delete:
 	if (timer->it_process) {
 		if (timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
 			put_task_struct(timer->it_process);
-	timer->it_process = NULL;
+		timer->it_process = NULL;
 	}
 	unlock_timer(timer, flags);
 	release_posix_timer(timer, IT_ID_SET);
