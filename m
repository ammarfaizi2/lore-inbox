Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVAVUfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVAVUfx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAVUfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:35:53 -0500
Received: from ns.suse.de ([195.135.220.2]:41936 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262709AbVAVUe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:29 -0500
Message-Id: <20050122203618.962749000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:01 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/13] Qsort
Content-Disposition: inline; filename=patches.suse/qsort
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quicksort from glibc as a kernel library function, and switch
xfs over to using it. The implementations are equivalent. The nfsacl
protocol also requires a sort function, so it makes more sense in
the common code.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/include/linux/kernel.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/kernel.h
+++ linux-2.6.11-rc2/include/linux/kernel.h
@@ -93,6 +93,8 @@ extern int sscanf(const char *, const ch
 	__attribute__ ((format (scanf,2,3)));
 extern int vsscanf(const char *, const char *, va_list);
 
+extern void qsort(void *, size_t, size_t, int (*)(const void *,const void *));
+
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(char *ptr, char **retptr);
Index: linux-2.6.11-rc2/lib/Kconfig
===================================================================
--- linux-2.6.11-rc2.orig/lib/Kconfig
+++ linux-2.6.11-rc2/lib/Kconfig
@@ -30,6 +30,9 @@ config LIBCRC32C
 	  require M here.  See Castagnoli93.
 	  Module will be libcrc32c.
 
+config QSORT
+	bool "Quick Sort"
+
 #
 # compression support is select'ed if needed
 #
Index: linux-2.6.11-rc2/lib/Makefile
===================================================================
--- linux-2.6.11-rc2.orig/lib/Makefile
+++ linux-2.6.11-rc2/lib/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
+obj-$(CONFIG_QSORT)	+= qsort.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
Index: linux-2.6.11-rc2/lib/qsort.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc2/lib/qsort.c
@@ -0,0 +1,249 @@
+/* Copyright (C) 1991, 1992, 1996, 1997, 1999 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Written by Douglas C. Schmidt (schmidt@ics.uci.edu).
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+/* If you consider tuning this algorithm, you should consult first:
+   Engineering a sort function; Jon Bentley and M. Douglas McIlroy;
+   Software - Practice and Experience; Vol. 23 (11), 1249-1265, 1993.  */
+
+# include <linux/module.h>
+# include <linux/slab.h>
+# include <linux/string.h>
+
+MODULE_LICENSE("GPL");
+
+/* Byte-wise swap two items of size SIZE. */
+#define SWAP(a, b, size)						      \
+  do									      \
+    {									      \
+      register size_t __size = (size);					      \
+      register char *__a = (a), *__b = (b);				      \
+      do								      \
+	{								      \
+	  char __tmp = *__a;						      \
+	  *__a++ = *__b;						      \
+	  *__b++ = __tmp;						      \
+	} while (--__size > 0);						      \
+    } while (0)
+
+/* Discontinue quicksort algorithm when partition gets below this size.
+   This particular magic number was chosen to work best on a Sun 4/260. */
+#define MAX_THRESH 4
+
+/* Stack node declarations used to store unfulfilled partition obligations. */
+typedef struct
+  {
+    char *lo;
+    char *hi;
+  } stack_node;
+
+/* The next 5 #defines implement a very fast in-line stack abstraction. */
+/* The stack needs log (total_elements) entries (we could even subtract
+   log(MAX_THRESH)).  Since total_elements has type size_t, we get as
+   upper bound for log (total_elements):
+   bits per byte (CHAR_BIT) * sizeof(size_t).  */
+#define CHAR_BIT 8
+#define STACK_SIZE	(CHAR_BIT * sizeof(size_t))
+#define PUSH(low, high)	((void) ((top->lo = (low)), (top->hi = (high)), ++top))
+#define	POP(low, high)	((void) (--top, (low = top->lo), (high = top->hi)))
+#define	STACK_NOT_EMPTY	(stack < top)
+
+
+/* Order size using quicksort.  This implementation incorporates
+   four optimizations discussed in Sedgewick:
+
+   1. Non-recursive, using an explicit stack of pointer that store the
+      next array partition to sort.  To save time, this maximum amount
+      of space required to store an array of SIZE_MAX is allocated on the
+      stack.  Assuming a 32-bit (64 bit) integer for size_t, this needs
+      only 32 * sizeof(stack_node) == 256 bytes (for 64 bit: 1024 bytes).
+      Pretty cheap, actually.
+
+   2. Chose the pivot element using a median-of-three decision tree.
+      This reduces the probability of selecting a bad pivot value and
+      eliminates certain extraneous comparisons.
+
+   3. Only quicksorts TOTAL_ELEMS / MAX_THRESH partitions, leaving
+      insertion sort to order the MAX_THRESH items within each partition.
+      This is a big win, since insertion sort is faster for small, mostly
+      sorted array segments.
+
+   4. The larger of the two sub-partitions is always pushed onto the
+      stack first, with the algorithm then concentrating on the
+      smaller partition.  This *guarantees* no more than log (total_elems)
+      stack size is needed (actually O(1) in this case)!  */
+
+void
+qsort(void *const pbase, size_t total_elems, size_t size,
+      int(*cmp)(const void *,const void *))
+{
+  register char *base_ptr = (char *) pbase;
+
+  const size_t max_thresh = MAX_THRESH * size;
+
+  if (total_elems == 0)
+    /* Avoid lossage with unsigned arithmetic below.  */
+    return;
+
+  if (total_elems > MAX_THRESH)
+    {
+      char *lo = base_ptr;
+      char *hi = &lo[size * (total_elems - 1)];
+      stack_node stack[STACK_SIZE];
+      stack_node *top = stack + 1;
+
+      while (STACK_NOT_EMPTY)
+        {
+          char *left_ptr;
+          char *right_ptr;
+
+	  /* Select median value from among LO, MID, and HI. Rearrange
+	     LO and HI so the three values are sorted. This lowers the
+	     probability of picking a pathological pivot value and
+	     skips a comparison for both the LEFT_PTR and RIGHT_PTR in
+	     the while loops. */
+
+	  char *mid = lo + size * ((hi - lo) / size >> 1);
+
+	  if ((*cmp) ((void *) mid, (void *) lo) < 0)
+	    SWAP (mid, lo, size);
+	  if ((*cmp) ((void *) hi, (void *) mid) < 0)
+	    SWAP (mid, hi, size);
+	  else
+	    goto jump_over;
+	  if ((*cmp) ((void *) mid, (void *) lo) < 0)
+	    SWAP (mid, lo, size);
+	jump_over:;
+
+	  left_ptr  = lo + size;
+	  right_ptr = hi - size;
+
+	  /* Here's the famous ``collapse the walls'' section of quicksort.
+	     Gotta like those tight inner loops!  They are the main reason
+	     that this algorithm runs much faster than others. */
+	  do
+	    {
+	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
+		left_ptr += size;
+
+	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
+		right_ptr -= size;
+
+	      if (left_ptr < right_ptr)
+		{
+		  SWAP (left_ptr, right_ptr, size);
+		  if (mid == left_ptr)
+		    mid = right_ptr;
+		  else if (mid == right_ptr)
+		    mid = left_ptr;
+		  left_ptr += size;
+		  right_ptr -= size;
+		}
+	      else if (left_ptr == right_ptr)
+		{
+		  left_ptr += size;
+		  right_ptr -= size;
+		  break;
+		}
+	    }
+	  while (left_ptr <= right_ptr);
+
+          /* Set up pointers for next iteration.  First determine whether
+             left and right partitions are below the threshold size.  If so,
+             ignore one or both.  Otherwise, push the larger partition's
+             bounds on the stack and continue sorting the smaller one. */
+
+          if ((size_t) (right_ptr - lo) <= max_thresh)
+            {
+              if ((size_t) (hi - left_ptr) <= max_thresh)
+		/* Ignore both small partitions. */
+                POP (lo, hi);
+              else
+		/* Ignore small left partition. */
+                lo = left_ptr;
+            }
+          else if ((size_t) (hi - left_ptr) <= max_thresh)
+	    /* Ignore small right partition. */
+            hi = right_ptr;
+          else if ((right_ptr - lo) > (hi - left_ptr))
+            {
+	      /* Push larger left partition indices. */
+              PUSH (lo, right_ptr);
+              lo = left_ptr;
+            }
+          else
+            {
+	      /* Push larger right partition indices. */
+              PUSH (left_ptr, hi);
+              hi = right_ptr;
+            }
+        }
+    }
+
+  /* Once the BASE_PTR array is partially sorted by quicksort the rest
+     is completely sorted using insertion sort, since this is efficient
+     for partitions below MAX_THRESH size. BASE_PTR points to the beginning
+     of the array to sort, and END_PTR points at the very last element in
+     the array (*not* one beyond it!). */
+
+  {
+    char *end_ptr = &base_ptr[size * (total_elems - 1)];
+    char *tmp_ptr = base_ptr;
+    char *thresh = min(end_ptr, base_ptr + max_thresh);
+    register char *run_ptr;
+
+    /* Find smallest element in first threshold and place it at the
+       array's beginning.  This is the smallest array element,
+       and the operation speeds up insertion sort's inner loop. */
+
+    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
+      if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
+        tmp_ptr = run_ptr;
+
+    if (tmp_ptr != base_ptr)
+      SWAP (tmp_ptr, base_ptr, size);
+
+    /* Insertion sort, running from left-hand-side up to right-hand-side.  */
+
+    run_ptr = base_ptr + size;
+    while ((run_ptr += size) <= end_ptr)
+      {
+	tmp_ptr = run_ptr - size;
+	while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
+	  tmp_ptr -= size;
+
+	tmp_ptr += size;
+        if (tmp_ptr != run_ptr)
+          {
+            char *trav;
+
+	    trav = run_ptr + size;
+	    while (--trav >= run_ptr)
+              {
+                char c = *trav;
+                char *hi, *lo;
+
+                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
+                  *hi = *lo;
+                *hi = c;
+              }
+          }
+      }
+  }
+}
+EXPORT_SYMBOL(qsort);
Index: linux-2.6.11-rc2/fs/xfs/support/qsort.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/xfs/support/qsort.c
+++ /dev/null
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
Index: linux-2.6.11-rc2/fs/xfs/Makefile
===================================================================
--- linux-2.6.11-rc2.orig/fs/xfs/Makefile
+++ linux-2.6.11-rc2/fs/xfs/Makefile
@@ -142,7 +142,6 @@ xfs-y				+= $(addprefix linux-2.6/, \
 xfs-y				+= $(addprefix support/, \
 				   debug.o \
 				   move.o \
-				   qsort.o \
 				   uuid.o)
 
 xfs-$(CONFIG_XFS_TRACE)		+= support/ktrace.o
Index: linux-2.6.11-rc2/fs/xfs/support/qsort.h
===================================================================
--- linux-2.6.11-rc2.orig/fs/xfs/support/qsort.h
+++ /dev/null
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
Index: linux-2.6.11-rc2/fs/xfs/linux-2.6/xfs_linux.h
===================================================================
--- linux-2.6.11-rc2.orig/fs/xfs/linux-2.6/xfs_linux.h
+++ linux-2.6.11-rc2/fs/xfs/linux-2.6/xfs_linux.h
@@ -64,7 +64,6 @@
 #include <sema.h>
 #include <time.h>
 
-#include <support/qsort.h>
 #include <support/ktrace.h>
 #include <support/debug.h>
 #include <support/move.h>
Index: linux-2.6.11-rc2/fs/Kconfig
===================================================================
--- linux-2.6.11-rc2.orig/fs/Kconfig
+++ linux-2.6.11-rc2/fs/Kconfig
@@ -306,6 +306,7 @@ config FS_POSIX_ACL
 
 config XFS_FS
 	tristate "XFS filesystem support"
+	select QSORT
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

