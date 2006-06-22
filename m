Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWFVBxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWFVBxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWFVBx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:53:28 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:4710 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030497AbWFVBxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:53:11 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Peter Williams <pwil3058@bigpond.net.au>, Srivatsa <vatsa@in.ibm.com>,
       Balbir Singh <bsingharora@gmail.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Thu, 22 Jun 2006 11:53:09 +1000
Message-Id: <20060622015309.14498.46692.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
References: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
Subject: [PATCH 3/4] sched: Add procfs interface for CPU rate soft caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a procfs interface for soft CPU rate caps.
Via files of the form /proc/<tgid>/task/<pid>/cpu_rate_cap.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>
 fs/proc/base.c      |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.caps |    5 ++++
 2 files changed, 64 insertions(+)

Index: MM-2.6.17-mm1/fs/proc/base.c
===================================================================
--- MM-2.6.17-mm1.orig/fs/proc/base.c	2006-06-22 09:27:19.000000000 +1000
+++ MM-2.6.17-mm1/fs/proc/base.c	2006-06-22 10:40:18.000000000 +1000
@@ -168,6 +168,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPUSETS
 	PROC_TID_CPUSET,
 #endif
+#ifdef CONFIG_CPU_RATE_CAPS
+	PROC_TID_CPU_RATE_CAP,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -282,6 +285,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_CPU_RATE_CAPS
+	E(PROC_TID_CPU_RATE_CAP,  "cpu_rate_cap",   S_IFREG|S_IRUGO|S_IWUSR),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -1041,6 +1047,54 @@ static struct file_operations proc_secco
 };
 #endif /* CONFIG_SECCOMP */
 
+#ifdef CONFIG_CPU_RATE_CAPS
+static ssize_t cpu_rate_cap_read(struct file * file, char * buf,
+			size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	char buffer[64];
+	size_t len;
+	unsigned int cppt = get_cpu_rate_cap(task);
+
+	if (*ppos)
+		return 0;
+	*ppos = len = sprintf(buffer, "%u\n", cppt);
+	if (copy_to_user(buf, buffer, len))
+		return -EFAULT;
+
+	return len;
+}
+
+static ssize_t cpu_rate_cap_write(struct file * file, const char * buf,
+			 size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	char buffer[128] = "";
+	char *endptr = NULL;
+	unsigned long hcppt;
+	int res;
+
+
+	if ((count > 63) || *ppos)
+		return -EFBIG;
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+	hcppt = simple_strtoul(buffer, &endptr, 0);
+	if ((endptr == buffer) || (hcppt == ULONG_MAX))
+		return -EINVAL;
+
+	if ((res = set_cpu_rate_cap(task, hcppt)) != 0)
+		return res;
+
+	return count;
+}
+
+struct file_operations proc_cpu_rate_cap_operations = {
+	read:		cpu_rate_cap_read,
+	write:		cpu_rate_cap_write,
+};
+#endif
+
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1803,6 +1857,11 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_loginuid_operations;
 			break;
 #endif
+#ifdef CONFIG_CPU_RATE_CAPS
+		case PROC_TID_CPU_RATE_CAP:
+			inode->i_fop = &proc_cpu_rate_cap_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: MM-2.6.17-mm1/kernel/Kconfig.caps
===================================================================
--- MM-2.6.17-mm1.orig/kernel/Kconfig.caps	2006-06-22 10:29:46.000000000 +1000
+++ MM-2.6.17-mm1/kernel/Kconfig.caps	2006-06-22 10:48:54.000000000 +1000
@@ -11,6 +11,11 @@ config CPU_RATE_CAPS
 	  allocated a soft CPU rate cap will be limited to that rate of CPU
 	  usage unless there is spare CPU resources available after the needs
 	  of uncapped tasks are met.
+	  Task soft caps can be set/got via the procfs file system using
+	  files of the form /proc/<tgid>/task/<pid>/cpu_rate_cap in parts
+	  per thousand.  Minimum soft cap is 0 and effectively places the
+	  task in the background.  Maximum soft cap is 1000 and means
+	  unlimited.
 
 config CPU_RATE_HARD_CAPS
 	bool "Support CPU rate hard caps"

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
