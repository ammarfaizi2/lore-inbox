Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbUAFPMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUAFPMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:12:18 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:25866 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264469AbUAFPL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:11:57 -0500
Message-ID: <3FFAD147.7050907@kolumbus.fi>
Date: Tue, 06 Jan 2004 17:16:23 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] cookie based proc_pid_readdir
References: <3FFABA20.3030304@colorfullife.com>
In-Reply-To: <3FFABA20.3030304@colorfullife.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.01.2004 17:14:03,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.01.2004 17:13:11,
	Serialize complete at 06.01.2004 17:13:11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

afaics, clist_head from f_version is leaked if not whole directory read.

--Mika



Manfred Spraul wrote:

> proc_dir_readdir skips over tasks if tasks exit between the individual 
> get_tgid_list calls. The only approach that guarantees that no tasks 
> are skipped is to add a cookie into the task list and restart from 
> that cookie.
>
> Attached is a proof of concept patch that adds such cookies - please 
> comment.
>
> -- 
>    Manfred
>
>------------------------------------------------------------------------
>
>// $Header$
>// Kernel Version:
>//  VERSION = 2
>//  PATCHLEVEL = 6
>//  SUBLEVEL = 0
>//  EXTRAVERSION =
>--- 2.6/include/linux/list.h	2003-12-20 09:19:13.000000000 +0100
>+++ build-2.6/include/linux/list.h	2004-01-06 12:26:32.000000000 +0100
>@@ -39,6 +39,16 @@
> } while (0)
> 
> /*
>+ * special linked lists that can contain invisible
>+ * members. Members with nonzero is_cookie should be
>+ * skipped.
>+ */
>+struct clist_head {
>+	struct list_head l;
>+	int is_cookie;
>+};
>+
>+/*
>  * Insert a new entry between two known consecutive entries. 
>  *
>  * This is only for internal list manipulation where we know
>--- 2.6/include/linux/proc_fs.h	2003-10-25 20:42:42.000000000 +0200
>+++ build-2.6/include/linux/proc_fs.h	2004-01-06 12:48:15.000000000 +0100
>@@ -95,6 +95,7 @@
> struct dentry *proc_pid_unhash(struct task_struct *p);
> void proc_pid_flush(struct dentry *proc_dentry);
> int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
>+loff_t proc_pid_llseek(struct file *file, loff_t offset, int origin);
> 
> extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
> 						struct proc_dir_entry *parent);
>--- 2.6/include/linux/sched.h	2003-12-04 19:44:40.000000000 +0100
>+++ build-2.6/include/linux/sched.h	2004-01-06 12:31:57.000000000 +0100
>@@ -352,7 +352,7 @@
> 	cpumask_t cpus_allowed;
> 	unsigned int time_slice, first_time_slice;
> 
>-	struct list_head tasks;
>+	struct clist_head tasks;
> 	struct list_head ptrace_children;
> 	struct list_head ptrace_list;
> 
>@@ -719,18 +719,31 @@
> 
> #define REMOVE_LINKS(p) do {					\
> 	if (thread_group_leader(p))				\
>-		list_del_init(&(p)->tasks);			\
>+		list_del_init(&(p)->tasks.l);			\
> 	remove_parent(p);					\
> 	} while (0)
> 
> #define SET_LINKS(p) do {					\
> 	if (thread_group_leader(p))				\
>-		list_add_tail(&(p)->tasks,&init_task.tasks);	\
>+		list_add_tail(&(p)->tasks.l,&init_task.tasks.l);	\
> 	add_parent(p, (p)->parent);				\
> 	} while (0)
> 
>-#define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
>-#define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
>+static inline task_t * next_task(task_t *p)
>+{
>+	do {
>+		p = list_entry((p)->tasks.l.next, struct task_struct, tasks.l);
>+	} while(p->tasks.is_cookie);
>+	return p;
>+}
>+
>+static inline task_t * prev_task(task_t *p)
>+{
>+	do {
>+		p = list_entry((p)->tasks.l.prev, struct task_struct, tasks.l);
>+	} while(p->tasks.is_cookie);
>+	return p;
>+}
> 
> #define for_each_process(p) \
> 	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
>--- 2.6/include/linux/init_task.h	2003-12-04 19:44:40.000000000 +0100
>+++ build-2.6/include/linux/init_task.h	2004-01-06 12:32:51.000000000 +0100
>@@ -75,7 +75,7 @@
> 	.active_mm	= &init_mm,					\
> 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
> 	.time_slice	= HZ,						\
>-	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
>+	.tasks		= { LIST_HEAD_INIT(tsk.tasks.l), 0},		\
> 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
> 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
> 	.real_parent	= &tsk,						\
>--- 2.6/fs/proc/base.c	2003-12-20 09:19:13.000000000 +0100
>+++ build-2.6/fs/proc/base.c	2004-01-06 14:17:20.000000000 +0100
>@@ -1627,33 +1627,6 @@
> #define PROC_MAXPIDS 20
> 
> /*
>- * Get a few tgid's to return for filldir - we need to hold the
>- * tasklist lock while doing this, and we must release it before
>- * we actually do the filldir itself, so we use a temp buffer..
>- */
>-static int get_tgid_list(int index, unsigned int *tgids)
>-{
>-	struct task_struct *p;
>-	int nr_tgids = 0;
>-
>-	index--;
>-	read_lock(&tasklist_lock);
>-	for_each_process(p) {
>-		int tgid = p->pid;
>-		if (!pid_alive(p))
>-			continue;
>-		if (--index >= 0)
>-			continue;
>-		tgids[nr_tgids] = tgid;
>-		nr_tgids++;
>-		if (nr_tgids >= PROC_MAXPIDS)
>-			break;
>-	}
>-	read_unlock(&tasklist_lock);
>-	return nr_tgids;
>-}
>-
>-/*
>  * Get a few tid's to return for filldir - we need to hold the
>  * tasklist lock while doing this, and we must release it before
>  * we actually do the filldir itself, so we use a temp buffer..
>@@ -1685,35 +1658,134 @@
> 	return nr_tids;
> }
> 
>+loff_t proc_pid_llseek(struct file *file, loff_t offset, int origin)
>+{
>+	long long retval;
>+	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
>+
>+	down(&inode->i_sem);
>+	switch (origin) {
>+		case 2:
>+			offset += inode->i_size;
>+			break;
>+		case 1:
>+			offset += file->f_pos;
>+	}
>+	retval = -EINVAL;
>+	if (offset>=0 && offset<=inode->i_sb->s_maxbytes) {
>+		if (offset != file->f_pos) {
>+			file->f_pos = offset;
>+			if (file->f_version) {
>+				struct clist_head *cl;
>+				cl = (struct clist_head *)file->f_version;
>+				write_lock_irq(&tasklist_lock);
>+				list_del(&cl->l);
>+				write_unlock_irq(&tasklist_lock);
>+				kfree(cl);
>+				file->f_version = 0;
>+			}
>+		}
>+		retval = offset;
>+	}
>+	up(&inode->i_sem);
>+	return retval;
>+}
>+
> /* for the /proc/ directory itself, after non-process stuff has been done */
> int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
> {
>-	unsigned int tgid_array[PROC_MAXPIDS];
>-	char buf[PROC_NUMBUF];
> 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
>-	unsigned int nr_tgids, i;
>+	struct clist_head fcl; /* fallback if kmalloc fails - -ENOMEM is not permitted */
>+	struct clist_head *pcl;
> 
> 	if (!nr) {
> 		ino_t ino = fake_ino(0,PROC_TGID_INO);
> 		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
> 			return 0;
> 		filp->f_pos++;
>-		nr++;
>+	} else {
>+		nr--;
> 	}
> 
>-	nr_tgids = get_tgid_list(nr, tgid_array);
>+	if (filp->f_version) {
>+		pcl = (struct clist_head *)filp->f_version;
>+	} else {
>+		task_t *p;
>+		pcl = kmalloc(sizeof(struct clist_head), GFP_KERNEL);
>+		if (pcl)
>+			filp->f_version = (unsigned long)pcl;
>+		else
>+			pcl = &fcl;
>+
>+		INIT_LIST_HEAD(&pcl->l);
>+		pcl->is_cookie = 1;
>+		
>+		write_lock_irq(&tasklist_lock);
>+		p = &init_task;
>+		while(nr) {
>+			if (pid_alive(p))
>+				nr--;
>+			p = next_task(p);
>+			if (p == &init_task) {
>+				write_unlock_irq(&tasklist_lock);
>+				if (pcl != &fcl) {
>+					filp->f_version = 0;
>+					kfree(pcl);
>+				}
>+				return 0;
>+			}
>+		}
>+		list_add(&pcl->l, &p->tasks.l);
>+		write_unlock_irq(&tasklist_lock);
>+	}
> 
>-	for (i = 0; i < nr_tgids; i++) {
>-		int tgid = tgid_array[i];
>-		ino_t ino = fake_ino(tgid,PROC_TGID_INO);
>-		unsigned long j = PROC_NUMBUF;
>+	for (;;) {
>+		unsigned int tgid;
>+		int j;
>+		char buf[PROC_NUMBUF];
>+		ino_t ino;
>+		task_t *p;
>+		struct list_head *walk;
>+
>+		write_lock_irq(&tasklist_lock);
>+		walk = &pcl->l;
>+		do {
>+			walk = walk->next;
>+			p = list_entry(walk, struct task_struct, tasks.l);
>+		} while (p->tasks.is_cookie);
>+		if (p == &init_task) {
>+			write_unlock_irq(&tasklist_lock);
>+			break;
>+		}
>+		tgid = p->pid;
>+		list_del(&pcl->l);
>+		list_add(&pcl->l, &p->tasks.l);
>+		write_unlock_irq(&tasklist_lock);
>+
>+		ino = fake_ino(tgid,PROC_TGID_INO);
> 
>+		j = PROC_NUMBUF;
> 		do buf[--j] = '0' + (tgid % 10); while (tgid/=10);
> 
>-		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0)
>+		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
>+			write_lock_irq(&tasklist_lock);
>+			walk = &pcl->l;
>+			do {
>+				walk = walk->prev;
>+				p = list_entry(walk, struct task_struct, tasks.l);
>+			} while (p->tasks.is_cookie);
>+			list_del(&pcl->l);
>+			list_add_tail(&pcl->l, &p->tasks.l);
>+			write_unlock_irq(&tasklist_lock);
> 			break;
>+		}
> 		filp->f_pos++;
> 	}
>+	if (pcl == &fcl) {
>+		write_lock_irq(&tasklist_lock);
>+		list_del(&fcl.l);
>+		write_unlock_irq(&tasklist_lock);
>+	}
> 	return 0;
> }
> 
>--- 2.6/fs/proc/root.c	2003-10-25 20:44:17.000000000 +0200
>+++ build-2.6/fs/proc/root.c	2004-01-06 13:19:31.000000000 +0100
>@@ -127,6 +127,7 @@
> static struct file_operations proc_root_operations = {
> 	.read		 = generic_read_dir,
> 	.readdir	 = proc_root_readdir,
>+	.llseek		 = proc_pid_llseek,
> };
> 
> /*
>--- 2.6/kernel/pid.c	2003-12-04 19:44:40.000000000 +0100
>+++ build-2.6/kernel/pid.c	2004-01-06 12:29:34.000000000 +0100
>@@ -255,7 +255,7 @@
> 	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
> 	attach_pid(thread, PIDTYPE_PGID, leader->__pgrp);
> 	attach_pid(thread, PIDTYPE_SID, thread->session);
>-	list_add_tail(&thread->tasks, &init_task.tasks);
>+	list_add_tail(&thread->tasks.l, &init_task.tasks.l);
> 
> 	attach_pid(leader, PIDTYPE_PID, leader->pid);
> 	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
>  
>

