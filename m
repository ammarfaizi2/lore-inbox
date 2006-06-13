Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWFNABl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWFNABl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWFNABl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:01:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:26280 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964800AbWFNABj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:01:39 -0400
Subject: [PATCH 02/11] Task watchers:  Register process events task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:33 -0700
Message-Id: <1150242874.21787.142.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes process events utilize task watchers instead of calling from
fork, exec, exit, and [re][ug]id changes directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
--

 drivers/connector/cn_proc.c |   65 +++++++++++++++++++++++++++++++++++++-------
 fs/exec.c                   |    2 -
 include/linux/cn_proc.h     |   22 --------------
 kernel/exit.c               |    2 -
 kernel/fork.c               |    7 +---
 kernel/sys.c                |    8 -----
 6 files changed, 57 insertions(+), 49 deletions(-)

Index: linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
@@ -25,10 +25,11 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/init.h>
 #include <linux/connector.h>
+#include <linux/notifier.h>
 #include <asm/atomic.h>
 
 #include <linux/cn_proc.h>
 
 #define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct proc_event))
@@ -44,11 +45,11 @@ static inline void get_seq(__u32 *ts, in
 	*ts = get_cpu_var(proc_event_counts)++;
 	*cpu = smp_processor_id();
 	put_cpu_var(proc_event_counts);
 }
 
