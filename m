Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbSJ2T0d>; Tue, 29 Oct 2002 14:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJ2T0c>; Tue, 29 Oct 2002 14:26:32 -0500
Received: from kathmandu.sun.com ([192.18.98.36]:40611 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id <S262180AbSJ2T0X>;
	Tue, 29 Oct 2002 14:26:23 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210291932.g9TJWjb30582@scl2.sfbay.sun.com>
Subject: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 29 Oct 2002 11:32:45 -0800 (PST)
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
#	           ChangeSet	1.808   -> 1.809  
#	include/linux/kernel.h	1.24    -> 1.25   
#	        lib/Makefile	1.14    -> 1.15   
#	               (new)	        -> 1.1     lib/bsearch.c  
#	               (new)	        -> 1.1     lib/qsort.c    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/21	thockin@freakshow.cobalt.com	1.809
# Add generic qsort() and bsearch(): qsort() from BSD, bsearch() from glibc
# --------------------------------------------
#
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Mon Oct 21 17:14:38 2002
+++ b/include/linux/kernel.h	Mon Oct 21 17:14:38 2002
@@ -215,4 +215,9 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+void qsort(void *base, size_t nmemb, size_t size,
+	int (*compar)(const void *, const void *));
+void *bsearch(const void *key, const void *base, size_t nmemb, size_t size,
+	int (*compar)(const void *, const void *));
+
 #endif
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Mon Oct 21 17:14:38 2002
+++ b/lib/Makefile	Mon Oct 21 17:14:38 2002
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
diff -Nru a/lib/bsearch.c b/lib/bsearch.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/bsearch.c	Mon Oct 21 17:14:38 2002
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
diff -Nru a/lib/qsort.c b/lib/qsort.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/qsort.c	Mon Oct 21 17:14:38 2002
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
