Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSJXUSp>; Thu, 24 Oct 2002 16:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265638AbSJXUSp>; Thu, 24 Oct 2002 16:18:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61893 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265637AbSJXUSd>;
	Thu, 24 Oct 2002 16:18:33 -0400
Subject: Re: [RFC] shared credentials with vfs snapshotting
From: "David C. Hansen" <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave McCracken <dmccr@us.ibm.com>
In-Reply-To: <1035490360.9081.73.camel@nighthawk>
References: <1035490360.9081.73.camel@nighthawk>
Content-Type: multipart/mixed; boundary="=-a3YLtJ8s2ztkspB0MeUP"
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 13:24:16 -0700
Message-Id: <1035491056.9081.75.camel@nighthawk>
Mime-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a3YLtJ8s2ztkspB0MeUP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oh yeah, the code!
-- 
Dave Hansen
haveblue@us.ibm.com

--=-a3YLtJ8s2ztkspB0MeUP
Content-Disposition: attachment; filename=cred-sharing-snapshotting-2.5.44-0.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=cred-sharing-snapshotting-2.5.44-0.patch;
	charset=ISO-8859-1

diff -X exclude -urN linux-2.5.44/arch/i386/kernel/init_task.c linux-2.5.44=
-cred/arch/i386/kernel/init_task.c
--- linux-2.5.44/arch/i386/kernel/init_task.c	Fri Oct 18 21:02:34 2002
+++ linux-2.5.44-cred/arch/i386/kernel/init_task.c	Thu Oct 24 11:33:14 2002
@@ -11,6 +11,7 @@
 static struct fs_struct init_fs =3D INIT_FS;
 static struct files_struct init_files =3D INIT_FILES;
 static struct signal_struct init_signals =3D INIT_SIGNALS(init_signals);
+static struct cred_struct init_cred =3D INIT_CRED;
 struct mm_struct init_mm =3D INIT_MM(init_mm);
