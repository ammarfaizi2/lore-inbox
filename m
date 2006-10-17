Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWJQUx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWJQUx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWJQUxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:53:40 -0400
Received: from cap31-3-82-227-199-249.fbx.proxad.net ([82.227.199.249]:43693
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750749AbWJQUxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:53:36 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20061017205316.160133000@localhost.localdomain>
References: <20061017203004.555659000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 17 Oct 2006 22:30:09 +0200
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>, Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch -mm 5/7] add pid_namespace to nsproxy
Content-Disposition: inline; filename=pid-namespace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pid namespace framework to the nsproxy object. The
copy of the pid namespace only increases the refcount on the global
pid namespace, init_pid_ns, and unshare is not implemented.

There is no configuration option to activate or deactivate this
feature because this not relevant for the moment.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
---
 include/linux/init_task.h     |    2 ++
 include/linux/nsproxy.h       |    2 ++
 include/linux/pid_namespace.h |   20 ++++++++++++++++++--
 kernel/nsproxy.c              |   26 +++++++++++++++++++-------
 kernel/pid.c                  |   23 +++++++++++++++++++++++
 5 files changed, 64 insertions(+), 9 deletions(-)

Index: 2.6.19-rc2-mm1/include/linux/init_task.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/init_task.h
+++ 2.6.19-rc2-mm1/include/linux/init_task.h
@@ -7,6 +7,7 @@
 #include <linux/utsname.h>
 #include <linux/lockdep.h>
 #include <linux/ipc.h>
+#include <linux/pid_namespace.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -70,6 +71,7 @@
 
 extern struct nsproxy init_nsproxy;
 #define INIT_NSPROXY(nsproxy) {						\
+	.pid_ns		= &init_pid_ns,					\
 	.count		= ATOMIC_INIT(1),				\
 	.nslock		= SPIN_LOCK_UNLOCKED,				\
 	.id		= 0,						\
Index: 2.6.19-rc2-mm1/include/linux/nsproxy.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/nsproxy.h
+++ 2.6.19-rc2-mm1/include/linux/nsproxy.h
@@ -7,6 +7,7 @@
 struct mnt_namespace;
 struct uts_namespace;
 struct ipc_namespace;
+struct pid_namespace;
 
 /*
  * A structure to contain pointers to all per-process
@@ -27,6 +28,7 @@ struct nsproxy {
 	struct uts_namespace *uts_ns;
 	struct ipc_namespace *ipc_ns;
 	struct mnt_namespace *mnt_ns;
+	struct pid_namespace *pid_ns;
 };
 extern struct nsproxy init_nsproxy;
 
Index: 2.6.19-rc2-mm1/include/linux/pid_namespace.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/pid_namespace.h
+++ 2.6.19-rc2-mm1/include/linux/pid_namespace.h
@@ -5,6 +5,8 @@
 #include <linux/mm.h>
 #include <linux/threads.h>
 #include <linux/pid.h>
+#include <linux/nsproxy.h>
+#include <linux/kref.h>
 
 struct pidmap {
        atomic_t nr_free;
@@ -14,10 +16,24 @@ struct pidmap {
 #define PIDMAP_ENTRIES         ((PID_MAX_LIMIT + 8*PAGE_SIZE - 1)/PAGE_SIZE/8)
 
 struct pid_namespace {
-       struct pidmap pidmap[PIDMAP_ENTRIES];
-       int last_pid;
+	struct kref kref;
+	struct pidmap pidmap[PIDMAP_ENTRIES];
+	int last_pid;
 };
 
 extern struct pid_namespace init_pid_ns;
 
+static inline void get_pid_ns(struct pid_namespace *ns)
+{
+	kref_get(&ns->kref);
+}
+
+extern int copy_pid_ns(int flags, struct task_struct *tsk);
+extern void free_pid_ns(struct kref *kref);
+
+static inline void put_pid_ns(struct pid_namespace *ns)
+{
+	kref_put(&ns->kref, free_pid_ns);
+}
+
 #endif /* _LINUX_PID_NS_H */
Index: 2.6.19-rc2-mm1/kernel/nsproxy.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/nsproxy.c
+++ 2.6.19-rc2-mm1/kernel/nsproxy.c
@@ -19,6 +19,7 @@
 #include <linux/init_task.h>
 #include <linux/mnt_namespace.h>
 #include <linux/utsname.h>
+#include <linux/pid_namespace.h>
 
 struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
@@ -69,6 +70,8 @@ struct nsproxy *dup_namespaces(struct ns
 			get_uts_ns(ns->uts_ns);
 		if (ns->ipc_ns)
 			get_ipc_ns(ns->ipc_ns);
+		if (ns->pid_ns)
+			get_pid_ns(ns->pid_ns);
 	}
 
 	return ns;
@@ -112,10 +115,17 @@ int copy_namespaces(int flags, struct ta
 	if (err)
 		goto out_ipc;
 
+	err = copy_pid_ns(flags, tsk);
+	if (err)
+		goto out_pid;
+
 out:
 	put_nsproxy(old_ns);
 	return err;
 
+out_pid:
+	if (new_ns->ipc_ns)
+		put_ipc_ns(new_ns->ipc_ns);
 out_ipc:
 	if (new_ns->uts_ns)
 		put_uts_ns(new_ns->uts_ns);
@@ -130,11 +140,13 @@ out_ns:
 
 void free_nsproxy(struct nsproxy *ns)
 {
-		if (ns->mnt_ns)
-			put_mnt_ns(ns->mnt_ns);
-		if (ns->uts_ns)
-			put_uts_ns(ns->uts_ns);
-		if (ns->ipc_ns)
-			put_ipc_ns(ns->ipc_ns);
-		kfree(ns);
+	if (ns->mnt_ns)
+		put_mnt_ns(ns->mnt_ns);
+	if (ns->uts_ns)
+		put_uts_ns(ns->uts_ns);
+	if (ns->ipc_ns)
+		put_ipc_ns(ns->ipc_ns);
+	if (ns->pid_ns)
+		put_pid_ns(ns->pid_ns);
+	kfree(ns);
 }
Index: 2.6.19-rc2-mm1/kernel/pid.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/pid.c
+++ 2.6.19-rc2-mm1/kernel/pid.c
@@ -59,6 +59,9 @@ static inline int mk_pid(struct pid_name
  * the scheme scales to up to 4 million PIDs, runtime.
  */
 struct pid_namespace init_pid_ns = {
+	.kref = {
+		.refcount       = ATOMIC_INIT(2),
+	},
 	.pidmap = {
 		[ 0 ... PIDMAP_ENTRIES-1] = { ATOMIC_INIT(BITS_PER_PAGE), NULL }
 	},
@@ -357,6 +360,26 @@ struct pid *find_ge_pid(int nr)
 }
 EXPORT_SYMBOL_GPL(find_get_pid);
 
+int copy_pid_ns(int flags, struct task_struct *tsk)
+{
+	struct pid_namespace *old_ns = tsk->nsproxy->pid_ns;
+	int err = 0;
+
+	if (!old_ns)
+		return 0;
+
+	get_pid_ns(old_ns);
+	return err;
+}
+
+void free_pid_ns(struct kref *kref)
+{
+	struct pid_namespace *ns;
+
+	ns = container_of(kref, struct pid_namespace, kref);
+	kfree(ns);
+}
+
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or

--
