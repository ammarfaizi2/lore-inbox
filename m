Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVAaHp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVAaHp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVAaHoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:44:02 -0500
Received: from waste.org ([216.27.176.166]:59116 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261951AbVAaHfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:01 -0500
Date: Mon, 31 Jan 2005 01:34:59 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1.416337461@selenic.com>
Message-Id: <2.416337461@selenic.com>
Subject: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a generic array sorting library routine. This is meant
to replace qsort, which has two problem areas for kernel use.

The first issue is quadratic worst-case performance. While quicksort
worst-case datasets are rarely encountered in normal scenarios, it is
in fact quite easy to construct worst cases for almost all quicksort
algorithms given source or access to an element comparison callback.
This could allow attackers to cause sorts that would otherwise take
less than a millisecond to take seconds and sorts that should take
less than a second to take weeks or months. Fixing this problem
requires randomizing pivot selection with a secure random number
generator, which is rather expensive.

The second is that quicksort's recursion tracking requires either
nontrivial amounts of stack space or dynamic memory allocation and out
of memory error handling.

By comparison, heapsort has both O(n log n) average and worst-case
performance and practically no extra storage requirements. This
version runs within 70-90% of the average performance of optimized
quicksort so it should be an acceptable replacement wherever quicksort
would be used in the kernel.

Note that this function has an extra parameter for passing in an
optimized swapping function. This is worth 10% or more over the
typical byte-by-byte exchange functions.

Benchmarks:

qsort:     glibc variant            1189 bytes (+ 256/1024 stack)
qsort_3f:  my simplified variant     459 bytes (+ 256/1024 stack)
heapsort:  the version below         346 bytes
shellsort: an optimized shellsort    196 bytes

                         P4 1.8GHz        Opteron 1.4GHz (32-bit)
size   algorithm      cycles relative        cycles relative
100:
           qsort:      38682 100.00%	      27631 100.00%
        qsort_3f:      36277 106.63%	      22406 123.32%
        heapsort:      43574  88.77%	      30301  91.19%
       shellsort:      39087  98.97%	      25139 109.91%
200:									    
           qsort:      86468 100.00%	      61148 100.00%
        qsort_3f:      78918 109.57%	      48959 124.90%
        heapsort:      98040  88.20%	      68235  89.61%
       shellsort:      95688  90.36%	      62279  98.18%
400:									    
           qsort:     187720 100.00%	     131313 100.00%
        qsort_3f:     174905 107.33%	     107954 121.64%
        heapsort:     223896  83.84%	     154241  85.13%
       shellsort:     223037  84.17%	     148990  88.14%
800:									    
           qsort:     407060 100.00%	     287460 100.00%
        qsort_3f:     385106 105.70%	     239131 120.21%
        heapsort:     484662  83.99%	     340099  84.52%
       shellsort:     537110  75.79%	     354755  81.03%
1600:									    
           qsort:     879596 100.00%	     621331 100.00%
        qsort_3f:     861568 102.09%	     522013 119.03%
        heapsort:    1079750  81.46%	     746677  83.21%
       shellsort:    1234243  71.27%	     820782  75.70%
3200:									    
           qsort:    1903902 100.00%	    1342126 100.00%
        qsort_3f:    1908816  99.74%	    1131496 118.62%
        heapsort:    2515493  75.69%	    1630333  82.32%
       shellsort:    2985339  63.78%	    1964794  68.31%
6400:									    
           qsort:    4046370 100.00%	    2909215 100.00%
        qsort_3f:    4164468  97.16%	    2468393 117.86%
        heapsort:    5150659  78.56%	    3533585  82.33%
       shellsort:    6650225  60.85%	    4429849  65.67%
12800:									    
           qsort:    8729730 100.00%	    6185097 100.00%
        qsort_3f:    8776885  99.46%	    5288826 116.95%
        heapsort:   11064224  78.90%	    7603061  81.35%
       shellsort:   15487905  56.36%	   10305163  60.02%
25600:									    
           qsort:   18357770 100.00%	   13172205 100.00%
        qsort_3f:   18687842  98.23%	   11337115 116.19%
        heapsort:   24121241  76.11%	   16612122  79.29%
       shellsort:   35552814  51.64%	   24106987  54.64%
51200:									    
           qsort:   38658883 100.00%	   28008505 100.00%
        qsort_3f:   39498463  97.87%	   24339675 115.07%
        heapsort:   50553552  76.47%	   37013828  75.67%
       shellsort:   82602416  46.80%	   56201889  49.84%
102400:									    
           qsort:   81197794 100.00%	   58918933 100.00%
        qsort_3f:   84257930  96.37%	   51986219 113.34%
        heapsort:  110540577  73.46%	   81419675  72.36%
       shellsort:  191303132  42.44%	  129786472  45.40%


Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/lib/Makefile
===================================================================
--- mm2.orig/lib/Makefile	2005-01-30 21:26:28.000000000 -0800
+++ mm2/lib/Makefile	2005-01-30 22:37:49.000000000 -0800
@@ -6,7 +6,7 @@
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
 	 bitmap.o extable.o kobject_uevent.o prio_tree.o \
-	 sha1.o halfmd4.o
+	 sha1.o halfmd4.o sort.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
Index: mm2/include/linux/sort.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm2/include/linux/sort.h	2005-01-30 22:06:37.000000000 -0800
@@ -0,0 +1,8 @@
+#ifndef _LINUX_SORT_H
+#define _LINUX_SORT_H
+
+void sort(void *base, size_t num, size_t size,
+	  int (*cmp)(const void *, const void *),
+	  void (*swap)(void *, void *, int));
+
+#endif
Index: mm2/lib/sort.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm2/lib/sort.c	2005-01-30 22:37:28.000000000 -0800
@@ -0,0 +1,121 @@
+/*
+ * A fast, small, non-recursive O(nlog n) sort for the Linux kernel
+ *
+ * Jan 23 2005  Matt Mackall <mpm@selenic.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+void u32_swap(void *a, void *b, int size)
+{
+	u32 t = *(u32 *)a;
+	*(u32 *)a = *(u32 *)b;
+	*(u32 *)b = t;
+}
+
+void generic_swap(void *a, void *b, int size)
+{
+	char t;
+
+	do {
+		t = *(char *)a;
+		*(char *)a++ = *(char *)b;
+		*(char *)b++ = t;
+	} while (--size > 0);
+}
+
+/*
+ * sort - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp: pointer to comparison function
+ * @swap: pointer to swap function or NULL
+ *
+ * This function does a heapsort on the given array. You may provide a
+ * swap function optimized to your element type.
+ *
+ * Sorting time is O(n log n) both on average and worst-case. While
+ * qsort is about 20% faster on average, it suffers from exploitable
+ * O(n*n) worst-case behavior and extra memory requirements that make
+ * it less suitable for kernel use.
+ */
+
+void sort(void *base, size_t num, size_t size,
+	  int (*cmp)(const void *, const void *),
+	  void (*swap)(void *, void *, int size))
+{
+	/* pre-scale counters for performance */
+	int i = (num/2 - 1) * size, n = num * size, c, r;
+
+	if (!swap)
+		swap = (size == 4 ? u32_swap : generic_swap);
+
+	/* heapify */
+	for ( ; i >= 0; i -= size) {
+		for (r = i; r * 2 < n; r  = c) {
+			c = r * 2;
+			if (c < n - size && cmp(base + c, base + c + size) < 0)
+				c += size;
+			if (cmp(base + r, base + c) >= 0)
+				break;
+			swap(base + r, base + c, size);
+		}
+	}
+
+	/* sort */
+	for (i = n - size; i >= 0; i -= size) {
+		swap(base, base + i, size);
+		for (r = 0; r * 2 < i; r = c) {
+			c = r * 2;
+			if (c < i - size && cmp(base + c, base + c + size) < 0)
+				c += size;
+			if (cmp(base + r, base + c) >= 0)
+				break;
+			swap(base + r, base + c, size);
+		}
+	}
+}
+
+EXPORT_SYMBOL_GPL(sort);
+
+MODULE_LICENSE("GPL");
+
+#if 1
+/* a simple boot-time regression test */
+
+int cmpint(const void *a, const void *b)
+{
+	return *(int *)a - *(int *)b;
+}
+
+static int sort_test(void)
+{
+	int *a, i, r = 0;
+
+	a = kmalloc(1000 * sizeof(int), GFP_KERNEL);
+	BUG_ON(!a);
+
+	printk("testing sort()\n");
+
+	for (i = 0; i < 1000; i++) {
+		r = (r * 725861) % 6599;
+		a[i] = r;
+	}
+
+	sort(a, 1000, sizeof(int), cmpint, 0);
+
+	for (i = 0; i < 999; i++)
+		if (a[i] > a[i+1]) {
+			printk("sort() failed!\n");
+			break;
+		}
+
+	kfree(a);
+
+	return 0;
+}
+
+module_init(sort_test);
+#endif
