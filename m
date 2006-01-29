Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWA2Vku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWA2Vku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWA2Vku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:40:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47591 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751172AbWA2Vkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:40:49 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] exec:  Allow init to exec from any thread.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 14:40:19 -0700
Message-ID: <m14q3m90ho.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After looking at the problem of init calling exec some more I figured
out an easy way to make the code work.

The actual symptom without out this patch is that all threads will die
except pid == 1, and the thread calling exec.  The thread calling exec
will wait forever for pid == 1 to die. 

Since pid == 1 does not install a handler for SIGKILL it will never die.

This modifies the tests for init from current->pid == 1 to the
equivalent current == child_reaper.  And then it causes exec in the
ugly case to modify child_reaper.

The only weird symptom is that you wind up with an init process that
doesn't have the oldest start time on the box. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c       |   13 ++++++++++++-
 kernel/exit.c   |    2 +-
 kernel/signal.c |    2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

96629b6a7cc1bdb3afdd1b5190e08e3df62bfa6a
diff --git a/fs/exec.c b/fs/exec.c
index 62eca47..348e6ac 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -660,12 +660,23 @@ static int de_thread(struct task_struct 
 		struct dentry *proc_dentry1, *proc_dentry2;
 		unsigned long ptrace;
 
+		leader = current->group_leader;
+		/*
+		 * If our leader is the child_reaper become
+		 * the child_reaper and resend SIGKILL signal.
+		 */
+		if (unlikely(leader == child_reaper)) {
+			write_lock(&tasklist_lock);
+			child_reaper = current;
+			zap_other_threads(current);
+			write_unlock(&tasklist_lock);
+		}
+		
 		/*
 		 * Wait for the thread group leader to be a zombie.
 		 * It should already be zombie at this point, most
 		 * of the time.
 		 */
-		leader = current->group_leader;
 		while (leader->exit_state != EXIT_ZOMBIE)
 			yield();
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 93cee36..4059b2a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -802,7 +802,7 @@ fastcall NORET_TYPE void do_exit(long co
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
-	if (unlikely(tsk->pid == 1))
+	if (unlikely(tsk == child_reaper))
 		panic("Attempted to kill init!");
 	if (tsk->io_context)
 		exit_io_context();
diff --git a/kernel/signal.c b/kernel/signal.c
index 20a67ae..6faf362 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,7 +2019,7 @@ relock:
 			continue;
 
 		/* Init gets no signals it doesn't want.  */
-		if (current->pid == 1)
+		if (current == child_reaper)
 			continue;
 
 		if (sig_kernel_stop(signr)) {
-- 
1.1.5.g3480

