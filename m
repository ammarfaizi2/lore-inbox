Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUFBCS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUFBCS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 22:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUFBCS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 22:18:59 -0400
Received: from ozlabs.org ([203.10.76.45]:60604 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265305AbUFBCSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 22:18:55 -0400
From: Jeremy Kerr <jeremy@redfishsoftware.com.au>
To: akpm@osdl.org
Subject: [PATCH] Fix signal race during process exit
Date: Wed, 2 Jun 2004 12:13:58 +1000
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021213.58305.jeremy@redfishsoftware.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a race where timer-generated signals are delivered to an 
exiting process, after task->sighand is cleared.

update_one_process() declared static, as it is only used in kernel/timer.c

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>



Jeremy

diff -urN linux-2.6.7-rc2-bk2.orig/include/linux/sched.h 
linux-2.6.7-rc2-bk2/include/linux/sched.h
--- linux-2.6.7-rc2-bk2.orig/include/linux/sched.h	2004-06-02 
11:29:13.000000000 +1000
+++ linux-2.6.7-rc2-bk2/include/linux/sched.h	2004-06-02 11:46:57.000000000 
+1000
@@ -168,8 +168,6 @@
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
-extern void update_one_process(struct task_struct *p, unsigned long user,
-			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
Binary files linux-2.6.7-rc2-bk2.orig/kernel/.signal.c.swp and 
linux-2.6.7-rc2-bk2/kernel/.signal.c.swp differ
Binary files linux-2.6.7-rc2-bk2.orig/kernel/.timer.c.swp and 
linux-2.6.7-rc2-bk2/kernel/.timer.c.swp differ
diff -urN linux-2.6.7-rc2-bk2.orig/kernel/signal.c 
linux-2.6.7-rc2-bk2/kernel/signal.c
--- linux-2.6.7-rc2-bk2.orig/kernel/signal.c	2004-06-02 11:29:13.000000000 
+1000
+++ linux-2.6.7-rc2-bk2/kernel/signal.c	2004-06-02 11:47:28.000000000 +1000
@@ -323,7 +323,10 @@
 {
 	struct sighand_struct * sighand = tsk->sighand;
 
-	/* Ok, we're done with the signal handlers */
+	/* Ok, we're done with the signal handlers.
+	 * Set sighand to NULL to tell kernel/timer.c not
+	 * to deliver further signals to this task
+	 */
 	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
 		kmem_cache_free(sighand_cachep, sighand);
diff -urN linux-2.6.7-rc2-bk2.orig/kernel/timer.c 
linux-2.6.7-rc2-bk2/kernel/timer.c
--- linux-2.6.7-rc2-bk2.orig/kernel/timer.c	2004-06-02 11:29:13.000000000 
+1000
+++ linux-2.6.7-rc2-bk2/kernel/timer.c	2004-06-02 11:47:08.000000000 +1000
@@ -829,7 +829,7 @@
 	}
 }
 
-void update_one_process(struct task_struct *p, unsigned long user,
+static void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
 	do_process_times(p, user, system);
@@ -846,7 +846,9 @@
 	struct task_struct *p = current;
 	int cpu = smp_processor_id(), system = user_tick ^ 1;
 
-	update_one_process(p, user_tick, system, cpu);
+	/* Don't send signals to current after release_task() */
+	if (likely(p->sighand)) 
+		update_one_process(p, user_tick, system, cpu);
 	run_local_timers();
 	scheduler_tick(user_tick, system);
 }



