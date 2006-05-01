Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWEATzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWEATzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWEATyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:54:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:11662 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932212AbWEATx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:53:56 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 4/7] uts namespaces: implement utsname namespaces
References: <20060501203903.XF1836@sergelap.austin.ibm.com>
Message-ID: <20060501203904.XF1836@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Date: Mon,  1 May 2006 14:53:52 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines the uts namespace and some manipulators.
Adds the uts namespace to task_struct, and initializes a
system-wide init namespace.

It leaves a #define for system_utsname so sysctl will compile.
This define will be removed in a separate patch.

Changes:
	Moved code from init/version.c to kernel/utsname.c.
	Modified the clone/unshare functions to better fit
		unsharing at clone and sys_unshare, vs allowing
		other parts of the kernel to unshare.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/init_task.h |    2 ++
 include/linux/sched.h     |    2 ++
 include/linux/utsname.h   |   51 +++++++++++++++++++++++++++++++++++++++++----
 init/Kconfig              |    8 +++++++
 init/version.c            |   22 +++++++++++--------
 kernel/Makefile           |    1 +
 kernel/exit.c             |    2 ++
 kernel/fork.c             |   11 +++++++---
 kernel/utsname.c          |   48 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 131 insertions(+), 16 deletions(-)
 create mode 100644 kernel/utsname.c

73a1721f20bb13cb49bc29b7553768fc788d4d22
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 41ecbb8..21b1751 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -3,6 +3,7 @@ #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
 #include <linux/rcupdate.h>
+#include <linux/utsname.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -123,6 +124,7 @@ #define INIT_TASK(tsk)	\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
+	.uts_ns		= &init_uts_ns,					\
 }
 
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 29b7d4f..3d74d77 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -685,6 +685,7 @@ #endif
 struct audit_context;		/* See audit.c */
 struct mempolicy;
 struct pipe_inode_info;
