Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265737AbUF2L1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbUF2L1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUF2LYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:24:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:16326 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265722AbUF2LXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:23:21 -0400
Date: Tue, 29 Jun 2004 04:22:39 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Sylvain <sylvain.jeaugey@bull.net>,
       Simon <Simon.Derr@bull.net>
Message-Id: <20040629112239.24730.82501.62456@sam.engr.sgi.com>
In-Reply-To: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
References: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
Subject: [patch 8/8] cpusets v3 - One more hook, for /proc/<pid>/cpuset.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpuset links to /proc, from each task to its cpuset.

Index: 2.6.7-mm1/fs/proc/base.c
===================================================================
--- 2.6.7-mm1.orig/fs/proc/base.c	2004-06-28 15:08:12.000000000 -0700
+++ 2.6.7-mm1/fs/proc/base.c	2004-06-28 15:10:43.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/cpuset.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -60,6 +61,9 @@ enum pid_directory_inos {
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+#ifdef CONFIG_CPUSETS
+	PROC_TGID_CPUSET,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR,
 	PROC_TGID_ATTR_CURRENT,
@@ -83,6 +87,9 @@ enum pid_directory_inos {
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+#ifdef CONFIG_CPUSETS
+	PROC_TID_CPUSET,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -123,6 +130,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_CPUSETS
+	E(PROC_TGID_CPUSET,    "cpuset", S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -145,6 +155,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_CPUSETS
+	E(PROC_TID_CPUSET,     "cpuset", S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -767,6 +780,14 @@ static struct inode_operations proc_pid_
 	.follow_link	= proc_pid_follow_link
 };
 
+
+#ifdef CONFIG_CPUSETS
+static int proc_pid_cpuset(struct task_struct *task, char *buffer)
+{
+	return proc_pid_cspath(task, buffer, PAGE_SIZE);
+}
+#endif /* CONFIG_CPUSETS */
+
 static int pid_alive(struct task_struct *p)
 {
 	BUG_ON(p->pids[PIDTYPE_PID].pidptr != &p->pids[PIDTYPE_PID].pid);
@@ -1375,6 +1396,13 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_wchan;
 			break;
 #endif
+#ifdef CONFIG_CPUSETS
+		case PROC_TID_CPUSET:
+		case PROC_TGID_CPUSET:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_cpuset;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: 2.6.7-mm1/fs/proc/root.c
===================================================================
--- 2.6.7-mm1.orig/fs/proc/root.c	2004-06-28 15:08:12.000000000 -0700
+++ 2.6.7-mm1/fs/proc/root.c	2004-06-28 15:10:43.000000000 -0700
@@ -75,6 +75,9 @@ void __init proc_root_init(void)
 	proc_device_tree_init();
 #endif
 	proc_bus = proc_mkdir("bus", 0);
+#ifdef CONFIG_CPUSETS
+	proc_mkdir("cpusets", 0);
+#endif
 }
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
