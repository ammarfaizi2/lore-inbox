Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUIASBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUIASBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIASBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:01:53 -0400
Received: from holomorphy.com ([207.189.100.168]:7879 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267381AbUIAR7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:59:21 -0400
Date: Wed, 1 Sep 2004 10:59:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [1/1] rework of Kirill Korotaev's pidhashing patch
Message-ID: <20040901175903.GL5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <kksx@mail.ru>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com> <Pine.LNX.4.58.0409011046450.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409011046450.2295@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:48:21AM -0700, Linus Torvalds wrote:
> Heh. These improvements look fine, but I definitely don't want to first 
> apply the broken one and then improve upon it - it would be much nicer to 
> get this kind of nice "progression" patch that starts off from a clean 
> thing and just improves on it (maybe that ends up meaning just one patch 
> to replace Kirill's, I don't know..)

Address a correctness issue with loop termination in do_each_task_pid()
and while_each_task_pid() as well as various stylistic and macro hygiene
issues with the original. Otherwise unaltered. The description from
Kirill Korotaev's original post is as follows:

"This patch fixes strange and obscure pid implementation in current kernels:
- it removes calling of put_task_struct() from detach_pid()
  under tasklist_lock. This allows to use blocking calls
  in security_task_free() hooks (in __put_task_struct()).
- it saves some space = 5*5 ints = 100 bytes in task_struct
- it's smaller and tidy, more straigthforward and doesn't use
  any knowledge about pids using and assignment.
- it removes pid_links and pid_struct doesn't hold reference counters
  on task_struct. instead, new pid_structs and linked altogether and
  only one of them is inserted in hash_list."

I've only compiletested my changes, though I have strong reasons to
believe they're correct. If Kirill signs off on this, I will too.


Index: kirill-2.6.9-rc1-mm2/drivers/char/tty_io.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/drivers/char/tty_io.c	2004-09-01 08:43:17.112081624 -0700
+++ kirill-2.6.9-rc1-mm2/drivers/char/tty_io.c	2004-09-01 08:44:05.758686216 -0700
@@ -424,7 +424,6 @@
 	struct file * cons_filp = NULL;
 	struct file *filp, *f = NULL;
 	struct task_struct *p;
-	struct pid *pid;
 	int    closecount = 0, n;
 
 	if (!tty)
@@ -487,8 +486,7 @@
 	
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
-		struct list_head *l;
-		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid) {
+		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
 			if (p->signal->tty == tty)
 				p->signal->tty = NULL;
 			if (!p->signal->leader)
@@ -497,7 +495,7 @@
 			send_group_sig_info(SIGCONT, SEND_SIG_PRIV, p);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
-		}
+		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 	}
 	read_unlock(&tasklist_lock);
 
@@ -569,8 +567,6 @@
 {
 	struct tty_struct *tty;
 	struct task_struct *p;
-	struct list_head *l;
-	struct pid *pid;
 	int tty_pgrp = -1;
 
 	lock_kernel();
@@ -599,8 +595,9 @@
 	tty->pgrp = -1;
 
 	read_lock(&tasklist_lock);
-	for_each_task_pid(current->signal->session, PIDTYPE_SID, p, l, pid)
+	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
 		p->signal->tty = NULL;
+	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 	unlock_kernel();
 }
@@ -1252,15 +1249,15 @@
 	 */
 	if (tty_closing || o_tty_closing) {
 		struct task_struct *p;
-		struct list_head *l;
-		struct pid *pid;
 
 		read_lock(&tasklist_lock);
-		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid)
+		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
 			p->signal->tty = NULL;
+		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 		if (o_tty)
-			for_each_task_pid(o_tty->session, PIDTYPE_SID, p,l, pid)
+			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
 				p->signal->tty = NULL;
