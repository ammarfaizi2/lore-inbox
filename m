Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVCOTAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVCOTAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCOTAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:00:40 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:10948 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261752AbVCOS4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:56:24 -0500
Subject: [patch 1/1] comments on locking of task->comm
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 12 Mar 2005 19:08:18 +0100
Message-Id: <20050312180818.54B3097666@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add some comments about task->comm, to explain what it is near its definition
and provide some important pointers to its uses.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/exec.c             |    4 +++-
 linux-2.6.11-paolo/include/linux/sched.h |    7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff -puN include/linux/sched.h~locking-use-commentary include/linux/sched.h
--- linux-2.6.11/include/linux/sched.h~locking-use-commentary	2005-03-12 19:06:25.000000000 +0100
+++ linux-2.6.11-paolo/include/linux/sched.h	2005-03-12 19:06:25.000000000 +0100
@@ -532,7 +532,7 @@ struct task_struct {
 	unsigned long flags;	/* per process flags, defined below */
 	unsigned long ptrace;
 
-	int lock_depth;		/* Lock depth */
+	int lock_depth;		/* BKL lock depth */
 
 	int prio, static_prio;
 	struct list_head run_list;
@@ -615,7 +615,10 @@ struct task_struct {
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
 	int oomkilladj; /* OOM kill score adjustment (bit shift). */
-	char comm[TASK_COMM_LEN];
+	char comm[TASK_COMM_LEN]; /* executable name excluding path
+				     - access with [gs]et_task_comm (which lock
+				       it with task_lock())
+				     - initialized normally by flush_old_exec */
 /* file system info */
 	int link_count, total_link_count;
 /* ipc stuff */
diff -puN fs/exec.c~locking-use-commentary fs/exec.c
--- linux-2.6.11/fs/exec.c~locking-use-commentary	2005-03-12 19:06:25.000000000 +0100
+++ linux-2.6.11-paolo/fs/exec.c	2005-03-12 19:06:25.000000000 +0100
@@ -867,9 +867,11 @@ int flush_old_exec(struct linux_binprm *
 	if (current->euid == current->uid && current->egid == current->gid)
 		current->mm->dumpable = 1;
 	name = bprm->filename;
+
+	/* Copies the binary name from after last slash */
 	for (i=0; (ch = *(name++)) != '\0';) {
 		if (ch == '/')
-			i = 0;
+			i = 0; /* overwrite what we wrote */
 		else
 			if (i < (sizeof(tcomm) - 1))
 				tcomm[i++] = ch;
_
