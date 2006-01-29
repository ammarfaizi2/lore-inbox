Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWA2Gby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWA2Gby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWA2Gby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:31:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33246 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750850AbWA2Gbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:31:53 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] pid: Don't hash pid 0.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:31:26 -0700
Message-ID: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pid 0 is never exported to userspace, so hashing it servers no useful
purpose.

Explicitly not hashing pid 0 allows struct pid to be marked as not
hashed, and it allows us to avoid checks if for pid 0 when searching
for processes to signal if pid 0 does not have a special meaning.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/pid.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

da30e3ccb4b506b79fe0e6439addbfc763e92e24
diff --git a/kernel/pid.c b/kernel/pid.c
index d2247dc..7890867 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -148,6 +148,9 @@ int fastcall attach_pid(task_t *task, en
 {
 	struct pid *pid, *task_pid;
 
+	if (!nr)
+		goto out;
+
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
 	task_pid->nr = nr;
@@ -159,7 +162,7 @@ int fastcall attach_pid(task_t *task, en
 		INIT_HLIST_NODE(&task_pid->pid_chain);
 		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
 	}
-
+ out:
 	return 0;
 }
 
@@ -169,6 +172,9 @@ static fastcall int __detach_pid(task_t 
 	int nr = 0;
 
 	pid = &task->pids[type];
+	if (!pid->nr)
+		goto out;
+
 	if (!hlist_unhashed(&pid->pid_chain)) {
 
 		if (list_empty(&pid->pid_list)) {
@@ -185,7 +191,7 @@ static fastcall int __detach_pid(task_t 
 
 	list_del_rcu(&pid->pid_list);
 	pid->nr = 0;
-
+ out:
 	return nr;
 }
 
-- 
1.1.5.g3480

