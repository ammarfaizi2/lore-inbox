Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVAJXil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVAJXil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAJXhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:37:09 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:50011 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262649AbVAJXay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:30:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VjP8ID/SCrwwHV3C+6vTihyePNwzT/mK4gxivl/l0S9cbzZ1fthOU+YEw252WmpBd0WrOMH+Wwes1u2hC1q0YYPI3QPHSghahdQW/e4WBlWqWpU7S+axnfWWOiwcpFLf4qE86jWeKm3pUpvjXKHMIZKol43WEJrQtX1+rv2BtgE=
Message-ID: <3f250c71050110153031825ba3@mail.gmail.com>
Date: Mon, 10 Jan 2005 19:30:53 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: User space out of memory approach
Cc: Edjard Souza Mota <edjard@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <3f250c71050110152421e83e04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <3f250c71050110152421e83e04@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I noticed something wrong with the first patch. Here goes the fixed patch:

***********
PATCH
***********

diff -urN linux-2.6.10/fs/proc/array.c linux-2.6.10-oom/fs/proc/array.c
--- linux-2.6.10/fs/proc/array.c	2004-12-24 17:35:00.000000000 -0400
+++ linux-2.6.10-oom/fs/proc/array.c	2005-01-10 15:42:26.000000000 -0400
@@ -470,3 +470,13 @@
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+int proc_pid_oom(struct task_struct *task, char * buffer)
+{
+	int res;
+	res = sprintf(buffer, "%d %lu %lu\n",
+		      task->pid,
+		      task->utime,
+		      task->stime);
+	return res;
+}
diff -urN linux-2.6.10/fs/proc/base.c linux-2.6.10-oom/fs/proc/base.c
--- linux-2.6.10/fs/proc/base.c	2004-12-24 17:35:00.000000000 -0400
+++ linux-2.6.10-oom/fs/proc/base.c	2005-01-10 15:42:26.000000000 -0400
@@ -60,6 +60,7 @@
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_OOM,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -86,6 +87,7 @@
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_OOM,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -132,6 +134,7 @@
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TGID_OOM,       "oom", S_IFREG|S_IRUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -157,6 +160,7 @@
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TID_OOM,       "oom", S_IFREG|S_IRUGO),
 	{0,0,NULL,0}
 };
 
@@ -193,6 +197,7 @@
 int proc_tgid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
+int proc_pid_oom(struct task_struct*,char*);
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry,
struct vfsmount **mnt)
 {
@@ -1377,6 +1382,11 @@
 			ei->op.proc_read = proc_pid_schedstat;
 			break;
 #endif
+		case PROC_TID_OOM:
+		case PROC_TGID_OOM:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_oom;
+			break;
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
diff -urN linux-2.6.10/include/linux/oom_kill.h
linux-2.6.10-oom/include/linux/oom_kill.h
--- linux-2.6.10/include/linux/oom_kill.h	1969-12-31 20:00:00.000000000 -0400
+++ linux-2.6.10-oom/include/linux/oom_kill.h	2005-01-10
15:42:26.000000000 -0400
@@ -0,0 +1,6 @@
+struct candidate_process {
+	pid_t pid;
+	struct list_head pid_list;
+};
+
+struct list_head *loop_counter;
diff -urN linux-2.6.10/mm/oom_kill.c linux-2.6.10-oom/mm/oom_kill.c
--- linux-2.6.10/mm/oom_kill.c	2004-12-24 17:34:57.000000000 -0400
+++ linux-2.6.10-oom/mm/oom_kill.c	2005-01-10 17:56:34.000000000 -0400
@@ -13,13 +13,26 @@
  *  machine) this file will double as a 'coding guide' and a signpost
  *  for newbie kernel hackers. It features several pointers to major
  *  kernel subsystems and hints as to where to find out what things do.
+ *
+ *
+ *  2005
+ *  Bruna Moreira <bruna.moreira@indt.org.br>
+ *  Edjard Mota <edjard.mota@indt.org.br>
+ *  Ilias Biris <ext-ilias.biris@indt.org.br>
+ *  Mauricio Lin <mauricio.lin@indt.org.br>
+ * 
+ *  Embedded Linux Lab - 10LE Institulo Nokia de Tecnologia - INdT 
+ *
+ *  Turn off the kernel space out of memory killer algorithm and provide
+ *  support for user space out of memory killer.
  */
-
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/oom_kill.h>
 
 /* #define DEBUG */
 
@@ -42,6 +55,57 @@
  *    of least surprise ... (be careful when you change it)
  */
 
+struct candidate_process *candidate;
+
+EXPORT_SYMBOL(candidate);
+
+LIST_HEAD(pidqueue_head);
+
+EXPORT_SYMBOL(pidqueue_head);
+/*
+void show_candidate_comm(void)
+{
+	struct task_struct *g, *p;
+	int i = 0;
+
+	list_for_each(loop_counter, &pidqueue_head) {
+		candidate = list_entry(loop_counter, struct candidate_process, pid_list);
+		do_each_thread(g, p)
+			if (p->pid == candidate->pid) {
+				printk(KERN_DEBUG "A good walker leaves no tracks.%s\n", p->comm);
+				goto outer_loop;
+			}
+		while_each_thread(g, p);
+	  outer_loop:
+		continue;
+	}
+}
+
+EXPORT_SYMBOL(show_candidate_comm);
+*/
+static struct task_struct * select_process(void)
+{
+	struct task_struct *g, *p;
+	struct task_struct *chosen = NULL;
+	      
+	if (!list_empty(&pidqueue_head)) {
+		struct list_head *tmp;
+		list_for_each_safe(loop_counter, tmp, &pidqueue_head) {
+			candidate = list_entry(loop_counter, struct candidate_process, pid_list);
+			do_each_thread(g, p)
+				if (p->pid == candidate->pid) {
+					chosen = p;
+					list_del(&candidate->pid_list);
+					kfree(candidate);
+					goto exit;
+				}
+			while_each_thread(g, p);
+		}
+	}
+  exit:
+	return chosen;
+}
+
 static unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
@@ -111,6 +175,7 @@
  *
  * (not docbooked, we don't want this one cluttering up the manual)
  */
+/*
 static struct task_struct * select_bad_process(void)
 {
 	unsigned long maxpoints = 0;
@@ -132,7 +197,7 @@
 	while_each_thread(g, p);
 	return chosen;
 }
-
+*/
 /**
  * We must be careful though to never send SIGKILL a process with
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
@@ -191,7 +256,8 @@
 	
 	read_lock(&tasklist_lock);
 retry:
-	p = select_bad_process();
+	printk(KERN_DEBUG "A good walker leaves no tracks.\n");
+	p = select_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (!p) {




BR,

Mauricio Lin.
