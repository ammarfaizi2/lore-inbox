Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVAQSeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVAQSeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVAQSc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:32:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42624 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262466AbVAQS1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:27:09 -0500
Date: Tue, 18 Jan 2005 00:00:14 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: [patch 1/2] mm: Reimplementation of alloc_percpu - move qsort from xfs/support to linux/lib
Message-ID: <20050117183014.GB2322@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to move qsort.c from fs/xfs/support/ to linux/lib so that
alloc_percpu reimplementation can use it.

Thanks,
Kiran


Patch to move qsort routine from the xfs file system to linux/lib so that
other subsystems can make use of it.

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
---

 fs/xfs/Makefile              |    1 
 fs/xfs/linux-2.6/xfs_linux.h |    2 
 fs/xfs/support/qsort.c       |  155 -------------------------------------------
 fs/xfs/support/qsort.h       |   41 -----------
 include/linux/qsort.h        |   41 +++++++++++
 lib/Makefile                 |    3 
 lib/qsort.c                  |  155 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 199 insertions(+), 199 deletions(-)

diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/fs/xfs/linux-2.6/xfs_linux.h alloc_percpu-2.6.11-rc1mm1/fs/xfs/linux-2.6/xfs_linux.h
--- linux-2.6.11-rc1mm1/fs/xfs/linux-2.6/xfs_linux.h	2004-12-25 03:05:50.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/fs/xfs/linux-2.6/xfs_linux.h	2005-01-15 21:02:17.000000000 +0530
@@ -64,7 +64,6 @@
 #include <sema.h>
 #include <time.h>
 
-#include <support/qsort.h>
 #include <support/ktrace.h>
 #include <support/debug.h>
 #include <support/move.h>
@@ -88,6 +87,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/version.h>
+#include <linux/qsort.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/fs/xfs/Makefile alloc_percpu-2.6.11-rc1mm1/fs/xfs/Makefile
--- linux-2.6.11-rc1mm1/fs/xfs/Makefile	2005-01-15 21:26:56.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/fs/xfs/Makefile	2005-01-15 21:03:40.000000000 +0530
@@ -143,7 +143,6 @@
 xfs-y				+= $(addprefix support/, \
 				   debug.o \
 				   move.o \
-				   qsort.o \
 				   uuid.o)
 
 xfs-$(CONFIG_XFS_TRACE)		+= support/ktrace.o
diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/fs/xfs/support/qsort.c alloc_percpu-2.6.11-rc1mm1/fs/xfs/support/qsort.c
--- linux-2.6.11-rc1mm1/fs/xfs/support/qsort.c	2004-12-25 03:05:28.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/fs/xfs/support/qsort.c	1970-01-01 05:30:00.000000000 +0530
@@ -1,155 +0,0 @@
-/*
- * Copyright (c) 1992, 1993
- *	The Regents of the University of California.  All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. Neither the name of the University nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-/*
- * Qsort routine from Bentley & McIlroy's "Engineering a Sort Function".
- */
-#define swapcode(TYPE, parmi, parmj, n) { 		\
-	long i = (n) / sizeof (TYPE); 			\
-	register TYPE *pi = (TYPE *) (parmi); 		\
-	register TYPE *pj = (TYPE *) (parmj); 		\
-	do { 						\
-		register TYPE	t = *pi;		\
-		*pi++ = *pj;				\
-		*pj++ = t;				\
-        } while (--i > 0);				\
-}
-
-#define SWAPINIT(a, es) swaptype = ((char *)a - (char *)0) % sizeof(long) || \
-	es % sizeof(long) ? 2 : es == sizeof(long)? 0 : 1;
-
-static __inline void
-swapfunc(char *a, char *b, int n, int swaptype)
-{
-	if (swaptype <= 1) 
-		swapcode(long, a, b, n)
-	else
-		swapcode(char, a, b, n)
-}
-
-#define swap(a, b)					\
-	if (swaptype == 0) {				\
-		long t = *(long *)(a);			\
-		*(long *)(a) = *(long *)(b);		\
-		*(long *)(b) = t;			\
-	} else						\
-		swapfunc(a, b, es, swaptype)
-
-#define vecswap(a, b, n) 	if ((n) > 0) swapfunc(a, b, n, swaptype)
-
-static __inline char *
-med3(char *a, char *b, char *c, int (*cmp)(const void *, const void *))
-{
-	return cmp(a, b) < 0 ?
-	       (cmp(b, c) < 0 ? b : (cmp(a, c) < 0 ? c : a ))
-              :(cmp(b, c) > 0 ? b : (cmp(a, c) < 0 ? a : c ));
-}
-
-void
-qsort(void *aa, size_t n, size_t es, int (*cmp)(const void *, const void *))
-{
-	char *pa, *pb, *pc, *pd, *pl, *pm, *pn;
-	int d, r, swaptype, swap_cnt;
-	register char *a = aa;
-
-loop:	SWAPINIT(a, es);
-	swap_cnt = 0;
-	if (n < 7) {
-		for (pm = (char *)a + es; pm < (char *) a + n * es; pm += es)
-			for (pl = pm; pl > (char *) a && cmp(pl - es, pl) > 0;
-			     pl -= es)
-				swap(pl, pl - es);
-		return;
-	}
-	pm = (char *)a + (n / 2) * es;
-	if (n > 7) {
-		pl = (char *)a;
-		pn = (char *)a + (n - 1) * es;
-		if (n > 40) {
-			d = (n / 8) * es;
-			pl = med3(pl, pl + d, pl + 2 * d, cmp);
-			pm = med3(pm - d, pm, pm + d, cmp);
-			pn = med3(pn - 2 * d, pn - d, pn, cmp);
-		}
-		pm = med3(pl, pm, pn, cmp);
-	}
-	swap(a, pm);
-	pa = pb = (char *)a + es;
-
-	pc = pd = (char *)a + (n - 1) * es;
-	for (;;) {
-		while (pb <= pc && (r = cmp(pb, a)) <= 0) {
-			if (r == 0) {
-				swap_cnt = 1;
-				swap(pa, pb);
-				pa += es;
-			}
-			pb += es;
-		}
-		while (pb <= pc && (r = cmp(pc, a)) >= 0) {
-			if (r == 0) {
-				swap_cnt = 1;
-				swap(pc, pd);
-				pd -= es;
-			}
-			pc -= es;
-		}
-		if (pb > pc)
-			break;
-		swap(pb, pc);
-		swap_cnt = 1;
-		pb += es;
-		pc -= es;
-	}
-	if (swap_cnt == 0) {  /* Switch to insertion sort */
-		for (pm = (char *) a + es; pm < (char *) a + n * es; pm += es)
-			for (pl = pm; pl > (char *) a && cmp(pl - es, pl) > 0; 
-			     pl -= es)
-				swap(pl, pl - es);
-		return;
-	}
-
-	pn = (char *)a + n * es;
-	r = min(pa - (char *)a, pb - pa);
-	vecswap(a, pb - r, r);
-	r = min((long)(pd - pc), (long)(pn - pd - es));
-	vecswap(pb, pn - r, r);
-	if ((r = pb - pa) > es)
-		qsort(a, r / es, es, cmp);
-	if ((r = pd - pc) > es) { 
-		/* Iterate rather than recurse to save stack space */
-		a = pn - r;
-		n = r / es;
-		goto loop;
-	}
-/*		qsort(pn - r, r / es, es, cmp);*/
-}
diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/fs/xfs/support/qsort.h alloc_percpu-2.6.11-rc1mm1/fs/xfs/support/qsort.h
--- linux-2.6.11-rc1mm1/fs/xfs/support/qsort.h	2004-12-25 03:05:23.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/fs/xfs/support/qsort.h	1970-01-01 05:30:00.000000000 +0530
@@ -1,41 +0,0 @@
-/*
- * Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
- */
-
-#ifndef QSORT_H
-#define QSORT_H
-
-extern void qsort (void *const pbase,
-		    size_t total_elems,
-		    size_t size,
-		    int (*cmp)(const void *, const void *));
-
-#endif
diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/include/linux/qsort.h alloc_percpu-2.6.11-rc1mm1/include/linux/qsort.h
--- linux-2.6.11-rc1mm1/include/linux/qsort.h	1970-01-01 05:30:00.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/include/linux/qsort.h	2004-12-25 03:05:23.000000000 +0530
@@ -0,0 +1,41 @@
+/*
+ * Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
+ */
+
+#ifndef QSORT_H
+#define QSORT_H
+
+extern void qsort (void *const pbase,
+		    size_t total_elems,
+		    size_t size,
+		    int (*cmp)(const void *, const void *));
+
+#endif
diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/lib/Makefile alloc_percpu-2.6.11-rc1mm1/lib/Makefile
--- linux-2.6.11-rc1mm1/lib/Makefile	2005-01-15 21:26:39.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/lib/Makefile	2005-01-15 21:00:11.000000000 +0530
@@ -5,7 +5,8 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o prio_tree.o
+	 bitmap.o extable.o kobject_uevent.o prio_tree.o \
+	 qsort.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff -ruN -X dontdiff2 linux-2.6.11-rc1mm1/lib/qsort.c alloc_percpu-2.6.11-rc1mm1/lib/qsort.c
--- linux-2.6.11-rc1mm1/lib/qsort.c	1970-01-01 05:30:00.000000000 +0530
+++ alloc_percpu-2.6.11-rc1mm1/lib/qsort.c	2004-12-25 03:05:28.000000000 +0530
@@ -0,0 +1,155 @@
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+/*
+ * Qsort routine from Bentley & McIlroy's "Engineering a Sort Function".
+ */
+#define swapcode(TYPE, parmi, parmj, n) { 		\
+	long i = (n) / sizeof (TYPE); 			\
+	register TYPE *pi = (TYPE *) (parmi); 		\
+	register TYPE *pj = (TYPE *) (parmj); 		\
+	do { 						\
+		register TYPE	t = *pi;		\
+		*pi++ = *pj;				\
+		*pj++ = t;				\
+        } while (--i > 0);				\
+}
+
+#define SWAPINIT(a, es) swaptype = ((char *)a - (char *)0) % sizeof(long) || \
+	es % sizeof(long) ? 2 : es == sizeof(long)? 0 : 1;
+
+static __inline void
+swapfunc(char *a, char *b, int n, int swaptype)
+{
+	if (swaptype <= 1) 
+		swapcode(long, a, b, n)
+	else
+		swapcode(char, a, b, n)
+}
+
+#define swap(a, b)					\
+	if (swaptype == 0) {				\
+		long t = *(long *)(a);			\
+		*(long *)(a) = *(long *)(b);		\
+		*(long *)(b) = t;			\
+	} else						\
+		swapfunc(a, b, es, swaptype)
+
+#define vecswap(a, b, n) 	if ((n) > 0) swapfunc(a, b, n, swaptype)
+
+static __inline char *
+med3(char *a, char *b, char *c, int (*cmp)(const void *, const void *))
+{
+	return cmp(a, b) < 0 ?
+	       (cmp(b, c) < 0 ? b : (cmp(a, c) < 0 ? c : a ))
+              :(cmp(b, c) > 0 ? b : (cmp(a, c) < 0 ? a : c ));
+}
+
+void
+qsort(void *aa, size_t n, size_t es, int (*cmp)(const void *, const void *))
+{
+	char *pa, *pb, *pc, *pd, *pl, *pm, *pn;
+	int d, r, swaptype, swap_cnt;
+	register char *a = aa;
+
+loop:	SWAPINIT(a, es);
+	swap_cnt = 0;
+	if (n < 7) {
+		for (pm = (char *)a + es; pm < (char *) a + n * es; pm += es)
+			for (pl = pm; pl > (char *) a && cmp(pl - es, pl) > 0;
+			     pl -= es)
+				swap(pl, pl - es);
+		return;
+	}
+	pm = (char *)a + (n / 2) * es;
+	if (n > 7) {
+		pl = (char *)a;
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
+		for (pm = (char *) a + es; pm < (char *) a + n * es; pm += es)
+			for (pl = pm; pl > (char *) a && cmp(pl - es, pl) > 0; 
+			     pl -= es)
+				swap(pl, pl - es);
+		return;
+	}
+
+	pn = (char *)a + n * es;
+	r = min(pa - (char *)a, pb - pa);
+	vecswap(a, pb - r, r);
+	r = min((long)(pd - pc), (long)(pn - pd - es));
+	vecswap(pb, pn - r, r);
+	if ((r = pb - pa) > es)
+		qsort(a, r / es, es, cmp);
+	if ((r = pd - pc) > es) { 
+		/* Iterate rather than recurse to save stack space */
+		a = pn - r;
+		n = r / es;
+		goto loop;
+	}
+/*		qsort(pn - r, r / es, es, cmp);*/
+}
