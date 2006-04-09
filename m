Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWDHUOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWDHUOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWDHUOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:14:45 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:23963 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965036AbWDHUO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:14:29 -0400
Date: Sun, 9 Apr 2006 04:11:27 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH rc1-mm 2/3] coredump: shutdown current process first
Message-ID: <20060409001127.GA101@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch optimize zap_threads() for the case when there are
no ->mm users except the current's thread group. In that case
we can avoid 'for_each_process()' loop.

It also adds a useful invariant: SIGNAL_GROUP_EXIT (if checked
under ->siglock) always implies that all threads (except may be
current) have pending SIGKILL.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/exec.c~2_optmz	2006-04-09 02:33:28.000000000 +0400
+++ MM/fs/exec.c	2006-04-09 03:06:43.000000000 +0400
@@ -1383,13 +1383,7 @@ static void format_corename(char *corena
 static void zap_process(struct task_struct *start)
 {
 	struct task_struct *t;
-	unsigned long flags;
 
-	/*
-	 * start->sighand can't disappear, but may be
-	 * changed by de_thread()
-	 */
-	lock_task_sighand(start, &flags);
 	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_stop_count = 0;
 
@@ -1401,40 +1395,51 @@ static void zap_process(struct task_stru
 			signal_wake_up(t, 1);
 		}
 	} while ((t = next_thread(t)) != start);
-
-	unlock_task_sighand(start, &flags);
 }
 
 static inline int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 				int exit_code)
 {
 	struct task_struct *g, *p;
+	unsigned long flags;
 	int err = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!(tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
-		tsk->signal->flags = SIGNAL_GROUP_EXIT;
 		tsk->signal->group_exit_code = exit_code;
-		tsk->signal->group_stop_count = 0;
+		zap_process(tsk);
 		err = 0;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 	if (err)
 		return err;
 
+	if (atomic_read(&mm->mm_users) == mm->core_waiters + 1)
+		goto done;
+
 	rcu_read_lock();
 	for_each_process(g) {
+		if (g == tsk->group_leader)
+			continue;
+
 		p = g;
 		do {
 			if (p->mm) {
-				if (p->mm == mm)
+				if (p->mm == mm) {
+					/*
+					 * p->sighand can't disappear, but
+					 * may be changed by de_thread()
+					 */
+					lock_task_sighand(p, &flags);
 					zap_process(p);
+					unlock_task_sighand(p, &flags);
+				}
 				break;
 			}
 		} while ((p = next_thread(p)) != g);
 	}
 	rcu_read_unlock();
-
+done:
 	return mm->core_waiters;
 }
 

