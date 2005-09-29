Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVI2CqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVI2CqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVI2CqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:46:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8916 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750907AbVI2CqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:46:14 -0400
Subject: [RFC][PATCH] Process Events Connector
From: Matthew Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 19:44:01 -0700
Message-Id: <1127961841.12346.2344.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <matthltc@us.ibm.com>

	I'd like to propose a single process event connector that reports fork,
exec, id change, and exit events to userspace. The patch merges the fork
and exit connector patches posted by Guillaume and Badari along with two
new types of significant events -- exec and [ug]id changes -- into a
single connector.

	Applications that may find these events useful include auditing, system
activity monitoring (e.g. top), security, and a userspace implementation
of CKRM's rule-based classifier (known as RBCE. For CKRM RBCE details
see:
http://sourceforge.net/mailarchive/forum.php?thread_id=8132624&forum_id=35191 )

The additional events are useful because:

	exec() often marks a significant change in the nature of 
a process. A program similar to top could use this to trigger
a change in the displayed name, memory, etc without having to 
rescan all of /proc as frequently. exec() may also be of interest to
auditing and security applications. A CKRM classification engine
written in userspace could use the event to trigger reclassification.

	Auditing and security systems are often related to ids. Resource
monitoring and/or management systems often predicate their decisions on
the owner of the process requesting those resources and hence changes in
id are significant events.


	Originally I wrote exec and id connectors and relied on previous
connector patches for fork and exit. That approach duplicated a great
deal of code. In comparison to the multi-connector approach this patch
saves 600 lines, reduces the number of per-cpu counters required for
computing sequence numbers, reduces the number of connectors needed, and
slightly reduces the amount of time spent with preemption disabled.

	I wrote and tested this patch against 2.6.14-rc2.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

---

 drivers/connector/Kconfig   |    8 +
 drivers/connector/Makefile  |    1
 drivers/connector/cn_proc.c |  212 ++++++++++++++++++++++++++++++++++++
 fs/exec.c                   |    3
 include/linux/cn_proc.h     |  126 +++++++++++++++++++++
 include/linux/connector.h   |    3
 kernel/exit.c               |    2
 kernel/fork.c               |    3
 kernel/sys.c                |   79 ++++++++++++-
 9 files changed, 432 insertions(+), 5 deletions(-)

