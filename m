Return-Path: <linux-kernel-owner+w=401wt.eu-S933013AbWLSXAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbWLSXAs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933058AbWLSXAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:00:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48539 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933013AbWLSXAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:00:38 -0500
Date: Tue, 19 Dec 2006 17:00:34 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, containers@lists.osdl.org
Subject: [PATCH 3/8] user ns: add user_namespace ptr to vfsmount
Message-ID: <20061219230034.GD25904@sergelap.austin.ibm.com>
References: <20061219225902.GA25904@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219225902.GA25904@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 3/8] user ns: add user_namespace ptr to vfsmount

Add user_namespace ptr to vfsmount, and define a helper to compare it
to the task's user_ns.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 fs/namespace.c        |    3 +++
 include/linux/mount.h |    2 ++
 include/linux/sched.h |   20 ++++++++++++++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5ef336c..9f98a67 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -25,6 +25,7 @@ #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/ramfs.h>
+#include <linux/user_namespace.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include "pnode.h"
@@ -56,6 +57,7 @@ struct vfsmount *alloc_vfsmnt(const char
 	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
+		mnt->mnt_user_ns = get_user_ns(current->nsproxy->user_ns);
 		atomic_set(&mnt->mnt_count, 1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
@@ -88,6 +90,7 @@ EXPORT_SYMBOL(simple_set_mnt);
 
 void free_vfsmnt(struct vfsmount *mnt)
 {
+	put_user_ns(mnt->mnt_user_ns);
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
 }
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1b7e178..acdeca7 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -21,6 +21,7 @@ struct super_block;
 struct vfsmount;
 struct dentry;
 struct mnt_namespace;
+struct user_namespace;
 
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
@@ -54,6 +55,7 @@ struct vfsmount {
 	struct list_head mnt_slave;	/* slave list entry */
 	struct vfsmount *mnt_master;	/* slave is on master->mnt_slave_list */
 	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	struct user_namespace *mnt_user_ns; /* namespace for uid interpretation */
 	int mnt_pinned;
 };
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5a3f630..450fc39 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -83,6 +83,8 @@ #include <linux/resource.h>
 #include <linux/timer.h>
 #include <linux/hrtimer.h>
 #include <linux/task_io_accounting.h>
+#include <linux/nsproxy.h>
+#include <linux/mount.h>
 
 #include <asm/processor.h>
 
@@ -1586,6 +1588,24 @@ extern int cond_resched_lock(spinlock_t 
 extern int cond_resched_softirq(void);
 
 /*
+ * Check whether a task and a vfsmnt belong to the same uidns.
+ * Since the initial namespace is exempt from these checks,
+ * return 1 if so.  Also return 1 if the vfsmnt is exempt from
+ * such checking.  Otherwise, if the uid namespaces are different,
+ * return 0.
+ */
+static inline int task_mnt_same_uidns(struct task_struct *tsk,
+					struct vfsmount *mnt)
+{
+	if (tsk->nsproxy == init_task.nsproxy)
+		return 1;
+	if (mnt->mnt_user_ns == tsk->nsproxy->user_ns)
+		return 1;
+	return 0;
+}
+
+
+/*
  * Does a critical section need to be broken due to another
  * task waiting?:
  */
-- 
1.4.1