+			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -1630,8 +1627,6 @@
 
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
-	struct list_head *l;
-	struct pid *pid;
 	task_t *p;
 
 	if (current->signal->leader &&
@@ -1654,8 +1649,9 @@
 			 */
 
 			read_lock(&tasklist_lock);
-			for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid)
+			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
 				p->signal->tty = NULL;
+			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 			read_unlock(&tasklist_lock);
 		} else
 			return -EPERM;
@@ -1962,8 +1958,6 @@
 #else
 	struct tty_struct *tty = arg;
 	struct task_struct *p;
-	struct list_head *l;
-	struct pid *pid;
 	int session;
 	int		i;
 	struct file	*filp;
@@ -1976,7 +1970,7 @@
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
 	read_lock(&tasklist_lock);
-	for_each_task_pid(session, PIDTYPE_SID, p, l, pid) {
+	do_each_task_pid(session, PIDTYPE_SID, p) {
 		if (p->signal->tty == tty || session > 0) {
 			printk(KERN_NOTICE "SAK: killed process %d"
 			    " (%s): p->signal->session==tty->session\n",
@@ -2003,7 +1997,7 @@
 			spin_unlock(&p->files->file_lock);
 		}
 		task_unlock(p);
-	}
+	} while_each_task_pid(session, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 #endif
 }
Index: kirill-2.6.9-rc1-mm2/fs/fcntl.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/fs/fcntl.c	2004-08-24 00:03:13.000000000 -0700
+++ kirill-2.6.9-rc1-mm2/fs/fcntl.c	2004-09-01 08:44:05.767684848 -0700
@@ -497,11 +497,9 @@
 			send_sigio_to_task(p, fown, fd, band);
 		}
 	} else {
-		struct list_head *l;
-		struct pid *pidptr;
-		for_each_task_pid(-pid, PIDTYPE_PGID, p, l, pidptr) {
+		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
 			send_sigio_to_task(p, fown, fd, band);
-		}
+		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
@@ -534,11 +532,9 @@
 			send_sigurg_to_task(p, fown);
 		}
 	} else {
-		struct list_head *l;
-		struct pid *pidptr;
-		for_each_task_pid(-pid, PIDTYPE_PGID, p, l, pidptr) {
+		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
 			send_sigurg_to_task(p, fown);
-		}
+		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
Index: kirill-2.6.9-rc1-mm2/fs/proc/base.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/fs/proc/base.c	2004-09-01 08:43:05.621828408 -0700
+++ kirill-2.6.9-rc1-mm2/fs/proc/base.c	2004-09-01 08:44:05.764685304 -0700
@@ -792,10 +792,9 @@
 	.follow_link	= proc_pid_follow_link
 };
 
-static int pid_alive(struct task_struct *p)
+static inline int pid_alive(struct task_struct *p)
 {
-	BUG_ON(p->pids[PIDTYPE_PID].pidptr != &p->pids[PIDTYPE_PID].pid);
-	return atomic_read(&p->pids[PIDTYPE_PID].pid.count);
+	return p->pids[PIDTYPE_PID].nr != 0;
 }
 
 #define NUMBUF 10
Index: kirill-2.6.9-rc1-mm2/include/linux/pid.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/pid.h	2004-09-01 08:43:15.994251560 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/pid.h	2004-09-01 10:13:28.949357304 -0700
@@ -12,54 +12,48 @@
 
 struct pid
 {
-	/* Try to keep hash_chain in the same cacheline as nr for find_pid */
-	struct hlist_node hash_chain;
+	/* Try to keep pid_chain in the same cacheline as nr for find_pid */
 	int nr;
-	atomic_t count;
-	struct task_struct *task;
-	struct list_head task_list;
-};
-
-struct pid_link
-{
-	struct list_head pid_chain;
-	struct pid *pidptr;
-	struct pid pid;
+	struct hlist_node pid_chain;
+	/* list of pids with the same nr, only one of them is in the hash */
+	struct list_head pid_list;
 };
 
 #define pid_task(elem, type) \
