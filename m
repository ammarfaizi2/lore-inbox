Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWG0O1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWG0O1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWG0O1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:27:41 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:57736
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932347AbWG0O1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:27:39 -0400
Date: Thu, 27 Jul 2006 16:27:37 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>,
       Bodo Eggert <7eggert@gmx.de>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][PATCH] procfs: add privacy options
Message-ID: <20060727142737.GA30561@lsrfire.ath.cx>
References: <44C50A2B.3040203@lsrfire.ath.cx> <m18xmiogp3.fsf@ebiederm.dsl.xmission.com> <44C547B0.1090304@lsrfire.ath.cx> <1153806307.8932.9.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1153806307.8932.9.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I had used a bouncing address for Al Viro, hopefully this one is
correct.]

On Tue, Jul 25, 2006 at 07:45:06AM +0200, Arjan van de Ven wrote:
> > You mean using ptrace_may_attach() and/or MAY_PTRACE() for determining
> > access to all (or at least more) files in /proc/<pid> instead of my
> > proposed "chmod 500"?  What are the advantages?

> file permissions are simple, but too simplistic to express a full "am I
> allowed to see that guy" rules as general principle. Just think of
> SELinux or any other kind of role based access control mechanism where
> "root is not full root". But it goes beyond that really; applications
> that drop their ptrace capability because they KNOW they won't use it
> and by dropping the capability deny an exploit that takes over from
> using it. There's just too many such cases that file permissions don't
> capture where ptrace is a more detailed description of the permission
> check you want (idea being that if you can ptrace someone you own them).
> It's good general principle to at least try to not duplicate such
> permission checks; history shows that those will be gotten incorrect.

OK, makes sense.  What do y'all think about the following attempt?

It is configurable via mount options; it should work even if someone
has opened a proc file before the admin changed the option, because the
permissions are checked at every read.

There are two pairs of options: privacy/noprivacy and gid=n/nogid.  The
first one can be used to prevent all users from looking into /proc/<pid>
files for processes hat they arent't allowed to ptrace.  The second one
can be used to lift this restriction from one user group.

I'm not sure whether the llseek checks are really needed.  Is the file
length really worth protecting?

I'm also not sure if "gid" is a good option name.  There once was a
procfs option that did something else.  Is it OK to recycle the name?
Would "pgid" be better?  Or "nonprivacygid"?

For the loginuid and oom_adjust files I made sure that those users
who are allowed to write (err, not forbidden to write) are allowed
to read them, too, regardless of the result of ptrace_may_attach().

Unlike my previous patch this one has only two modes: on and off.  If
privacy is on, pstree stops working for normal users.  This could be
worked around with a "soft" privacy mode again by taking any privacy
away from root-owned processes, if needed.

I tested the patch lightly by booting Fedora Core 6 test1 and turning
the options on and off while watching top.  One thing I noticed is
that the normal boot process doesn't seem to pick up mount options
from /etc/fstab for /proc.

The patch doesn't change any permission bits, that behaviour might be
confusing.  On the other hand, I already _am_ confused by symlinks
that I can't get the target for (cwd, root, exe) ;-).  Is this worth
fixing?

Doing the permission checks also at open seems like a good idea, too.

Am I on the right track?
René


diff --git a/fs/proc/base.c b/fs/proc/base.c
index fe8d55f..cdf5743 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -572,6 +572,42 @@ static struct inode_operations proc_def_
 	.setattr	= proc_setattr,
 };
 
