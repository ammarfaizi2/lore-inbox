Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbULXRgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbULXRgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULXRgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:36:11 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:29084 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261287AbULXRfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:35:31 -0500
Date: Fri, 24 Dec 2004 18:35:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: VM fixes [1/4]
Message-ID: <20041224173519.GB13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Likely I'll bring a -aa tree up in a few weeks to avoid this stuff to
get lost, but I'm attempting to merge it in mainline first.

This is protect-pids, a patch to allow the admin to tune the oom killer.
The tweak is inherited between parent and child so it's easy to write a
wrapper for complex apps.

I made used_math a char at the light of later patches. per-cpu atomicity
with byte granularity is provided by all archs AFIK.

From: garloff@suse.de
Subject: protect-pids

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

From: garloff@suse.de
Subject: protect-pids

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/fs/proc/base.c.orig	2004-12-04 08:56:31.000000000 +0100
+++ x/fs/proc/base.c	2004-12-24 17:50:29.043208992 +0100
@@ -71,6 +71,8 @@ enum pid_directory_inos {
 	PROC_TGID_ATTR_FSCREATE,
 #endif
 	PROC_TGID_FD_DIR,
+	PROC_TGID_OOM_SCORE,
+	PROC_TGID_OOM_ADJUST,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -97,6 +99,8 @@ enum pid_directory_inos {
 	PROC_TID_ATTR_FSCREATE,
 #endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
+	PROC_TID_OOM_SCORE,
+	PROC_TID_OOM_ADJUST,
 };
 
 struct pid_entry {
@@ -132,6 +136,8 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
+	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -157,6 +163,8 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
+	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 	{0,0,NULL,0}
 };
 
@@ -425,6 +433,18 @@ static int proc_pid_schedstat(struct tas
 }
 #endif
 
+/* The badness from the OOM killer */
+unsigned long badness(struct task_struct *p, unsigned long uptime);
+static int proc_oom_score(struct task_struct *task, char *buffer)
+{
+	unsigned long points;
+	struct timespec uptime;
+
+	do_posix_clock_monotonic_gettime(&uptime);
+	points = badness(task, uptime.tv_sec);
+	return sprintf(buffer, "%lu\n", points);
+}
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -698,6 +718,55 @@ static struct file_operations proc_mem_o
 	.open		= mem_open,
 };
 
+static ssize_t oom_adjust_read(struct file * file, char * buf,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	char buffer[8];
+	size_t len;
+	int oom_adjust = task->oomkilladj;
+
+	len = sprintf(buffer, "%i\n", oom_adjust) + 1;
+	if (*ppos >= len)
+		return 0;
+	if (count > len-*ppos)
+		count = len-*ppos;
+	if (copy_to_user(buf, buffer + *ppos, count)) 
+		return -EFAULT;
+	*ppos += count;
+	return count;
+}
+
+static ssize_t oom_adjust_write(struct file * file, const char * buf,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	char buffer[8], *end;
+	int oom_adjust;
+
+	if (!capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+	memset(buffer, 0, 8);	
+	if (count > 6)
+		count = 6;
+	if (copy_from_user(buffer, buf, count)) 
+		return -EFAULT;
+	oom_adjust = simple_strtol(buffer, &end, 0);
+	if (oom_adjust < -16 || oom_adjust > 15)
+		return -EINVAL;
+	if (*end == '\n')
+		end++;
+	task->oomkilladj = oom_adjust;
+	if (end - buffer == 0) 
+		return -EIO;
+	return end - buffer;
+}
+
+static struct file_operations proc_oom_adjust_operations = {
+	read:		oom_adjust_read,
+	write:		oom_adjust_write,
+};
+
 static struct inode_operations proc_mem_inode_operations = {
 	.permission	= proc_permission,
 };
@@ -1377,6 +1446,15 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_schedstat;
 			break;
 #endif
+		case PROC_TID_OOM_SCORE:	
+		case PROC_TGID_OOM_SCORE:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_oom_score;
+			break;
+		case PROC_TID_OOM_ADJUST:
+		case PROC_TGID_OOM_ADJUST:
+			inode->i_fop = &proc_oom_adjust_operations;
+			break;
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
--- x/include/linux/sched.h.orig	2004-12-04 08:56:32.000000000 +0100
+++ x/include/linux/sched.h	2004-12-24 17:48:36.743281176 +0100
@@ -600,7 +600,19 @@ struct task_struct {
 	struct key *process_keyring;	/* keyring private to this process (CLONE_THREAD) */
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
-	unsigned short used_math;
+/*
+ * Must be changed atomically so it shouldn't be
+ * be a shareable bitflag.
+ */
+	unsigned char used_math;
+/*
+ * OOM kill score adjustment (bit shift).
+ * Cannot live together with used_math since
+ * used_math and oomkilladj can be changed at the
+ * same time, so they would race if they're in the
+ * same atomic block.
+ */
+	short oomkilladj;
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
--- x/mm/oom_kill.c.orig	2004-12-04 08:55:05.000000000 +0100
+++ x/mm/oom_kill.c	2004-12-24 17:49:07.098666456 +0100
@@ -42,7 +42,7 @@
  *    of least surprise ... (be careful when you change it)
  */
 
-static unsigned long badness(struct task_struct *p, unsigned long uptime)
+unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
 
@@ -98,6 +98,17 @@ static unsigned long badness(struct task
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /= 4;
+
+	/* 
+	 * Adjust the score by oomkilladj.
+	 */
+	if (p->oomkilladj) {
+		if (p->oomkilladj > 0)
+			points <<= p->oomkilladj;
+		else
+			points >>= -(p->oomkilladj);
+	}
+		
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
 	p->pid, p->comm, points);
