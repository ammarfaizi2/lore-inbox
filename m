Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSH3XNC>; Fri, 30 Aug 2002 19:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSH3XNC>; Fri, 30 Aug 2002 19:13:02 -0400
Received: from pat.uio.no ([129.240.130.16]:7635 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314938AbSH3XLF>;
	Fri, 30 Aug 2002 19:11:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15727.64653.78081.277222@charged.uio.no>
Date: Sat, 31 Aug 2002 01:15:25 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Introduce BSD-style user credential [3/3]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce basic *BSD style user credentials of the form

struct ucred {
       atomic_t	count;
       uid_t	uid;
       gid_t	gid;
       int	ngroups;
       gid_t	*groups;
};

and replace fsuid, fsgid, ngroups, groups in the struct task.

The struct ucred will later be used as the basic element of user
authentication at the VFS level in lieu of the current hodge-podge of
partial creds in struct file and lower level filesystem code.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.32-cred2/arch/s390x/kernel/linux32.c linux-2.5.32-cred3/arch/s390x/kernel/linux32.c
--- linux-2.5.32-cred2/arch/s390x/kernel/linux32.c	Fri Aug 30 02:35:54 2002
+++ linux-2.5.32-cred3/arch/s390x/kernel/linux32.c	Fri Aug 30 13:45:18 2002
@@ -194,12 +194,10 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current_ngroups();
+	i = current_getgroups16(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
 		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
 			return -EFAULT;
 	}
@@ -217,10 +215,7 @@
 		return -EINVAL;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
 		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+	return current_setgroups16(gidsetsize, grouplist);
 }
 
 asmlinkage long sys32_getuid16(void)
diff -u --recursive --new-file linux-2.5.32-cred2/arch/sparc64/kernel/sys_sparc32.c linux-2.5.32-cred3/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.32-cred2/arch/sparc64/kernel/sys_sparc32.c	Fri Aug 30 02:35:55 2002
+++ linux-2.5.32-cred3/arch/sparc64/kernel/sys_sparc32.c	Fri Aug 30 13:45:18 2002
@@ -211,12 +211,10 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current_ngroups();
+	i = current_getgroups16(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
 		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
 			return -EFAULT;
 	}
@@ -234,10 +232,7 @@
 		return -EINVAL;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
 		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+	return current_setgroups16(gidsetsize, groups);
 }
 
 asmlinkage long sys32_getuid16(void)
diff -u --recursive --new-file linux-2.5.32-cred2/fs/intermezzo/file.c linux-2.5.32-cred3/fs/intermezzo/file.c
--- linux-2.5.32-cred2/fs/intermezzo/file.c	Fri Aug 30 02:35:55 2002
+++ linux-2.5.32-cred3/fs/intermezzo/file.c	Fri Aug 30 13:45:18 2002
@@ -139,6 +139,7 @@
                 presto_set(file->f_dentry, PRESTO_ATTR | PRESTO_DATA);
 
         if (writable) { 
+		struct ucred *cred;
                 PRESTO_ALLOC(fdata, struct presto_file_data *, sizeof(*fdata));
                 if (!fdata) {
                         EXIT;
@@ -146,15 +147,17 @@
                 }
                 /* we believe that on open the kernel lock
                    assures that only one process will do this allocation */ 
+		cred = current_getucred();
                 fdata->fd_do_lml = 0;
-                fdata->fd_fsuid = current_fsuid();
-                fdata->fd_fsgid = current_fsgid();
+                fdata->fd_fsuid = cred->uid;
+                fdata->fd_fsgid = cred->gid;
                 fdata->fd_mode = file->f_dentry->d_inode->i_mode;
-                fdata->fd_ngroups = current_ngroups();
-                for (i=0 ; i<current_ngroups() ; i++)
-                        fdata->fd_groups[i] = current->groups[i]; 
+                fdata->fd_ngroups = cred->ngroups;
+                for (i=0 ; i<cred->ngroups ; i++)
+                        fdata->fd_groups[i] = cred->groups[i]; 
                 fdata->fd_bytes_written = 0; /*when open,written data is zero*/ 
                 file->private_data = fdata; 
+		put_ucred(cred);
         } else {
                 file->private_data = NULL;
         }
