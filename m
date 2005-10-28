Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbVJ1JIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVJ1JIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVJ1JIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:08:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:9707 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965186AbVJ1JId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:08:33 -0400
Subject: [PATCH] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 01:55:13 -0700
Message-Id: <1130489713.10680.685.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	This patch adds a connector that reports fork, exec, id change,
and exit events for all processes to userspace. It replaces the
fork_advisor patch that ELSA is currently using. Applications that may
find these events useful include accounting/auditing (e.g. ELSA),
system activity monitoring (e.g. top), security, and resource management
(e.g. CKRM).

	Please consider for -mm.

Changes since 10/25/2005:
	Fixed header include-once convention
	Removed sparse idioms
	Removed typedefs
	Switched ints to __u32 for userspace
	Gave proc_event struct's union a name: event_data
	Removed useless module-isms
	Removed space between function names and open paren
	Removed unnecessary use of cn_already_initialized
	Added initializer for per-cpu proc_event_counts
	Made per-cpu proc_event_counts static
	Fixed switch body indentation
	Switched from __initcall to module_init()
	Removed __exit function
	Added comment describing IDX and VAL
	Placed linux includes before asm includes in fs/exec.c,
		kernel/fork.c, and kernel/sys.c
	Moved cn_proc_ack closer to usage
	Fixed sequence number in proc_id_connector

Changes since 9/29/2005:
	Changed signatures to take only task struct in anticipation of
	task_notif(y|iers). As a consequence:
		Lots of new little functions -- one per id that can
			change
		No more "from" and "to" ids -- just "to" ruid and euid
			- Will anyone need the former id?
		Adjusted structure passed to userspace to remove "from" 
			id
		Moved exit notification past the point where the
			struct's exit_code gets assigned
		Adjusted callers to only pass a task struct
	Moved fork notification above wake_up_new_task() so it takes 
		place before adding the child to a runqueue and after
		parent/child linking has taken place
	Use new gfp_t type
	Prevent building as a module (task_notify or similar
		infrastructure would enable building this connector as a
		module)
	Simpler and fewer calls in sys_set[res][u|g]id
	Added exit signal to exit event information

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

---

 drivers/connector/Kconfig   |    8 +
 drivers/connector/Makefile  |    1
 drivers/connector/cn_proc.c |  222 ++++++++++++++++++++++++++++++++++++
 fs/exec.c                   |    2
 include/linux/cn_proc.h     |  127 ++++++++++++++++++++
 include/linux/connector.h   |    6
 kernel/exit.c               |    3
 kernel/fork.c               |    2
 kernel/sys.c                |    9 +
 9 files changed, 380 insertions(+)

