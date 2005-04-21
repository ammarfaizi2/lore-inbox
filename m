Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVDUBcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDUBcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 21:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVDUBcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 21:32:14 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:29971 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261169AbVDUB2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 21:28:05 -0400
Date: Wed, 20 Apr 2005 21:21:55 -0400
From: Jeff Dike <jdike@addtoit.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Resource management through virtualization - the scheduler
Message-ID: <20050421012155.GA6217@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have long believed that general-purpose resource management is best
done by virtualizing the subsystem responsible for the resource in
question.

Here, I present a virtualization of the scheduler which allows the
construction of CPU compartments and confinement of processes within
them.  The scheduler is virtualized in the sense that it is possible
to have more than one scheduler running on the system, and each new
guest scheduler runs as a process on the host scheduler.  Thus, it
competes for CPU time as a single process, and the processes confined
to the guest compete against each other for the CPU time given to the
guest scheduler.

For example, given three CPU hogs, one of which is running directly on
the host scheduler, and two of which are confined to a guest
scheduler, the CPU hog on the host will compete with the guest
scheduler for CPU time, and each will receive half.  The two hogs
inside the guest scheduler will then compete for the half of the CPU
given to the guest scheduler, each receiving 1/4 of the CPU.

This has uses aside from the resource control which motivated it:
    The guest scheduler doesn't need to be the standard Linux
scheduler - if you feel the current scheduler doesn't do justice to
your workload, you can write your own, load it in as a guest, and put
your workload into it.
    The guest can be a bug-fixed version of the host - move your
workload into it and see if your bug is fixed.  If not, move your
workload back out, unload the scheduler, and try again.  If so, you
can leave everything as is, and you don't have to reboot.

Each guest scheduler creates a "sched group" (I would have used "sched
domain", but the NUMA people beat me to it).  In addition, there is a
sched group for the host scheduler.  These are represented in /proc as
/proc/sched-groups/<n>, where <n> is the pid of the process creating
the sched group.  The host sched group is /proc/sched-groups/0, and is
created at boot time.

The /proc/sched-groups/<n> directory contains the current /proc/<pid>
directories for all processes inside the sched group.  sched group 0
initially contains all of the processes on the system.  As the
/proc/<pid> directories have moved, symlinks are left behind for
compatibility.

A new sched group is created by a process opening
/proc/schedulers/guest_o1_scheduler, as with
    % /proc/schedulers/guest_o1_scheduler
This interface is somewhat hokey, and better suggestions would be
appreciated.  However, this does have the property that the container
initially has the scheduling properties of this process, such as nice
level, priority, scheduling policy, processor affinity, etc.  These
can be manipulated after the fact just as any other process.

Processes are confined to a compartment by moving them from one
/proc/sched-group/<n> directory to another.  New processes also
inherit the compartment of their parent.

To make this concrete, here is a session producing the 50-25-25 CPU
split described above:

        # This cat will become the guest scheduler by opening guest_o1_scheduler
	usermode:~# cat /proc/schedulers/guest_o1_scheduler &
	Created sched_group 290 ('guest_o1_scheduler')
	# This is now /proc/sched-groups/290/
	[1] 290
	# Create three CPU hogs
	usermode:~# bash -c 'while true; do true; done' &
	[2] 292
	usermode:~# bash -c 'while true; do true; done' &
	[3] 293
	usermode:~# bash -c 'while true; do true; done' &
	[4] 294
	# Move 293 and 294 into the compartment, leaving 292 on the host
	# scheduler
	usermode:~# mv /proc/sched-groups/0/293 /proc/sched-groups/290/
	usermode:~# mv /proc/sched-groups/0/294 /proc/sched-groups/290/
	# ...wait a bit...
	usermode:~# ps uax
	...
	root       292 49.1  0.7  2324  996 tty0     R    21:51  14:40 bash -c 
	root       293 24.7  0.7  2324  996 tty0     R    21:51   7:23 bash -c 
	root       294 24.7  0.7  2324  996 tty0     R    21:51   7:23 bash -c 
	...

More arbitrary divisions of CPU can be made by having the guest
schedulers be SMP with more than one virtual processor.  This could
also be adjusted on the fly by adding CPU hotplug support.

Compartments can be nested, and don't require root privileges to
create.  What does require root is loading the guests into the kernel
in the first place.  In the absence of a reentrant scheduler, new
instances are made available by modprobing more instances of the
scheduler module into the kernel.  However, given the presence of
available guests, activating one is a non-privileged operation.

The design of this is that there is a scheduler struct pointer in each
task struct.  This contains the entry points for the scheduler that is
controlling it.  Every scheduler operation now goes through
p->scheduler.task_ops.<function>.  Moving a process from one sched group
to another causes its scheduler to be changed.

When a new sched group is created, it creates another thread, which
will be the idle thread of the guest scheduler.  The original process
remains with its scheduler.  When it gets CPU time from the host, it
switches to the idle thread of the guest scheduler.  When the guest
idle thread runs again, instead of sleeping, it switches back to the
container process, which sleeps in the host scheduler.

Clock ticks are handled such that the host scheduler gets to see them
first, getting a chance to schedule away from the compartment.  When
the compartment next runs, it will handle the tick on its own, and
have a chance to make its own scheduling decisions.

The implementation is as follows:
    The O(1) scheduler algorithm was split out from sched.c and moved
to o1_sched.c.  This is the code that we want duplicated, and the code
that remains in sched.c is stuff like system call entry points and
primitives which are independent of the actual algorithm, which
shouldn't be duplicated.

    The scheduling primitives were made static and used to fill a
structure of function pointers in the scheduler struct.  Their names
were also changed so as not to conflict with the new macros in sched.h
which call through the scheduler struct.  For example, schedule() in
sched.h is now
	#define schedule() current->scheduler->task_ops.schedule()
and the scheduler is now
        static asmlinkage void __sched o1_schedule(void)

o1_sched.c is now linked into two intermediate object files, a host
and a guest, with either host_sched.c and guest_sched.c.  These two
customize the scheduler struct as either a host or a guest scheduler.
The output of this is either guest_o1_sched.o (when CONFIG_GUEST_SCHED
== y) or guest_o1_scheduler.ko (when CONFIG_GUEST_SCHED == m).  When
built into the kernel, you get one guest scheduler, which is
registered at boot time.  Thus, it is recommended to make it
modular, and modprobe it whenever you need a new compartment.

modprobe is somewhat reluctant to load the same module twice, so using
the -o switch to modprobe is needed to give each instance a different
name:
    % modprobe -o guest1 modprobe guest_o1_scheduler
at which point, you'd open /proc/schedulers/guest1 to activate it.

I've broken this into three patches -
    guest-sched-prep - adds the procfs changes and makes the single
host scheduler use it, adds the sched.h changes, the sched.c
redeclarations, and the scheduler struct, but doesn't change the
system's behavior. 
    guest-sched-movement - creates o1_sched.c by splitting the
relevant code from sched.c
    guest-sched-guest - adds guest support by adding the necessary
build changes (along with the kbuild nastiness that seems to be a
hallmark of my work, sigh) and the code in guest_sched.c which
actually virtualizes the scheduler.

Patches 1 and 3 are attached; patch 2 is code movement with no
functional changes and is way too large to post to LKML.  It can be
found at http://www.user-mode-linux.org/~jdike/guest-sched-movement

Here are diffstats:

guest-sched-prep:

 arch/um/kernel/skas/process_kern.c |    2 
 arch/um/kernel/tt/process_kern.c   |    2 
 fs/proc/base.c                     |  201 +++++++++++++++++++++++++++++++++++--
 include/linux/init_task.h          |    1 
 include/linux/kernel_stat.h        |   11 +-
 include/linux/sched.h              |  122 +++++++++++++++++++---
 kernel/Makefile                    |    7 -
 kernel/host_sched.c                |   10 +
 kernel/sched.c                     |  142 ++++++++++++++++++--------
 kernel/sched_group.c               |  138 +++++++++++++++++++++++++
 10 files changed, 560 insertions(+), 76 deletions(-)

guest-sched-movement:

 Makefile   |    2 
 o1_sched.c | 3506 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sched.c    | 3510 -------------------------------------------------------------
 3 files changed, 3512 insertions(+), 3506 deletions(-)

guest-sched-guest:

 arch/um/defconfig             |    1 
 arch/um/kernel/ksyms.c        |    4 +
 arch/um/kernel/process_kern.c |    2 
 arch/um/kernel/signal_kern.c  |    2 
 arch/um/kernel/time_kern.c    |    2 
 include/linux/rcupdate.h      |    2 
 include/linux/sched.h         |    2 
 init/Kconfig                  |    4 +
 kernel/Makefile               |   32 +++++++++
 kernel/acct.c                 |    3 
 kernel/fork.c                 |    4 +
 kernel/guest_sched.c          |  143 ++++++++++++++++++++++++++++++++++++++++++
 kernel/o1_sched.c             |   26 +++++++
 kernel/profile.c              |    2 
 kernel/rcupdate.c             |    7 ++
 kernel/sched_group.c          |   52 +++++++++++++++
 mm/memory.c                   |    2 
 17 files changed, 288 insertions(+), 2 deletions(-)

The lots of little changes in -guest are a bunch of EXPORT_SYMBOLS of
random crap that were needed to get the scheduler loading as a module.

I've build and tested this with UML (2.6.11-bk8, but it should be fine
with anything near that).  I think that there one or two minor
unportabilities that will prevent this from working as-is on other
arches.  However, there's nothing intrinsically arch-dependent here.

				  Jeff

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=guest-sched-prep

