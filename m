Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWENOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWENOpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWENOpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:45:12 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:41418 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751238AbWENOpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:45:10 -0400
Date: Sun, 14 May 2006 22:45:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH -mm] coredump-kill-ptrace-related-stuff-fix
Message-ID: <20060514184510.GA86@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 2 bugs in
	"[PATCH 3/4] coredump: kill ptrace related stuff"
	coredump-kill-ptrace-related-stuff.patch

1. Roland McGrath pointed out that SIGNAL_GROUP_EXIT can't
   prevent the task from going to ptrace_stop() and schedule
   in TASK_TRACED state.

   As Eric W. Biederman suggested, ptrace_stop() should check
   ->core_waiters.

2. This patch killed 'if (child->ptrace)' check in ptrace_detach()
   because that check was added to protect against ptrace_detach()
   vs zap_threads() race.

   However, the check is still needed: de_thread() can release the
   task after ptrace_check_attach() succeeded.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/signal.c~1_FIX	2006-04-21 03:26:32.000000000 +0400
+++ MM/kernel/signal.c	2006-05-14 21:22:08.000000000 +0400
@@ -1531,6 +1531,35 @@ static void do_notify_parent_cldstop(str
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+static inline int may_ptrace_stop(void)
+{
+	if (!likely(current->ptrace & PT_PTRACED))
+		return 0;
+
+	if (unlikely(current->parent == current->real_parent &&
+		    (current->ptrace & PT_ATTACHED)))
+		return 0;
+
+	if (unlikely(current->signal == current->parent->signal) &&
+	    unlikely(current->signal->flags & SIGNAL_GROUP_EXIT))
+		return 0;
+
+	/*
+	 * Are we in the middle of do_coredump?
+	 * If so and our tracer is also part of the coredump stopping
+	 * is a deadlock situation, and pointless because our tracer
+	 * is dead so don't allow us to stop.
+	 * If SIGKILL was already sent before the caller unlocked
+	 * ->siglock we must see ->core_waiters != 0. Otherwise it
+	 * is safe to enter schedule().
+	 */
+	if (unlikely(current->mm->core_waiters) &&
+	    unlikely(current->mm == current->parent->mm))
+		return 0;
+
+	return 1;
+}
+
 /*
  * This must be called with current->sighand->siglock held.
  *
@@ -1559,11 +1588,7 @@ static void ptrace_stop(int exit_code, i
 	spin_unlock_irq(&current->sighand->siglock);
 	try_to_freeze();
 	read_lock(&tasklist_lock);
-	if (likely(current->ptrace & PT_PTRACED) &&
-	    likely(current->parent != current->real_parent ||
-		   !(current->ptrace & PT_ATTACHED)) &&
-	    (likely(current->parent->signal != current->signal) ||
-	     !unlikely(current->signal->flags & SIGNAL_GROUP_EXIT))) {
+	if (may_ptrace_stop()) {
 		do_notify_parent_cldstop(current, CLD_TRAPPED);
 		read_unlock(&tasklist_lock);
 		schedule();
--- MM/kernel/ptrace.c~1_FIX	2006-05-14 20:06:44.000000000 +0400
+++ MM/kernel/ptrace.c	2006-05-14 21:27:06.000000000 +0400
@@ -213,7 +213,9 @@ int ptrace_detach(struct task_struct *ch
 	ptrace_disable(child);
 
 	write_lock_irq(&tasklist_lock);
-	__ptrace_detach(child, data);
+	/* protect against de_thread()->release_task() */
+	if (child->ptrace)
+		__ptrace_detach(child, data);
 	write_unlock_irq(&tasklist_lock);
 
 	return 0;

