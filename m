Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSIERE1>; Thu, 5 Sep 2002 13:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSIERE0>; Thu, 5 Sep 2002 13:04:26 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:4104 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317887AbSIERES>; Thu, 5 Sep 2002 13:04:18 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Daniel Jacobowitz <dan@debian.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
References: <Pine.LNX.4.44.0209051728490.18985-100000@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 06 Sep 2002 02:08:13 +0900
In-Reply-To: <Pine.LNX.4.44.0209051728490.18985-100000@localhost.localdomain>
Message-ID: <874rd4cqki.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> Linus,
> 
> the attached patch (against BK-curr) collects two ptrace related fixes:  
> first it undoes Ogawa's change (so various uses of ptrace works again),
> plus it adds Daniel's suggested fix that allows a parent to PTRACE_ATTACH
> to a child it forked. (this also fixes the incorrect BUG_ON() assert
> Ogawa's patch was intended to fix in the first place.)
> 
> i've tested various ptrace uses and they appear to work just fine.
> 
> (Daniel, let us know if you can still see anything questionable in this
> area - or if the ptrace list could be managed in a cleaner way.)

I think I found some bugs.

in forget_original_parent()

	/*
	 * There are only two places where our children can be:
	 *
	 * - in our child list
	 * - in the global ptrace list
	 *
	 * Search them and reparent children.
	 */
	list_for_each(_p, &father->children) {
		p = list_entry(_p,struct task_struct,sibling);
		reparent_thread(p, reaper, child_reaper);
	}

Looks like that tracer change the real parent.


in exit_notify()

	list_for_each_safe(_p, _n, &current->ptrace_children)
		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current);

Looks like that real parent deprive a process from tracer.


in sys_wait4()

+				} else {
+					if (p->ptrace) {
+						write_lock_irq(&tasklist_lock);
+						ptrace_unlink(p);
+						write_unlock_irq(&tasklist_lock);
+					}
 					release_task(p);
+				}

Umm, why needed this? If ->real_parent == ->parent, it's real
child. So this child don't use ->ptrace_list.


			break;
		tsk = next_thread(tsk);
	} while (tsk != current);
	read_unlock(&tasklist_lock);
	if (flag || !list_empty(&current->ptrace_children)) {

Until now, this case wasn't blocked. However, I like this behavior.


If these are right, can you look the following patch? I think this patch 
fixes problems.

===== kernel/exit.c 1.43 vs edited =====
--- 1.43/kernel/exit.c	Mon Sep  2 00:54:47 2002
+++ edited/kernel/exit.c	Fri Sep  6 01:58:52 2002
@@ -403,10 +403,10 @@
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
-static inline void forget_original_parent(struct task_struct * father)
+static inline void forget_real_parent(struct task_struct * father)
 {
 	struct task_struct *p, *reaper;
-	list_t *_p;
+	list_t *_p, *_n;
 
 	read_lock(&tasklist_lock);
 
@@ -425,17 +425,24 @@
 	 * There are only two places where our children can be:
 	 *
 	 * - in our child list
-	 * - in the global ptrace list
+	 * - in the ptraced child list
 	 *
 	 * Search them and reparent children.
 	 */
 	list_for_each(_p, &father->children) {
 		p = list_entry(_p,struct task_struct,sibling);
-		reparent_thread(p, reaper, child_reaper);
+		if (p->real_parent == father)
+			reparent_thread(p, reaper, child_reaper);
 	}
-	list_for_each(_p, &father->ptrace_children) {
+	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
+		list_del_init(&p->ptrace_list);
 		reparent_thread(p, reaper, child_reaper);
+
+		/* This is needed for thread group reparent */
+		if (p->real_parent != child_reaper &&
+		    p->real_parent != p->parent)
+			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
 	}
 	read_unlock(&tasklist_lock);
 }
@@ -443,9 +450,8 @@
 static inline void zap_thread(task_t *p, task_t *father)
 {
 	ptrace_unlink(p);
-	list_del_init(&p->sibling);
-	p->ptrace = 0;
 
+	list_del_init(&p->sibling);
 	p->parent = p->real_parent;
 	list_add_tail(&p->sibling, &p->parent->children);
 	if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
@@ -478,7 +484,7 @@
 	struct task_struct *t;
 	list_t *_p, *_n;
 
-	forget_original_parent(current);
+	forget_real_parent(current);
 	/*
 	 * Check to see if any process groups have become orphaned
 	 * as a result of our exiting, and if they have any stopped
@@ -539,15 +545,13 @@
 zap_again:
 	list_for_each_safe(_p, _n, &current->children)
 		zap_thread(list_entry(_p,struct task_struct,sibling), current);
-	list_for_each_safe(_p, _n, &current->ptrace_children)
-		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current);
+
 	/*
 	 * reparent_thread might drop the tasklist lock, thus we could
 	 * have new children queued back from the ptrace list into the
 	 * child list:
 	 */
-	if (unlikely(!list_empty(&current->children) ||
-			!list_empty(&current->ptrace_children)))
+	if (unlikely(!list_empty(&current->children)))
 		goto zap_again;
 	/*
 	 * No need to unlock IRQs, we'll schedule() immediately
@@ -598,8 +602,10 @@
 	tsk->exit_code = code;
 	exit_notify();
 	preempt_disable();
-	if (current->exit_signal == -1)
+	if (current->exit_signal == -1) {
+		ptrace_unlink(current);
 		release_task(current);
+	}
 	schedule();
 	BUG();
 /*
===== kernel/ptrace.c 1.16 vs edited =====
--- 1.16/kernel/ptrace.c	Tue Aug 20 03:12:27 2002
+++ edited/kernel/ptrace.c	Wed Sep  4 03:00:53 2002
@@ -26,11 +26,12 @@
  */
 void __ptrace_link(task_t *child, task_t *new_parent)
 {
-	if (!list_empty(&child->ptrace_list))
-		BUG();
+	BUG_ON(!list_empty(&child->ptrace_list));
+	BUG_ON(child->parent != child->real_parent);
+
 	if (child->parent == new_parent)
-		BUG();
-	list_add(&child->ptrace_list, &child->parent->ptrace_children);
+		return;
+	list_add(&child->ptrace_list, &child->real_parent->ptrace_children);
 	REMOVE_LINKS(child);
 	child->parent = new_parent;
 	SET_LINKS(child);
@@ -44,10 +45,10 @@
  */
 void __ptrace_unlink(task_t *child)
 {
-	if (!child->ptrace)
-		BUG();
+	BUG_ON(!child->ptrace);
+
 	child->ptrace = 0;
-	if (list_empty(&child->ptrace_list))
+	if (child->parent == child->real_parent)
 		return;
 	list_del_init(&child->ptrace_list);
 	REMOVE_LINKS(child);
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