Index: guest-sched-2.6.11/arch/um/kernel/skas/process_kern.c
===================================================================
--- guest-sched-2.6.11.orig/arch/um/kernel/skas/process_kern.c	2005-04-20 16:51:13.000000000 -0400
+++ guest-sched-2.6.11/arch/um/kernel/skas/process_kern.c	2005-04-20 16:59:13.000000000 -0400
@@ -47,8 +47,6 @@
 	return(current->thread.prev_sched);
 }
 
-extern void schedule_tail(struct task_struct *prev);
-
 void new_thread_handler(int sig)
 {
 	int (*fn)(void *), n;
Index: guest-sched-2.6.11/arch/um/kernel/tt/process_kern.c
===================================================================
--- guest-sched-2.6.11.orig/arch/um/kernel/tt/process_kern.c	2005-04-20 16:51:13.000000000 -0400
+++ guest-sched-2.6.11/arch/um/kernel/tt/process_kern.c	2005-04-20 16:59:00.000000000 -0400
@@ -123,8 +123,6 @@
 		panic("read failed in suspend_new_thread, err = %d", -err);
 }
 
-void schedule_tail(task_t *prev);
-
 static void new_thread_handler(int sig)
 {
 	unsigned long disable;
Index: guest-sched-2.6.11/fs/proc/base.c
===================================================================
--- guest-sched-2.6.11.orig/fs/proc/base.c	2005-04-19 18:46:19.000000000 -0400
+++ guest-sched-2.6.11/fs/proc/base.c	2005-04-19 18:47:19.000000000 -0400
@@ -119,6 +119,7 @@
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
 #endif
+	PROC_TID_SCHED_GROUP,
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
@@ -1699,6 +1700,67 @@
 	.follow_link	= proc_self_follow_link,
 };
 
+static int sched_group(int pid)
+{
+        struct task_struct *task;
+
+        read_lock(&tasklist_lock);
+	task = find_task_by_pid(pid);
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
+        pid = -ENOENT;
+	if (!task)
+		goto out;
+
+        pid = task_sched_pid(task);
+ out:
+	put_task_struct(task);
+        return pid;
+}
+
+static int sched_group_str(const char *name)
+{
+        char *end;
+        int pid = simple_strtol(name, &end, 10);
+
+        if(*end != '\0')
+                return -EINVAL;
+
+        return sched_group(pid);
+}
+
+static int proc_pid_sched_readlink(struct dentry *dentry, char __user *buffer,
+				   int buflen)
+{
+	char tmp[sizeof("sched-groups/12345/12345")];
+        int group = sched_group_str(dentry->d_name.name);
+
+        if(group < 0)
+                return group;
+
+	sprintf(tmp, "sched-groups/%d/%s", group, dentry->d_name.name);
+	return vfs_readlink(dentry,buffer,buflen,tmp);
+}
+
+static int proc_pid_sched_follow_link(struct dentry *dentry, 
+				      struct nameidata *nd)
+{
+	char tmp[sizeof("sched-groups/12345/12345")];
+        int group = sched_group_str(dentry->d_name.name);
+
+        if(group < 0)
+                return group;
+
+	sprintf(tmp, "sched-groups/%d/%s", group, dentry->d_name.name);
+	return vfs_follow_link(nd,tmp);
+}	
+
+static struct inode_operations proc_pid_inode_operations = {
+	.readlink	= proc_pid_sched_readlink,
+	.follow_link	= proc_pid_sched_follow_link,
+};
+
 /**
  * proc_pid_unhash -  Unhash /proc/<pid> entry from the dcache.
  * @p: task that should be flushed.
@@ -1753,6 +1815,63 @@
 	}
 }
 
+struct dentry *sched_group_lookup(struct inode *dir, struct dentry * dentry, 
+                                  struct nameidata *nd)
+{
+        struct proc_dir_entry *entry = PDE(dir);
+	struct task_struct *task;
+	struct inode *inode;
+	unsigned tgid;
+	int died = 0;
+
+	tgid = name_to_int(dentry);
+	if (tgid == ~0U)
+		goto out;
+
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(tgid);
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
+	if (!task)
+		goto out;
+
+        if(sched_group(tgid) != sched_pid(entry->data))
+                goto out_put;
+
+	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_SCHED_GROUP);
+
+	if (!inode) {
+		put_task_struct(task);
+		goto out;
+	}
+	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_op = &proc_tgid_base_inode_operations;
+	inode->i_fop = &proc_tgid_base_operations;
+	inode->i_nlink = 3;
+
+	dentry->d_op = &pid_base_dentry_operations;
+
+	d_add(dentry, inode);
+	spin_lock(&task->proc_lock);
+	task->proc_dentry = dentry;
+	if (!pid_alive(task)) {
+		dentry = proc_pid_unhash(task);
+		died = 1;
+	}
+	spin_unlock(&task->proc_lock);
+
+ out_put:
+	put_task_struct(task);
+	if (died) {
+		proc_pid_flush(dentry);
+		goto out;
+	}
+	return NULL;
+out:
+	return ERR_PTR(-ENOENT);
+}
+
 /* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
@@ -1791,18 +1910,14 @@
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
 
-
 	if (!inode) {
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	inode->i_op = &proc_tgid_base_inode_operations;
-	inode->i_fop = &proc_tgid_base_operations;
-	inode->i_nlink = 3;
-	inode->i_flags|=S_IMMUTABLE;
 
-	dentry->d_op = &pid_base_dentry_operations;
+	inode->i_mode = S_IFLNK|S_IRWXUGO;
+	inode->i_size = 64;
+	inode->i_op = &proc_pid_inode_operations;
 
 	died = 0;
 	d_add(dentry, inode);
@@ -1943,6 +2058,76 @@
 	return nr_tids;
 }
 
+int sched_group_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	unsigned int tgid_array[PROC_MAXPIDS];
+	char buf[PROC_NUMBUF];
+	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
+	unsigned int nr_tgids, i;
+	int next_tgid;
+        struct proc_dir_entry *entry;
+
+	if (filp->f_pos < FIRST_PROCESS_ENTRY){
+		filp->f_pos = FIRST_PROCESS_ENTRY;
+                nr = filp->f_pos - FIRST_PROCESS_ENTRY;
+        }
+
+        /* The remnants of /proc/self */
+	if (!nr) {
+                filp->f_pos++;
+                nr++;
+        }
+
+        entry = PDE(filp->f_dentry->d_inode);
+
+	/* f_version caches the tgid value that the last readdir call couldn't
+	 * return. lseek aka telldir automagically resets f_version to 0.
+	 */
+	next_tgid = filp->f_version;
+	filp->f_version = 0;
+	for (;;) {
+		nr_tgids = get_tgid_list(nr, next_tgid, tgid_array);
+		if (!nr_tgids) {
+			/* no more entries ! */
+			break;
+		}
+		next_tgid = 0;
+
+		/* do not use the last found pid, reserve it for next_tgid */
+		if (nr_tgids == PROC_MAXPIDS) {
+			nr_tgids--;
+			next_tgid = tgid_array[nr_tgids];
+		}
+
+		for (i=0;i<nr_tgids;i++) {
+			int tgid = tgid_array[i];
+			ino_t ino = fake_ino(tgid,PROC_TGID_INO);
+			unsigned long j = PROC_NUMBUF;
+                        
+                        if(sched_group(tgid) != sched_pid(entry->data)){
+                                filp->f_pos++;
+                                nr++;
+                                continue;
+                        }
+
+			do
+				buf[--j] = '0' + (tgid % 10);
+			while ((tgid /= 10) != 0);
+
+			if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
+				/* returning this tgid failed, save it as the first
+				 * pid for the next readir call */
+				filp->f_version = tgid_array[i];
+				goto out;
+			}
+			filp->f_pos++;
+			nr++;
+		}
+	}
+out:
+	return 0;
+}
+
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
@@ -1988,7 +2173,7 @@
 				buf[--j] = '0' + (tgid % 10);
 			while ((tgid /= 10) != 0);
 
