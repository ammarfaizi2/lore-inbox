Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWELPYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWELPYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWELPYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:24:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47820 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932133AbWELPYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:24:17 -0400
Date: Fri, 12 May 2006 10:24:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, dev@sw.ru,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
Message-ID: <20060512152412.GA11734@sergelap.austin.ibm.com>
References: <29vfyljM-1.2006059-s@us.ibm.com> <20060510021135.GC32523@sergelap.austin.ibm.com> <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com> <20060510132623.GB20892@sergelap.austin.ibm.com> <m1ac9pwves.fsf@ebiederm.dsl.xmission.com> <20060510203449.GA12215@sergelap.austin.ibm.com> <m1ejz1vc2d.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejz1vc2d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Eric W. Biederman (ebiederm@xmission.com):
> >> There are two additional things I can think of that are worth looking
> >> at:
> >> - moving copy_uts_namespace, and copy_namespace inside of copy_nsproxy
> >>   so we only run those we create a new nsproxy instance.
> >
> > Was about to do that when I stopped because I was thinking I'd need to
> > keep track of which namespace had been copied before a failaure, for
> > the sake of clone.
> >
> > But of course I don't have to - copy_nsproxy could do the cleanup itself
> > on failure.
> >
> > So this should be a nice little cleanup - especially as # namespaces
> > increases.
> 
> Yes.  At least if nsproxy doesn't show a performance degradation...

Ok, at least here is a patch to do a bit of this.  It moves things
around enough that didn't want to combine this with setting
namespace->refcount to #nsproxies, or your inlining trick.

-serge

Subject: [PATCH] nsproxy: code cleanup

consolidate nsproxy and namespace copy/get/exit.

Signed-off-by:  <hallyn@elg11.watson.ibm.com>

---

 include/linux/namespace.h |    8 ----
 include/linux/nsproxy.h   |   26 ++++++-------
 kernel/exit.c             |   13 ++-----
 kernel/fork.c             |   39 +++++++++-----------
 kernel/nsproxy.c          |   87 ++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 113 insertions(+), 60 deletions(-)

5492e3bdc0245ab27e70fe8dc6c004cb437dc8f6
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
index d137009..fce3714 100644
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -25,14 +25,6 @@ static inline void put_namespace(struct 
 		__put_namespace(namespace);
 }
 