+struct uts_namespace;
 
 enum sleep_type {
 	SLEEP_NORMAL,
@@ -808,6 +809,7 @@ #endif
 	struct files_struct *files;
 /* namespace */
 	struct namespace *namespace;
+	struct uts_namespace *uts_ns;
 /* signal handlers */
 	struct signal_struct *signal;
 	struct sighand_struct *sighand;
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 8f0decf..a28e956 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -1,5 +1,8 @@
 #ifndef _LINUX_UTSNAME_H
 #define _LINUX_UTSNAME_H
+#include <linux/sched.h>
+#include <linux/kref.h>
+#include <asm/atomic.h>
 
 #define __OLD_UTS_LEN 8
 
@@ -30,15 +33,55 @@ struct new_utsname {
 	char domainname[65];
 };
 
-extern struct new_utsname system_utsname;
+struct uts_namespace {
+	struct kref kref;
+	struct new_utsname name;
+};
+extern struct uts_namespace init_uts_ns;
+
+#ifdef CONFIG_UTS_NS
+extern int copy_utsname(int flags, struct task_struct *tsk);
+extern void free_uts_ns(struct kref *kref);
+
+static inline void put_uts_ns(struct uts_namespace *ns)
+{
+	kref_put(&ns->kref, free_uts_ns);
+}
+
+static inline void exit_utsname(struct task_struct *p)
+{
+	struct uts_namespace *uts_ns = p->uts_ns;
+	if (uts_ns) {
+		task_lock(p);
+		p->uts_ns = NULL;
+		task_unlock(p);
+		put_uts_ns(uts_ns);
+	}
+}
 
-static inline struct new_utsname *utsname(void) {
-	return &system_utsname;
+#else
+static inline int copy_utsname(int flags, struct task_struct *tsk)
+{
+	return 0;
+}
+static inline void put_uts_ns(struct uts_namespace *ns)
+{
+}
+static inline void exit_utsname(struct task_struct *p)
+{
+}
+#endif
+
+static inline struct new_utsname *utsname(void)
+{
+	return &current->uts_ns->name;
 }
 
 static inline struct new_utsname *init_utsname(void) {
-	return &system_utsname;
+	return &init_uts_ns.name;
 }
 
+#define system_utsname init_uts_ns.name
+
 extern struct rw_semaphore uts_sem;
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 3b36a1d..8460e5a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -166,6 +166,14 @@ config SYSCTL
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
+config UTS_NS
+	bool "UTS Namespaces"
+	default n
+	help
+	  Support uts namespaces.  This allows containers, i.e.
+	  vservers, to use uts namespaces to provide different
+	  uts info for different servers.  If unsure, say N.
+
 config AUDIT
 	bool "Auditing support"
 	depends on NET
diff --git a/init/version.c b/init/version.c
index 3ddc3ce..78cef48 100644
--- a/init/version.c
+++ b/init/version.c
@@ -11,23 +11,27 @@ #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
+#include <linux/sched.h>
 
 #define version(a) Version_ ## a
 #define version_string(a) version(a)
 
 int version_string(LINUX_VERSION_CODE);
 
-struct new_utsname system_utsname = {
-	.sysname	= UTS_SYSNAME,
-	.nodename	= UTS_NODENAME,
-	.release	= UTS_RELEASE,
-	.version	= UTS_VERSION,
-	.machine	= UTS_MACHINE,
-	.domainname	= UTS_DOMAINNAME,
+struct uts_namespace init_uts_ns = {
+	.kref = {
+		.refcount	= ATOMIC_INIT(2),
+	},
+	.name = {
+		.sysname	= UTS_SYSNAME,
+		.nodename	= UTS_NODENAME,
+		.release	= UTS_RELEASE,
+		.version	= UTS_VERSION,
+		.machine	= UTS_MACHINE,
+		.domainname	= UTS_DOMAINNAME,
+	},
 };
 
-EXPORT_SYMBOL(system_utsname);
-
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
diff --git a/kernel/Makefile b/kernel/Makefile
index 58908f9..70a69bc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
+obj-$(CONFIG_UTS_NS) += utsname.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --git a/kernel/exit.c b/kernel/exit.c
index f86434d..6a46059 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -35,6 +35,7 @@ #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
+#include <linux/utsname.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -174,6 +175,7 @@ repeat:
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
+	put_uts_ns(p->uts_ns);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
 	p = leader;
diff --git a/kernel/fork.c b/kernel/fork.c
index d2fa57d..cedfd86 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@ #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/utsname.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1064,9 +1065,11 @@ #endif
 		goto bad_fork_cleanup_mm;
 	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_keys;
+	if ((retval = copy_utsname(clone_flags, p)))
+		goto bad_fork_cleanup_namespace;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_utsns;
 
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
 	/*
@@ -1153,7 +1156,7 @@ #endif
 		spin_unlock(&current->sighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 		retval = -ERESTARTNOINTR;
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_utsns;
 	}
 
 	if (clone_flags & CLONE_THREAD) {
@@ -1166,7 +1169,7 @@ #endif
 			spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
 			retval = -EAGAIN;
-			goto bad_fork_cleanup_namespace;
+			goto bad_fork_cleanup_utsns;
 		}
 
 		p->group_leader = current->group_leader;
@@ -1218,6 +1221,8 @@ #endif
 	proc_fork_connector(p);
 	return p;
 
+bad_fork_cleanup_utsns:
+	exit_utsname(p);
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_keys:
diff --git a/kernel/utsname.c b/kernel/utsname.c
new file mode 100644
index 0000000..f9e8f86
--- /dev/null
+++ b/kernel/utsname.c
@@ -0,0 +1,48 @@
+/*
+ *  Copyright (C) 2004 IBM Corporation
+ *
+ *  Author: Serge Hallyn <serue@us.ibm.com>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation, version 2 of the
+ *  License.
+ */
+
+#include <linux/compile.h>
+#include <linux/module.h>
+#include <linux/uts.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+
+static inline void get_uts_ns(struct uts_namespace *ns)
+{
+	kref_get(&ns->kref);
+}
+
+/*
+ * Copy task tsk's utsname namespace, or clone it if flags
+ * specifies CLONE_NEWUTS.  In latter case, changes to the
+ * utsname of this process won't be seen by parent, and vice
+ * versa.
+ */
+int copy_utsname(int flags, struct task_struct *tsk)
+{
+	struct uts_namespace *old_ns = tsk->uts_ns;
+	int err = 0;
+	
+	if (!old_ns)
+		return 0;
+
+	get_uts_ns(old_ns);
+
+	return err;
+}
+
+void free_uts_ns(struct kref *kref)
+{
+	struct uts_namespace *ns;
+
+	ns = container_of(kref, struct uts_namespace, kref);
+	kfree(ns);
+}
-- 
1.3.0


