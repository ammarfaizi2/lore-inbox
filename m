Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCSBvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCSBvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 20:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVCSBvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 20:51:47 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:57514 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261330AbVCSBv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 20:51:26 -0500
Date: Sat, 19 Mar 2005 02:51:22 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Subject: Re: [PATCH][RFC] /proc umask and gid [was: Make /proc/<pid> chmod'able]
Message-ID: <20050319015122.GB2143@lsrfire.ath.cx>
References: <1110771251.1967.84.camel@cube> <20050316023923.GA27736@lsrfire.ath.cx> <1110948088.1967.282.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110948088.1967.282.camel@cube>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 11:41:28PM -0500, Albert Cahalan wrote:
> Better interface:
> 
> /sbin/sysctl -w proc.maps=0440
> /sbin/sysctl -w proc.cmdline=0444
> /sbin/sysctl -w proc.status=0444

Indeed it is, but it's much harder to implement.

Patch is against 2.6.11-mm3 but works with -mm4, too.  I only made the
permissions configurable for some of the files, more can be added easily
if and when needed.

It's uglier than it needs to be, but before cleaning it up I'll go and
get some sleep.

Comments and patches much appreciated! :)

Rene



diff -pur linux-2.6.11-mm3/fs/proc/base.c l5/fs/proc/base.c
--- linux-2.6.11-mm3/fs/proc/base.c	2005-03-12 19:23:36.000000000 +0100
+++ l5/fs/proc/base.c	2005-03-19 01:08:40.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
+#include <linux/sysctl.h>
 #include "internal.h"
 
 /*
@@ -1419,6 +1420,93 @@ static struct file_operations proc_tgid_
 static struct inode_operations proc_tgid_attr_inode_operations;
 #endif
 
+static struct pid_entry *proc_base_entry_by_name(struct pid_entry *ents,
+                                                 struct qstr *name)
+{
+	struct pid_entry *p;
+
+	for (p = ents; p->name; p++) {
+		if (p->len != name->len)
+			continue;
+		if (!memcmp(name->name, p->name, p->len))
+			return p;
+	}
+	return NULL;
+}
+
+#ifdef CONFIG_SYSCTL
+struct proc_sysctl_info {
+	int type;
+	mode_t mode;
+};
+
+/* order must match the CTL_PROC table in sysctl.h */
+struct proc_sysctl_info proc_base_permissions[] = {
+	{PROC_TGID_CMDLINE,	S_IRUGO},
+	{PROC_TGID_MAPS,	S_IRUGO},
+	{PROC_TGID_STAT,	S_IRUGO},
+	{PROC_TGID_STATM,	S_IRUGO},
+	{PROC_TGID_STATUS,	S_IRUGO},
+	{0, 0}
+};
+
+static inline int is_system_task(struct task_struct *task)
+{
+	int rc = 0;
+
+	if (task->pid == 1)
+		rc = 1;
+	// TODO: kernel threads?
+	return rc;
+}
+
+static void proc_update_mode(mode_t *mode, int type, struct task_struct *task)
+{
+	struct proc_sysctl_info *s;
+
+	if (is_system_task(task))
+		return;
+	for (s = proc_base_permissions; s->type; s++) {
+		if (s->type == type) {
+			*mode = (*mode & ~S_IALLUGO) | s->mode;
+			break;
+		}
+	}
+}
+
+static int proc_base_permission(struct inode *inode, int mask,
+                                struct nameidata *nd)
+{
+	struct task_struct *task = proc_task(inode);
+	struct pid_entry *p;
+
+	p = proc_base_entry_by_name(tgid_base_stuff, &nd->dentry->d_name);
+	if (p)
+		proc_update_mode(&inode->i_mode, p->type, task);
+	return generic_permission(inode, mask, NULL);
+}
+
+static int proc_base_getattr(struct vfsmount *mnt, struct dentry *dentry,
+                             struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	struct pid_entry *p;
+
+	generic_fillattr(inode, stat);
+	p = proc_base_entry_by_name(tgid_base_stuff, &dentry->d_name);
+	if (p)
+		proc_update_mode(&inode->i_mode, p->type, task);
+	return 0;
+}
+
+static struct inode_operations proc_base_inode_operations = {
+	.getattr	= proc_base_getattr,
+	.permission	= proc_base_permission,
+};
+
+#endif /* CONFIG_SYSCTL */
+
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1436,13 +1524,8 @@ static struct dentry *proc_pident_lookup
 	if (!pid_alive(task))
 		goto out;
 
-	for (p = ents; p->name; p++) {
-		if (p->len != dentry->d_name.len)
-			continue;
-		if (!memcmp(dentry->d_name.name, p->name, p->len))
-			break;
-	}
-	if (!p->name)
+	p = proc_base_entry_by_name(ents, &dentry->d_name);
+	if (p == NULL)
 		goto out;
 
 	error = -EINVAL;
