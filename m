Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWHWIQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWHWIQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWHWIQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:16:28 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:52953 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932385AbWHWIQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:16:12 -0400
Date: Wed, 23 Aug 2006 01:05:54 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230805.k7N85seX000372@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/18] 2.6.17.9 perfmon2 patch for review: new library support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the carta_random32() routine to the library.
This is a very simple and very efficient random number generator
implementing Carta's algorithm. This routine is used by
perfmon2 to compute a randomized sampling period. On some
platforms, such as IA-64, this routine may be implemented in
assembly directly.




diff -urp --exclude-from=/tmp/excl31584 linux-2.6.17.9.base/lib/Makefile linux-2.6.17.9/lib/Makefile
--- linux-2.6.17.9.base/lib/Makefile	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/lib/Makefile	2006-08-21 03:37:45.000000000 -0700
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o carta_random32.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
Only in linux-2.6.17.9/lib: carta_random32.c
Only in linux-2.6.17.9: perfmon
--- linux-2.6.17.9.base/lib/carta_random32.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/lib/carta_random32.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,29 @@
+/*
+ * Fast, simple, yet decent quality random number generator based on
+ * a paper by David G. Carta ("Two Fast Implementations of the
+ * `Minimal Standard' Random Number Generator," Communications of the
+ * ACM, January, 1990).
+ *
+ * Copyright (c) 2002-2005 Hewlett-Packard Development Company, L.P.
+ *	Contributed by David Mosberger-Tang <davidm@hpl.hp.com>
+ */
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+#ifndef __HAVE_ARCH_CARTA_RANDOM32
+u64 carta_random32 (u64 seed)
+{
+#       define A 16807
+#       define M ((u32) 1 << 31)
+        u64 s, prod = A * seed, p, q;
+
+        p = (prod >> 31) & (M - 1);
+        q = (prod >>  0) & (M - 1);
+        s = p + q;
+        if (s >= M)
+                s -= M - 1;
+        return s;
+}
+EXPORT_SYMBOL(carta_random32);
+#endif
