Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVAXUT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVAXUT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVAXUT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:19:28 -0500
Received: from waste.org ([216.27.176.166]:21154 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261614AbVAXUPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:15:52 -0500
Date: Mon, 24 Jan 2005 12:15:27 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] lib/qsort
Message-ID: <20050124201527.GZ12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122203618.962749000@blunzn.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces an implementation of qsort to lib/.

I've benchmarked many variants of quicksort implementations on array sizes
from 100 elements to >1M elements with an eye to reducing instruction
and branch count to bring out performance on modern processors. The
version below was the clear winner in both size and performance. 

Here are some benchmarks of cycle count averages for 10 runs on the
same random datasets, interrupts disabled. Percentages are performance
relative to the glibc algorithm. A bunch of other variants dropped for
brevity.

name      size  description
qsort:     916  glibc algorithm
qsort2:    613  glibc algorithm without insertion sort pass
qsort_s:   324  simple version with variable-sized automatic stack
qsort_sf2: 247  simple version with pluggable swap routine (this patch)
qsort_c3:  573  simple version with median of 3 and "collapse the walls"

P4M 1.8GHz -O2 -march=i686 (cycles counts almost identical to P4 Xeon 3.2GHz):

100:
           qsort: 11568 100.00%
          qsort2: 11822 97.85%
         qsort_s: 8356 138.43%
       qsort_sf2: 4542 254.70%
        qsort_c3: 11248 102.84%
200:
           qsort: 27005 100.00%
          qsort2: 28337 95.30%
         qsort_s: 24672 109.46%
       qsort_sf2: 13387 201.72%
        qsort_c3: 28776 93.85%
400:
           qsort: 60464 100.00%
          qsort2: 63134 95.77%
         qsort_s: 54791 110.35%
       qsort_sf2: 31677 190.88%
        qsort_c3: 68228 88.62%
800:
           qsort: 144190 100.00%
          qsort2: 149240 96.62%
         qsort_s: 137439 104.91%
       qsort_sf2: 82340 175.12%
        qsort_c3: 151487 95.18%
1600:
           qsort: 315813 100.00%
          qsort2: 329444 95.86%
         qsort_s: 356588 88.57%
       qsort_sf2: 195203 161.79%
        qsort_c3: 360908 87.51%
3200:
           qsort: 725993 100.00%
          qsort2: 738060 98.37%
         qsort_s: 752978 96.42%
       qsort_sf2: 444705 163.25%
        qsort_c3: 814500 89.13%
6400:
           qsort: 1564310 100.00%
          qsort2: 1603845 97.53%
         qsort_s: 1746958 89.54%
       qsort_sf2: 1011510 154.65%
        qsort_c3: 1800720 86.87%
12800:
           qsort: 3502147 100.00%
          qsort2: 3507643 99.84%
         qsort_s: 4078681 85.86%
       qsort_sf2: 2397432 146.08%
        qsort_c3: 3976366 88.07%
25600:
           qsort: 7618627 100.00%
          qsort2: 7661898 99.44%
         qsort_s: 8708923 87.48%
       qsort_sf2: 5288890 144.05%
        qsort_c3: 8637922 88.20%
51200:
           qsort: 16009766 100.00%
          qsort2: 16339192 97.98%
         qsort_s: 18949571 84.49%
       qsort_sf2: 11511438 139.08%
        qsort_c3: 18578005 86.18%
102400:
           qsort: 34594524 100.00%
          qsort2: 35163198 98.38%
         qsort_s: 42052914 82.26%
       qsort_sf2: 25638424 134.93%
        qsort_c3: 40474691 85.47%

Opteron 1.4GHz 32-bit -O2 -march=athlon:

100:
           qsort: 8125 100.00%
          qsort2: 5531 146.90%
         qsort_s: 4534 179.18%
       qsort_sf2: 1714 474.06%
        qsort_c3: 5841 139.09%
200:
           qsort: 16019 100.00%
          qsort2: 12259 130.67%
         qsort_s: 12540 127.75%
       qsort_sf2: 4432 361.42%
        qsort_c3: 14156 113.16%
400:
           qsort: 34523 100.00%
          qsort2: 26789 128.87%
         qsort_s: 27058 127.59%
       qsort_sf2: 10152 340.05%
        qsort_c3: 33008 104.59%
800:
           qsort: 78279 100.00%
          qsort2: 61667 126.94%
         qsort_s: 65749 119.06%
       qsort_sf2: 25454 307.53%
        qsort_c3: 72988 107.25%
1600:
           qsort: 166172 100.00%
          qsort2: 135495 122.64%
         qsort_s: 169073 98.28%
       qsort_sf2: 60248 275.81%
        qsort_c3: 173264 95.91%
3200:
           qsort: 362308 100.00%
          qsort2: 302439 119.80%
         qsort_s: 361346 100.27%
       qsort_sf2: 134529 269.31%
        qsort_c3: 387407 93.52%
6400:
           qsort: 780260 100.00%
          qsort2: 651574 119.75%
         qsort_s: 855666 91.19%
       qsort_sf2: 306348 254.70%
        qsort_c3: 852795 91.49%