-			if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
+			if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_LNK) < 0) {
 				/* returning this tgid failed, save it as the first
 				 * pid for the next readir call */
 				filp->f_version = tgid_array[i];
Index: guest-sched-2.6.11/include/linux/init_task.h
===================================================================
--- guest-sched-2.6.11.orig/include/linux/init_task.h	2005-04-19 18:46:19.000000000 -0400
+++ guest-sched-2.6.11/include/linux/init_task.h	2005-04-19 18:47:19.000000000 -0400
@@ -111,6 +111,7 @@
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
+        .scheduler	= &o1_scheduler,				\
 }
 
 
Index: guest-sched-2.6.11/include/linux/kernel_stat.h
===================================================================
--- guest-sched-2.6.11.orig/include/linux/kernel_stat.h	2005-04-19 18:46:19.000000000 -0400
+++ guest-sched-2.6.11/include/linux/kernel_stat.h	2005-04-19 18:47:19.000000000 -0400
@@ -36,7 +36,7 @@
 /* Must have preemption disabled for this to be meaningful. */
 #define kstat_this_cpu	__get_cpu_var(kstat)
 
-extern unsigned long long nr_context_switches(void);
+#define nr_context_switches() current->scheduler->task_ops.nr_context_switches()
 
 /*
  * Number of interrupts per specific IRQ source, since bootup
@@ -52,8 +52,11 @@
 	return sum;
 }
 
-extern void account_user_time(struct task_struct *, cputime_t);
-extern void account_system_time(struct task_struct *, int, cputime_t);
-extern void account_steal_time(struct task_struct *, cputime_t);
+#define account_user_time(task, t) \
+        (task)->scheduler->task_ops.account_user_time(task, t)
+#define account_system_time(task, o, t) \
+        (task)->scheduler->task_ops.account_system_time(task, o, t)
+#define account_steal_time(task, t) \
+        (task)->scheduler->task_ops.account_steal_time(task, t)
 
 #endif /* _LINUX_KERNEL_STAT_H */
Index: guest-sched-2.6.11/include/linux/sched.h
===================================================================
--- guest-sched-2.6.11.orig/include/linux/sched.h	2005-04-19 18:46:19.000000000 -0400
+++ guest-sched-2.6.11/include/linux/sched.h	2005-04-20 20:58:20.000000000 -0400
@@ -35,6 +35,15 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 
+/*
+ * Convert user-nice values [ -20 ... 0 ... 19 ]
+ * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
+ * and back.
+ */
+#define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
+#define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
+#define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
+
 struct exec_domain;
 
 /*
@@ -94,9 +103,9 @@
 extern int last_pid;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
-extern unsigned long nr_running(void);
-extern unsigned long nr_uninterruptible(void);
-extern unsigned long nr_iowait(void);
+#define nr_running() current->scheduler->task_ops.nr_running()
+#define nr_uninterruptible() current->scheduler->task_ops.nr_uninterruptible()
+#define nr_iowait() current->scheduler->task_ops.nr_iowait()
 
 #include <linux/time.h>
 #include <linux/param.h>
@@ -152,9 +161,16 @@
 
 typedef struct task_struct task_t;
 
-extern void sched_init(void);
+#define task_timeslice(p) (p)->scheduler->task_ops.task_timeslice(p)
+#define try_to_wake_up(p, state, sync) \
+        (p)->scheduler->task_ops.try_to_wake_up(p, state, sync)
+
+#define sched_init() current->scheduler->task_ops.sched_init_fn()
+#define init_idle(t, cpu) (t)->scheduler->task_ops.init_idle(t, cpu)
+
+#define schedule_tail(p) (p)->scheduler->task_ops.schedule_tail(p)
+
 extern void sched_init_smp(void);
-extern void init_idle(task_t *idle, int cpu);
 
 extern cpumask_t nohz_cpu_mask;
 
@@ -168,13 +184,15 @@
  */
 extern void show_stack(struct task_struct *task, unsigned long *sp);
 
-void io_schedule(void);
-long io_schedule_timeout(long timeout);
+#define io_schedule() current->scheduler->task_ops.io_schedule()
+#define io_schedule_timeout(timeout) \
+        current->scheduler->task_ops.io_schedule_timeout(timeout)
+#define do_sched_yield() current->scheduler->task_ops.sched_yield()
 
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
-extern void scheduler_tick(void);
+#define scheduler_tick() current->scheduler->task_ops.scheduler_tick()
 extern unsigned long cache_decay_ticks;
 
 /* Attach to any functions which should be ignored in wchan output. */
@@ -184,7 +202,7 @@
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
-asmlinkage void schedule(void);
+#define schedule() current->scheduler->task_ops.schedule()
 
 struct namespace;
 
@@ -205,6 +223,72 @@
 extern void arch_unmap_area(struct vm_area_struct *area);
 extern void arch_unmap_area_topdown(struct vm_area_struct *area);
 
