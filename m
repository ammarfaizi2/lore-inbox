Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319473AbSH3Hfs>; Fri, 30 Aug 2002 03:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319474AbSH3Hfs>; Fri, 30 Aug 2002 03:35:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39068 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319473AbSH3Hfr>;
	Fri, 30 Aug 2002 03:35:47 -0400
Date: Fri, 30 Aug 2002 09:43:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: [patch] scheduler fixes, 2.5.32-BK
Message-ID: <Pine.LNX.4.44.0208300939030.8227-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch adds two scheduler related fixes:

 - changes the migration code to use struct completion. Andrew pointed out
   that there might be a small window in where the up() touches the
   semaphore while the waiting task goes on and frees its stack. And
   completion is more suited for this kind of stuff anyway.

 - removes two unneeded exports, pointed out by Andrew.

	Ingo

--- linux/kernel/sched.c.orig	Fri Aug 30 09:34:34 2002
+++ linux/kernel/sched.c	Fri Aug 30 09:35:49 2002
@@ -1901,7 +1901,7 @@
 typedef struct {
 	list_t list;
 	task_t *task;
-	struct semaphore sem;
+	struct completion done;
 } migration_req_t;
 
 /*
@@ -1945,13 +1945,13 @@
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
-	init_MUTEX_LOCKED(&req.sem);
+	init_completion(&req.done);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);
 	task_rq_unlock(rq, &flags);
 	wake_up_process(rq->migration_thread);
 
-	down(&req.sem);
+	wait_for_completion(&req.done);
 out:
 	preempt_enable();
 }
@@ -2032,7 +2032,7 @@
 		double_rq_unlock(rq_src, rq_dest);
 		local_irq_restore(flags);
 
-		up(&req->sem);
+		complete(&req->done);
 	}
 }
 
--- linux/kernel/ksyms.c.orig	Fri Aug 30 09:37:36 2002
+++ linux/kernel/ksyms.c	Fri Aug 30 09:37:38 2002
@@ -496,8 +496,6 @@
 #endif
 
 EXPORT_SYMBOL(kstat);
-EXPORT_SYMBOL(nr_running);
-EXPORT_SYMBOL(nr_context_switches);
 
 /* misc */
 EXPORT_SYMBOL(panic);