diff -u --recursive --new-file linux-2.5.32-cred2/fs/intermezzo/journal.c linux-2.5.32-cred3/fs/intermezzo/journal.c
--- linux-2.5.32-cred2/fs/intermezzo/journal.c	Fri Aug 30 02:35:55 2002
+++ linux-2.5.32-cred3/fs/intermezzo/journal.c	Fri Aug 30 13:45:18 2002
@@ -254,18 +254,22 @@
 static inline char *
 journal_log_prefix(char *buf, int opcode, struct rec_info *rec)
 {
+	struct ucred *cred;
 	__u32 groups[NGROUPS_MAX]; 
 	int i; 
 
+	cred = current_getucred();
 	/* convert 16 bit gid's to 32 bit gid's */
-	for (i=0; i<current_ngroups(); i++) 
-		groups[i] = (__u32) current->groups[i];
+	for (i=0; i<cred->ngroups; i++) 
+		groups[i] = (__u32) cred->groups[i];
 	
-        return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
-                                                      (__u32)current_ngroups(),
+        i =  journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
+                                                      (__u32)cred->ngroups,
 						      groups,
-                                                      (__u32)current_fsuid(),
-                                                      (__u32)current_fsgid());
+                                                      (__u32)cred->uid,
+                                                      (__u32)cred->gid);
+	put_ucred(cred);
+	return i;
 }
 
 static inline char *
@@ -1741,14 +1745,16 @@
                 open_fsuid = fd->fd_fsuid;
                 open_fsgid = fd->fd_fsgid;
         } else {
-                open_ngroups = current_ngroups();
-                for (i=0; i<current_ngroups(); i++)
-			open_groups[i] =  (__u32) current->groups[i]; 
+		struct ucred *cred = current_getucred();
+                open_ngroups = cred->ngroups;
+                for (i=0; i<cred->ngroups; i++)
+			open_groups[i] =  (__u32) cred->groups[i]; 
                 open_mode = dentry->d_inode->i_mode;
                 open_uid = dentry->d_inode->i_uid;
                 open_gid = dentry->d_inode->i_gid;
-                open_fsuid = current_fsuid();
-                open_fsgid = current_fsgid();
+                open_fsuid = cred->uid;
+                open_fsgid = cred->gid;
+		put_ucred(cred);
         }
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
diff -u --recursive --new-file linux-2.5.32-cred2/fs/nfsd/auth.c linux-2.5.32-cred3/fs/nfsd/auth.c
--- linux-2.5.32-cred2/fs/nfsd/auth.c	Fri Aug 30 02:35:55 2002
+++ linux-2.5.32-cred3/fs/nfsd/auth.c	Fri Aug 30 13:45:18 2002
@@ -46,9 +46,8 @@
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
-		current->groups[i] = group;
 	}
-	current->ngroups = i;
+	current_setgroups(i, cred->cr_groups);
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
diff -u --recursive --new-file linux-2.5.32-cred2/fs/proc/array.c linux-2.5.32-cred3/fs/proc/array.c
--- linux-2.5.32-cred2/fs/proc/array.c	Thu Jul 25 03:36:09 2002
+++ linux-2.5.32-cred3/fs/proc/array.c	Fri Aug 30 13:45:18 2002
@@ -148,9 +148,11 @@
 
 static inline char * task_state(struct task_struct *p, char *buffer)
 {
+	struct ucred *cred;
 	int g;
 
 	read_lock(&tasklist_lock);
+	cred = task_getucred(p);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
 		"Tgid:\t%d\n"
@@ -161,8 +163,8 @@
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p), p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0, 0,
-		p->uid, p->euid, p->suid, p->fsuid,
-		p->gid, p->egid, p->sgid, p->fsgid);
+		p->uid, p->euid, p->suid, cred->uid,
+		p->gid, p->egid, p->sgid, cred->gid);
 	read_unlock(&tasklist_lock);	
 	task_lock(p);
 	buffer += sprintf(buffer,
@@ -171,10 +173,11 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
-		buffer += sprintf(buffer, "%d ", p->groups[g]);
+	for (g = 0; g < cred->ngroups; g++)
+		buffer += sprintf(buffer, "%d ", cred->groups[g]);
 
 	buffer += sprintf(buffer, "\n");
+	put_ucred(cred);
 	return buffer;
 }
 
