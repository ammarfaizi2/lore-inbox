Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSKNXUa>; Thu, 14 Nov 2002 18:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSKNXTp>; Thu, 14 Nov 2002 18:19:45 -0500
Received: from patan.Sun.COM ([192.18.98.43]:38828 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262813AbSKNXTY>;
	Thu, 14 Nov 2002 18:19:24 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200211142326.gAENQE231767@scl2.sfbay.sun.com>
Subject: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2002 15:26:13 -0800 (PST)
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
#	           ChangeSet	1.853   -> 1.854  
#	include/linux/kernel.h	1.24    -> 1.25   
#	        lib/Makefile	1.15    -> 1.16   
#	include/linux/init_task.h	1.19    -> 1.20   
#	include/linux/sched.h	1.103   -> 1.104  
#	       kernel/fork.c	1.83    -> 1.84   
#	        kernel/sys.c	1.32    -> 1.33   
#	include/asm-i386/param.h	1.2     -> 1.3    
#	      kernel/uid16.c	1.2     -> 1.3    
#	     fs/proc/array.c	1.32    -> 1.33   
#	       kernel/exit.c	1.73    -> 1.74   
#	include/linux/limits.h	1.3     -> 1.4    
#	               (new)	        -> 1.1     lib/bsearch.c  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/11	thockin@freakshow.cobalt.com	1.854
# Remove the limit of 32 groups.  We now have a per-task, dynamic array of
# groups, which is kept sorted and refcounted.
# 
# This ChangeSet incorporates all the core functionality. but does not fixup
# all the incorrect usages of groups.  That is in a seperate ChangeSet.
# --------------------------------------------
#
diff -Nru a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Mon Nov 11 17:36:55 2002
+++ b/fs/proc/array.c	Mon Nov 11 17:36:55 2002
@@ -172,7 +172,7 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
+	for (g = 0; g < min(p->ngroups, OLD_NGROUPS); g++)
 		buffer += sprintf(buffer, "%d ", p->groups[g]);
 
 	buffer += sprintf(buffer, "\n");
diff -Nru a/include/asm-i386/param.h b/include/asm-i386/param.h
--- a/include/asm-i386/param.h	Mon Nov 11 17:36:55 2002
+++ b/include/asm-i386/param.h	Mon Nov 11 17:36:55 2002
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
--- a/include/linux/init_task.h	Mon Nov 11 17:36:55 2002
+++ b/include/linux/init_task.h	Mon Nov 11 17:36:55 2002
@@ -80,6 +80,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.ngroups	= 0,						\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Mon Nov 11 17:36:55 2002
+++ b/include/linux/kernel.h	Mon Nov 11 17:36:55 2002
@@ -215,4 +215,7 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+void *bsearch(const void *key, const void *base, size_t nmemb, size_t size,
+	int (*compar)(const void *, const void *));
+
 #endif
diff -Nru a/include/linux/limits.h b/include/linux/limits.h
--- a/include/linux/limits.h	Mon Nov 11 17:36:55 2002
+++ b/include/linux/limits.h	Mon Nov 11 17:36:55 2002
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
--- a/include/linux/sched.h	Mon Nov 11 17:36:55 2002
+++ b/include/linux/sched.h	Mon Nov 11 17:36:55 2002
@@ -348,7 +348,8 @@
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	int ngroups;
-	gid_t	groups[NGROUPS];
+	gid_t *groups;
+	atomic_t *groups_refcount;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Mon Nov 11 17:36:55 2002
+++ b/kernel/exit.c	Mon Nov 11 17:36:55 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
@@ -65,6 +66,11 @@
  
 	if (p != current)
 		wait_task_inactive(p);
+
+	if (p->ngroups && atomic_dec_and_test(p->groups_refcount)) {
+		vfree(p->groups_refcount);
+		vfree(p->groups);
+	}
 
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Mon Nov 11 17:36:55 2002
+++ b/kernel/fork.c	Mon Nov 11 17:36:55 2002
@@ -815,6 +815,10 @@
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
 
+	/* increment the groups ref count */
+	if (p->ngroups)
+		atomic_inc(p->groups_refcount);
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Mon Nov 11 17:36:55 2002
+++ b/kernel/sys.c	Mon Nov 11 17:36:55 2002
@@ -21,6 +21,8 @@
 #include <linux/times.h>
 #include <linux/security.h>
 #include <linux/dcookies.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1060,42 +1062,114 @@
 	return i;
 }
 