+struct sched_task_ops {
+        /* Sleep */
+        asmlinkage void (*schedule)(void);
+        void (*io_schedule)(void);
+        long (*io_schedule_timeout)(long timeout);
+
+        /* Wake-up */
+#ifdef CONFIG_SMP
+        void (*wait_task_inactive)(task_t * p);
+#endif
+        void fastcall (*wake_up_new_task)(task_t * p, 
+                                          unsigned long clone_flags);
+        void fastcall (*sched_exit)(task_t * p);
+        asmlinkage void (*schedule_tail)(task_t *prev);
+
+        /* Policy */
+        void (*set_user_nice)(task_t *p, long nice);
+        int (*sched_setscheduler)(struct task_struct *p, int policy, 
+                                  struct sched_param *param);
+#ifdef CONFIG_SMP
+        int (*set_cpus_allowed)(task_t *p, cpumask_t new_mask);
+#endif
+        long (*sched_yield)(void);
+        unsigned long (*nr_running)(void);
+        unsigned long (*nr_uninterruptible)(void);
+        unsigned long long (*nr_context_switches)(void);
+        unsigned long (*nr_iowait)(void);
+        unsigned long long (*current_sched_time)(const task_t *tsk);
+        void (*account_user_time)(struct task_struct *p, cputime_t cputime);
+        void (*account_system_time)(struct task_struct *p, int hardirq_offset,
+                                    cputime_t cputime);
+        void (*account_steal_time)(struct task_struct *p, cputime_t steal);
+        void (*scheduler_tick)(void);
+        int (*idle_cpu)(int cpu);
+        task_t *(*idle_task)(int cpu);
+        unsigned int (*task_timeslice)(task_t *p);
+        int (*try_to_wake_up)(task_t * p, unsigned int state, int sync);
+        void (*sched_init_fn)(void);
+        int (*task_curr)(const task_t *p);
+        void (*init_idle)(task_t *idle, int cpu);
+};
+
+struct scheduler {
+        struct list_head list;
+        struct task_struct *container;
+        char *name;
+        int is_guest;
+        unsigned int inode;
+        struct completion wakeup;
+        spinlock_t lock;
+        struct list_head incoming;
+        struct sched_task_ops task_ops;
+};
+
+extern struct scheduler o1_scheduler;
+
+extern int register_scheduler(struct scheduler *scheduler, char *name);
+extern int register_sched_group(int pid, struct scheduler *scheduler);
+extern int task_sched_pid(struct task_struct *task);
+extern int init_sched_instance(struct scheduler *scheduler);
+extern void uninit_sched_instance(struct scheduler *scheduler);
+extern int sched_pid(void *sched);
+extern void handle_incoming(struct scheduler *scheduler);
+
+#define sched_add_task(p) p->scheduler->task_ops.sched_add_task(p)
+#define sched_remove_task(p) p->scheduler->task_ops.sched_remove_task(p)
 
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
@@ -719,6 +803,7 @@
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+        struct scheduler *scheduler;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -808,7 +893,7 @@
 #endif
 
 extern unsigned long long sched_clock(void);
-extern unsigned long long current_sched_time(const task_t *current_task);
+#define current_sched_time(t) (t)->scheduler->task_ops.current_sched_time(t)
 
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
@@ -824,13 +909,14 @@
 #endif
 
 extern void sched_idle_next(void);
-extern void set_user_nice(task_t *p, long nice);
+#define set_user_nice(p, nice) (p)->scheduler->task_ops.set_user_nice(p, nice)
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
-extern int task_curr(const task_t *p);
-extern int idle_cpu(int cpu);
-extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
-extern task_t *idle_task(int cpu);
+#define task_curr(p) (p)->scheduler->task_ops.task_curr(p)
+#define idle_cpu(cpu) current->scheduler->task_ops.idle_cpu(cpu)
+#define sched_setscheduler(p, policy, param) \
+        (p)->scheduler->task_ops.sched_setscheduler(p, policy, param)
+#define idle_task(cpu) current->scheduler->task_ops.idle_task(cpu)
 
 void yield(void);
 
@@ -880,8 +966,9 @@
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern void FASTCALL(wake_up_new_task(struct task_struct * tsk,
-						unsigned long clone_flags));
+#define wake_up_new_task(tsk, clone_flags) \
+        (tsk)->scheduler->task_ops.wake_up_new_task(tsk, clone_flags)
+
 #ifdef CONFIG_SMP
  extern void kick_process(struct task_struct *tsk);
 #else
@@ -889,6 +976,7 @@
 #endif
 extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
+#define sched_exit(p) (p)->scheduler->task_ops.sched_exit(p)
 
 extern int in_group_p(gid_t);
 extern int in_egroup_p(gid_t);
Index: guest-sched-2.6.11/kernel/Makefile
===================================================================
--- guest-sched-2.6.11.orig/kernel/Makefile	2005-04-20 17:09:23.000000000 -0400
+++ guest-sched-2.6.11/kernel/Makefile	2005-04-20 20:58:24.000000000 -0400
@@ -2,12 +2,13 @@
 # Makefile for the linux kernel.
 #
 
-obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
-	    exit.o itimer.o time.o softirq.o resource.o \
+obj-y     = sched.o host_sched.o fork.o exec_domain.o panic.o printk.o \
+	    profile.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
+	    sched_group.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: guest-sched-2.6.11/kernel/host_sched.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/host_sched.c	2003-09-15 09:40:47.000000000 -0400
+++ guest-sched-2.6.11/kernel/host_sched.c	2005-04-20 17:07:06.000000000 -0400
@@ -0,0 +1,10 @@
+#include <linux/sched.h>
+
+int init_sched_instance(struct scheduler *scheduler)
+{
+	return register_sched_group(0, scheduler);
+}
+
+void uninit_sched_instance(struct scheduler *scheduler)
+{
+}
Index: guest-sched-2.6.11/kernel/sched.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/sched.c	2005-04-20 11:19:10.000000000 -0400
+++ guest-sched-2.6.11/kernel/sched.c	2005-04-20 20:58:24.000000000 -0400
@@ -166,7 +166,7 @@
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
 
