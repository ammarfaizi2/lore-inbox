Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVJZATd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVJZATd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVJZATd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:19:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60088 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932496AbVJZATc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:19:32 -0400
Subject: Re: [PATCH 02/02] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <1130285260.10680.194.camel@stark>
References: <1130285260.10680.194.camel@stark>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 17:12:08 -0700
Message-Id: <1130285528.10680.200.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch adds a connector that reports fork, exec, id change, and
exit
events for all processes to userspace. The patch merges the fork and exit
connector patches previously in -mm by Guillaume and Badari along with two new
significant events -- exec and [ug]id changes -- into a single connector that
reports process events.

	Applications that may find these events useful include 
accounting/auditing (e.g. ELSA), system activity monitoring (e.g. top), 
security, and resource management (e.g. CKRM).

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

        Originally I wrote exec and id connectors and relied on previous
connector patches for fork and exit. That approach duplicated a great
deal of code. In comparison to the multi-connector approach this patch
saves 600 lines, reduces the number of per-cpu counters required for
computing sequence numbers, reduces the number of connectors needed, and
slightly reduces the amount of time spent with preemption disabled.

Changes since 9/29/2005:
	Changed signatures to take only task struct in anticipation of
	task_notif(y|iers) or similar interfaces. As a consequence:
		No more "from" and "to" ids -- just the new real and effective
			ids. Will anyone need the former id?
		Adjusted structure passed to userspace to remove "from" id
		Moved exit notification past the point where the struct's
			exit_code gets assigned (BUG in the previous version)
		Adjusted callers to only pass a task struct
	Moved fork notification above wake_up_new_task() so it takes place
		before adding the child to a runqueue and after
		parent/child linking has taken place
	Prevent building as a module (task_notify or similar interfaces
		would enable building this connector as a module)
	Simpler and fewer calls in sys_set[res][u|g]id
	Added exit signal to exit event information
	Sends ack with error code to userspace in response to valid-sized
		commands

 Tested this patch against 2.6.14-rc4.

 drivers/connector/Kconfig   |    8 +
 drivers/connector/Makefile  |    1
 drivers/connector/cn_proc.c |  238 ++++++++++++++++++++++++++++++++++++
 fs/exec.c                   |    2
 include/linux/cn_proc.h     |  125 ++++++++++++++++++
 include/linux/connector.h   |    3
 kernel/exit.c               |    3
 kernel/fork.c               |    3
 kernel/sys.c                |   10 +
 9 files changed, 393 insertions(+)

---

