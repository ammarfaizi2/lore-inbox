Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTAFXV1>; Mon, 6 Jan 2003 18:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbTAFXV1>; Mon, 6 Jan 2003 18:21:27 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:27633 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S267048AbTAFXVJ>; Mon, 6 Jan 2003 18:21:09 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200301062329.h06NTax24223@scl2.sfbay.sun.com>
Subject: [BK PATCH 1/1] remove 32 group limit (re-send)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Mon, 6 Jan 2003 15:29:36 -0800 (PST)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.887   -> 1.888  
#	include/linux/kernel.h	1.29    -> 1.30   
#	        lib/Makefile	1.16    -> 1.17   
#	include/linux/init_task.h	1.19    -> 1.20   
#	       kernel/fork.c	1.93    -> 1.94   
#	include/linux/sched.h	1.115   -> 1.116  
#	        kernel/sys.c	1.38    -> 1.39   
#	include/asm-i386/param.h	1.2     -> 1.3    
#	include/linux/sunrpc/svcauth.h	1.4     -> 1.5    
#	      kernel/uid16.c	1.4     -> 1.5    
#	     fs/proc/array.c	1.35    -> 1.36   
#	net/sunrpc/svcauth_unix.c	1.9     -> 1.10   
#	       kernel/exit.c	1.76    -> 1.77   
#	include/linux/limits.h	1.3     -> 1.4    
#	      fs/nfsd/auth.c	1.1     -> 1.2    
#	               (new)	        -> 1.1     lib/bsearch.c  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/16	thockin@freakshow.cobalt.com	1.888
# Remove the limit of 32 groups.  We now have a per-task, dynamic array of
# groups, which is kept sorted and refcounted.  If the task has less than 32 
# groups, we behave like older kernels and use an inline array.
# 
# This ChangeSet incorporates all the core functionality. but does not fixup
# all the incorrect architecture usages of groups.  That will follow.
# --------------------------------------------
#
diff -Nru a/fs/nfsd/auth.c b/fs/nfsd/auth.c
--- a/fs/nfsd/auth.c	Mon Dec 16 15:15:22 2002
+++ b/fs/nfsd/auth.c	Mon Dec 16 15:15:22 2002
@@ -10,12 +10,15 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfsd/nfsd.h>
 
+extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
+
 #define	CAP_NFSD_MASK (CAP_FS_MASK|CAP_TO_MASK(CAP_SYS_RESOURCE))
 void
 nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 {
 	struct svc_cred	*cred = &rqstp->rq_cred;
 	int		i;
+	gid_t		groups[SVC_CRED_NGROUPS];
 
 	if (rqstp->rq_userset)
 		return;
@@ -29,7 +32,7 @@
 			cred->cr_uid = exp->ex_anon_uid;
 		if (!cred->cr_gid)
 			cred->cr_gid = exp->ex_anon_gid;
-		for (i = 0; i < NGROUPS; i++)
+		for (i = 0; i < SVC_CRED_NGROUPS; i++)
 			if (!cred->cr_groups[i])
 				cred->cr_groups[i] = exp->ex_anon_gid;
 	}
@@ -42,13 +45,13 @@
 		current->fsgid = cred->cr_gid;
 	else
 		current->fsgid = exp->ex_anon_gid;
