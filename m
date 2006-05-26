Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWEZEVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWEZEVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWEZEVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:21:32 -0400
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:22362 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030376AbWEZEVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:21:14 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Fri, 26 May 2006 14:21:12 +1000
Message-Id: <20060526042112.2886.24458.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
Subject: [RFC 5/5] sched: Add procfs interface for CPU rate hard caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a procfs interface for hard CPU rate caps.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
 fs/proc/base.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

Index: MM-2.6.17-rc4-mm3/fs/proc/base.c
===================================================================
--- MM-2.6.17-rc4-mm3.orig/fs/proc/base.c	2006-05-26 13:50:57.000000000 +1000
+++ MM-2.6.17-rc4-mm3/fs/proc/base.c	2006-05-26 13:51:01.000000000 +1000
@@ -170,6 +170,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPU_RATE_CAPS
 	PROC_TID_CPU_RATE_CAP,
 #endif
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	PROC_TID_CPU_RATE_HARD_CAP,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -286,6 +289,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_CPU_RATE_CAPS
 	E(PROC_TID_CPU_RATE_CAP,  "cpu_rate_cap",   S_IFREG|S_IRUGO|S_IWUSR),
 #endif
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	E(PROC_TID_CPU_RATE_HARD_CAP,  "cpu_rate_hard_cap",   S_IFREG|S_IRUGO|S_IWUSR),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -1090,6 +1096,54 @@ struct file_operations proc_cpu_rate_cap
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
@@ -1855,6 +1909,11 @@ static struct dentry *proc_pident_lookup
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

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
