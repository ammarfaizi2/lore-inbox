Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbSJQTKn>; Thu, 17 Oct 2002 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSJQTKn>; Thu, 17 Oct 2002 15:10:43 -0400
Received: from fmr01.intel.com ([192.55.52.18]:42225 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261771AbSJQTKk>;
	Thu, 17 Oct 2002 15:10:40 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC7E7@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "lkml (E-mail)" <linux-kernel@vger.kernel.org>
Cc: "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: [PATCH] Cleanup of current->state for __set_current_state in linu
	x/fs/*.c
Date: Thu, 17 Oct 2002 12:15:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All

This is a simple patch to remove all direct usage of
current->state in fs/*.c and use the helper __set_current_state().

Applies vs 2.5.43

Maybe it'd be better to use set_current_state() so it 
is truly SMP safe. I was wondering, but I did not want
to change it without someone confirming a good reason.

Cheers,


diff -urN linux-2.5.43.orig/fs/dquot.c linux-2.5.43/fs/dquot.c
--- linux-2.5.43.orig/fs/dquot.c	Tue Oct 15 20:28:29 2002
+++ linux-2.5.43/fs/dquot.c	Wed Oct 16 22:11:22 2002
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
diff -urN linux-2.5.43.orig/fs/exec.c linux-2.5.43/fs/exec.c
--- linux-2.5.43.orig/fs/exec.c	Tue Oct 15 20:27:53 2002
+++ linux-2.5.43/fs/exec.c	Wed Oct 16 22:12:47 2002
@@ -564,7 +564,7 @@
 		count = 1;
 	while (atomic_read(&oldsig->count) > count) {
 		oldsig->group_exit_task = current;
-		current->state = TASK_UNINTERRUPTIBLE;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(&oldsig->siglock);
 		schedule();
 		spin_lock_irq(&oldsig->siglock);
diff -urN linux-2.5.43.orig/fs/inode.c linux-2.5.43/fs/inode.c
--- linux-2.5.43.orig/fs/inode.c	Tue Oct 15 20:29:06 2002
+++ linux-2.5.43/fs/inode.c	Wed Oct 16 22:13:21 2002
@@ -1156,7 +1156,7 @@
 		goto repeat;
 	}
 	remove_wait_queue(wq, &wait);
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 }
 
 void wake_up_inode(struct inode *inode)
diff -urN linux-2.5.43.orig/fs/locks.c linux-2.5.43/fs/locks.c
--- linux-2.5.43.orig/fs/locks.c	Tue Oct 15 20:29:04 2002
+++ linux-2.5.43/fs/locks.c	Wed Oct 16 22:06:41 2002
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
 
diff -urN linux-2.5.43.orig/fs/namei.c linux-2.5.43/fs/namei.c
--- linux-2.5.43.orig/fs/namei.c	Tue Oct 15 20:27:51 2002
+++ linux-2.5.43/fs/namei.c	Wed Oct 16 22:10:39 2002
@@ -410,7 +410,7 @@
 	if (current->total_link_count >= 40)
 		goto loop;
 	if (need_resched()) {
-		current->state = TASK_RUNNING;
+		__set_current_state(TASK_RUNNING);
 		schedule();
 	}
 	err = security_ops->inode_follow_link(dentry, nd);
diff -urN linux-2.5.43.orig/fs/pipe.c linux-2.5.43/fs/pipe.c
--- linux-2.5.43.orig/fs/pipe.c	Tue Oct 15 20:28:23 2002
+++ linux-2.5.43/fs/pipe.c	Wed Oct 16 22:10:34 2002
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
 
diff -urN linux-2.5.43.orig/fs/select.c linux-2.5.43/fs/select.c
--- linux-2.5.43.orig/fs/select.c	Tue Oct 15 20:27:09 2002
+++ linux-2.5.43/fs/select.c	Wed Oct 16 21:58:32 2002
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
 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


