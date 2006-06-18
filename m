Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWFRI1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWFRI1W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 04:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWFRI1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 04:27:22 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:65196 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932169AbWFRI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 04:27:11 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Peter Williams <pwil3058@bigpond.net.au>, Srivatsa <vatsa@in.ibm.com>,
       Balbir Singh <bsingharora@gmail.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Sun, 18 Jun 2006 18:27:09 +1000
Message-Id: <20060618082709.6061.30813.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
Subject: [PATCH 3/4] sched: Add procfs interface for CPU rate soft caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a procfs interface for soft CPU rate caps.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
 fs/proc/base.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

Index: MM-2.6.17-rc6-mm2/fs/proc/base.c
===================================================================
--- MM-2.6.17-rc6-mm2.orig/fs/proc/base.c	2006-06-13 09:56:43.000000000 +1000
+++ MM-2.6.17-rc6-mm2/fs/proc/base.c	2006-06-14 11:14:01.000000000 +1000
@@ -167,6 +167,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPUSETS
 	PROC_TID_CPUSET,
 #endif
+#ifdef CONFIG_CPU_RATE_CAPS
+	PROC_TID_CPU_RATE_CAP,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -280,6 +283,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_CPU_RATE_CAPS
+	E(PROC_TID_CPU_RATE_CAP,  "cpu_rate_cap",   S_IFREG|S_IRUGO|S_IWUSR),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -1037,6 +1043,54 @@ static struct file_operations proc_secco
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
@@ -1797,6 +1851,11 @@ static struct dentry *proc_pident_lookup
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

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