-	for (i = 0; i < NGROUPS; i++) {
+	for (i = 0; i < SVC_CRED_NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
-		current->groups[i] = group;
+		groups[i] = group;
 	}
-	current->ngroups = i;
+	sys_setgroups(i, groups);
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
diff -Nru a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Mon Dec 16 15:15:22 2002
+++ b/fs/proc/array.c	Mon Dec 16 15:15:22 2002
@@ -172,7 +172,7 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
+	for (g = 0; g < min(p->ngroups, OLD_NGROUPS); g++)
 		buffer += sprintf(buffer, "%d ", p->groups[g]);
 
 	buffer += sprintf(buffer, "\n");
diff -Nru a/include/asm-i386/param.h b/include/asm-i386/param.h
--- a/include/asm-i386/param.h	Mon Dec 16 15:15:22 2002
+++ b/include/asm-i386/param.h	Mon Dec 16 15:15:22 2002
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Mon Dec 16 15:15:22 2002
+++ b/include/linux/init_task.h	Mon Dec 16 15:15:22 2002
@@ -80,6 +80,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.ngroups	= 0,						\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Mon Dec 16 15:15:22 2002
+++ b/include/linux/kernel.h	Mon Dec 16 15:15:22 2002
@@ -221,4 +221,7 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+void *bsearch(const void *key, const void *base, size_t nmemb, size_t size,
+	int (*compar)(const void *, const void *));
+
 #endif
diff -Nru a/include/linux/limits.h b/include/linux/limits.h
--- a/include/linux/limits.h	Mon Dec 16 15:15:22 2002
+++ b/include/linux/limits.h	Mon Dec 16 15:15:22 2002
@@ -3,7 +3,6 @@
 
 #define NR_OPEN	        1024
 
-#define NGROUPS_MAX       32	/* supplemental group IDs are available */
 #define ARG_MAX       131072	/* # bytes of args + environ for exec() */
 #define CHILD_MAX        999    /* no limit :-) */
 #define OPEN_MAX         256	/* # open files a process may have */
@@ -18,5 +17,7 @@
 #define XATTR_LIST_MAX 65536	/* size of extended attribute namelist (64k) */
 
 #define RTSIG_MAX	  32
+
+#define OLD_NGROUPS       32	/* old limit of supplemental group IDs */
 
 #endif
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Mon Dec 16 15:15:22 2002
+++ b/include/linux/sched.h	Mon Dec 16 15:15:22 2002
@@ -276,6 +276,8 @@
 typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 
+#define NGROUPS_INLINE		32
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -348,7 +350,9 @@
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	int ngroups;
-	gid_t	groups[NGROUPS];
+	gid_t *groups;
+	gid_t groups_inline[NGROUPS_INLINE];
+	atomic_t *groups_refcount;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
diff -Nru a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
--- a/include/linux/sunrpc/svcauth.h	Mon Dec 16 15:15:22 2002
+++ b/include/linux/sunrpc/svcauth.h	Mon Dec 16 15:15:22 2002
@@ -14,10 +14,11 @@
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/cache.h>
 
+#define SVC_CRED_NGROUPS	32
 struct svc_cred {
 	uid_t			cr_uid;
 	gid_t			cr_gid;
-	gid_t			cr_groups[NGROUPS];
+	gid_t			cr_groups[SVC_CRED_NGROUPS];
 };
 
 struct svc_rqst;		/* forward decl */
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Mon Dec 16 15:15:22 2002
+++ b/kernel/exit.c	Mon Dec 16 15:15:22 2002
@@ -57,6 +57,7 @@
 	return proc_dentry;
 }
 
+extern void groups_free(gid_t *groups, int gidsetsize);
 void release_task(struct task_struct * p)
 {
 	struct dentry *proc_dentry;
@@ -66,6 +67,12 @@
  
 	if (p != current)
 		wait_task_inactive(p);
+
+	if (p->ngroups > NGROUPS_INLINE 
+	    && atomic_dec_and_test(p->groups_refcount)) {
+		kfree(p->groups_refcount);
+		groups_free(p->groups, p->ngroups);
+	}
 
 	atomic_dec(&p->user->processes);
 	security_task_free(p);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Mon Dec 16 15:15:22 2002
+++ b/kernel/fork.c	Mon Dec 16 15:15:22 2002
@@ -834,6 +834,13 @@
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
 
+	/* increment the groups ref count */
+	if (p->ngroups > NGROUPS_INLINE) {
+		atomic_inc(p->groups_refcount);
+	} else if (p->ngroups) {
+		p->groups = p->groups_inline;
+	}
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Mon Dec 16 15:15:22 2002
+++ b/kernel/sys.c	Mon Dec 16 15:15:22 2002
@@ -22,6 +22,9 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1063,42 +1066,137 @@
 	return i;
 }
 
