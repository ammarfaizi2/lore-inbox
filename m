Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUK1L2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUK1L2W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUK1L2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:28:21 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:26571 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261460AbUK1L1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:27:16 -0500
Message-ID: <41A9B589.1090005@colorfullife.com>
Date: Sun, 28 Nov 2004 12:24:57 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: mingo@elte.hu, roland@redhat.com, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] use pid_alive in proc_pid_status
Content-Type: multipart/mixed;
 boundary="------------090100020503050307060507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090100020503050307060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

proc_pid_status dereferences pointers in the task structure even if the 
task is already dead. This is probably the reason for the oops described in

http://bugme.osdl.org/show_bug.cgi?id=3812

The attached patch removes the pointer dereferences by using pid_alive() 
for testing that the task structure contents is still valid before 
dereferencing them. The task structure itself is guaranteed to be valid 
- we hold a reference count.

What do you think? Are you aware of further instances where p->pid is 
still used to check if a thread is alive?

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>


--------------090100020503050307060507
Content-Type: text/plain;
 name="patch-pid-alive"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pid-alive"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 10
//  EXTRAVERSION =-rc2
--- 2.6/include/linux/pid.h	2004-10-23 09:58:17.000000000 +0200
+++ build-2.6/include/linux/pid.h	2004-11-28 12:07:55.514992845 +0100
@@ -52,4 +52,6 @@
 			hlist_unhashed(&(task)->pids[type].pid_chain));	\
 	}								\
 
+extern int pid_alive(struct task_struct *p);
+
 #endif /* _LINUX_PID_H */
--- 2.6/kernel/pid.c	2004-11-19 18:54:37.000000000 +0100
+++ build-2.6/kernel/pid.c	2004-11-28 12:09:07.464302391 +0100
@@ -247,6 +247,19 @@
 	attach_pid(leader, PIDTYPE_SID, leader->signal->session);
 }
 
+/**
+ * pid_alive - check that a task structure is not stale
+ * @p: Task structure to be checked.
+ *
+ * Test if a process is not yet dead (at most zombie state)
+ * If pid_alive fails, then pointers within the task structure
+ * can be stale and must not be dereferenced.
+ */
+int pid_alive(struct task_struct *p)
+{
+	return p->pids[PIDTYPE_PID].nr != 0;
+}
+
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
--- 2.6/fs/proc/base.c	2004-11-19 18:54:34.000000000 +0100
+++ build-2.6/fs/proc/base.c	2004-11-28 12:06:49.259448232 +0100
@@ -780,11 +780,6 @@
 	.follow_link	= proc_pid_follow_link
 };
 
-static inline int pid_alive(struct task_struct *p)
-{
-	return p->pids[PIDTYPE_PID].nr != 0;
-}
-
 #define NUMBUF 10
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
--- 2.6/fs/proc/array.c	2004-11-19 18:54:34.000000000 +0100
+++ build-2.6/fs/proc/array.c	2004-11-28 12:00:17.944726203 +0100
@@ -171,8 +171,8 @@
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

--------------090100020503050307060507--
