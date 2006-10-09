Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932830AbWJIOKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWJIOKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbWJIOKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:10:19 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:48895 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932830AbWJIOKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:10:18 -0400
Date: Mon, 9 Oct 2006 07:10:09 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EA9RH026023@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] 2.6.18 perfmon2 : new library support
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


This routine is now part of Andrew's tree, so this portion of the
perfmon2 patch will not be needed anymore in the next release


--- linux-2.6.18.base/lib/carta_random32.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/lib/carta_random32.c	2006-09-22 01:59:06.000000000 -0700
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
