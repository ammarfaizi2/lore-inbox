Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWBAS01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWBAS01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWBAS01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:26:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:61359 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1422814AbWBAS0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:26:25 -0500
Message-ID: <43E10F5D.54A0B990@tv-sign.ru>
Date: Wed, 01 Feb 2006 22:43:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH rc1-mm] simplify exec from init's subthread
References: <200601312208.k0VM8hT4002399@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ On top of "exec: allow init to exec from any thread.",
  filename exec-allow-init-to-exec-from-any-thread.patch ]

I think it is enough to take tasklist_lock for reading while
changing child_reaper:

	Reparenting needs write_lock(tasklist_lock)

	Only one thread in a thread group can do exec()

	sighand->siglock garantees that get_signal_to_deliver()
	will not see a stale value of child_reaper.

This means that we can change child_reaper earlier, without
calling zap_other_threads() twice.

"child_reaper = current" is a NOOP when init does exec from
main thread, we don't care.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/fs/exec.c~	2006-02-01 23:38:20.000000000 +0300
+++ RC-1/fs/exec.c	2006-02-02 00:39:40.000000000 +0300
@@ -616,6 +616,15 @@ static int de_thread(struct task_struct 
 		kmem_cache_free(sighand_cachep, newsighand);
 		return -EAGAIN;
 	}
+
+	/*
+	 * child_reaper ignores SIGKILL, change it now.
+	 * Reparenting needs write_lock on tasklist_lock,
+	 * so it is safe to do it under read_lock.
+	 */
+	if (unlikely(current->group_leader == child_reaper))
+		child_reaper = current;
+
 	zap_other_threads(current);
 	read_unlock(&tasklist_lock);
 
@@ -660,23 +669,12 @@ static int de_thread(struct task_struct 
 		struct dentry *proc_dentry1, *proc_dentry2;
 		unsigned long ptrace;
 
-		leader = current->group_leader;
-		/*
-		 * If our leader is the child_reaper become
-		 * the child_reaper and resend SIGKILL signal.
-		 */
-		if (unlikely(leader == child_reaper)) {
-			write_lock(&tasklist_lock);
-			child_reaper = current;
-			zap_other_threads(current);
-			write_unlock(&tasklist_lock);
-		}
-
 		/*
 		 * Wait for the thread group leader to be a zombie.
 		 * It should already be zombie at this point, most
 		 * of the time.
 		 */
+		leader = current->group_leader;
 		while (leader->exit_state != EXIT_ZOMBIE)
 			yield();