Index: linux-2.6.14-rc2/include/linux/cn_proc.h
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2/include/linux/cn_proc.h
@@ -0,0 +1,126 @@
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
+		PROC_EVENT_FORK = (__force proc_event_what_t)0x0001,
+		PROC_EVENT_EXEC = (__force proc_event_what_t)0x0002,
+		PROC_EVENT_RUID = (__force proc_event_what_t)0x0004,
+		PROC_EVENT_RGID = (__force proc_event_what_t)0x0008,
+		PROC_EVENT_EUID = (__force proc_event_what_t)0x0010,
+		PROC_EVENT_EGID = (__force proc_event_what_t)0x0020,
+		PROC_EVENT_SUID = (__force proc_event_what_t)0x0040,
+		PROC_EVENT_SGID = (__force proc_event_what_t)0x0080,
+		PROC_EVENT_FSUID = (__force proc_event_what_t)0x0100,
+		PROC_EVENT_FSGID = (__force proc_event_what_t)0x0200,
+		PROC_EVENT_EXIT = (__force proc_event_what_t)0x80000000 /* last */
+	} what;
+	int cpu;
+	union { /* must be last field of struct */
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
+				uid_t uid;
+				gid_t gid;
+			} from;
+			union {
+				uid_t uid;
+				gid_t gid;
+			} to;
+		} id;
+
+		struct exit_proc_event {
+			pid_t process_pid;
+			pid_t process_tgid;
+			int exit_code;
+		} exit;
+	};
+};
+
+#ifdef __KERNEL__
+#ifdef CONFIG_PROC_EVENTS
+void proc_fork_connector(pid_t ppid, pid_t ptgid, pid_t cpid, pid_t ctgid);
+void proc_exec_connector(pid_t pid, pid_t tgid);
+void proc_id_connector (pid_t pid, pid_t tgid, int from, int to, int which_id);
+void proc_exit_connector(pid_t pid, pid_t tgid, int exit_code);
+#else
+static inline void proc_fork_connector(pid_t ppid, pid_t ptgid, pid_t cpid,
+				       pid_t ctgid)
+{}
+
+static inline void proc_exec_connector(pid_t pid, pid_t tgid)
+{}
+
+static inline void proc_id_connector (pid_t pid, pid_t tgid, int from,
+				      int to, int which_id)
+{}
+
+static inline void proc_exit_connector(pid_t pid, pid_t tgid, int exit_code)
+{}
+
+#endif				/* CONFIG_PROC_EVENTS */
+#endif				/* __KERNEL__ */
+#endif				/* CN_PROC_H */
Index: linux-2.6.14-rc2/drivers/connector/cn_proc.c
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2/drivers/connector/cn_proc.c
@@ -0,0 +1,212 @@
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
+
+#include <linux/cn_proc.h>
+
+#define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct proc_event))
+
+static int proc_event_num_listeners = 0;
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
+void proc_fork_connector(pid_t ppid, pid_t ptgid, pid_t cpid, pid_t ctgid)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (proc_event_num_listeners < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = PROC_EVENT_FORK;
+	ev->fork.parent_pid = ppid;
+	ev->fork.parent_tgid = ptgid;
+	ev->fork.child_pid = cpid;
+	ev->fork.child_tgid = ctgid;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+
+	/*  If cn_netlink_send() failed, the data is not send */
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_exec_connector(pid_t pid, pid_t tgid)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (proc_event_num_listeners < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = PROC_EVENT_EXEC;
+	ev->exec.process_pid = pid;
+	ev->exec.process_tgid = tgid;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_id_connector (pid_t task_pid, pid_t task_tgid,
+			int from, int to, int which_id)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (proc_event_num_listeners < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = which_id;
+	ev->id.process_pid = task_pid;
+	ev->id.process_tgid = task_tgid;
+
+	switch (which_id) {
+		case PROC_EVENT_RUID:
+		case PROC_EVENT_EUID:
+		case PROC_EVENT_SUID:
+		case PROC_EVENT_FSUID:
+			ev->id.from.uid = from;
+			ev->id.to.uid = to;
+			break;
+		case PROC_EVENT_RGID:
+		case PROC_EVENT_EGID:
+		case PROC_EVENT_SGID:
+		case PROC_EVENT_FSGID:
+			ev->id.from.gid = from;
+			ev->id.to.gid = to;
+			break;
+		default:
+			return;
+			break;
+	}
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+}
+
+void proc_exit_connector(pid_t pid, pid_t tgid, int exit_code)
+{
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
+
+	if (proc_event_num_listeners < 1)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
+
+	get_seq(&msg->seq, &ev->cpu);
+
+	ev->what = PROC_EVENT_EXIT;
+	ev->exit.process_pid = pid;
+	ev->exit.process_tgid = tgid;
+	ev->exit.exit_code = exit_code;
+
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+
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
+
+	if (!(cn_already_initialized &&
+	    (msg->len == sizeof(*mc_op))))
+		return;
+
+	mc_op = (enum proc_cn_mcast_op*)msg->data;
+	switch (*mc_op) {
+		case PROC_CN_MCAST_LISTEN:
+			proc_event_num_listeners++;
+			break;
+		case PROC_CN_MCAST_IGNORE:
+			if (proc_event_num_listeners < 1)
+				break;
+			proc_event_num_listeners--;
+			break;
+		default:
+			break;
+	}
+}
+
+/*
+ * cn_proc_init - initialization entry point
+ *
+ * Adds the connector callback to the connector driver.
+ */
+int __init cn_proc_init(void)
+{
+	if (cn_add_callback(&cn_proc_event_id, "cn_proc",
+			    &cn_proc_mcast_ctl)) {
+		printk(KERN_WARNING "cn_proc failed to register\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+__initcall(cn_proc_init);
Index: linux-2.6.14-rc2/kernel/exit.c
===================================================================
--- linux-2.6.14-rc2.orig/kernel/exit.c
+++ linux-2.6.14-rc2/kernel/exit.c
@@ -26,10 +26,11 @@
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
 #include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/cn_proc.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -805,10 +806,11 @@ fastcall NORET_TYPE void do_exit(long co
 	if (unlikely(tsk->pid == 1))
 		panic("Attempted to kill init!");
 	if (tsk->io_context)
 		exit_io_context();
 
+	proc_exit_connector(current->pid, current->tgid, code);
 	if (unlikely(current->ptrace & PT_TRACE_EXIT)) {
 		current->ptrace_message = code;
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
Index: linux-2.6.14-rc2/fs/exec.c
===================================================================
--- linux-2.6.14-rc2.orig/fs/exec.c
+++ linux-2.6.14-rc2/fs/exec.c
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
@@ -1098,10 +1099,12 @@ int search_binary_handler(struct linux_b
 				allow_write_access(bprm->file);
 				if (bprm->file)
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
+				proc_exec_connector(current->pid,
+						    current->tgid);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
 			if (retval != -ENOEXEC || bprm->mm == NULL)
Index: linux-2.6.14-rc2/include/linux/connector.h
===================================================================
--- linux-2.6.14-rc2.orig/include/linux/connector.h
+++ linux-2.6.14-rc2/include/linux/connector.h
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
Index: linux-2.6.14-rc2/kernel/sys.c
===================================================================
--- linux-2.6.14-rc2.orig/kernel/sys.c
+++ linux-2.6.14-rc2/kernel/sys.c
@@ -29,10 +29,11 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
+#include <linux/cn_proc.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/unistd.h>
 
@@ -574,16 +575,29 @@ asmlinkage long sys_setregid(gid_t rgid,
 	if (new_egid != old_egid)
 	{
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
+
 	if (rgid != (gid_t) -1 ||
-	    (egid != (gid_t) -1 && egid != old_rgid))
+	    (egid != (gid_t) -1 && egid != old_rgid)) {
+		proc_id_connector(current->pid, current->tgid,
+				  current->sgid, new_egid, PROC_EVENT_SGID);
 		current->sgid = new_egid;
+	}
+
+	proc_id_connector(current->pid, current->tgid,
+			  current->fsgid, new_egid,PROC_EVENT_FSGID);
+	proc_id_connector(current->pid, current->tgid,
+			  old_egid, new_egid, PROC_EVENT_EGID);
+	proc_id_connector(current->pid, current->tgid,
+			  old_rgid, new_rgid, PROC_EVENT_RGID);
+
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
+
 	key_fsgid_changed(current);
 	return 0;
 }
 
 /*
@@ -605,19 +619,31 @@ asmlinkage long sys_setgid(gid_t gid)
 		if(old_egid != gid)
 		{
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
+		proc_id_connector(current->pid, current->tgid,
+				  current->sgid, gid, PROC_EVENT_SGID);
+		proc_id_connector(current->pid, current->tgid,
+				  current->fsgid, gid, PROC_EVENT_FSGID);
+		proc_id_connector(current->pid, current->tgid,
+				  current->egid, gid, PROC_EVENT_EGID);
+		proc_id_connector(current->pid, current->tgid,
+				  current->gid, gid,PROC_EVENT_RGID);
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
 	}
 	else if ((gid == current->gid) || (gid == current->sgid))
 	{
 		if(old_egid != gid)
 		{
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
+		proc_id_connector(current->pid, current->tgid,
+				  current->fsgid, gid, PROC_EVENT_FSGID);
+		proc_id_connector(current->pid, current->tgid,
+				  current->egid, gid, PROC_EVENT_EGID);
 		current->egid = current->fsgid = gid;
 	}
 	else
 		return -EPERM;
 
@@ -645,10 +671,13 @@ static int set_user(uid_t new_ruid, int 
 	if(dumpclear)
 	{
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
+
+	proc_id_connector(current->pid, current->tgid,
+			  current->uid, new_ruid, PROC_EVENT_RUID);
 	current->uid = new_ruid;
 	return 0;
 }
 
 /*
@@ -702,14 +731,23 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	if (new_euid != old_euid)
 	{
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
+
+	proc_id_connector(current->pid, current->tgid,
+			  current->euid, new_euid, PROC_EVENT_EUID);
+	proc_id_connector(current->pid, current->tgid,
+			  current->fsuid, new_euid, PROC_EVENT_FSUID);
 	current->fsuid = current->euid = new_euid;
 	if (ruid != (uid_t) -1 ||
-	    (euid != (uid_t) -1 && euid != old_ruid))
+	    (euid != (uid_t) -1 && euid != old_ruid)) {
+		proc_id_connector(current->pid, current->tgid,
+				  current->suid, new_euid, PROC_EVENT_SUID);
 		current->suid = current->euid;
+	}
+
 	current->fsuid = current->euid;
 
 	key_fsuid_changed(current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
@@ -752,10 +790,18 @@ asmlinkage long sys_setuid(uid_t uid)
 	if (old_euid != uid)
 	{
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
+
+	proc_id_connector(current->pid, current->tgid,
+			  old_euid, uid, PROC_EVENT_EUID);
+	proc_id_connector(current->pid, current->tgid,
+			  current->fsuid, uid, PROC_EVENT_FSUID);
+	proc_id_connector(current->pid, current->tgid,
+			  current->suid, new_suid, PROC_EVENT_SUID);
+
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
 	key_fsuid_changed(current);
 
@@ -797,15 +843,23 @@ asmlinkage long sys_setresuid(uid_t ruid
 		if (euid != current->euid)
 		{
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
+		proc_id_connector(current->pid, current->tgid,
+				  old_euid, euid, PROC_EVENT_EUID);
 		current->euid = euid;
 	}
+
+	proc_id_connector(current->pid, current->tgid,
+			  current->fsuid, current->euid, PROC_EVENT_FSUID);
 	current->fsuid = current->euid;
-	if (suid != (uid_t) -1)
+	if (suid != (uid_t) -1) {
+		proc_id_connector(current->pid, current->tgid,
+				  old_suid, suid, PROC_EVENT_SUID);
 		current->suid = suid;
+	}
 
 	key_fsuid_changed(current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
@@ -847,17 +901,27 @@ asmlinkage long sys_setresgid(gid_t rgid
 		if (egid != current->egid)
 		{
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
+		proc_id_connector(current->pid, current->tgid,
+				  current->egid, egid, PROC_EVENT_EGID);
 		current->egid = egid;
 	}
+	proc_id_connector(current->pid, current->tgid,
+			  current->fsgid, current->egid, PROC_EVENT_FSGID);
 	current->fsgid = current->egid;
-	if (rgid != (gid_t) -1)
+	if (rgid != (gid_t) -1) {
+		proc_id_connector(current->pid, current->tgid,
+				  current->gid, rgid, PROC_EVENT_RGID);
 		current->gid = rgid;
-	if (sgid != (gid_t) -1)
+	}
+	if (sgid != (gid_t) -1) {
+		proc_id_connector(current->pid, current->tgid,
+				  current->sgid, sgid, PROC_EVENT_SGID);
 		current->sgid = sgid;
+	}
 
 	key_fsgid_changed(current);
 	return 0;
 }
 
@@ -894,10 +958,12 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		if (uid != old_fsuid)
 		{
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
+		proc_id_connector(current->pid, current->tgid,
+				  old_fsuid, uid, PROC_EVENT_FSUID);
 		current->fsuid = uid;
 	}
 
 	key_fsuid_changed(current);
 
@@ -924,13 +990,16 @@ asmlinkage long sys_setfsgid(gid_t gid)
 		if (gid != old_fsgid)
 		{
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
+		proc_id_connector(current->pid, current->tgid,
+				  old_fsgid, gid, PROC_EVENT_FSGID);
 		current->fsgid = gid;
 		key_fsgid_changed(current);
 	}
+
 	return old_fsgid;
 }
 
 asmlinkage long sys_times(struct tms __user * tbuf)
 {
Index: linux-2.6.14-rc2/kernel/fork.c
===================================================================
--- linux-2.6.14-rc2.orig/kernel/fork.c
+++ linux-2.6.14-rc2/kernel/fork.c
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
@@ -1287,10 +1288,12 @@ long do_fork(unsigned long clone_flags,
 		if (unlikely (trace)) {
 			current->ptrace_message = pid;
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}
 
+		proc_fork_connector(current->pid, current->tgid,
+				    p->pid, p->tgid);
 		if (clone_flags & CLONE_VFORK) {
 			wait_for_completion(&vfork);
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
Index: linux-2.6.14-rc2/drivers/connector/Kconfig
===================================================================
--- linux-2.6.14-rc2.orig/drivers/connector/Kconfig
+++ linux-2.6.14-rc2/drivers/connector/Kconfig
@@ -8,6 +8,14 @@ config CONNECTOR
 	  of the netlink socket protocol.
 
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
+config PROC_EVENTS
+	bool
+	depends on CONNECTOR
+	default y
+	---help---
+	  Provide a connector that reports process events to userspace. Send
+	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
+
 endmenu
Index: linux-2.6.14-rc2/drivers/connector/Makefile
===================================================================
--- linux-2.6.14-rc2.orig/drivers/connector/Makefile
+++ linux-2.6.14-rc2/drivers/connector/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
 
 cn-y				+= cn_queue.o connector.o


