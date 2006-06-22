Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWFVBx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWFVBx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWFVBx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:53:26 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:13562 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030501AbWFVBxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:53:21 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Balbir Singh <bsingharora@gmail.com>, Srivatsa <vatsa@in.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Thu, 22 Jun 2006 11:53:19 +1000
Message-Id: <20060622015319.14498.81601.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
References: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
Subject: [PATCH 4/4] sched: Add procfs interface for CPU rate hard caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a procfs interface for hard CPU rate caps.
Via files of the form /proc/<tgid>/task/<pid>/cpu_rate_hard_cap.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>
 fs/proc/base.c      |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.caps |    4 +++
 2 files changed, 63 insertions(+)

Index: MM-2.6.17-mm1/fs/proc/base.c
===================================================================
--- MM-2.6.17-mm1.orig/fs/proc/base.c	2006-06-22 10:40:18.000000000 +1000
+++ MM-2.6.17-mm1/fs/proc/base.c	2006-06-22 10:49:55.000000000 +1000
@@ -171,6 +171,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPU_RATE_CAPS
 	PROC_TID_CPU_RATE_CAP,
 #endif
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	PROC_TID_CPU_RATE_HARD_CAP,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -288,6 +291,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_CPU_RATE_CAPS
 	E(PROC_TID_CPU_RATE_CAP,  "cpu_rate_cap",   S_IFREG|S_IRUGO|S_IWUSR),
 #endif
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	E(PROC_TID_CPU_RATE_HARD_CAP,  "cpu_rate_hard_cap",   S_IFREG|S_IRUGO|S_IWUSR),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -1095,6 +1101,54 @@ struct file_operations proc_cpu_rate_cap
 };
 #endif
 
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+static ssize_t cpu_rate_hard_cap_read(struct file * file, char * buf,
+			size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	char buffer[64];
+	size_t len;
+	unsigned int cppt = get_cpu_rate_hard_cap(task);
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
+static ssize_t cpu_rate_hard_cap_write(struct file * file, const char * buf,
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
+	if ((res = set_cpu_rate_hard_cap(task, hcppt)) != 0)
+		return res;
+
+	return count;
+}
+
+struct file_operations proc_cpu_rate_hard_cap_operations = {
+	read:		cpu_rate_hard_cap_read,
+	write:		cpu_rate_hard_cap_write,
+};
+#endif
+
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1862,6 +1916,11 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_cpu_rate_cap_operations;
 			break;
 #endif
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+		case PROC_TID_CPU_RATE_HARD_CAP:
+			inode->i_fop = &proc_cpu_rate_hard_cap_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: MM-2.6.17-mm1/kernel/Kconfig.caps
===================================================================
--- MM-2.6.17-mm1.orig/kernel/Kconfig.caps	2006-06-22 10:48:54.000000000 +1000
+++ MM-2.6.17-mm1/kernel/Kconfig.caps	2006-06-22 10:52:21.000000000 +1000
@@ -26,3 +26,7 @@ config CPU_RATE_HARD_CAPS
 	  the rate of CPU usage by individual tasks.  A task which has been
 	  allocated a hard CPU rate cap will be limited to that rate of CPU
 	  usage regardless of whether there is spare CPU resources available.
+	  Task hard caps can be set/got via the procfs file system using
+	  files of the form /proc/<tgid>/task/<pid>/cpu_rate_hard_cap in parts
+	  per thousand.  Minimum hard cap is 1 and the maximum hard cap is
+	  1000 (which means unlimited).

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