=20
 /*
diff -X exclude -urN linux-2.5.44/arch/s390x/kernel/linux32.c linux-2.5.44-=
cred/arch/s390x/kernel/linux32.c
--- linux-2.5.44/arch/s390x/kernel/linux32.c	Fri Oct 18 21:01:16 2002
+++ linux-2.5.44-cred/arch/s390x/kernel/linux32.c	Thu Oct 24 12:14:14 2002
@@ -194,12 +194,10 @@
=20
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i =3D current->ngroups;
+	i =3D getgroups16(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=3D0;j<i;j++)
-			groups[j] =3D current->groups[j];
 		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
 			return -EFAULT;
 	}
@@ -217,10 +215,7 @@
 		return -EINVAL;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
 		return -EFAULT;
-	for (i =3D 0 ; i < gidsetsize ; i++)
-		current->groups[i] =3D (gid_t)groups[i];
-	current->ngroups =3D gidsetsize;
-	return 0;
+	return setgroups16(gidgetsize, grouplist);
 }
=20
 asmlinkage long sys32_getuid16(void)
Binary files linux-2.5.44/arch/sparc64/kernel/.sys_sparc32.c.swp and linux-=
2.5.44-cred/arch/sparc64/kernel/.sys_sparc32.c.swp differ
diff -X exclude -urN linux-2.5.44/arch/sparc64/kernel/sys_sparc32.c linux-2=
.5.44-cred/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.44/arch/sparc64/kernel/sys_sparc32.c	Fri Oct 18 21:02:00 2002
+++ linux-2.5.44-cred/arch/sparc64/kernel/sys_sparc32.c	Thu Oct 24 12:14:48=
 2002
@@ -211,12 +211,10 @@
=20
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i =3D current->ngroups;
+	i =3D getgroups16(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=3D0;j<i;j++)
-			groups[j] =3D current->groups[j];
 		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
 			return -EFAULT;
 	}
@@ -234,10 +232,7 @@
 		return -EINVAL;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
 		return -EFAULT;
-	for (i =3D 0 ; i < gidsetsize ; i++)
-		current->groups[i] =3D (gid_t)groups[i];
-	current->ngroups =3D gidsetsize;
-	return 0;
+	return setgroups16(gidsetsize, groups);
 }
=20
 asmlinkage long sys32_getuid16(void)
diff -X exclude -urN linux-2.5.44/fs/exec.c linux-2.5.44-cred/fs/exec.c
--- linux-2.5.44/fs/exec.c	Fri Oct 18 21:01:48 2002
+++ linux-2.5.44-cred/fs/exec.c	Thu Oct 24 11:47:20 2002
@@ -864,6 +864,11 @@
         current->suid =3D current->euid =3D current->fsuid =3D bprm->e_uid=
;
         current->sgid =3D current->egid =3D current->fsgid =3D bprm->e_gid=
;
=20
+	current->cred->suid =3D current->cred->euid =3D bprm->e_uid;
+	setfsuid(bprm->e_uid);
+	current->cred->sgid =3D current->cred->egid =3D bprm->e_gid;
+	setfsgid(bprm->e_gid);
+=09
 	if(do_unlock)
 		unlock_kernel();
=20
diff -X exclude -urN linux-2.5.44/include/linux/cred.h linux-2.5.44-cred/in=
clude/linux/cred.h
--- linux-2.5.44/include/linux/cred.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-cred/include/linux/cred.h	Thu Oct 24 11:16:25 2002
@@ -0,0 +1,101 @@
+#ifndef _LINUX_CRED_H
+#define _LINUX_CRED_H
+
+#ifdef __KERNEL__
+
+#include <linux/param.h>
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+
+struct cred_struct {
+	atomic_t		count;
+	uid_t			uid,euid,suid;
+	gid_t			gid,egid,sgid;
+	struct vfs_cred*	vfscred;
+	kernel_cap_t		cap_effective, cap_inheritable, cap_permitted;
+	int			keep_capabilities:1;
+	structuser_struct	*user;
+};
+
+
+
+/*
+ * VFS credentials
+ *
+ * This is for use by filesystems, sockets, RPC for user authentication
+ * purposes. It is a direct replacement for the 2.4.x task entries
+ * fsuid/fsgid + groups[].
+ *
+ * The VFS credential may be shared among different threads, interrupts,..=
.
+ * without any fancy locking mechanisms provided one sticks to using
+ * copy on write semantics. The latter is a guarantee that if more than
+ * one object is referencing the vfscred, then the data in the struct will
+ * not change.
+ *
+ * This again means that the recipe for changing one or more of fsuid,
+ * fsgid, ...  for the current thread will usually be as follows:
+ *  1) copy the existing vfscred into a new one using clone_current_vfscre=
d()
+ *  2) make all the necessary changes to the clone
+ *  3) use set_current_vfscred() in order to register the change to the
+ *     task_struct
+ *
+ */
+struct vfs_cred {
+	atomic_t	count;
+
+	uid_t		uid;
+	gid_t		gid;
+
+	int		ngroups;
+	gid_t		*groups;
+	/* Default storage for groups */
+	gid_t		__group_storage[NGROUPS];
+};
+
+#define NOGID ((gid_t)-1)
+#define NOUID ((uid_t)-1)
+
+extern struct vfs_cred init_vfscred;
+extern void credentials_init(void);
+
+extern void put_vfscred(struct vfs_cred *);
+extern struct vfs_cred *vfscred_create(uid_t, gid_t);
+extern struct vfs_cred *vfscred_clone(struct vfs_cred *);
+extern int vfscred_getgroups(struct vfs_cred *, int, gid_t *);
+extern int vfscred_setgroups(struct vfs_cred *, int, gid_t *);
+extern int vfscred_match_group(struct vfs_cred *, gid_t);
+
+static inline struct vfs_cred *get_vfscred(struct vfs_cred *cred)
+{
+	atomic_inc(&cred->count);
+	return cred;
+}
+
+static inline int vfscred_count(struct vfs_cred *cred)
+{
+	return atomic_read(&cred->count);
+}
+
+#define get_current_vfscred()	get_vfscred(current->vfscred)
+
+extern struct vfs_cred *clone_current_vfscred(void);
+extern void set_current_vfscred(struct vfs_cred *);
+extern int setfsuid(uid_t);
+extern int setfsgid(gid_t);
+extern int setgroups(int, gid_t *);
+extern int getgroups(int, gid_t *);
+
+extern struct vfs_cred *get_task_vfscred(struct task_struct *);
+extern void set_task_vfscred(struct task_struct *, struct vfs_cred *);
+
+/* Grrr: Support for oddball functions in security/dummy.c */
+extern int task_setfsuid(struct task_struct *, uid_t);
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X)
+extern int setgroups16(int, gid16_t *);
+extern int getgroups16(int, gid16_t *);
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CRED_H */
diff -X exclude -urN linux-2.5.44/include/linux/init_task.h linux-2.5.44-cr=
ed/include/linux/init_task.h
--- linux-2.5.44/include/linux/init_task.h	Fri Oct 18 21:01:11 2002
+++ linux-2.5.44-cred/include/linux/init_task.h	Thu Oct 24 11:26:13 2002
@@ -50,6 +50,24 @@
 	.shared_pending	=3D { NULL, &sig.shared_pending.head, {{0}}}, \
 }
