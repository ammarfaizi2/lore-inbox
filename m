Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWBVXIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWBVXIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWBVXIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:08:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52968 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030337AbWBVXIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:08:38 -0500
Message-ID: <43FCEE43.6BA95501@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:05:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 6/6] do_sigaction: don't take tasklist_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_sigaction() does not need tasklist_lock anymore,
we can simplify the code.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/signal.c~6_DOSA	2006-02-23 01:46:17.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-23 02:16:08.000000000 +0300
@@ -2303,8 +2303,7 @@ sys_rt_sigqueueinfo(int pid, int sig, si
 	return kill_proc_info(sig, &info, pid);
 }
 
-int
-do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
+int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 {
 	struct k_sigaction *k;
 	sigset_t mask;
@@ -2330,6 +2329,7 @@ do_sigaction(int sig, struct k_sigaction
 	if (act) {
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
+		*k = *act;
 		/*
 		 * POSIX 3.3.1.3:
 		 *  "Setting a signal action to SIG_IGN for a signal that is
@@ -2342,19 +2342,8 @@ do_sigaction(int sig, struct k_sigaction
 		 *   be discarded, whether or not it is blocked"
 		 */
 		if (act->sa.sa_handler == SIG_IGN ||
-		    (act->sa.sa_handler == SIG_DFL &&
-		     sig_kernel_ignore(sig))) {
-			/*
-			 * This is a fairly rare case, so we only take the
-			 * tasklist_lock once we're sure we'll need it.
-			 * Now we must do this little unlock and relock
-			 * dance to maintain the lock hierarchy.
-			 */
+		   (act->sa.sa_handler == SIG_DFL && sig_kernel_ignore(sig))) {
 			struct task_struct *t = current;
-			spin_unlock_irq(&t->sighand->siglock);
-			read_lock(&tasklist_lock);
-			spin_lock_irq(&t->sighand->siglock);
-			*k = *act;
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
 			rm_from_queue_full(&mask, &t->signal->shared_pending);
@@ -2363,12 +2352,7 @@ do_sigaction(int sig, struct k_sigaction
 				recalc_sigpending_tsk(t);
 				t = next_thread(t);
 			} while (t != current);
-			spin_unlock_irq(&current->sighand->siglock);
-			read_unlock(&tasklist_lock);
-			return 0;
 		}
-
-		*k = *act;
 	}
 
 	spin_unlock_irq(&current->sighand->siglock);
