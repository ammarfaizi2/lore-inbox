Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWBFThi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWBFThi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWBFThi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:37:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22253 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932319AbWBFThg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:37:36 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:34:08 -0700
In-Reply-To: <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:29:51 -0700")
Message-ID: <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies the fork/exit, signal handling, and pid and
process group manipulating syscalls to support multiple process
spaces, and implements the data for allow multiple instaces of the pid
namespace. 

The implementation is the best compromise I have found between a
maintainable implementation that will break users that need to be
modified and a minimal impact implementation that doesn't require all
of the kernel's process id handling to be modified.

pid,tgid,pgrp,session all retain their current meanings.  Functions
that operation in an arbitrary context take an additional pspace
parameter.  The tuple pspace,pid is globally unique.   Making the
tuple pspace, pid the kernel pid and any plain pid value the user
space pid.

In conjunction with this patch there will need to be an audit of the
kernel to find and fix the places that compare and print pids.  The
only operations possible with out calling a helper function.

The number of comparisions performed not in conjunction with another
pid operation is small so there should not be many pieces of the
kernel affected.

Fixing up printing of the pids in debug messages is optional but
will likely be useful for understanding what is going on.  The
pspace->name field is provided for this purpose.  Simply
adding a "%s/"  before the existing "%d is suffient to add
the pspace name.

The API for manipulating PID namespaces is defined as follows:

sys_clone(CLONE_NPSPACE) creates a new process id namespace,
giving the child process 2 pids.  The normal pid which only
the parent sees and pid 1.  The child the becomes the init
process for the namespace in all measurable wasy including
reaping all of the namespaces children who die unexpectedly.

>From any process in the parents namespace with the appropriate
permissions sending sys_kill( <child pid>) sends a signal to just the
leading process of the pid namespace.

>From any process in the parents namespace with the appropriate
permissions sending sys_kill( -<child pid>) sends a signal to all
of the processes in the pid namespace.

currenty CAP_KILL is defined as the required capability to
create a PID namespace.  I don't know of anything harmful that
could result in making this disallowed but since someone
with CAP_KILL can arbitrarily kill any process it sounded
like a good safety measure.

When the leading process of the pid namespace exits all of
it's children die because init cannot exit :)

Waitpid on the extrenally visible pid of a pid namespace waits
for that namespace to exit.

pid namespaces are currently implemented so the can nest one
inside the other, as this adds no real complications.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c                 |    7 +-
 include/linux/init_task.h |    2 
 include/linux/kernel.h    |    3 -
 include/linux/pid.h       |   17 +++-
 include/linux/pspace.h    |   95 ++++++++++++++++++++++
 include/linux/sched.h     |   23 +++--
 include/linux/tty.h       |    2 
 init/main.c               |    5 -
 kernel/exit.c             |   79 ++++++++++++-------
 kernel/fork.c             |   56 ++++++++-----
 kernel/pid.c              |  192 ++++++++++++++++++++++++++++++++++-----------
 kernel/signal.c           |  118 +++++++++++++++++++---------
 kernel/sys.c              |   14 ++-
 13 files changed, 450 insertions(+), 163 deletions(-)
 create mode 100644 include/linux/pspace.h

