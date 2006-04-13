Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWDMJBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWDMJBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDMJBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:01:37 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:16520 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751218AbWDMJBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:01:36 -0400
Date: Thu, 13 Apr 2006 16:58:32 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] coredump: kill ptrace related stuff
Message-ID: <20060413125832.GA247@oleg>
References: <20060410133511.GA85@oleg> <20060411012109.4DB3A1809D1@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411012109.4DB3A1809D1@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Roland McGrath wrote:
>
> > It turns out I misread SIGNAL_GROUP_EXIT check in ptrace_stop(),
> > didn't notice '(->parent->signal != current->signal) ||' before
> > it.
> 
> I thought that might have been it.
> 
> > Do you see any solution which doesn't need tasklist_lock to be
> > held while traversing global process list?
> 
> Eh, kind of, but I'm not sure I want to get into it.  This only comes up in
> a pathological case and we don't actually take the lock unless the weird
> case really happened.  My inclination is to get the rest of the cleanups
> and optimizations ironed out and merged in first.  Then we can revisit this
> oddball case later on.

The main optimization is avoiding tasklist_lock. But we can't reintroduce
'if (p->ptrace && p->parent->mm == mm)' check without tasklist_lock.

Roland, could you please look at the patch below and ack/nack it ?
This patch is soooooooo ugly, but:

	It is very simple.

	It (as I hope) fixes all coredump vs ptrace problems, those
	which current code has and those which were added by me.

	It allows us to avoid tasklist_lock.

	Since the locking in ptrace_attch() likely to be changed soon,
	it is unclear to me what could be done as "right thing" now.

Oleg.

--- MM/include/linux/sched.h~1_PTFIX	2006-04-13 16:06:19.000000000 +0400
+++ MM/include/linux/sched.h	2006-04-13 16:06:32.000000000 +0400
@@ -466,6 +466,7 @@ struct signal_struct {
 #define SIGNAL_STOP_DEQUEUED	0x00000002 /* stop signal dequeued */
 #define SIGNAL_STOP_CONTINUED	0x00000004 /* SIGCONT since WCONTINUED reap */
 #define SIGNAL_GROUP_EXIT	0x00000008 /* group exit in progress */
+#define SIGNAL_GROUP_COREDUMP	0x00000010 /* coredump in progress */
 
 
 /*
--- MM/fs/exec.c~1_PTFIX	2006-04-09 03:52:03.000000000 +0400
+++ MM/fs/exec.c	2006-04-13 16:16:27.000000000 +0400
@@ -1384,7 +1384,7 @@ static void zap_process(struct task_stru
 {
 	struct task_struct *t;
 
-	start->signal->flags = SIGNAL_GROUP_EXIT;
+	start->signal->flags = SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP;
 	start->signal->group_stop_count = 0;
 
 	t = start;
--- MM/kernel/signal.c~1_PTFIX	2006-03-25 20:18:38.000000000 +0300
+++ MM/kernel/signal.c	2006-04-13 16:40:49.000000000 +0400
@@ -1545,6 +1545,34 @@ static void do_notify_parent_cldstop(str
  * If we actually decide not to stop at all because the tracer is gone,
  * we leave nostop_code in current->exit_code.
  */
+static inline int may_ptrace_stop(void)
+{
+	if (!likely(current->ptrace & PT_PTRACED))
+		return 0;
+
+	if (unlikely(current->parent == current->real_parent &&
+		    (current->ptrace & PT_ATTACHED)))
+		return 0;
+
+	// Copied from ptrace_stop(), seems to be unneeded
+
+	if ((unlikely(current->parent->signal == current->signal) &&
+	     unlikely(current->signal->flags & SIGNAL_GROUP_EXIT)))
+		return 0;
+
+	// ... Fat comment is needed here ...
+
+	// This check '->flags & SIGNAL_GROUP_COREDUMP' is racy.
+	// But if this flag was set after spin_unlock(->siglock)
+	// zap_process() will wake up this task anyway.
+
+	if ((unlikely(current->parent->mm == current->mm) &&
+	     unlikely(current->signal->flags & SIGNAL_GROUP_COREDUMP)))
+		return 0;
+
+	return 1;
+}
+
 static void ptrace_stop(int exit_code, int nostop_code, siginfo_t *info)
 {
 	/*
@@ -1561,11 +1589,7 @@ static void ptrace_stop(int exit_code, i
 	set_current_state(TASK_TRACED);
 	spin_unlock_irq(&current->sighand->siglock);
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

