Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277162AbRJDHxg>; Thu, 4 Oct 2001 03:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277164AbRJDHx2>; Thu, 4 Oct 2001 03:53:28 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:32269 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S277162AbRJDHxQ>; Thu, 4 Oct 2001 03:53:16 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org
cc: pmenage@ensim.com
Subject: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 00:52:58 -0700
Message-Id: <E15p3JS-0000ko-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've recently run across a problem where a server (in this case, sshd) 
can deadlock itself if a SIGCHLD arrives just before it calls select(), 
but after it has checked whether its child_terminated. So when the 
select() is called, the SIGCHLD signal handler has already run and set 
the child_terminated flag, and there's nothing to wake the select().

The only real user-space solution to this is to have the SIGCHLD handler
somehow cause the select() to return immediately by e.g. writing a byte
to a looped pipe which is included in the select() readfd set, but this
seems a little contrived. This patch simply adds a proc_base_poll()
method to make /proc/<pid> pollable, with the following semantics:

- /proc/<your_pid>/ returns POLLHUP if you have any unreaped zombie
children.

- /proc/<your_child_pid>/ returns POLLHUP if the specified child is a
zombie or has been reaped.

- Any other /proc/<pid>/ directory returns POLLNVAL, as we've no way to
do a proper poll() on it - only a parent's wait_chldexit wait queue is
awakened when a process exits, so other processes won't get any kind of
notification.

So by including /proc/self in the readset for select(), you can 
guarantee that select()/poll() will return if you've just received (and 
handled) a SIGCHLD, but not yet reaped the child. 

Alternatively, you could block SIGCHLD and just use select() for both
your child notifications and your I/O notifications. In this case, it
becomes a very specialised case of the sigopen() that Dan Kegel
proposed, but is minimally intrusive (consisting of just a single method
added to proc_base_operations).

If do_notify_parent() were changed to wake up tsk->wait_chldexit as well
as its parent's wait_chldexit, then sensible semantics could be added
for polling on any /proc/<pid>/ dir - just do a pollwait() on the target
process' exit_childwait queue. Provided that the target task is properly
refcounted (which should occur naturally due to the existence of the 
/proc/<pid>/ inode), this should be safe. Would anyone have objections
to (or enthusiasm for) such a patch?

Paul


--- linux.orig/fs/proc/base.c	Fri Jul 20 12:39:56 2001
+++ linux/fs/proc/base.c	Thu Oct  4 00:19:45 2001
@@ -23,6 +23,8 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/string.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -643,6 +645,44 @@
 	return 1;
 }
 
+static unsigned int proc_base_poll(struct file *file, poll_table *wait)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	struct task_struct *task = inode->u.proc_i.task;
+
+	int mask = 0;
+
+	poll_wait(file, &current->wait_chldexit, wait);
+	
+	if(task == current) {
+		
+		/* Check for any zombie children */
+		struct task_struct *p;
+
+		read_lock(&tasklist_lock);
+		do {
+			for (p = task->p_cptr ; p ; p = p->p_osptr) {
+				if(p->state == TASK_ZOMBIE) {
+					mask = POLLERR;
+					break;
+				}
+			}
+			task = next_thread(task);
+
+		} while(task != current && !mask);
+		read_unlock(&tasklist_lock);
+
+	} else if (task->p_pptr == current) {
+		/* Check for specific zombie child */
+		if(task->state == TASK_ZOMBIE) 
+			mask = POLLERR;
+	} else {
+		mask = POLLNVAL;
+	}
+
+	return mask;
+}
+
 /* building an inode */
 
 static int task_dumpable(struct task_struct *task)
@@ -914,6 +954,7 @@
 static struct file_operations proc_base_operations = {
 	read:		generic_read_dir,
 	readdir:	proc_base_readdir,
+	poll :          proc_base_poll,
 };
 
 static struct inode_operations proc_base_inode_operations = {

