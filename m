Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVDJPjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVDJPjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDJPjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:39:10 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:11924 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261512AbVDJPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:38:56 -0400
Date: Sun, 10 Apr 2005 17:38:55 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Bodo Eggert <7eggert@gmx.de>
Cc: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
Subject: [RFC][PATCH] Simple privacy enhancement for /proc/<pid>
Message-ID: <20050410153855.GA24905@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sorry it took me so long before offering another patch for restricting
/proc permissions.  Real life kept on intervening.

Albert, allowing access based on tty sounds nice, but it _is_ expansive.
More importantly, perhaps, it would "virtualize" /proc: every user would
see different permissions for certain files in there.  That's too comlex
for my taste.

My previous patchset was complex, too, given its simple purpose: to
restrict regular users from spying on each other.  So let's cut out what
we don't really need.

First, configuring via kernel parameters is sufficient.  It simplifies
implementation a lot because we know the settings cannot change.  And we
don't need the added flexibility of sysctls anyway -- I assume these
parameters are set at installation time and never touched again.

Then I suppose we don't need to be able to fine-tune the permissions for
each file in /proc/<pid>/.  All that we need is a distinction between
"normal" users (which are to be restricted) and admins (which need to
see everything).

In a previous mail I asked how to identify tasks every user should be
able to see details of.  Bodo came up with some nice ideas, like
checking if parent is init(1) to catch daemons and identifying kernel
threads by their unique ability to block SIGKILL.  That's simple and
catches most interesting processes; it fails to catch the children of
forking servers like apache and, notably, sshd, however.

I have another idea: let's keep the details of _every_ process owned by
user root readable by anyone.  The superuser doesn't deserve privacy.
No new hole is opened, as root's files don't change their permissions.
Admittedly, admins are people, too, and they can get privacy, too -- but
only if they use their own regular user ID.  They should be doing that
anyway.

This catches the _important_ processes, those used to provide logins
(and then some :-).  Tools like w, who and pstree keep on working just
fine, even for SSH logins.

This patch introduces two kernel parameters: proc.privacy and proc.gid.
The group ID attribute of all files below /proc/<pid> is set to
proc.gid, but only if you activate the feature by setting proc.privacy
to a non-zero value.  1 means to allow all users to see root's process
details and hide everyone else's (as described above), 2 gives you the
"shared nothing" semantics where even root's processes are "cloaked".

Patch is against 2.6.12-rc2-mm2, please give it a try and tell me how
you like it.

Thanks,
Rene



diff -pur l1/Documentation/kernel-parameters.txt l2/Documentation/kernel-parameters.txt
--- l1/Documentation/kernel-parameters.txt	2005-04-07 23:18:36.000000000 +0200
+++ l2/Documentation/kernel-parameters.txt	2005-04-10 13:52:56.000000000 +0200
@@ -1116,16 +1116,25 @@ running once the system is up.
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
+			2 = restrict access to all process details.
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
+++ l2/fs/proc/base.c	2005-04-10 14:00:28.000000000 +0200
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
@@ -1175,13 +1187,15 @@ static int pid_revalidate(struct dentry 
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
+		if (proc_privacy && !IS_PID_DIR(proc_type(inode)))
+			inode->i_gid = proc_gid;
 		security_task_to_inode(task, inode);
 		return 1;
 	}
@@ -1454,6 +1468,11 @@ static struct dentry *proc_pident_lookup
 
 	ei = PROC_I(inode);
 	inode->i_mode = p->mode;
+	if (proc_privacy && !IS_PID_DIR(p->type)) {
+		inode->i_gid = proc_gid;
+		if (proc_privacy == 2 || task->euid != 0)
+			inode->i_mode &= ~S_IRWXO;
+	}
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