Index: linux-2.6.14/include/linux/cn_proc.h
===================================================================
--- /dev/null
+++ linux-2.6.14/include/linux/cn_proc.h
@@ -0,0 +1,127 @@
+/*
+ * cn_proc.h - process events connector
+ *
+ * Copyright (C) Matt Helsley, IBM Corp. 2005
+ * Based on cn_fork.h by Nguyen Anh Quynh and Guillaume Thouvenin
+ * Original copyright notice follows:
+ * Copyright (C) 2005 Nguyen Anh Quynh <aquynh@gmail.com>
+ * Copyright (C) 2005 Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef CN_PROC_H
+#define CN_PROC_H
+
+#include <linux/types.h>
+#include <linux/connector.h>
+
+/*
+ * Userspace sends this enum to register with the kernel that it is listening
+ * for events on the connector.
+ */
+enum proc_cn_mcast_op {
+	PROC_CN_MCAST_LISTEN = 1,
+	PROC_CN_MCAST_IGNORE = 2
+};
+
+/*
+ * From the user's point of view, the process
+ * ID is the thread group ID and thread ID is the internal
+ * kernel "pid". So, fields are assigned as follow:
+ *
+ *  In user space     -  In  kernel space
+ *
+ * parent process ID  =  parent->tgid
+ * parent thread  ID  =  parent->pid
+ * child  process ID  =  child->tgid
+ * child  thread  ID  =  child->pid
+ */
+
+struct proc_event {
+	enum what {
+		/* Use successive bits so the enums can be used to record
+		 * sets of events as well
+		 */
+		PROC_EVENT_NONE = 0x00000000,
+		PROC_EVENT_FORK = 0x00000001,
+		PROC_EVENT_EXEC = 0x00000002,
+		PROC_EVENT_UID  = 0x00000004,
+		PROC_EVENT_GID  = 0x00000040,
+		/* "next" should be 0x00000400 */
+		/* "last" is the last process event: exit */
+		PROC_EVENT_EXIT = 0x80000000
+	} what;
+	__u32 cpu;
+	union { /* must be last field of proc_event struct */
+		struct {
+			__u32 err;
+		} ack;
+
+		struct fork_proc_event {
+			pid_t parent_pid;
+			pid_t parent_tgid;
+			pid_t child_pid;
+			pid_t child_tgid;
+		} fork;
+
+		struct exec_proc_event {
+			pid_t process_pid;
+			pid_t process_tgid;
+		} exec;
+
+		struct id_proc_event {
+			pid_t process_pid;
+			pid_t process_tgid;
+			union {
+				uid_t ruid; /* current->uid */
+				gid_t rgid; /* current->gid */
+			};
+			union {
+				uid_t euid;
+				gid_t egid;
+			};
+		} id;
+
+		struct exit_proc_event {
+			pid_t process_pid;
+			pid_t process_tgid;
+			__u32 exit_code, exit_signal;
+		} exit;
+	} event_data;
+};
+
+#ifdef __KERNEL__
+#ifdef CONFIG_PROC_EVENTS
+void proc_fork_connector(struct task_struct *task);
+void proc_exec_connector(struct task_struct *task);
+void proc_id_connector(struct task_struct *task, int which_id);
+void proc_exit_connector(struct task_struct *task);
+#else
+static inline void proc_fork_connector(struct task_struct *task)
+{}
+
+static inline void proc_exec_connector(struct task_struct *task)
+{}
+
+static inline void proc_id_connector(struct task_struct *task,
+				     int which_id)
+{}
+
+static inline void proc_exit_connector(struct task_struct *task)
+{}
+#endif	/* CONFIG_PROC_EVENTS */
+#endif	/* __KERNEL__ */
+#endif	/* CN_PROC_H */
Index: linux-2.6.14/drivers/connector/cn_proc.c
===================================================================
--- /dev/null
+++ linux-2.6.14/drivers/connector/cn_proc.c
@@ -0,0 +1,222 @@
+/*
+ * cn_proc.c - process events connector
+ *
+ * Copyright (C) Matt Helsley, IBM Corp. 2005
+ * Based on cn_fork.c by Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ * Original copyright notice follows:
+ * Copyright (C) 2005 BULL SA.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+
+#include <linux/cn_proc.h>
+
+#define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct proc_event))
+
+static atomic_t proc_event_num_listeners = ATOMIC_INIT(0);
+static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
+
+/* proc_counts is used as the sequence number of the netlink message */
+static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
+
+static inline void get_seq(__u32 *ts, int *cpu)
+{
+	*ts = get_cpu_var(proc_event_counts)++;
+	*cpu = smp_processor_id();
+	put_cpu_var(proc_counts);
+}
+
+void proc_fork_connector(struct task_struct *task)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+	get_seq(&msg->seq, &ev->cpu);
+	ev->what = PROC_EVENT_FORK;
+	ev->event_data.fork.parent_pid = task->real_parent->pid;
+	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
+	ev->event_data.fork.child_pid = task->pid;
+	ev->event_data.fork.child_tgid = task->tgid;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	/*  If cn_netlink_send() failed, the data is not sent */
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_exec_connector(struct task_struct *task)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+	get_seq(&msg->seq, &ev->cpu);
+	ev->what = PROC_EVENT_EXEC;
+	ev->event_data.exec.process_pid = task->pid;
+	ev->event_data.exec.process_tgid = task->tgid;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_id_connector(struct task_struct *task, int which_id)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+	ev->what = which_id;
+	ev->event_data.id.process_pid = task->pid;
+	ev->event_data.id.process_tgid = task->tgid;
+	if (which_id == PROC_EVENT_UID) {
+	 	ev->event_data.id.ruid = task->uid;
+	 	ev->event_data.id.euid = task->euid;
+	} else if (which_id == PROC_EVENT_GID) {
+	   	ev->event_data.id.rgid = task->gid;
+	   	ev->event_data.id.egid = task->egid;
+	} else
+	     	return;
+	get_seq(&msg->seq, &ev->cpu);
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_exit_connector(struct task_struct *task)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+	get_seq(&msg->seq, &ev->cpu);
+	ev->what = PROC_EVENT_EXIT;
+	ev->event_data.exit.process_pid = task->pid;
+	ev->event_data.exit.process_tgid = task->tgid;
+	ev->event_data.exit.exit_code = task->exit_code;
+	ev->event_data.exit.exit_signal = task->exit_signal;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+/*
+ * Send an acknowledgement message to userspace
+ *
+ * Use 0 for success, EFOO otherwise.
+ * Note: this is the negative of conventional kernel error
+ * values because it's not being returned via syscall return
+ * mechanisms.
+ */
+static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+	msg->seq = rcvd_seq;
+	ev->cpu = -1;
+	ev->what = PROC_EVENT_NONE;
+	ev->event_data.ack.err = err;
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = rcvd_ack + 1;
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+/**
+ * cn_proc_mcast_ctl
+ * @data: message sent from userspace via the connector
+ */
+static void cn_proc_mcast_ctl(void *data)
+{
+	struct cn_msg *msg = data;
+	enum proc_cn_mcast_op *mc_op = NULL;
+	int err = 0;
+
+	if (msg->len != sizeof(*mc_op))
+		return;
+
+	mc_op = (enum proc_cn_mcast_op*)msg->data;
+	switch (*mc_op) {
+	case PROC_CN_MCAST_LISTEN:
+		atomic_inc(&proc_event_num_listeners);
+		break;
+	case PROC_CN_MCAST_IGNORE:
+		atomic_dec(&proc_event_num_listeners);
+		break;
+	default:
+		err = EINVAL;
+		break;
+	}
+	cn_proc_ack(err, msg->seq, msg->ack);
+}
+
+/*
+ * cn_proc_init - initialization entry point
+ *
+ * Adds the connector callback to the connector driver.
+ */
+static int __init cn_proc_init(void)
+{
+	int err;
+
+	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
+	 			   &cn_proc_mcast_ctl))) {
+		printk(KERN_WARNING "cn_proc failed to register\n");
+		return err;
+	}
+	return 0;
+}
+
+module_init(cn_proc_init);
Index: linux-2.6.14/include/linux/connector.h
===================================================================
--- linux-2.6.14.orig/include/linux/connector.h
+++ linux-2.6.14/include/linux/connector.h
@@ -25,10 +25,16 @@
 #include <asm/types.h>
 
 #define CN_IDX_CONNECTOR		0xffffffff
 #define CN_VAL_CONNECTOR		0xffffffff
 