12800:
           qsort: 1686017 100.00%
          qsort2: 1420488 118.69%
         qsort_s: 1992462 84.62%
       qsort_sf2: 726466 232.08%
        qsort_c3: 1898620 88.80%
25600:
           qsort: 3642061 100.00%
          qsort2: 3093633 117.73%
         qsort_s: 4161486 87.52%
       qsort_sf2: 1653795 220.22%
        qsort_c3: 4120878 88.38%
51200:
           qsort: 7724747 100.00%
          qsort2: 6649277 116.17%
         qsort_s: 9248117 83.53%
       qsort_sf2: 3653293 211.45%
        qsort_c3: 8917153 86.63%
102400:
           qsort: 16478170 100.00%
          qsort2: 14305384 115.19%
         qsort_s: 20574011 80.09%
       qsort_sf2: 8322403 198.00%
        qsort_c3: 19511628 84.45%

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2qs/lib/Makefile
===================================================================
--- mm2qs.orig/lib/Makefile	2005-01-20 22:11:01.000000000 -0800
+++ mm2qs/lib/Makefile	2005-01-24 01:24:17.000000000 -0800
@@ -21,6 +21,7 @@
   lib-y += dec_and_lock.o
 endif
 
+obj-$(CONFIG_QSORT) += qsort.o
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
Index: mm2qs/lib/qsort.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm2qs/lib/qsort.c	2005-01-24 10:41:57.000000000 -0800
@@ -0,0 +1,94 @@
+/*
+ * A fast, small, non-recursive quicksort for the Linux kernel
+ *
+ * Jan 23 2005  Matt Mackall <mpm@selenic.com>
+ *
+ * Inspired by quicksort code from glibc and K&R
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+
+/*
+ * qsort - sort an array of elements with quicksort
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp: pointer to comparison function
+ * @swap: pointer to swap function
+ * @flags: allocation type for kmalloc
+ *
+ * This function does a quicksort on the given array. It is primarily
+ * tuned for small arrays, trading optimal compare and swap count for
+ * code simplicity and instruction/branch count. You can either use
+ * the generic_swap function or, where appropriate, provide a routine
+ * optimized for your element size.
+ *
+ * This function allocates an internal stack of 256 or 1024 bytes to
+ * avoid recursion overhead and may return -ENOMEM if allocation
+ * fails.
+ */
+
+int qsort(void *base, size_t num, size_t size,
+	  int (*cmp)(const void *, const void *),
+	  void (*swap)(const void *, const void *, int), int flags)
+{
+	void *i, *p, *l = base, *r = base + num * size;
+	struct stack {
+		void *l, *r;
+	} *stack, *top;
+
+	stack = top = kmalloc(8 * sizeof(int) * sizeof(struct stack), flags);
+	if (!stack)
+		return -ENOMEM;
+
+	do {
+		if (l + size >= r) {
+			/* empty sub-array, pop */
+			l = top->l;
+			r = top->r;
+			--top;
+		} else {
+			/* position the pivot element */
+			for(i = l + size, p = l; i != r; i += size)
+				if (cmp(i, l) < 0) {
+					p += size;
+					swap(i, p, size);
+				}
+			swap(l, p, size);
+
+			/* save the bigger half on the stack */
+			top++;
+			if (p - l < r - p) {
+				top->l = p + size;
+				top->r = r;
+				r = p;
+			} else {
+				top->l = l;
+				top->r = p;
+				l = p + size;
+			}
+		}
+	} while (top >= stack);
+
+	kfree(stack);
+	return 0;
+}
+
+void qsort_swap(void *a, void *b, int size)
+{
+	char t;
+
+	do {
+		t = *(char *)a;
+		*(char *)b++ = *(char *)a;
+		*(char *)a++ = t;
+	} while (--size > 0);
+}
+
+EXPORT_SYMBOL_GPL(qsort);
+EXPORT_SYMBOL_GPL(qsort_swap);
+
+MODULE_LICENSE("GPL");
Index: mm2qs/include/linux/qsort.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm2qs/include/linux/qsort.h	2005-01-24 10:43:46.000000000 -0800
@@ -0,0 +1,10 @@
+#ifndef _LINUX_QSORT_H
+#define _LINUX_QSORT_H
+
+int qsort(void *base, size_t num, size_t size,
+	  int (*cmp)(const void *, const void *),
+	  void (*swap)(const void *, const void *, int), int flags);
+
+void qsort_swap(void *a, void *b, int size);
+
+#endif
Index: mm2qs/lib/Kconfig
===================================================================
--- mm2qs.orig/lib/Kconfig	2005-01-19 22:53:44.000000000 -0800
+++ mm2qs/lib/Kconfig	2005-01-24 10:33:20.000000000 -0800
@@ -57,5 +57,8 @@
 config REED_SOLOMON_DEC16
 	boolean
 
+config QSORT
+	tristate
+
 endmenu
 


-- 
Mathematics is the supreme nostalgia of our time.
