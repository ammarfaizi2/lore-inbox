Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVCPCjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVCPCjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 21:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVCPCjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 21:39:52 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:9631 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262476AbVCPCje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 21:39:34 -0500
Date: Wed, 16 Mar 2005 03:39:23 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Subject: Re: [PATCH][RFC] /proc umask and gid [was: Make /proc/<pid> chmod'able]
Message-ID: <20050316023923.GA27736@lsrfire.ath.cx>
References: <1110771251.1967.84.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110771251.1967.84.camel@cube>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I gather from the feedback I've got that chmod'able /proc/<pid>
would be a bit over the top. 8-)  While providing the easiest and most
intuitive user interface for changing the permissions on those
directories, it is overkill.  Paul is right when he says that such a
feature should be turned on or off for all sessions at once, and that's
it.

My patch had at least one other problem: the contents of eac
/proc/<pid> directory became chmod'able, too, which was not intended.

Instead of fixing it up I took two steps back, dusted off the umask
kernel parameter patch and added the "special gid" feature I mentioned.

Without the new kernel parameters behaviour is unchanged.  Add
proc.umask=077 and all /proc/<pid> will get a permission mode of 500.
This breaks pstree (no output), as Bodo already noted, because this
program needs access to /proc/1.  It also breaks w -- it shows the
correct number of users but it lists XXXXX even for sessions owned
by the user running it.

Use proc.umask=007 and proc.gid=50 instead and all /proc/<pid> dirs
will have a mode of 550 and their group attribute will be set to 50
(that's "staff" on my Debian system).  Pstree will work for all members
of that special group (just like top, ps and w -- which also show
everything in that case).  Normal users will still have a restricted
view.

Albert, would you take fixes for w even though you despise the feature
that makes them necessary?

Is this less scary?  Still useful?

Thanks,
Rene



diff -urp linux-2.6.11-mm3/Documentation/kernel-parameters.txt l5/Documentation/kernel-parameters.txt
--- linux-2.6.11-mm3/Documentation/kernel-parameters.txt	2005-03-12 19:23:30.000000000 +0100
+++ l5/Documentation/kernel-parameters.txt	2005-03-16 01:14:05.000000000 +0100
@@ -1095,16 +1095,22 @@ running once the system is up.
 			[ISAPNP] Exclude memory regions for the autoconfiguration
 			Ranges are in pairs (memory base and size).
 
+	processor.max_cstate=   [HW, ACPI]
+			Limit processor to maximum C-state
+			max_cstate=9 overrides any DMI blacklist limit.
+
+	proc.gid=	[KNL] If non-zero all /proc/<pid> directories will
+			have their group attribute set to that value.
+
+	proc.umask=	[KNL] Restrict permissions of process specific
+			entries in /proc (i.e. the numerical directories).
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
diff -urp linux-2.6.11-mm3/fs/proc/base.c l5/fs/proc/base.c
--- linux-2.6.11-mm3/fs/proc/base.c	2005-03-12 19:23:36.000000000 +0100
+++ l5/fs/proc/base.c	2005-03-16 01:54:52.000000000 +0100
@@ -35,8 +35,18 @@
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include "internal.h"
 
+static umode_t proc_umask;
+module_param_named(umask, proc_umask, ushort, 0);
+MODULE_PARM_DESC(umask, "umask for all /proc/<pid> entries");
+
+static gid_t proc_gid;
+module_param_named(gid, proc_gid, uint, 0);
+MODULE_PARM_DESC(gid, "group attribute of all /proc/<pid> entries");
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -1149,6 +1159,8 @@ static struct inode *proc_pid_make_inode
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
+	if ((ino == PROC_TGID_INO || ino == PROC_TID_INO) && proc_gid)
+		inode->i_gid = proc_gid;
 	security_task_to_inode(task, inode);
 
 out:
@@ -1182,6 +1194,8 @@ static int pid_revalidate(struct dentry 
 			inode->i_uid = 0;
 			inode->i_gid = 0;
 		}
+		if ((proc_type(inode) == PROC_TGID_INO || proc_type(inode) == PROC_TID_INO) && proc_gid)
+			inode->i_gid = proc_gid;
 		security_task_to_inode(task, inode);
 		return 1;
 	}
@@ -1797,7 +1811,7 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = S_IFDIR | ((S_IRUGO|S_IXUGO) & ~proc_umask);
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
@@ -1852,7 +1866,7 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = S_IFDIR | ((S_IRUGO|S_IXUGO) & ~proc_umask);
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