8927729234906eb9fef21ca16bb30598a97b4485
diff --git a/fs/exec.c b/fs/exec.c
index 390aafe..1c2fa2c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -49,6 +49,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/pspace.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -621,8 +622,8 @@ static int de_thread(struct task_struct 
 	 * Reparenting needs write_lock on tasklist_lock,
 	 * so it is safe to do it under read_lock.
 	 */
-	if (unlikely(current->group_leader == child_reaper))
-		child_reaper = current;
+	if (unlikely(current->group_leader == current->pspace->child_reaper.task))
+		current->pspace->child_reaper.task = current;
 
 	zap_other_threads(current);
 	read_unlock(&tasklist_lock);
@@ -720,7 +721,7 @@ static int de_thread(struct task_struct 
 		list_add_tail(&current->tasks, &init_task.tasks);
 
 		current->parent = current->real_parent = leader->real_parent;
-		leader->parent = leader->real_parent = child_reaper;
+		leader->parent = leader->real_parent = leader->pspace->child_reaper.task;
 		current->group_leader = current;
 		leader->group_leader = leader;
 
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index e182ee6..db93266 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -3,6 +3,7 @@
 
 #include <linux/file.h>
 #include <linux/rcupdate.h>
+#include <linux/pspace.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -112,6 +113,7 @@ extern struct group_info init_groups;
 	.thread		= INIT_THREAD,					\
 	.fs		= &init_fs,					\
 	.files		= &init_files,					\
+	.pspace		= &init_pspace,					\
 	.signal		= &init_signals,				\
 	.sighand	= &init_sighand,				\
 	.pending	= {						\
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b49affa..bd2dd1f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -49,6 +49,7 @@ extern int console_printk[];
 struct completion;
 struct pt_regs;
 struct user;
+struct pspace;
 
 /**
  * might_sleep - annotation for functions that can sleep
@@ -123,7 +124,7 @@ extern unsigned long long memparse(char 
 
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
-extern int session_of_pgrp(int pgrp);
+extern int session_of_pgrp(struct pspace *pspace, int pgrp);
 
 extern void dump_thread(struct pt_regs *regs, struct user *dump);
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 099e70e..ba38c13 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -10,13 +10,16 @@ enum pid_type
 	PIDTYPE_MAX
 };
 
+struct pspace;
 struct pid
 {
 	/* Try to keep pid_chain in the same cacheline as nr for find_pid */
+	struct pspace *pspace;
 	int nr;
 	struct hlist_node pid_chain;
 	/* list of pids with the same nr, only one of them is in the hash */
 	struct list_head pid_list;
+	struct task_struct *task;
 };
 
 #define pid_task(elem, type) \
@@ -34,17 +37,19 @@ extern void FASTCALL(detach_pid(struct t
  * look up a PID in the hash table. Must be called with the tasklist_lock
  * held.
  */
-extern struct pid *FASTCALL(find_pid(enum pid_type, int));
+extern struct pid *FASTCALL(find_pid(enum pid_type, struct pspace *, int));
+#define find_task_by_pid(pspace, nr)	find_task_by_pid_type(PIDTYPE_PID, pspace, nr)
+extern struct task_struct *find_task_by_pid_type(int type, struct pspace *pspace, int pid);
 
-extern int alloc_pidmap(void);
-extern void FASTCALL(free_pidmap(int));
+extern int alloc_pidmap(struct pspace *pspace);
+extern void FASTCALL(free_pidmap(struct pspace *psapce, int pid));
 
-#define do_each_task_pid(who, type, task)				\
-	if ((task = find_task_by_pid_type(type, who))) {		\
+#define do_each_task_pid(pspace, who, type, task)			\
+	if ((task = find_task_by_pid_type(type, pspace, who))) {	\
 		prefetch((task)->pids[type].pid_list.next);		\
 		do {
 
-#define while_each_task_pid(who, type, task)				\
+#define while_each_task_pid(pspace, who, type, task)			\
 		} while (task = pid_task((task)->pids[type].pid_list.next,\
 						type),			\
 			prefetch((task)->pids[type].pid_list.next),	\
diff --git a/include/linux/pspace.h b/include/linux/pspace.h
new file mode 100644
index 0000000..950393a
--- /dev/null
+++ b/include/linux/pspace.h
@@ -0,0 +1,95 @@
+#ifndef _LINUX_PSPACE_H
+#define _LINUX_PSPACE_H
+
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <linux/pid.h>
+
+struct pidmap
+{
+	atomic_t nr_free;
+	void *page;
+};
+
+#define PIDMAP_ENTRIES		((PID_MAX_LIMIT + 8*PAGE_SIZE - 1)/PAGE_SIZE/8)
+
+struct pspace
+{
+	atomic_t count;
+	unsigned int flags;
+#define PSPACE_EXIT 0x00000001 /* pspace exit in progress */
+	struct pid child_reaper;
+	int nr_threads;
+	int nr_processes;
+	int last_pid;
+	int min;
+	int max;
+	struct pidmap pidmap[PIDMAP_ENTRIES];
+	char name[1]; /* For use in debugging print statements */
+};
+
+extern struct pspace init_pspace;
+
+#define INVALID_PID 0x7fffffff
+
+static inline int pspace_task_visible(struct pspace *pspace, struct task_struct *tsk)
+{
+	return (tsk->pspace == pspace) || 
+		((tsk->pspace->child_reaper.pspace == pspace) &&
+		 (tsk->pspace->child_reaper.task == tsk));
+}
+
+static inline int task_visible(struct task_struct *tsk)
+{
+	return pspace_task_visible(current->pspace, tsk);
+}
+
+static inline void get_pspace(struct pspace *pspace)
+{
+	if (!pspace)
+		return;
+	atomic_inc(&pspace->count);
+}
+
+extern void __put_pspace(struct pspace *pspace);
+
+static inline void put_pspace(struct pspace *pspace)
+{
+	if (!pspace)
+		return;
+	if (atomic_dec_and_test(&pspace->count)) {
+		__put_pspace(pspace);
+	}
+}
+
+extern int copy_pspace(int flags, struct task_struct *p);
+
+static inline void exit_pspace(struct task_struct *tsk)
+{
+	struct pspace *pspace = tsk->pspace;
+	tsk->pspace = NULL;
+	if (pspace->child_reaper.task == tsk) 
+		pspace->child_reaper.task = NULL;
+	put_pspace(pspace);
+}
+
+static inline int pspace_leader(struct task_struct *tsk)
+{
+	return tsk == tsk->pspace->child_reaper.task;
+}
+
+static inline int current_pspace_leader(struct task_struct *tsk)
+{
+	return tsk == current->pspace->child_reaper.task;
+}
+
+static inline int in_pspace(struct pspace *pspace, struct task_struct *tsk)
+{
+	struct pspace *test;
+	test = tsk->pspace;
+	while((test != &init_pspace) && (test != pspace))
+		test = test->child_reaper.pspace;
+	return test == pspace;
+}
+
+#endif /* _LINUX_PSPACE_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 86a92d6..1977cb9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -61,6 +61,7 @@ struct exec_domain;
 #define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 #define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
+#define CLONE_NPSPACE		0x04000000	/* New process id space */
 
 /*
  * List of flags we want to share for kernel threads,
@@ -94,9 +95,6 @@ extern unsigned long avenrun[];		/* Load
 
 extern unsigned long total_forks;
 extern int nr_threads;
-extern int last_pid;
-DECLARE_PER_CPU(unsigned long, process_counts);
-extern int nr_processes(void);
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
@@ -234,6 +232,7 @@ extern signed long schedule_timeout_unin
 asmlinkage void schedule(void);
 
 struct namespace;
+struct pspace;
 
 /* Maximum number of active map areas.. This is a random (large) number */
 #define DEFAULT_MAX_MAP_COUNT	65536
@@ -741,6 +740,7 @@ struct task_struct {
 	unsigned long personality;
 	unsigned did_exec:1;
 	pid_t wid;
+	struct pspace *pspace;	/* process id namespace */
 	pid_t pid;
 	pid_t tgid;
 	/* 
@@ -1037,8 +1037,6 @@ extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
 
-#define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
-extern struct task_struct *find_task_by_pid_type(int type, int pid);
 extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
 
@@ -1096,17 +1094,19 @@ extern int send_sig_info(int, struct sig
 extern int send_group_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
-extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
-extern int kill_pg_info(int, struct siginfo *, pid_t);
-extern int kill_proc_info(int, struct siginfo *, pid_t);
-extern int kill_proc_info_as_uid(int, struct siginfo *, pid_t, uid_t, uid_t);
+extern int __kill_pspace_info(int , struct siginfo *, struct pspace *);
+extern int kill_pspace_info(int , struct siginfo *, struct pspace *);
+extern int __kill_pg_info(int sig, struct siginfo *info, struct pspace *, pid_t pgrp);
+extern int kill_pg_info(int, struct siginfo *, struct pspace *, pid_t);
+extern int kill_proc_info(int, struct siginfo *, struct pspace *, pid_t);
+extern int kill_proc_info_as_uid(int, struct siginfo *, struct pspace *, pid_t, uid_t, uid_t);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
 extern int send_sig(int, struct task_struct *, int);
 extern void zap_other_threads(struct task_struct *p);
-extern int kill_pg(pid_t, int, int);
-extern int kill_proc(pid_t, int, int);
+extern int kill_pg(struct pspace *, pid_t, int, int);
+extern int kill_proc(struct pspace *, pid_t, int, int);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(int, struct sigqueue *,  struct task_struct *);
@@ -1173,7 +1173,6 @@ extern NORET_TYPE void do_group_exit(int
 extern void daemonize(const char *, ...);
 extern int allow_signal(int);
 extern int disallow_signal(int);
-extern task_t *child_reaper;
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3787102..898d593 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -292,7 +292,7 @@ extern int tty_read_raw_data(struct tty_
 			     int buflen);
 extern void tty_write_message(struct tty_struct *tty, char *msg);
 
-extern int is_orphaned_pgrp(int pgrp);
+extern int is_orphaned_pgrp(struct pspace *pspace, int pgrp);
 extern int is_ignored(int sig);
 extern int tty_signal(int sig, struct tty_struct *tty);
 extern void tty_hangup(struct tty_struct * tty);
diff --git a/init/main.c b/init/main.c
index 7c79da5..42dabde 100644
--- a/init/main.c
+++ b/init/main.c
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/pspace.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -555,8 +556,6 @@ static int __init initcall_debug_setup(c
 }
 __setup("initcall_debug", initcall_debug_setup);
 
-struct task_struct *child_reaper = &init_task;
-
 extern initcall_t __initcall_start[], __initcall_end[];
 
 static void __init do_initcalls(void)
@@ -666,7 +665,7 @@ static int init(void * unused)
 	 * assumptions about where in the task array this
 	 * can be found.
 	 */
-	child_reaper = current;
+	init_pspace.child_reaper.task = current;
 
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
diff --git a/kernel/exit.c b/kernel/exit.c
index f1af8bb..a32bbe6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -31,6 +31,7 @@
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
+#include <linux/pspace.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -38,7 +39,6 @@
 #include <asm/mmu_context.h>
 
 extern void sem_exit (void);
-extern struct task_struct *child_reaper;
 
 int getrusage(struct task_struct *, int, struct rusage __user *);
 
@@ -46,13 +46,14 @@ static void exit_mm(struct task_struct *
 
 static void __unhash_process(struct task_struct *p)
 {
+	p->pspace->nr_threads--;
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
 	detach_pid(p, PIDTYPE_TGID);
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
-		__get_cpu_var(process_counts)--;
+		p->pspace->nr_processes--;
 	}
 
 	REMOVE_LINKS(p);
@@ -105,6 +106,7 @@ repeat: 
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
+	exit_pspace(p);
 	release_thread(p);
 	put_task_struct(p);
 
@@ -118,19 +120,19 @@ repeat: 
  * satisfactory pgrp is found. I dunno - gdb doesn't work correctly
  * without this...
  */
-int session_of_pgrp(int pgrp)
+int session_of_pgrp(struct pspace *pspace, int pgrp)
 {
 	struct task_struct *p;
 	int sid = -1;
 
 	read_lock(&tasklist_lock);
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	do_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p) {
 		if (p->signal->session > 0) {
 			sid = p->signal->session;
 			goto out;
 		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
-	p = find_task_by_pid(pgrp);
+	} while_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p);
+	p = find_task_by_pid(pspace, pgrp);
 	if (p)
 		sid = p->signal->session;
 out:
@@ -147,12 +149,12 @@ out:
  *
  * "I ask you, have you ever known what it is to be an orphan?"
  */
-static int will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
+static int will_become_orphaned_pgrp(struct pspace *pspace, int pgrp, task_t *ignored_task)
 {
 	struct task_struct *p;
 	int ret = 1;
 
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	do_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p) {
 		if (p == ignored_task
 				|| p->exit_state
 				|| p->real_parent->pid == 1)
@@ -162,27 +164,27 @@ static int will_become_orphaned_pgrp(int
 			ret = 0;
 			break;
 		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	} while_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p);
 	return ret;	/* (sighing) "Often!" */
 }
 
-int is_orphaned_pgrp(int pgrp)
+int is_orphaned_pgrp(struct pspace *pspace, int pgrp)
 {
 	int retval;
 
 	read_lock(&tasklist_lock);
-	retval = will_become_orphaned_pgrp(pgrp, NULL);
+	retval = will_become_orphaned_pgrp(pspace, pgrp, NULL);
 	read_unlock(&tasklist_lock);
 
 	return retval;
 }
 
-static int has_stopped_jobs(int pgrp)
+static int has_stopped_jobs(struct pspace *pspace, int pgrp)
 {
 	int retval = 0;
 	struct task_struct *p;
 
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	do_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p) {
 		if (p->state != TASK_STOPPED)
 			continue;
 
@@ -198,7 +200,7 @@ static int has_stopped_jobs(int pgrp)
 
 		retval = 1;
 		break;
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	} while_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p);
 	return retval;
 }
 
@@ -221,8 +223,8 @@ static void reparent_to_init(void)
 	ptrace_unlink(current);
 	/* Reparent to init */
 	REMOVE_LINKS(current);
-	current->parent = child_reaper;
-	current->real_parent = child_reaper;
+	current->parent = current->pspace->child_reaper.task;
+	current->real_parent = current->pspace->child_reaper.task;
 	SET_LINKS(current);
 
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
@@ -524,6 +526,12 @@ static inline void choose_new_parent(tas
 	 * the parent is not a zombie.
 	 */
 	BUG_ON(p == reaper || reaper->exit_state >= EXIT_ZOMBIE);
+	/* If the pspaces of our parents differ don't become a zombie
+	 * or allow ourselves to be waited on, effecitvely this means
+	 * the process just disappears.
+	 */
+	if (p->real_parent->pspace != reaper->pspace)
+		p->exit_signal = -1;
 	p->real_parent = reaper;
 }
 
@@ -576,11 +584,13 @@ static void reparent_thread(task_t *p, t
 	 */
 	if ((process_group(p) != process_group(father)) &&
 	    (p->signal->session == father->signal->session)) {
+		struct pspace *pspace = p->pspace;
 		int pgrp = process_group(p);
 
-		if (will_become_orphaned_pgrp(pgrp, NULL) && has_stopped_jobs(pgrp)) {
-			__kill_pg_info(SIGHUP, SEND_SIG_PRIV, pgrp);
-			__kill_pg_info(SIGCONT, SEND_SIG_PRIV, pgrp);
+		if (will_become_orphaned_pgrp(pspace, pgrp, NULL) &&
+				has_stopped_jobs(pspace, pgrp)) {
+			__kill_pg_info(SIGHUP, SEND_SIG_PRIV, pspace, pgrp);
+			__kill_pg_info(SIGCONT, SEND_SIG_PRIV, pspace, pgrp);
 		}
 	}
 }
@@ -600,7 +610,10 @@ static void forget_original_parent(struc
 	do {
 		reaper = next_thread(reaper);
 		if (reaper == father) {
-			reaper = child_reaper;
+			if (!(father->pspace->flags & PSPACE_EXIT))
+				reaper = father->pspace->child_reaper.task;
+			else
+				reaper = init_pspace.child_reaper.task;
 			break;
 		}
 	} while (reaper->exit_state);
@@ -624,7 +637,7 @@ static void forget_original_parent(struc
 
 		if (father == p->real_parent) {
 			/* reparent with a reaper, real father it's us */
-			choose_new_parent(p, reaper, child_reaper);
+			choose_new_parent(p, reaper, p->pspace->child_reaper.task);
 			reparent_thread(p, father, 0);
 		} else {
 			/* reparent ptraced task to its real parent */
@@ -645,7 +658,7 @@ static void forget_original_parent(struc
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
-		choose_new_parent(p, reaper, child_reaper);
+		choose_new_parent(p, reaper, p->pspace->child_reaper.task);
 		reparent_thread(p, father, 1);
 	}
 }
@@ -713,10 +726,10 @@ static void exit_notify(struct task_stru
 	
 	if ((process_group(t) != process_group(tsk)) &&
 	    (t->signal->session == tsk->signal->session) &&
-	    will_become_orphaned_pgrp(process_group(tsk), tsk) &&
-	    has_stopped_jobs(process_group(tsk))) {
-		__kill_pg_info(SIGHUP, SEND_SIG_PRIV, process_group(tsk));
-		__kill_pg_info(SIGCONT, SEND_SIG_PRIV, process_group(tsk));
+	    will_become_orphaned_pgrp(tsk->pspace, process_group(tsk), tsk) &&
+	    has_stopped_jobs(tsk->pspace, process_group(tsk))) {
+		__kill_pg_info(SIGHUP, SEND_SIG_PRIV, tsk->pspace, process_group(tsk));
+		__kill_pg_info(SIGCONT, SEND_SIG_PRIV, tsk->pspace, process_group(tsk));
 	}
 
 	/* Let father know we died 
@@ -788,6 +801,16 @@ fastcall NORET_TYPE void do_exit(long co
 		panic("Attempted to kill the idle task!");
 	if (unlikely(is_init(tsk)))
 		panic("Attempted to kill init!");
+
+	/*
+	 * If we are the pspace leader it is nonsense for the pspace
+	 * to continue so kill everyone else in the pspace.
+	 */
+	if (pspace_leader(tsk)) {
+		tsk->pspace->flags = PSPACE_EXIT;
+		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
+	}
+
 	if (tsk->io_context)
 		exit_io_context();
 
@@ -943,10 +966,10 @@ static int eligible_child(pid_t pid, int
 	if (pid > 0) {
 		if (p->wid != pid)
 			return 0;
-	} else if (!pid) {
+	} else if (!pid && (current->pspace == p->pspace)) {
 		if (process_group(p) != process_group(current))
 			return 0;
-	} else if (pid != -1) {
+	} else if ((pid != -1) && (current->pspace == p->pspace)) {
 		if (process_group(p) != -pid)
 			return 0;
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 743d46c..354d156 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/pspace.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -60,23 +61,10 @@ int nr_threads; 		/* The idle threads do
 
 int max_threads;		/* tunable limit on nr_threads */
 
-DEFINE_PER_CPU(unsigned long, process_counts) = 0;
-
  __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
 EXPORT_SYMBOL(tasklist_lock);
 
-int nr_processes(void)
-{
-	int cpu;
-	int total = 0;
-
-	for_each_online_cpu(cpu)
-		total += per_cpu(process_counts, cpu);
-
-	return total;
-}
-
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
 # define alloc_task_struct()	kmem_cache_alloc(task_struct_cachep, GFP_KERNEL)
 # define free_task_struct(tsk)	kmem_cache_free(task_struct_cachep, (tsk))
@@ -879,6 +867,12 @@ static task_t *copy_process(unsigned lon
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
+	/* If I'm not sharing process ids I can't share signals or pids.
+	 */
+	if ((clone_flags & CLONE_NPSPACE) && 
+		(clone_flags & (CLONE_THREAD|CLONE_SIGHAND)))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Thread groups must share signals as well, and detached threads
 	 * can only be started up within the thread group.
@@ -894,6 +888,14 @@ static task_t *copy_process(unsigned lon
 	if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Important: If an exit-all has been started then
+	 * do not create this new process - the whole pspace
+	 * supposed to exit.
+	 */
+	if (current->pspace->flags & PSPACE_EXIT)
+		return ERR_PTR(-EAGAIN);
+
 	retval = security_task_create(clone_flags);
 	if (retval)
 		goto fork_out;
@@ -932,10 +934,13 @@ static task_t *copy_process(unsigned lon
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->wid = p->pid = pid;
+	if ((retval = copy_pspace(clone_flags, p)))
+		goto bad_fork_cleanup;
+
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
 		if (put_user(p->wid, parent_tidptr))
-			goto bad_fork_cleanup;
+			goto bad_fork_cleanup_pspace;
 
 	p->proc_dentry = NULL;
 
@@ -1139,13 +1144,20 @@ static task_t *copy_process(unsigned lon
 		attach_pid(p, PIDTYPE_PID, p->pid);
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
 		if (thread_group_leader(p)) {
-			p->signal->tty = current->signal->tty;
-			p->signal->pgrp = process_group(current);
-			p->signal->session = current->signal->session;
+			if (unlikely(clone_flags & CLONE_NPSPACE)) {
+				p->signal->tty = NULL;
+				p->signal->pgrp = 1;
+				p->signal->session = 1;
+			} else {
+				p->signal->tty = current->signal->tty;
+				p->signal->pgrp = process_group(current);
+				p->signal->session = current->signal->session;
+			}
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
 			attach_pid(p, PIDTYPE_SID, p->signal->session);
-			__get_cpu_var(process_counts)++;
+			p->pspace->nr_processes++;
 		}
+		p->pspace->nr_threads++;
 		nr_threads++;
 	}
 
@@ -1181,6 +1193,10 @@ bad_fork_cleanup_policy:
 bad_fork_cleanup_cpuset:
 #endif
 	cpuset_exit(p);
+bad_fork_cleanup_pspace:
+	if (p->wid != p->pid)
+		free_pidmap(p->pspace, p->pid);
+	exit_pspace(p);
 bad_fork_cleanup:
 	if (p->binfmt)
 		module_put(p->binfmt->module);
@@ -1248,7 +1264,7 @@ long do_fork(unsigned long clone_flags,
 {
 	struct task_struct *p;
 	int trace = 0;
-	long pid = alloc_pidmap();
+	long pid = alloc_pidmap(current->pspace);
 
 	if (pid < 0)
 		return -EAGAIN;
@@ -1295,7 +1311,7 @@ long do_fork(unsigned long clone_flags,
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
 	} else {
-		free_pidmap(pid);
+		free_pidmap(current->pspace, pid);
 		pid = PTR_ERR(p);
 	}
 	return pid;
diff --git a/kernel/pid.c b/kernel/pid.c
index fbf45bb..221585d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -26,23 +26,21 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/hash.h>
+#include <linux/pspace.h>
 
-#define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
+#define pid_hashfn(pspace, nr) \
+	hash_long(((unsigned long)pspace) ^ ((unsigned long)nr), pidhash_shift)
 static struct hlist_head *pid_hash[PIDTYPE_MAX];
 static int pidhash_shift;
 
-int pid_max = PID_MAX_DEFAULT;
-int last_pid;
-
 #define RESERVED_PIDS		300
 
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
 
-#define PIDMAP_ENTRIES		((PID_MAX_LIMIT + 8*PAGE_SIZE - 1)/PAGE_SIZE/8)
 #define BITS_PER_PAGE		(PAGE_SIZE*8)
 #define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
-#define mk_pid(map, off)	(((map) - pidmap_array)*BITS_PER_PAGE + (off))
+#define mk_pid(map, off)	(((map) - pspace->pidmap)*BITS_PER_PAGE + (off))
 #define find_next_offset(map, off)					\
 		find_next_zero_bit((map)->page, BITS_PER_PAGE, off)
 
@@ -52,36 +50,45 @@ int pid_max_max = PID_MAX_LIMIT;
  * value does not cause lots of bitmaps to be allocated, but
  * the scheme scales to up to 4 million PIDs, runtime.
  */
-typedef struct pidmap {
-	atomic_t nr_free;
-	void *page;
-} pidmap_t;
-
-static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
-	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
+struct pspace init_pspace = {
+	.count        = ATOMIC_INIT(1),
+	.child_reaper = {
+		.pspace	= &init_pspace,
+		.task	= &init_task,
+	},
+	.nr_threads   = 0,
+	.nr_processes = 0,
+	.last_pid     = 0,
+	.min          = RESERVED_PIDS,
+	.max          = PID_MAX_DEFAULT,
+	.pidmap   = {
+		[ 0 ... PIDMAP_ENTRIES-1] = { ATOMIC_INIT(BITS_PER_PAGE), NULL }
+	},
+	.name = "",
+};
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
 
-fastcall void free_pidmap(int pid)
+fastcall void free_pidmap(struct pspace *pspace, int pid)
 {
-	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	struct pidmap *map = pspace->pidmap + pid / BITS_PER_PAGE;
 	int offset = pid & BITS_PER_PAGE_MASK;
 
 	clear_bit(offset, map->page);
 	atomic_inc(&map->nr_free);
 }
 
-int alloc_pidmap(void)
+int alloc_pidmap(struct pspace *pspace)
 {
-	int i, offset, max_scan, pid, last = last_pid;
-	pidmap_t *map;
+	int i, offset, max_scan, pid, last = pspace->last_pid;
+	struct pidmap *map;
 
 	pid = last + 1;
-	if (pid >= pid_max)
-		pid = RESERVED_PIDS;
+	if (pid >= pspace->max)
+		pid = pspace->min;
 	offset = pid & BITS_PER_PAGE_MASK;
-	map = &pidmap_array[pid/BITS_PER_PAGE];
-	max_scan = (pid_max + BITS_PER_PAGE - 1)/BITS_PER_PAGE - !offset;
+	map = &pspace->pidmap[pid/BITS_PER_PAGE];
+	max_scan = (pspace->max + BITS_PER_PAGE - 1)/BITS_PER_PAGE - !offset;
 	for (i = 0; i <= max_scan; ++i) {
 		if (unlikely(!map->page)) {
 			unsigned long page = get_zeroed_page(GFP_KERNEL);
@@ -102,7 +109,7 @@ int alloc_pidmap(void)
 			do {
 				if (!test_and_set_bit(offset, map->page)) {
 					atomic_dec(&map->nr_free);
-					last_pid = pid;
+					pspace->last_pid = pid;
 					return pid;
 				}
 				offset = find_next_offset(map, offset);
@@ -113,16 +120,16 @@ int alloc_pidmap(void)
 			 * bitmap block and the final block was the same
 			 * as the starting point, pid is before last_pid.
 			 */
-			} while (offset < BITS_PER_PAGE && pid < pid_max &&
+			} while (offset < BITS_PER_PAGE && pid < pspace->max &&
 					(i != max_scan || pid < last ||
 					    !((last+1) & BITS_PER_PAGE_MASK)));
 		}
-		if (map < &pidmap_array[(pid_max-1)/BITS_PER_PAGE]) {
+		if (map < &pspace->pidmap[(pspace->max-1)/BITS_PER_PAGE]) {
 			++map;
 			offset = 0;
 		} else {
-			map = &pidmap_array[0];
-			offset = RESERVED_PIDS;
+			map = &pspace->pidmap[0];
+			offset = pspace->min;
 			if (unlikely(last == offset))
 				break;
 		}
@@ -131,30 +138,31 @@ int alloc_pidmap(void)
 	return -1;
 }
 
-struct pid * fastcall find_pid(enum pid_type type, int nr)
+struct pid * fastcall find_pid(enum pid_type type, struct pspace *pspace, int nr)
 {
 	struct hlist_node *elem;
 	struct pid *pid;
 
 	hlist_for_each_entry_rcu(pid, elem,
-			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
-		if (pid->nr == nr)
+			&pid_hash[type][pid_hashfn(pspace, nr)], pid_chain) {
+		if ((pid->nr == nr) && (pid->pspace == pspace))
 			return pid;
 	}
 	return NULL;
 }
 
-int fastcall attach_pid(task_t *task, enum pid_type type, int nr)
+static int fastcall attach_any_pid(struct pid *task_pid, task_t *task, enum pid_type type, struct pspace *pspace, int nr)
 {
-	struct pid *pid, *task_pid;
+	struct pid *pid;
 
-	task_pid = &task->pids[type];
-	pid = find_pid(type, nr);
+	pid = find_pid(type, pspace, nr);
 	task_pid->nr = nr;
+	task_pid->pspace = pspace;
+	task_pid->task = task;
 	if (pid == NULL) {
 		INIT_LIST_HEAD(&task_pid->pid_list);
 		hlist_add_head_rcu(&task_pid->pid_chain,
-				   &pid_hash[type][pid_hashfn(nr)]);
+				   &pid_hash[type][pid_hashfn(pspace, nr)]);
 	} else {
 		INIT_HLIST_NODE(&task_pid->pid_chain);
 		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
@@ -163,12 +171,16 @@ int fastcall attach_pid(task_t *task, en
 	return 0;
 }
 
-static fastcall int __detach_pid(task_t *task, enum pid_type type)
+int fastcall attach_pid(task_t *task, enum pid_type type, int nr)
+{
+	return attach_any_pid(&task->pids[type], task, type, task->pspace, nr);
+}
+
+static fastcall int __detach_pid(struct pid *pid, enum pid_type type)
 {
-	struct pid *pid, *pid_next;
+	struct pid *pid_next;
 	int nr = 0;
 
-	pid = &task->pids[type];
 	if (!hlist_unhashed(&pid->pid_chain)) {
 
 		if (list_empty(&pid->pid_list)) {
@@ -189,34 +201,118 @@ static fastcall int __detach_pid(task_t 
 	return nr;
 }
 
-void fastcall detach_pid(task_t *task, enum pid_type type)
+static void fastcall detach_any_pid(struct pid *pid, enum pid_type type)
 {
 	int tmp, nr;
 
-	nr = __detach_pid(task, type);
+	nr = __detach_pid(pid, type);
 	if (!nr)
 		return;
 
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
-		if (tmp != type && find_pid(tmp, nr))
+		if (tmp != type && find_pid(tmp, pid->pspace, nr))
 			return;
 
-	free_pidmap(nr);
+	free_pidmap(pid->pspace, nr);
 }
 
-task_t *find_task_by_pid_type(int type, int nr)
+void fastcall detach_pid(task_t *task, enum pid_type type)
+{
+	return detach_any_pid(&task->pids[type], type);
+}
+
+task_t *find_task_by_pid_type(int type, struct pspace *pspace, int nr)
 {
 	struct pid *pid;
 
-	pid = find_pid(type, nr);
+	pid = find_pid(type, pspace, nr);
 	if (!pid)
 		return NULL;
 
-	return pid_task(&pid->pid_list, type);
+	return pid->task;
 }
 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
+static struct pspace *new_pspace(struct task_struct *leader)
+{
+	struct pspace *pspace, *parent;
+	int i;
+	size_t len;
+	parent = leader->pspace;
+	len = strlen(parent->name) + 10;
+	pspace = kzalloc(sizeof(struct pspace) + len, GFP_KERNEL);
+	if (!pspace)
+		return NULL;
+	atomic_set(&pspace->count, 1);
+	pspace->flags        = 0;
+	pspace->nr_threads   = 0;
+	pspace->nr_processes = 0;
+	pspace->last_pid     = 0;
+	pspace->min          = RESERVED_PIDS;
+	pspace->max          = PID_MAX_DEFAULT;
+	for (i = 0; i < PIDMAP_ENTRIES; i++) {
+		atomic_set(&pspace->pidmap[i].nr_free,  BITS_PER_PAGE);
+		pspace->pidmap[i].page = NULL;
+	}
+	attach_any_pid(&pspace->child_reaper, leader, PIDTYPE_PID, 
+			parent, leader->wid);
+	leader->pspace->nr_processes++;
+	snprintf(pspace->name, len + 1, "%s/%d", parent->name, leader->wid);
+
+	return pspace;
+}
+
+int copy_pspace(int flags, struct task_struct *p)
+{
+	struct pspace *new;
+	int pid;
+	get_pspace(p->pspace);
+
+	if (!(flags & CLONE_NPSPACE))
+		return 0;
+
+	if (!capable(CAP_KILL))
+		return -EPERM;
+		
+	/* Allocate the new pidspace structure */
+	new = new_pspace(p);
+	if (!new) {
+		put_pspace(p->pspace);
+		return -ENOMEM;
+	}
+	
+	/* Allocate the new pid */
+	pid = alloc_pidmap(new);
+
+	/* Setup the new pspace and pid */
+	p->pspace = new;
+	p->pid = pid;
+
+	return 0;
+}
+
+void __put_pspace(struct pspace *pspace)
+{
+	struct pspace *parent;
+	struct pidmap *map;
+	int i;
+
+	BUG_ON(atomic_read(&pspace->count) != 0);
+	/* notifier? */
+
+	pspace->child_reaper.pspace->nr_processes--;
+	detach_any_pid(&pspace->child_reaper, PIDTYPE_PID);
+	parent = pspace->child_reaper.pspace;
+	map    = pspace->pidmap;
+	for (i = 0; i < PIDMAP_ENTRIES; i++) {
+		BUG_ON(atomic_read(&map[i].nr_free) != BITS_PER_PAGE);
+		free_page((unsigned long)map[i].page);
+	}
+	kfree(pspace);
+	put_pspace(parent);
+}
+
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
@@ -247,8 +343,8 @@ void __init pidhash_init(void)
 
 void __init pidmap_init(void)
 {
-	pidmap_array->page = (void *)get_zeroed_page(GFP_KERNEL);
+	init_pspace.pidmap->page = (void *)get_zeroed_page(GFP_KERNEL);
 	/* Reserve PID 0 */
-	set_bit(0, pidmap_array->page);
-	atomic_dec(&pidmap_array->nr_free);
+	set_bit(0, init_pspace.pidmap->page);
+	atomic_dec(&init_pspace.pidmap->nr_free);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 70c226c..8a7fa8e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -26,6 +26,7 @@
 #include <linux/signal.h>
 #include <linux/audit.h>
 #include <linux/capability.h>
+#include <linux/pspace.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -680,6 +681,8 @@ static int check_kill_permission(int sig
 	if (!valid_signal(sig))
 		return error;
 	error = -EPERM;
+	if (current_pspace_leader(t) && sig_kernel_only(sig))
+		return error;
 	if ((info == SEND_SIG_NOINFO || (!is_si_special(info) && SI_FROMUSER(info)))
 	    && ((sig != SIGCONT) ||
 		(current->signal->session != t->signal->session))
@@ -1147,11 +1150,55 @@ retry:
 }
 
 /*
+ * kill_pspace_info() sends a signal to all processes in a process space.
+ * This is what kill(-1, sig) does.
+ */
+
+int __kill_pspace_info(int sig, struct siginfo *info, struct pspace *pspace)
+{
+	struct task_struct *p = NULL;
+	int retval = 0, count = 0;
+
+	for_each_process(p) {
+		int err;
+		/* Skip the current pspace leader */
+		if (current_pspace_leader(p))
+			continue;
+
+		/* Skip the sender of the signal */
+		if (p->signal == current->signal)
+			continue;
+
+		/* Skip processes outside the target process space */
+		if (!in_pspace(pspace, p))
+			continue;
+
+		/* Finally it is a good process send the signal. */
+		err = group_send_sig_info(sig, info, p);
+		++count;
+		if (err != -EPERM)
+			retval = err;
+	}
+	return count ? retval : -ESRCH;
+}
+
+int kill_pspace_info(int sig, struct siginfo *info, struct pspace *pspace)
+{
+	int retval;
+
+	read_lock(&tasklist_lock);
+	retval = __kill_pspace_info(sig, info, pspace);
+	read_unlock(&tasklist_lock);
+
+	return retval;
+}
+
+/*
  * kill_pg_info() sends a signal to a process group: this is what the tty
  * control characters do (^C, ^Z etc)
  */
 
-int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
+int __kill_pg_info(int sig, struct siginfo *info, struct pspace *pspace, pid_t pgrp)
 {
 	struct task_struct *p = NULL;
 	int retval, success;
@@ -1161,28 +1208,28 @@ int __kill_pg_info(int sig, struct sigin
 
 	success = 0;
 	retval = -ESRCH;
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
+	do_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p) {
 		int err = group_send_sig_info(sig, info, p);
 		success |= !err;
 		retval = err;
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
+	} while_each_task_pid(pspace, pgrp, PIDTYPE_PGID, p);
 	return success ? 0 : retval;
 }
 
 int
-kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
+kill_pg_info(int sig, struct siginfo *info, struct pspace *pspace, pid_t pgrp)
 {
 	int retval;
 
 	read_lock(&tasklist_lock);
-	retval = __kill_pg_info(sig, info, pgrp);
+	retval = __kill_pg_info(sig, info, pspace, pgrp);
 	read_unlock(&tasklist_lock);
 
 	return retval;
 }
 
 int
-kill_proc_info(int sig, struct siginfo *info, pid_t pid)
+kill_proc_info(int sig, struct siginfo *info, struct pspace *pspace, pid_t pid)
 {
 	int error;
 	int acquired_tasklist_lock = 0;
@@ -1193,7 +1240,7 @@ kill_proc_info(int sig, struct siginfo *
 		read_lock(&tasklist_lock);
 		acquired_tasklist_lock = 1;
 	}
-	p = find_task_by_pid(pid);
+	p = find_task_by_pid(pspace, pid);
 	error = -ESRCH;
 	if (p)
 		error = group_send_sig_info(sig, info, p);
@@ -1204,8 +1251,9 @@ kill_proc_info(int sig, struct siginfo *
 }
 
 /* like kill_proc_info(), but doesn't use uid/euid of "current" */
-int kill_proc_info_as_uid(int sig, struct siginfo *info, pid_t pid,
-		      uid_t uid, uid_t euid)
+int kill_proc_info_as_uid(int sig, struct siginfo *info, 
+				struct pspace *pspace, pid_t pid, 
+				uid_t uid, uid_t euid)
 {
 	int ret = -EINVAL;
 	struct task_struct *p;
@@ -1214,7 +1262,7 @@ int kill_proc_info_as_uid(int sig, struc
 		return ret;
 
 	read_lock(&tasklist_lock);
-	p = find_task_by_pid(pid);
+	p = find_task_by_pid(pspace, pid);
 	if (!p) {
 		ret = -ESRCH;
 		goto out_unlock;
@@ -1242,31 +1290,28 @@ EXPORT_SYMBOL_GPL(kill_proc_info_as_uid)
  *
  * POSIX specifies that kill(-1,sig) is unspecified, but what we have
  * is probably wrong.  Should make it like BSD or SYSV.
+ *
+ * This has been extended to treat all process spaces just like kill(-1, sig)
  */
 
 static int kill_something_info(int sig, struct siginfo *info, int pid)
 {
 	if (!pid) {
-		return kill_pg_info(sig, info, process_group(current));
-	} else if (pid == -1) {
-		int retval = 0, count = 0;
-		struct task_struct * p;
+		return kill_pg_info(sig, info, current->pspace, process_group(current));
+	} else if (pid < 0) {
+		struct task_struct *p;
+		int retval;
 
 		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->pid > 1 && p->tgid != current->tgid) {
-				int err = group_send_sig_info(sig, info, p);
-				++count;
-				if (err != -EPERM)
-					retval = err;
-			}
-		}
+		p = find_task_by_pid(current->pspace, -pid);
+		if (!p || !pspace_leader(p))
+			retval = __kill_pg_info(sig, info, current->pspace, -pid);
+		else
+			retval = __kill_pspace_info(sig, info, p->pspace);
 		read_unlock(&tasklist_lock);
-		return count ? retval : -ESRCH;
-	} else if (pid < 0) {
-		return kill_pg_info(sig, info, -pid);
+		return retval;
 	} else {
-		return kill_proc_info(sig, info, pid);
+		return kill_proc_info(sig, info, current->pspace, pid);
 	}
 }
 
@@ -1354,15 +1399,15 @@ force_sigsegv(int sig, struct task_struc
 }
 
 int
-kill_pg(pid_t pgrp, int sig, int priv)
+kill_pg(struct pspace *pspace, pid_t pgrp, int sig, int priv)
 {
-	return kill_pg_info(sig, __si_special(priv), pgrp);
+	return kill_pg_info(sig, __si_special(priv), pspace, pgrp);
 }
 
 int
-kill_proc(pid_t pid, int sig, int priv)
+kill_proc(struct pspace *pspace, pid_t pid, int sig, int priv)
 {
-	return kill_proc_info(sig, __si_special(priv), pid);
+	return kill_proc_info(sig, __si_special(priv), pspace, pid);
 }
 
 /*
@@ -1987,8 +2032,11 @@ relock:
 		if (sig_kernel_ignore(signr)) /* Default is nothing. */
 			continue;
 
-		/* Init gets no signals it doesn't want.  */
-		if (current == child_reaper)
+		/* Init gets no signals it doesn't want.
+		 * Other pspace leaders can't ignore SIGKILL and SIGSTOP
+		 */
+		if (pspace_leader(current) &&
+				(is_init(current) || !sig_kernel_only(signr)))
 			continue;
 
 		if (sig_kernel_stop(signr)) {
@@ -2007,7 +2055,7 @@ relock:
 
 				/* signals can be posted during this window */
 
-				if (is_orphaned_pgrp(process_group(current)))
+				if (is_orphaned_pgrp(current->pspace, process_group(current)))
 					goto relock;
 
 				spin_lock_irq(&current->sighand->siglock);
@@ -2360,7 +2408,7 @@ static int do_tkill(int tgid, int pid, i
 	info.si_uid = current->uid;
 
 	read_lock(&tasklist_lock);
-	p = find_task_by_pid(pid);
+	p = find_task_by_pid(current->pspace, pid);
 	if (p && (tgid <= 0 || p->tgid == tgid)) {
 		error = check_kill_permission(sig, &info, p);
 		/*
@@ -2426,7 +2474,7 @@ sys_rt_sigqueueinfo(int pid, int sig, si
 	info.si_signo = sig;
 
 	/* POSIX.1b doesn't mention process groups.  */
-	return kill_proc_info(sig, &info, pid);
+	return kill_proc_info(sig, &info, current->pspace, pid);
 }
 
 int
diff --git a/kernel/sys.c b/kernel/sys.c
index 0929c69..dc8cb58 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -30,6 +30,7 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
+#include <linux/pspace.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -1114,7 +1115,7 @@ asmlinkage long sys_setpgid(pid_t pid, p
 	write_lock_irq(&tasklist_lock);
 
 	err = -ESRCH;
-	p = find_task_by_pid(pid);
+	p = find_task_by_pid(current->pspace, pid);
 	if (!p)
 		goto out;
 
@@ -1140,12 +1141,13 @@ asmlinkage long sys_setpgid(pid_t pid, p
 		goto out;
 
 	if (pgid != pid) {
+		struct pspace *pspace = current->pspace;
 		struct task_struct *p;
 
-		do_each_task_pid(pgid, PIDTYPE_PGID, p) {
+		do_each_task_pid(pspace, pgid, PIDTYPE_PGID, p) {
 			if (p->signal->session == group_leader->signal->session)
 				goto ok_pgid;
-		} while_each_task_pid(pgid, PIDTYPE_PGID, p);
+		} while_each_task_pid(pspace, pgid, PIDTYPE_PGID, p);
 		goto out;
 	}
 
@@ -1176,7 +1178,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 		struct task_struct *p;
 
 		read_lock(&tasklist_lock);
-		p = find_task_by_pid(pid);
+		p = find_task_by_pid(current->pspace, pid);
 
 		retval = -ESRCH;
 		if (p) {
@@ -1208,7 +1210,7 @@ asmlinkage long sys_getsid(pid_t pid)
 		struct task_struct *p;
 
 		read_lock(&tasklist_lock);
-		p = find_task_by_pid(pid);
+		p = find_task_by_pid(current->pspace, pid);
 
 		retval = -ESRCH;
 		if(p) {
@@ -1230,7 +1232,7 @@ asmlinkage long sys_setsid(void)
 	down(&tty_sem);
 	write_lock_irq(&tasklist_lock);
 
-	pid = find_pid(PIDTYPE_PGID, group_leader->pid);
+	pid = find_pid(PIDTYPE_PGID, current->pspace, group_leader->pid);
 	if (pid)
 		goto out;
 
-- 
1.1.5.g3480

