Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUIGOpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUIGOpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUIGOng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:43:36 -0400
Received: from verein.lst.de ([213.95.11.210]:42905 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268111AbUIGOmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:42:07 -0400
Date: Tue, 7 Sep 2004 16:41:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead code and exports from signal.c
Message-ID: <20040907144158.GA8717@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.252/include/linux/sched.h	2004-09-03 11:08:16 +02:00
+++ edited/include/linux/sched.h	2004-09-07 13:55:45 +02:00
@@ -736,7 +736,6 @@
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
-extern int kill_sl_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
 extern void notify_parent(struct task_struct *, int);
 extern void do_notify_parent(struct task_struct *, int);
--- 1.132/kernel/signal.c	2004-09-02 11:48:04 +02:00
+++ edited/kernel/signal.c	2004-09-07 15:34:47 +02:00
@@ -1137,36 +1137,6 @@
 	return retval;
 }
 
-/*
- * kill_sl_info() sends a signal to the session leader: this is used
- * to send SIGHUP to the controlling process of a terminal when
- * the connection is lost.
- */
-
-
-int
-kill_sl_info(int sig, struct siginfo *info, pid_t sid)
-{
-	int err, retval = -EINVAL;
-	struct task_struct *p;
-
-	if (sid <= 0)
-		goto out;
-
-	retval = -ESRCH;
-	read_lock(&tasklist_lock);
-	do_each_task_pid(sid, PIDTYPE_SID, p) {
-		if (!p->signal->leader)
-			continue;
-		err = group_send_sig_info(sig, info, p);
-		if (retval)
-			retval = err;
-	} while_each_task_pid(sid, PIDTYPE_SID, p);
-	read_unlock(&tasklist_lock);
-out:
-	return retval;
-}
-
 int
 kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 {
@@ -1303,12 +1273,6 @@
 }
 
 int
-kill_sl(pid_t sess, int sig, int priv)
-{
-	return kill_sl_info(sig, (void *)(long)(priv != 0), sess);
-}
-
-int
 kill_proc(pid_t pid, int sig, int priv)
 {
 	return kill_proc_info(sig, (void *)(long)(priv != 0), pid);
@@ -1956,22 +1920,10 @@
 EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL_GPL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
-EXPORT_SYMBOL(force_sig);
-EXPORT_SYMBOL(force_sig_info);
 EXPORT_SYMBOL(kill_pg);
-EXPORT_SYMBOL(kill_pg_info);
 EXPORT_SYMBOL(kill_proc);
-EXPORT_SYMBOL(kill_proc_info);
-EXPORT_SYMBOL(kill_sl);
-EXPORT_SYMBOL(kill_sl_info);
-EXPORT_SYMBOL(notify_parent);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
-EXPORT_SYMBOL(send_group_sig_info);
-EXPORT_SYMBOL(sigqueue_alloc);
-EXPORT_SYMBOL(sigqueue_free);
-EXPORT_SYMBOL(send_sigqueue);
-EXPORT_SYMBOL(send_group_sigqueue);
 EXPORT_SYMBOL(sigprocmask);
 EXPORT_SYMBOL(block_all_signals);
 EXPORT_SYMBOL(unblock_all_signals);
