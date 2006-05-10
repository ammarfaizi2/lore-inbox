Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWEJCMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWEJCMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWEJCM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:12:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12739 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932393AbWEJCME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:12:04 -0400
Date: Tue, 9 May 2006 21:12:02 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 9/9] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060510021202.GJ32523@sergelap.austin.ibm.com>
References: <29vfyljM-8.2006059-s@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a CLONE_NEWUTS flag, and use it at clone and sys_unshare.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 include/linux/sched.h   |    1 +
 include/linux/utsname.h |    7 ++++++
 kernel/fork.c           |   13 ++++++++++--
 kernel/utsname.c        |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)

7e24342145bbc63e7cdcc62a3729b9d89e3785db
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3332d5e..55671b2 100644
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
index 339ad14..b700911 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -47,6 +47,8 @@ static inline void get_uts_ns(struct uts
 }
 
 #ifdef CONFIG_UTS_NS
+extern int unshare_utsname(unsigned long unshare_flags,
+				struct uts_namespace **new_uts);
 extern int copy_utsname(int flags, struct task_struct *tsk);
 extern void free_uts_ns(struct kref *kref);
 
@@ -64,6 +66,11 @@ static inline void exit_utsname(struct t
 }
 
 #else
+static inline int unshare_utsname(unsigned long unshare_flags,
+			struct uts_namespace **new_uts)
+{
+	return -EINVAL;
+}
 static inline int copy_utsname(int flags, struct task_struct *tsk)
 {
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d7cbae..baeef86 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1570,13 +1570,14 @@ asmlinkage long sys_unshare(unsigned lon
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
 	struct nsproxy *new_nsproxy, *old_nsproxy;
+	struct uts_namespace *new_uts = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
 	/* Return -EINVAL for all unsupported flags */
 	err = -EINVAL;
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
-				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM))
+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS))
 		goto bad_unshare_out;
 
 	if ((err = unshare_thread(unshare_flags)))
@@ -1593,8 +1594,11 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_cleanup_vm;
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
+	if ((err = unshare_utsname(unshare_flags, &new_uts)))
+		goto bad_unshare_cleanup_fd;
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
+	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
+				new_uts) {
 
 		old_nsproxy = current->nsproxy;
 		new_nsproxy = clone_nsproxy(old_nsproxy);
@@ -1640,6 +1644,11 @@ asmlinkage long sys_unshare(unsigned lon
 			new_fd = fd;
 		}
 
+		if (new_uts) {
+			put_uts_ns(current->nsproxy->uts_ns);
+			current->nsproxy->uts_ns = new_uts;
+		}
+
 		task_unlock(current);
 	}
 
diff --git a/kernel/utsname.c b/kernel/utsname.c
index 2818c9b..2c45490 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -16,6 +16,41 @@ #include <linux/utsname.h>
 #include <linux/version.h>
 
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
+		*new_uts = clone_uts_ns(current->nsproxy->uts_ns);
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
@@ -24,6 +59,7 @@ #include <linux/version.h>
 int copy_utsname(int flags, struct task_struct *tsk)
 {
 	struct uts_namespace *old_ns = tsk->nsproxy->uts_ns;
+	struct uts_namespace *new_ns;
 	int err = 0;
 	
 	if (!old_ns)
@@ -31,6 +67,23 @@ int copy_utsname(int flags, struct task_
 
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
+	tsk->nsproxy->uts_ns = new_ns;
+
+out:
+	put_uts_ns(old_ns);
 	return err;
 }
 
-- 
1.3.0

