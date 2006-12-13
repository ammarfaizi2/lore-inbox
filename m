Return-Path: <linux-kernel-owner+w=401wt.eu-S964860AbWLMLWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWLMLWG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWLMLTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57332 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964858AbWLMLTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:38 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 12/12] pid: Remove the now unused kill_pg kill_pg_info and __kill_pg_info
Date: Wed, 13 Dec 2006 04:07:56 -0700
Message-Id: <11660080801734-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I have changed all of the in-tree users remove the old
version of these  functions.  This should make it clear to any
out of tree users that they should be using kill_pgrp kill_pgrp_info
or __kill_pgrp_info instead.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sched.h |    3 ---
 kernel/signal.c       |   27 ---------------------------
 2 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef0d6fe..f455f02 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1328,14 +1328,11 @@ extern int kill_pid_info(int sig, struct siginfo *info, struct pid *pid);
 extern int kill_pid_info_as_uid(int, struct siginfo *, struct pid *, uid_t, uid_t, u32);
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
-extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
-extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
 extern int send_sig(int, struct task_struct *, int);
 extern void zap_other_threads(struct task_struct *p);
-extern int kill_pg(pid_t, int, int);
 extern int kill_proc(pid_t, int, int);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 91caafa..2b29e95 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1096,26 +1096,6 @@ int kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp)
 	return retval;
 }
 
-int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
-{
-	if (pgrp <= 0)
-		return -EINVAL;
-
-	return __kill_pgrp_info(sig, info, find_pid(pgrp));
-}
-
-int
-kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
-{
-	int retval;
-
-	read_lock(&tasklist_lock);
-	retval = __kill_pg_info(sig, info, pgrp);
-	read_unlock(&tasklist_lock);
-
-	return retval;
-}
-
 int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
 {
 	int error;
@@ -1316,12 +1296,6 @@ int kill_pid(struct pid *pid, int sig, int priv)
 EXPORT_SYMBOL(kill_pid);
 
 int
-kill_pg(pid_t pgrp, int sig, int priv)
-{
-	return kill_pg_info(sig, __si_special(priv), pgrp);
-}
-
-int
 kill_proc(pid_t pid, int sig, int priv)
 {
 	return kill_proc_info(sig, __si_special(priv), pid);
@@ -1958,7 +1932,6 @@ EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL_GPL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
 EXPORT_SYMBOL(force_sig);
-EXPORT_SYMBOL(kill_pg);
 EXPORT_SYMBOL(kill_proc);
 EXPORT_SYMBOL(ptrace_notify);
 EXPORT_SYMBOL(send_sig);
-- 
1.4.4.1.g278f

