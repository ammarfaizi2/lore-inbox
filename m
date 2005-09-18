Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVIRNje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVIRNje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVIRNja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:39:30 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:38797 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751227AbVIRNjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:39:13 -0400
Message-ID: <432D70BF.83872419@tv-sign.ru>
Date: Sun, 18 Sep 2005 17:50:55 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] remove hardcoded SEND_SIG_xxx constants
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces hardcoded SEND_SIG_xxx constants with
their symbolic names.

No changes in affected .o files.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc1/kernel/signal.c~1_SYMB	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc1/kernel/signal.c	2005-09-18 18:31:04.000000000 +0400
@@ -661,8 +661,9 @@ static int check_kill_permission(int sig
 	if (!valid_signal(sig))
 		return error;
 	error = -EPERM;
-	if ((!info || ((unsigned long)info != 1 &&
-			(unsigned long)info != 2 && SI_FROMUSER(info)))
+	if ((info == SEND_SIG_NOINFO ||
+			(info != SEND_SIG_PRIV && info != SEND_SIG_FORCED
+				&& SI_FROMUSER(info)))
 	    && ((sig != SIGCONT) ||
 		(current->signal->session != t->signal->session))
 	    && (current->euid ^ t->suid) && (current->euid ^ t->uid)
@@ -799,7 +800,7 @@ static int send_signal(int sig, struct s
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
 	 * or SIGKILL.
 	 */
-	if ((unsigned long)info == 2)
+	if (info == SEND_SIG_FORCED)
 		goto out_set;
 
 	/* Real-time signals must be queued if sent by sigqueue, or
@@ -811,19 +812,19 @@ static int send_signal(int sig, struct s
 	   pass on the info struct.  */
 
 	q = __sigqueue_alloc(t, GFP_ATOMIC, (sig < SIGRTMIN &&
-					     ((unsigned long) info < 2 ||
+					     (info < SEND_SIG_FORCED ||
 					      info->si_code >= 0)));
 	if (q) {
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
-		case 0:
+		case (unsigned long) SEND_SIG_NOINFO:
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
 			q->info.si_code = SI_USER;
 			q->info.si_pid = current->pid;
 			q->info.si_uid = current->uid;
 			break;
-		case 1:
+		case (unsigned long) SEND_SIG_PRIV:
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
 			q->info.si_code = SI_KERNEL;
@@ -835,14 +836,15 @@ static int send_signal(int sig, struct s
 			break;
 		}
 	} else {
-		if (sig >= SIGRTMIN && info && (unsigned long)info != 1
+		if (sig >= SIGRTMIN
+		   && info != SEND_SIG_NOINFO && info != SEND_SIG_PRIV
 		   && info->si_code != SI_USER)
 		/*
 		 * Queue overflow, abort.  We may abort if the signal was rt
 		 * and sent by user using something other than kill().
 		 */
 			return -EAGAIN;
-		if (((unsigned long)info > 1) && (info->si_code == SI_TIMER))
+		if ((info > SEND_SIG_PRIV) && (info->si_code == SI_TIMER))
 			/*
 			 * Set up a return to indicate that we dropped 
 			 * the signal.
@@ -868,7 +870,7 @@ specific_send_sig_info(int sig, struct s
 		BUG();
 	assert_spin_locked(&t->sighand->siglock);
 
-	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
+	if ((info > SEND_SIG_FORCED) && (info->si_code == SI_TIMER))
 		/*
 		 * Set up a return to indicate that we dropped the signal.
 		 */
@@ -924,7 +926,7 @@ force_sig_specific(int sig, struct task_
 		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	sigdelset(&t->blocked, sig);
 	recalc_sigpending_tsk(t);
-	specific_send_sig_info(sig, (void *)2, t);
+	specific_send_sig_info(sig, SEND_SIG_FORCED, t);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 }
 
@@ -1063,7 +1065,7 @@ __group_send_sig_info(int sig, struct si
 	assert_spin_locked(&p->sighand->siglock);
 	handle_stop_signal(sig, p);
 
-	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
+	if ((info > SEND_SIG_FORCED) && (info->si_code == SI_TIMER))
 		/*
 		 * Set up a return to indicate that we dropped the signal.
 		 */
@@ -1264,10 +1266,13 @@ send_sig_info(int sig, struct siginfo *i
 	return ret;
 }
 
+#define __si_special(priv) \
+	((priv) ? SEND_SIG_PRIV : SEND_SIG_NOINFO)
+
 int
 send_sig(int sig, struct task_struct *p, int priv)
 {
-	return send_sig_info(sig, (void*)(long)(priv != 0), p);
+	return send_sig_info(sig, __si_special(priv), p);
 }
 
 /*
@@ -1287,7 +1292,7 @@ send_group_sig_info(int sig, struct sigi
 void
 force_sig(int sig, struct task_struct *p)
 {
-	force_sig_info(sig, (void*)1L, p);
+	force_sig_info(sig, SEND_SIG_PRIV, p);
 }
 
 /*
@@ -1312,13 +1317,13 @@ force_sigsegv(int sig, struct task_struc
 int
 kill_pg(pid_t pgrp, int sig, int priv)
 {
-	return kill_pg_info(sig, (void *)(long)(priv != 0), pgrp);
+	return kill_pg_info(sig, __si_special(priv), pgrp);
 }
 
 int
 kill_proc(pid_t pid, int sig, int priv)
 {
-	return kill_proc_info(sig, (void *)(long)(priv != 0), pid);
+	return kill_proc_info(sig, __si_special(priv), pid);
 }
 
 /*
--- 2.6.14-rc1/kernel/exit.c~1_SYMB	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc1/kernel/exit.c	2005-09-17 22:24:28.000000000 +0400
@@ -541,7 +541,7 @@ static inline void reparent_thread(task_
 
 	if (p->pdeath_signal)
 		/* We already hold the tasklist_lock here.  */
-		group_send_sig_info(p->pdeath_signal, (void *) 0, p);
+		group_send_sig_info(p->pdeath_signal, SEND_SIG_NOINFO, p);
 
 	/* Move the child from its dying parent to the new one.  */
 	if (unlikely(traced)) {
@@ -585,8 +585,8 @@ static inline void reparent_thread(task_
 		int pgrp = process_group(p);
 
 		if (will_become_orphaned_pgrp(pgrp, NULL) && has_stopped_jobs(pgrp)) {
-			__kill_pg_info(SIGHUP, (void *)1, pgrp);
-			__kill_pg_info(SIGCONT, (void *)1, pgrp);
+			__kill_pg_info(SIGHUP, SEND_SIG_PRIV, pgrp);
+			__kill_pg_info(SIGCONT, SEND_SIG_PRIV, pgrp);
 		}
 	}
 }
@@ -721,8 +721,8 @@ static void exit_notify(struct task_stru
 	    (t->signal->session == tsk->signal->session) &&
 	    will_become_orphaned_pgrp(process_group(tsk), tsk) &&
 	    has_stopped_jobs(process_group(tsk))) {
-		__kill_pg_info(SIGHUP, (void *)1, process_group(tsk));
-		__kill_pg_info(SIGCONT, (void *)1, process_group(tsk));
+		__kill_pg_info(SIGHUP, SEND_SIG_PRIV, process_group(tsk));
+		__kill_pg_info(SIGCONT, SEND_SIG_PRIV, process_group(tsk));
 	}
 
 	/* Let father know we died 
--- 2.6.14-rc1/security/selinux/hooks.c~1_SYMB	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc1/security/selinux/hooks.c	2005-09-18 17:55:07.000000000 +0400
@@ -2688,8 +2688,8 @@ static int selinux_task_kill(struct task
 	if (rc)
 		return rc;
 
-	if (info && ((unsigned long)info == 1 ||
-	             (unsigned long)info == 2 || SI_FROMKERNEL(info)))
+	if (info != SEND_SIG_NOINFO && (info == SEND_SIG_PRIV ||
+					info == SEND_SIG_FORCED || SI_FROMKERNEL(info)))
 		return 0;
 
 	if (!sig)
