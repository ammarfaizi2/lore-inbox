Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVBQVaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVBQVaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVBQVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:30:19 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:61611 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261185AbVBQV3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:29:02 -0500
Date: Thu, 17 Feb 2005 22:28:59 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] add umask parameter to procfs
Message-ID: <20050217212859.GA24403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proc.umask kernel parameter.  It can be used to restrict permissions
on the numerical directories in the root of a proc filesystem, i.e. the
directories containing process specific information.

E.g. add proc.umask=077 to your kernel command line and all users except
root can only see their own process details (like command line
parameters) with ps or top.  It can be useful to add a bit of privacy to
multi-user servers.

The patch has been inspired by a similar feature in GrSecurity.

It could have also been implemented as a mount option to procfs, but at
a higher cost and no apparent benefit -- changes to this umask are not
supposed to happen very often.  Actually, the previous incarnation of
this patch was implemented as a half-assed mount option, but I didn't
know then how easy it is to add a kernel parameter.

Comments about usefulness or implementation are very welcome.

Thanks,
Rene


--- linux-2.6.11-rc4/fs/proc/base.c~	2005-02-11 21:16:13.000000000 +0100
+++ linux-2.6.11-rc4/fs/proc/base.c	2005-02-11 23:38:17.000000000 +0100
@@ -32,8 +32,14 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include "internal.h"
 
+static umode_t umask = 0;
+module_param(umask, ushort, 0);
+MODULE_PARM_DESC(umask, "umask for the numerical directories in /proc");
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -1369,7 +1375,7 @@ static struct dentry *proc_pident_lookup
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
+	inode->i_mode = p->mode & ~(umask & S_IRWXUGO);
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
@@ -1699,7 +1705,7 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = S_IFDIR | ((S_IRUGO|S_IXUGO) & ~umask);
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
@@ -1754,7 +1760,7 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = S_IFDIR | ((S_IRUGO|S_IXUGO) & ~umask);
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
