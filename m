Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWGXR6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWGXR6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWGXR6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:58:08 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:17057
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932254AbWGXR6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:58:07 -0400
Message-ID: <44C50A2B.3040203@lsrfire.ath.cx>
Date: Mon, 24 Jul 2006 19:58:03 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>,
       Bodo Eggert <7eggert@gmx.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [RFC][PATCH] procfs: add privacy options
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roughly a year ago I sent out a few patches intended to give normal
users a bit of privacy in their parts the /proc filesystem.  The first
incarnations were described as rootkits, later ones met a bit less
resistance. :-D  Then I got distracted; the patches never went anywhere.
Now that Wolfgang Draxinger asked about something like it, I think it's
time to revive the thing.

So I dusted off the last version and ported it to 2.6.18-rc2.  It's
inspired by the Openwall kernel option CONFIG_HARDEN_PROC.  The patch
introduces two kernel boot options, proc.privacy and proc.gid.  They
can be used to restrict visibility of process details for regular users.

Setting proc.privacy to 2 let's users only enter their own /proc/<pid>
directories, while a setting of 1 allows them to enter root's process
dirs, too.  In this way tools like pstree keep working, because all
parents of a user process up to init (e.g. sshd, getty, init itself)
keep being visible.  It's a rough heuristic, but I think it makes sense:
root can alway see you, and in turn you can see root.  If root is shy he
can set proc.privacy=2; the price is that his users get slightly strange
results from pstools etc.

proc.gid is the GID of the group that has read and execute access to
all /proc/<pid> dirs, regardless what the file mode and group ownership
says.  Unlike in Openwall and in my previous attempts I implemented it
as a .permission function this time.  That means owner and group
attributes of /proc/<pid> dirs are not changed; tools like top and ps
can still gather euid and egid that way.

Normally .permission functions are not the way to implement access
control in procfs, because the condition on which to grant/deny access
could change between open and actual access (think setuid).  This is of
no concern in the case of this patch, because the it unconditionally
grants some access to the members of one group, independent from /proc
data or meta-data.

I briefly tested the patch on a Fedora Core 6 test1 system on top of
a vanilla 2.6.18-rc2 kernel and it seems to work as described here: it
boots, it restricts, and if I'm in the right group I see every process
in ps' output again.

Questions, suggestions or even flames are very much welcome.  Did I
manage to do something stupid in these few lines of code?

Andrew, are you (still) interested in test-driving the patch in -mm?

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e11f772..c4de276 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1284,6 +1284,16 @@ running once the system is up.
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
+	proc.gid=	[KNL] ID of the group that is allowed to read and
+			enter all /proc/<pid> directories, regardless of the
+			proc.privacy setting (i.e., the process admin group).
+			Default is 0.
+	proc.privacy=	[KNL] Restrict access to the /proc/<pid> directories
+			to their respective owners ("chmod 500").
+			0 = disabled (default), 1 = restrict access to all
+			process dirs except those owned by root (uid 0),
+			2 = restrict access to all process dirs.
+
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index fe8d55f..f20e73d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -71,8 +71,18 @@ #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include "internal.h"
 
+static int proc_privacy;
+module_param_named(privacy, proc_privacy, uint, 0);
+MODULE_PARM_DESC(umask, "restrict permissions of /proc/<pid> directories");
+
+static gid_t proc_gid;
+module_param_named(gid, proc_gid, uint, 0);
+MODULE_PARM_DESC(gid, "process admin group");
+
 /* NOTE:
  *	Implementing inode permission operations in /proc is almost
  *	certainly an error.  Permission checks need to happen during
@@ -81,7 +91,19 @@ #include "internal.h"
  *
  *	The classic example of a problem is opening file descriptors
  *	in /proc for a task before it execs a suid executable.
+ *
+ *	proc_tgid_base_permission() is the exception to this rule.  It is
+ *	OK because its additional check doesn't depend on anything that
+ *	can change: it unconditionally gives read and execute permissions
+ *	to the members of a certain group.
  */
+static int proc_tgid_base_permission(struct inode *inode, int mask,
+                                     struct nameidata *nd)
+{
+	if (((mask & (MAY_READ|MAY_EXEC)) == mask) && in_group_p(proc_gid))
+		return 0;
+	return generic_permission(inode, mask, NULL);
+}
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -1292,6 +1314,16 @@ static int task_dumpable(struct task_str
 }
 
 
+static umode_t proc_privacy_pid_mode(uid_t uid)
+{
+	if (proc_privacy == 1 && uid == 0)
+		return S_IFDIR|S_IRUGO|S_IXUGO;
+	else
+		return S_IFDIR|S_IRUSR|S_IXUSR;
+}
+
+static struct inode_operations proc_tgid_base_privacy_inode_operations;
+
 static struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task, int ino)
 {
 	struct inode * inode;
@@ -1322,6 +1354,8 @@ static struct inode *proc_pid_make_inode
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
+	if (inode->i_op == &proc_tgid_base_privacy_inode_operations)
+		inode->i_mode = proc_privacy_pid_mode(inode->i_uid);
 	security_task_to_inode(task, inode);
 
 out:
@@ -1362,6 +1396,8 @@ static int pid_revalidate(struct dentry 
 			inode->i_uid = 0;
 			inode->i_gid = 0;
 		}
+		if (inode->i_op == &proc_tgid_base_privacy_inode_operations)
+			inode->i_mode = proc_privacy_pid_mode(inode->i_uid);
 		inode->i_mode &= ~(S_ISUID | S_ISGID);
 		security_task_to_inode(task, inode);
 		put_task_struct(task);
@@ -1387,6 +1423,8 @@ static int pid_getattr(struct vfsmount *
 			stat->uid = task->euid;
 			stat->gid = task->egid;
 		}
+		if (inode->i_op == &proc_tgid_base_privacy_inode_operations)
+			stat->mode = proc_privacy_pid_mode(stat->uid);
 	}
 	rcu_read_unlock();
 	return 0;
@@ -1875,6 +1913,13 @@ static struct inode_operations proc_tgid
 	.setattr	= proc_setattr,
 };
 
+static struct inode_operations proc_tgid_base_privacy_inode_operations = {
+	.lookup		= proc_tgid_base_lookup,
+	.getattr	= pid_getattr,
+	.setattr	= proc_setattr,
+	.permission	= proc_tgid_base_permission,
+};
+
 static struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
 	.getattr	= pid_getattr,
@@ -2063,6 +2108,10 @@ struct dentry *proc_pid_lookup(struct in
 
 	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tgid_base_inode_operations;
+	if (proc_privacy) {
+		inode->i_mode = proc_privacy_pid_mode(inode->i_uid);
+		inode->i_op = &proc_tgid_base_privacy_inode_operations;
+	}
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
 #ifdef CONFIG_SECURITY
