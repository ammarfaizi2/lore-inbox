Return-Path: <linux-kernel-owner+w=401wt.eu-S1030356AbXAEHBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbXAEHBs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbXAEHBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:01:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43944 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030356AbXAEHBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:01:47 -0500
Date: Fri, 5 Jan 2007 01:00:42 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 0/8] user ns: Introduction
Message-ID: <20070105070042.GA24802@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104200323.3b09f81a.akpm@osdl.org> <20070105054337.GB1412@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105054337.GB1412@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Andrew Morton (akpm@osdl.org):
> > On Thu, 4 Jan 2007 12:06:35 -0600
> > "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> >
> > > This patchset adds a user namespace, which allows a process to
> > > unshare its user_struct table,  allowing for separate accounting
> > > per user namespace.
> >
> > With these patches applied and with CONFIG_USER_NS=n, my selinux-enabled
> > standard FC5 machine throws a complete fit:
...
> >
> > Setting CONFIG_USER_NS=y fixes this.
> 
> Ok, I see.  The CONFIG_USER_NS split is absolutely horrible.  Should
> really get rid of the user_ns pointers altogether when !CONFIG_USER_NS.
> I'll try to fix it up without putting ifdefs all over - planning to send
> a patch tomorrow.

Actually it's not that bad.  Following patch fixes what I believe is
the underlying problem, and in any case was a definite bug.

thanks,
-serge

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] user ns: fix !CONFIG_USER_NS mount denial

Don't do user_ns permission checks when !CONFIG_USER_NS.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 fs/namespace.c                 |    6 ++----
 include/linux/sched.h          |    8 ++++++++
 include/linux/user_namespace.h |   15 +++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2ed89d4..664c6f2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -236,10 +236,8 @@ static struct vfsmount *clone_mnt(struct
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt;
 
-	if (!(old->mnt_flags & MNT_SHARE_NS)) {
-		if (old->mnt_user_ns != current->nsproxy->user_ns)
-			return ERR_PTR(-EPERM);
-	}
+	if (!clone_mnt_userns_permission(old))
+		return ERR_PTR(-EPERM);
 
 	mnt = alloc_vfsmnt(old->mnt_devname);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 55ecf81..0542f34 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1588,6 +1588,7 @@ extern int cond_resched(void);
 extern int cond_resched_lock(spinlock_t * lock);
 extern int cond_resched_softirq(void);
 
+#ifdef CONFIG_USER_NS
 /*
  * Check whether a task and a vfsmnt belong to the same uidns.
  * Since the initial namespace is exempt from these checks,
@@ -1606,6 +1607,13 @@ static inline int task_mnt_same_uidns(st
 		return 1;
 	return 0;
 }
+#else
+static inline int task_mnt_same_uidns(struct task_struct *tsk,
+					struct vfsmount *mnt)
+{
+	return 1;
+}
+#endif
 
 
 /*
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index be3e484..e4ce9cb 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -35,6 +35,16 @@ static inline void put_user_ns(struct us
 		kref_put(&ns->kref, free_user_ns);
 }
 
+static inline int clone_mnt_userns_permission(struct vfsmount *old)
+{
+	if (!(old->mnt_flags & MNT_SHARE_NS)) {
+		if (old->mnt_user_ns != current->nsproxy->user_ns)
+			return 0;
+	}
+
+	return 1;
+}
+
 #else
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
@@ -59,6 +69,11 @@ static inline int copy_user_ns(int flags
 static inline void put_user_ns(struct user_namespace *ns)
 {
 }
+
+static inline int clone_mnt_userns_permission(struct vfsmount *old)
+{
+	return 1;
+}
 #endif
 
 #endif /* _LINUX_USER_H */
-- 
1.4.1

