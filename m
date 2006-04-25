Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWDYTtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWDYTtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWDYTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:49:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751352AbWDYTtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:49:46 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix coredump vs exec deadlock
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 25 Apr 2006 20:49:41 +0100
Message-ID: <1919.1145994581@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a race between the coredump code and the exec dethreader that causes the
two to deadlock.

The problem is that if both events happen simultaneously (exec and death by
signal) in two different threads, both threads sit there waiting for the other
to die.

This patch makes exec inferior to death by signal, the dethreader for the
former aborting if it detects the latter.

I've also fixed a potential race in which de_thread() was doing a wait loop,
but with the setting of the task state _after_ the loop condition check.  I've
moved the task state set before the check.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/dethread.diff 
 fs/exec.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3a79d97..b66cc82 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -647,10 +647,13 @@ static int de_thread(struct task_struct 
 			hrtimer_restart(&sig->real_timer);
 		spin_lock_irq(lock);
 	}
-	while (atomic_read(&sig->count) > count) {
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&sig->count) <= count ||
+		    tsk->mm->core_startup_done)
+			break;
 		sig->group_exit_task = current;
 		sig->notify_count = count;
-		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(lock);
 		schedule();
 		spin_lock_irq(lock);
@@ -658,6 +661,13 @@ static int de_thread(struct task_struct 
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock_irq(lock);
+	__set_current_state(TASK_RUNNING);
+
+	/* exec loses out to death-by-signal in some other thread */
+	if (tsk->mm->core_startup_done) {
+		kmem_cache_free(sighand_cachep, newsighand);
+		return -EINTR;
+	}
 
 	/*
 	 * At this point all other threads have exited, all we have to
@@ -1394,6 +1404,8 @@ static void zap_threads (struct mm_struc
 	do_each_thread(g,p)
 		if (mm == p->mm && p != tsk) {
 			force_sig_specific(SIGKILL, p);
+			/* make sure de_thread() gets the message */
+			wake_up_state(p, TASK_UNINTERRUPTIBLE);
 			mm->core_waiters++;
 			if (unlikely(p->ptrace) &&
 			    unlikely(p->parent->mm == mm))