+/*
+ * Process Events connector unique ids -- used for message routing
+ */
+#define CN_IDX_PROC			0x1
+#define CN_VAL_PROC			0x1
+
 #define CN_NETLINK_USERS		1
 
 /*
  * Maximum connector's message size.
  */
Index: linux-2.6.14/drivers/connector/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/connector/Kconfig
+++ linux-2.6.14/drivers/connector/Kconfig
@@ -8,6 +8,14 @@ config CONNECTOR
 	  of the netlink socket protocol.
 
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
+config PROC_EVENTS
+	boolean "Report process events to userspace"
+	depends on CONNECTOR=y
+	default y
+	---help---
+	  Provide a connector that reports process events to userspace. Send
+	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
+
 endmenu
Index: linux-2.6.14/drivers/connector/Makefile
===================================================================
--- linux-2.6.14.orig/drivers/connector/Makefile
+++ linux-2.6.14/drivers/connector/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
 
 cn-y				+= cn_queue.o connector.o
Index: linux-2.6.14/fs/exec.c
===================================================================
--- linux-2.6.14.orig/fs/exec.c
+++ linux-2.6.14/fs/exec.c
@@ -46,10 +46,11 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/cn_proc.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
 #ifdef CONFIG_KMOD
@@ -1098,10 +1099,11 @@ int search_binary_handler(struct linux_b
 				allow_write_access(bprm->file);
 				if (bprm->file)
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
+				proc_exec_connector(current);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
 			if (retval != -ENOEXEC || bprm->mm == NULL)
Index: linux-2.6.14/kernel/exit.c
===================================================================
--- linux-2.6.14.orig/kernel/exit.c
+++ linux-2.6.14/kernel/exit.c
@@ -32,10 +32,12 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
+#include <linux/cn_proc.h>
+
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
 
 int getrusage(struct task_struct *, int, struct rusage __user *);
 
@@ -862,10 +864,11 @@ fastcall NORET_TYPE void do_exit(long co
 	module_put(tsk->thread_info->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
 	tsk->exit_code = code;
+	proc_exit_connector(tsk);
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
 #endif
Index: linux-2.6.14/kernel/fork.c
===================================================================
--- linux-2.6.14.orig/kernel/fork.c
+++ linux-2.6.14/kernel/fork.c
@@ -40,10 +40,11 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/cn_proc.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1144,10 +1145,11 @@ static task_t *copy_process(unsigned lon
 		attach_pid(p, PIDTYPE_SID, p->signal->session);
 		if (p->pid)
 			__get_cpu_var(process_counts)++;
 	}
 
+	proc_fork_connector(p);
 	if (!current->signal->tty && p->signal->tty)
 		p->signal->tty = NULL;
 
 	nr_threads++;
 	total_forks++;
Index: linux-2.6.14/kernel/sys.c
===================================================================
--- linux-2.6.14.orig/kernel/sys.c
+++ linux-2.6.14/kernel/sys.c
@@ -26,10 +26,11 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/signal.h>
+#include <linux/cn_proc.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
@@ -621,10 +622,11 @@ asmlinkage long sys_setregid(gid_t rgid,
 		current->sgid = new_egid;
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
+	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 /*
  * setgid() is implemented like SysV w/ SAVED_IDS 
@@ -660,10 +662,11 @@ asmlinkage long sys_setgid(gid_t gid)
 	}
 	else
 		return -EPERM;
 
 	key_fsgid_changed(current);
+	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
 {
@@ -749,10 +752,11 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
 
@@ -796,10 +800,11 @@ asmlinkage long sys_setuid(uid_t uid)
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
 
@@ -844,10 +849,11 @@ asmlinkage long sys_setresuid(uid_t ruid
 	current->fsuid = current->euid;
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t __user *ruid, uid_t __user *euid, uid_t __user *suid)
@@ -896,10 +902,11 @@ asmlinkage long sys_setresgid(gid_t rgid
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
+	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
 {
@@ -938,10 +945,11 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		}
 		current->fsuid = uid;
 	}
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -966,10 +974,11 @@ asmlinkage long sys_setfsgid(gid_t gid)
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
 		current->fsgid = gid;
 		key_fsgid_changed(current);
+		proc_id_connector(current, PROC_EVENT_GID);
 	}
 	return old_fsgid;
 }
 
 asmlinkage long sys_times(struct tms __user * tbuf)