-static inline void exit_namespace(struct task_struct *p)
-{
-	struct namespace *namespace = p->nsproxy->namespace;
-	if (namespace) {
-		put_namespace(namespace);
-	}
-}
-
 static inline void get_namespace(struct namespace *namespace)
 {
 	atomic_inc(&namespace->count);
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 18fcd8f..480f665 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -14,28 +14,24 @@ struct nsproxy {
 };
 extern struct nsproxy init_nsproxy;
 
-static inline void get_nsproxy(struct nsproxy *nsp)
+struct nsproxy *dup_namespaces(struct nsproxy *orig);
+int copy_namespaces(int flags, struct task_struct *tsk);
+void get_namespaces(struct task_struct *tsk);
+void exit_namespaces(struct nsproxy *ns);
+
+static inline void exit_task_namespaces(struct task_struct *p)
 {
-	atomic_inc(&nsp->count);
+	struct nsproxy *ns = p->nsproxy;
+	if (ns) {
+		exit_namespaces(p->nsproxy);
+		p->nsproxy = NULL;
+	}
 }
 
-struct nsproxy *clone_nsproxy(struct nsproxy *orig);
-int copy_nsproxy(int flags, struct task_struct *tsk);
-void free_nsproxy(struct nsproxy *nsp);
-
 static inline void put_nsproxy(struct nsproxy *nsp)
 {
 	if (atomic_dec_and_test(&nsp->count)) {
 		kfree(nsp);
 	}
 }
-
-static inline void exit_nsproxy(struct task_struct *p)
-{
-	struct nsproxy *nsp = p->nsproxy;
-	if (nsp) {
-		p->nsproxy = NULL;
-		put_nsproxy(nsp);
-	}
-}
 #endif
diff --git a/kernel/exit.c b/kernel/exit.c
index 921a4b7..4ded4e3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -175,7 +175,6 @@ repeat:
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
-	exit_nsproxy(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
@@ -416,13 +415,9 @@ void daemonize(const char *name, ...)
 	current->fs = fs;
 	atomic_inc(&fs->count);
 
-	exit_utsname(current);
-	exit_namespace(current);
-	exit_nsproxy(current);
+	exit_task_namespaces(current);
 	current->nsproxy = init_task.nsproxy;
-	get_nsproxy(current->nsproxy);
-	get_namespace(current->nsproxy->namespace);
-	get_uts_ns(current->nsproxy->uts_ns);
+	get_namespaces(current);
 
  	exit_files(current);
 	current->files = init_task.files;
@@ -926,9 +921,7 @@ fastcall NORET_TYPE void do_exit(long co
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
-	exit_utsname(current);
-	exit_namespace(current);
-	exit_nsproxy(current);
+	exit_task_namespaces(current);
 	exit_thread();
 	cpuset_exit(tsk);
 	exit_keys(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index baeef86..f9b607c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -45,7 +45,6 @@
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/nsproxy.h>
-#include <linux/utsname.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1062,15 +1061,11 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_signal;
 	if ((retval = copy_keys(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
-	if ((retval = copy_nsproxy(clone_flags, p)))
+	if ((retval = copy_namespaces(clone_flags, p)))
 		goto bad_fork_cleanup_keys;
-	if ((retval = copy_utsname(clone_flags, p)))
-		goto bad_fork_cleanup_nsproxy;
-	if ((retval = copy_namespace(clone_flags, p)))
-		goto bad_fork_cleanup_utsname;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_namespaces;
 
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
 	/*
@@ -1157,7 +1152,7 @@ static task_t *copy_process(unsigned lon
 		spin_unlock(&current->sighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 		retval = -ERESTARTNOINTR;
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_namespaces;
 	}
 
 	if (clone_flags & CLONE_THREAD) {
@@ -1170,7 +1165,7 @@ static task_t *copy_process(unsigned lon
 			spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
 			retval = -EAGAIN;
-			goto bad_fork_cleanup_namespace;
+			goto bad_fork_cleanup_namespaces;
 		}
 
 		p->group_leader = current->group_leader;
@@ -1222,12 +1217,8 @@ static task_t *copy_process(unsigned lon
 	proc_fork_connector(p);
 	return p;
 
-bad_fork_cleanup_namespace:
-	exit_namespace(p);
-bad_fork_cleanup_utsname:
-	exit_utsname(p);
-bad_fork_cleanup_nsproxy:
-	exit_nsproxy(p);
+bad_fork_cleanup_namespaces:
+	exit_task_namespaces(p);
 bad_fork_cleanup_keys:
 	exit_keys(p);
 bad_fork_cleanup_mm:
@@ -1570,7 +1561,7 @@ asmlinkage long sys_unshare(unsigned lon
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
 	struct nsproxy *new_nsproxy, *old_nsproxy;
-	struct uts_namespace *new_uts = NULL;
+	struct uts_namespace *uts, *new_uts = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
@@ -1595,21 +1586,20 @@ asmlinkage long sys_unshare(unsigned lon
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
 	if ((err = unshare_utsname(unshare_flags, &new_uts)))
-		goto bad_unshare_cleanup_fd;
+		goto bad_unshare_cleanup_semundo;
 
 	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
 				new_uts) {
 
 		old_nsproxy = current->nsproxy;
-		new_nsproxy = clone_nsproxy(old_nsproxy);
+		new_nsproxy = dup_namespaces(old_nsproxy);
 		if (!new_nsproxy) {
 			err = -ENOMEM;
-			goto bad_unshare_cleanup_semundo;
+			goto bad_unshare_cleanup_uts;
 		}
 
 		task_lock(current);
 		current->nsproxy = new_nsproxy;
-		put_nsproxy(old_nsproxy);
 
 		if (new_fs) {
 			fs = current->fs;
@@ -1645,13 +1635,20 @@ asmlinkage long sys_unshare(unsigned lon
 		}
 
 		if (new_uts) {
-			put_uts_ns(current->nsproxy->uts_ns);
+			uts = current->nsproxy->uts_ns;
 			current->nsproxy->uts_ns = new_uts;
+			new_uts = uts;
 		}
 
 		task_unlock(current);
+
+		put_nsproxy(old_nsproxy);
 	}
 
+bad_unshare_cleanup_uts:
+	if (new_uts)
+		put_uts_ns(new_uts);
+
 bad_unshare_cleanup_semundo:
 bad_unshare_cleanup_fd:
 	if (new_fd)
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 2390afb..a93a0c5 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -13,8 +13,31 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/nsproxy.h>
+#include <linux/namespace.h>
+#include <linux/utsname.h>
 
-struct nsproxy *clone_nsproxy(struct nsproxy *orig)
+static inline void get_nsproxy(struct nsproxy *ns)
+{
+	atomic_inc(&ns->count);
+}
+
+void get_namespaces(struct task_struct *tsk)
+{
+	struct nsproxy *ns = tsk->nsproxy;
+	if (ns) {
+		get_nsproxy(ns);
+		if (ns->namespace)
+			get_namespace(ns->namespace);
+		if (ns->uts_ns)
+			get_uts_ns(ns->uts_ns);
+	}
+}
+
+/*
+ * creates a copy of "orig" with refcount 1.
+ * This does not grab references to the contained namespaces.
+ */
+static inline struct nsproxy *clone_namespaces(struct nsproxy *orig)
 {
 	struct nsproxy *ns;
 
@@ -26,7 +49,42 @@ struct nsproxy *clone_nsproxy(struct nsp
 	return ns;
 }
 
-int copy_nsproxy(int flags, struct task_struct *tsk)
+/*
+ * copies the nsproxy, setting refcount to 1, and grabbing a
+ * reference to all contained namespaces.  Called from
+ * sys_unshare()
+ */
+struct nsproxy *dup_namespaces(struct nsproxy *orig)
+{
+	struct nsproxy *ns = clone_namespaces(orig);
+
+	if (ns) {
+		if (ns->namespace)
+			get_namespace(ns->namespace);
+		if (ns->uts_ns)
+			get_uts_ns(ns->uts_ns);
+	}
+
+	return ns;
+}
+
+/*
+ * Put refcount on nsproxy and each namespace therein
+ */
+void exit_namespaces(struct nsproxy *ns)
+{
+	if (ns->namespace)
+		put_namespace(ns->namespace);
+	if (ns->uts_ns)
+		put_uts_ns(ns->uts_ns);
+	put_nsproxy(ns);
+}
+
+/*
+ * called from clone.  This now handles copy for nsproxy and all
+ * namespaces therein.
+ */
+int copy_namespaces(int flags, struct task_struct *tsk)
 {
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct nsproxy *new_ns;
@@ -35,19 +93,36 @@ int copy_nsproxy(int flags, struct task_
 	if (!old_ns)
 		return 0;
 
-	get_nsproxy(old_ns);
+	get_namespaces(tsk);
 
-	if (!(flags & CLONE_NEWNS))
+	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS)))
 		return 0;
 
-	new_ns = clone_nsproxy(old_ns);
+	new_ns = clone_namespaces(old_ns);
 	if (!new_ns) {
 		err = -ENOMEM;
 		goto out;
 	}
+
 	tsk->nsproxy = new_ns;
 
+	err = copy_namespace(flags, tsk);
+	if (err) {
+		tsk->nsproxy = old_ns;
+		put_nsproxy(new_ns);
+		goto out;
+	}
+
+	err = copy_utsname(flags, tsk);
+	if (err) {
+		if (new_ns->namespace)
+			put_namespace(new_ns->namespace);
+		tsk->nsproxy = old_ns;
+		put_nsproxy(new_ns);
+		goto out;
+	}
+
 out:
-	put_nsproxy(old_ns);
+	exit_namespaces(old_ns);
 	return err;
 }
-- 
1.1.6
