Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265764AbSJTE2w>; Sun, 20 Oct 2002 00:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265765AbSJTE2w>; Sun, 20 Oct 2002 00:28:52 -0400
Received: from fmr06.intel.com ([134.134.136.7]:27850 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265764AbSJTE2u>; Sun, 20 Oct 2002 00:28:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15794.12783.828436.735651@milikk.co.intel.com>
Date: Sat, 19 Oct 2002 21:32:47 -0700
From: Inaky Perez Gonzalez <inaky.perez-gonzalez@intel.com>
To: linux-kernel@vger.kernel.org
Subject: Cleanup manual setting of current->state, use __set_current_state() [fs/*.c]
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In fs/*.c, many functions manually set the task state directly
accessing current->state, or with a macro, kind of
inconsistently. This patch forces all of them to use
[__]set_current_state().


This patch is against 2.5.44.


diff -u fs/dquot.c:1.1.1.3 fs/dquot.c:1.1.1.3.4.1
--- fs/dquot.c:1.1.1.3	Thu Oct 17 13:08:29 2002
+++ fs/dquot.c	Fri Oct 18 12:59:16 2002
@@ -262,7 +262,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(&dquot->dq_wait_lock, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 static inline void wait_on_dquot(struct dquot *dquot)
@@ -296,7 +296,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(&dquot->dq_wait_free, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 /* Wait for all duplicated dquot references to be dropped */
@@ -312,7 +312,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(&dquot->dq_wait_free, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 static int read_dqblk(struct dquot *dquot)

diff -u fs/exec.c:1.1.1.3 fs/exec.c:1.1.1.3.4.1
--- fs/exec.c:1.1.1.3	Thu Oct 17 13:08:29 2002
+++ fs/exec.c	Fri Oct 18 12:59:16 2002
@@ -564,7 +564,7 @@
 		count = 1;
 	while (atomic_read(&oldsig->count) > count) {
 		oldsig->group_exit_task = current;
-		current->state = TASK_UNINTERRUPTIBLE;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(&oldsig->siglock);
 		schedule();
 		spin_lock_irq(&oldsig->siglock);

diff -u fs/inode.c:1.1.1.3 fs/inode.c:1.1.1.3.4.1
--- fs/inode.c:1.1.1.3	Thu Oct 17 13:08:29 2002
+++ fs/inode.c	Fri Oct 18 12:59:16 2002
@@ -1156,7 +1156,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(wq, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 void wake_up_inode(struct inode *inode)

diff -u fs/locks.c:1.1.1.2 fs/locks.c:1.1.1.1.6.2
--- fs/locks.c:1.1.1.2	Fri Oct 18 22:54:44 2002
+++ fs/locks.c	Sat Oct 19 21:19:04 2002
@@ -561,7 +561,7 @@
 	int result = 0;
 	DECLARE_WAITQUEUE(wait, current);
 
-	current->state = TASK_INTERRUPTIBLE;
+	__set_current_state (TASK_INTERRUPTIBLE);
 	add_wait_queue(fl_wait, &wait);
 	if (timeout == 0)
 		schedule();
@@ -570,7 +570,7 @@
 	if (signal_pending(current))
 		result = -ERESTARTSYS;
 	remove_wait_queue(fl_wait, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 	return result;
 }
 

diff -u fs/namei.c:1.1.1.1 fs/namei.c:1.1.1.1.6.1
--- fs/namei.c:1.1.1.1	Tue Oct  8 19:47:18 2002
+++ fs/namei.c	Fri Oct 18 12:59:16 2002
@@ -410,7 +410,7 @@
 	if (current->total_link_count >= 40)
 		goto loop;
 	if (need_resched()) {
-		current->state = TASK_RUNNING;
+		__set_current_state(TASK_RUNNING);
 		schedule();
 	}
 	err = security_ops->inode_follow_link(dentry, nd);

diff -u fs/pipe.c:1.1.1.2 fs/pipe.c:1.1.1.2.4.1
--- fs/pipe.c:1.1.1.2	Thu Oct 17 13:06:35 2002
+++ fs/pipe.c	Fri Oct 18 12:59:16 2002
@@ -34,12 +34,12 @@
 void pipe_wait(struct inode * inode)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	current->state = TASK_INTERRUPTIBLE;
+	__set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(PIPE_WAIT(*inode), &wait);
 	up(PIPE_SEM(*inode));
 	schedule();
 	remove_wait_queue(PIPE_WAIT(*inode), &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 	down(PIPE_SEM(*inode));
 }
 

diff -u fs/select.c:1.1.1.1 fs/select.c:1.1.1.1.6.1
--- fs/select.c:1.1.1.1	Tue Oct  8 19:47:18 2002
+++ fs/select.c	Fri Oct 18 12:59:16 2002
@@ -224,7 +224,7 @@
 		}
 		__timeout = schedule_timeout(__timeout);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 
 	poll_freewait(&table);
 
@@ -406,7 +406,7 @@
 			break;
 		timeout = schedule_timeout(timeout);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state (TASK_RUNNING);
 	return count;
 }
 

-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
