Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269359AbUIYQcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269359AbUIYQcu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUIYQcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 12:32:50 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:63914 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269359AbUIYQci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 12:32:38 -0400
Date: Sat, 25 Sep 2004 18:32:04 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Thomas Habets <thomas@habets.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040925163203.GO3309@dualathlon.random>
References: <200409230123.30858.thomas@habets.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409230123.30858.thomas@habets.pp.se>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:23:08AM +0200, Thomas Habets wrote:
> 
> Hello.
> 
> How about a sysctl that does "for the love of kbaek, don't ever kill these 
> processes when OOM. If nothing else can be killed, I'd rather you panic"?
> 
> Examples for this list would be /usr/bin/vlock and /usr/X11R6/bin/xlock. 
> I just got a very uncomfortable surprise when found my box unlocked thanks to 
> this.
> 
> After playing around a bit, I made the patch below, but it's almost completely 
> untested. I'm not even sure I take the binaries name from the right place. 
> And I don't know if the locking can race. If it's too ugly then it'd be great 
> if someone implemented it the right way. (iow: huge fucking disclaimer)
> 
> echo "/usr/bin/vlock /usr/X11R6/bin/xlock" > /proc/sys/vm/oom_pardon

we had to implement this for our kernel too. The logic is similar to the
one in your patch. The oom killer is not trustable on servers where the
biggest task is the only one we trust, this patch tries to workaround
it. This is just for your info and to standardize on the same API if it
overlaps functionality.

this patch is from Kurt and it's called protect-pids. Even after
rewriting the oom killer, this would probably remain a nice feature for
a few selected trusted apps.

The value is inherited by fork, one slight modification I would probably
like is to reset the value during exec so it can be safely used on ssh
too (so that bash and its childs aren't unkillable too, currently
enabling this on ssh is like allowing all normal users logging in to DoS
the machine, but it's more generic for bigger apps like databases that
may fork+exec). I'd probably also place oomkilladj at the end of the
task struct instead of counting the bits but it doesn't make any
difference in practice.

Comments?

--------------------------------------------------------------------------
Feature.

This patch changes the way Linux choses processes when an out-of-memory (OOM) 
situation is detected. 
* It sends a SIGTERM first to a process. If the process is selected a
  second time by the OOM killer because we're still OOM, it will get
  a SIGKILL.
* It does export the OOM score of a process to userspace in
  /proc/$PID/oom_score
* It does allow the admin (CAP_SYS_RESOURCE) to change the OOM score by a
  power of two via 
  /proc/$PID/oom_adj
  The number needs to be in [-16..15], where -16 means that the score is
  lowered by a factor of 65536(2^16), thus making the process very unlikely
  to be chosen. Normally, numbers in [-8..7] should be used ...

 fs/proc/base.c        |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h |    4 ++
 mm/oom_kill.c         |   25 ++++++++++++++--
 3 files changed, 98 insertions(+), 5 deletions(-)

diff -uNrp linux-2.6.4.old/fs/proc/base.c linux-2.6.4/fs/proc/base.c
--- linux-2.6.4.old/fs/proc/base.c	2004-04-01 19:57:29.000000000 +0200
+++ linux-2.6.4/fs/proc/base.c	2004-04-02 12:01:52.000000000 +0200
@@ -69,6 +69,8 @@ enum pid_directory_inos {
 	PROC_TGID_ATTR_FSCREATE,
 #endif
 	PROC_TGID_FD_DIR,
+	PROC_TGID_OOM_SCORE,
+	PROC_TGID_OOM_ADJUST,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -96,6 +98,8 @@ enum pid_directory_inos {
         PROC_TGID_DELAY_ACCT,
 #endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
+	PROC_TID_OOM_SCORE,
+	PROC_TID_OOM_ADJUST,
 };
 
 struct pid_entry {
@@ -134,6 +138,8 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
+	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -159,6 +165,8 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
+	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 	{0,0,NULL,0}
 };
 
@@ -416,6 +424,14 @@ static int proc_pid_wchan(struct task_st
 }
 #endif /* CONFIG_KALLSYMS */
 
+/* The badness from the OOM killer */
+int badness(struct task_struct *p);
+static int proc_oom_score(struct task_struct *task, char *buffer)
+{
+	int points = badness(task);
+	return sprintf(buffer, "%i\n", points);
+}
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -753,6 +769,55 @@ static struct file_operations proc_mapba
 };
 #endif /* __HAS_ARCH_PROC_MAPPED_BASE */
 
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
@@ -1467,6 +1532,15 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_delay;
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
diff -uNrp linux-2.6.4.old/include/linux/sched.h linux-2.6.4/include/linux/sched.h
--- linux-2.6.4.old/include/linux/sched.h	2004-04-01 19:57:29.000000000 +0200
+++ linux-2.6.4/include/linux/sched.h	2004-04-02 11:33:10.305376136 +0200
@@ -442,7 +442,9 @@ struct task_struct {
 	struct user_struct *user;
 /* limits */
 	struct rlimit rlim[RLIM_NLIMITS];
-	unsigned short used_math;
+	unsigned short used_math:1;
+	unsigned short rcvd_sigterm:1;	/* Received SIGTERM by oom killer already */
+	short oomkilladj:5;		/* OOM kill score adjustment (bit shift) */
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
diff -uNrp linux-2.6.4.old/mm/oom_kill.c linux-2.6.4/mm/oom_kill.c
--- linux-2.6.4.old/mm/oom_kill.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4/mm/oom_kill.c	2004-04-02 11:37:34.802253850 +0200
@@ -41,7 +41,7 @@
  *    of least surprise ... (be careful when you change it)
  */
 
-static int badness(struct task_struct *p)
+int badness(struct task_struct *p)
 {
 	int points, cpu_time, run_time, s;
 
@@ -93,6 +93,21 @@ static int badness(struct task_struct *p
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
+	/* 
+	 * One point for already having received a warning 
+	 */
+	points += p->rcvd_sigterm;
+		
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
 	p->pid, p->comm, points);
@@ -152,11 +166,13 @@ static void __oom_kill_task(task_t *p)
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		force_sig(SIGTERM, p);
-	} else {
+	else if (p->rcvd_sigterm++)
 		force_sig(SIGKILL, p);
-	}
+	else
+		force_sig(SIGTERM, p);
+
 }
 
 static struct mm_struct *oom_kill_task(task_t *p)