-	list_entry(elem, struct task_struct, pids[type].pid_chain)
+	list_entry(elem, struct task_struct, pids[type].pid_list)
 
 /*
- * attach_pid() and link_pid() must be called with the tasklist_lock
+ * attach_pid() and detach_pid() must be called with the tasklist_lock
  * write-held.
  */
 extern int FASTCALL(attach_pid(struct task_struct *task, enum pid_type type, int nr));
 
-extern void FASTCALL(link_pid(struct task_struct *task, struct pid_link *link, struct pid *pid));
-
-/*
- * detach_pid() must be called with the tasklist_lock write-held.
- */
 extern void FASTCALL(detach_pid(struct task_struct *task, enum pid_type));
 
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
  * held.
  */
-extern struct pid *FASTCALL(find_pid(enum pid_type, int));
+struct pid *FASTCALL(find_pid(enum pid_type, int));
 
 extern int alloc_pidmap(void);
 extern void FASTCALL(free_pidmap(int));
 extern void switch_exec_pids(struct task_struct *leader, struct task_struct *thread);
 
-#define for_each_task_pid(who, type, task, elem, pid)		\
-	if ((pid = find_pid(type, who)))			\
-	        for (elem = pid->task_list.next,			\
-			prefetch(elem->next),				\
-			task = pid_task(elem, type);			\
-			elem != &pid->task_list;			\
-			elem = elem->next, prefetch(elem->next), 	\
-			task = pid_task(elem, type))
+#define do_each_task_pid(who, type, task)				\
+do {									\
+	struct list_head *__list__;					\
+	if ((task = find_task_by_pid_type(type, who))) {		\
+		__list__ = &(task)->pids[type].pid_list;		\
+		prefetch((task)->pids[type].pid_list.next);		\
+		do {
+
+#define while_each_task_pid(who, type, task)				\
+			task = pid_task((task)->pids[type].pid_list.next,\
+						type);			\
+			prefetch((task)->pids[type].pid_list.next);	\
+		} while ((task)->pids[type].pid_list.next != __list__);	\
+	}								\
+} while (0)
 
 #endif /* _LINUX_PID_H */
Index: kirill-2.6.9-rc1-mm2/include/linux/sched.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/sched.h	2004-09-01 08:43:17.894962608 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/sched.h	2004-09-01 09:28:56.542624880 -0700
@@ -503,7 +503,7 @@
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
-	struct pid_link pids[PIDTYPE_MAX];
+	struct pid pids[PIDTYPE_MAX];
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
@@ -695,7 +695,8 @@
 
 extern struct   mm_struct init_mm;
 
-extern struct task_struct *find_task_by_pid(int pid);
+#define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
+extern struct task_struct *find_task_by_pid_type(int type, int pid);
 extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
 
@@ -897,9 +898,7 @@
 
 static inline int thread_group_empty(task_t *p)
 {
-	struct pid *pid = p->pids[PIDTYPE_TGID].pidptr;
-
-	return pid->task_list.next->next == &pid->task_list;
+	return list_empty(&p->pids[PIDTYPE_TGID].pid_list);
 }
 
 #define delay_group_leader(p) \
