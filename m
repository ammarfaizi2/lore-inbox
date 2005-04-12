Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262992AbVDLVWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbVDLVWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVDLVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:20:25 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:13726 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262992AbVDLVQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:16:04 -0400
Date: Tue, 12 Apr 2005 23:16:01 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Bodo Eggert <7eggert@gmx.de>, Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
Subject: Re: [RFC][PATCH] Simple privacy enhancement for /proc/<pid>
Message-ID: <20050412211601.GA7433@lsrfire.ath.cx>
References: <20050410153855.GA24905@lsrfire.ath.cx> <1113283776.2325.167.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113283776.2325.167.camel@cube>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 01:29:35AM -0400, Albert Cahalan wrote:
> If you really can't allow access based on tty, then at least allow
> access if any UID value matches any UID value. Without this, a user
> can not always see a setuid program they are running.

Yes, that's a bug.  Below is a new version of the patch that keeps
setuid'd processes visible to any user.

> This means mucking with boot parameters, which can be a pain.
> The various boot loaders do not all use the same config file.

True, kernel parameters not as comfortable to use as sysctl's or mount
options.  You only have to set it once, however.

> > Then I suppose we don't need to be able to fine-tune the permissions for
> > each file in /proc/<pid>/.  All that we need is a distinction between
> > "normal" users (which are to be restricted) and admins (which need to
> > see everything).
> 
> The /proc/*/maps file sure is different from the /proc/*/status file.
> The same for all the others, really.

The contents and purposes are different, but the intent of my patch is
to protect all information about the processes of one user from all
others.  If you need to access that information you have at least three
options: a) don't enable proc.privacy, b) put the users who need the
info into the proc.gid group, c) chmod a+r /proc/$pid/$file.  (Note:
that last option is a feature of the vanilla kernel.)

> > This patch introduces two kernel parameters: proc.privacy and proc.gid.
> > The group ID attribute of all files below /proc/<pid> is set to
> > proc.gid, but only if you activate the feature by setting proc.privacy
> > to a non-zero value.
> 
> This is very bad. Please do not change the GID as seen by
> the stat() call. This value is used.

What is it used for?  E.g. using the group ID of /proc/<pid>/stat to
determine the egid that process is running as is not reliable even
without my patch.  It's better to use the group ID of the directory
/proc/<pid>/ instead or to look up the ID in /proc/<pid>/status.  And
the permissions of the <pid> directories are not changed by the patch.

Thanks,
Rene


diff -pur l1/Documentation/kernel-parameters.txt l2/Documentation/kernel-parameters.txt
--- l1/Documentation/kernel-parameters.txt	2005-04-07 23:18:36.000000000 +0200
+++ l2/Documentation/kernel-parameters.txt	2005-04-10 16:56:58.000000000 +0200
@@ -1116,16 +1116,27 @@ running once the system is up.
 			[ISAPNP] Exclude memory regions for the autoconfiguration
 			Ranges are in pairs (memory base and size).
 
+	processor.max_cstate=   [HW, ACPI]
+			Limit processor to maximum C-state
+			max_cstate=9 overrides any DMI blacklist limit.
+
+	proc.gid=	[KNL] Group ID attribute of the files in /proc/<pid>,
+			default is 0.  This parameter is ignored if
+			proc.privacy is 0.
+	proc.privacy=	[KNL] Take away permissions for files in /proc/<pid>
+			from world (think "chmod o-rwx") and apply proc.gid
+			setting.  0 = disabled (default), 1 = restrict access
+			to all process details except those having a uid of 0,
+			2 = restrict access to all process details except for
+			kernel threads and init and its children, 3 = restrict
+			access to all process details.
+
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			{ schedule | <number> }
 			(param: schedule - profile schedule points}
 			(param: profile step/bucket size as a power of 2 for
 				statistical time based profiling)
 
-	processor.max_cstate=   [HW, ACPI]
-			Limit processor to maximum C-state
-			max_cstate=9 overrides any DMI blacklist limit.
-
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
 			See Documentation/ramdisk.txt.
diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-04-07 23:18:47.000000000 +0200
+++ l2/fs/proc/base.c	2005-04-12 21:26:13.000000000 +0200
@@ -35,8 +35,18 @@
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include "internal.h"
 
+static int proc_privacy;
+module_param_named(privacy, proc_privacy, uint, 0);
+MODULE_PARM_DESC(umask, "restrict permissions of files in /proc/<pid>");
+
+static gid_t proc_gid;
+module_param_named(gid, proc_gid, uint, 0);
+MODULE_PARM_DESC(gid, "process admin group");
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -227,6 +237,8 @@ static struct pid_entry tid_attr_stuff[]
 
 #undef E
 
+#define IS_PID_DIR(type) ((type) == PROC_TGID_INO || (type) == PROC_TID_INO)
+
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct task_struct *task = proc_task(inode);
@@ -1145,7 +1157,7 @@ static struct inode *proc_pid_make_inode
 	ei->type = ino;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_TGID_INO || ino == PROC_TID_INO || task_dumpable(task)) {
+	if (IS_PID_DIR(ino) || task_dumpable(task)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
@@ -1175,13 +1187,20 @@ static int pid_revalidate(struct dentry 
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = proc_task(inode);
 	if (pid_alive(task)) {
-		if (proc_type(inode) == PROC_TGID_INO || proc_type(inode) == PROC_TID_INO || task_dumpable(task)) {
+		if (IS_PID_DIR(proc_type(inode)) || task_dumpable(task)) {
 			inode->i_uid = task->euid;
 			inode->i_gid = task->egid;
 		} else {
 			inode->i_uid = 0;
 			inode->i_gid = 0;
 		}
+		if (proc_privacy && !IS_PID_DIR(proc_type(inode))) {
+			inode->i_gid = proc_gid;
+			if (proc_privacy == 2 || inode->i_uid != 0)
+				inode->i_mode &= ~S_IRWXO;
+			else
+				inode->i_mode |= (inode->i_mode & S_IRWXG) >> 3;
+		}
 		security_task_to_inode(task, inode);
 		return 1;
 	}
@@ -1454,6 +1473,11 @@ static struct dentry *proc_pident_lookup
 
 	ei = PROC_I(inode);
 	inode->i_mode = p->mode;
+	if (proc_privacy && !IS_PID_DIR(p->type)) {
+		inode->i_gid = proc_gid;
+		if (proc_privacy == 2 || inode->i_uid != 0)
+			inode->i_mode &= ~S_IRWXO;
+	}
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
