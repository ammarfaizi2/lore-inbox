Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbSJDXrT>; Fri, 4 Oct 2002 19:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262121AbSJDXrT>; Fri, 4 Oct 2002 19:47:19 -0400
Received: from patan.Sun.COM ([192.18.98.43]:42892 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262120AbSJDXrJ>;
	Fri, 4 Oct 2002 19:47:09 -0400
Message-ID: <3D9E29BD.1040902@sun.com>
Date: Fri, 04 Oct 2002 16:52:29 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: austin@digitalroadkill.net, hahn@physics.mcmaster.ca, jackie.m@vt.edu,
       rread@clusterfs.com
Subject: RFC: Patch for >32 groups
Content-Type: multipart/mixed;
 boundary="------------070800050108070509000001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070800050108070509000001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All,

Here is a set of patches (against a recent-ish 2.5 BK) that removes the 
arbitrary limit of 32 groups.

The first patch creates generic qsort() and bsearch() routines (I have 
another patch to conver XFS to use it, as discussed with Christoph a 
while back).

The second patch converts task->groups[] into a dynamic, refcounted, CoW 
array.  It does the needed bits for i386 (minor) but not the other 
architectures.  I have (not included here for brevity) patches that 
convert other arch trees to do the right thing (I think) and convert 
other usages of NGROUPS and task->groups and task->ngroups.  There are 
still a few issues I am working out with those.

I wanted to post this (and CC: people who have mailed me about it) and 
see if there are any complaints about the approach.  The patches are 
simple, and have been in use in our own 2.4.x systems or some time.  I 
did make some changes in forward porting, but they are tested on at 
least one 2.5.x box here :)

This has the side effect of reducing the size of struct task_struct by a 
bit, too. :)

This should run on any glibc, without mods.  Glibc will need to return a 
different value instead of NGROUPS (32), to be fully correct, though.  I 
suggest INT_MAX :)

We've found a couple apps that needed to be fixed up in the event of >32 
groups being used, and when this goes mainline, we'll pop out those 
patches, too.  Another issue:  this changes /proc/pid/status to only 
show 32 groups - not sure what better solution is preferred.

Comments, read-overs, and flames requested.  Ideally I'd like to see 
this go into 2.5.x real soon now. :)

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

--------------070800050108070509000001
Content-Type: text/plain;
 name="sort_search.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sort_search.patch"

diff -ruN virgin-2.5/include/linux/kernel.h linux-2.5/include/linux/kernel.h
--- virgin-2.5/include/linux/kernel.h	Tue Oct  1 16:42:45 2002
+++ linux-2.5/include/linux/kernel.h	Fri Oct  4 13:44:09 2002
@@ -206,4 +206,9 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+void qsort(void *base, size_t nmemb, size_t size,
+	int (*compar)(const void *, const void *));
+void *bsearch(const void *key, const void *base, size_t nmemb, size_t size,
+	int (*compar)(const void *, const void *));
+
 #endif
diff -ruN virgin-2.5/lib/Makefile linux-2.5/lib/Makefile
--- virgin-2.5/lib/Makefile	Tue Oct  1 16:46:37 2002
+++ linux-2.5/lib/Makefile	Fri Oct  4 13:44:09 2002
@@ -9,10 +9,11 @@
 L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       crc32.o rbtree.o radix-tree.o