=20
+=20
+#define	INIT_CRED					\
+{							\
+	.count			=3D ATOMIC_INIT(1), 	\
+	.uid			=3D 0,			\
+	.euid			=3D 0,			\
+	.suid			=3D 0,			\
+	.gid			=3D 0,			\
+	.egid			=3D 0,			\
+	.sgid			=3D 0,			\
+	.vfscred		=3D &init_vfcred		\
+	.cap_effective		=3D CAP_INIT_EFF_SET,	\
+	.cap_inheritable	=3D CAP_INIT_INH_SET,	\
+	.cap_permitted		=3D CAP_FULL_SET,		\
+	.keep_capabilities	=3D 0,			\
+	.user			=3D INIT_USER		\
+}
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=3D0, limit=3D0x1fffff (=3D2MB)
@@ -80,17 +98,13 @@
 	.real_timer	=3D {						\
 		.function	=3D it_real_fn				\
 	},								\
-	.cap_effective	=3D CAP_INIT_EFF_SET,				\
-	.cap_inheritable =3D CAP_INIT_INH_SET,				\
-	.cap_permitted	=3D CAP_FULL_SET,					\
-	.keep_capabilities =3D 0,						\
 	.rlim		=3D INIT_RLIMITS,					\
-	.user		=3D INIT_USER,					\
 	.comm		=3D "swapper",					\
 	.thread		=3D INIT_THREAD,					\
 	.fs		=3D &init_fs,					\
 	.files		=3D &init_files,					\
 	.sig		=3D &init_signals,				\
+	.cred		=3D &init_cred					\
 	.pending	=3D { NULL, &tsk.pending.head, {{0}}},		\
 	.blocked	=3D {{0}},					\
 	.alloc_lock	=3D SPIN_LOCK_UNLOCKED,				\
diff -X exclude -urN linux-2.5.44/include/linux/sched.h linux-2.5.44-cred/i=
nclude/linux/sched.h
--- linux-2.5.44/include/linux/sched.h	Fri Oct 18 21:01:11 2002
+++ linux-2.5.44-cred/include/linux/sched.h	Thu Oct 24 12:11:33 2002
@@ -29,6 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/cred.h>
=20
 struct exec_domain;
=20
@@ -51,7 +52,7 @@
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 #define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
 #define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
-
+#define	CLONE_CRED	0x00800000	/* Share credentials between tasks */
 /*
  * List of flags we want to share for kernel threads,
  * if only because they are not used by them anyway.
@@ -340,13 +341,7 @@
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
 /* process credentials */
-	uid_t uid,euid,suid,fsuid;
-	gid_t gid,egid,sgid,fsgid;
-	int ngroups;
-	gid_t	groups[NGROUPS];
-	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
-	int keep_capabilities:1;
-	struct user_struct *user;
+	struct cred_struct* cred;
 /* limits */
 	struct rlimit rlim[RLIM_NLIMITS];
 	unsigned short used_math;
