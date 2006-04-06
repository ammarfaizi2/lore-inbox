Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWDFSJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWDFSJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDFSJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:09:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:30872 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932156AbWDFSJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:09:30 -0400
Date: Fri, 7 Apr 2006 02:06:36 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] coredump: don't take tasklist_lock
Message-ID: <20060406220635.GA243@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depends on
	"[PATCH rc1-mm] de_thread: fix deadlockable process addition"

This patch removes tasklist_lock from zap_threads().
This is safe wrt:

	do_exit:
		The caller holds mm->mmap_sem. This means that task which
		shares the same ->mm can't pass exit_mm(), so it can't be
		unhashed from init_task.tasks or ->thread_group lists.

	fork:
		None of sub-threads can fork after zap_process(leader). All
		processes which were created before this point should be
		visible to zap_threads() because copy_process() adds the new
		process to the tail of init_task.tasks list, and ->siglock
		lock/unlock provides a memory barrier.

	de_thread:
		It does list_replace_rcu(&leader->tasks, &current->tasks).
		So zap_threads() will see either old or new leader, it does
		not matter. However, it can change p->sighand, so we should
		use lock_task_sighand() in zap_process().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/exec.c~4_TLOCK	2006-04-07 01:21:41.000000000 +0400
+++ MM/fs/exec.c	2006-04-07 01:32:02.000000000 +0400
@@ -1385,7 +1385,11 @@ static void zap_process(struct task_stru
 	struct task_struct *t;
 	unsigned long flags;
 
-	spin_lock_irqsave(&start->sighand->siglock, flags);
+	/*
+	 * start->sighand can't disappear, but may be
+	 * changed by de_thread()
+	 */
+	lock_task_sighand(start, &flags);
 	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_stop_count = 0;
 
@@ -1398,7 +1402,7 @@ static void zap_process(struct task_stru
 		}
 	} while ((t = next_thread(t)) != start);
 
-	spin_unlock_irqrestore(&start->sighand->siglock, flags);
+	unlock_task_sighand(start, &flags);
 }
 
 static void zap_threads(struct mm_struct *mm)
@@ -1416,7 +1420,7 @@ static void zap_threads(struct mm_struct
 		complete(vfork_done);
 	}
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process(g) {
 		p = g;
 		do {
@@ -1427,7 +1431,7 @@ static void zap_threads(struct mm_struct
 			}
 		} while ((p = next_thread(p)) != g);
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 }
 
 static void coredump_wait(struct mm_struct *mm)

