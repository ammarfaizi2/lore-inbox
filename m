Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274903AbTHFHjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274905AbTHFHjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:39:12 -0400
Received: from mail7.speakeasy.net ([216.254.0.207]:63904 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S274903AbTHFHjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:39:08 -0400
Date: Wed, 6 Aug 2003 00:39:06 -0700
Message-Id: <200308060739.h767d6407156@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>, Daniel Jacobowitz <drow@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix spinlock deadlock in ptrace-reaping of detached thread
X-Windows: even not doing anything would have been better than nothing.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a dead detached thread has been temporarily zombified because it's
ptraced and its tracer tries to reap it, it deadlocks on SMP.  Here's a fix.


Thanks,
Roland


--- linux-2.5/kernel/exit.c	6 Aug 2003 05:30:45 -0000	1.109
+++ linux-2.5/kernel/exit.c	6 Aug 2003 06:04:02 -0000
@@ -898,13 +898,19 @@ static int wait_task_zombie(task_t *p, u
 			__ptrace_unlink(p);
 			p->state = TASK_ZOMBIE;
 			/* If this is a detached thread, this is where it goes away.  */
-			if (p->exit_signal == -1)
+			if (p->exit_signal == -1) {
+				/* release_task takes the lock itself.  */
+				write_unlock_irq(&tasklist_lock);
 				release_task (p);
-			else
+			}
+			else {
 				do_notify_parent(p, p->exit_signal);
+				write_unlock_irq(&tasklist_lock);
+			}
 			p = NULL;
 		}
-		write_unlock_irq(&tasklist_lock);
+		else
+			write_unlock_irq(&tasklist_lock);
 	}
 	if (p != NULL)
 		release_task(p);