-static unsigned int task_timeslice(task_t *p)
+static unsigned int o1_task_timeslice(task_t *p)
 {
 	if (p->static_prio < NICE_TO_PRIO(0))
 		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
@@ -801,7 +801,7 @@
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
  */
-inline int task_curr(const task_t *p)
+static inline int o1_task_curr(const task_t *p)
 {
 	return cpu_curr(task_cpu(p)) == p;
 }
@@ -860,7 +860,7 @@
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
  */
-void wait_task_inactive(task_t * p)
+static void wait_task_inactive(task_t * p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
@@ -984,7 +984,7 @@
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync)
+static int o1_try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
 	int cpu, this_cpu, success = 0;
 	unsigned long flags;
@@ -1204,7 +1204,7 @@
  * that must be done for every newly created context, then puts the task
  * on the runqueue and wakes it.
  */
-void fastcall wake_up_new_task(task_t * p, unsigned long clone_flags)
+static void fastcall o1_wake_up_new_task(task_t * p, unsigned long clone_flags)
 {
 	unsigned long flags;
 	int this_cpu, cpu;
@@ -1290,7 +1290,7 @@
  * artificially, because any timeslice recovered here
  * was given away by the parent in the first place.)
  */
-void fastcall sched_exit(task_t * p)
+static void fastcall o1_sched_exit(task_t * p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
@@ -1357,7 +1357,7 @@
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
-asmlinkage void schedule_tail(task_t *prev)
+static asmlinkage void o1_schedule_tail(task_t *prev)
 	__releases(rq->lock)
 {
 	finish_task_switch(prev);
@@ -1402,7 +1402,7 @@
  * threads, current number of uninterruptible-sleeping threads, total
  * number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+static unsigned long o1_nr_running(void)
 {
 	unsigned long i, sum = 0;
 
@@ -1412,7 +1412,7 @@
 	return sum;
 }
 
-unsigned long nr_uninterruptible(void)
+static unsigned long o1_nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
@@ -1429,7 +1429,7 @@
 	return sum;
 }
 
-unsigned long long nr_context_switches(void)
+static unsigned long long o1_nr_context_switches(void)
 {
 	unsigned long long i, sum = 0;
 
@@ -1439,7 +1439,7 @@
 	return sum;
 }
 
-unsigned long nr_iowait(void)
+static unsigned long o1_nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
@@ -2257,7 +2257,7 @@
  * Return current->sched_time plus any more ns on the sched_clock
  * that have not yet been banked.
  */
-unsigned long long current_sched_time(const task_t *tsk)
+unsigned long long o1_current_sched_time(const task_t *tsk)
 {
 	unsigned long long ns;
 	unsigned long flags;
@@ -2290,7 +2290,7 @@
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in user space since the last update
  */
-void account_user_time(struct task_struct *p, cputime_t cputime)
+static void o1_account_user_time(struct task_struct *p, cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp;
@@ -2311,8 +2311,8 @@
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in kernel space since the last update
  */
-void account_system_time(struct task_struct *p, int hardirq_offset,
-			 cputime_t cputime)
+static void o1_account_system_time(struct task_struct *p, int hardirq_offset,
+                                   cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
@@ -2343,7 +2343,7 @@
  * @p: the process from which the cpu time has been stolen
  * @steal: the cpu time spent in involuntary wait
  */
-void account_steal_time(struct task_struct *p, cputime_t steal)
+static void o1_account_steal_time(struct task_struct *p, cputime_t steal)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp = cputime_to_cputime64(steal);
@@ -2366,7 +2366,7 @@
  * It also gets called by the fork code, when changing the parent's
  * timeslices.
  */
-void scheduler_tick(void)
+static void o1_scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
@@ -2619,7 +2619,7 @@
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void __sched schedule(void)
+static asmlinkage void __sched o1_schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -2789,8 +2789,6 @@
 		goto need_resched;
 }
 
-EXPORT_SYMBOL(schedule);
-
 #ifdef CONFIG_PREEMPT
 /*
  * this is is the entry point to schedule() from in-kernel preemption
@@ -3186,7 +3184,7 @@
 
 EXPORT_SYMBOL(sleep_on_timeout);
 
-void set_user_nice(task_t *p, long nice)
+static void o1_set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
 	prio_array_t *array;
@@ -3233,8 +3231,6 @@
 	task_rq_unlock(rq, &flags);
 }
 
-EXPORT_SYMBOL(set_user_nice);
-
 #ifdef __ARCH_WANT_SYS_NICE
 
 /*
@@ -3314,18 +3310,16 @@
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
  */
-int idle_cpu(int cpu)
+static int o1_idle_cpu(int cpu)
 {
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
 
-EXPORT_SYMBOL_GPL(idle_cpu);
-
 /**
  * idle_task - return the idle task for a given cpu.
  * @cpu: the processor in question.
  */
-task_t *idle_task(int cpu)
+static task_t *o1_idle_task(int cpu)
 {
 	return cpu_rq(cpu)->idle;
 }
@@ -3358,7 +3352,8 @@
  * @policy: new policy.
  * @param: structure containing the new RT priority.
  */
-int sched_setscheduler(struct task_struct *p, int policy, struct sched_param *param)
+static int o1_sched_setscheduler(struct task_struct *p, int policy, 
+                                 struct sched_param *param)
 {
 	int retval;
 	int oldprio, oldpolicy = -1;
@@ -3425,7 +3420,6 @@
 	task_rq_unlock(rq, &flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sched_setscheduler);
 
 static int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
@@ -3677,7 +3671,7 @@
  * to the expired array. If there are no other threads running on this
  * CPU then this function will return.
  */
-asmlinkage long sys_sched_yield(void)
+static long o1_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
 	prio_array_t *array = current->array;
@@ -3723,6 +3717,11 @@
 	return 0;
 }
 
+asmlinkage long sys_sched_yield(void)
+{
+        return do_sched_yield();
+}
+
 static inline void __cond_resched(void)
 {
 	do {
@@ -3810,7 +3809,7 @@
  * But don't do that if it is a deliberate, throttling IO wait (this task
  * has set its backing_dev_info: the queue against which it should throttle)
  */
-void __sched io_schedule(void)
+static void __sched o1_io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 
@@ -3819,9 +3818,7 @@
 	atomic_dec(&rq->nr_iowait);
 }
 
-EXPORT_SYMBOL(io_schedule);
-
-long __sched io_schedule_timeout(long timeout)
+static long __sched o1_io_schedule_timeout(long timeout)
 {
 	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 	long ret;
@@ -4014,7 +4011,7 @@
 	read_unlock(&tasklist_lock);
 }
 
-void __devinit init_idle(task_t *idle, int cpu)
+static void o1_init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
@@ -4023,7 +4020,6 @@
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
-	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
 
 	spin_lock_irqsave(&rq->lock, flags);
@@ -4074,13 +4070,15 @@
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-int set_cpus_allowed(task_t *p, cpumask_t new_mask)
+static int set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
 	unsigned long flags;
 	int ret = 0;
 	migration_req_t req;
 	runqueue_t *rq;
 
+	perfctr_set_cpus_allowed(p, new_mask);
+
 	rq = task_rq_lock(p, &flags);
 	if (!cpus_intersects(new_mask, cpu_online_map)) {
 		ret = -EINVAL;
@@ -4105,8 +4103,6 @@
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(set_cpus_allowed);
-
 /*
  * Move (not current) task off this cpu, onto dest cpu.  We're doing
  * this because either it can't run here any more (set_cpus_allowed()
@@ -4915,7 +4911,7 @@
 		&& addr < (unsigned long)__sched_text_end);
 }
 
-void __init sched_init(void)
+static void o1_sched_init(void)
 {
 	runqueue_t *rq;
 	int i, j, k;
@@ -5017,3 +5013,69 @@
 }
 
 #endif /* CONFIG_MAGIC_SYSRQ */
+
+struct scheduler o1_scheduler = {
+        .list		= LIST_HEAD_INIT(o1_scheduler.list),
+	.name		= "host_o1_scheduler",
+        .container	= &init_task,
+	.is_guest	= 0,
+        .inode		= 0,
+        .wakeup		= COMPLETION_INITIALIZER(o1_scheduler.wakeup),
+        .lock		= SPIN_LOCK_UNLOCKED,
+        .incoming	= LIST_HEAD_INIT(o1_scheduler.incoming),
+	.task_ops	= {
+		.schedule		= o1_schedule,
+		.io_schedule		= o1_io_schedule,
+		.io_schedule_timeout	= o1_io_schedule_timeout,
+#ifdef CONFIG_SMP
+		.wait_task_inactive	= o1_wait_task_inactive,
+#endif
+		.wake_up_new_task	= o1_wake_up_new_task,
+                .sched_exit		= o1_sched_exit,
+                .schedule_tail		= o1_schedule_tail,
+		.set_user_nice		= o1_set_user_nice,
+		.sched_setscheduler	= o1_sched_setscheduler,
+#ifdef CONFIG_SMP
+		.set_cpus_allowed	= o1_set_cpus_allowed,
+#endif
+		.sched_yield		= o1_sched_yield,
+                .nr_running		= o1_nr_running,
+                .nr_uninterruptible	= o1_nr_uninterruptible,
+                .nr_context_switches	= o1_nr_context_switches,
+                .nr_iowait		= o1_nr_iowait,
+                .current_sched_time	= o1_current_sched_time,
+                .account_user_time	= o1_account_user_time,
+                .account_system_time	= o1_account_system_time,
+                .account_steal_time	= o1_account_steal_time,
+                .scheduler_tick		= o1_scheduler_tick,
+                .idle_cpu		= o1_idle_cpu,
+                .idle_task		= o1_idle_task,
+                .task_timeslice		= o1_task_timeslice,
+                .try_to_wake_up		= o1_try_to_wake_up,
+                .sched_init_fn		= o1_sched_init,
+                .task_curr		= o1_task_curr,
+                .init_idle		= o1_init_idle,
+	},
+};
+
+static int init_scheduler(void)
+{
+        char *name = THIS_MODULE ? THIS_MODULE->name : o1_scheduler.name;
+	int err;
+
+        err = init_sched_instance(&o1_scheduler);
+        if(err)
+                goto error;
+                
+	err = register_scheduler(&o1_scheduler, name);
+        if(err)
+                goto error;
+
+        return 0;
+
+ error:
+        uninit_sched_instance(&o1_scheduler);
+	return err;
+}
+
+postcore_initcall(init_scheduler);
Index: guest-sched-2.6.11/kernel/sched_group.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/sched_group.c	2003-09-15 09:40:47.000000000 -0400
+++ guest-sched-2.6.11/kernel/sched_group.c	2005-04-20 20:58:20.000000000 -0400
@@ -0,0 +1,138 @@
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+
+static LIST_HEAD(schedulers);
+static DEFINE_SPINLOCK(schedulers_lock);
+
+static struct proc_dir_entry *schedulers_entry = NULL;
+static struct proc_dir_entry *sched_groups_entry = NULL;
+
+static int init_schedulers(void)
+{
+	schedulers_entry = proc_mkdir("schedulers", NULL);
+        sched_groups_entry = proc_mkdir("sched-groups", NULL);
+	return 0;
+}
+
+core_initcall(init_schedulers);
+
+static int scheduler_open(struct inode *inode, struct file *file)
+{
+        struct scheduler *s, *found = NULL;
+        struct list_head *entry;
+        int err = -ENOENT;
+
+        spin_lock(&schedulers_lock);
+        list_for_each(entry, &schedulers){
+                s = list_entry(entry, struct scheduler, list);
+                if(s->inode == inode->i_ino){
+                        found = s;
+                        break;
+                }
+        }
+        spin_unlock(&schedulers_lock);
+
+        if(found == NULL)
+                goto out;
+
+        err = -EPERM;
+        if(!found->is_guest)
+                goto out;
+
+        found->task_ops.sched_init_fn();
+
+ out:
+        return -EINVAL;
+}
+
+static struct file_operations scheduler_file_ops = {
+        .open	= scheduler_open,
+};
+
+int register_scheduler(struct scheduler *scheduler, char *name)
+{
+	struct proc_dir_entry *entry;
+	int err = -ENOENT;
+
+	if(schedulers_entry == NULL)
+		goto out_none;
+
+	spin_lock(&schedulers_lock);
+	list_add(&scheduler->list, &schedulers);
+
+	entry = create_proc_entry(name, 0444, schedulers_entry);
+	if(entry == NULL)
+		goto out_del;
+
+        entry->proc_fops = &scheduler_file_ops;
+        scheduler->inode = entry->low_ino;
+
+	printk("Registering scheduler '%s'\n", scheduler->name);
+	err = 0;
+
+ out:
+	spin_unlock(&schedulers_lock);
+ out_none:
+	return err;
+
+ out_del:
+	list_del(&scheduler->list);
+        goto out;
+}
+
+EXPORT_SYMBOL(register_scheduler);
+
+extern int sched_group_readdir(struct file * filp, void * dirent, 
+                               filldir_t filldir);
+
+static struct file_operations sched_group_file_ops = {
+	.read		= generic_read_dir,
+	.readdir	= sched_group_readdir,
+};
+
+extern struct dentry *sched_group_lookup(struct inode *dir, 
+                                         struct dentry * dentry, 
+                                         struct nameidata *nd);
+
+static struct inode_operations sched_group_inode_ops = {
+	.lookup		= sched_group_lookup,
+};
+
+int register_sched_group(int pid, struct scheduler *scheduler)
+{
+        struct proc_dir_entry *entry;
+        char name[sizeof("12345\0")];
+        int err = -ENOENT;
+
+        if(sched_groups_entry == NULL)
+                goto out;
+        
+        sprintf(name, "%d", pid);
+        entry = proc_mkdir(name, sched_groups_entry);
+        if(entry == NULL)
+                goto out;
+
+        entry->data = scheduler;
+	entry->proc_fops = &sched_group_file_ops;
+	entry->proc_iops = &sched_group_inode_ops;
+
+        err = 0;
+        printk("Created sched_group %d ('%s')\n", pid, scheduler->name);
+ out:
+        return err;
+}
+
+EXPORT_SYMBOL(register_sched_group);
+
+int task_sched_pid(struct task_struct *task)
+{
+        return(task->scheduler->container->pid);
+}
+
+int sched_pid(void *scheduler)
+{
+        return(((struct scheduler *) scheduler)->container->pid);
+}

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=guest-sched-guest

Index: guest-sched-2.6.11/arch/um/defconfig
===================================================================
--- guest-sched-2.6.11.orig/arch/um/defconfig	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/arch/um/defconfig	2005-04-20 17:39:27.000000000 -0400
@@ -6,6 +6,7 @@
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_USERMODE=y
 CONFIG_MMU=y
+# CONFIG_GUEST_SCHED is not set
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
Index: guest-sched-2.6.11/arch/um/kernel/ksyms.c
===================================================================
--- guest-sched-2.6.11.orig/arch/um/kernel/ksyms.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/arch/um/kernel/ksyms.c	2005-04-20 17:39:27.000000000 -0400
@@ -122,6 +122,10 @@
 EXPORT_SYMBOL(kmap_atomic_to_page);
 #endif
 
+#ifdef CONFIG_MODE_SKAS
+EXPORT_SYMBOL(switch_mm_skas);
+#endif
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: guest-sched-2.6.11/arch/um/kernel/process_kern.c
===================================================================
--- guest-sched-2.6.11.orig/arch/um/kernel/process_kern.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/arch/um/kernel/process_kern.c	2005-04-20 17:39:27.000000000 -0400
@@ -129,6 +129,8 @@
 			   switch_to_skas(prev, next)));
 }
 
+EXPORT_SYMBOL(_switch_to);
+
 int interrupt_end(void)
 {
 	if(need_resched()) schedule();
Index: guest-sched-2.6.11/arch/um/kernel/signal_kern.c
===================================================================
--- guest-sched-2.6.11.orig/arch/um/kernel/signal_kern.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/arch/um/kernel/signal_kern.c	2005-04-20 17:39:27.000000000 -0400
@@ -146,6 +146,8 @@
 	return(kern_do_signal(&current->thread.regs, &current->blocked));
 }
 
+EXPORT_SYMBOL(do_signal);
+
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
Index: guest-sched-2.6.11/arch/um/kernel/time_kern.c
===================================================================
--- guest-sched-2.6.11.orig/arch/um/kernel/time_kern.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/arch/um/kernel/time_kern.c	2005-04-20 17:39:27.000000000 -0400
@@ -39,6 +39,8 @@
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
+EXPORT_SYMBOL(sched_clock);
+
 /* Changed at early boot */
 int timer_irq_inited = 0;
 
Index: guest-sched-2.6.11/include/linux/rcupdate.h
===================================================================
--- guest-sched-2.6.11.orig/include/linux/rcupdate.h	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/include/linux/rcupdate.h	2005-04-20 17:39:27.000000000 -0400
@@ -123,6 +123,8 @@
 	rdp->passed_quiesc = 1;
 }
 
+extern void rcu_qsctr_inc_fn(int cpu);
+
 static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
 						struct rcu_data *rdp)
 {
Index: guest-sched-2.6.11/include/linux/sched.h
===================================================================
--- guest-sched-2.6.11.orig/include/linux/sched.h	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/include/linux/sched.h	2005-04-20 17:39:27.000000000 -0400
@@ -263,6 +263,8 @@
         void (*sched_init_fn)(void);
         int (*task_curr)(const task_t *p);
         void (*init_idle)(task_t *idle, int cpu);
+        void (*sched_add_task)(struct task_struct *p);
+        void (*sched_remove_task)(struct task_struct *p);
 };
 
 struct scheduler {
Index: guest-sched-2.6.11/init/Kconfig
===================================================================
--- guest-sched-2.6.11.orig/init/Kconfig	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/init/Kconfig	2005-04-20 17:39:27.000000000 -0400
@@ -369,6 +369,10 @@
 	  no dummy operations need be executed.
 	  Zero means use compiler's default.
 
+config GUEST_SCHED
+	tristate "Guest scheduler"
+	default n
+
 endmenu		# General setup
 
 config TINY_SHMEM
Index: guest-sched-2.6.11/kernel/Makefile
===================================================================
--- guest-sched-2.6.11.orig/kernel/Makefile	2005-04-20 17:28:03.000000000 -0400
+++ guest-sched-2.6.11/kernel/Makefile	2005-04-20 17:39:55.000000000 -0400
@@ -2,7 +2,8 @@
 # Makefile for the linux kernel.
 #
 
-obj-y     = sched.o o1_sched.o host_sched.o fork.o exec_domain.o panic.o printk.o \
+obj-y     = sched.o host_o1_sched.o fork.o exec_domain.o panic.o printk.o \
+	    profile.o exit.o itimer.o time.o softirq.o resource.o \
 	    profile.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
@@ -30,6 +31,35 @@
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 
+ifeq ($(CONFIG_GUEST_SCHED),y)
+obj-$(CONFIG_GUEST_SCHED) += guest_o1_sched.o
+
+else
+obj-$(CONFIG_GUEST_SCHED) += guest_o1_scheduler.o
+endif
+
+$(obj)/guest_o1_scheduler.o : $(obj)/guest_sched.o $(obj)/o1_sched2.o
+	$(call if_changed,link_multi-$(CONFIG_GUEST_SCHED))
+
+$(obj)/o1_sched2.o : $(obj)/o1_sched2.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/o1_sched2.c : $(obj)/o1_sched.c
+	ln -sf $(notdir $<) $@
+
+$(obj)/host_o1_scheduler.o : $(obj)/%_o1_scheduler.o : $(obj)/%_sched.o $(obj)/o1_sched.o
+	$(call if_changed,link_multi-y)
+
+host_o1_scheduler-y := o1_sched.o host_sched.o
+guest_o1_scheduler-y := o1_sched2.o guest_sched.o
+
+localize = init_sched_instance uninit_sched_instance \
+	$(if $(findstring host,$(1)),,o1_scheduler)
+
+$(obj)/guest_o1_sched.o $(obj)/host_o1_sched.o : $(obj)/%_o1_sched.o : $(obj)/%_o1_scheduler.o 
+	objcopy $(foreach s,$(call localize,$<),--localize-symbol=$(s)) $< $@
+
+
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
Index: guest-sched-2.6.11/kernel/acct.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/acct.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/kernel/acct.c	2005-04-20 17:39:27.000000000 -0400
@@ -54,6 +54,7 @@
 #include <linux/jiffies.h>
 #include <linux/times.h>
 #include <linux/syscalls.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
@@ -547,6 +548,8 @@
 	}
 }
 
