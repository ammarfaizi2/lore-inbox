Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWCGNOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWCGNOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWCGNOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:14:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60120 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751100AbWCGNOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:14:19 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
	<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
	<440CA459.6627024C@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 06:12:18 -0700
In-Reply-To: <440CA459.6627024C@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 07 Mar 2006 00:06:33 +0300")
Message-ID: <m1fylu2ybx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Horrible incremental patch...

Ok.  I just threw this together and it seems to work..

I need to head to back to bed, but I figured since I got
this to boot successfully that I would throw this out
so someone could look at it while I sleep.

This patch is way to big and ugly to go in like this and
it would probably make even more sense if it would
simply replace part of what is in the -mm tree.  
Andrew any suggestions?

There is a neat trick in here for implementing an
rcu findable data structure that is also reference
counted, that allows the reference count to be safely
incremented without a lock.

Oleg anyway you can now look and see how I have butchered
your great idea :)

Eric



---

 drivers/char/tty_io.c   |   29 ++++---
 fs/exec.c               |    2 -
 fs/fcntl.c              |   10 ++-
 fs/ioprio.c             |   10 ++-
 fs/proc/base.c          |   17 +++-
 fs/proc/inode.c         |    4 +
 fs/proc/internal.h      |    7 +-
 fs/proc/task_mmu.c      |    4 +
 include/linux/pid.h     |   43 ++++++-----
 include/linux/proc_fs.h |    4 +
 include/linux/sched.h   |    4 +
 kernel/Makefile         |    2 -
 kernel/capability.c     |    5 +
 kernel/cpuset.c         |   11 +--
 kernel/exit.c           |   25 ++++--
 kernel/fork.c           |   23 +++---
 kernel/pid.c            |  186 +++++++++++++++++++++++++++--------------------
 kernel/signal.c         |    5 +
 kernel/sys.c            |   17 +++-
 19 files changed, 226 insertions(+), 182 deletions(-)

e5062e605992e32e15a75eade0fee34c8355353a
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index dc8d79d..7433c2a 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1092,7 +1092,8 @@ static void do_tty_hangup(void *data)
 	
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+		struct pid *pid;
+		for_each_task_pid(tty->session, PIDTYPE_SID, p, pid) {
 			if (p->signal->tty == tty)
 				p->signal->tty = NULL;
 			if (!p->signal->leader)
@@ -1101,7 +1102,7 @@ static void do_tty_hangup(void *data)
 			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+		}
 	}
 	read_unlock(&tasklist_lock);
 
@@ -1184,6 +1185,7 @@ void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty;
 	struct task_struct *p;
+	struct pid *pid;
 	int tty_pgrp = -1;
 
 	lock_kernel();
@@ -1218,9 +1220,9 @@ void disassociate_ctty(int on_exit)
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
-	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
+	for_each_task_pid(current->signal->session, PIDTYPE_SID, p, pid) {
 		p->signal->tty = NULL;
-	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
+	}
 	read_unlock(&tasklist_lock);
 	mutex_unlock(&tty_mutex);
 	unlock_kernel();