+/* a simple shell-metzner sort */
+static void groupsort(gid_t *grouplist, int gidsetsize)
+{
+	int right, left, cur, max, stride;
+
+	stride = gidsetsize / 2;
+	while (stride) {
+		max = gidsetsize - stride;
+
+		for (left = 0; left < max; left++) {
+			cur = left;
+			while (cur >= 0) {
+				right = cur + stride;
+				if (grouplist[right] < grouplist[cur]) {
+					gid_t tmp = grouplist[cur];
+					grouplist[cur] = grouplist[right];
+					grouplist[right] = tmp;
+					cur -= stride;
+				} else {
+					break;
+				}
+			}
+		}
+		stride /= 2;
+	}
+}
+
+static int gid_t_cmp(const void *a, const void *b)
+{
+	return *((gid_t *)a) - *((gid_t *)b);
+}
+
 /*
- *	SMP: Our groups are not shared. We can copy to/from them safely
+ *	SMP: Our groups are copy-on-write. We can set them safely
  *	without another task interfering.
  */
+int do_setgroups(int gidsetsize, gid_t *grouplist)
+{
+	atomic_t *newrefcnt = NULL;
+
+	BUG_ON(gidsetsize && !grouplist);
+	if (gidsetsize) {
+		newrefcnt = vmalloc(sizeof(*newrefcnt));
+		if (!newrefcnt) {
+			vfree(grouplist);
+			return -ENOMEM;
+		}
+
+		atomic_set(newrefcnt, 1);
+
+		/* sort the groupslist for faster searches */
+		groupsort(grouplist, gidsetsize);
+	}
+
+	/* disassociate ourselves from any shared group list */
+	if (current->ngroups
+	    && atomic_dec_and_test(current->groups_refcount)) {
+		vfree(current->groups_refcount);
+		vfree(current->groups);
+	}
+
+	current->groups = grouplist;
+	current->groups_refcount = newrefcnt;
+	current->ngroups = gidsetsize;
+
+	return 0;
+}
  
 asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist)
 {
-	gid_t groups[NGROUPS];
+	gid_t *groups = NULL;
 	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
-		return -EFAULT;
+	if (gidsetsize) {
+		/*
+		 * make sure there is at least OLD_NGROUPS amount of space in
+		 * the group list for backwards compatiblity sake.
+		 */
+		int alloc_size = (gidsetsize > OLD_NGROUPS) ? 
+		    gidsetsize : OLD_NGROUPS;
+		groups = vmalloc(alloc_size * sizeof(gid_t));
+		if (!groups)
+			return -ENOMEM;
+
+		if (copy_from_user(groups, grouplist,
+		    gidsetsize * sizeof(gid_t))) {
+			vfree(groups);
+			return -EFAULT;
+		}
+	}
+
 	retval = security_ops->task_setgroups(gidsetsize, groups);
-	if (retval)
+	if (retval) {
+		if (groups)
+			vfree(groups);
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	}
+	return do_setgroups(gidsetsize, groups);
 }
 
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
@@ -1388,3 +1462,4 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(sys_setgroups);
diff -Nru a/kernel/uid16.c b/kernel/uid16.c
--- a/kernel/uid16.c	Mon Nov 11 17:36:55 2002
+++ b/kernel/uid16.c	Mon Nov 11 17:36:55 2002
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 
@@ -27,6 +28,7 @@
 extern asmlinkage long sys_setresgid(gid_t, gid_t, gid_t);
 extern asmlinkage long sys_setfsuid(uid_t);
 extern asmlinkage long sys_setfsgid(gid_t);
+extern int do_setgroups(int gidsetsize, gid_t *grouplist);
  
 asmlinkage long sys_chown16(const char * filename, old_uid_t user, old_gid_t group)
 {
@@ -109,43 +111,74 @@
 
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
+		groups = vmalloc(sizeof(old_gid_t) * i);
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
 	int i;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		new_groups[i] = (gid_t)groups[i];
+	if (gidsetsize) {
+		/*
+		 * make sure there is at least OLD_NGROUPS amount of space in
+		 * the group list for backwards compatiblity sake.
+		 */
+		int alloc_size = (gidsetsize > OLD_NGROUPS) ? 
+		    gidsetsize : OLD_NGROUPS;
+
+		groups = vmalloc(sizeof(old_gid_t) * gidsetsize);
+		if (!groups)
+			return -ENOMEM;
+
+		if (copy_from_user(groups, grouplist,
+		    gidsetsize * sizeof(old_gid_t))) {
+			vfree(groups);
+			return -EFAULT;
+		}
+
+		if (!(new_groups = vmalloc(sizeof(gid_t) * alloc_size))) {
+			vfree(groups);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < gidsetsize; i++)
+			new_groups[i] = (gid_t)groups[i];
+
+		vfree(groups);
+	}
+
 	i = security_ops->task_setgroups(gidsetsize, new_groups);
-	if (i)
+	if (i) {
+		if (new_groups)
+			vfree(new_groups);
 		return i;
-	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	}
+	/* handles the vmalloc()ed new_groups */
+	return do_setgroups(gidsetsize, new_groups);
 }
 
 asmlinkage long sys_getuid16(void)
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Mon Nov 11 17:36:55 2002
+++ b/lib/Makefile	Mon Nov 11 17:36:55 2002
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
+++ b/lib/bsearch.c	Mon Nov 11 17:36:55 2002
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
