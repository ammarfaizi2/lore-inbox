Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbULHGA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbULHGA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbULHGA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:00:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:40877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbULHGAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:00:33 -0500
Date: Tue, 7 Dec 2004 22:00:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in proc_pid_stat() on task->real_parent?
Message-Id: <20041207220016.6917ee6f.akpm@osdl.org>
In-Reply-To: <1102467332.19465.197.camel@localhost>
References: <1102467332.19465.197.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave@sr71.net> wrote:
>
> I got this OOPS while running a relatively intensive PostgreSQL load on
>  my dual-CPU PIII with 2.6.9, while simultaneously running top.  Sorry,
>  no serial console, but I do have a screenshot:
> 
>  	http://sprucegoose.sr71.net/~dave/oops/dsc02631.jpg
> 
>  $ addr2line -e vmlinux-2.6.9 c017920e

yup, we fixed that one.


From: Manfred Spraul <manfred@colorfullife.com>

proc_pid_status dereferences pointers in the task structure even if the
task is already dead.  This is probably the reason for the oops described
in

http://bugme.osdl.org/show_bug.cgi?id=3812

The attached patch removes the pointer dereferences by using pid_alive()
for testing that the task structure contents is still valid before
dereferencing them.  The task structure itself is guaranteed to be valid -
we hold a reference count.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/proc/array.c       |    4 ++--
 25-akpm/fs/proc/base.c        |    5 -----
 25-akpm/include/linux/sched.h |   13 +++++++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff -puN fs/proc/array.c~use-pid_alive-in-proc_pid_status fs/proc/array.c
--- 25/fs/proc/array.c~use-pid_alive-in-proc_pid_status	2004-12-02 23:31:57.000000000 -0800
+++ 25-akpm/fs/proc/array.c	2004-12-02 23:31:57.000000000 -0800
@@ -171,8 +171,8 @@ static inline char * task_state(struct t
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	p->tgid,
-		p->pid, p->pid ? p->group_leader->real_parent->tgid : 0,
-		p->pid && p->ptrace ? p->parent->pid : 0,
+		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
+		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);
diff -puN fs/proc/base.c~use-pid_alive-in-proc_pid_status fs/proc/base.c
--- 25/fs/proc/base.c~use-pid_alive-in-proc_pid_status	2004-12-02 23:31:57.000000000 -0800
+++ 25-akpm/fs/proc/base.c	2004-12-02 23:31:57.000000000 -0800
@@ -780,11 +780,6 @@ static struct inode_operations proc_pid_
 	.follow_link	= proc_pid_follow_link
 };
 
-static inline int pid_alive(struct task_struct *p)
-{
-	return p->pids[PIDTYPE_PID].nr != 0;
-}
-
 #define NUMBUF 10
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
diff -puN include/linux/sched.h~use-pid_alive-in-proc_pid_status include/linux/sched.h
--- 25/include/linux/sched.h~use-pid_alive-in-proc_pid_status	2004-12-02 23:31:57.000000000 -0800
+++ 25-akpm/include/linux/sched.h	2004-12-02 23:31:57.000000000 -0800
@@ -671,6 +671,19 @@ static inline pid_t process_group(struct
 	return tsk->signal->pgrp;
 }
 
+/**
+ * pid_alive - check that a task structure is not stale
+ * @p: Task structure to be checked.
+ *
+ * Test if a process is not yet dead (at most zombie state)
+ * If pid_alive fails, then pointers within the task structure
+ * can be stale and must not be dereferenced.
+ */
+static inline int pid_alive(struct task_struct *p)
+{
+	return p->pids[PIDTYPE_PID].nr != 0;
+}
+
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
_

