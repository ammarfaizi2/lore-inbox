Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWI2CNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWI2CNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWI2CNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57277 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751311AbWI2CNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:05 -0400
Message-Id: <20060929021302.229026000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:42 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 10/10] Task watchers v2 Register process events connector
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

Index: linux-2.6.18-mm1/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.18-mm1.orig/drivers/connector/cn_proc.c
+++ linux-2.6.18-mm1/drivers/connector/cn_proc.c
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
Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
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
 
@@ -1220,11 +1219,10 @@ static struct task_struct *copy_process(
 
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	notify_task_watchers(WATCH_TASK_CLONE, clone_flags, p);
-	proc_fork_connector(p);
 	return p;
 
 bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
 bad_fork_cleanup_mm:
Index: linux-2.6.18-mm1/kernel/exit.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/exit.c
+++ linux-2.6.18-mm1/kernel/exit.c
@@ -29,11 +29,10 @@
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
@@ -925,11 +924,10 @@ fastcall NORET_TYPE void do_exit(long co
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
Index: linux-2.6.18-mm1/kernel/sys.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/sys.c
+++ linux-2.6.18-mm1/kernel/sys.c
@@ -25,11 +25,10 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/signal.h>
-#include <linux/cn_proc.h>
 #include <linux/task_watchers.h>
 #include <linux/getcpu.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -956,11 +955,10 @@ asmlinkage long sys_setregid(gid_t rgid,
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
@@ -991,11 +989,10 @@ asmlinkage long sys_setgid(gid_t gid)
 		current->egid = current->fsgid = gid;
 	}
 	else
 		return -EPERM;
 
-	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
@@ -1079,11 +1076,10 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
@@ -1126,11 +1122,10 @@ asmlinkage long sys_setuid(uid_t uid)
 		smp_wmb();
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
@@ -1174,11 +1169,10 @@ asmlinkage long sys_setresuid(uid_t ruid
 	}
 	current->fsuid = current->euid;
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
@@ -1226,11 +1220,10 @@ asmlinkage long sys_setresgid(gid_t rgid
 	if (rgid != (gid_t) -1)
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
-	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
@@ -1267,11 +1260,10 @@ asmlinkage long sys_setfsuid(uid_t uid)
 			smp_wmb();
 		}
 		current->fsuid = uid;
 	}
 
-	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
@@ -1294,11 +1286,10 @@ asmlinkage long sys_setfsgid(gid_t gid)
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
 
Index: linux-2.6.18-mm1/fs/exec.c
===================================================================
--- linux-2.6.18-mm1.orig/fs/exec.c
+++ linux-2.6.18-mm1/fs/exec.c
@@ -1085,11 +1085,10 @@ int search_binary_handler(struct linux_b
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
Index: linux-2.6.18-mm1/include/linux/cn_proc.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/cn_proc.h
+++ linux-2.6.18-mm1/include/linux/cn_proc.h
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