diff -X exclude -urN linux-2.5.44/include/linux/slab.h linux-2.5.44-cred/in=
clude/linux/slab.h
--- linux-2.5.44/include/linux/slab.h	Fri Oct 18 21:02:34 2002
+++ linux-2.5.44-cred/include/linux/slab.h	Thu Oct 24 11:30:02 2002
@@ -73,6 +73,8 @@
 extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*sigact_cachep;
 extern kmem_cache_t	*bio_cachep;
+extern kmem_cache_t	*cred_cachep;
+extern kmem_cache_t	*vfscred_cachep;
=20
 #endif	/* __KERNEL__ */
=20
diff -X exclude -urN linux-2.5.44/init/main.c linux-2.5.44-cred/init/main.c
--- linux-2.5.44/init/main.c	Fri Oct 18 21:01:16 2002
+++ linux-2.5.44-cred/init/main.c	Thu Oct 24 11:49:25 2002
@@ -424,6 +424,7 @@
 	pidhash_init();
 	pgtable_cache_init();
 	pte_chain_init();
+	credentials_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	security_scaffolding_startup();
diff -X exclude -urN linux-2.5.44/kernel/cred.c linux-2.5.44-cred/kernel/cr=
ed.c
--- linux-2.5.44/kernel/cred.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-cred/kernel/cred.c	Thu Oct 24 11:19:49 2002
@@ -0,0 +1,468 @@
+/*
+ * linux/kernel/cred.c
+ *
+ * Copyright (c) 2001 Trond Myklebust <trond.myklebust@fys.uio.no>
+ *
+ * 'cred.c' contains the helper routines for managing task_cred
+ * and vfs_cred structures.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+
+/*
+ * Creds for the init task
+ */
+struct vfs_cred init_vfscred =3D {=20
+	.count		=3D ATOMIC_INIT(2),
+	/* .uid		=3D (uid_t)0, */
+	/* .gid		=3D (gid_t)0, */
+	/* .ngroups	=3D 0, */
+	.groups		=3D init_vfscred.__group_storage,
+};
+
+rwlock_t task_credlock =3D RW_LOCK_UNLOCKED;
+
+static kmem_cache_t	*vfscred_cache;
+
+void __init credentials_init(void)
+{
+	vfscred_cache =3D kmem_cache_create("vfs_cred",
+				       sizeof(struct vfs_cred),
+				       0,
+				       SLAB_HWCACHE_ALIGN,
+				       NULL, NULL);
+	if (!vfscred_cache)
+		panic("Cannot create vfs credential SLAB cache");
+}
+
+static inline struct vfs_cred *vfscred_alloc(int gfp)
+{
+	struct vfs_cred *cred;
+	cred =3D (struct vfs_cred *)kmem_cache_alloc(vfscred_cache, gfp);
+	if (cred) {
+		atomic_set(&cred->count, 1);
+		cred->groups =3D cred->__group_storage;
+	}
+	return cred;
+}
+
+static inline void vfscred_freegroups(struct vfs_cred *cred)
+{
+	if (cred->groups !=3D cred->__group_storage)
+		kfree(cred->groups);
+}
+
+static int vfscred_growgroups(struct vfs_cred *cred, int ngrp)
+{
+	gid_t *buf;
+	int err;
+
+	buf =3D cred->__group_storage;
+	if (ngrp <=3D ARRAY_SIZE(cred->__group_storage))
+		goto out;
+	err =3D -ENOMEM;
+	buf =3D (gid_t *)kmalloc(ngrp * sizeof(gid_t), GFP_KERNEL);
+	if (!buf)
+		goto out_err;
+out:
+	vfscred_freegroups(cred);
+	cred->groups =3D buf;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * put_vfscred - Release a user credential
+ * @cred: pointer to vfs_cred
+ */
+void put_vfscred(struct vfs_cred *cred)
+{
+	if (atomic_dec_and_test(&cred->count)) {
+		vfscred_freegroups(cred);
+		kmem_cache_free(vfscred_cache, cred);
+	}
+}
+
+/**
+ * vfscred_create - allocate and initialize a new user credential
+ * @uid:
+ * @gid:
+ */
+struct vfs_cred *vfscred_create(uid_t uid, gid_t gid)
+{
+	struct vfs_cred *cred;
+
+	if (!(cred =3D vfscred_alloc(SLAB_KERNEL)))
+		return NULL;
+	cred->uid =3D uid;
+	cred->gid =3D gid;
+	cred->ngroups =3D 0;
+	return cred;
+}
+
+/**
+ * vfscred_setgroups - set the supplemental group membership in a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of gids to copy
+ * @src: pointer to gids
+ *
+ * Note: this function does not COW. If you want to set the groups on
+ *       a public vfscred, please ensure that you copy it first...
+ */
+int vfscred_setgroups(struct vfs_cred *cred, int ngrp, gid_t *src)
+{
+	int err;
+
+	err =3D -EINVAL;
+	if (ngrp < 0)
+		goto out_err;
+	err =3D vfscred_growgroups(cred, ngrp);
+	if (err)
+		goto out_err;
+	memcpy(cred->groups, src, ngrp * sizeof(gid_t));
+	cred->ngroups =3D ngrp;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * vfscred_getgroups - return the supplemental groups from a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of gids to copy
+ * @dst: pointer to dest buffer
+ *
+ */
+int vfscred_getgroups(struct vfs_cred *cred, int ngrp, gid_t *dst)
+{
+	if (ngrp > cred->ngroups)
+		ngrp =3D cred->ngroups;
+	memcpy(dst, cred->groups, ngrp * sizeof(gid_t));
+	return cred->ngroups;
+}
+
+/**
+ * vfscred_match_group - match a gid to a vfs_cred's supplemental groups
+ * @cred: pointer to vfs_cred
+ * @gid: gid to match
+ */
+int vfscred_match_group(struct vfs_cred *cred, gid_t gid)
+{
+	gid_t *p =3D cred->groups;
+	int i;
+
+	for (i =3D cred->ngroups; i !=3D 0 ; i--) {
+		if (gid =3D=3D *p++)
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * vfscred_clone - duplicate a user credential
+ * @cred: pointer to vfs_cred
+ *
+ * Allocate a new user credential, and copy the entries in cred.
+ */
+struct vfs_cred *vfscred_clone(struct vfs_cred *cred)
+{
+	struct vfs_cred *new;
+	int err;
+
+	new =3D vfscred_create(cred->uid, cred->gid);
+	if (!new)
+		goto out_nomem;
+	err =3D vfscred_setgroups(new, cred->ngroups, cred->groups);
+	if (err)
+		goto out_free;
+	return new;
+out_free:
+	put_vfscred(new);
+out_nomem:
+	return NULL;
+}
+
+/**
+ * get_task_vfscred - return a reference to a task's user credentials
+ * @tsk:  pointer to task
+ *
+ * Note: the rwlock is needed in order to protect against /proc
+ * 	 grabbing a reference while the task itself is changing
+ *	 the vfscred.
+ *	 Once CLONE_CRED is introduced it may get worse...
+ */
+struct vfs_cred *get_task_vfscred(struct task_struct *tsk)
+{
+	struct vfs_cred *cred;
+
+	read_lock(&task_credlock);
+	cred =3D get_vfscred(tsk->cred->vfscred);
+	read_unlock(&task_credlock);
+	return cred;
+}
+
+/**
+ * set_task_vfscred - replace a task's user credentials
+ * @tsk:  pointer to task
+ * @cred: pointer to vfs_cred
+ *
+ * Note: This function does not check capabilities etc.
+ */
+void set_task_vfscred(struct task_struct *tsk, struct vfs_cred *cred)
+{
+	struct vfs_cred *old;
+
+	if (tsk->cred->vfscred =3D=3D cred)
+		return;
+	write_lock(&task_credlock);
+	old =3D xchg(&tsk->cred->vfscred, get_vfscred(cred));
+	write_unlock(&task_credlock);
+	if (old)
+		put_vfscred(old);
+}
+
+/**
+ * set_current_vfscred - replace the current task's user credentials
+ * @cred: pointer to vfs_cred
+ */
+void set_current_vfscred(struct vfs_cred *cred)
+{
+	set_task_vfscred(current, cred);
+}
+
+/**
+ * clone_current_vfscred - Clone the current task's vfs_cred
+ */
+struct vfs_cred *clone_current_vfscred(void)
+{
+	struct vfs_cred *cred, *new;
+
+	cred =3D get_current_vfscred();
+	new =3D vfscred_clone(cred);
+	put_vfscred(cred);
+	return new;
+}
+
+/*
+ * copy_write_task_vfscred - Conditionally clone a task's vfs_cred.
+ * @tsk: pointer to task
+ *
+ * Clones the task's vfscred if its reference count is > 1, else
+ * just take a reference.
+ * Use this in order to ensure that you are free to write to the
+ * vfscred.
+ *
+ */
+static struct vfs_cred *copy_write_task_vfscred(struct task_struct *tsk)
+{
+	struct vfs_cred *cred;
+
+	cred =3D get_task_vfscred(tsk);
+	if (vfscred_count(cred) > 2) {
+		struct vfs_cred *new;
+		new =3D vfscred_clone(cred);
+		put_vfscred(cred);
+		return new;
+	}
+	return cred;
+}
+
+/**
+ * setfsuid - set the current task's vfscred->uid
+ * @uid:  new fsuid
+ */
+int setfsuid(uid_t uid)
+{
+	struct vfs_cred *cred;
+
+	if (uid =3D=3D current->cred->vfscred->uid)
+		goto out;
+	cred =3D copy_write_task_vfscred(current);
+	if (!cred)
+		return -ENOMEM;
+	cred->uid =3D uid;
+	set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return 0;
+}
+
+/**
+ * setfsgid - set the current task's vfscred->gid
+ * @gid:  new fsgid
+ */
+int setfsgid(gid_t gid)
+{
+	struct vfs_cred *cred;
+
+	if (gid =3D=3D current->cred->vfscred->gid)
+		goto out;
+	cred =3D copy_write_task_vfscred(current);
+	if (!cred)
+		return -ENOMEM;
+	cred->gid =3D gid;
+	set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return 0;
+}
+
+/**
+ * setgroups - set the current task's group list
+ * @ngrp: number of gids to copy
+ * @src: pointer to gids
+ */
+int setgroups(int ngrp, gid_t *src)
+{
+	struct vfs_cred *cred;
+	int ret =3D -ENOMEM;
+
+	cred =3D copy_write_task_vfscred(current);
+	if (!cred)
+		goto out;
+	ret =3D vfscred_setgroups(cred, ngrp, src);
+	if (!ret)
+		set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return ret;
+}
+
+/**
+ * getgroups - return the current task's group list
+ * @ngrp: number of gids to copy
+ * @dst: pointer to dest buffer
+ */
+int getgroups(int ngrp, gid_t *dst)
+{
+	struct vfs_cred *cred;
+	int ret;
+
+	cred =3D get_current_vfscred();
+	ret =3D vfscred_getgroups(cred, ngrp, dst);
+	put_vfscred(cred);
+	return ret;
+}
+
+/**
+ * task_setfsuid - set the current task's vfscred uid
+ * @uid:  new fsuid
+ *
+ * Doing this for tasks other than 'current' is usually unsafe,
+ * so use of this function is deprecated.
+ */
+int task_setfsuid(struct task_struct *tsk, uid_t uid)
+{
+	struct vfs_cred *cred;
+
+	cred =3D copy_write_task_vfscred(tsk);
+	if (!cred)
+		return -ENOMEM;
+	cred->uid =3D uid;
+	set_task_vfscred(tsk, cred);
+	put_vfscred(cred);
+	return 0;
+}
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X)
+/*
+ * vfscred_setgroups16 - set the supplemental group membership in a vfs_cr=
ed
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of 16-bit gids to copy
+ * @src: pointer to gids
+ *
+ * Note: this function does not COW. If you want to set the groups on
+ *       a public vfscred, please ensure that you copy it first...
+ */
+static int vfscred_setgroups16(struct vfs_cred *cred, int ngrp, gid16_t *s=
rc)
+{
+	gid_t *dst;
+	int i, err;
+
+	err =3D -EINVAL;
+	if (ngrp < 0)
+		goto out_err;
+	err =3D vfscred_growgroups(cred, ngrp);
+	if (err)
+		goto out_err;
+	dst =3D cred->groups;
+	for (i =3D ngrp; i !=3D 0; i--)
+		*dst++ =3D (gid_t)*src++;
+	cred->ngroups =3D ngrp;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * vfscred_getgroups16 - return the supplemental groups from a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of 16-bit gids to copy
+ * @dst: pointer to dest buffer
+ *
+ */
+static int vfscred_getgroups16(struct vfs_cred *cred, int ngrp, gid16_t *d=
st)
+{
+	gid_t *src =3D cred->groups;
+	int i;
+	if (ngrp > cred->ngroups)
+		ngrp =3D cred->ngroups;
+	for (i =3D ngrp; i !=3D 0; i--)
+		*dst++ =3D (gid16_t)*src++;
+	return cred->ngroups;
+}
+
+/**
+ * setgroups16 - set the current task's group list
+ * @ngrp: number of 16-bit gids to copy
+ * @src:  pointer to 16-bit gids
+ */
+int setgroups16(int ngrp, gid16_t *src)
+{
+	struct vfs_cred *cred;
+	int ret =3D -ENOMEM;
+
+	cred =3D copy_write_task_vfscred(current);
+	if (!cred)
+		goto out;
+	ret =3D vfscred_setgroups16(cred, ngrp, src);
+	if (!ret)
+		set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return ret;
+}
+
+/**
+ * getgroups16 - return the current task's group list
+ * @ngrp: number of 16-bit gids to copy
+ * @dst: pointer to dest buffer
+ */
+int getgroups16(int ngrp, gid16_t *dst)
+{
+	struct vfs_cred *cred;
+	int ret;
+
+	cred =3D get_current_vfscred();
+	ret =3D vfscred_getgroups16(cred, ngrp, dst);
+	put_vfscred(cred);
+	return ret;
+}
+
+#endif /* defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X) */
+
+EXPORT_SYMBOL(put_vfscred);
+EXPORT_SYMBOL(vfscred_getgroups);
+EXPORT_SYMBOL(setfsuid);
+EXPORT_SYMBOL(setfsgid);
+EXPORT_SYMBOL(setgroups);
+EXPORT_SYMBOL(getgroups);
+EXPORT_SYMBOL(set_current_vfscred);
diff -X exclude -urN linux-2.5.44/kernel/exit.c linux-2.5.44-cred/kernel/ex=
it.c
--- linux-2.5.44/kernel/exit.c	Fri Oct 18 21:02:29 2002
+++ linux-2.5.44-cred/kernel/exit.c	Thu Oct 24 12:07:50 2002
@@ -384,6 +384,23 @@
 	__exit_fs(tsk);
 }
=20
+static inline void __exit_cred(struct task_struct *tsk)
+{
+	struct cred_struct	*cred =3D tsk->cred;
+
+	if (atomic_dec_and_test(&cred->count)) {
+		put_vfscred(cred->vfscred);
+		atomic_dec(&cred->user->processes);
+		free_uid(cred->user);
+		kmem_cache_free(cred_cachep, cred);
+	}
+}
+
+void exit_cred(struct task_struct *tsk)
+{
+	__exit_cred(tsk);
+}
+
 /*
  * We can use these to temporarily drop into
  * "lazy TLB" mode and back.
@@ -646,6 +663,7 @@
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
+	__exit_cred(tsk);
 	exit_namespace(tsk);
 	exit_thread();
=20
diff -X exclude -urN linux-2.5.44/kernel/fork.c linux-2.5.44-cred/kernel/fo=
rk.c
--- linux-2.5.44/kernel/fork.c	Fri Oct 18 21:01:11 2002
+++ linux-2.5.44-cred/kernel/fork.c	Thu Oct 24 12:10:49 2002
@@ -618,6 +618,25 @@
 	goto out;
 }
=20
+static inline int copy_cred(unsigned long clone_flags, struct task_struct =
* tsk)
+{
+	struct cred_struct *cred;
+
+	if (clone_flags & CLONE_CRED) {
+		atomic_inc(&current->cred->count);
+		return 0;
+	}
+	cred =3D kmem_cache_alloc(cred_cachep, GFP_KERNEL);
+	tsk->cred =3D cred;
+	if (!cred)
+		return -1;
+	*cred =3D *current->cred;
+	cred->vfscred =3D get_current_vfscred();
+	atomic_set(&cred->count, 1);
+	atomic_inc(&cred->user->__count);
+	return 0;
+}
+
 static inline int copy_sighand(unsigned long clone_flags, struct task_stru=
ct * tsk)
 {
 	struct signal_struct *sig;
@@ -692,10 +711,15 @@
 		goto fork_out;
=20
 	retval =3D -EAGAIN;
-	if (atomic_read(&p->user->processes) >=3D p->rlim[RLIMIT_NPROC].rlim_cur)=
 {
-		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
-			goto bad_fork_free;
-	}
+
+	/* for now, always copy */
+	if ( 1 || !(clone_flags & CLONE_CRED)) {
+		if (atomic_read(&p->cred->user->processes) >=3D
+		    p->rlim[RLIMIT_NPROC].rlim_cur)
+			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
+				goto bad_fork_free;
+		atomic_inc(&p->cred->user->processes);
+ 	}
=20
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
@@ -783,6 +807,8 @@
 		goto bad_fork_cleanup_files;
 	if (copy_sighand(clone_flags, p))
 		goto bad_fork_cleanup_fs;
+	if (copy_cred(clone_flags, p))
+		goto bad_fork_cleanup_cred;
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
 	if (copy_namespace(clone_flags, p))
@@ -913,6 +939,8 @@
 	exit_namespace(p);
 bad_fork_cleanup_mm:
 	exit_mm(p);
+bad_fork_cleanup_cred:
+	exit_cred(p);
 bad_fork_cleanup_sighand:
 	exit_sighand(p);
 bad_fork_cleanup_fs:
@@ -930,8 +958,8 @@
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);
 bad_fork_cleanup_count:
-	atomic_dec(&p->user->processes);
-	free_uid(p->user);
+	if ( 1 || !(clone_flags & CLONE_CRED))
+		atomic_dec(&p->cred->user->processes);
 bad_fork_free:
 	put_task_struct(p);
 	goto fork_out;
@@ -977,6 +1005,9 @@
 	return p;
 }
=20
+/* SLAB cache for cred_struct structures (tsk->cred) */
+kmem_cache_t *cred_cachep;
+
 /* SLAB cache for signal_struct structures (tsk->sig) */
 kmem_cache_t *sigact_cachep;
=20
@@ -994,6 +1025,12 @@
=20
 void __init proc_caches_init(void)
 {
+	cred_cachep =3D kmem_cache_create("cred_cache",
+				sizeof(struct cred_struct), 0,
+				SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!cred_cachep)
+		panic("Cannot create credential SLAB cache");
+
 	sigact_cachep =3D kmem_cache_create("signal_act",
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
diff -X exclude -urN linux-2.5.44/kernel/sched.c linux-2.5.44-cred/kernel/s=
ched.c
--- linux-2.5.44/kernel/sched.c	Fri Oct 18 21:02:28 2002
+++ linux-2.5.44-cred/kernel/sched.c	Thu Oct 24 11:27:55 2002
@@ -1447,7 +1447,7 @@
 	if ((policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR) &&
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
-	if ((current->euid !=3D p->euid) && (current->euid !=3D p->uid) &&
+	if ((current->cred->euid !=3D p->cred->euid) && (current->cred->euid !=3D=
 p->cred->uid) &&
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
=20
@@ -1605,7 +1605,8 @@
 	read_unlock(&tasklist_lock);
=20
 	retval =3D -EPERM;
-	if ((current->euid !=3D p->euid) && (current->euid !=3D p->uid) &&
+	if ((current->cred->euid !=3D p->cred->euid) &&=20
+	    (current->cred->euid !=3D p->cred->uid) &&
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
=20

--=-a3YLtJ8s2ztkspB0MeUP--

