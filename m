Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbSLSBq5>; Wed, 18 Dec 2002 20:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbSLSBq4>; Wed, 18 Dec 2002 20:46:56 -0500
Received: from fmr06.intel.com ([134.134.136.7]:58340 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267506AbSLSBqr>; Wed, 18 Dec 2002 20:46:47 -0500
Subject: [PATCH 2.5.52] Use __set_current_state() instead of current->state = (take 2)
To: linux-kernel@vger.kernel.org, rml@tech9.net, torvalds@transmeta.com
Message-Id: <E18OpoV-00020l-00@milikk>
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Date: Wed, 18 Dec 2002 17:49:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all

In fs/*.c, many functions manually set the task state directly
accessing current->state, or with a macro, kind of
inconsistently. This patch changes all of them to use
[__]set_current_state().

Changelog:

- Added feedback from Robert Love regarding usage of
  __set_current_thread() vs. set_current_thread() to avoid race
  conditions related to memory flush. 

- Use cond_resched() in namei.c:do_follow_link().

Take 1:

- Ported forward to 2.5.52

diff -u fs/dquot.c:1.1.1.4 fs/dquot.c:1.1.1.1.6.2
--- fs/dquot.c:1.1.1.4	Wed Dec 11 11:13:35 2002
+++ fs/dquot.c	Wed Dec 18 13:20:24 2002
@@ -264,7 +264,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(&dquot->dq_wait_lock, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 static inline void wait_on_dquot(struct dquot *dquot)
@@ -298,7 +298,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(&dquot->dq_wait_free, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 /* Wait for all duplicated dquot references to be dropped */
@@ -314,7 +314,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(&dquot->dq_wait_free, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 static int read_dqblk(struct dquot *dquot)
diff -u fs/exec.c:1.1.1.8 fs/exec.c:1.1.1.1.6.2
--- fs/exec.c:1.1.1.8	Mon Dec 16 18:44:31 2002
+++ fs/exec.c	Wed Dec 18 13:20:24 2002
@@ -587,7 +587,7 @@
 		count = 1;
 	while (atomic_read(&oldsig->count) > count) {
 		oldsig->group_exit_task = current;
-		current->state = TASK_UNINTERRUPTIBLE;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(&oldsig->siglock);
 		schedule();
 		spin_lock_irq(&oldsig->siglock);
diff -u fs/inode.c:1.1.1.6 fs/inode.c:1.1.1.1.6.2
--- fs/inode.c:1.1.1.6	Mon Dec 16 18:44:31 2002
+++ fs/inode.c	Wed Dec 18 13:20:24 2002
@@ -1195,7 +1195,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(wq, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 void wake_up_inode(struct inode *inode)
diff -u fs/locks.c:1.1.1.6 fs/locks.c:1.1.1.1.6.3
--- fs/locks.c:1.1.1.6	Wed Dec 11 11:13:35 2002
+++ fs/locks.c	Wed Dec 18 17:42:37 2002
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
 
diff -u fs/namei.c:1.1.1.6 fs/namei.c:1.1.1.1.6.3
--- fs/namei.c:1.1.1.6	Wed Dec 11 11:13:35 2002
+++ fs/namei.c	Wed Dec 18 17:42:49 2002
@@ -409,10 +409,7 @@
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
diff -u fs/select.c:1.1.1.3 fs/select.c:1.1.1.1.6.2
--- fs/select.c:1.1.1.3	Wed Dec 11 11:10:14 2002
+++ fs/select.c	Wed Dec 18 13:20:24 2002
@@ -235,7 +235,7 @@
 		}
 		__timeout = schedule_timeout(__timeout);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 
 	poll_freewait(&table);
 
@@ -417,7 +417,7 @@
 			break;
 		timeout = schedule_timeout(timeout);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 	return count;
 }
 


-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
