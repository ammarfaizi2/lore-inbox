Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWCWS0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWCWS0B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWCWS0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:26:01 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:12183 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932324AbWCWS0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:26:00 -0500
Message-ID: <4422E786.D56DD978@tv-sign.ru>
Date: Thu, 23 Mar 2006 21:23:02 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-mm1] cleanup __exit_signal->cleanup_sighand path
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves 'tsk->sighand = NULL' from cleanup_sighand() to
__exit_signal(). This makes the exit path more understandable and
allows us to do cleanup_sighand() outside of ->siglock protected
section.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/include/linux/sched.h~1_ESCS	2006-03-23 22:48:10.000000000 +0300
+++ MM/include/linux/sched.h	2006-03-23 23:00:02.000000000 +0300
@@ -1184,7 +1184,7 @@ extern void exit_thread(void);
 
 extern void exit_files(struct task_struct *);
 extern void __cleanup_signal(struct signal_struct *);
-extern void cleanup_sighand(struct task_struct *);
+extern void __cleanup_sighand(struct sighand_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern NORET_TYPE void do_group_exit(int);
--- MM/kernel/fork.c~1_ESCS	2006-03-23 22:48:10.000000000 +0300
+++ MM/kernel/fork.c	2006-03-23 22:59:33.000000000 +0300
@@ -808,12 +808,8 @@ static inline int copy_sighand(unsigned 
 	return 0;
 }
 
-void cleanup_sighand(struct task_struct *tsk)
+void __cleanup_sighand(struct sighand_struct *sighand)
 {
-	struct sighand_struct * sighand = tsk->sighand;
-
-	/* Ok, we're done with the signal handlers */
-	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
 		kmem_cache_free(sighand_cachep, sighand);
 }
@@ -1232,7 +1228,7 @@ bad_fork_cleanup_mm:
 bad_fork_cleanup_signal:
 	cleanup_signal(p);
 bad_fork_cleanup_sighand:
-	cleanup_sighand(p);
+	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
--- MM/kernel/exit.c~1_ESCS	2006-03-23 22:48:10.000000000 +0300
+++ MM/kernel/exit.c	2006-03-23 23:02:53.000000000 +0300
@@ -114,10 +114,11 @@ static void __exit_signal(struct task_st
 	__unhash_process(tsk);
 
 	tsk->signal = NULL;
-	cleanup_sighand(tsk);
+	tsk->sighand = NULL;
 	spin_unlock(&sighand->siglock);
 	rcu_read_unlock();
 
+	__cleanup_sighand(sighand);
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
 	if (sig) {
