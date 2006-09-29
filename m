Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWI2CNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWI2CNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWI2CNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:2212 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751361AbWI2CNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:06 -0400
Message-Id: <20060929021259.755781000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:33 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 01/10] Task watchers v2 Task watchers v2
Content-Disposition: inline; filename=task-watchers-v2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Associate function calls with significant events in a task's lifetime much like
we handle init/exit functions. This creates a table for each of the following
events in the task_watchers_table ELF section -- notify_task_watchers() is
called with:

WATCH_TASK_INIT at the beginning of a fork/clone system call when the
new task struct first becomes available.

WATCH_TASK_CLONE just before returning successfully from a fork/clone.

WATCH_TASK_EXEC just before successfully returning from the exec
system call.

WATCH_TASK_UID every time a task's real or effective user id changes.

WATCH_TASK_GID every time a task's real or effective group id changes.

WATCH_TASK_EXIT at the beginning of do_exit when a task is exiting
for any reason. 

WATCH_TASK_FREE is called before critical task structures like
the mm_struct become inaccessible and the task is subsequently freed.

The next patch will add a debugfs interface for measuring fork and exit rates
which can be used to calculate the overhead of the task watcher infrastructure.

Subsequent patches will make use of task watchers to simplify fork, exit,
and many of the system calls that set [er][ug]ids.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Jes Sorensen <jes@sgi.com>
Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com
Cc: Paul Jackson <pj@sgi.com>
---
 fs/exec.c                         |    3 +++
 include/asm-generic/vmlinux.lds.h |   19 +++++++++++++++++++
 include/linux/task_watchers.h     |   31 +++++++++++++++++++++++++++++++
 kernel/Makefile                   |    2 +-
 kernel/exit.c                     |    3 +++
 kernel/fork.c                     |   15 +++++++++++----
 kernel/sys.c                      |    9 +++++++++
 kernel/task_watchers.c            |   37 +++++++++++++++++++++++++++++++++++++
 8 files changed, 114 insertions(+), 5 deletions(-)

Index: linux-2.6.18-mm1/kernel/sys.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/sys.c
+++ linux-2.6.18-mm1/kernel/sys.c
@@ -26,10 +26,11 @@
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
+#include <linux/task_watchers.h>
 #include <linux/getcpu.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
 #include <linux/kprobes.h>
