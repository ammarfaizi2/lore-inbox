Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTCEXIv>; Wed, 5 Mar 2003 18:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTCEXIv>; Wed, 5 Mar 2003 18:08:51 -0500
Received: from fmr05.intel.com ([134.134.136.6]:60891 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266114AbTCEXIq>; Wed, 5 Mar 2003 18:08:46 -0500
Message-ID: <15974.34008.255564.492025@milikk.co.intel.com>
Date: Wed, 5 Mar 2003 15:14:32 -0800
Subject: [PATCH 2.5.64] Use __set_current_state() instead of current->state = (take 3)
To: linux-kernel@vger.kernel.org, rml@tech9.net, torvalds@transmeta.com
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all

In fs/*.c, many functions manually set the task state directly
accessing current->state, or with a macro, kind of
inconsistently. This patch changes all of them to use
[__]set_current_state().

Changelog:

 Take 3:

  - Port to 2.5.64

  - Port to 2.5.57

  - Use safe set_current_state() instead of __set... in
    exec.c:de_thread()

 Take 2:

  - Added feedback from Robert Love regarding usage of
    __set_current_thread() vs. set_current_thread() to avoid race
    conditions related to memory flush. 

  - Use cond_resched() in namei.c:do_follow_link().

 Take 1:

  - Ported forward to 2.5.52

diff -u linux/fs/exec.c:1.1.1.15 linux/fs/exec.c:1.1.1.1.6.6
--- linux/fs/exec.c:1.1.1.15	Mon Feb 24 21:04:49 2003
+++ linux/fs/exec.c	Wed Mar  5 15:06:02 2003
@@ -633,7 +633,7 @@
 		count = 1;
 	while (atomic_read(&oldsig->count) > count) {
 		oldsig->group_exit_task = current;
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(lock);
 		schedule();
 		spin_lock_irq(lock);
diff -u linux/fs/inode.c:1.1.1.10 linux/fs/inode.c:1.1.1.1.6.6
--- linux/fs/inode.c:1.1.1.10	Wed Mar  5 08:12:22 2003
+++ linux/fs/inode.c	Wed Mar  5 15:06:02 2003
@@ -1208,7 +1208,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(wq, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 void wake_up_inode(struct inode *inode)
diff -u linux/fs/locks.c:1.1.1.7 linux/fs/locks.c:1.1.1.1.6.4
--- linux/fs/locks.c:1.1.1.7	Tue Feb 18 12:51:54 2003
+++ linux/fs/locks.c	Wed Mar  5 15:06:02 2003
@@ -571,7 +571,7 @@
 	int result = 0;
 	DECLARE_WAITQUEUE(wait, current);
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state (TASK_INTERRUPTIBLE);
 	add_wait_queue(fl_wait, &wait);
 	if (timeout == 0)
 		schedule();
@@ -580,7 +580,7 @@
 	if (signal_pending(current))
 		result = -ERESTARTSYS;
 	remove_wait_queue(fl_wait, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 	return result;
 }
 
diff -u linux/fs/namei.c:1.1.1.9 linux/fs/namei.c:1.1.1.1.6.6
--- linux/fs/namei.c:1.1.1.9	Tue Feb 18 12:51:54 2003
+++ linux/fs/namei.c	Wed Mar  5 15:06:02 2003
@@ -388,10 +388,7 @@
 		goto loop;
 	if (current->total_link_count >= 40)
 		goto loop;
-	if (need_resched()) {
-		current->state = TASK_RUNNING;
-		schedule();
-	}
+	cond_resched();
 	err = security_inode_follow_link(dentry, nd);
 	if (err)
 		goto loop;
diff -u linux/fs/select.c:1.1.1.5 linux/fs/select.c:1.1.1.1.6.4
--- linux/fs/select.c:1.1.1.5	Fri Jan 10 14:36:46 2003
+++ linux/fs/select.c	Fri Jan 10 16:45:54 2003
@@ -235,7 +235,7 @@
 		}
 		__timeout = schedule_timeout(__timeout);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 
 	poll_freewait(&table);
 
@@ -425,7 +425,7 @@
 			break;
 		timeout = schedule_timeout(timeout);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 	return count;
 }
 

-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
