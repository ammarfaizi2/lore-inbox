Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWFIVGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWFIVGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWFIVGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:06:33 -0400
Received: from AToulouse-252-1-74-163.w81-49.abo.wanadoo.fr ([81.49.44.163]:5075
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S965296AbWFIVGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:31 -0400
Message-Id: <20060609210623.244151000@localhost.localdomain>
References: <20060609210202.215291000@localhost.localdomain>
Date: Fri, 09 Jun 2006 23:02:03 +0200
From: dlezcano@fr.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com
Subject: [RFC] [patch 1/6] [Network namespace] Network namespace structure
Content-Disposition: inline; filename=net_ns.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to the nsproxy the network namespace and a set of
functions to unshare it. The network namespace structure should be
filled later with the identified network ressources needed for more
isolation.

Replace-Subject: [Network namespace] Network namespace structure
Signed-off-by: Daniel Lezcano <dlezcano@fr.ibm.com> 
--
 include/linux/init_task.h |    2 
 include/linux/net_ns.h    |   59 ++++++++++++++++++++++++++++
 include/linux/nsproxy.h   |    2 
 include/linux/sched.h     |    1 
 init/version.c            |    8 +++
 kernel/fork.c             |   24 +++++++++--
 kernel/nsproxy.c          |   38 +++++++++++-------
 net/Kconfig               |    9 ++++
 net/Makefile              |    1 
 net/net_ns.c              |   96 ++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 222 insertions(+), 18 deletions(-)

Index: 2.6-mm/include/linux/net_ns.h
===================================================================
--- /dev/null
+++ 2.6-mm/include/linux/net_ns.h
@@ -0,0 +1,59 @@
+#ifndef _LINUX_NET_NS_H
+#define _LINUX_NET_NS_H
+
+#include <linux/kref.h>
+#include <linux/sched.h>
+#include <linux/nsproxy.h>
+
+struct net_namespace {
+	struct kref kref;
+};
+
+extern struct net_namespace init_net_ns;
+
+#ifdef CONFIG_NET_NS
+
+extern int unshare_network(unsigned long unshare_flags,
+			   struct net_namespace **new_net);
+
+extern int copy_network(int flags, struct task_struct *tsk);
+
+static inline void get_net_ns(struct net_namespace *ns)
+{
+	kref_get(&ns->kref);
+}
+
+void free_net_ns(struct kref *kref);
+
+static inline void put_net_ns(struct net_namespace *ns)
+{
+	kref_put(&ns->kref, free_net_ns);
+}
+
+static inline void exit_network(struct task_struct *p)
+{
+	struct net_namespace *net_ns = p->nsproxy->net_ns;
+	if (net_ns)
+		put_net_ns(net_ns);
+}
+#else /* !CONFIG_NET_NS */
+static inline int unshare_network(unsigned long unshare_flags,
+				  struct net_namespace **new_net)
+{
+	return -EINVAL;
+}
+static inline int copy_network(int flags, struct task_struct *tsk)
+{
+	return 0;
+}
+static inline void get_net_ns(struct net_namespace *ns) {}
+static inline void put_net_ns(struct net_namespace *ns) {}
+static inline void exit_network(struct task_struct *p) {}
+#endif /* CONFIG_NET_NS */
+
+static inline struct net_namespace *net_ns(void)
+{
+	return current->nsproxy->net_ns;
+}
+
+#endif
Index: 2.6-mm/net/net_ns.c
===================================================================
--- /dev/null
+++ 2.6-mm/net/net_ns.c
@@ -0,0 +1,96 @@
+/*
+ *  net_ns.c - adds support for network namespace
+ *
+ *  Copyright (C) 2006 IBM
+ *
+ *  Author: Daniel Lezcano <dlezcano@fr.ibm.com>
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation, version 2 of the
+ *     License.
+ */
+
+#include <linux/net_ns.h>
+#include <linux/module.h>
+
+/*
+ * Clone a new ns copying an original, setting refcount to 1
+ * Cloned process will have
+ * @old_ns: namespace to clone
+ * Return NULL on error (failure to kmalloc), new ns otherwise
+ */
+struct net_namespace *clone_net_ns(struct net_namespace *old_ns)
+{
+	struct net_namespace *new_ns;
+
+	new_ns = kmalloc(sizeof(*new_ns), GFP_KERNEL);
+ 	if (!new_ns)
+ 		return NULL;
+ 	kref_init(&new_ns->kref);
+	return new_ns;
+}
+
+/*
+ * unshare the current process' network namespace.
+ * called only in sys_unshare()
+ */
+int unshare_network(unsigned long unshare_flags,
+		    struct net_namespace **new_net)
+{
+ 	if (!(unshare_flags & CLONE_NEWNET))
+ 		return 0;
+
+ 	if (!capable(CAP_SYS_ADMIN))
+ 		return -EPERM;
+
+ 	*new_net = clone_net_ns(current->nsproxy->net_ns);
+ 	if (!*new_net)
+ 		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * Copy task tsk's network namespace, or clone it if flags specifies
+ * CLONE_NEWNET.  In latter case, changes to the network ressources of
+ * this process won't be seen by parent, and vice versa.
+ */
+int copy_network(int flags, struct task_struct *tsk)
+{
+	struct net_namespace *old_ns = tsk->nsproxy->net_ns;
+	struct net_namespace *new_ns;
+	int err = 0;
+
+	if (!old_ns)
+		return 0;
+
+	get_net_ns(old_ns);
+
+	if (!(flags & CLONE_NEWNET))
+		return 0;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	new_ns = clone_net_ns(old_ns);
+	if (!new_ns) {
+		err = -ENOMEM;
+		goto out;
+	}
+	tsk->nsproxy->net_ns = new_ns;
+
+out:
+	put_net_ns(old_ns);
+	return err;
+}
+
+void free_net_ns(struct kref *kref)
+{
+	struct net_namespace *ns;
+
+	ns = container_of(kref, struct net_namespace, kref);
+	kfree(ns);
+}
Index: 2.6-mm/include/linux/nsproxy.h
===================================================================
--- 2.6-mm.orig/include/linux/nsproxy.h
+++ 2.6-mm/include/linux/nsproxy.h
@@ -6,6 +6,7 @@
 
 struct namespace;
 struct uts_namespace;
+struct net_namespace;
 
 /*
  * A structure to contain pointers to all per-process
@@ -23,6 +24,7 @@ struct nsproxy {
 	atomic_t count;
 	spinlock_t nslock;
 	struct uts_namespace *uts_ns;
+	struct net_namespace *net_ns;
 	struct namespace *namespace;
 };
 extern struct nsproxy init_nsproxy;
Index: 2.6-mm/kernel/nsproxy.c
===================================================================
--- 2.6-mm.orig/kernel/nsproxy.c
+++ 2.6-mm/kernel/nsproxy.c
@@ -14,6 +14,7 @@
 #include <linux/nsproxy.h>
 #include <linux/namespace.h>
 #include <linux/utsname.h>
+#include <linux/net_ns.h>
 
 static inline void get_nsproxy(struct nsproxy *ns)
 {
@@ -59,6 +60,8 @@ struct nsproxy *dup_namespaces(struct ns
 			get_namespace(ns->namespace);
 		if (ns->uts_ns)
 			get_uts_ns(ns->uts_ns);
+		if (ns->net_ns)
+			get_net_ns(ns->net_ns);
 	}
 
 	return ns;
@@ -79,7 +82,7 @@ int copy_namespaces(int flags, struct ta
 
 	get_nsproxy(old_ns);
 
-	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS)))
+	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWNET)))
 		return 0;
 
 	new_ns = clone_namespaces(old_ns);
@@ -91,21 +94,28 @@ int copy_namespaces(int flags, struct ta
 	tsk->nsproxy = new_ns;
 
 	err = copy_namespace(flags, tsk);
-	if (err) {
-		tsk->nsproxy = old_ns;
-		put_nsproxy(new_ns);
-		goto out;
-	}
+	if (err)
+		goto bad_copy_namespace;
 
 	err = copy_utsname(flags, tsk);
-	if (err) {
-		if (new_ns->namespace)
-			put_namespace(new_ns->namespace);
-		tsk->nsproxy = old_ns;
-		put_nsproxy(new_ns);
-		goto out;
-	}
+	if (err)
+		goto bad_copy_utsname;
 
+  	err = copy_network(flags, tsk);
+  	if (err)
+ 		goto bad_copy_network;
+
+  	goto out;
+
+bad_copy_network:
+	if (new_ns->uts_ns)
+		put_uts_ns(new_ns->uts_ns);
+bad_copy_utsname:
+	if (new_ns->namespace)
+		put_namespace(new_ns->namespace);
+bad_copy_namespace:
+	tsk->nsproxy = old_ns;
+	put_nsproxy(new_ns);
 out:
 	put_nsproxy(old_ns);
 	return err;
@@ -117,5 +127,7 @@ void free_nsproxy(struct nsproxy *ns)
 			put_namespace(ns->namespace);
 		if (ns->uts_ns)
 			put_uts_ns(ns->uts_ns);
+		if (ns->net_ns)
+			put_net_ns(ns->net_ns);
 		kfree(ns);
 }
Index: 2.6-mm/include/linux/sched.h
===================================================================
--- 2.6-mm.orig/include/linux/sched.h
+++ 2.6-mm/include/linux/sched.h
@@ -25,6 +25,7 @@
 #define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
 #define CLONE_NEWUTS		0x04000000	/* New utsname group? */
+#define CLONE_NEWNET		0x08000000	/* New network namespace */
 
 /*
  * Scheduling policies
Index: 2.6-mm/net/Kconfig
===================================================================
--- 2.6-mm.orig/net/Kconfig
+++ 2.6-mm/net/Kconfig
@@ -60,6 +60,15 @@ config INET
 
 	  Short answer: say Y.
 
+config NET_NS
+	bool "Network namespaces"
+	depends on NET
+	default n
+	---help---
+	  Support for network namespaces.  This allows containers, i.e.
+	  vservers, to use network namespaces to provide isolated
+	  network for different servers.  If unsure, say N.
+
 if INET
 source "net/ipv4/Kconfig"
 source "net/ipv6/Kconfig"
Index: 2.6-mm/net/Makefile
===================================================================
--- 2.6-mm.orig/net/Makefile
+++ 2.6-mm/net/Makefile
@@ -50,3 +50,4 @@ obj-$(CONFIG_TIPC)		+= tipc/
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
 endif
+obj-$(CONFIG_NET_NS)            += net_ns.o
Index: 2.6-mm/include/linux/init_task.h
===================================================================
--- 2.6-mm.orig/include/linux/init_task.h
+++ 2.6-mm/include/linux/init_task.h
@@ -4,6 +4,7 @@
 #include <linux/file.h>
 #include <linux/rcupdate.h>
 #include <linux/utsname.h>
+#include <linux/net_ns.h>
 #include <linux/interrupt.h>
 
 #define INIT_FDTABLE \
@@ -73,6 +74,7 @@ extern struct nsproxy init_nsproxy;
 	.count		= ATOMIC_INIT(1),				\
 	.nslock		= SPIN_LOCK_UNLOCKED,				\
 	.uts_ns		= &init_uts_ns,					\
+	.net_ns         = &init_net_ns,                                 \
 	.namespace	= NULL,						\
 }
 
Index: 2.6-mm/kernel/fork.c
===================================================================
--- 2.6-mm.orig/kernel/fork.c
+++ 2.6-mm/kernel/fork.c
@@ -1592,13 +1592,15 @@ asmlinkage long sys_unshare(unsigned lon
 	struct sem_undo_list *new_ulist = NULL;
 	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
 	struct uts_namespace *uts, *new_uts = NULL;
+	struct net_namespace *net, *new_net = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
 	/* Return -EINVAL for all unsupported flags */
 	err = -EINVAL;
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
-				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS))
+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS|
+			        CLONE_NEWNET))
 		goto bad_unshare_out;
 
 	if ((err = unshare_thread(unshare_flags)))
