Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSLBHYA>; Mon, 2 Dec 2002 02:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLBHX7>; Mon, 2 Dec 2002 02:23:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33681 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265570AbSLBHWc>;
	Mon, 2 Dec 2002 02:22:32 -0500
Date: Mon, 2 Dec 2002 09:48:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] getppid-2.5.50-A3
Message-ID: <Pine.LNX.4.44.0212020928150.11803-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) changes sys_getppid() to be more
POSIX-threading conform.

sys_getppid() needs to return the PID of the "process' parent" (ie. the
tgid of the parent thread), not the thread parent's PID. The patch has no
effect on non-CLONE_THREAD users, for them current->group_leader ==
current. The effect on CLONE_THREAD threads is that getppid() does not
return any PID within the thread group anymore. Plus if a threaded
application starts up a (non-thread) child then the child sees the process
PID of the parent process, not the thread PID of the parent thread.

in theory we could introduce the getttid() variant to get to the TID of
the parent thread, but i doubt it would be of any use. (and we can add it
if the need arises.)

The lockless algorithm is still safe because the ->group_leader pointer
never changes asynchronously. (the ->real_parent pointer might still
change asynchronously so the SMP checks are still needed.)

I've also updated the comments (they referenced the nonexistent p_ooptr
field.), plus i've changed the mb() to rmb() - we need to order the reads,
we dont do any global writes that need some predictable ordering.

	Ingo

--- linux/kernel/timer.c.orig	2002-12-02 08:39:41.000000000 +0100
+++ linux/kernel/timer.c	2002-12-02 09:22:48.000000000 +0100
@@ -862,8 +862,8 @@
 }
 
 /*
- * This is not strictly SMP safe: p_opptr could change
- * from under us. However, rather than getting any lock
+ * Accessing ->group_leader->real_parent is not SMP-safe, it could
+ * change from under us. However, rather than getting any lock
  * we can use an optimistic algorithm: get the parent
  * pid, and go back and check that the parent is still
  * the same. If it has changed (which is extremely unlikely
@@ -871,33 +871,31 @@
  *
  * NOTE! This depends on the fact that even if we _do_
  * get an old value of "parent", we can happily dereference
- * the pointer: we just can't necessarily trust the result
+ * the pointer (it was and remains a dereferencable kernel pointer
+ * no matter what): we just can't necessarily trust the result
  * until we know that the parent pointer is valid.
  *
- * The "mb()" macro is a memory barrier - a synchronizing
- * event. It also makes sure that gcc doesn't optimize
- * away the necessary memory references.. The barrier doesn't
- * have to have all that strong semantics: on x86 we don't
- * really require a synchronizing instruction, for example.
- * The barrier is more important for code generation than
- * for any real memory ordering semantics (even if there is
- * a small window for a race, using the old pointer is
- * harmless for a while).
+ * NOTE2: ->group_leader never changes from under us.
  */
 asmlinkage long sys_getppid(void)
 {
 	int pid;
-	struct task_struct * me = current;
-	struct task_struct * parent;
+	struct task_struct *me = current;
+	struct task_struct *parent;
 
-	parent = me->real_parent;
+	parent = me->group_leader->real_parent;
 	for (;;) {
-		pid = parent->pid;
+		pid = parent->tgid;
 #if CONFIG_SMP
 {
 		struct task_struct *old = parent;
-		mb();
-		parent = me->real_parent;
+
+		/*
+		 * Make sure we read the pid before re-reading the
+		 * parent pointer:
+		 */
+		rmb();
+		parent = me->group_leader->real_parent;
 		if (old != parent)
 			continue;
 }

