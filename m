Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWELTOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWELTOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWELTOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:14:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:62945 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751237AbWELTOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:14:06 -0400
Date: Fri, 12 May 2006 14:14:04 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, dev@sw.ru,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
Message-ID: <20060512191404.GB17153@sergelap.austin.ibm.com>
References: <29vfyljM-1.2006059-s@us.ibm.com> <20060510021135.GC32523@sergelap.austin.ibm.com> <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> 
> > @@ -1727,11 +1727,16 @@ static void __init init_mount_tree(void)
> >  	namespace->root = mnt;
> >  	mnt->mnt_namespace = namespace;
> >  
> > -	init_task.namespace = namespace;
> > +	init_task.nsproxy->namespace = namespace;
> >  	read_lock(&tasklist_lock);
> >  	do_each_thread(g, p) {
> > +		/* do we want namespace count to be #nsproxies,
> > +		 * or # processes pointing to the namespace? */
> 
> I am fairly certain we want the count to be #nsproxies.
> 
> >  		get_namespace(namespace);
> > -		p->namespace = namespace;
> > +#if 0
> > +		/* should only be 1 nsproxy so far */
> > +		p->nsproxy->namespace = namespace;
> > +#endif
> >  	} while_each_thread(g, p);
> >  	read_unlock(&tasklist_lock);
> 
> So I think this bit is wrong.

Here is a patch (on top of the patchset + the patch I sent in response
to Dave) to change the fs namespace and utsname ->counts to being the
number of nsproxies holding a reference.

thanks,
-serge

Subject: [PATCH 11/11] nsproxy: change meaning of namespace refcount

switch namespace+utsname refcount to count nsproxies

Signed-off-by:  <hallyn@elg11.watson.ibm.com>

---

 fs/namespace.c          |   13 +------------
 include/linux/nsproxy.h |   18 +++++++++---------
 kernel/fork.c           |    3 +--
 kernel/nsproxy.c        |   39 ++++++++++++++-------------------------
 4 files changed, 25 insertions(+), 48 deletions(-)

41b3b9a9df03156627adc34b88c041dd3ade1236
diff --git a/fs/namespace.c b/fs/namespace.c
index 851a02d..33330fe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1711,7 +1711,6 @@ static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
 	struct namespace *namespace;
-	struct task_struct *g, *p;
 
 	mnt = do_kern_mount("rootfs", 0, "rootfs", NULL);
 	if (IS_ERR(mnt))
@@ -1728,17 +1727,7 @@ static void __init init_mount_tree(void)
 	mnt->mnt_namespace = namespace;
 
 	init_task.nsproxy->namespace = namespace;
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		/* do we want namespace count to be #nsproxies,
-		 * or # processes pointing to the namespace? */
-		get_namespace(namespace);
-#if 0
-		/* should only be 1 nsproxy so far */
-		p->nsproxy->namespace = namespace;
-#endif
-	} while_each_thread(g, p);
-	read_unlock(&tasklist_lock);
+	get_namespace(namespace);
 
 	set_fs_pwd(current->fs, namespace->root, namespace->root->mnt_root);
 	set_fs_root(current->fs, namespace->root, namespace->root->mnt_root);
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 6046fc3..3793017 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -17,21 +17,21 @@ extern struct nsproxy init_nsproxy;
 struct nsproxy *dup_namespaces(struct nsproxy *orig);
 int copy_namespaces(int flags, struct task_struct *tsk);
 void get_task_namespaces(struct task_struct *tsk);
-void exit_namespaces(struct nsproxy *ns);
+void free_nsproxy(struct nsproxy *ns);
 
-static inline void exit_task_namespaces(struct task_struct *p)
+static inline void put_nsproxy(struct nsproxy *ns)
 {
-	struct nsproxy *ns = p->nsproxy;
-	if (ns) {
-		exit_namespaces(p->nsproxy);
-		p->nsproxy = NULL;
+	if (atomic_dec_and_test(&ns->count)) {
+		free_nsproxy(ns);
 	}
 }
 
-static inline void put_nsproxy(struct nsproxy *nsp)
+static inline void exit_task_namespaces(struct task_struct *p)
 {
-	if (atomic_dec_and_test(&nsp->count)) {
-		kfree(nsp);
+	struct nsproxy *ns = p->nsproxy;
+	if (ns) {
+		put_nsproxy(ns);
+		p->nsproxy = NULL;
 	}
 }
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index f9b607c..6214427 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1470,8 +1470,7 @@ static int unshare_namespace(unsigned lo
 {
 	struct namespace *ns = current->nsproxy->namespace;
 
-	if ((unshare_flags & CLONE_NEWNS) &&
-	    (ns && atomic_read(&ns->count) > 1)) {
+	if ((unshare_flags & CLONE_NEWNS) && ns) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index d963af9..19abf95 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -21,26 +21,18 @@ static inline void get_nsproxy(struct ns
 	atomic_inc(&ns->count);
 }
 
-static inline void get_namespaces(struct nsproxy *ns)
-{
-	get_nsproxy(ns);
-	if (ns->namespace)
-		get_namespace(ns->namespace);
-	if (ns->uts_ns)
-		get_uts_ns(ns->uts_ns);
-}
-
 void get_task_namespaces(struct task_struct *tsk)
 {
 	struct nsproxy *ns = tsk->nsproxy;
 	if (ns) {
-		get_namespaces(ns);
+		get_nsproxy(ns);
 	}
 }
 
 /*
  * creates a copy of "orig" with refcount 1.
- * This does not grab references to the contained namespaces.
+ * This does not grab references to the contained namespaces,
+ * so that needs to be done by dup_namespaces.
  */
 static inline struct nsproxy *clone_namespaces(struct nsproxy *orig)
 {
@@ -74,18 +66,6 @@ struct nsproxy *dup_namespaces(struct ns
 }
 
 /*
- * Put refcount on nsproxy and each namespace therein
- */
-void exit_namespaces(struct nsproxy *ns)
-{
-	if (ns->namespace)
-		put_namespace(ns->namespace);
-	if (ns->uts_ns)
-		put_uts_ns(ns->uts_ns);
-	put_nsproxy(ns);
-}
-
-/*
  * called from clone.  This now handles copy for nsproxy and all
  * namespaces therein.
  */
@@ -98,7 +78,7 @@ int copy_namespaces(int flags, struct ta
 	if (!old_ns)
 		return 0;
 
-	get_namespaces(old_ns);
+	get_nsproxy(old_ns);
 
 	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS)))
 		return 0;
@@ -128,6 +108,15 @@ int copy_namespaces(int flags, struct ta
 	}
 
 out:
-	exit_namespaces(old_ns);
+	put_nsproxy(old_ns);
 	return err;
 }
+
+void free_nsproxy(struct nsproxy *ns)
+{
+		if (ns->namespace)
+			put_namespace(ns->namespace);
+		if (ns->uts_ns)
+			put_uts_ns(ns->uts_ns);
+		kfree(ns);
+}
-- 
1.1.6