+	       crc32.o rbtree.o radix-tree.o qsort.o bsearch.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
-	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o
+	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
+	 qsort.o bsearch.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -ruN virgin-2.5/lib/bsearch.c linux-2.5/lib/bsearch.c
--- virgin-2.5/lib/bsearch.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5/lib/bsearch.c	Fri Oct  4 13:44:09 2002
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
diff -ruN virgin-2.5/lib/qsort.c linux-2.5/lib/qsort.c
--- virgin-2.5/lib/qsort.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5/lib/qsort.c	Fri Oct  4 13:44:09 2002
@@ -0,0 +1,180 @@
+/*
+ * Update: The Berkeley copyright was changed, and the change
+ * is retroactive to all "true" BSD software (ie everything
+ * from UCB as opposed to other peoples code that just carried
+ * the same license). The new copyright doesn't clash with the
+ * GPL, so the module-only restriction has been removed..
+ */
+
+/*-
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ * Copyright (c) 2002 SGI
+ * Copyright (c) 2002 Sun Microsystems, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ * 
+ * From:
+ *	@(#)qsort.c	8.1 (Berkeley) 6/4/93
+ *	FreeBSD: src/lib/libc/stdlib/qsort.c,v 1.11 2002/03/22 21:53:10
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+typedef int		 cmp_t(const void *, const void *);
+static inline char	*med3(char *, char *, char *, cmp_t *);
+static inline void	 swapfunc(char *, char *, int, int);
+
+/*
+ * Qsort routine from Bentley & McIlroy's "Engineering a Sort Function".
+ */
+#define swapcode(TYPE, parmi, parmj, n) do { 		\
+	long i = (n) / sizeof (TYPE); 			\
+	TYPE *pi = (TYPE *) (parmi); 			\
+	TYPE *pj = (TYPE *) (parmj); 			\
+	do { 						\
+		TYPE	t = *pi;			\
+		*pi++ = *pj;				\
+		*pj++ = t;				\
+        } while (--i > 0);				\
+} while (0)
+
+#define SWAPINIT(a, es) swaptype = ((char *)a - (char *)0) % sizeof(long) || \
+	es % sizeof(long) ? 2 : es == sizeof(long)? 0 : 1;
+
+static inline void
+swapfunc(char *a, char *b, int n, int swaptype)
+{
+	if(swaptype <= 1)
+		swapcode(long, a, b, n);
+	else
+		swapcode(char, a, b, n);
+}
+
+#define swap(a, b) do {					\
+	if (swaptype == 0) {				\
+		long t = *(long *)(a);			\
+		*(long *)(a) = *(long *)(b);		\
+		*(long *)(b) = t;			\
+	} else						\
+		swapfunc(a, b, es, swaptype);		\
+} while (0)
+
+#define vecswap(a, b, n) 	do { 			\
+	if ((n) > 0) swapfunc(a, b, n, swaptype);	\
+} while (0)
+
+static inline char *
+med3(char *a, char *b, char *c, cmp_t *cmp)
+{
+	return cmp(a, b) < 0 ?
+	       (cmp(b, c) < 0 ? b : (cmp(a, c) < 0 ? c : a ))
+              :(cmp(b, c) > 0 ? b : (cmp(a, c) < 0 ? a : c ));
+}
+
+void
+qsort(void *a, size_t n, size_t es, cmp_t *cmp)
+{
+	char *pa, *pb, *pc, *pd, *pl, *pm, *pn;
+	int d, r, swaptype, swap_cnt;
+
+loop:	SWAPINIT(a, es);
+	swap_cnt = 0;
+	if (n < 7) {
+		for (pm = (char *)a + es; pm < (char *)a + n * es; pm += es)
+			for (pl = pm; pl > (char *)a && cmp(pl - es, pl) > 0;
+			     pl -= es)
+				swap(pl, pl - es);
+		return;
+	}
+	pm = (char *)a + (n / 2) * es;
+	if (n > 7) {
+		pl = a;
+		pn = (char *)a + (n - 1) * es;
+		if (n > 40) {
+			d = (n / 8) * es;
+			pl = med3(pl, pl + d, pl + 2 * d, cmp);
+			pm = med3(pm - d, pm, pm + d, cmp);
+			pn = med3(pn - 2 * d, pn - d, pn, cmp);
+		}
+		pm = med3(pl, pm, pn, cmp);
+	}
+	swap(a, pm);
+	pa = pb = (char *)a + es;
+
+	pc = pd = (char *)a + (n - 1) * es;
+	for (;;) {
+		while (pb <= pc && (r = cmp(pb, a)) <= 0) {
+			if (r == 0) {
+				swap_cnt = 1;
+				swap(pa, pb);
+				pa += es;
+			}
+			pb += es;
+		}
+		while (pb <= pc && (r = cmp(pc, a)) >= 0) {
+			if (r == 0) {
+				swap_cnt = 1;
+				swap(pc, pd);
+				pd -= es;
+			}
+			pc -= es;
+		}
+		if (pb > pc)
+			break;
+		swap(pb, pc);
+		swap_cnt = 1;
+		pb += es;
+		pc -= es;
+	}
+	if (swap_cnt == 0) {  /* Switch to insertion sort */
+		for (pm = (char *)a + es; pm < (char *)a + n * es; pm += es)
+			for (pl = pm; pl > (char *)a && cmp(pl - es, pl) > 0;
+			     pl -= es)
+				swap(pl, pl - es);
+		return;
+	}
+
+	pn = (char *)a + n * es;
+	r = min_t(long, pa - (char *)a, pb - pa);
+	vecswap(a, pb - r, r);
+	r = min_t(long, pd - pc, pn - pd - es);
+	vecswap(pb, pn - r, r);
+	if ((r = pb - pa) > es)
+		qsort(a, r / es, es, cmp);
+	if ((r = pd - pc) > es) {
+		/* Iterate rather than recurse to save stack space */
+		a = pn - r;
+		n = r / es;
+		goto loop;
+	}
+}
+
+EXPORT_SYMBOL(qsort);