diff -u --recursive --new-file linux-2.5.32-cred2/include/linux/cred.h linux-2.5.32-cred3/include/linux/cred.h
--- linux-2.5.32-cred2/include/linux/cred.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.32-cred3/include/linux/cred.h	Fri Aug 30 15:33:04 2002
@@ -0,0 +1,92 @@
+#ifndef _LINUX_CRED_H
+#define _LINUX_CRED_H
+
+#include <linux/param.h>
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+/*
+ * UNIX credential
+ *
+ * This is for use by filesystems, sockets, RPC for user authentication
+ * purposes. It is a direct replacement for the 2.4.x task entries
+ * fsuid/fsgid + groups[].
+ *
+ * The credential may be shared among different threads, interrupts,...
+ * without any fancy locking mechanisms provided one sticks to using
+ * copy on write semantics. The latter is a guarantee that if more than
+ * one object is referencing the ucred, then the data in the struct will
+ * not change.
+ *
+ * This again means that the recipe for changing one or more of fsuid,
+ * fsgid, ...  for the current thread will usually be as follows:
+ *  1) copy the existing ucred into a new one using current_clone_ucred()
+ *  2) make all the necessary changes to the clone
+ *  3) use current_setucred() in order to register the change to the
+ *     task_struct
+ *
+ */
+struct ucred {
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
+#ifdef __KERNEL__
+
+#define NOGID ((gid_t)-1)
+#define NOUID ((uid_t)-1)
+
+extern struct ucred init_ucred;
+extern void credentials_init(void);
+
+extern void put_ucred(struct ucred *);
+extern struct ucred *ucred_create(uid_t, gid_t);
+extern struct ucred *ucred_clone(struct ucred *);
+extern int ucred_getgroups(struct ucred *, int, gid_t *);
+extern int ucred_setgroups(struct ucred *, int, gid_t *);
+extern int ucred_match_supplemental(struct ucred *, gid_t);
+
+static inline struct ucred *get_ucred(struct ucred *cred)
+{
+	atomic_inc(&cred->count);
+	return cred;
+}
+
+static inline int ucred_count(struct ucred *cred)
+{
+	return atomic_read(&cred->count);
+}
+
+#define current_getucred()	get_ucred(current->ucred)
+#define current_fsuid()		(current->ucred->uid)
+#define current_fsgid()		(current->ucred->gid)
+#define current_ngroups()	(current->ucred->ngroups)
+
+extern struct ucred *current_clone_ucred(void);
+extern void current_setucred(struct ucred *);
+extern int current_setfsuid(uid_t);
+extern int current_setfsgid(gid_t);
+extern int current_setgroups(int, gid_t *);
+extern int current_getgroups(int, gid_t *);
+
+extern struct ucred *task_getucred(struct task_struct *);
+extern void task_setucred(struct task_struct *, struct ucred *);
+
+/* Grrr: Support for oddball functions in security/dummy.c */
+#define task_fsuid(tsk)		((tsk)->ucred->uid)
+extern int task_setfsuid(struct task_struct *, uid_t);
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X)
+extern int current_setgroups16(int, gid16_t *);
+extern int current_getgroups16(int, gid16_t *);
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CRED_H */
diff -u --recursive --new-file linux-2.5.32-cred2/include/linux/init_task.h linux-2.5.32-cred3/include/linux/init_task.h
--- linux-2.5.32-cred2/include/linux/init_task.h	Mon Aug 19 20:12:27 2002
+++ linux-2.5.32-cred3/include/linux/init_task.h	Fri Aug 30 13:45:18 2002
@@ -65,6 +65,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.ucred		= &init_ucred,					\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
diff -u --recursive --new-file linux-2.5.32-cred2/include/linux/sched.h linux-2.5.32-cred3/include/linux/sched.h
--- linux-2.5.32-cred2/include/linux/sched.h	Fri Aug 30 02:35:55 2002
+++ linux-2.5.32-cred3/include/linux/sched.h	Fri Aug 30 13:45:18 2002
@@ -27,6 +27,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/cred.h>
 
 struct exec_domain;
 
@@ -327,10 +328,9 @@
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
 /* process credentials */
-	uid_t uid,euid,suid,fsuid;
-	gid_t gid,egid,sgid,fsgid;
-	int ngroups;
-	gid_t	groups[NGROUPS];
+	uid_t uid,euid,suid;
+	gid_t gid,egid,sgid;
+	struct ucred *ucred;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
@@ -946,28 +946,6 @@
 
 #endif /* CONFIG_SMP */
 
-/* Provisional functions for the transition to reference-counted ucreds */
-static inline uid_t current_fsuid(void)
-{
-	return current->fsuid;
-}
-static inline gid_t current_fsgid(void)
-{
-	return current->fsgid;
-}
-static inline int current_ngroups(void)
-{
-	return current->ngroups;
-}
-static inline void current_setfsuid(uid_t uid)
-{
-	current->fsuid = uid;
-}
-static inline void current_setfsgid(gid_t gid)
-{
-	current->fsgid = gid;
-}
-
 #endif /* __KERNEL__ */
 
 #endif
diff -u --recursive --new-file linux-2.5.32-cred2/init/main.c linux-2.5.32-cred3/init/main.c
--- linux-2.5.32-cred2/init/main.c	Wed Aug 28 09:54:46 2002
+++ linux-2.5.32-cred3/init/main.c	Fri Aug 30 13:45:18 2002
@@ -438,6 +438,7 @@
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
 	pte_chain_init();
