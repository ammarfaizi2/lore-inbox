Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTB1Gu2>; Fri, 28 Feb 2003 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTB1Gu2>; Fri, 28 Feb 2003 01:50:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1808 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267488AbTB1Gu1>; Fri, 28 Feb 2003 01:50:27 -0500
Date: Thu, 27 Feb 2003 22:58:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.63 tsk->usage count.
In-Reply-To: <200302271134.28229.schwidefsky@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0302272256520.18176-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Feb 2003, Martin Schwidefsky wrote:
> while debugging a memory leak with task structures on s390
> I found something related to it. If copy_process fails for some
> reason the task structure created with dup_task_struct has set
> p->usage to 2 but only one put_task_struct is done in the error
> cleanup code. The attached patch should take care of it.

This actually looks wrong, it ends up doing free_user() twice because a 
final put_task_struct() does that too these days.

Does this alternate patch work for you instead?

		Linus

----
===== kernel/fork.c 1.110 vs edited =====
--- 1.110/kernel/fork.c	Tue Feb 25 02:50:01 2003
+++ edited/kernel/fork.c	Thu Feb 27 22:56:36 2003
@@ -72,15 +72,8 @@
 	return total;
 }
 
-void __put_task_struct(struct task_struct *tsk)
+static void free_task_struct(struct task_struct *tsk)
 {
-	WARN_ON(!(tsk->state & (TASK_DEAD | TASK_ZOMBIE)));
-	WARN_ON(atomic_read(&tsk->usage));
-	WARN_ON(tsk == current);
-
-	security_task_free(tsk);
-	free_uid(tsk->user);
-
 	/*
 	 * The task cache is effectively disabled right now.
 	 * Do we want it? The slab cache already has per-cpu
@@ -103,6 +96,17 @@
 	}
 }
 
+void __put_task_struct(struct task_struct *tsk)
+{
+	WARN_ON(!(tsk->state & (TASK_DEAD | TASK_ZOMBIE)));
+	WARN_ON(atomic_read(&tsk->usage));
+	WARN_ON(tsk == current);
+
+	security_task_free(tsk);
+	free_uid(tsk->user);
+	free_task_struct(tsk);
+}
+
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -1034,7 +1038,7 @@
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
 bad_fork_free:
-	put_task_struct(p);
+	free_task_struct(p);
 	goto fork_out;
 }
 

