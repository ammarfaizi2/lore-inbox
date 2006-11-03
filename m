Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753082AbWKCE20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbWKCE20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbWKCE16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:27:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:900 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753087AbWKCE1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:27:53 -0500
Message-Id: <20061103042750.874577000@us.ibm.com>
References: <20061103042257.274316000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 02 Nov 2006 20:23:06 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/9] Task Watchers v2: Register process events connector
Content-Disposition: inline; filename=task-watchers-register-procevents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the Process events connector use task watchers instead of hooking the
paths it's interested in.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 drivers/connector/cn_proc.c |   52 +++++++++++++++++++++++++++++++-------------
 fs/exec.c                   |    1 
 include/linux/cn_proc.h     |   21 -----------------
 kernel/exit.c               |    2 -
 kernel/fork.c               |    2 -
 kernel/sys.c                |    9 -------
 6 files changed, 37 insertions(+), 50 deletions(-)

Benchmark results:
System: 4 1.7GHz ppc64 (Power 4+) processors, 30968600MB RAM, 2.6.19-rc2-mm2 kernel

Clone	Number of Children Cloned
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17602.2 	17876.7 	17977.4 	18075.5 	18134.3 	18151.5
Dev	291.294 	376.373 	277.882 	288.971 	278.25	 	276.3
Err (%)	1.65487 	2.10539 	1.54573 	1.59869 	1.53439 	1.52219

Fork	Number of Children Forked
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17691.1 	17770.9 	17932.6 	17996 		18096.4 	18142.9
Dev	300.692 	291.913 	296.654 	279.183 	290.228 	284.693
Err (%)	1.69968 	1.64265 	1.65428 	1.55136 	1.60379 	1.56917

Kernbench:
Elapsed: 124.359s User: 439.756s System: 46.457s CPU: 390.3%
439.87user 46.42system 2:04.44elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.68user 46.42system 2:04.15elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.72user 46.64system 2:04.40elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.81user 46.42system 2:03.92elapsed 392%CPU (0avgtext+0avgdata 0maxresident)k
439.77user 46.39system 2:04.48elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.66user 46.41system 2:04.70elapsed 389%CPU (0avgtext+0avgdata 0maxresident)k
439.73user 46.59system 2:04.42elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.97user 46.46system 2:04.45elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.62user 46.40system 2:04.33elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.73user 46.42system 2:04.30elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k

Index: linux-2.6.19-rc2-mm2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.19-rc2-mm2/drivers/connector/cn_proc.c
@@ -25,10 +25,11 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/init.h>
 #include <linux/connector.h>
+#include <linux/task_watchers.h>
 #include <asm/atomic.h>
 
 #include <linux/cn_proc.h>
 
 #define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct proc_event))
@@ -44,19 +45,20 @@ static inline void get_seq(__u32 *ts, in
 	*ts = get_cpu_var(proc_event_counts)++;
 	*cpu = smp_processor_id();
 	put_cpu_var(proc_event_counts);
 }
 
-void proc_fork_connector(struct task_struct *task)
+static int proc_fork_connector(unsigned long clone_flags,
+			       struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
+		return 0;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
@@ -70,21 +72,24 @@ void proc_fork_connector(struct task_str
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	/*  If cn_netlink_send() failed, the data is not sent */
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	return 0;
 }
+task_watcher_func(clone, proc_fork_connector);
 
-void proc_exec_connector(struct task_struct *task)
+static int proc_exec_connector(unsigned long ignore,
+			       struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	struct timespec ts;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
+		return 0;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
@@ -95,21 +100,23 @@ void proc_exec_connector(struct task_str
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	return 0;
 }
+task_watcher_func(exec, proc_exec_connector);
 
-void proc_id_connector(struct task_struct *task, int which_id)
+static int process_change_id(unsigned long which_id, struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
+		return 0;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	ev->what = which_id;
 	ev->event_data.id.process_pid = task->pid;
@@ -119,47 +126,64 @@ void proc_id_connector(struct task_struc
 	 	ev->event_data.id.e.euid = task->euid;
 	} else if (which_id == PROC_EVENT_GID) {
 	   	ev->event_data.id.r.rgid = task->gid;
 	   	ev->event_data.id.e.egid = task->egid;
 	} else
-	     	return;
+	     	return 0;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
 	ev->timestamp_ns = timespec_to_ns(&ts);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	return 0;
+}
+
+static int proc_change_uid_connector(unsigned long ignore,
+				     struct task_struct *task)
+{
+	return process_change_id(PROC_EVENT_UID, task);
+}
+task_watcher_func(uid, proc_change_uid_connector);
+
+static int proc_change_gid_connector(unsigned long ignore,
+				     struct task_struct *task)
+{
+	return process_change_id(PROC_EVENT_GID, task);
 }
+task_watcher_func(gid, proc_change_gid_connector);
 
-void proc_exit_connector(struct task_struct *task)
+static int proc_exit_connector(unsigned long code, struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
+		return 0;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
 	ev->timestamp_ns = timespec_to_ns(&ts);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
-	ev->event_data.exit.exit_code = task->exit_code;
+	ev->event_data.exit.exit_code = code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	return 0;
 }
+task_watcher_func(exit, proc_exit_connector);
 
 /*
  * Send an acknowledgement message to userspace
  *
  * Use 0 for success, EFOO otherwise.
@@ -226,14 +250,12 @@ static void cn_proc_mcast_ctl(void *data
  */
 static int __init cn_proc_init(void)
 {
 	int err;
 
-	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
-	 			   &cn_proc_mcast_ctl))) {
+	err = cn_add_callback(&cn_proc_event_id, "cn_proc", &cn_proc_mcast_ctl);
+	if (err)
 		printk(KERN_WARNING "cn_proc failed to register\n");
-		return err;
-	}
-	return 0;
+	return err;
 }
 
 module_init(cn_proc_init);
