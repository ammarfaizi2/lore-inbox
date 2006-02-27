Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWB0WpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWB0WpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWB0WbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:22 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9857 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932344AbWB0WbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:09 -0500
Message-Id: <20060227223346.243149000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Oleg Nesterov <oleg@tv-sign.ru>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/39] [PATCH] do_sigaction: cleanup ->sa_mask manipulation
Content-Disposition: inline; filename=do_sigaction-cleanup-sa_mask-manipulation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Clear unblockable signals beforehand.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 include/linux/sched.h |    2 +-
 kernel/signal.c       |    8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.15.4.orig/include/linux/sched.h
+++ linux-2.6.15.4/include/linux/sched.h
@@ -1075,7 +1075,7 @@ extern struct sigqueue *sigqueue_alloc(v
 extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(int, struct sigqueue *,  struct task_struct *);
 extern int send_group_sigqueue(int, struct sigqueue *,  struct task_struct *);
-extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
+extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
 
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
--- linux-2.6.15.4.orig/kernel/signal.c
+++ linux-2.6.15.4/kernel/signal.c
@@ -2335,7 +2335,7 @@ sys_rt_sigqueueinfo(int pid, int sig, si
 }
 
 int
-do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact)
+do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 {
 	struct k_sigaction *k;
 
@@ -2358,6 +2358,8 @@ do_sigaction(int sig, const struct k_sig
 		*oact = *k;
 
 	if (act) {
+		sigdelsetmask(&act->sa.sa_mask,
+			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		/*
 		 * POSIX 3.3.1.3:
 		 *  "Setting a signal action to SIG_IGN for a signal that is
@@ -2383,8 +2385,6 @@ do_sigaction(int sig, const struct k_sig
 			read_lock(&tasklist_lock);
 			spin_lock_irq(&t->sighand->siglock);
 			*k = *act;
-			sigdelsetmask(&k->sa.sa_mask,
-				      sigmask(SIGKILL) | sigmask(SIGSTOP));
 			rm_from_queue(sigmask(sig), &t->signal->shared_pending);
 			do {
 				rm_from_queue(sigmask(sig), &t->pending);
@@ -2397,8 +2397,6 @@ do_sigaction(int sig, const struct k_sig
 		}
 
 		*k = *act;
-		sigdelsetmask(&k->sa.sa_mask,
-			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 	}
 
 	spin_unlock_irq(&current->sighand->siglock);

--
