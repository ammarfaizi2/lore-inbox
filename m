Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUGAO2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUGAO2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUGAO13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:27:29 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:35478 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S265530AbUGAO0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:26:50 -0400
Date: Thu, 1 Jul 2004 16:26:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
Message-ID: <20040701142633.GE15086@dualathlon.random>
References: <Pine.LNX.4.58.0406302250120.11212@ppc970.osdl.org> <200407010706.i6176pTa019793@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407010706.i6176pTa019793@magilla.sf.frob.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:06:51AM -0700, Roland McGrath wrote:
> When did you wake up the tracer?  I don't see how that happened.  If the
> tracer is blocked in a wait4 call and still has other live children, it
> stays blocked.  Next time it wakes up for some other reason, it can poll

the wait4 in strace needing to see the "stolen child" in its ->children
list is the only good reason for deferring the release_task of the
otherwise self-reaping tasks, until the killing of strace itself. You
ignored my patch completely in your reply, so it wasn't clear to me if
something was wrong with it in terms of stracing and so I asked what's
the point of the "deferring", now it's clear.

The thing I figured out was that the deferring of the release_task for
self-reaping clones (the one I incidentally tried to remove ;) is what
generates the buggy code since things goes a bit complex there and we
need to make them even a bit more complex with your fix to preserve the
feature (I now agree it is really a feature).

I think I understood this code now, thanks a lot for the help.

What about this? (fixes both testcases for me)

--- sles/kernel/exit.c.~1~	2004-06-30 01:41:58.000000000 +0200
+++ sles/kernel/exit.c	2004-07-01 16:19:13.207742224 +0200
@@ -596,7 +596,8 @@ static inline void reparent_thread(task_
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
-static inline void forget_original_parent(struct task_struct * father)
+static inline void forget_original_parent(struct task_struct * father,
+					  struct list_head *to_release)
 {
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p, *_n;
@@ -614,16 +615,34 @@ static inline void forget_original_paren
 	 * Search them and reparent children.
 	 */
 	list_for_each_safe(_p, _n, &father->children) {
+		int ptrace;
 		p = list_entry(_p,struct task_struct,sibling);
+
+		ptrace = p->ptrace;
+
+		/* if father isn't the real parent, then ptrace must be enabled */
+		BUG_ON(father != p->real_parent && !ptrace);
+
 		if (father == p->real_parent) {
+			/* reparent with a reaper, real father it's us */
 			choose_new_parent(p, reaper, child_reaper);
 			reparent_thread(p, father, 0);
 		} else {
-			ptrace_unlink (p);
+			/* reparent ptraced task to its real parent */
+			__ptrace_unlink (p);
 			if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
 			    thread_group_empty(p))
 				do_notify_parent(p, p->exit_signal);
 		}
+
+		/*
+		 * if the ptraced child is a zombie with exit_signal == -1
+		 * we must collect it before we exit, or it will remain
+		 * zombie forever since we prevented it from self-reap itself
+		 * while it was being traced by us, to be able to see it in wait4.
+		 */
+		if (unlikely(ptrace && p->state == TASK_ZOMBIE && p->exit_signal == -1))
+			list_add(&p->ptrace_list, to_release);
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
@@ -640,6 +659,7 @@ static void exit_notify(struct task_stru
 {
 	int state;
 	struct task_struct *t;
+	struct list_head ptrace_dead, *_p, *_n;
 
 	ckrm_cb_exit(tsk);
 
@@ -677,8 +697,10 @@ static void exit_notify(struct task_stru
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	forget_original_parent(tsk);
+	INIT_LIST_HEAD(&ptrace_dead);
+	forget_original_parent(tsk, &ptrace_dead);
 	BUG_ON(!list_empty(&tsk->children));
+	BUG_ON(!list_empty(&tsk->ptrace_children));
 
 	/*
 	 * Check to see if any process groups have become orphaned
@@ -763,6 +785,12 @@ static void exit_notify(struct task_stru
 	_raw_write_unlock(&tasklist_lock);
 	local_irq_enable();
 
+	list_for_each_safe(_p, _n, &ptrace_dead) {
+		list_del_init(_p);
+		t = list_entry(_p,struct task_struct,ptrace_list);
+		release_task(t);
+	}
+
 	/* If the process is dead, release it - nobody will wait for it */
 	if (state == TASK_DEAD)
 		release_task(tsk);
