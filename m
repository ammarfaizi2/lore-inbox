Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVAVHFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVAVHFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVAVHFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 02:05:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:50830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262673AbVAVHFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 02:05:06 -0500
Date: Fri, 21 Jan 2005 23:05:04 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Brent Casavant <bcasavan@sgi.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Pollable Semaphores
Message-ID: <20050121230504.T469@build.pdx.osdl.net>
References: <20050121212212.GA453910@firefly.engr.sgi.com> <521xceqx90.fsf@topspin.com> <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com> <a36005b5050121194377026f39@mail.gmail.com> <20050121215203.S469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050121215203.S469@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Jan 21, 2005 at 09:52:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Ulrich Drepper (drepper@gmail.com) wrote:
> > And is another thing to consider.  There is at least one other event
> > which should be pollable: process (maybe threads) deaths.  I was
> > hoping that we get support for this, perhaps in the form of polling
> > the /proc/PID directory.  For poll(), a POLLERR value could mean the
> > process/thread died.  For select(), once again a  bit in the except
> > array could be set.
> 
> I have a simple patch that does just that.  It worked after brief testing,
> then I never went back to look at it any more.  I'll see if I can't dig
> it up, maybe it's useful.

Yeah, here it is.  I refreshed it against a current kernel.  It passes my
same old test, where I select on /proc/<pid>/status fd in exceptfds.

===== fs/proc/base.c 1.86 vs edited =====
--- 1.86/fs/proc/base.c	2005-01-10 17:29:31 -08:00
+++ edited/fs/proc/base.c	2005-01-21 22:51:00 -08:00
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/poll.h>
 #include "internal.h"
 
 /*
@@ -519,8 +520,21 @@ static ssize_t proc_info_read(struct fil
 	return length;
 }
 
+static unsigned int proc_info_poll(struct file *file, poll_table *wait)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	wait_queue_head_t *pid_wait = &PROC_I(task->proc_dentry->d_inode)->wait;
+
+	poll_wait(file, pid_wait, wait);
+	if (!pid_alive(task))
+		return POLLPRI;
+	return 0;
+}
+
 static struct file_operations proc_info_file_operations = {
 	.read		= proc_info_read,
+	.poll		= proc_info_poll,
 };
 
 static int mem_open(struct inode* inode, struct file* file)
@@ -1489,6 +1503,8 @@ void proc_pid_flush(struct dentry *proc_
 {
 	might_sleep();
 	if(proc_dentry != NULL) {
+		wait_queue_head_t *pid_wait=&PROC_I(proc_dentry->d_inode)->wait;
+		wake_up_interruptible(pid_wait);
 		shrink_dcache_parent(proc_dentry);
 		dput(proc_dentry);
 	}
===== fs/proc/inode.c 1.31 vs edited =====
--- 1.31/fs/proc/inode.c	2005-01-04 18:48:14 -08:00
+++ edited/fs/proc/inode.c	2005-01-21 22:48:06 -08:00
@@ -97,6 +97,7 @@ static struct inode *proc_alloc_inode(st
 	ei->type = 0;
 	ei->op.proc_get_link = NULL;
 	ei->pde = NULL;
+	init_waitqueue_head(&ei->wait);
 	inode = &ei->vfs_inode;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	return inode;
===== include/linux/proc_fs.h 1.41 vs edited =====
--- 1.41/include/linux/proc_fs.h	2005-01-07 21:44:33 -08:00
+++ edited/include/linux/proc_fs.h	2005-01-21 22:48:06 -08:00
@@ -243,6 +243,7 @@ struct proc_inode {
 		int (*proc_read)(struct task_struct *task, char *page);
 	} op;
 	struct proc_dir_entry *pde;
+	wait_queue_head_t wait;
 	struct inode vfs_inode;
 };
 
