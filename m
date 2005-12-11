Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVLKQH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVLKQH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 11:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVLKQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 11:07:28 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:10222 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750721AbVLKQH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 11:07:26 -0500
Message-ID: <439C605F.BA7C1D5B@tv-sign.ru>
Date: Sun, 11 Dec 2005 20:22:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
Cc: orenl@cs.columbia.edu, roland@redhat.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [PATCH ? 2/2] setpgid: should work for sub-threads
References: <200512110523.jBB5NVEr002551@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setpgid(0, pgid) or setpgid(forked_child_pid, pgid) does not work
unless the calling process is a thread_group_leader().

'man setpgid' does not tell anything about that, so I consider
this behaviour is a bug.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc5/kernel/sys.c~	2005-12-11 22:40:33.000000000 +0300
+++ 2.6.15-rc5/kernel/sys.c	2005-12-11 22:50:39.000000000 +0300
@@ -1083,10 +1083,11 @@ asmlinkage long sys_times(struct tms __u
 asmlinkage long sys_setpgid(pid_t pid, pid_t pgid)
 {
 	struct task_struct *p;
+	struct task_struct *group_leader = current->group_leader;
 	int err = -EINVAL;
 
 	if (!pid)
-		pid = current->pid;
+		pid = group_leader->pid;
 	if (!pgid)
 		pgid = pid;
 	if (pgid < 0)
@@ -1106,16 +1107,16 @@ asmlinkage long sys_setpgid(pid_t pid, p
 	if (!thread_group_leader(p))
 		goto out;
 
-	if (p->real_parent == current) {
+	if (p->real_parent == group_leader) {
 		err = -EPERM;
-		if (p->signal->session != current->signal->session)
+		if (p->signal->session != group_leader->signal->session)
 			goto out;
 		err = -EACCES;
 		if (p->did_exec)
 			goto out;
 	} else {
 		err = -ESRCH;
-		if (p != current)
+		if (p != group_leader)
 			goto out;
 	}
 
@@ -1127,7 +1128,7 @@ asmlinkage long sys_setpgid(pid_t pid, p
 		struct task_struct *p;
 
 		do_each_task_pid(pgid, PIDTYPE_PGID, p) {
-			if (p->signal->session == current->signal->session)
+			if (p->signal->session == group_leader->signal->session)
 				goto ok_pgid;
 		} while_each_task_pid(pgid, PIDTYPE_PGID, p);
 		goto out;