+#define PROC_PRIVACY (proc_config.privacy && \
+	!(proc_config.usegid && in_group_p(proc_config.gid)))
+
+ssize_t proc_seq_read(struct file *file, char __user *buf, size_t size,
+                      loff_t *ppos)
+{
+	if (PROC_PRIVACY) {
+		struct inode * inode = file->f_dentry->d_inode;
+		struct task_struct *task = get_proc_task(inode);
+
+		if (task && !ptrace_may_attach(task)) {
+			put_task_struct(task);
+			return -EPERM;
+		}
+		put_task_struct(task);
+	}
+
+	return seq_read(file, buf, size, ppos);
+}
+
+loff_t proc_seq_lseek(struct file *file, loff_t offset, int origin)
+{
+	if (PROC_PRIVACY) {
+		struct inode * inode = file->f_dentry->d_inode;
+		struct task_struct *task = get_proc_task(inode);
+
+		if (task && !ptrace_may_attach(task)) {
+			put_task_struct(task);
+			return -EPERM;
+		}
+		put_task_struct(task);
+	}
+
+	return seq_lseek(file, offset, origin);
+}
+
 extern struct seq_operations mounts_op;
 struct proc_mounts {
 	struct seq_file m;
@@ -640,8 +676,8 @@ static unsigned mounts_poll(struct file 
 
 static struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= proc_seq_read,
+	.llseek		= proc_seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
 };
@@ -677,8 +713,8 @@ static int mountstats_open(struct inode 
 
 static struct file_operations proc_mountstats_operations = {
 	.open		= mountstats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= proc_seq_read,
+	.llseek		= proc_seq_lseek,
 	.release	= mounts_release,
 };
 
@@ -696,6 +732,12 @@ static ssize_t proc_info_read(struct fil
 	if (!task)
 		goto out_no_task;
 
+	if (PROC_PRIVACY) {
+		length = -EPERM;
+		if (!ptrace_may_attach(task))
+			goto out;
+	}
+
 	if (count > PROC_BLOCK_SIZE)
 		count = PROC_BLOCK_SIZE;
 
@@ -865,6 +907,11 @@ static struct file_operations proc_mem_o
 	.open		= mem_open,
 };
 
+static int oom_adjust_may_write(void)
+{
+	return capable(CAP_SYS_RESOURCE);
+}
+
 static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -876,6 +923,14 @@ static ssize_t oom_adjust_read(struct fi
 
 	if (!task)
 		return -ESRCH;
+
+	if (PROC_PRIVACY) {
+		if (!oom_adjust_may_write() && !ptrace_may_attach(task)) {
+			put_task_struct(task);
+			return -EPERM;
+		}
+	}
+
 	oom_adjust = task->oomkilladj;
 	put_task_struct(task);
 
@@ -897,7 +952,7 @@ static ssize_t oom_adjust_write(struct f
 	char buffer[PROC_NUMBUF], *end;
 	int oom_adjust;
 
-	if (!capable(CAP_SYS_RESOURCE))
+	if (!oom_adjust_may_write())
 		return -EPERM;
 	memset(buffer, 0, sizeof(buffer));
 	if (count > sizeof(buffer) - 1)
@@ -926,6 +981,12 @@ static struct file_operations proc_oom_a
 
 #ifdef CONFIG_AUDITSYSCALL
 #define TMPBUFLEN 21
+static int proc_loginuid_may_write(struct inode *inode)
+{
+	return capable(CAP_AUDIT_CONTROL) &&
+	       (current == pid_task(proc_pid(inode), PIDTYPE_PID));
+}
+
 static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
 				  size_t count, loff_t *ppos)
 {
@@ -936,6 +997,15 @@ static ssize_t proc_loginuid_read(struct
 
 	if (!task)
 		return -ESRCH;
+
+	if (PROC_PRIVACY) {
+		if (!proc_loginuid_may_write(inode) &&
+		    !ptrace_may_attach(task)) {
+			put_task_struct(task);
+			return -EPERM;
+		}
+	}
+
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
 				audit_get_loginuid(task->audit_context));
 	put_task_struct(task);
@@ -950,10 +1020,7 @@ static ssize_t proc_loginuid_write(struc
 	ssize_t length;
 	uid_t loginuid;
 
-	if (!capable(CAP_AUDIT_CONTROL))
-		return -EPERM;
-
-	if (current != pid_task(proc_pid(inode), PIDTYPE_PID))
+	if (!proc_loginuid_may_write(inode))
 		return -EPERM;
 
 	if (count >= PAGE_SIZE)
@@ -1574,6 +1641,12 @@ static ssize_t proc_pid_attr_read(struct
 	if (!task)
 		goto out_no_task;
 
+	if (PROC_PRIVACY) {
+		length = -EPERM;
+		if (!ptrace_may_attach(task))
+			goto out;
+	}
+
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 	length = -ENOMEM;
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 49dfb2a..251b730 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -15,6 +15,8 @@ #include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/parser.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -126,9 +128,70 @@ int __init proc_init_inodecache(void)
 	return 0;
 }
 
+struct proc_config proc_config = {
+	.privacy = 0,
+	.usegid = 0,
+};
+
+enum {
+	Opt_privacy, Opt_noprivacy, Opt_gid, Opt_nogid,
+	Opt_err
+};
+
+static match_table_t tokens = {
+	{Opt_privacy, "privacy"},
+	{Opt_noprivacy, "noprivacy"},
+	{Opt_gid, "gid=%u"},
+	{Opt_nogid, "nogid"},
+	{Opt_err, NULL}
+};
+
 static int proc_remount(struct super_block *sb, int *flags, char *data)
 {
+	char *p;
+
 	*flags |= MS_NODIRATIME;
+
+	while ((p = strsep(&data, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token, option;
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_privacy:
+			proc_config.privacy = 1;
+			break;
+		case Opt_noprivacy:
+			proc_config.privacy = 0;
+			break;
+		case Opt_gid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			proc_config.gid = option;
+			proc_config.usegid = 1;
+			break;
+		case Opt_nogid:
+			proc_config.usegid = 0;
+			break;
+		default:
+			printk(KERN_ERR "proc: bogus mount options\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int proc_show_options(struct seq_file *s, struct vfsmount *m)
+{
+	if (proc_config.privacy)
+		seq_puts(s, ",privacy");
+	if (proc_config.usegid)
+		seq_printf(s, ",gid=%u", proc_config.gid);
+
 	return 0;
 }
 
@@ -140,6 +203,7 @@ static struct super_operations proc_sops
 	.delete_inode	= proc_delete_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= proc_remount,
+	.show_options	= proc_show_options,
 };
 
 struct inode *proc_get_inode(struct super_block *sb, unsigned int ino,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0a163a4..9693193 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -441,8 +441,8 @@ static int maps_open(struct inode *inode
 
 struct file_operations proc_maps_operations = {
 	.open		= maps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= proc_seq_read,
+	.llseek		= proc_seq_lseek,
 	.release	= seq_release_private,
 };
 
@@ -463,8 +463,8 @@ static int numa_maps_open(struct inode *
 
 struct file_operations proc_numa_maps_operations = {
 	.open		= numa_maps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= proc_seq_read,
+	.llseek		= proc_seq_lseek,
 	.release	= seq_release_private,
 };
 #endif
@@ -476,7 +476,7 @@ static int smaps_open(struct inode *inod
 
 struct file_operations proc_smaps_operations = {
 	.open		= smaps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= proc_seq_read,
+	.llseek		= proc_seq_lseek,
 	.release	= seq_release_private,
 };
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 17e7578..48d45f5 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -200,6 +200,18 @@ static inline void proc_net_remove(const
 	remove_proc_entry(name,proc_net);
 }
 
+struct proc_config {
+	int privacy;
+	int usegid;
+	gid_t gid;
+};
+
+extern struct proc_config proc_config;
+
+extern ssize_t proc_seq_read(struct file *file, char __user *buf, size_t size,
+                             loff_t *ppos);
+extern loff_t proc_seq_lseek(struct file *file, loff_t offset, int origin);
+
 #else
 
 #define proc_root_driver NULL
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 1a649f2..f78057d 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -2446,6 +2446,7 @@ void __cpuset_memory_pressure_bump(void)
 	task_unlock(current);
 }
 
+#ifdef CONFIG_PROC
 /*
  * proc_cpuset_show()
  *  - Print tasks cpuset path into seq_file.
@@ -2500,10 +2501,11 @@ static int cpuset_open(struct inode *ino
 
 struct file_operations proc_cpuset_operations = {
 	.open		= cpuset_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
+	.read		= proc_seq_read,
+	.llseek		= proc_seq_lseek,
 	.release	= single_release,
 };
+#endif /* CONFIG_PROC */
 
 /* Display task cpus_allowed, mems_allowed in /proc/<pid>/status file. */
 char *cpuset_task_status_allowed(struct task_struct *task, char *buffer)
