Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVCTKPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVCTKPE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVCTKPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:15:04 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:35247 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262075AbVCTKOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:14:43 -0500
Subject: [PATCH][2/5] Sysctl for proc
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Date: Sun, 20 Mar 2005 11:14:43 +0100
Message-Id: <1111313683.2bf6b.17773@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an array to store file permission settings in and add an example
sysctl (proc.cmdline).  It can already be set and read, but it has no
effect, yet.

diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-03-19 01:28:47.000000000 +0100
+++ l2/fs/proc/base.c	2005-03-19 19:50:37.000000000 +0100
@@ -227,6 +227,13 @@ static struct pid_entry tid_attr_stuff[]
 
 #undef E
 
+#ifdef CONFIG_SYSCTL
+/* Order and number of elements must match CTL_PROC table in sysctl.h! */
+mode_t proc_base_permissions[] = {
+	S_IRUGO,	/* PROC_CMDLINE */
+};
+#endif /* CONFIG_SYSCTL */
+
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct task_struct *task = proc_task(inode);
diff -pur l1/include/linux/sysctl.h l2/include/linux/sysctl.h
--- l1/include/linux/sysctl.h	2005-03-19 19:49:43.000000000 +0100
+++ l2/include/linux/sysctl.h	2005-03-19 19:49:53.000000000 +0100
@@ -654,6 +654,9 @@ enum {
 };
 
 /* CTL_PROC names: */
+enum {
+	PROC_CMDLINE	= 1,
+};
 
 /* CTL_FS names: */
 enum
diff -pur l1/kernel/sysctl.c l2/kernel/sysctl.c
--- l1/kernel/sysctl.c	2005-03-19 19:49:43.000000000 +0100
+++ l2/kernel/sysctl.c	2005-03-19 19:49:53.000000000 +0100
@@ -168,6 +168,10 @@ extern struct proc_dir_entry *proc_sys_r
 
 static void register_proc_table(ctl_table *, struct proc_dir_entry *);
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
+
+extern mode_t proc_base_permissions[];
+
+static int mode_r_ugo = S_IRUGO;
 #endif
 
 /* The default sysctl tables: */
@@ -840,6 +844,16 @@ static ctl_table vm_table[] = {
 };
 
 static ctl_table proc_table[] = {
+#ifdef CONFIG_PROC_FS
+	{
+		.ctl_name	= PROC_CMDLINE,
+		.procname	= "cmdline",
+		.data		= &proc_base_permissions[PROC_CMDLINE-1],
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 