@@ -1617,18 +1619,20 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_cleanup_fd;
 	if ((err = unshare_utsname(unshare_flags, &new_uts)))
 		goto bad_unshare_cleanup_semundo;
+ 	if ((err = unshare_network(unshare_flags, &new_net)))
+ 		goto bad_unshare_cleanup_utsname;
 
-	if (new_ns || new_uts) {
+	if (new_ns || new_uts || new_net) {
 		old_nsproxy = current->nsproxy;
 		new_nsproxy = dup_namespaces(old_nsproxy);
 		if (!new_nsproxy) {
 			err = -ENOMEM;
-			goto bad_unshare_cleanup_uts;
+			goto bad_unshare_cleanup_net;
 		}
 	}
 
 	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
-				new_uts) {
+				new_uts || new_net) {
 
 		task_lock(current);
 
@@ -1676,13 +1680,23 @@ asmlinkage long sys_unshare(unsigned lon
 			new_uts = uts;
 		}
 
+ 		if (new_net) {
+ 			net = current->nsproxy->net_ns;
+ 			current->nsproxy->net_ns = new_net;
+			new_net = net;
+ 		}
+
 		task_unlock(current);
 	}
 
 	if (new_nsproxy)
 		put_nsproxy(new_nsproxy);
 
-bad_unshare_cleanup_uts:
+bad_unshare_cleanup_net:
+	if (new_net)
+		put_net_ns(new_net);
+
+bad_unshare_cleanup_utsname:
 	if (new_uts)
 		put_uts_ns(new_uts);
 
Index: 2.6-mm/init/version.c
===================================================================
--- 2.6-mm.orig/init/version.c
+++ 2.6-mm/init/version.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/net_ns.h>
 #include <linux/version.h>
 #include <linux/sched.h>
 
@@ -33,6 +34,13 @@ struct uts_namespace init_uts_ns = {
 };
 EXPORT_SYMBOL_GPL(init_uts_ns);
 
+struct net_namespace init_net_ns = {
+	.kref = {
+		.refcount	= ATOMIC_INIT(2),
+	},
+};
+EXPORT_SYMBOL_GPL(init_net_ns);
+
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";

--