+EXPORT_SYMBOL(acct_update_integrals);
+
 /*
  * acct_clear_integrals
  *    - clear the mm integral fields in task_struct
Index: guest-sched-2.6.11/kernel/fork.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/fork.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/kernel/fork.c	2005-04-20 17:39:27.000000000 -0400
@@ -103,6 +103,8 @@
 		free_task(tsk);
 }
 
+EXPORT_SYMBOL(__put_task_struct);
+
 void __init fork_init(unsigned long mempages)
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
@@ -341,6 +343,8 @@
 	free_mm(mm);
 }
 
+EXPORT_SYMBOL(__mmdrop);
+
 /*
  * Decrement the use count and release all resources for an mm.
  */
Index: guest-sched-2.6.11/kernel/guest_sched.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/guest_sched.c	2003-09-15 09:40:47.000000000 -0400
+++ guest-sched-2.6.11/kernel/guest_sched.c	2005-04-20 17:39:27.000000000 -0400
@@ -0,0 +1,143 @@
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/module.h>
+#include <asm/mmu_context.h>
+
+static struct scheduler *guest_scheduler;
+static struct task_struct *guest_idle_task, *tick_task;
+
+/* This is a cut-down version of context_switch().  It's not doing the lazy
+ * TLB stuff, or keeping rq->{active,prev}_mm up to date (which it can't),
+ * which makes me nervous about its correctness.
+ * This is for the container process and the contained idle thread to switch
+ * back and forth without going through schedule(), which they can't.
+ */
+static void do_switch(struct task_struct *from, struct task_struct *to)
+{
+	struct mm_struct *mm = to->mm;
+	struct mm_struct *oldmm = from->active_mm;
+
+        if(mm != NULL)
+                switch_mm(oldmm, mm, to);
+
+        _switch_to(from, to, NULL);
+}
+
+static void (*host_sched_init)(void);
+
+static int initialized = 0;
+
+/* The guest idle thread just calls schedule within its own group, and when
+ * it gets control back, none of its processes need CPU, so it switches back
+ * to the container process, which will sleep in the host scheduler.
+ */
+static int guest_idle(void *unused)
+{
+        (*host_sched_init)();
+        initialized = 1;
+
+        while(1){
+                schedule();
+                do_switch(current, guest_scheduler->container);
+        }
+
+        return 0;
+}
+
+static int (*host_try_to_wake_up)(task_t *p, unsigned int state, int sync);
+
+/* Some random process, in some completely different scheduler, may wake up
+ * a process in this scheduler.  So, in addition to performing the normal
+ * wake-up on this process, we also need to wake the container process so that
+ * it can schedule the woken-up process.  This is done with the completion,
+ * on which the container is sleeping in the host scheduler.
+ */
+static int guest_try_to_wake_up(task_t *p, unsigned int state, int sync)
+{
+        int ret = (*host_try_to_wake_up)(p, state, sync);
+        complete(&p->scheduler->wakeup);
+
+        return ret;
+}
+
+static void (*host_scheduler_tick)(void);
+
+/* When a tick comes in on a process in a guest scheduler, we need to have
+ * the container process in the host scheduler call scheduler_tick first, in
+ * case the container needs to be switched out.  When we come back from that,
+ * we can do our own tick, out own accounting, and a schedule, if needed.
+ * Setting tick_task to non-NULL is a kludge - this is probably better done
+ * by making do_switch return something in the container process, a la setjmp.
+ */
+static void guest_scheduler_tick(void)
+{
+        if(!initialized)
+                return;
+
+        tick_task = current;
+        do_switch(current, guest_scheduler->container);
+        (*host_scheduler_tick)();
+}
+
+static void guest_sched_init(void)
+{
+        struct task_struct *guest_task;
+        int pid = kernel_thread(guest_idle, NULL, CLONE_FS | CLONE_FILES | 
+                            CLONE_SIGHAND | CLONE_STOPPED | SIGCHLD);
+
+        if(pid < 0)
+                return;
+
+        guest_idle_task = find_task_by_pid(pid);
+        if(guest_idle_task == NULL)
+                return;
+
+        guest_idle_task->scheduler = guest_scheduler;
+        guest_scheduler->container = current;
+
+        register_sched_group(current->pid, guest_scheduler);
+
+        guest_task = guest_idle_task;
+        while(1){
+                INIT_COMPLETION(guest_scheduler->wakeup);
+                
+                do_switch(current, guest_task);
+                if(tick_task != NULL){
+                        guest_task = tick_task;
+                        tick_task = NULL;
+                        scheduler_tick();
+
+                        if(need_resched()) schedule();
+                        if(test_tsk_thread_flag(current, TIF_SIGPENDING)) 
+                                do_signal();
+                }
+                else {
+                        wait_for_completion(&guest_scheduler->wakeup);
+                        guest_task = guest_idle_task;
+                }
+        }
+}
+
+int init_sched_instance(struct scheduler *scheduler)
+{
+        scheduler->name = "guest_o1_scheduler";
+        scheduler->container = NULL;
+        scheduler->is_guest = 1;
+
+        host_sched_init = scheduler->task_ops.sched_init_fn;
+        scheduler->task_ops.sched_init_fn = guest_sched_init;
+
+        host_try_to_wake_up = scheduler->task_ops.try_to_wake_up;
+        scheduler->task_ops.try_to_wake_up = guest_try_to_wake_up;
+
+        host_scheduler_tick = scheduler->task_ops.scheduler_tick;
+        scheduler->task_ops.scheduler_tick = guest_scheduler_tick;
+
+        guest_scheduler = scheduler;
+        return 0;
+}
+
+void uninit_sched_instance(struct scheduler *scheduler)
+{
+}
+
Index: guest-sched-2.6.11/kernel/o1_sched.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/o1_sched.c	2005-04-20 17:28:35.000000000 -0400
+++ guest-sched-2.6.11/kernel/o1_sched.c	2005-04-20 17:48:20.000000000 -0400
@@ -711,6 +711,16 @@
 	__activate_task(p, rq);
 }
 
