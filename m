Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWEJCN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWEJCN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWEJCNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:13:47 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:60904 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932216AbWEJCLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:11:54 -0400
Date: Tue, 9 May 2006 21:11:51 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 6/9] uts namespaces: implement utsname namespaces
Message-ID: <20060510021151.GG32523@sergelap.austin.ibm.com>
References: <29vfyljM-5.2006059-s@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
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

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 include/linux/init_task.h |    2 ++
 include/linux/nsproxy.h   |    1 +
 include/linux/sched.h     |    1 +
 include/linux/utsname.h   |   55 ++++++++++++++++++++++++++++++++++++++++++---
 init/Kconfig              |    8 +++++++
 init/version.c            |   22 +++++++++++-------
 kernel/Makefile           |    1 +
 kernel/exit.c             |    7 +++++-
 kernel/fork.c             |    7 +++++-
 kernel/utsname.c          |   43 +++++++++++++++++++++++++++++++++++
 10 files changed, 132 insertions(+), 15 deletions(-)
 create mode 100644 kernel/utsname.c

d7e342120496af2cd8520bc89f7b1e54b7ab2749
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 672dc04..ceb68b7 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -3,6 +3,7 @@ #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
 #include <linux/rcupdate.h>
+#include <linux/utsname.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -70,6 +71,7 @@ extern struct nsproxy init_nsproxy;
 #define INIT_NSPROXY(nsproxy) {						\
 	.count		= ATOMIC_INIT(1),				\
 	.nslock		= SPIN_LOCK_UNLOCKED,				\
+	.uts_ns		= &init_uts_ns,					\
 	.namespace	= NULL,						\
 }
 
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 64e9075..18fcd8f 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -9,6 +9,7 @@ struct namespace;
 struct nsproxy {
 	atomic_t count;
 	spinlock_t nslock;
+	struct uts_namespace *uts_ns;
 	struct namespace *namespace;
 };
 extern struct nsproxy init_nsproxy;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f2c945b..3332d5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -685,6 +685,7 @@ #endif
 struct audit_context;		/* See audit.c */
 struct mempolicy;
 struct pipe_inode_info;
+struct uts_namespace;
 
 enum sleep_type {
 	SLEEP_NORMAL,
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 8f0decf..b6b9801 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -1,6 +1,11 @@
 #ifndef _LINUX_UTSNAME_H
 #define _LINUX_UTSNAME_H
 
+#include <linux/sched.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <asm/atomic.h>
+
 #define __OLD_UTS_LEN 8
 
 struct oldold_utsname {
@@ -30,15 +35,57 @@ struct new_utsname {
 	char domainname[65];
 };
 
-extern struct new_utsname system_utsname;
+struct uts_namespace {
+	struct kref kref;
+	struct new_utsname name;
+};
+extern struct uts_namespace init_uts_ns;
+
+static inline void get_uts_ns(struct uts_namespace *ns)
+{
+	kref_get(&ns->kref);
+}
+
+#ifdef CONFIG_UTS_NS
+extern int copy_utsname(int flags, struct task_struct *tsk);
+extern void free_uts_ns(struct kref *kref);
+
+static inline void put_uts_ns(struct uts_namespace *ns)
+{
+	kref_put(&ns->kref, free_uts_ns);
+}
 
-static inline struct new_utsname *utsname(void) {
-	return &system_utsname;
+static inline void exit_utsname(struct task_struct *p)
+{
+	struct uts_namespace *uts_ns = p->nsproxy->uts_ns;
+	if (uts_ns) {
+		put_uts_ns(uts_ns);
+	}
+}
+
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
+	return &current->nsproxy->uts_ns->name;
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
index 215fb33..ab7426c 100644
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
index 1862d36..921a4b7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -14,7 +14,7 @@ #include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
-#include <linux/nsproxy.h>
+#include <linux/utsname.h>
 #include <linux/namespace.h>
 #include <linux/key.h>
 #include <linux/security.h>
@@ -415,11 +415,15 @@ void daemonize(const char *name, ...)
 	fs = init_task.fs;
 	current->fs = fs;
 	atomic_inc(&fs->count);
+
+	exit_utsname(current);
 	exit_namespace(current);
 	exit_nsproxy(current);
 	current->nsproxy = init_task.nsproxy;
 	get_nsproxy(current->nsproxy);
 	get_namespace(current->nsproxy->namespace);
+	get_uts_ns(current->nsproxy->uts_ns);
+
  	exit_files(current);
 	current->files = init_task.files;
 	atomic_inc(&current->files->count);
@@ -922,6 +926,7 @@ #endif
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
+	exit_utsname(current);
 	exit_namespace(current);
 	exit_nsproxy(current);
 	exit_thread();
diff --git a/kernel/fork.c b/kernel/fork.c
index 06cc87a..4d7cbae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -45,6 +45,7 @@ #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/nsproxy.h>
+#include <linux/utsname.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1063,8 +1064,10 @@ #endif
 		goto bad_fork_cleanup_mm;
 	if ((retval = copy_nsproxy(clone_flags, p)))
 		goto bad_fork_cleanup_keys;
-	if ((retval = copy_namespace(clone_flags, p)))
+	if ((retval = copy_utsname(clone_flags, p)))
 		goto bad_fork_cleanup_nsproxy;
+	if ((retval = copy_namespace(clone_flags, p)))
+		goto bad_fork_cleanup_utsname;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
@@ -1221,6 +1224,8 @@ #endif
 
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
+bad_fork_cleanup_utsname:
+	exit_utsname(p);
 bad_fork_cleanup_nsproxy:
 	exit_nsproxy(p);
 bad_fork_cleanup_keys:
diff --git a/kernel/utsname.c b/kernel/utsname.c
new file mode 100644
index 0000000..2818c9b
--- /dev/null
+++ b/kernel/utsname.c
@@ -0,0 +1,43 @@
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
+/*
+ * Copy task tsk's utsname namespace, or clone it if flags
+ * specifies CLONE_NEWUTS.  In latter case, changes to the
+ * utsname of this process won't be seen by parent, and vice
+ * versa.
+ */
+int copy_utsname(int flags, struct task_struct *tsk)
+{
+	struct uts_namespace *old_ns = tsk->nsproxy->uts_ns;
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

