Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWCHUFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWCHUFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCHUFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:05:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49385 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932565AbWCHUFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:05:32 -0500
To: Andrew Morton <akpm@osdl.org>
CC: Oleg Nesterov <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Make setsid more robust.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Mar 2006 13:05:07 -0700
Message-ID: <m1hd68vh1o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Carefully allow init (pid == 1) to call setsid despite the kernel using
  it's session.
- Use find_task_by_pid instead of find_pid because find_pid taking a pidtype
  is going away.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

Andrew this can replaces my fork-allow-init-to-become-a-session-leader patch.

 kernel/sys.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

a051dfe3df38b6cb1cc11209f1f8274531d761e3
diff --git a/kernel/sys.c b/kernel/sys.c
index 6a8157e..5831641 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1384,18 +1384,29 @@ asmlinkage long sys_getsid(pid_t pid)
 asmlinkage long sys_setsid(void)
 {
 	struct task_struct *group_leader = current->group_leader;
-	struct pid *pid;
+	pid_t session;
 	int err = -EPERM;
 
 	mutex_lock(&tty_mutex);
 	write_lock_irq(&tasklist_lock);
 
-	pid = find_pid(PIDTYPE_PGID, group_leader->pid);
-	if (pid)
+	/* Fail if I am already a session leader */
+	if (group_leader->signal->leader)
+		goto out;
+	
+	session = group_leader->pid;
+	/* Fail if a process group id already exists that equals the
+	 * proposed session id.  
+	 *
+	 * Don't check if session id == 1 because kernel threads use this
+	 * session id and so the check will always fail and make it so
+	 * init cannot successfully call setsid.
+	 */
+	if (session > 1 && find_task_by_pid_type(PIDTYPE_PGID, session))
 		goto out;
 
 	group_leader->signal->leader = 1;
-	__set_special_pids(group_leader->pid, group_leader->pid);
+	__set_special_pids(session, session);
 	group_leader->signal->tty = NULL;
 	group_leader->signal->tty_old_pgrp = 0;
 	err = process_group(group_leader);
-- 
1.2.2.g709a-dirty