--------------070800050108070509000001
Content-Type: text/plain;
 name="ngroups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ngroups.patch"

diff -ruN virgin-2.5/fs/proc/array.c linux-2.5/fs/proc/array.c
--- virgin-2.5/fs/proc/array.c	Tue Oct  1 16:35:03 2002
+++ linux-2.5/fs/proc/array.c	Fri Oct  4 13:44:38 2002
@@ -171,7 +171,7 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
+	for (g = 0; g < min(p->ngroups, OLD_NGROUPS); g++)
 		buffer += sprintf(buffer, "%d ", p->groups[g]);
 
 	buffer += sprintf(buffer, "\n");
diff -ruN virgin-2.5/include/asm-i386/param.h linux-2.5/include/asm-i386/param.h
--- virgin-2.5/include/asm-i386/param.h	Tue Oct  1 16:44:14 2002
+++ linux-2.5/include/asm-i386/param.h	Fri Oct  4 13:44:38 2002
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -ruN virgin-2.5/include/linux/init_task.h linux-2.5/include/linux/init_task.h
--- virgin-2.5/include/linux/init_task.h	Tue Oct  1 16:42:52 2002
+++ linux-2.5/include/linux/init_task.h	Fri Oct  4 13:44:17 2002
@@ -80,6 +80,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.ngroups	= 0,						\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
diff -ruN virgin-2.5/include/linux/limits.h linux-2.5/include/linux/limits.h
--- virgin-2.5/include/linux/limits.h	Tue Oct  1 16:43:11 2002
+++ linux-2.5/include/linux/limits.h	Fri Oct  4 13:44:38 2002
@@ -3,7 +3,6 @@
 
 #define NR_OPEN	        1024
 
-#define NGROUPS_MAX       32	/* supplemental group IDs are available */
 #define ARG_MAX       131072	/* # bytes of args + environ for exec() */
 #define CHILD_MAX        999    /* no limit :-) */
 #define OPEN_MAX         256	/* # open files a process may have */
@@ -19,4 +18,6 @@
 
 #define RTSIG_MAX	  32
 
+#define OLD_NGROUPS       32	/* old limit of supplemental group IDs */
+
 #endif
diff -ruN virgin-2.5/include/linux/sched.h linux-2.5/include/linux/sched.h
--- virgin-2.5/include/linux/sched.h	Tue Oct  1 16:42:52 2002
+++ linux-2.5/include/linux/sched.h	Fri Oct  4 13:44:17 2002
@@ -351,7 +351,8 @@
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	int ngroups;
-	gid_t	groups[NGROUPS];
+	gid_t *groups;
+	atomic_t *groups_refcount;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
diff -ruN virgin-2.5/kernel/exit.c linux-2.5/kernel/exit.c
--- virgin-2.5/kernel/exit.c	Tue Oct  1 16:46:42 2002
+++ linux-2.5/kernel/exit.c	Fri Oct  4 13:44:17 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
@@ -64,6 +65,12 @@
 		BUG();
 	if (p != current)
 		wait_task_inactive(p);
+
+	if (p->ngroups && atomic_dec_and_test(p->groups_refcount)) {
+		vfree(p->groups_refcount);
+		vfree(p->groups);
+	}
+
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
diff -ruN virgin-2.5/kernel/fork.c linux-2.5/kernel/fork.c
--- virgin-2.5/kernel/fork.c	Tue Oct  1 16:46:41 2002
+++ linux-2.5/kernel/fork.c	Fri Oct  4 13:44:17 2002
@@ -805,6 +805,10 @@
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
 
+	/* increment the groups ref count */
+	if (p->ngroups)
+		atomic_inc(p->groups_refcount);
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
diff -ruN virgin-2.5/kernel/sys.c linux-2.5/kernel/sys.c
--- virgin-2.5/kernel/sys.c	Tue Oct  1 16:46:41 2002
+++ linux-2.5/kernel/sys.c	Fri Oct  4 13:44:46 2002
@@ -20,6 +20,9 @@
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1056,42 +1059,87 @@
 	return i;
 }
 
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
+		qsort(grouplist, gidsetsize, sizeof(gid_t), gid_t_cmp);
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
@@ -1384,3 +1432,4 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(sys_setgroups);
diff -ruN virgin-2.5/kernel/uid16.c linux-2.5/kernel/uid16.c
--- virgin-2.5/kernel/uid16.c	Tue Oct  1 16:46:42 2002
+++ linux-2.5/kernel/uid16.c	Fri Oct  4 13:48:39 2002
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

--------------070800050108070509000001--

