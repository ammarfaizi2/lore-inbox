Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVIRNjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVIRNjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVIRNjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:39:08 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:39053 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751227AbVIRNjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:39:06 -0400
Message-ID: <432D70C1.F55217B9@tv-sign.ru>
Date: Sun, 18 Sep 2005 17:50:57 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] cleanup the usage of SEND_SIG_xxx constants
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies some checks for magic siginfo values.
It should not change the behaviour in any way.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc1/include/linux/sched.h~2_CLEAN	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc1/include/linux/sched.h	2005-09-18 19:14:09.000000000 +0400
@@ -1015,6 +1015,11 @@ extern int do_sigaltstack(const stack_t 
 #define SEND_SIG_PRIV	((struct siginfo *) 1)
 #define SEND_SIG_FORCED	((struct siginfo *) 2)
 
+static inline int is_si_special(const struct siginfo *info)
+{
+	return info <= SEND_SIG_FORCED;
+}
+
 /* True if we are on the alternate signal stack.  */
 
 static inline int on_sig_stack(unsigned long sp)
--- 2.6.14-rc1/kernel/signal.c~2_CLEAN	2005-09-18 18:36:23.000000000 +0400
+++ 2.6.14-rc1/kernel/signal.c	2005-09-18 19:12:35.000000000 +0400
@@ -661,9 +661,7 @@ static int check_kill_permission(int sig
 	if (!valid_signal(sig))
 		return error;
 	error = -EPERM;
-	if ((info == SEND_SIG_NOINFO ||
-			(info != SEND_SIG_PRIV && info != SEND_SIG_FORCED
-				&& SI_FROMUSER(info)))
+	if ((info == SEND_SIG_NOINFO || (!is_si_special(info) && SI_FROMUSER(info)))
 	    && ((sig != SIGCONT) ||
 		(current->signal->session != t->signal->session))
 	    && (current->euid ^ t->suid) && (current->euid ^ t->uid)
@@ -812,7 +810,7 @@ static int send_signal(int sig, struct s
 	   pass on the info struct.  */
 
 	q = __sigqueue_alloc(t, GFP_ATOMIC, (sig < SIGRTMIN &&
-					     (info < SEND_SIG_FORCED ||
+					     (is_si_special(info) ||
 					      info->si_code >= 0)));
 	if (q) {
 		list_add_tail(&q->list, &signals->list);
@@ -835,16 +833,14 @@ static int send_signal(int sig, struct s
 			copy_siginfo(&q->info, info);
 			break;
 		}
-	} else {
-		if (sig >= SIGRTMIN
-		   && info != SEND_SIG_NOINFO && info != SEND_SIG_PRIV
-		   && info->si_code != SI_USER)
+	} else if (!is_si_special(info)) {
+		if (sig >= SIGRTMIN && info->si_code != SI_USER)
 		/*
 		 * Queue overflow, abort.  We may abort if the signal was rt
 		 * and sent by user using something other than kill().
 		 */
 			return -EAGAIN;
-		if ((info > SEND_SIG_PRIV) && (info->si_code == SI_TIMER))
+		if (info->si_code == SI_TIMER)
 			/*
 			 * Set up a return to indicate that we dropped 
 			 * the signal.
@@ -870,7 +866,7 @@ specific_send_sig_info(int sig, struct s
 		BUG();
 	assert_spin_locked(&t->sighand->siglock);
 
-	if ((info > SEND_SIG_FORCED) && (info->si_code == SI_TIMER))
+	if (!is_si_special(info) && (info->si_code == SI_TIMER))
 		/*
 		 * Set up a return to indicate that we dropped the signal.
 		 */
@@ -1065,7 +1061,7 @@ __group_send_sig_info(int sig, struct si
 	assert_spin_locked(&p->sighand->siglock);
 	handle_stop_signal(sig, p);
 
-	if ((info > SEND_SIG_FORCED) && (info->si_code == SI_TIMER))
+	if (!is_si_special(info) && (info->si_code == SI_TIMER))
 		/*
 		 * Set up a return to indicate that we dropped the signal.
 		 */
--- 2.6.14-rc1/security/selinux/hooks.c~2_CLEAN	2005-09-18 17:55:07.000000000 +0400
+++ 2.6.14-rc1/security/selinux/hooks.c	2005-09-18 19:24:47.000000000 +0400
@@ -2688,8 +2688,7 @@ static int selinux_task_kill(struct task
 	if (rc)
 		return rc;
 
-	if (info != SEND_SIG_NOINFO && (info == SEND_SIG_PRIV ||
-					info == SEND_SIG_FORCED || SI_FROMKERNEL(info)))
+	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
 		return 0;
 
 	if (!sig)