Index: linux-2.6.14-rc4/include/linux/cn_proc.h
===================================================================
--- /dev/null
+++ linux-2.6.14-rc4/include/linux/cn_proc.h
@@ -0,0 +1,125 @@
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
+#define CN_PROC_H 1
+
+#include <linux/types.h>
+#include <linux/connector.h>
+
+typedef int __bitwise proc_cn_mcast_op_t;
+enum proc_cn_mcast_op {
+	PROC_CN_MCAST_LISTEN = (__force proc_cn_mcast_op_t)1,
+	PROC_CN_MCAST_IGNORE = (__force proc_cn_mcast_op_t)2
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
+typedef int __bitwise proc_event_what_t;
+struct proc_event {
+	enum what {
+		/* Use successive bits so the enums can be used to record
+		 * sets of events as well
+		 */
+		PROC_EVENT_NONE = (__force proc_event_what_t)0x00000000,
+		PROC_EVENT_FORK = (__force proc_event_what_t)0x00000001,
+		PROC_EVENT_EXEC = (__force proc_event_what_t)0x00000002,
+		PROC_EVENT_UID  = (__force proc_event_what_t)0x00000004,
+		PROC_EVENT_GID  = (__force proc_event_what_t)0x00000040,
+		/* "next" should be 0x00000400 */
+		/* "last" is the last process event: exit */
+		PROC_EVENT_EXIT = (__force proc_event_what_t)0x80000000
+	} what;
+	int cpu;
+	union { /* must be last field of proc_event struct */
+		struct {
+			int err;
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
+			int exit_code, exit_signal;
+		} exit;
+	};
+};
+
+#ifdef __KERNEL__
+#if defined(CONFIG_PROC_EVENTS) || defined(CONFIG_PROC_EVENTS_MODULE)
+void proc_fork_connector(struct task_struct *task);
+void proc_exec_connector(struct task_struct *task);
+void proc_id_connector (struct task_struct *task, int which_id);
+void proc_exit_connector(struct task_struct *task);
+#else
+static inline void proc_fork_connector(struct task_struct *task)
+{}
+
+static inline void proc_exec_connector(struct task_struct *task)
+{}
+
+static inline void proc_id_connector  (struct task_struct *task,
+				       int which_id)
+{}
+
+static inline void proc_exit_connector(struct task_struct *task)
+{}
+#endif	/* CONFIG_PROC_EVENTS */
+#endif	/* __KERNEL__ */
+#endif	/* CN_PROC_H */
Index: linux-2.6.14-rc4/drivers/connector/cn_proc.c
===================================================================
--- /dev/null
+++ linux-2.6.14-rc4/drivers/connector/cn_proc.c
@@ -0,0 +1,238 @@
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
+extern int cn_already_initialized;
+static atomic_t proc_event_num_listeners = 0;
+struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
+
+/* proc_counts is used as the sequence number of the netlink message */
+DEFINE_PER_CPU(__u32, proc_event_counts);
+
+static inline void get_seq (__u32 *ts, int *cpu)
+{
+	*ts = get_cpu_var(proc_event_counts)++;
+	*cpu = smp_processor_id();
+	put_cpu_var(proc_counts);
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
+static void cn_proc_ack (int err, int rcvd_seq, int rcvd_ack)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	msg->seq = rcvd_seq;
+	ev->cpu = -1;
+	ev->what = PROC_EVENT_NONE;
+	ev->ack.err = err;
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = rcvd_ack + 1;
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_fork_connector(struct task_struct *task)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = PROC_EVENT_FORK;
+	ev->fork.parent_pid = task->real_parent->pid;
+	ev->fork.parent_tgid = task->real_parent->tgid;
+	ev->fork.child_pid = task->pid;
+	ev->fork.child_tgid = task->tgid;
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
+	if (atomic_read(proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = PROC_EVENT_EXEC;
+	ev->exec.process_pid = task->pid;
+	ev->exec.process_tgid = task->tgid;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_id_connector (struct task_struct *task, int which_id)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (atomic_read(proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = which_id;
+	ev->id.process_pid = task->pid;
+	ev->id.process_tgid = task->tgid;
+	if (which_id == PROC_EVENT_UID) {
+	 	ev->id.ruid = task->uid;
+	 	ev->id.euid = task->euid;
+	} else if (which_id == PROC_EVENT_GID) {
+	   	ev->id.rgid = task->gid;
+	   	ev->id.egid = task->egid;
+	} else
+	     	return;
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
+	if (atomic_read(proc_event_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = PROC_EVENT_EXIT;
+	ev->exit.process_pid = task->pid;
+	ev->exit.process_tgid = task->tgid;
+	ev->exit.exit_code = task->exit_code;
+	ev->exit.exit_signal = task->exit_signal;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
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
+	if (!(cn_already_initialized &&
+	    (msg->len == sizeof(*mc_op))))
+		return;
+
+	mc_op = (enum proc_cn_mcast_op*)msg->data;
+	switch (*mc_op) {
+		case PROC_CN_MCAST_LISTEN:
+			atomic_inc(&proc_event_num_listeners);
+			break;
+		case PROC_CN_MCAST_IGNORE:
+			atomic_dec(&proc_event_num_listeners);
+			break;
+		default:
+			err = EINVAL;
+			break;
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
+static void __exit cn_proc_fini(void)
+{
+	cn_del_callback(&cn_proc_event_id);
+}
+
+__initcall(cn_proc_init);
Index: linux-2.6.14-rc4/include/linux/connector.h
===================================================================
--- linux-2.6.14-rc4.orig/include/linux/connector.h
+++ linux-2.6.14-rc4/include/linux/connector.h
@@ -25,10 +25,13 @@
 #include <asm/types.h>
 
 #define CN_IDX_CONNECTOR		0xffffffff
 #define CN_VAL_CONNECTOR		0xffffffff
 
+#define CN_IDX_PROC                    0x1
+#define CN_VAL_PROC                    0x1
+
 #define CN_NETLINK_USERS		1
 
 /*
  * Maximum connector's message size.
  */
Index: linux-2.6.14-rc4/drivers/connector/Kconfig
===================================================================
--- linux-2.6.14-rc4.orig/drivers/connector/Kconfig
+++ linux-2.6.14-rc4/drivers/connector/Kconfig
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
Index: linux-2.6.14-rc4/drivers/connector/Makefile
===================================================================
--- linux-2.6.14-rc4.orig/drivers/connector/Makefile
+++ linux-2.6.14-rc4/drivers/connector/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
 
 cn-y				+= cn_queue.o connector.o
Index: linux-2.6.14-rc4/fs/exec.c
===================================================================
--- linux-2.6.14-rc4.orig/fs/exec.c
+++ linux-2.6.14-rc4/fs/exec.c
@@ -49,10 +49,11 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <linux/cn_proc.h>
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
 
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
Index: linux-2.6.14-rc4/kernel/exit.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/exit.c
+++ linux-2.6.14-rc4/kernel/exit.c
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
 
@@ -861,10 +863,11 @@ fastcall NORET_TYPE void do_exit(long co
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
Index: linux-2.6.14-rc4/kernel/fork.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/fork.c
+++ linux-2.6.14-rc4/kernel/fork.c
@@ -48,10 +48,12 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#include <linux/cn_proc.h>
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int nr_threads; 		/* The idle threads do not count.. */
@@ -1144,10 +1146,11 @@ static task_t *copy_process(unsigned lon
 		attach_pid(p, PIDTYPE_SID, p->signal->session);
 		if (p->pid)
 			__get_cpu_var(process_counts)++;
 	}
 
+	proc_fork_connector(p);
 	if (!current->signal->tty && p->signal->tty)
 		p->signal->tty = NULL;
 
 	nr_threads++;
 	total_forks++;
Index: linux-2.6.14-rc4/kernel/sys.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/sys.c
+++ linux-2.6.14-rc4/kernel/sys.c
@@ -34,10 +34,12 @@
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/unistd.h>
 
+#include <linux/cn_proc.h>
+
 #ifndef SET_UNALIGN_CTL
 # define SET_UNALIGN_CTL(a,b)	(-EINVAL)
 #endif
 #ifndef GET_UNALIGN_CTL
 # define GET_UNALIGN_CTL(a,b)	(-EINVAL)
@@ -621,10 +623,11 @@ asmlinkage long sys_setregid(gid_t rgid,
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
@@ -660,10 +663,11 @@ asmlinkage long sys_setgid(gid_t gid)
 	}
 	else
 		return -EPERM;
 
 	key_fsgid_changed(current);
+	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
 {
@@ -749,10 +753,11 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 

@@ -796,10 +801,11 @@ asmlinkage long sys_setuid(uid_t uid)
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 

@@ -844,10 +850,11 @@ asmlinkage long sys_setresuid(uid_t ruid
 	current->fsuid = current->euid;
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t __user *ruid, uid_t __user *euid, uid_t __user *suid)
@@ -896,10 +903,11 @@ asmlinkage long sys_setresgid(gid_t rgid
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
+	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
 {
@@ -938,10 +946,11 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		}
 		current->fsuid = uid;
 	}
 
 	key_fsuid_changed(current);
+	proc_id_connector(current, PROC_EVENT_UID);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -966,10 +975,11 @@ asmlinkage long sys_setfsgid(gid_t gid)
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


