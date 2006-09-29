Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWI2JPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWI2JPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWI2JPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:15:45 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:26614 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1030504AbWI2JPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:15:44 -0400
Date: Fri, 29 Sep 2006 02:15:31 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] adds carta_random32() library routine
Message-ID: <20060929091531.GF20238@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a follow-up patch based on the review for perfmon2. This patch adds
the carta_random32() library routine + carta_random32.h header file.

This is fast, simple, and efficient pseudo number generator algorithm.
We use it in perfmon2 to randomize the sampling periods. In this context,
we do not need any fancy randomizer.

Changelog:
	- add carta_random32() simple and efficient pseudo random number
	  generator routine to generic kernel library
	- add carta_random32.h header file for prototype

Signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --git a/lib/Makefile b/lib/Makefile
index ef1d37a..dd8ff24 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ #
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o carta_random32.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
--- a/include/linux/carta_random32.h	1969-12-31 16:00:00.000000000 -0800
+++ b/include/linux/carta_random32.h	2006-09-28 08:23:46.000000000 -0700
@@ -0,0 +1,29 @@
+/*
+ * Fast, simple, yet decent quality random number generator based on
+ * a paper by David G. Carta ("Two Fast Implementations of the
+ * `Minimal Standard' Random Number Generator," Communications of the
+ * ACM, January, 1990).
+ *
+ * Copyright (c) 2002-2006 Hewlett-Packard Development Company, L.P.
+ *	Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+ */
+#ifndef _LINUX_CARTA_RANDOM32_H_
+#define _LINUX_CARTA_RANDOM32_H_
+
+u64 carta_random32(u64 seed);
+
+#endif /* _LINUX_CARTA_RANDOM32_H_ */
--- a/lib/carta_random32.c	1969-12-31 16:00:00.000000000 -0800
+++ b/lib/carta_random32.c	2006-09-29 01:54:00.000000000 -0700
@@ -0,0 +1,41 @@
+/*
+ * Copyright (c) 2002-2006 Hewlett-Packard Development Company, L.P.
+ *	Contributed by David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+ */
+#include <linux/types.h>
+#include <linux/module.h>
+
+/*
+ * Fast, simple, yet decent quality random number generator based on
+ * a paper by David G. Carta ("Two Fast Implementations of the
+ * `Minimal Standard' Random Number Generator," Communications of the
+ * ACM, January, 1990).
+ */ 
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
+EXPORT_SYMBOL_GPL(carta_random32);