+static void o1_sched_add_task(task_t *p)
+{
+	unsigned long flags;
+	runqueue_t *rq;
+        
+	rq = task_rq_lock(p, &flags);
+        activate_task(p, rq, 0);
+        task_rq_unlock(rq, &flags);
+}
+
 /*
  * deactivate_task - remove a task from the runqueue.
  */
@@ -721,6 +731,16 @@
 	p->array = NULL;
 }
 
+static void o1_sched_remove_task(struct task_struct *p)
+{
+	unsigned long flags;
+	runqueue_t *rq;
+        
+	rq = task_rq_lock(p, &flags);
+        deactivate_task(p, rq);
+        task_rq_unlock(rq, &flags);
+}
+
 /*
  * resched_task - mark a task 'to be rescheduled now'.
  *
@@ -2678,7 +2698,7 @@
 		schedstat_inc(rq, sched_goidle);
 	prefetch(next);
 	clear_tsk_need_resched(prev);
-	rcu_qsctr_inc(task_cpu(prev));
+	rcu_qsctr_inc_fn(task_cpu(prev));
 
 	update_cpu_clock(prev, rq, now);
 
@@ -3480,6 +3500,8 @@
                 .sched_init_fn		= o1_sched_init,
                 .task_curr		= o1_task_curr,
                 .init_idle		= o1_init_idle,
+                .sched_add_task		= o1_sched_add_task,
+                .sched_remove_task	= o1_sched_remove_task,
 	},
 };
 
@@ -3504,3 +3526,5 @@
 }
 
 postcore_initcall(init_scheduler);
+
+MODULE_LICENSE("GPL");
Index: guest-sched-2.6.11/kernel/profile.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/profile.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/kernel/profile.c	2005-04-20 17:39:27.000000000 -0400
@@ -379,6 +379,8 @@
 }
 #endif /* !CONFIG_SMP */
 