-void proc_fork_connector(struct task_struct *task)
+static void proc_fork_connector(struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
@@ -67,14 +68,14 @@ void proc_fork_connector(struct task_str
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	/*  If cn_netlink_send() failed, the data is not sent */
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
-void proc_exec_connector(struct task_struct *task)
+static void proc_exec_connector(struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
@@ -90,14 +91,14 @@ void proc_exec_connector(struct task_str
 	ev->event_data.exec.process_tgid = task->tgid;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
-void proc_id_connector(struct task_struct *task, int which_id)
+static void proc_id_connector(struct task_struct *task, int which_id)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
@@ -121,14 +122,14 @@ void proc_id_connector(struct task_struc
 	ktime_get_ts(&ev->timestamp);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
-void proc_exit_connector(struct task_struct *task)
+static void proc_exit_connector(struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
@@ -146,11 +147,11 @@ void proc_exit_connector(struct task_str
 	ev->event_data.exit.exit_signal = task->exit_signal;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
 /*
  * Send an acknowledgement message to userspace
  *
@@ -207,10 +208,49 @@ static void cn_proc_mcast_ctl(void *data
 		break;
 	}
 	cn_proc_ack(err, msg->seq, msg->ack);
 }
 
+
+/*
+ * Dispatch task watcher events to the appropriate process event
+ * generation function.
+ */
+static int cn_proc_watch_task(struct notifier_block *nb, unsigned long val,
+			      void *t)
+{
+	struct task_struct *task = t;
+	int rc = NOTIFY_OK;
+
+	switch (get_watch_event(val)) {
+	case WATCH_TASK_CLONE:
+		proc_fork_connector(task);
+		break;
+	case WATCH_TASK_EXEC:
+		proc_exec_connector(task);
+		break;
+	case WATCH_TASK_UID:
+		proc_id_connector(task, PROC_EVENT_UID);
+		break;
+	case WATCH_TASK_GID:
+		proc_id_connector(task, PROC_EVENT_GID);
+		break;
+	case WATCH_TASK_EXIT:
+		proc_exit_connector(task);
+		break;
+	default: /* we don't care about WATCH_TASK_INIT|FREE because we
+		    don't keep per-task info */
+		rc = NOTIFY_DONE; /* ignore all other notifications */
+		break;
+	}
+	return rc;
+}
+
+static struct notifier_block __read_mostly cn_proc_nb = {
+	.notifier_call = cn_proc_watch_task,
+};
+
 /*
  * cn_proc_init - initialization entry point
  *
  * Adds the connector callback to the connector driver.
  */
@@ -219,11 +259,16 @@ static int __init cn_proc_init(void)
 	int err;
 
 	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
 	 			   &cn_proc_mcast_ctl))) {
 		printk(KERN_WARNING "cn_proc failed to register\n");
-		return err;
+		goto out;
 	}
-	return 0;
+
+	err = register_task_watcher(&cn_proc_nb);
+	if (err != 0)
+		cn_del_callback(&cn_proc_event_id);
+out:
+	return err;
 }
 
 module_init(cn_proc_init);
Index: linux-2.6.17-rc6-mm2/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/cn_proc.h
+++ linux-2.6.17-rc6-mm2/include/linux/cn_proc.h
@@ -93,28 +93,6 @@ struct proc_event {
 			pid_t process_tgid;
 			__u32 exit_code, exit_signal;
 		} exit;
 	} event_data;
 };
-
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
Index: linux-2.6.17-rc6-mm2/kernel/exit.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/exit.c
+++ linux-2.6.17-rc6-mm2/kernel/exit.c
@@ -31,11 +31,10 @@
 #include <linux/delayacct.h>
 #include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
 #include <linux/posix-timers.h>
-#include <linux/cn_proc.h>
 #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
@@ -941,11 +940,10 @@ fastcall NORET_TYPE void do_exit(long co
 
 	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
-	proc_exit_connector(tsk);
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
 #endif
Index: linux-2.6.17-rc6-mm2/kernel/fork.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/fork.c
+++ linux-2.6.17-rc6-mm2/kernel/fork.c
@@ -42,11 +42,10 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
-#include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/notifier.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1251,14 +1250,12 @@ static task_t *copy_process(unsigned lon
 
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	notify_result = notify_watchers(WATCH_TASK_CLONE, p);
-	if (notify_result & NOTIFY_STOP_MASK)
-		goto bad_fork_cleanup_namespaces;
-	proc_fork_connector(p);
-	return p;
+	if (!(notify_result & NOTIFY_STOP_MASK))
+		return p;
 
 bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
 bad_fork_cleanup_keys:
 	exit_keys(p);
Index: linux-2.6.17-rc6-mm2/fs/exec.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/exec.c
+++ linux-2.6.17-rc6-mm2/fs/exec.c
@@ -46,11 +46,10 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
-#include <linux/cn_proc.h>
 #include <linux/audit.h>
 #include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1097,11 +1096,10 @@ int search_binary_handler(struct linux_b
 				if (bprm->file)
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
 				notify_watchers(WATCH_TASK_EXEC, current);
-				proc_exec_connector(current);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
 			if (retval != -ENOEXEC || bprm->mm == NULL)
Index: linux-2.6.17-rc6-mm2/kernel/sys.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sys.c
+++ linux-2.6.17-rc6-mm2/kernel/sys.c
@@ -862,11 +862,10 @@ asmlinkage long sys_setregid(gid_t rgid,
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
 	notify_watchers(WATCH_TASK_GID, current);
-	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 /*
  * setgid() is implemented like SysV w/ SAVED_IDS 
@@ -903,11 +902,10 @@ asmlinkage long sys_setgid(gid_t gid)
 	else
 		return -EPERM;
 
 	key_fsgid_changed(current);
 	notify_watchers(WATCH_TASK_GID, current);
-	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
 {
@@ -994,11 +992,10 @@ asmlinkage long sys_setreuid(uid_t ruid,
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
 	key_fsuid_changed(current);
 	notify_watchers(WATCH_TASK_UID, current);
-	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 

@@ -1043,11 +1040,10 @@ asmlinkage long sys_setuid(uid_t uid)
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
 	key_fsuid_changed(current);
 	notify_watchers(WATCH_TASK_UID, current);
-	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 

@@ -1093,11 +1089,10 @@ asmlinkage long sys_setresuid(uid_t ruid
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
 	key_fsuid_changed(current);
 	notify_watchers(WATCH_TASK_UID, current);
-	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t __user *ruid, uid_t __user *euid, uid_t __user *suid)
@@ -1147,11 +1142,10 @@ asmlinkage long sys_setresgid(gid_t rgid
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
 	notify_watchers(WATCH_TASK_GID, current);
-	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
 {
@@ -1191,11 +1185,10 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		current->fsuid = uid;
 	}
 
 	key_fsuid_changed(current);
 	notify_watchers(WATCH_TASK_UID, current);
-	proc_id_connector(current, PROC_EVENT_UID);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -1221,11 +1214,10 @@ asmlinkage long sys_setfsgid(gid_t gid)
 			smp_wmb();
 		}
 		current->fsgid = gid;
 		key_fsgid_changed(current);
 		notify_watchers(WATCH_TASK_GID, current);
-		proc_id_connector(current, PROC_EVENT_GID);
 	}
 	return old_fsgid;
 }
 
 asmlinkage long sys_times(struct tms __user * tbuf)

--