Index: kirill-2.6.9-rc1-mm2/kernel/capability.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/capability.c	2004-08-24 00:03:13.000000000 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/capability.c	2004-09-01 08:44:05.811678160 -0700
@@ -89,14 +89,12 @@
 			      kernel_cap_t *permitted)
 {
 	task_t *g, *target;
-	struct list_head *l;
-	struct pid *pid;
 
-	for_each_task_pid(pgrp, PIDTYPE_PGID, g, l, pid) {
+	do_each_task_pid(pgrp, PIDTYPE_PGID, g) {
 		target = g;
 		while_each_thread(g, target)
 			security_capset_set(target, effective, inheritable, permitted);
-	}
+	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
 }
 
 /*
Index: kirill-2.6.9-rc1-mm2/kernel/exit.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/exit.c	2004-09-01 08:43:05.660822480 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/exit.c	2004-09-01 08:44:05.787681808 -0700
@@ -128,16 +128,15 @@
 int session_of_pgrp(int pgrp)
 {
 	struct task_struct *p;
-	struct list_head *l;
-	struct pid *pid;
 	int sid = -1;
 
 	read_lock(&tasklist_lock);
-	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid)
+	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
 		if (p->signal->session > 0) {
 			sid = p->signal->session;
 			goto out;
 		}
+	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
 	p = find_task_by_pid(pgrp);
 	if (p)
 		sid = p->signal->session;
@@ -158,11 +157,9 @@
 static int will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
 {
 	struct task_struct *p;
-	struct list_head *l;
-	struct pid *pid;
 	int ret = 1;
 
-	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
+	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
 		if (p == ignored_task
 				|| p->state >= TASK_ZOMBIE 
 				|| p->real_parent->pid == 1)
@@ -172,7 +169,7 @@
 			ret = 0;
 			break;
 		}
-	}
+	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
 	return ret;	/* (sighing) "Often!" */
 }
 
@@ -191,15 +188,13 @@
 {
 	int retval = 0;
 	struct task_struct *p;
-	struct list_head *l;
-	struct pid *pid;
 
-	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
+	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
 		if (p->state != TASK_STOPPED)
 			continue;
 		retval = 1;
 		break;
-	}
+	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
 	return retval;
 }
 
@@ -852,9 +847,6 @@
 
 task_t fastcall *next_thread(const task_t *p)
 {
-	const struct pid_link *link = p->pids + PIDTYPE_TGID;
-	const struct list_head *tmp, *head = &link->pidptr->task_list;
-
 #ifdef CONFIG_SMP
 	if (!p->sighand)
 		BUG();
@@ -862,11 +854,7 @@
 				!rwlock_is_locked(&tasklist_lock))
 		BUG();
 #endif
-	tmp = link->pid_chain.next;
-	if (tmp == head)
-		tmp = head->next;
-
-	return pid_task(tmp, PIDTYPE_TGID);
+	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);
 }
 
 EXPORT_SYMBOL(next_thread);
Index: kirill-2.6.9-rc1-mm2/kernel/fork.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/fork.c	2004-09-01 08:43:26.780611784 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/fork.c	2004-09-01 08:44:05.809678464 -0700
@@ -1011,14 +1011,13 @@
 	cpuset_fork(p);
 
 	attach_pid(p, PIDTYPE_PID, p->pid);
+	attach_pid(p, PIDTYPE_TGID, p->tgid);
 	if (thread_group_leader(p)) {
-		attach_pid(p, PIDTYPE_TGID, p->tgid);
 		attach_pid(p, PIDTYPE_PGID, process_group(p));
 		attach_pid(p, PIDTYPE_SID, p->signal->session);
 		if (p->pid)
 			__get_cpu_var(process_counts)++;
-	} else
-		link_pid(p, p->pids + PIDTYPE_TGID, &p->group_leader->pids[PIDTYPE_TGID].pid);
+	}
 
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
Index: kirill-2.6.9-rc1-mm2/kernel/pid.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/pid.c	2004-09-01 08:43:15.810279528 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/pid.c	2004-09-01 10:17:50.529591064 -0700
@@ -148,70 +148,61 @@
 	return -1;
 }
 
-fastcall struct pid *find_pid(enum pid_type type, int nr)
+struct pid * fastcall find_pid(enum pid_type type, int nr)
 {
 	struct hlist_node *elem;
 	struct pid *pid;
 
 	hlist_for_each_entry(pid, elem,
-			&pid_hash[type][pid_hashfn(nr)], hash_chain) {
+			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
 		if (pid->nr == nr)
 			return pid;
 	}
 	return NULL;
 }
 