+EXPORT_SYMBOL(profile_hit);
+
 void profile_tick(int type, struct pt_regs *regs)
 {
 	if (type == CPU_PROFILING && timer_hook)
Index: guest-sched-2.6.11/kernel/rcupdate.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/rcupdate.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/kernel/rcupdate.c	2005-04-20 17:39:27.000000000 -0400
@@ -72,6 +72,13 @@
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int maxbatch = 10;
 
+void rcu_qsctr_inc_fn(int cpu)
+{
+        rcu_qsctr_inc(cpu);
+}
+
+EXPORT_SYMBOL(rcu_qsctr_inc_fn);
+
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
Index: guest-sched-2.6.11/kernel/sched_group.c
===================================================================
--- guest-sched-2.6.11.orig/kernel/sched_group.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/kernel/sched_group.c	2005-04-20 17:39:27.000000000 -0400
@@ -97,8 +97,60 @@
                                          struct dentry * dentry, 
                                          struct nameidata *nd);
 
+static int proc_tgid_rename(struct inode *from_dir, struct dentry *from_file, 
+                            struct inode *to_dir, struct dentry *to_file)
+{
+        struct proc_dir_entry *entry = PDE(to_dir);
+        struct task_struct *task;
+	char *end;
+        int err = -EINVAL;
+        int pid = simple_strtoul(from_file->d_name.name, &end, 10);
+
+        if(*end != '\0')
+                goto out;
+
+        err = -ENOENT;
+        read_lock(&tasklist_lock);
+	task = find_task_by_pid(pid);
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
+        if(task == NULL)
+                goto out;
+        
+        if(task->state == TASK_RUNNING){
+#ifdef CONFIG_SMP
+                /* What I think we need to do here is force both current and
+                 * the moving process onto the same CPU.  Then when we are 
+                 * running, we know that the other guy has context-switched,
+                 * and it not about to try to call schedule() or do anything
+                 * else tricky.
+                 * As for an implementation, what I have in mind is:
+                 *    find the common parent scheduler of these two processes
+                 *    force the container processes of these processes (which
+                 *        may be the process itself) onto the same (possibly
+                 *        virtual) CPU
+                 *    Do the move
+                 *    restore the CPU masks of the processes
+                 */
+#endif
+                sched_remove_task(task);
+                task->scheduler = entry->data;
+                sched_add_task(task);
+
+                wake_up_process(task);
+        }
+        else task->scheduler = entry->data;
+
+        put_task_struct(task);
+        err = 0;
+ out:
+        return err;
+}
+
 static struct inode_operations sched_group_inode_ops = {
 	.lookup		= sched_group_lookup,
+        .rename		= proc_tgid_rename,
 };
 
 int register_sched_group(int pid, struct scheduler *scheduler)
Index: guest-sched-2.6.11/mm/memory.c
===================================================================
--- guest-sched-2.6.11.orig/mm/memory.c	2005-04-20 17:10:31.000000000 -0400
+++ guest-sched-2.6.11/mm/memory.c	2005-04-20 17:39:27.000000000 -0400
@@ -2269,6 +2269,8 @@
 	}
 }
 
+EXPORT_SYMBOL(update_mem_hiwater);
+
 #if !defined(__HAVE_ARCH_GATE_AREA)
 
 #if defined(AT_SYSINFO_EHDR)

--TB36FDmn/VVEgNH/--
