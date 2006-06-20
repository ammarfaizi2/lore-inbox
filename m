Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWFTX5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWFTX5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWFTX5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:57:14 -0400
Received: from gw.goop.org ([64.81.55.164]:45187 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751027AbWFTX5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:57:14 -0400
Message-ID: <44988B5C.9080400@goop.org>
Date: Tue, 20 Jun 2006 16:57:16 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] Implement kasprintf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Fitzhardinge <jeremy@xensource.com>

Implement kasprintf, a kernel version of asprintf.  This allocates the
memory required for the formatted string, including the trailing '\0'.
Returns NULL on allocation failure.

Requires vsnprintf to accept a NULL buffer when the buffer size is 0.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 include/linux/kernel.h |    2 +
 lib/Makefile           |    2 -
 lib/kasprintf.c        |   54 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)


diff -r c175fd50e604 include/linux/kernel.h
--- a/include/linux/kernel.h	Tue Jun 20 16:47:53 2006 -0700
+++ b/include/linux/kernel.h	Tue Jun 20 16:53:19 2006 -0700
@@ -114,6 +114,8 @@ extern int scnprintf(char * buf, size_t 
 	__attribute__ ((format (printf, 3, 4)));
 extern int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 	__attribute__ ((format (printf, 3, 0)));
+extern char *kasprintf(gfp_t gfp, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
 
 extern int sscanf(const char *, const char *, ...)
 	__attribute__ ((format (scanf, 2, 3)));
diff -r c175fd50e604 lib/Makefile
--- a/lib/Makefile	Tue Jun 20 16:47:53 2006 -0700
+++ b/lib/Makefile	Tue Jun 20 16:53:19 2006 -0700
@@ -5,7 +5,7 @@ lib-y := errno.o ctype.o string.o vsprin
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o kasprintf.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
diff -r c175fd50e604 lib/kasprintf.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/lib/kasprintf.c	Tue Jun 20 16:53:19 2006 -0700
@@ -0,0 +1,54 @@
+/******************************************************************************
+ * Simplified asprintf.
+ *
+ * Copyright (C) 2006 XenSource Ltd
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+/* Simplified asprintf. */
+char *kasprintf(gfp_t gfp, const char *fmt, ...)
+{
+	va_list ap;
+	unsigned int len;
+	char *p;
+
+	va_start(ap, fmt);
+	len = vsnprintf(NULL, 0, fmt, ap);
+	va_end(ap);
+
+	p = kmalloc(len+1, gfp);
+	if (!p)
+		return NULL;
+	va_start(ap, fmt);
+	vsnprintf(p, len+1, fmt, ap);
+	va_end(ap);
+	return p;
+}
+EXPORT_SYMBOL(kasprintf);


