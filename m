Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWHNVPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWHNVPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWHNVPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:15:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932709AbWHNVPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:15:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [RHEL5 PATCH 1/4] Provide fallback full 64-bit divide/modulus ops for gcc
Date: Mon, 14 Aug 2006 22:15:07 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#,
       dhowells@redhat.com
Message-Id: <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide simple, reasonably quick full 64-bit divide and modulus ops for gcc to
call behind the scenes as:

	__udivmoddi4
	__udivdi3
	__umoddi3

The algorithm is a really simple binary long division that doesn't require
usage of multiply and divide instructions.  It shortcuts the long division at
the beginning by not bothering to consider any steps below the divisor
threshold.

The algorithm is placed in lib/ so that it can easily be replaced with an arch
specific version.  It will be dragged in by stuff in the fs/ directory once the
64-bit ino_t patch is applied unless an alternative is supplied, or unless the
CPU provides full 64-bit native instructions that the compiler can use.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/kernel.h |    4 ++
 lib/Makefile           |    2 -
 lib/__udivdi3.c        |   23 +++++++++++
 lib/__udivmoddi4.c     |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/__umoddi3.c        |   25 ++++++++++++
 5 files changed, 152 insertions(+), 1 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 181c69c..ab69416 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -152,6 +152,10 @@ static inline int printk(const char *s, 
 static inline int printk(const char *s, ...) { return 0; }
 #endif
 
+extern u64 __udivmoddi4(u64 dividend, u64 divisor, u64 *_remainder);
+extern u64 __udivdi3(u64 dividend, u64 divisor);
+extern u64 __umoddi3(u64 dividend, u64 divisor);
+
 unsigned long int_sqrt(unsigned long);
 
 static inline int __attribute_pure__ long_log2(unsigned long x)
diff --git a/lib/Makefile b/lib/Makefile
index be9719a..41428d3 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ #
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o __udivdi3.o __umoddi3.o __udivmoddi4.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
diff --git a/lib/__udivdi3.c b/lib/__udivdi3.c
new file mode 100644
index 0000000..6541aef
--- /dev/null
+++ b/lib/__udivdi3.c
@@ -0,0 +1,23 @@
+/* __udivdi3.c: unsigned 64-bit by 64-bit division yielding 64-bit result
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/*
+ * return a / b
+ */
+u64 __udivdi3(u64 a, u64 b)
+{
+	return __udivmoddi4(a, b, NULL);
+}
+
+EXPORT_SYMBOL(__udivdi3);
diff --git a/lib/__udivmoddi4.c b/lib/__udivmoddi4.c
new file mode 100644
index 0000000..b9a9f2a
--- /dev/null
+++ b/lib/__udivmoddi4.c
@@ -0,0 +1,99 @@
+/* __udivmoddi4.c: unsigned 64-bit by 64-bit division yielding 64-bit results
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <asm/div64.h>
+
+#define log2(n) (fls(n) - 1)
+
+/*
+ * calculate:
+ *	Q = a / b
+ *	R = a % b
+ * by long division (repeated shift and conditional subtract)
+ * - base2 long division does not require any usage of actual division or
+ *   multiplication instructions
+ */
+u64 __udivmoddi4(u64 a, u64 b, u64 *_r)
+{
+	u64 acc, Q;
+	u32 A;
+	int M;
+
+	/* dispose of trivialities first */
+	if (b >= a) {
+		if (b == a) {
+			if (_r)
+				*_r = 0;
+			return 1;
+		}
+		if (_r)
+			*_r = a;
+		return 0;
+	}
+
+	/* divide by two until at least one argument is odd */
+	while (!((a | b) & 1)) {
+		a >>= 1;
+		b >>= 1;
+	}
+
+	/* handle it as 64-bit divide by 32-bit if we can */
+	if (b <= 0xffffffffULL) {
+		acc = do_div(a, b);
+		if (_r)
+			*_r = acc;
+		return a;
+	}
+
+	/* skip any steps that don't need to be done given the magnitude of the
+	 * divisor:
+	 * - the divisor is at least 33 bits in size (log2(b) >= 32)
+	 * - load the accumulator with as many bits of the dividend as we can
+	 * - decant the remainder into a 32-bit variable since we will have
+	 *   fewer than 32-bits remaining
+	 */
+	M = log2(b >> 32) + 32;
+	acc = a >> (63 - M);
+	A = a;
+	A <<= M - 31;
+
+	Q = 0;
+
+	for (;;) {
+		if (acc >= b) {
+			/* reduce the accumulator if we can */
+			acc -= b;
+			Q |= 1ULL;
+		}
+
+		if (M >= 63)
+			break;
+
+		/* shift next-MSB from dividend into LSB of accumulator */
+		acc = acc << 1;
+		if (A & 0x80000000U)
+			acc |= 1ULL;
+		A <<= 1;
+		Q <<= 1;
+		M++;
+	}
+
+	/* the accumulator is left holding the remainder */
+	if (_r)
+		*_r = acc;
+
+	return Q;
+}
+
+EXPORT_SYMBOL(__udivmoddi4);
diff --git a/lib/__umoddi3.c b/lib/__umoddi3.c
new file mode 100644
index 0000000..7b99757
--- /dev/null
+++ b/lib/__umoddi3.c
@@ -0,0 +1,25 @@
+/* __umoddi3.c: unsigned 64-bit by 64-bit modulus yielding 64-bit result
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/*
+ * return a % b
+ */
+u64 __umoddi3(u64 a, u64 b)
+{
+	u64 r;
+	__udivmoddi4(a, b, &r);
+	return r;
+}
+
+EXPORT_SYMBOL(__umoddi3);