-void fastcall link_pid(task_t *task, struct pid_link *link, struct pid *pid)
-{
-	atomic_inc(&pid->count);
-	list_add_tail(&link->pid_chain, &pid->task_list);
-	link->pidptr = pid;
-}
-
 int fastcall attach_pid(task_t *task, enum pid_type type, int nr)
 {
-	struct pid *pid = find_pid(type, nr);
+	struct pid *pid, *task_pid;
 
-	if (pid)
-		atomic_inc(&pid->count);
-	else {
-		pid = &task->pids[type].pid;
-		pid->nr = nr;
-		atomic_set(&pid->count, 1);
-		INIT_LIST_HEAD(&pid->task_list);
-		pid->task = task;
-		get_task_struct(task);
-		hlist_add_head(&pid->hash_chain,
+	task_pid = &task->pids[type];
+	pid = find_pid(type, nr);
+	if (pid == NULL) {
+		hlist_add_head(&task_pid->pid_chain,
 				&pid_hash[type][pid_hashfn(nr)]);
+		INIT_LIST_HEAD(&task_pid->pid_list);
+	} else {
+		INIT_HLIST_NODE(&task_pid->pid_chain);
+		list_add_tail(&task_pid->pid_list, &pid->pid_list);
 	}
-	list_add_tail(&task->pids[type].pid_chain, &pid->task_list);
-	task->pids[type].pidptr = pid;
+	task_pid->nr = nr;
 
 	return 0;
 }
 
 static inline int __detach_pid(task_t *task, enum pid_type type)
 {
-	struct pid_link *link = task->pids + type;
-	struct pid *pid = link->pidptr;
+	struct pid *pid, *pid_next;
 	int nr;
 
-	list_del(&link->pid_chain);
-	if (!atomic_dec_and_test(&pid->count))
-		return 0;
-
+	pid = &task->pids[type];
+	if (!hlist_unhashed(&pid->pid_chain)) {
+		hlist_del(&pid->pid_chain);
+		if (!list_empty(&pid->pid_list)) {
+			pid_next = list_entry(pid->pid_list.next,
+						struct pid, pid_list);
+			/* insert next pid from pid_list to hash */
+			hlist_add_head(&pid_next->pid_chain,
+				&pid_hash[type][pid_hashfn(pid_next->nr)]);
+		}
+	}
+	list_del(&pid->pid_list);
 	nr = pid->nr;
-	hlist_del(&pid->hash_chain);
-	put_task_struct(pid->task);
+	pid->nr = 0;
 
 	return nr;
 }
 
-static void _detach_pid(task_t *task, enum pid_type type)
-{
-	__detach_pid(task, type);
-}
-
 void fastcall detach_pid(task_t *task, enum pid_type type)
 {
 	int nr = __detach_pid(task, type);
@@ -225,16 +216,16 @@
 	free_pidmap(nr);
 }
 
-task_t *find_task_by_pid(int nr)
+task_t *find_task_by_pid_type(int type, int nr)
 {
-	struct pid *pid = find_pid(PIDTYPE_PID, nr);
+	struct pid *pid = find_pid(type, nr);
 
-	if (!pid)
-		return NULL;
-	return pid_task(pid->task_list.next, PIDTYPE_PID);
+	if (pid)
+		return pid_task(&pid->pid_list, type);
+	return NULL;
 }
 
-EXPORT_SYMBOL(find_task_by_pid);
+EXPORT_SYMBOL(find_task_by_pid_type);
 
 /*
  * This function switches the PIDs if a non-leader thread calls
@@ -243,13 +234,13 @@
  */
 void switch_exec_pids(task_t *leader, task_t *thread)
 {
-	_detach_pid(leader, PIDTYPE_PID);
-	_detach_pid(leader, PIDTYPE_TGID);
-	_detach_pid(leader, PIDTYPE_PGID);
-	_detach_pid(leader, PIDTYPE_SID);
+	__detach_pid(leader, PIDTYPE_PID);
+	__detach_pid(leader, PIDTYPE_TGID);
+	__detach_pid(leader, PIDTYPE_PGID);
+	__detach_pid(leader, PIDTYPE_SID);
 
-	_detach_pid(thread, PIDTYPE_PID);
-	_detach_pid(thread, PIDTYPE_TGID);
+	__detach_pid(thread, PIDTYPE_PID);
+	__detach_pid(thread, PIDTYPE_TGID);
 
 	leader->pid = leader->tgid = thread->pid;
 	thread->pid = thread->tgid;
Index: kirill-2.6.9-rc1-mm2/kernel/signal.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/signal.c	2004-09-01 08:43:00.334632184 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/signal.c	2004-09-01 08:44:05.803679376 -0700
@@ -1115,8 +1115,6 @@
 int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
 {
 	struct task_struct *p;
-	struct list_head *l;
-	struct pid *pid;
 	int retval, success;
 
 	if (pgrp <= 0)
@@ -1124,11 +1122,11 @@
 
 	success = 0;
 	retval = -ESRCH;
-	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
+	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
 		int err = group_send_sig_info(sig, info, p);
 		success |= !err;
 		retval = err;
-	}
+	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
 	return success ? 0 : retval;
 }
 
@@ -1155,8 +1153,6 @@
 kill_sl_info(int sig, struct siginfo *info, pid_t sid)
 {
 	int err, retval = -EINVAL;
-	struct pid *pid;
-	struct list_head *l;
 	struct task_struct *p;
 
 	if (sid <= 0)
@@ -1164,13 +1160,13 @@
 
 	retval = -ESRCH;
 	read_lock(&tasklist_lock);
-	for_each_task_pid(sid, PIDTYPE_SID, p, l, pid) {
+	do_each_task_pid(sid, PIDTYPE_SID, p) {
 		if (!p->signal->leader)
 			continue;
 		err = group_send_sig_info(sig, info, p);
 		if (retval)
 			retval = err;
-	}
+	} while_each_task_pid(sid, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 out:
 	return retval;
Index: kirill-2.6.9-rc1-mm2/kernel/sys.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/sys.c	2004-09-01 08:43:03.059217984 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/sys.c	2004-09-01 09:29:03.608550696 -0700
@@ -320,8 +320,6 @@
 {
 	struct task_struct *g, *p;
 	struct user_struct *user;
-	struct pid *pid;
-	struct list_head *l;
 	int error = -EINVAL;
 
 	if (which > 2 || which < 0)
@@ -346,8 +344,9 @@
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
-			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid)
+			do_each_task_pid(who, PIDTYPE_PGID, p) {
 				error = set_one_prio(p, niceval, error);
+			} while_each_task_pid(who, PIDTYPE_PGID, p);
 			break;
 		case PRIO_USER:
 			if (!who)
@@ -381,8 +380,6 @@
 asmlinkage long sys_getpriority(int which, int who)
 {
 	struct task_struct *g, *p;
-	struct list_head *l;
-	struct pid *pid;
 	struct user_struct *user;
 	long niceval, retval = -ESRCH;
 
@@ -404,11 +401,11 @@
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
-			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid) {
+			do_each_task_pid(who, PIDTYPE_PGID, p) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
-			}
+			} while_each_task_pid(who, PIDTYPE_PGID, p);
 			break;
 		case PRIO_USER:
 			if (!who)
@@ -1086,12 +1083,11 @@
 
 	if (pgid != pid) {
 		struct task_struct *p;
-		struct pid *pid;
-		struct list_head *l;
 
-		for_each_task_pid(pgid, PIDTYPE_PGID, p, l, pid)
+		do_each_task_pid(pgid, PIDTYPE_PGID, p) {
 			if (p->signal->session == current->signal->session)
 				goto ok_pgid;
+		} while_each_task_pid(pgid, PIDTYPE_PGID, p);
 		goto out;
 	}
 
