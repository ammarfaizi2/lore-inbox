Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWEATyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWEATyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWEATyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:54:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16525 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932215AbWEATx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:53:56 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
Message-ID: <20060501203907.XF1836@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Date: Mon,  1 May 2006 14:53:52 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a CLONE_NEWUTS flag, and use it at clone and sys_unshare.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/sched.h   |    1 +
 include/linux/utsname.h |    7 ++++++
 kernel/fork.c           |   13 ++++++++++--
 kernel/utsname.c        |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)

f785920e68ae2482ff76df39d6be5335bbfcc511
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3d74d77..7f4af71 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -62,6 +62,7 @@ #define CLONE_DETACHED		0x00400000	/* Un
 #define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 #define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
+#define CLONE_NEWUTS		0x04000000	/* New utsname group? */
 
 /*
  * List of flags we want to share for kernel threads,
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index d58a406..caecec7 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -40,6 +40,8 @@ struct uts_namespace {
 extern struct uts_namespace init_uts_ns;
 
 #ifdef CONFIG_UTS_NS
+extern int unshare_utsname(unsigned long unshare_flags,
+				struct uts_namespace **new_uts);
 extern int copy_utsname(int flags, struct task_struct *tsk);
 extern void free_uts_ns(struct kref *kref);
 
@@ -70,6 +72,11 @@ static inline void put_uts_ns(struct uts
 static inline void exit_utsname(struct task_struct *p)
 {
 }
+static inline int unshare_utsname(unsigned long unshare_flags,
+			struct uts_namespace **new_uts)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline struct new_utsname *utsname(void)
diff --git a/kernel/fork.c b/kernel/fork.c
index cedfd86..c52c274 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1566,13 +1566,14 @@ asmlinkage long sys_unshare(unsigned lon
 	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
+	struct uts_namespace *new_uts = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
 	/* Return -EINVAL for all unsupported flags */
 	err = -EINVAL;
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
-				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM))
+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS))
 		goto bad_unshare_out;
 
 	if ((err = unshare_thread(unshare_flags)))
@@ -1589,8 +1590,11 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_cleanup_vm;
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
+	if ((err = unshare_utsname(unshare_flags, &new_uts)))
+		goto bad_unshare_cleanup_fd;
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
+	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
+				new_uts) {
 
 		task_lock(current);
 
@@ -1627,6 +1631,11 @@ asmlinkage long sys_unshare(unsigned lon
 			new_fd = fd;
 		}
 
+		if (new_uts) {
+			put_uts_ns(current->uts_ns);
+			current->uts_ns = new_uts;
+		}
+
 		task_unlock(current);
 	}
 
diff --git a/kernel/utsname.c b/kernel/utsname.c
index f9e8f86..5a97a21 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -21,6 +21,41 @@ static inline void get_uts_ns(struct uts
 }
 
 /*
+ * Clone a new ns copying an original utsname, setting refcount to 1
+ * @old_ns: namespace to clone
+ * Return NULL on error (failure to kmalloc), new ns otherwise
+ */
+struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
+{
+	struct uts_namespace *ns;
+
+	ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
+	if (ns) {
+		memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
+		kref_init(&ns->kref);
+	}
+	return ns;
+}
+
+/*
+ * unshare the current process' utsname namespace.
+ * called only in sys_unshare()
+ */
+int unshare_utsname(unsigned long unshare_flags, struct uts_namespace **new_uts)
+{
+	if (unshare_flags & CLONE_NEWUTS) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		*new_uts = clone_uts_ns(current->uts_ns);
+		if (!*new_uts)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
  * Copy task tsk's utsname namespace, or clone it if flags
  * specifies CLONE_NEWUTS.  In latter case, changes to the
  * utsname of this process won't be seen by parent, and vice
@@ -29,6 +64,7 @@ static inline void get_uts_ns(struct uts
 int copy_utsname(int flags, struct task_struct *tsk)
 {
 	struct uts_namespace *old_ns = tsk->uts_ns;
+	struct uts_namespace *new_ns;
 	int err = 0;
 	
 	if (!old_ns)
@@ -36,6 +72,23 @@ int copy_utsname(int flags, struct task_
 
 	get_uts_ns(old_ns);
 
+	if (!(flags & CLONE_NEWUTS))
+		return 0;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	new_ns = clone_uts_ns(old_ns);
+	if (!new_ns) {
+		err = -ENOMEM;
+		goto out;
+	}
+	tsk->uts_ns = new_ns;
+
+out:
+	put_uts_ns(old_ns);
 	return err;
 }
 
-- 
1.3.0


