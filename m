Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129711AbRBTFB6>; Tue, 20 Feb 2001 00:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbRBTFBs>; Tue, 20 Feb 2001 00:01:48 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11282 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129711AbRBTFBl>; Tue, 20 Feb 2001 00:01:41 -0500
Date: Mon, 19 Feb 2001 23:01:06 -0600
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
Message-ID: <20010219230106.A23699@cadcamlab.org>
In-Reply-To: <Pine.A41.4.31.0102192312330.174604-100000@pandora.inf.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.A41.4.31.0102192312330.174604-100000@pandora.inf.elte.hu>; from szabi@inf.elte.hu on Mon, Feb 19, 2001 at 11:18:27PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[BERECZ Szabolcs]
> Here is a new syscall. With this you can change the owner of a running
> procces.

> +       if (current->euid)
> +               return -EPERM;

Use capable().

> +       p = find_task_by_pid(pid);
> +       p->fsuid = p->euid = p->suid = p->uid = uid;

Race -- you need to make sure the task_struct doesn't disappear out
from under you.

Anyway, why not use the interface 'chown uid /proc/pid'?  No new
syscall, no arch-dependent part, no user-space tool, etc.

The following is untested and almost certainly broken (I'm a lousy
kernel hacker), but should be at least somewhat close....

Peter


--- fs/proc/base.c.orig	Thu Nov 16 22:11:22 2000
+++ fs/proc/base.c	Mon Feb 19 22:51:59 2001
@@ -873,6 +873,27 @@
 	return ERR_PTR(error);
 }
 
+static int proc_base_chown (struct dentry *dentry, struct iattr *attr)
+{
+	struct task_struct *task;
+
+	if (!capable (CAP_SETUID))
+		return -EPERM;
+
+	if (!(attr->ia_valid & ATTR_UID))
+		return -EINVAL;
+
+	read_lock (&tasklist_lock);
+	task = dentry->d_inode->u.proc_i.task;
+	if (task)
+		task->fsuid = task->euid = task->suid = task->uid = attr->ia_uid;
+	read_unlock (&tasklist_lock);
+	if (!task)
+		return -ENOENT;
+
+	return 0;
+}
+
 static struct file_operations proc_base_operations = {
 	read:		generic_read_dir,
 	readdir:	proc_base_readdir,
@@ -880,6 +901,7 @@
 
 static struct inode_operations proc_base_inode_operations = {
 	lookup:		proc_base_lookup,
+	setattr:	proc_base_chown,
 };
 
 /*