Index: linux-2.6.19-rc2-mm2/kernel/fork.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/fork.c
+++ linux-2.6.19-rc2-mm2/kernel/fork.c
@@ -40,11 +40,10 @@
 #include <linux/mount.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
-#include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
 #include <linux/random.h>
 #include <linux/task_watchers.h>
 
@@ -1212,11 +1211,10 @@ static struct task_struct *copy_process(
 
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	notify_task_watchers(WATCH_TASK_CLONE, clone_flags, p);
-	proc_fork_connector(p);
 	return p;
 
 bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
 bad_fork_cleanup_mm:
Index: linux-2.6.19-rc2-mm2/kernel/exit.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/exit.c
+++ linux-2.6.19-rc2-mm2/kernel/exit.c
@@ -30,11 +30,10 @@
 #include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
 #include <linux/posix-timers.h>
-#include <linux/cn_proc.h>
 #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/resource.h>
@@ -927,11 +926,10 @@ fastcall NORET_TYPE void do_exit(long co
 	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
 	tsk->exit_code = code;
-	proc_exit_connector(tsk);
 	exit_notify(tsk);
 	exit_task_namespaces(tsk);
 	/*
 	 * This must happen late, after the PID is not
 	 * hashed anymore:
Index: linux-2.6.19-rc2-mm2/kernel/sys.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/sys.c
+++ linux-2.6.19-rc2-mm2/kernel/sys.c
@@ -25,11 +25,10 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/signal.h>
-#include <linux/cn_proc.h>
 #include <linux/getcpu.h>
 #include <linux/seccomp.h>
 #include <linux/task_watchers.h>
 
 #include <linux/compat.h>
@@ -957,11 +956,10 @@ asmlinkage long sys_setregid(gid_t rgid,
 	    (egid != (gid_t) -1 && egid != old_rgid))
 		current->sgid = new_egid;
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
-	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
 /*
@@ -992,11 +990,10 @@ asmlinkage long sys_setgid(gid_t gid)
 		current->egid = current->fsgid = gid;
 	}
 	else
 		return -EPERM;
 
-	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
@@ -1080,11 +1077,10 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
@@ -1127,11 +1123,10 @@ asmlinkage long sys_setuid(uid_t uid)
 		smp_wmb();
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
@@ -1175,11 +1170,10 @@ asmlinkage long sys_setresuid(uid_t ruid
 	}
 	current->fsuid = current->euid;
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
@@ -1227,11 +1221,10 @@ asmlinkage long sys_setresgid(gid_t rgid
 	if (rgid != (gid_t) -1)
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
-	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
@@ -1268,11 +1261,10 @@ asmlinkage long sys_setfsuid(uid_t uid)
 			smp_wmb();
 		}
 		current->fsuid = uid;
 	}
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
@@ -1295,11 +1287,10 @@ asmlinkage long sys_setfsgid(gid_t gid)
 		if (gid != old_fsgid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
 		current->fsgid = gid;
-		proc_id_connector(current, PROC_EVENT_GID);
 		notify_task_watchers(WATCH_TASK_GID, 0, current);
 	}
 	return old_fsgid;
 }
 
Index: linux-2.6.19-rc2-mm2/fs/exec.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/fs/exec.c
+++ linux-2.6.19-rc2-mm2/fs/exec.c
@@ -1086,11 +1086,10 @@ int search_binary_handler(struct linux_b
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
 				notify_task_watchers(WATCH_TASK_EXEC, 0,
 						     current);
-				proc_exec_connector(current);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
 			if (retval != -ENOEXEC || bprm->mm == NULL)
Index: linux-2.6.19-rc2-mm2/include/linux/cn_proc.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/linux/cn_proc.h
+++ linux-2.6.19-rc2-mm2/include/linux/cn_proc.h
@@ -95,27 +95,6 @@ struct proc_event {
 			__u32 exit_code, exit_signal;
 		} exit;
 	} event_data;
 };
 
-#ifdef __KERNEL__
-#ifdef CONFIG_PROC_EVENTS
-void proc_fork_connector(struct task_struct *task);
-void proc_exec_connector(struct task_struct *task);
-void proc_id_connector(struct task_struct *task, int which_id);
-void proc_exit_connector(struct task_struct *task);
-#else
-static inline void proc_fork_connector(struct task_struct *task)
-{}
-
-static inline void proc_exec_connector(struct task_struct *task)
-{}
-
-static inline void proc_id_connector(struct task_struct *task,
-				     int which_id)
-{}
-
-static inline void proc_exit_connector(struct task_struct *task)
-{}
-#endif	/* CONFIG_PROC_EVENTS */
-#endif	/* __KERNEL__ */
 #endif	/* CN_PROC_H */

--