@@ -1452,6 +1535,10 @@ static struct dentry *proc_pident_lookup
 
 	ei = PROC_I(inode);
 	inode->i_mode = p->mode;
+#ifdef CONFIG_SYSCTL
+	proc_update_mode(&inode->i_mode, p->type, task);
+	inode->i_op = &proc_base_inode_operations;
+#endif
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
diff -pur linux-2.6.11-mm3/include/linux/sysctl.h l5/include/linux/sysctl.h
--- linux-2.6.11-mm3/include/linux/sysctl.h	2005-03-12 19:23:37.000000000 +0100
+++ l5/include/linux/sysctl.h	2005-03-18 23:40:59.000000000 +0100
@@ -654,6 +654,13 @@ enum {
 };
 
 /* CTL_PROC names: */
+enum {
+	PROC_CMDLINE	= 1,
+	PROC_MAPS	= 2,
+	PROC_STAT	= 3,
+	PROC_STATM	= 4,
+	PROC_STATUS	= 5,
+};
 
 /* CTL_FS names: */
 enum
diff -pur linux-2.6.11-mm3/kernel/sysctl.c l5/kernel/sysctl.c
--- linux-2.6.11-mm3/kernel/sysctl.c	2005-03-12 19:23:38.000000000 +0100
+++ l5/kernel/sysctl.c	2005-03-19 00:39:33.000000000 +0100
@@ -168,6 +168,15 @@ extern struct proc_dir_entry *proc_sys_r
 
 static void register_proc_table(ctl_table *, struct proc_dir_entry *);
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
+
+struct proc_sysctl_info {
+        int type;
+        mode_t mode;
+};
+extern struct proc_sysctl_info proc_base_permissions[];
+
+int proc_domode(ctl_table *, int, struct file *, void __user *, size_t *, loff_t *);
+
 #endif
 
 /* The default sysctl tables: */
@@ -839,7 +848,53 @@ static ctl_table vm_table[] = {
 	{ .ctl_name = 0 }
 };
 
+#ifdef CONFIG_PROC_FS
+static int mode_r_ugo = S_IRUGO;
+#endif
+
 static ctl_table proc_table[] = {
+#ifdef CONFIG_PROC_FS
+	{
+		.ctl_name	= PROC_CMDLINE,
+		.procname	= "cmdline",
+		.data		= &proc_base_permissions[PROC_CMDLINE-1].mode,
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_MAPS,
+		.procname	= "maps",
+		.data		= &proc_base_permissions[PROC_MAPS-1].mode,
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_STAT,
+		.procname	= "stat",
+		.data		= &proc_base_permissions[PROC_STAT-1].mode,
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_STATM,
+		.procname	= "statm",
+		.data		= &proc_base_permissions[PROC_STATM-1].mode,
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_STATUS,
+		.procname	= "status",
+		.data		= &proc_base_permissions[PROC_STATUS-1].mode,
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
@@ -1459,6 +1514,79 @@ static int proc_doutsstring(ctl_table *t
 	return r;
 }
 
+/**
+ * proc_domode - read a file mode value
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes one file mode value (data type mode_t) 
+ * from/to the user buffer, treated as an ASCII string. 
+ * Optionally checks that the value fits within the mask
+ * specified with *table->extra1.
+ *
+ * Returns 0 on success.
+ */
+int proc_domode(ctl_table *table, int write, struct file *filp,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	size_t len;
+	char __user *p;
+	char c;
+	char buf[6];
+	char *endp;
+	mode_t maxmask = 07777;
+	unsigned long mode;
+	
+	if (!table->data || !*lenp || (*ppos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+	
+	if (write) {
+		if (table->extra1)
+			maxmask = *((mode_t *)table->extra1);
+		len = 0;
+		p = buffer;
+		while (len < *lenp) {
+			if (get_user(c, p++))
+				return -EFAULT;
+			if (c == 0 || c == '\n')
+				break;
+			len++;
+		}
+		if (len > 6)
+			return -EINVAL;
+		if (copy_from_user(buf, buffer, len))
+			return -EFAULT;
+		buf[len] = '\0';
+		mode = simple_strtoul(buf, &endp, 0);
+		if (mode & ~maxmask)
+			return -EPERM;
+		*((mode_t *)table->data) = mode;
+		*ppos += *lenp;
+	} else {
+		if (*((mode_t *)table->data) > 07777)
+			return -EINVAL;
+		mode = *((mode_t *)table->data);
+		if (mode & 07000)
+			len = sprintf(buf, "%05o\n", (mode_t)mode);
+		else
+			len = sprintf(buf, "%04o\n", (mode_t)mode);
+		if (len > *lenp)
+			len = *lenp;
+		if (len)
+			if (copy_to_user(buffer, buf, len))
+				return -EFAULT;
+		*lenp = len;
+		*ppos += len;
+	}
+	return 0;
+}
+
 static int do_proc_dointvec_conv(int *negp, unsigned long *lvalp,
 				 int *valp,
 				 int write, void *data)