+/* a simple shell-metzner sort */
+static void groupsort(gid_t *grouplist, int gidsetsize)
+{
+	int base, max, stride;
+
+	for (stride = 1; stride < gidsetsize; stride = 3 * stride + 1)
+		; /* nothing */
+	stride /= 3;
+
+	while (stride) {
+		max = gidsetsize - stride;
+		for (base = 0; base < max; base++) {
+			int left = base;
+			gid_t tmp = grouplist[base + stride];
+			while (left >= 0 && tmp < grouplist[left]) {
+				grouplist[left] = grouplist[left + stride];
+				left -= stride;
+			}
+			grouplist[left + stride] = tmp;
+		}
+		stride /= 3;
+	}
+}
+
+static int gid_t_cmp(const void *a, const void *b)
+{
+	return *((gid_t *)a) - *((gid_t *)b);
+}
+
+#define GROUPS_KV_THRESH	(2*EXEC_PAGESIZE/sizeof(gid_t))
+gid_t *groups_alloc(int gidsetsize)
+{
+	if (gidsetsize <= GROUPS_KV_THRESH)
+		return kmalloc(gidsetsize * sizeof(gid_t), GFP_KERNEL);
+	else
+		return vmalloc(gidsetsize * sizeof(gid_t));
+}
+
+void groups_free(gid_t *groups, int gidsetsize)
+{
+	if (gidsetsize <= NGROUPS_INLINE)
+		; /* nothing */
+	else if (gidsetsize <= GROUPS_KV_THRESH)
+		kfree(groups);
+	else
+		vfree(groups);
+}
+	
 /*
- *	SMP: Our groups are not shared. We can copy to/from them safely
+ *	SMP: Our groups are copy-on-write. We can set them safely
  *	without another task interfering.
  */
- 
-asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist)
+int do_setgroups(int gidsetsize, gid_t *grouplist)
 {
-	gid_t groups[NGROUPS];
+	atomic_t *newrefcnt = NULL;
 	int retval;
 
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
-		return -EFAULT;
-	retval = security_task_setgroups(gidsetsize, groups);
-	if (retval)
+	BUG_ON(gidsetsize && !grouplist);
+
+	retval = security_task_setgroups(gidsetsize, grouplist);
+	if (retval) {
+		groups_free(grouplist, gidsetsize);
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
+	}
+
+	if (gidsetsize > NGROUPS_INLINE) {
+		newrefcnt = kmalloc(sizeof(*newrefcnt), GFP_KERNEL);
+		if (!newrefcnt) {
+			groups_free(grouplist, gidsetsize);
+			return -ENOMEM;
+		}
+		atomic_set(newrefcnt, 1);
+	}
+	if (gidsetsize) {
+		/* sort the grouplist for faster searches */
+		groupsort(grouplist, gidsetsize);
+	}
+
+	/* disassociate ourselves from any shared group list */
+	if (current->ngroups > NGROUPS_INLINE
+	    && atomic_dec_and_test(current->groups_refcount)) {
+		kfree(current->groups_refcount);
+		groups_free(current->groups, current->ngroups);
+	}
+
+	/* use the inline array for small numbers of groups */
+	if (gidsetsize <= NGROUPS_INLINE) {
+		memcpy(current->groups_inline, grouplist,
+		    gidsetsize * sizeof(gid_t));
+		grouplist = current->groups_inline;
+	}
+
+	current->groups = grouplist;
+	current->groups_refcount = newrefcnt;
 	current->ngroups = gidsetsize;
+
 	return 0;
 }