@@ -957,10 +958,11 @@ asmlinkage long sys_setregid(gid_t rgid,
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
+	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
 /*
  * setgid() is implemented like SysV w/ SAVED_IDS 
@@ -992,10 +994,11 @@ asmlinkage long sys_setgid(gid_t gid)
 	else
 		return -EPERM;
 
 	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
+	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
 {
@@ -1080,10 +1083,11 @@ asmlinkage long sys_setreuid(uid_t ruid,
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
 	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
+	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
 
@@ -1127,10 +1131,11 @@ asmlinkage long sys_setuid(uid_t uid)
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
 	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
+	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
 
@@ -1175,10 +1180,11 @@ asmlinkage long sys_setresuid(uid_t ruid
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
 	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
+	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t __user *ruid, uid_t __user *euid, uid_t __user *suid)
@@ -1227,10 +1233,11 @@ asmlinkage long sys_setresgid(gid_t rgid
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
+	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
 {
@@ -1268,10 +1275,11 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		current->fsuid = uid;
 	}
 
 	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
+	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -1295,10 +1303,11 @@ asmlinkage long sys_setfsgid(gid_t gid)
 			smp_wmb();
 		}
 		current->fsgid = gid;
 		key_fsgid_changed(current);
 		proc_id_connector(current, PROC_EVENT_GID);
+		notify_task_watchers(WATCH_TASK_GID, 0, current);
 	}
 	return old_fsgid;
 }
 
 asmlinkage long sys_times(struct tms __user * tbuf)
Index: linux-2.6.18-mm1/kernel/exit.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/exit.c
+++ linux-2.6.18-mm1/kernel/exit.c
@@ -39,10 +39,11 @@
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
 #include <linux/blkdev.h>
+#include <linux/task_watchers.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -881,10 +882,11 @@ fastcall NORET_TYPE void do_exit(long co
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
 
 	tsk->flags |= PF_EXITING;
+	notify_task_watchers(WATCH_TASK_EXIT, code, tsk);
 
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
 				current->comm, current->pid,
 				preempt_count());
@@ -912,10 +914,11 @@ fastcall NORET_TYPE void do_exit(long co
 		audit_free(tsk);
 	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
 	taskstats_exit_free(tidstats);
 
 	exit_mm(tsk);
+	notify_task_watchers(WATCH_TASK_FREE, code, tsk);
 
 	if (group_dead)
 		acct_process();
 	exit_sem(tsk);
 	__exit_files(tsk);
Index: linux-2.6.18-mm1/fs/exec.c
===================================================================
--- linux-2.6.18-mm1.orig/fs/exec.c
+++ linux-2.6.18-mm1/fs/exec.c
@@ -47,10 +47,11 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
+#include <linux/task_watchers.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
 #ifdef CONFIG_KMOD
@@ -1082,10 +1083,12 @@ int search_binary_handler(struct linux_b
 				allow_write_access(bprm->file);
 				if (bprm->file)
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
+				notify_task_watchers(WATCH_TASK_EXEC, 0,
+						     current);
 				proc_exec_connector(current);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
Index: linux-2.6.18-mm1/include/linux/task_watchers.h
===================================================================
--- /dev/null
+++ linux-2.6.18-mm1/include/linux/task_watchers.h
@@ -0,0 +1,31 @@
+#ifndef _TASK_WATCHERS_H
+#define _TASK_WATCHERS_H
+#include <linux/sched.h>
+
+#define WATCH_TASK_INIT  0
+#define WATCH_TASK_CLONE 1
+#define WATCH_TASK_EXEC  2
+#define WATCH_TASK_UID   3
+#define WATCH_TASK_GID   4
+#define WATCH_TASK_EXIT  5
+#define WATCH_TASK_FREE  6
+#define NUM_WATCH_TASK_EVENTS 7
+
+#ifndef MODULE
+typedef int (*task_watcher_fn)(unsigned long, struct task_struct*);
+
+/*
+ * Watch for events occuring within a task and call the supplied function
+ * when (and only when) the given event happens.
+ * Only non-modular kernel code may register functions as task_watchers.
+ */
+#define task_watcher_func(ev, fn) \
+static task_watcher_fn __task_watcher_##ev##_##fn __attribute_used__ \
+	__attribute__ ((__section__ (".task_watchers." #ev))) = fn
+#else
+#error "task_watcher() macro may not be used in modules."
+#endif
+
+extern int notify_task_watchers(unsigned int ev_idx, unsigned long val,
+				struct task_struct *tsk);
+#endif /*  _TASK_WATCHERS_H */
Index: linux-2.6.18-mm1/kernel/task_watchers.c
===================================================================
--- /dev/null
+++ linux-2.6.18-mm1/kernel/task_watchers.c
@@ -0,0 +1,37 @@
+#include <linux/task_watchers.h>
+
+/* Defined in include/asm-generic/common.lds.h */
+extern const task_watcher_fn __start_task_watchers_init[],
+		__start_task_watchers_clone[], __start_task_watchers_exec[],
+		__start_task_watchers_uid[], __start_task_watchers_gid[],
+		__start_task_watchers_exit[], __start_task_watchers_free[],
+		__stop_task_watchers_free[];
+
+/*
+ *  Tables of ptrs to the first watcher func for WATCH_TASK_*
+ */
+static const task_watcher_fn *twtable[] = {
+	__start_task_watchers_init,
+	__start_task_watchers_clone,
+	__start_task_watchers_exec,
+	__start_task_watchers_uid,
+	__start_task_watchers_gid,
+	__start_task_watchers_exit,
+	__start_task_watchers_free,
+	__stop_task_watchers_free,
+};
+
+int notify_task_watchers(unsigned int ev, unsigned long val,
+			 struct task_struct *tsk)
+{
+	const task_watcher_fn *tw_call;
+	int ret_err = 0, err;
+
+	/* Call all of the watchers, report the first error */
+	for (tw_call = twtable[ev]; tw_call < twtable[ev + 1]; tw_call++) {
+		err = (*tw_call)(val, tsk);
+		if (unlikely((err < 0) && (ret_err == NOTIFY_OK)))
+			ret_err = err;
+	}
+	return ret_err;
+}
Index: linux-2.6.18-mm1/kernel/Makefile
===================================================================
--- linux-2.6.18-mm1.orig/kernel/Makefile
+++ linux-2.6.18-mm1/kernel/Makefile
@@ -6,11 +6,11 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o rwsem.o latency.o nsproxy.o srcu.o
+	    hrtimer.o rwsem.o latency.o nsproxy.o srcu.o task_watchers.o
 
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_LOCKDEP) += lockdep.o
Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
@@ -46,10 +46,11 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
 #include <linux/random.h>
+#include <linux/task_watchers.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1051,10 +1052,18 @@ static struct task_struct *copy_process(
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
+
+	p->tgid = p->pid;
+	if (clone_flags & CLONE_THREAD)
+		p->tgid = current->tgid;
+
+	retval = notify_task_watchers(WATCH_TASK_INIT, clone_flags, p);
+	if (retval < 0)
+		goto bad_fork_cleanup_delays_binfmt;
 	cpuset_fork(p);
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
  		retval = PTR_ERR(p->mempolicy);
@@ -1092,14 +1101,10 @@ static struct task_struct *copy_process(
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
 
-	p->tgid = p->pid;
-	if (clone_flags & CLONE_THREAD)
-		p->tgid = current->tgid;
-
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
 	if ((retval = audit_alloc(p)))
 		goto bad_fork_cleanup_security;
 	/* copy all the process information */
@@ -1256,10 +1261,11 @@ static struct task_struct *copy_process(
 	}
 
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+	notify_task_watchers(WATCH_TASK_CLONE, clone_flags, p);
 	proc_fork_connector(p);
 	return p;
 
 bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
@@ -1288,10 +1294,11 @@ bad_fork_cleanup_policy:
 bad_fork_cleanup_cpuset:
 #endif
 	cpuset_exit(p);
 bad_fork_cleanup_delays_binfmt:
 	delayacct_tsk_free(p);
+	notify_task_watchers(WATCH_TASK_FREE, 0, p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
 	module_put(task_thread_info(p)->exec_domain->module);
 bad_fork_cleanup_count:
Index: linux-2.6.18-mm1/include/asm-generic/vmlinux.lds.h
===================================================================
--- linux-2.6.18-mm1.orig/include/asm-generic/vmlinux.lds.h
+++ linux-2.6.18-mm1/include/asm-generic/vmlinux.lds.h
@@ -42,10 +42,29 @@
 		VMLINUX_SYMBOL(__start_rio_route_ops) = .;		\
 		*(.rio_route_ops)					\
 		VMLINUX_SYMBOL(__end_rio_route_ops) = .;		\
 	}								\
 									\
+	.task_watchers_table : AT(ADDR(.task_watchers_table) - LOAD_OFFSET) { \
+		*(.task_watchers_table)					\
+		VMLINUX_SYMBOL(__start_task_watchers_init) = .;		\
+		*(.task_watchers.init)					\
+		VMLINUX_SYMBOL(__start_task_watchers_clone) = .;	\
+		*(.task_watchers.clone)					\
+		VMLINUX_SYMBOL(__start_task_watchers_exec) = .;		\
+		*(.task_watchers.exec)					\
+		VMLINUX_SYMBOL(__start_task_watchers_uid) = .;		\
+		*(.task_watchers.uid)					\
+		VMLINUX_SYMBOL(__start_task_watchers_gid) = .;		\
+		*(.task_watchers.gid)					\
+		VMLINUX_SYMBOL(__start_task_watchers_exit) = .;		\
+		*(.task_watchers.exit)					\
+		VMLINUX_SYMBOL(__start_task_watchers_free) = .;		\
+		*(.task_watchers.free)					\
+		VMLINUX_SYMBOL(__stop_task_watchers_free) = .;		\
+	}								\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
 		*(__ksymtab)						\
 		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\

--
