Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWEJCMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWEJCMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWEJCMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:12:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:32947 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751395AbWEJCLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:11:50 -0400
Date: Tue, 9 May 2006 21:11:35 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 2/9] nsproxy: incorporate fs namespace
Message-ID: <20060510021135.GC32523@sergelap.austin.ibm.com>
References: <29vfyljM-1.2006059-s@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporate fs namespace into nsproxy.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 fs/namespace.c            |   21 +++++++++++++--------
 fs/proc/base.c            |    5 +++--
 include/linux/init_task.h |    1 +
 include/linux/namespace.h |    6 ++----
 include/linux/nsproxy.h   |    3 +++
 include/linux/sched.h     |    4 +---
 kernel/exit.c             |    7 +++----
 kernel/fork.c             |    6 +++---
 8 files changed, 29 insertions(+), 24 deletions(-)

8095ae8032ce2164e7177fb2d254629e7851947c
diff --git a/fs/namespace.c b/fs/namespace.c
index 2c5f1f8..851a02d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -133,7 +133,7 @@ struct vfsmount *lookup_mnt(struct vfsmo
 
 static inline int check_mnt(struct vfsmount *mnt)
 {
-	return mnt->mnt_namespace == current->namespace;
+	return mnt->mnt_namespace == current->nsproxy->namespace;
 }
 
 static void touch_namespace(struct namespace *ns)
@@ -832,7 +832,7 @@ static int attach_recursive_mnt(struct v
 	if (parent_nd) {
 		detach_mnt(source_mnt, parent_nd);
 		attach_mnt(source_mnt, nd);
-		touch_namespace(current->namespace);
+		touch_namespace(current->nsproxy->namespace);
 	} else {
 		mnt_set_mountpoint(dest_mnt, dest_dentry, source_mnt);
 		commit_tree(source_mnt);
@@ -1372,7 +1372,7 @@ dput_out:
  */
 struct namespace *dup_namespace(struct task_struct *tsk, struct fs_struct *fs)
 {
-	struct namespace *namespace = tsk->namespace;
+	struct namespace *namespace = tsk->nsproxy->namespace;
 	struct namespace *new_ns;
 	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
 	struct vfsmount *p, *q;
@@ -1439,7 +1439,7 @@ struct namespace *dup_namespace(struct t
 
 int copy_namespace(int flags, struct task_struct *tsk)
 {
-	struct namespace *namespace = tsk->namespace;
+	struct namespace *namespace = tsk->nsproxy->namespace;
 	struct namespace *new_ns;
 	int err = 0;
 
@@ -1462,7 +1462,7 @@ int copy_namespace(int flags, struct tas
 		goto out;
 	}
 
-	tsk->namespace = new_ns;
+	tsk->nsproxy->namespace = new_ns;
 
 out:
 	put_namespace(namespace);
@@ -1685,7 +1685,7 @@ asmlinkage long sys_pivot_root(const cha
 	detach_mnt(user_nd.mnt, &root_parent);
 	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
 	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
-	touch_namespace(current->namespace);
+	touch_namespace(current->nsproxy->namespace);
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
@@ -1727,11 +1727,16 @@ static void __init init_mount_tree(void)
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
 
-	init_task.namespace = namespace;
+	init_task.nsproxy->namespace = namespace;
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
+		/* do we want namespace count to be #nsproxies,
+		 * or # processes pointing to the namespace? */
 		get_namespace(namespace);
-		p->namespace = namespace;
+#if 0
+		/* should only be 1 nsproxy so far */
+		p->nsproxy->namespace = namespace;
+#endif
 	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6cc77dc..f74acae 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -72,6 +72,7 @@ #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/nsproxy.h>
 #include "internal.h"
 
 /*
@@ -685,7 +686,7 @@ static int mounts_open(struct inode *ino
 	int ret = -EINVAL;
 
 	task_lock(task);
-	namespace = task->namespace;
+	namespace = task->nsproxy->namespace;
 	if (namespace)
 		get_namespace(namespace);
 	task_unlock(task);
@@ -752,7 +753,7 @@ static int mountstats_open(struct inode 
 		struct seq_file *m = file->private_data;
 		struct namespace *namespace;
 		task_lock(task);
-		namespace = task->namespace;
+		namespace = task->nsproxy->namespace;
 		if (namespace)
 			get_namespace(namespace);
 		task_unlock(task);
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 79ec4ea..672dc04 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -70,6 +70,7 @@ extern struct nsproxy init_nsproxy;
 #define INIT_NSPROXY(nsproxy) {						\
 	.count		= ATOMIC_INIT(1),				\
 	.nslock		= SPIN_LOCK_UNLOCKED,				\
+	.namespace	= NULL,						\
 }
 
 #define INIT_SIGHAND(sighand) {						\
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
index 3abc8e3..d137009 100644
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -4,6 +4,7 @@ #ifdef __KERNEL__
 
 #include <linux/mount.h>
 #include <linux/sched.h>
+#include <linux/nsproxy.h>
 
 struct namespace {
 	atomic_t		count;
@@ -26,11 +27,8 @@ static inline void put_namespace(struct 
 
 static inline void exit_namespace(struct task_struct *p)
 {
-	struct namespace *namespace = p->namespace;
+	struct namespace *namespace = p->nsproxy->namespace;
 	if (namespace) {
-		task_lock(p);
-		p->namespace = NULL;
-		task_unlock(p);
 		put_namespace(namespace);
 	}
 }
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 065107d..64e9075 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -4,9 +4,12 @@ #define _LINUX_NSPROXY_H
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 
+struct namespace;
+
 struct nsproxy {
 	atomic_t count;
 	spinlock_t nslock;
+	struct namespace *namespace;
 };
 extern struct nsproxy init_nsproxy;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4c0bbb3..f2c945b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -235,7 +235,6 @@ extern signed long schedule_timeout_inte
 extern signed long schedule_timeout_uninterruptible(signed long timeout);
 asmlinkage void schedule(void);
 
-struct namespace;
 struct nsproxy;
 
 /* Maximum number of active map areas.. This is a random (large) number */
@@ -807,8 +806,7 @@ #endif
 	struct fs_struct *fs;
 /* open file information */
 	struct files_struct *files;
-/* namespace */
-	struct namespace *namespace;
+/* namespaces */
 	struct nsproxy *nsproxy;
 /* signal handlers */
 	struct signal_struct *signal;
diff --git a/kernel/exit.c b/kernel/exit.c
index 234f5ea..1862d36 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -14,6 +14,7 @@ #include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
+#include <linux/nsproxy.h>
 #include <linux/namespace.h>
 #include <linux/key.h>
 #include <linux/security.h>
@@ -36,7 +37,6 @@ #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -416,11 +416,10 @@ void daemonize(const char *name, ...)
 	current->fs = fs;
 	atomic_inc(&fs->count);
 	exit_namespace(current);
-	current->namespace = init_task.namespace;
-	get_namespace(current->namespace);
 	exit_nsproxy(current);
 	current->nsproxy = init_task.nsproxy;
 	get_nsproxy(current->nsproxy);
+	get_namespace(current->nsproxy->namespace);
  	exit_files(current);
 	current->files = init_task.files;
 	atomic_inc(&current->files->count);
@@ -923,7 +922,7 @@ #endif
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
-	exit_namespace(tsk);
+	exit_namespace(current);
 	exit_nsproxy(current);
 	exit_thread();
 	cpuset_exit(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9b6f1de..06cc87a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1472,7 +1472,7 @@ static int unshare_fs(unsigned long unsh
  */
 static int unshare_namespace(unsigned long unshare_flags, struct namespace **new_nsp, struct fs_struct *new_fs)
 {
-	struct namespace *ns = current->namespace;
+	struct namespace *ns = current->nsproxy->namespace;
 
 	if ((unshare_flags & CLONE_NEWNS) &&
 	    (ns && atomic_read(&ns->count) > 1)) {
@@ -1609,8 +1609,8 @@ asmlinkage long sys_unshare(unsigned lon
 		}
 
 		if (new_ns) {
-			ns = current->namespace;
-			current->namespace = new_ns;
+			ns = current->nsproxy->namespace;
+			current->nsproxy->namespace = new_ns;
 			new_ns = ns;
 		}
 
-- 
1.3.0