+ 
+asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist)
+{
+	gid_t *groups = NULL;
+	gid_t groups_ar[NGROUPS_INLINE];
+
+	if (!capable(CAP_SETGID))
+		return -EPERM;
+	if (gidsetsize) {
+		if (gidsetsize <= NGROUPS_INLINE) {
+			groups = groups_ar;
+		} else {
+			groups = groups_alloc(gidsetsize);
+			if (!groups)
+				return -ENOMEM;
+		}
+
+		if (copy_from_user(groups, grouplist, 
+		    gidsetsize * sizeof(gid_t))) {
+			groups_free(groups, gidsetsize);
+			return -EFAULT;
+		}
+	}
+
+	return do_setgroups(gidsetsize, groups);
+}
 
 static int supplemental_group_member(gid_t grp)
 {
-	int i = current->ngroups;
-
-	if (i) {
-		gid_t *groups = current->groups;
-		do {
-			if (*groups == grp)
-				return 1;
-			groups++;
-			i--;
-		} while (i);
+	if (current->ngroups) {
+		if (bsearch(&grp, current->groups, current->ngroups,
+		    sizeof(gid_t), gid_t_cmp))
+			return 1;
 	}
 	return 0;
 }
@@ -1393,3 +1491,4 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(sys_setgroups);
diff -Nru a/kernel/uid16.c b/kernel/uid16.c
--- a/kernel/uid16.c	Mon Dec 16 15:15:22 2002
+++ b/kernel/uid16.c	Mon Dec 16 15:15:22 2002
@@ -13,6 +13,8 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 
@@ -107,45 +109,73 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+extern gid_t *groups_alloc(int gidsetsize);
+extern void groups_free(gid_t *groups, int gidsetsize);
+extern int do_setgroups(int gidsetsize, gid_t *grouplist);
+
 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t *grouplist)
 {
-	old_gid_t groups[NGROUPS];
+	old_gid_t *groups;
 	int i,j;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
 	i = current->ngroups;
-	if (gidsetsize) {
+	if (i && gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
+		groups = vmalloc(i * sizeof(old_gid_t));
+		if (!groups)
+			return -ENOMEM;
 		for(j=0;j<i;j++)
 			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
+		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i)) {
+			vfree(groups);
 			return -EFAULT;
+		}
+		vfree(groups);
 	}
 	return i;
 }
 
 asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t *grouplist)
 {
-	old_gid_t groups[NGROUPS];
-	gid_t new_groups[NGROUPS];
+	old_gid_t *groups;
+	gid_t *new_groups = NULL;
+	gid_t new_groups_ar[NGROUPS_INLINE];
 	int i;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		new_groups[i] = (gid_t)groups[i];
-	i = security_task_setgroups(gidsetsize, new_groups);
-	if (i)
-		return i;
-	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	if (gidsetsize) {
+		groups = vmalloc(gidsetsize * sizeof(old_gid_t));
+		if (!groups)
+			return -ENOMEM;
+
+		if (copy_from_user(groups, grouplist,
+		    gidsetsize * sizeof(old_gid_t))) {
+			vfree(groups);
+			return -EFAULT;
+		}
+
+		if (gidsetsize <= NGROUPS_INLINE) {
+			new_groups = new_groups_ar;
+		} else {
+			new_groups = groups_alloc(gidsetsize);
+			if (!new_groups) {
+				vfree(groups);
+				return -ENOMEM;
+			}
+		}
+
+		for (i = 0; i < gidsetsize; i++)
+			new_groups[i] = (gid_t)groups[i];
+
+		vfree(groups);
+	}
+
+	/* this handles the allocated new_groups */
+	return do_setgroups(gidsetsize, new_groups);
 }
 
 asmlinkage long sys_getuid16(void)
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Mon Dec 16 15:15:22 2002
+++ b/lib/Makefile	Mon Dec 16 15:15:22 2002
@@ -9,11 +9,11 @@
 L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       crc32.o rbtree.o radix-tree.o kobject.o
+	       crc32.o rbtree.o radix-tree.o kobject.o bsearch.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o
+	 kobject.o bsearch.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/bsearch.c b/lib/bsearch.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/bsearch.c	Mon Dec 16 15:15:22 2002
@@ -0,0 +1,49 @@
+/* Copyright (C) 1991, 1992, 1997, 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/* Perform a binary search for KEY in BASE which has NMEMB elements
+   of SIZE bytes each.  The comparisons are done by (*COMPAR)().  */
+void *
+bsearch(const void *key, const void *base, size_t nmemb, size_t size,
+    int (*compar)(const void *, const void *))
+{
+	size_t l, u, idx;
+	const void *p;
+	int comparison;
+
+	l = 0;
+	u = nmemb;
+	while (l < u) {
+		idx = (l + u) / 2;
+		p = (void *)(((const char *)base) + (idx * size));
+		comparison = (*compar)(key, p);
+		if (comparison < 0)
+			u = idx;
+		else if (comparison > 0)
+			l = idx + 1;
+		else
+			return (void *)p;
+	}
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(bsearch);
diff -Nru a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
--- a/net/sunrpc/svcauth_unix.c	Mon Dec 16 15:15:22 2002
+++ b/net/sunrpc/svcauth_unix.c	Mon Dec 16 15:15:22 2002
@@ -401,11 +401,11 @@
 	if (slen > 16 || (len -= (slen + 2)*4) < 0)
 		goto badcred;
 	for (i = 0; i < slen; i++)
-		if (i < NGROUPS)
+		if (i < SVC_CRED_NGROUPS)
 			cred->cr_groups[i] = ntohl(svc_getu32(argv));
 		else
 			svc_getu32(argv);
-	if (i < NGROUPS)
+	if (i < SVC_CRED_NGROUPS)
 		cred->cr_groups[i] = NOGROUP;
 
 	if (svc_getu32(argv) != RPC_AUTH_NULL || svc_getu32(argv) != 0) {