+	credentials_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	security_scaffolding_startup();
diff -u --recursive --new-file linux-2.5.32-cred2/kernel/Makefile linux-2.5.32-cred3/kernel/Makefile
--- linux-2.5.32-cred2/kernel/Makefile	Sat Jul 27 16:14:38 2002
+++ linux-2.5.32-cred3/kernel/Makefile	Fri Aug 30 13:45:18 2002
@@ -10,12 +10,13 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o cred.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    cred.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -u --recursive --new-file linux-2.5.32-cred2/kernel/cred.c linux-2.5.32-cred3/kernel/cred.c
--- linux-2.5.32-cred2/kernel/cred.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.32-cred3/kernel/cred.c	Fri Aug 30 15:57:51 2002
@@ -0,0 +1,475 @@
+/*
+ * linux/kernel/cred.c
+ *
+ * Copyright (c) 2001 Trond Myklebust <trond.myklebust@fys.uio.no>
+ *
+ * 'cred.c' contains the helper routines for managing credentials
+ * and ucred structures in the task structure.
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
+struct ucred init_ucred = { 
+	.count		= ATOMIC_INIT(2),
+	/* .uid		= (uid_t)0, */
+	/* .gid		= (gid_t)0, */
+	/* .ngroups	= 0, */
+	.groups		= init_ucred.__group_storage,
+};
+
+rwlock_t task_credlock = RW_LOCK_UNLOCKED;
+
+static kmem_cache_t	*ucred_cache;
+
+void __init credentials_init(void)
+{
+	ucred_cache = kmem_cache_create("ucred_cache",
+				       sizeof(struct ucred),
+				       0,
+				       SLAB_HWCACHE_ALIGN,
+				       NULL, NULL);
+	if (!ucred_cache)
+		panic("Cannot create user credential SLAB cache");
+}
+
+static inline struct ucred *ucred_alloc(int gfp)
+{
+	struct ucred *cred;
+	cred = (struct ucred *)kmem_cache_alloc(ucred_cache, gfp);
+	if (cred) {
+		atomic_set(&cred->count, 1);
+		cred->groups = cred->__group_storage;
+	}
+	return cred;
+}
+
+static inline void ucred_freegroups(struct ucred *cred)
+{
+	if (cred->groups != cred->__group_storage)
+		kfree(cred->groups);
+}
+
+static int ucred_growgroups(struct ucred *cred, int ngrp)
+{
+	gid_t *buf;
+	int err;
+
+	buf = cred->__group_storage;
+	if (ngrp <= ARRAY_SIZE(cred->__group_storage))
+		goto out;
+	err = -ENOMEM;
+	buf = (gid_t *)kmalloc(ngrp * sizeof(gid_t), GFP_KERNEL);
+	if (!buf)
+		goto out_err;
+out:
+	ucred_freegroups(cred);
+	cred->groups = buf;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * put_ucred - Release a user credential
+ * @cred: pointer to ucred
+ */
+void put_ucred(struct ucred *cred)
+{
+	if (atomic_dec_and_test(&cred->count)) {
+		ucred_freegroups(cred);
+		kmem_cache_free(ucred_cache, cred);
+	}
+}
+
+/**
+ * ucred_create - allocate and initialize a new user credential
+ * @uid:
+ * @gid:
+ */
+struct ucred *ucred_create(uid_t uid, gid_t gid)
+{
+	struct ucred *cred;
+
+	if (!(cred = ucred_alloc(SLAB_KERNEL)))
+		return NULL;
+	cred->uid = uid;
+	cred->gid = gid;
+	cred->ngroups = 0;
+	return cred;
+}
+
+/**
+ * ucred_setgroups - set the supplemental group membership in a ucred
+ * @cred: pointer to ucred
+ * @ngrp: number of gids to copy
+ * @src: pointer to gids
+ *
+ * Note: this function does not COW. If you want to set the groups on
+ *       a public ucred, please ensure that you copy it first...
+ */
+int ucred_setgroups(struct ucred *cred, int ngrp, gid_t *src)
+{
+	int err;
+
+	err = -EINVAL;
+	if (ngrp < 0)
+		goto out_err;
+	err = ucred_growgroups(cred, ngrp);
+	if (err)
+		goto out_err;
+	memcpy(cred->groups, src, ngrp * sizeof(gid_t));
+	cred->ngroups = ngrp;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * ucred_getgroups - return the supplemental groups from a ucred
+ * @cred: pointer to ucred
+ * @ngrp: number of gids to copy
+ * @dst: pointer to dest buffer
+ *
+ */
+int ucred_getgroups(struct ucred *cred, int ngrp, gid_t *dst)
+{
+	if (ngrp > cred->ngroups)
+		ngrp = cred->ngroups;
+	memcpy(dst, cred->groups, ngrp * sizeof(gid_t));
+	return cred->ngroups;
+}
+
+/**
+ * ucred_match_supplemental - match a gid to a ucred supplemental groups
+ * @cred: pointer to ucred
+ * @gid: gid to match
+ */
+int ucred_match_supplemental(struct ucred *cred, gid_t gid)
+{
+	gid_t *p = cred->groups;
+	int i;
+
+	for (i = cred->ngroups; i != 0 ; i--) {
+		if (gid == *p++)
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * ucred_clone - duplicate a user credential
+ * @cred: pointer to ucred
+ *
+ * Allocate a new user credential, and copy the entries in cred.
+ */
+struct ucred *ucred_clone(struct ucred *cred)
+{
+	struct ucred *new;
+	int err;
+
+	new = ucred_create(cred->uid, cred->gid);
+	if (!new)
+		goto out_nomem;
+	err = ucred_setgroups(new, cred->ngroups, cred->groups);
+	if (err)
+		goto out_free;
+	return new;
+out_free:
+	put_ucred(new);
+out_nomem:
+	return NULL;
+}
+
+/**
+ * task_getucred - return a reference to a task's user credentials
+ * @tsk:  pointer to task
+ *
+ * Note: the rwlock is needed in order to protect against /proc
+ * 	 grabbing a reference while the task itself is changing
+ *	 the ucred.
+ *	 Once CLONE_CRED is introduced it may get worse...
+ */
+struct ucred *task_getucred(struct task_struct *tsk)
+{
+	struct ucred *cred;
+
+	read_lock(&task_credlock);
+	cred = get_ucred(tsk->ucred);
+	read_unlock(&task_credlock);
+	return cred;
+}
+
+/**
+ * task_setucred - replace a task's user credentials
+ * @tsk:  pointer to task
+ * @cred: pointer to ucred
+ *
+ * Note: This function does not check capabilities etc.
+ */
+void task_setucred(struct task_struct *tsk, struct ucred *cred)
+{
+	struct ucred *old;
+
+	if (tsk->ucred == cred)
+		return;
+	write_lock(&task_credlock);
+	old = xchg(&tsk->ucred, get_ucred(cred));
+	write_unlock(&task_credlock);
+	if (old)
+		put_ucred(old);
+}
+
+/**
+ * current_setucred - replace the current task's user credentials
+ * @cred: pointer to ucred
+ */
+void current_setucred(struct ucred *cred)
+{
+	task_setucred(current, cred);
+}
+
+/**
+ * current_clone_ucred - Clone the current task's ucred
+ */
+struct ucred *current_clone_ucred(void)
+{
+	struct ucred *cred, *new;
+
+	cred = current_getucred();
+	new = ucred_clone(cred);
+	put_ucred(cred);
+	return new;
+}
+
+/*
+ * task_cow_ucred - Prepare a task's ucred for writing.
+ * @tsk: pointer to task
+ *
+ * Clones the current task's ucred if its reference count is > 1, else
+ * just take a reference.
+ * Use this in order to ensure that you are free to write to the
+ * ucred.
+ *
+ */
+static struct ucred *task_cow_ucred(struct task_struct *tsk)
+{
+	struct ucred *cred;
+
+	cred = task_getucred(tsk);
+	if (ucred_count(cred) > 2) {
+		struct ucred *new;
+		new = ucred_clone(cred);
+		put_ucred(cred);
+		return new;
+	}
+	return cred;
+}
+
+/*
+ * current_cow_ucred - Prepare the current task's ucred for writing
+ */
+static inline struct ucred *current_cow_ucred(void)
+{
+	return task_cow_ucred(current);
+}
+
+/**
+ * current_setfsuid - set the current task's ucred uid
+ * @uid:  new fsuid
+ */
+int current_setfsuid(uid_t uid)
+{
+	struct ucred *cred;
+
+	if (uid == current_fsuid())
+		goto out;
+	cred = current_cow_ucred();
+	if (!cred)
+		return -ENOMEM;
+	cred->uid = uid;
+	current_setucred(cred);
+	put_ucred(cred);
+out:
+	return 0;
+}
+
+/**
+ * current_setfsgid - set the current task's ucred uid
+ * @gid:  new fsgid
+ */
+int current_setfsgid(gid_t gid)
+{
+	struct ucred *cred;
+
+	if (gid == current_fsgid())
+		goto out;
+	cred = current_cow_ucred();
+	if (!cred)
+		return -ENOMEM;
+	cred->gid = gid;
+	current_setucred(cred);
+	put_ucred(cred);
+out:
+	return 0;
+}
+
+/**
+ * current_setgroups - set the current task's group list
+ * @ngrp: number of gids to copy
+ * @src: pointer to gids
+ */
+int current_setgroups(int ngrp, gid_t *src)
+{
+	struct ucred *cred;
+	int ret = -ENOMEM;
+
+	cred = current_cow_ucred();
+	if (!cred)
+		goto out;
+	ret = ucred_setgroups(cred, ngrp, src);
+	if (!ret)
+		current_setucred(cred);
+	put_ucred(cred);
+out:
+	return ret;
+}
+
+/**
+ * current_getgroups - return the current task's group list
+ * @ngrp: number of gids to copy
+ * @dst: pointer to dest buffer
+ */
+int current_getgroups(int ngrp, gid_t *dst)
+{
+	struct ucred *cred;
+	int ret;
+
+	cred = current_getucred();
+	ret = ucred_getgroups(cred, ngrp, dst);
+	put_ucred(cred);
+	return ret;
+}
+
+/**
+ * task_setfsuid - set the current task's ucred uid
+ * @uid:  new fsuid
+ *
+ * Doing this for tasks other than 'current' is usually unsafe,
+ * so use of this function is deprecated.
+ */
+int task_setfsuid(struct task_struct *tsk, uid_t uid)
+{
+	struct ucred *cred;
+
+	cred = task_cow_ucred(tsk);
+	if (!cred)
+		return -ENOMEM;
+	cred->uid = uid;
+	task_setucred(tsk, cred);
+	put_ucred(cred);
+	return 0;
+}
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X)
+/*
+ * ucred_setgroups16 - set the supplemental group membership in a ucred
+ * @cred: pointer to ucred
+ * @ngrp: number of 16-bit gids to copy
+ * @src: pointer to gids
+ *
+ * Note: this function does not COW. If you want to set the groups on
+ *       a public ucred, please ensure that you copy it first...
+ */
+static int ucred_setgroups16(struct ucred *cred, int ngrp, gid16_t *src)
+{
+	gid_t *dst;
+	int i, err;
+
+	err = -EINVAL;
+	if (ngrp < 0)
+		goto out_err;
+	err = ucred_growgroups(cred, ngrp);
+	if (err)
+		goto out_err;
+	dst = cred->groups;
+	for (i = ngrp; i != 0; i--)
+		*dst++ = (gid_t)*src++;
+	cred->ngroups = ngrp;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * ucred_getgroups16 - return the supplemental groups from a ucred
+ * @cred: pointer to ucred
+ * @ngrp: number of 16-bit gids to copy
+ * @dst: pointer to dest buffer
+ *
+ */
+static int ucred_getgroups16(struct ucred *cred, int ngrp, gid16_t *dst)
+{
+	gid_t *src = cred->groups;
+	int i;
+	if (ngrp > cred->ngroups)
+		ngrp = cred->ngroups;
+	for (i = ngrp; i != 0; i--)
+		*dst++ = (gid16_t)*src++;
+	return cred->ngroups;
+}
+
+/**
+ * current_setgroups16 - set the current task's group list
+ * @ngrp: number of 16-bit gids to copy
+ * @src:  pointer to 16-bit gids
+ */
+int current_setgroups16(int ngrp, gid16_t *src)
+{
+	struct ucred *cred;
+	int ret = -ENOMEM;
+
+	cred = current_cow_ucred();
+	if (!cred)
+		goto out;
+	ret = ucred_setgroups16(cred, ngrp, src);
+	if (!ret)
+		current_setucred(cred);
+	put_ucred(cred);
+out:
+	return ret;
+}
+
+/**
+ * current_getgroups16 - return the current task's group list
+ * @ngrp: number of 16-bit gids to copy
+ * @dst: pointer to dest buffer
+ */
+int current_getgroups16(int ngrp, gid16_t *dst)
+{
+	struct ucred *cred;
+	int ret;
+
+	cred = current_getucred();
+	ret = ucred_getgroups16(cred, ngrp, dst);
+	put_ucred(cred);
+	return ret;
+}
+
+#endif /* defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X) */
+
+EXPORT_SYMBOL(put_ucred);
+EXPORT_SYMBOL(ucred_getgroups);
+EXPORT_SYMBOL(current_setfsuid);
+EXPORT_SYMBOL(current_setfsgid);
+EXPORT_SYMBOL(current_setgroups);
+EXPORT_SYMBOL(current_getgroups);
diff -u --recursive --new-file linux-2.5.32-cred2/kernel/fork.c linux-2.5.32-cred3/kernel/fork.c
--- linux-2.5.32-cred2/kernel/fork.c	Sat Aug 24 12:57:43 2002
+++ linux-2.5.32-cred3/kernel/fork.c	Fri Aug 30 16:40:24 2002
@@ -62,6 +62,7 @@
 void __put_task_struct(struct task_struct *tsk)
 {
 	if (tsk != current) {
+		put_ucred(tsk->ucred);
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
 	} else {
@@ -69,6 +70,7 @@
 
 		tsk = task_cache[cpu];
 		if (tsk) {
+			put_ucred(tsk->ucred);
 			free_thread_info(tsk->thread_info);
 			kmem_cache_free(task_struct_cachep,tsk);
 		}
@@ -146,6 +148,7 @@
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
+	tsk->ucred = task_getucred(orig);
 	atomic_set(&tsk->usage,1);
 
 	return tsk;
@@ -502,6 +505,18 @@
 	return i;
 }
 
+/* For the moment, we never share credentials between processes */
+static int copy_cred(unsigned long clone_flags, struct task_struct * tsk)
+{
+	struct ucred *cred;
+	cred = current_clone_ucred();
+	if (!cred)
+		return -ENOMEM;
+	task_setucred(tsk, cred);
+	put_ucred(cred);
+	return 0;
+}
+
 static int copy_files(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct files_struct *oldf, *newf;
@@ -671,6 +686,8 @@
 		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
 			goto bad_fork_free;
 	}
+	if (copy_cred(clone_flags, p))
+		goto bad_fork_free;
 
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
diff -u --recursive --new-file linux-2.5.32-cred2/kernel/kmod.c linux-2.5.32-cred3/kernel/kmod.c
--- linux-2.5.32-cred2/kernel/kmod.c	Fri Aug 16 03:25:31 2002
+++ linux-2.5.32-cred3/kernel/kmod.c	Fri Aug 30 13:45:18 2002
@@ -132,8 +132,10 @@
 	}
 
 	/* Give kmod all effective privileges.. */
-	curtask->euid = curtask->fsuid = 0;
-	curtask->egid = curtask->fsgid = 0;
+	curtask->euid = 0;
+	curtask->egid = 0;
+	current_setfsuid(0);
+	current_setfsgid(0);
 	security_ops->task_kmod_set_label();
 
 	/* Allow execve args to be in kernel space. */
diff -u --recursive --new-file linux-2.5.32-cred2/kernel/sys.c linux-2.5.32-cred3/kernel/sys.c
--- linux-2.5.32-cred2/kernel/sys.c	Fri Aug 30 02:35:56 2002
+++ linux-2.5.32-cred3/kernel/sys.c	Fri Aug 30 13:45:18 2002
@@ -984,6 +984,7 @@
  */
 asmlinkage long sys_getgroups(int gidsetsize, gid_t *grouplist)
 {
+	gid_t groups[NGROUPS];
 	int i;
 	
 	/*
@@ -993,11 +994,11 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current_ngroups();
+	i = current_getgroups(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		if (copy_to_user(grouplist, current->groups, sizeof(gid_t)*i))
+		if (copy_to_user(grouplist, groups, sizeof(gid_t)*i))
 			return -EFAULT;
 	}
 	return i;
@@ -1022,25 +1023,18 @@
 	retval = security_ops->task_setgroups(gidsetsize, groups);
 	if (retval)
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	return current_setgroups(gidsetsize, groups);
 }
 
 static int supplemental_group_member(gid_t grp)
 {
-	int i = current_ngroups();
+	struct ucred *cred;
+	int retval;
 
-	if (i) {
-		gid_t *groups = current->groups;
-		do {
-			if (*groups == grp)
-				return 1;
-			groups++;
-			i--;
-		} while (i);
-	}
-	return 0;
+	cred = current_getucred();
+	retval = ucred_match_supplemental(cred, grp);
+	put_ucred(cred);
+	return retval;
 }
 
 /*
@@ -1048,9 +1042,13 @@
  */
 int in_group_p(gid_t grp)
 {
+	struct ucred *cred;
 	int retval = 1;
-	if (grp != current_fsgid())
-		retval = supplemental_group_member(grp);
+
+	cred = current_getucred();
+	if (grp != cred->gid)
+		retval = ucred_match_supplemental(cred, grp);
+	put_ucred(cred);
 	return retval;
 }
 
diff -u --recursive --new-file linux-2.5.32-cred2/kernel/uid16.c linux-2.5.32-cred3/kernel/uid16.c
--- linux-2.5.32-cred2/kernel/uid16.c	Fri Aug 30 02:35:56 2002
+++ linux-2.5.32-cred3/kernel/uid16.c	Fri Aug 30 13:45:18 2002
@@ -109,17 +109,18 @@
 
 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t *grouplist)
 {
+	gid_t gids[NGROUPS];
 	old_gid_t groups[NGROUPS];
 	int i,j;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current_ngroups();
+	i = current_getgroups(NGROUPS, gids);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
 		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
+			groups[j] = gids[j];
 		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
 			return -EFAULT;
 	}
@@ -143,9 +144,7 @@
 	i = security_ops->task_setgroups(gidsetsize, new_groups);
 	if (i)
 		return i;
-	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	return current_setgroups(gidsetsize, new_groups);
 }
 
 asmlinkage long sys_getuid16(void)
diff -u --recursive --new-file linux-2.5.32-cred2/net/sunrpc/auth_unix.c linux-2.5.32-cred3/net/sunrpc/auth_unix.c
--- linux-2.5.32-cred2/net/sunrpc/auth_unix.c	Fri Aug 30 02:35:56 2002
+++ linux-2.5.32-cred3/net/sunrpc/auth_unix.c	Fri Aug 30 13:45:18 2002
@@ -80,16 +80,11 @@
 		cred->uc_gid = cred->uc_fsgid = 0;
 		cred->uc_gids[0] = NOGROUP;
 	} else {
-		int groups = current_ngroups();
-		if (groups > NFS_NGROUPS)
-			groups = NFS_NGROUPS;
-
 		cred->uc_uid = current->uid;
 		cred->uc_gid = current->gid;
 		cred->uc_fsuid = current_fsuid();
 		cred->uc_fsgid = current_fsgid();
-		for (i = 0; i < groups; i++)
-			cred->uc_gids[i] = (gid_t) current->groups[i];
+		i = current_getgroups(NFS_NGROUPS, cred->uc_gids);
 		if (i < NFS_NGROUPS)
 		  cred->uc_gids[i] = NOGROUP;
 	}
@@ -134,29 +129,35 @@
 static int
 unx_match(struct rpc_cred *rcred, int taskflags)
 {
-	struct unx_cred	*cred = (struct unx_cred *) rcred;
-	int		i;
-
-	if (!(taskflags & RPC_TASK_ROOTCREDS)) {
-		int groups;
+	struct unx_cred	*cr = (struct unx_cred *) rcred;
+	struct ucred *cred;
+	int groups, res = 1;
+
+	if ((taskflags & RPC_TASK_ROOTCREDS)) {
+		return (cr->uc_uid == 0 && cr->uc_fsuid == 0
+		     && cr->uc_gid == 0 && cr->uc_fsgid == 0
+		     && cr->uc_gids[0] == (gid_t) NOGROUP);
+	}
 
-		if (cred->uc_uid != current->uid
-		 || cred->uc_gid != current->gid
-		 || cred->uc_fsuid != current_fsuid()
-		 || cred->uc_fsgid != current_fsgid())
-			return 0;
-
-		groups = current_ngroups();
-		if (groups > NFS_NGROUPS)
-			groups = NFS_NGROUPS;
-		for (i = 0; i < groups ; i++)
-			if (cred->uc_gids[i] != (gid_t) current->groups[i])
-				return 0;
-		return 1;
+	cred = current_getucred();
+	if (cr->uc_uid != current->uid
+	 || cr->uc_gid != current->gid
+	 || cr->uc_fsuid != cred->uid
+	 || cr->uc_fsgid != cred->gid) {
+		res = 0;
+		goto out;
 	}
-	return (cred->uc_uid == 0 && cred->uc_fsuid == 0
-	     && cred->uc_gid == 0 && cred->uc_fsgid == 0
-	     && cred->uc_gids[0] == (gid_t) NOGROUP);
+
+	groups = cred->ngroups;
+	if (groups > NFS_NGROUPS)
+		groups = NFS_NGROUPS;
+	if (memcmp(cr->uc_gids, cred->groups, groups*sizeof(gid_t)))
+		res = 0;
+	if (groups < NFS_NGROUPS && cr->uc_gids[groups] != NOGROUP)
+		res = 0;
+out:
+	put_ucred(cred);
+	return res;
 }
 
 /*
diff -u --recursive --new-file linux-2.5.32-cred2/security/dummy.c linux-2.5.32-cred3/security/dummy.c
--- linux-2.5.32-cred2/security/dummy.c	Tue Jul 30 02:24:55 2002
+++ linux-2.5.32-cred3/security/dummy.c	Fri Aug 30 13:45:18 2002
@@ -53,7 +53,7 @@
 
 static int dummy_capable (struct task_struct *tsk, int cap)
 {
-	if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
+	if (cap_is_fs_cap (cap) ? task_fsuid(tsk) == 0 : tsk->euid == 0)
 		/* capability granted */
 		return 0;
 
@@ -489,7 +489,8 @@
 
 static void dummy_task_reparent_to_init (struct task_struct *p)
 {
-	p->euid = p->fsuid = 0;
+	p->euid = 0;
+	task_setfsuid(p, 0);
 	return;
 }
 

