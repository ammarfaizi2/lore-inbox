Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWBISY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWBISY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWBISYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:24:35 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:41133 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965242AbWBISYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:24:33 -0500
Message-ID: <43EB9AFE.1B77DF51@tv-sign.ru>
Date: Thu, 09 Feb 2006 22:41:50 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] do_sigaction: cleanup ->sa_mask manipulation
References: <43EA33B3.4D67CA97@tv-sign.ru> <43EA3611.3F4BC29D@tv-sign.ru> <Pine.LNX.4.64.0602080907460.2458@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clear unblockable signals beforehand.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/include/linux/sched.h~SAKILL	2006-02-07 01:40:51.000000000 +0300
+++ RC-1/include/linux/sched.h	2006-02-10 00:15:19.000000000 +0300
@@ -1097,7 +1097,7 @@ extern struct sigqueue *sigqueue_alloc(v
 extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(int, struct sigqueue *,  struct task_struct *);
 extern int send_group_sigqueue(int, struct sigqueue *,  struct task_struct *);
-extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
+extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
 
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
--- RC-1/kernel/signal.c~SAKILL	2006-02-09 23:17:54.000000000 +0300
+++ RC-1/kernel/signal.c	2006-02-10 00:17:43.000000000 +0300
@@ -2430,7 +2430,7 @@ sys_rt_sigqueueinfo(int pid, int sig, si
 }
 
 int
-do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact)
+do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 {
 	struct k_sigaction *k;
 	sigset_t mask;
@@ -2454,6 +2454,8 @@ do_sigaction(int sig, const struct k_sig
 		*oact = *k;
 
 	if (act) {
+		sigdelsetmask(&act->sa.sa_mask,
+			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		/*
 		 * POSIX 3.3.1.3:
 		 *  "Setting a signal action to SIG_IGN for a signal that is
@@ -2479,8 +2481,6 @@ do_sigaction(int sig, const struct k_sig
 			read_lock(&tasklist_lock);
 			spin_lock_irq(&t->sighand->siglock);
 			*k = *act;
-			sigdelsetmask(&k->sa.sa_mask,
-				      sigmask(SIGKILL) | sigmask(SIGSTOP));
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
 			rm_from_queue_full(&mask, &t->signal->shared_pending);
@@ -2495,8 +2495,6 @@ do_sigaction(int sig, const struct k_sig
 		}
 
 		*k = *act;
-		sigdelsetmask(&k->sa.sa_mask,
-			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 	}
 
 	spin_unlock_irq(&current->sighand->siglock);