@@ -1922,15 +1924,16 @@ static void release_dev(struct file * fi
 	 */
 	if (tty_closing || o_tty_closing) {
 		struct task_struct *p;
+		struct pid *pid;
 
 		read_lock(&tasklist_lock);
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+		for_each_task_pid(tty->session, PIDTYPE_SID, p, pid) {
 			p->signal->tty = NULL;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+		}
 		if (o_tty)
-			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
+			for_each_task_pid(o_tty->session, PIDTYPE_SID, p, pid) {
 				p->signal->tty = NULL;
-			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
+			}
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2358,14 +2361,15 @@ static int tiocsctty(struct tty_struct *
 		 * tty for another session group!
 		 */
 		if ((arg == 1) && capable(CAP_SYS_ADMIN)) {
+			struct pid *pid;
 			/*
 			 * Steal it away
 			 */
 
 			read_lock(&tasklist_lock);
-			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+			for_each_task_pid(tty->session, PIDTYPE_SID, p, pid) {
 				p->signal->tty = NULL;
-			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+			}
 			read_unlock(&tasklist_lock);
 		} else
 			return -EPERM;
@@ -2680,6 +2684,7 @@ static void __do_SAK(void *arg)
 	int		i;
 	struct file	*filp;
 	struct tty_ldisc *disc;
+	struct pid *pid;
 	struct fdtable *fdt;
 	
 	if (!tty)
@@ -2698,12 +2703,12 @@ static void __do_SAK(void *arg)
 	rcu_read_lock();
 	read_lock(&tasklist_lock);
 	/* Kill the entire session */
-	do_each_task_pid(session, PIDTYPE_SID, p) {
+	for_each_task_pid(session, PIDTYPE_SID, p, pid) {
 		printk(KERN_NOTICE "SAK: killed process %d"
 			" (%s): p->signal->session==tty->session\n",
 			p->pid, p->comm);
 		send_sig(SIGKILL, p, 1);
-	} while_each_task_pid(session, PIDTYPE_SID, p);
+	}
 	/* Now kill any processes that happen to have the
 	 * tty open.
 	 */
diff --git a/fs/exec.c b/fs/exec.c
index d961639..c7fe6e8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -708,7 +708,7 @@ static int de_thread(struct task_struct 
 		 * Note: The old leader also uses thispid until release_task
 		 *       is called.  Odd but simple and correct.
 		 */
-		detach_pid(current, PIDTYPE_PID);
+		detach_pid(current, PIDTYPE_PID, current->pid);
 		current->pid = leader->pid;
 		attach_pid(current, PIDTYPE_PID,  current->pid);
 		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 03c7895..deb4ca7 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -485,9 +485,10 @@ void send_sigio(struct fown_struct *fown
 			send_sigio_to_task(p, fown, fd, band);
 		}
 	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
+		struct pid *pidp;
+		for_each_task_pid(-pid, PIDTYPE_PGID, p, pidp) {
 			send_sigio_to_task(p, fown, fd, band);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
+		}
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
@@ -520,9 +521,10 @@ int send_sigurg(struct fown_struct *fown
 			send_sigurg_to_task(p, fown);
 		}
 	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
+		struct pid *pidp;
+		for_each_task_pid(-pid, PIDTYPE_PGID, p, pidp) {
 			send_sigurg_to_task(p, fown);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
+		}
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
diff --git a/fs/ioprio.c b/fs/ioprio.c
index ca77008..96e4044 100644
--- a/fs/ioprio.c
+++ b/fs/ioprio.c
@@ -51,6 +51,7 @@ asmlinkage long sys_ioprio_set(int which
 	int data = IOPRIO_PRIO_DATA(ioprio);
 	struct task_struct *p, *g;
 	struct user_struct *user;
+	struct pid *pid;
 	int ret;
 
 	switch (class) {
@@ -85,11 +86,11 @@ asmlinkage long sys_ioprio_set(int which
 		case IOPRIO_WHO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			for_each_task_pid(who, PIDTYPE_PGID, p, pid) {
 				ret = set_task_ioprio(p, ioprio);
 				if (ret)
 					break;
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			}
 			break;
 		case IOPRIO_WHO_USER:
 			if (!who)
@@ -123,6 +124,7 @@ asmlinkage long sys_ioprio_get(int which
 {
 	struct task_struct *g, *p;
 	struct user_struct *user;
+	struct pid *pid;
 	int ret = -ESRCH;
 
 	read_lock_irq(&tasklist_lock);
@@ -138,12 +140,12 @@ asmlinkage long sys_ioprio_get(int which
 		case IOPRIO_WHO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			for_each_task_pid(who, PIDTYPE_PGID, p, pid) {
 				if (ret == -ESRCH)
 					ret = p->ioprio;
 				else
 					ret = ioprio_best(ret, p->ioprio);
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			}
 			break;
 		case IOPRIO_WHO_USER:
 			if (!who)
diff --git a/fs/proc/base.c b/fs/proc/base.c
index dc70dfc..67383a6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -908,7 +908,7 @@ static ssize_t proc_loginuid_write(struc
 	if (!capable(CAP_AUDIT_CONTROL))
 		return -EPERM;
 
-	if (current != proc_tref(inode)->task)
+	if (current != pid_task(proc_pid(inode)), PIDTYPE_PID)
 		return -EPERM;
 
 	if (count > PAGE_SIZE)
@@ -1264,10 +1264,13 @@ static struct inode *proc_pid_make_inode
 	/*
 	 * grab the reference to task.
 	 */
-	ei->tref = tref_get_by_task(task);
-	if (!tref_task(ei->tref))
+	rcu_read_lock();
+	if (pid_alive(task))
+		ei->pid = get_pid(find_pid(task->pid));
+	rcu_read_unlock();
+	if (!ei->pid)
 		goto out_unlock;
-
+	
 	inode->i_uid = 0;
 	inode->i_gid = 0;
 	if (task_dumpable(task)) {
@@ -1349,11 +1352,15 @@ static int tid_fd_revalidate(struct dent
 
 static int pid_delete_dentry(struct dentry * dentry)
 {
+	struct task_struct *task;
 	/* Is the task we represent dead?
 	 * If so, then don't put the dentry on the lru list,
 	 * kill it immediately.
 	 */
-	return !proc_tref(dentry->d_inode)->task;
+	rcu_read_lock();
+	task = pid_task(proc_pid(dentry->d_inode), PIDTYPE_PID);
+	rcu_read_unlock();
+	return !task;
 }
 
 static struct dentry_operations tid_fd_dentry_operations =
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 31e0475..6dcef08 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -62,7 +62,7 @@ static void proc_delete_inode(struct ino
 	truncate_inode_pages(&inode->i_data, 0);
 
 	/* Stop tracking associated processes */
-	tref_put(PROC_I(inode)->tref);
+	put_pid(PROC_I(inode)->pid);
 
 	/* Let go of any associated proc directory entry */
 	de = PROC_I(inode)->pde;
@@ -91,7 +91,7 @@ static struct inode *proc_alloc_inode(st
 	ei = (struct proc_inode *)kmem_cache_alloc(proc_inode_cachep, SLAB_KERNEL);
 	if (!ei)
 		return NULL;
-	ei->tref = NULL;
+	ei->pid = NULL;
 	ei->fd = 0;
 	ei->op.proc_get_link = NULL;
 	ei->pde = NULL;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 37f1648..146a434 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -10,7 +10,6 @@
  */
 
 #include <linux/proc_fs.h>
-#include <linux/task_ref.h>
 
 struct vmalloc_info {
 	unsigned long	used;
@@ -51,14 +50,14 @@ void free_proc_entry(struct proc_dir_ent
 
 int proc_init_inodecache(void);
 
-static inline struct task_ref *proc_tref(struct inode *inode)
+static inline struct pid *proc_pid(struct inode *inode)
 {
-	return PROC_I(inode)->tref;
+	return PROC_I(inode)->pid;
 }
 
 static inline struct task_struct *get_proc_task(struct inode *inode)
 {
-	return get_tref_task(proc_tref(inode));
+	return get_pid_task(proc_pid(inode), PIDTYPE_PID);
 }
 
 static inline int proc_fd(struct inode *inode)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0491eb7..11592dc 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -320,7 +320,7 @@ static void *m_start(struct seq_file *m,
 	if (last_addr == -1UL)
 		return NULL;
 
-	priv->task = get_tref_task(priv->tref);
+	priv->task = get_pid_task(priv->pid, PIDTYPE_PID);
 	if (!priv->task)
 		return NULL;
 
@@ -416,7 +416,7 @@ static int do_maps_open(struct inode *in
 	int ret = -ENOMEM;
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv) {
-		priv->tref = proc_tref(inode);
+		priv->pid = proc_pid(inode);
 		ret = seq_open(file, ops);
 		if (!ret) {
 			struct seq_file *m = file->private_data;
diff --git a/include/linux/pid.h b/include/linux/pid.h
index da5cd89..11992c1 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
-struct task_ref;
+#include <linux/rcupdate.h>
 
 enum pid_type
 {
@@ -13,17 +13,25 @@ enum pid_type
 
 struct pid
 {
+	atomic_t count;
 	/* Try to keep pid_chain in the same cacheline as nr for find_pid */
 	int nr;
 	struct hlist_node pid_chain;
 	/* list of pids with the same nr, only one of them is in the hash */
-	struct list_head pid_list;
-	/* Does a weak reference of this type exist to the task struct? */
-	struct task_ref *tref;
+	struct list_head tasks[PIDTYPE_MAX];
+	struct rcu_head rcu;
 };
 
-#define pid_task(elem, type) \
-	list_entry(elem, struct task_struct, pids[type].pid_list)
+static inline struct pid *get_pid(struct pid *pid)
+{
+	if (pid)
+		atomic_inc(&pid->count);
+	return pid;
+}
+
+extern void FASTCALL(put_pid(struct pid *pid));
+extern struct task_struct *FASTCALL(pid_task(struct pid *pid, enum pid_type type));
+extern struct task_struct *FASTCALL(get_pid_task(struct pid *pid, enum pid_type type));
 
 /*
  * attach_pid() and detach_pid() must be called with the tasklist_lock
@@ -31,30 +39,23 @@ struct pid
  */
 extern int FASTCALL(attach_pid(struct task_struct *task, enum pid_type type, int nr));
 
-extern void FASTCALL(detach_pid(struct task_struct *task, enum pid_type));
+extern void FASTCALL(detach_pid(struct task_struct *task, enum pid_type, int nr));
 
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
  * held.
  */
-extern struct pid *FASTCALL(find_pid(enum pid_type, int));
+extern struct pid *FASTCALL(find_pid(int nr));
 
 extern struct task_struct *find_task_by_pid_type(int type, int pid);
 #define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
 
-extern int alloc_pidmap(void);
-extern void FASTCALL(free_pidmap(int));
+extern struct pid *alloc_pid(void);
+extern void FASTCALL(free_pid(struct pid *pid));
+
+#define for_each_task_pid(who, type, task, pid)	\
+	if ((pid = find_pid(who)))		\
+		list_for_each_entry_rcu(task, &pid->tasks[type], pid_list[type])
 
-#define do_each_task_pid(who, type, task)				\
-	if ((task = find_task_by_pid_type(type, who))) {		\
-		prefetch((task)->pids[type].pid_list.next);		\
-		do {
-
-#define while_each_task_pid(who, type, task)				\
-		} while (task = pid_task((task)->pids[type].pid_list.next,\
-						type),			\
-			prefetch((task)->pids[type].pid_list.next),	\
-			hlist_unhashed(&(task)->pids[type].pid_chain));	\
-	}								\
 
 #endif /* _LINUX_PID_H */
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 7f5a400..b5fc62f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -247,7 +247,7 @@ extern void kclist_add(struct kcore_list
 #endif
 
 struct proc_inode {
-	struct task_ref *tref;
+	struct pid *pid;
 	int fd;
 	union {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
@@ -268,7 +268,7 @@ static inline struct proc_dir_entry *PDE
 }
 
 struct proc_maps_private {
-	struct task_ref *tref;
+	struct pid *pid;
 	struct task_struct *task;
 	struct vm_area_struct *tail_vma;
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7e2500c..a54e2c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -764,7 +764,7 @@ struct task_struct {
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
-	struct pid pids[PIDTYPE_MAX];
+	struct list_head pid_list[PIDTYPE_MAX];
 	struct list_head threads;
 
 	struct completion *vfork_done;		/* for vfork() */
@@ -902,7 +902,7 @@ static inline pid_t process_group(struct
  */
 static inline int pid_alive(struct task_struct *p)
 {
-	return p->pids[PIDTYPE_PID].pid_list.prev != LIST_POISON2;
+	return p->pid_list[PIDTYPE_PID].prev != LIST_POISON2;
 }
 
 extern void free_task(struct task_struct *tsk);
diff --git a/kernel/Makefile b/kernel/Makefile
index 1905c80..3401e54 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -5,7 +5,7 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o pid.o task_ref.o \
+	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o
diff --git a/kernel/capability.c b/kernel/capability.c
index bfa3c92..adae2ab 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -97,10 +97,11 @@ static inline int cap_set_pg(int pgrp, k
 			      kernel_cap_t *permitted)
 {
 	task_t *g, *target;
+	struct pid *pid;
 	int ret = -EPERM;
 	int found = 0;
 
-	do_each_task_pid(pgrp, PIDTYPE_PGID, g) {
+	for_each_task_pid(pgrp, PIDTYPE_PGID, g, pid) {
 		target = g;
 		while_each_thread(g, target) {
 			if (!security_capset_check(target, effective,
@@ -113,7 +114,7 @@ static inline int cap_set_pg(int pgrp, k
 			}
 			found = 1;
 		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
+	}
 
 	if (!found)
 	     ret = 0;
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index d81dd44..fb2ddd1 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -49,7 +49,6 @@
 #include <linux/time.h>
 #include <linux/backing-dev.h>
 #include <linux/sort.h>
-#include <linux/task_ref.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
@@ -2380,7 +2379,7 @@ void __cpuset_memory_pressure_bump(void)
 static int proc_cpuset_show(struct seq_file *m, void *v)
 {
 	struct cpuset *cs;
-	struct task_ref *tref;
+	struct pid *pid;
 	struct task_struct *tsk;
 	char *buf;
 	int retval;
@@ -2391,8 +2390,8 @@ static int proc_cpuset_show(struct seq_f
 		goto out;
 
 	retval = -ESRCH;
-	tref = m->private;
-	tsk = get_tref_task(tref);
+	pid = m->private;
+	tsk = get_pid_task(pid, PIDTYPE_PID);
 	if (!tsk)
 		goto out_free;
 
@@ -2418,8 +2417,8 @@ out:
 
 static int cpuset_open(struct inode *inode, struct file *file)
 {
-	struct task_ref *tref = PROC_I(inode)->tref;
-	return single_open(file, proc_cpuset_show, tref);
+	struct pid *pid = PROC_I(inode)->pid;
+	return single_open(file, proc_cpuset_show, pid);
 }
 
 struct file_operations proc_cpuset_operations = {
diff --git a/kernel/exit.c b/kernel/exit.c
index df406fe..e69c6d8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -50,11 +50,11 @@ static void exit_mm(struct task_struct *
 static void __unhash_process(struct task_struct *p)
 {
 	nr_threads--;
-	detach_pid(p, PIDTYPE_PID);
+	detach_pid(p, PIDTYPE_PID, p->pid);
 	list_del_rcu(&p->threads);
 	if (thread_group_leader(p)) {
-		detach_pid(p, PIDTYPE_PGID);
-		detach_pid(p, PIDTYPE_SID);
+		detach_pid(p, PIDTYPE_PGID, p->signal->pgrp);
+		detach_pid(p, PIDTYPE_SID,  p->signal->session);
 
 		list_del_init(&p->tasks);
 		__get_cpu_var(process_counts)--;
@@ -178,15 +178,16 @@ repeat:
 int session_of_pgrp(int pgrp)
 {
 	struct task_struct *p;
+	struct pid *pid;
 	int sid = -1;
 
 	read_lock(&tasklist_lock);
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, pid) {
 		if (p->signal->session > 0) {
 			sid = p->signal->session;
 			goto out;
 		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	}
 	p = find_task_by_pid(pgrp);
 	if (p)
 		sid = p->signal->session;
@@ -207,9 +208,10 @@ out:
 static int will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
 {
 	struct task_struct *p;
+	struct pid *pid;
 	int ret = 1;
 
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, pid) {
 		if (p == ignored_task
 				|| p->exit_state
 				|| p->real_parent->pid == 1)
@@ -219,7 +221,7 @@ static int will_become_orphaned_pgrp(int
 			ret = 0;
 			break;
 		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	}
 	return ret;	/* (sighing) "Often!" */
 }
 
@@ -238,8 +240,9 @@ static int has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
 	struct task_struct *p;
+	struct pid *pid;
 
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, pid) {
 		if (p->state != TASK_STOPPED)
 			continue;
 
@@ -255,7 +258,7 @@ static int has_stopped_jobs(int pgrp)
 
 		retval = 1;
 		break;
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	}
 	return retval;
 }
 
@@ -305,12 +308,12 @@ void __set_special_pids(pid_t session, p
 	struct task_struct *curr = current->group_leader;
 
 	if (curr->signal->session != session) {
-		detach_pid(curr, PIDTYPE_SID);
+		detach_pid(curr, PIDTYPE_SID, curr->signal->session);
 		curr->signal->session = session;
 		attach_pid(curr, PIDTYPE_SID, session);
 	}
 	if (process_group(curr) != pgrp) {
-		detach_pid(curr, PIDTYPE_PGID);
+		detach_pid(curr, PIDTYPE_PGID, curr->signal->pgrp);
 		curr->signal->pgrp = pgrp;
 		attach_pid(curr, PIDTYPE_PGID, pgrp);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index eb5e7ec..0144135 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -172,7 +172,6 @@ void __init fork_init(unsigned long memp
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
-	int type;
 	struct task_struct *tsk;
 	struct thread_info *ti;
 
@@ -196,11 +195,7 @@ static struct task_struct *dup_task_stru
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
 	tsk->btrace_seq = 0;
-	/* Initially there are no weak references to this task */
-	for (type = 0; type < PIDTYPE_MAX; type++) {
-		tsk->pids[type].nr = 0;
-		tsk->pids[type].tref = NULL;
-	}
+
 	return tsk;
 }
 
@@ -1332,17 +1327,19 @@ long do_fork(unsigned long clone_flags,
 {
 	struct task_struct *p;
 	int trace = 0;
-	long pid = alloc_pidmap();
+	struct pid *pid = alloc_pid();
+	long nr;
 
-	if (pid < 0)
+	if (!pid)
 		return -EAGAIN;
+	nr = pid->nr;
 	if (unlikely(current->ptrace)) {
 		trace = fork_traceflag (clone_flags);
 		if (trace)
 			clone_flags |= CLONE_PTRACE;
 	}
 
-	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, pid);
+	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, nr);
 	/*
 	 * Do this prior waking up the new thread - the thread pointer
 	 * might get invalid after that point, if the thread exits quickly.
@@ -1369,7 +1366,7 @@ long do_fork(unsigned long clone_flags,
 			p->state = TASK_STOPPED;
 
 		if (unlikely (trace)) {
-			current->ptrace_message = pid;
+			current->ptrace_message = nr;
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}
 
@@ -1379,10 +1376,10 @@ long do_fork(unsigned long clone_flags,
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
 	} else {
-		free_pidmap(pid);
-		pid = PTR_ERR(p);
+		free_pid(pid);
+		nr = PTR_ERR(p);
 	}
-	return pid;
+	return nr;
 }
 
 #ifndef ARCH_MIN_MMSTRUCT_ALIGN
diff --git a/kernel/pid.c b/kernel/pid.c
index a3cc593..4875fc6 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -27,11 +27,11 @@
 #include <linux/kgdb.h>
 #include <linux/bootmem.h>
 #include <linux/hash.h>
-#include <linux/task_ref.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
-static struct hlist_head *pid_hash[PIDTYPE_MAX];
+static struct hlist_head *pid_hash;
 static int pidhash_shift;
+static kmem_cache_t *pid_cachep;
 
 int pid_max = PID_MAX_DEFAULT;
 int last_pid;
@@ -64,7 +64,7 @@ static pidmap_t pidmap_array[PIDMAP_ENTR
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
 
-fastcall void free_pidmap(int pid)
+static fastcall void free_pidmap(int pid)
 {
 	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
 	int offset = pid & BITS_PER_PAGE_MASK;
@@ -73,7 +73,7 @@ fastcall void free_pidmap(int pid)
 	atomic_inc(&map->nr_free);
 }
 
-int alloc_pidmap(void)
+static int alloc_pidmap(void)
 {
 	int i, offset, max_scan, pid, last = last_pid;
 	pidmap_t *map;
@@ -133,13 +133,68 @@ int alloc_pidmap(void)
 	return -1;
 }
 
-struct pid * fastcall find_pid(enum pid_type type, int nr)
+fastcall void put_pid(struct pid *pid)
+{
+	if (!pid)
+		return;
+	if ((atomic_read(&pid->count) == 1) ||
+	     atomic_dec_and_test(&pid->count))
+		kmem_cache_free(pid_cachep, pid);
+}
+
+static void rcu_put_pid(struct rcu_head *rhp)
+{
+	struct pid *pid = container_of(rhp, struct pid, rcu);
+	put_pid(pid);
+}
+
+fastcall void free_pid(struct pid *pid)
+{
+	spin_lock(&pidmap_lock);
+	hlist_del_rcu(&pid->pid_chain);
+	spin_unlock(&pidmap_lock);
+
+	free_pidmap(pid->nr);
+	call_rcu(&pid->rcu, rcu_put_pid);
+}
+
+struct pid *alloc_pid(void)
+{
+	struct pid *pid;
+	enum pid_type type;
+	int nr = -1;
+
+	pid = kmem_cache_alloc(pid_cachep, GFP_KERNEL);
+	if (!pid)
+		goto out;
+	
+	for (type = 0; type < PIDTYPE_MAX; ++type)
+		INIT_LIST_HEAD(&pid->tasks[type]);
+	
+	nr = alloc_pidmap();
+	if (nr < 0)
+		goto out_free;
+
+	atomic_set(&pid->count, 1);
+	pid->nr = nr;
+	spin_lock(&pidmap_lock);
+	hlist_add_head_rcu(&pid->pid_chain, &pid_hash[pid_hashfn(pid->nr)]);
+	spin_unlock(&pidmap_lock);
+out:
+	return pid;
+out_free:
+	kmem_cache_free(pid_cachep, pid);
+	pid = NULL;
+	goto out;
+}
+
+struct pid * fastcall find_pid(int nr)
 {
 	struct hlist_node *elem;
 	struct pid *pid;
 
 	hlist_for_each_entry_rcu(pid, elem,
-			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
+			&pid_hash[pid_hashfn(nr)], pid_chain) {
 		WARN_ON(!pid->nr); /* to be removed soon */
 		if (pid->nr == nr)
 			return pid;
@@ -149,93 +204,60 @@ struct pid * fastcall find_pid(enum pid_
 
 int fastcall attach_pid(task_t *task, enum pid_type type, int nr)
 {
-	struct pid *pid, *task_pid;
+	struct pid *pid;
 
 	WARN_ON(!task->pid); /* to be removed soon */
 	WARN_ON(!nr); /* to be removed soon */
 
-	task_pid = &task->pids[type];
-	pid = find_pid(type, nr);
-	task_pid->nr = nr;
-	task_pid->tref = NULL;
-	if (pid == NULL) {
-		INIT_LIST_HEAD(&task_pid->pid_list);
-		hlist_add_head_rcu(&task_pid->pid_chain,
-				   &pid_hash[type][pid_hashfn(nr)]);
-	} else {
-		INIT_HLIST_NODE(&task_pid->pid_chain);
-		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
-	}
+	pid = find_pid(nr);
+	list_add_tail_rcu(&task->pid_list[type], &pid->tasks[type]);
 
 	return 0;
 }
 
-static fastcall int __detach_pid(task_t *task, enum pid_type type)
+void fastcall detach_pid(task_t *task, enum pid_type type, int nr)
 {
-	task_t *task_next;
-	struct pid *pid, *pid_next;
-	struct task_ref *tref;
-	int nr = 0;
-
-	pid = &task->pids[type];
-	tref = pid->tref;
-	pid->tref = NULL;
-	if (!hlist_unhashed(&pid->pid_chain)) {
-
-		if (list_empty(&pid->pid_list)) {
-			if (tref)
-				tref->task = NULL;
-			nr = pid->nr;
-			hlist_del_rcu(&pid->pid_chain);
-		} else {
-			task_next = pid_task(pid->pid_list.next, type);
-			pid_next = list_entry(pid->pid_list.next,
-						struct pid, pid_list);
-			pid_next->tref = tref_get(tref);
-			/* insert next pid from pid_list to hash */
-			hlist_replace_rcu(&pid->pid_chain,
-					  &pid_next->pid_chain);
-			/* Update the reference to point at the next task */
-			if (tref)
-				rcu_assign_pointer(tref->task, task_next);
-		}
-	}
+	struct pid *pid;
 
-	list_del_rcu(&pid->pid_list);
-	tref_put(tref);
-	pid->nr = 0;
+	list_del_rcu(&task->pid_list[type]);
 
-	return nr;
+	pid = find_pid(nr);
+	for (type = 0; type < PIDTYPE_MAX; ++type)
+		if (!list_empty(&pid->tasks[type]))
+			return;
+	
+	free_pid(pid);
 }
 
-void fastcall detach_pid(task_t *task, enum pid_type type)
+struct task_struct * fastcall pid_task(struct pid *pid, enum pid_type type)
 {
-	int tmp, nr;
-
-	nr = __detach_pid(task, type);
-	if (!nr)
-		return;
-
-	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
-		if (tmp != type && find_pid(tmp, nr))
-			return;
-
-	free_pidmap(nr);
+	struct task_struct *result = NULL;
+	if (pid) {
+		struct list_head *list, *next;
+		list = rcu_dereference(&pid->tasks[type]);
+		next = rcu_dereference(list->next);
+		if (list != next)
+			result = list_entry(next, struct task_struct, pid_list[type]);
+	}
+	return result;
 }
 
 task_t *find_task_by_pid_type(int type, int nr)
 {
-	struct pid *pid;
-
-	pid = find_pid(type, nr);
-	if (!pid)
-		return NULL;
-
-	return pid_task(&pid->pid_list, type);
+	return pid_task(find_pid(nr), type);
 }
 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
+struct task_struct * fastcall get_pid_task(struct pid *pid, enum pid_type type)
+{
+	struct task_struct *result;
+	rcu_read_lock();
+	result = rcu_get_task_struct(pid_task(pid, type));
+	rcu_read_unlock();
+	return result;
+}
+
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
@@ -243,7 +265,7 @@ EXPORT_SYMBOL(find_task_by_pid_type);
  */
 void __init pidhash_init(void)
 {
-	int i, j, pidhash_size;
+	int i, pidhash_size;
 	unsigned long megabytes = nr_kernel_pages >> (20 - PAGE_SHIFT);
 
 	pidhash_shift = max(4, fls(megabytes * 4));
@@ -252,16 +274,14 @@ void __init pidhash_init(void)
 
 	printk("PID hash table entries: %d (order: %d, %Zd bytes)\n",
 		pidhash_size, pidhash_shift,
-		PIDTYPE_MAX * pidhash_size * sizeof(struct hlist_head));
+		pidhash_size * sizeof(struct hlist_head));
+
+	pid_hash = alloc_bootmem(pidhash_size *	sizeof(*(pid_hash)));
+	if (!pid_hash)
+		panic("Could not alloc pidhash!\n");
+	for (i = 0; i < pidhash_size; i++)
+		INIT_HLIST_HEAD(&pid_hash[i]);
 
-	for (i = 0; i < PIDTYPE_MAX; i++) {
-		pid_hash[i] = alloc_bootmem(pidhash_size *
-					sizeof(*(pid_hash[i])));
-		if (!pid_hash[i])
-			panic("Could not alloc pidhash!\n");
-		for (j = 0; j < pidhash_size; j++)
-			INIT_HLIST_HEAD(&pid_hash[i][j]);
-	}
 #ifdef CONFIG_KGDB
 	kgdb_pid_init_done++;
 #endif
@@ -273,4 +293,8 @@ void __init pidmap_init(void)
 	/* Reserve PID 0. We never call free_pidmap(0) */
 	set_bit(0, pidmap_array->page);
 	atomic_dec(&pidmap_array->nr_free);
+
+	pid_cachep = kmem_cache_create("pid", sizeof(struct pid),
+					__alignof__(struct pid),
+					SLAB_PANIC, NULL, NULL);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 2dfaa50..6390879 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1060,6 +1060,7 @@ int group_send_sig_info(int sig, struct 
 int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
 {
 	struct task_struct *p = NULL;
+	struct pid *pid;
 	int retval, success;
 
 	if (pgrp <= 0)
@@ -1067,11 +1068,11 @@ int __kill_pg_info(int sig, struct sigin
 
 	success = 0;
 	retval = -ESRCH;
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, pid) {
 		int err = group_send_sig_info(sig, info, p);
 		success |= !err;
 		retval = err;
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	}
 	return success ? 0 : retval;
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 3d46f39..ad92bec 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -470,6 +470,7 @@ asmlinkage long sys_setpriority(int whic
 {
 	struct task_struct *g, *p;
 	struct user_struct *user;
+	struct pid *pid;
 	int error = -EINVAL;
 
 	if (which > 2 || which < 0)
@@ -494,9 +495,9 @@ asmlinkage long sys_setpriority(int whic
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			for_each_task_pid(who, PIDTYPE_PGID, p, pid) {
 				error = set_one_prio(p, niceval, error);
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			}
 			break;
 		case PRIO_USER:
 			user = current->user;
@@ -530,6 +531,7 @@ asmlinkage long sys_getpriority(int whic
 {
 	struct task_struct *g, *p;
 	struct user_struct *user;
+	struct pid *pid;
 	long niceval, retval = -ESRCH;
 
 	if (which > 2 || which < 0)
@@ -550,11 +552,11 @@ asmlinkage long sys_getpriority(int whic
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			for_each_task_pid(who, PIDTYPE_PGID, p, pid) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			}
 			break;
 		case PRIO_USER:
 			user = current->user;
@@ -1301,11 +1303,12 @@ asmlinkage long sys_setpgid(pid_t pid, p
 
 	if (pgid != pid) {
 		struct task_struct *p;
+		struct pid *pidp;
 
-		do_each_task_pid(pgid, PIDTYPE_PGID, p) {
+		for_each_task_pid(pgid, PIDTYPE_PGID, p, pidp) {
 			if (p->signal->session == group_leader->signal->session)
 				goto ok_pgid;
-		} while_each_task_pid(pgid, PIDTYPE_PGID, p);
+		}
 		goto out;
 	}
 
@@ -1315,7 +1318,7 @@ ok_pgid:
 		goto out;
 
 	if (process_group(p) != pgid) {
-		detach_pid(p, PIDTYPE_PGID);
+		detach_pid(p, PIDTYPE_PGID, p->signal->pgrp);
 		p->signal->pgrp = pgid;
 		attach_pid(p, PIDTYPE_PGID, pgid);
 	}
-- 
1.2.2.g709a-dirty

