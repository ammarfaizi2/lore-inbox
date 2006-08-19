Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWHSPG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWHSPG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWHSPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:06:28 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:16798 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751294AbWHSPG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:06:28 -0400
Date: Sat, 19 Aug 2006 23:30:27 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] for 2.6.18, revert "Drop tasklist lock in do_sched_setscheduler"
Message-ID: <20060819193026.GA7449@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sched_setscheduler() looks at ->signal->rlim[]. It is unsafe do dereference
->signal unless tasklist_lock or ->siglock is held (or p == current). We pin
the task structure, but this can't prevent from release_task()->__exit_signal()
which sets ->signal = NULL.

Restore tasklist_lock across the setscheduler call.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/sched.c~1_revert	2006-08-19 17:50:56.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-19 18:15:15.000000000 +0400
@@ -4162,10 +4162,8 @@ do_sched_setscheduler(pid_t pid, int pol
 		read_unlock_irq(&tasklist_lock);
 		return -ESRCH;
 	}
-	get_task_struct(p);
-	read_unlock_irq(&tasklist_lock);
 	retval = sched_setscheduler(p, policy, &lparam);
-	put_task_struct(p);
+	read_unlock_irq(&tasklist_lock);
 
 	return retval;
 }

