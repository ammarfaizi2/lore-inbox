Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVDVDki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVDVDki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 23:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVDVDkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 23:40:37 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34027 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261397AbVDVDkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 23:40:24 -0400
Subject: [patch 1/2] kstrdup: implementation
From: Robert Love <rml@novell.com>
To: Rusty Russell <rusty@rustcorp.com.au>, Mr Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 21 Apr 2005 23:41:15 -0400
Message-Id: <1114141276.6973.87.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty and I's LCA kernel tutorial again brought up kstrdup().  Let's
close this never ending saga and provide a standard kernel
implementation.

As an example of the savings from such a patch, there are a handful of
existing strdup() implementations and what looks like 100s of open coded
strdup() uses.  Some of which are surely buggy or less optimal than our
version, and all of which bloat the kernel.

Andrew, patch is against 2.6.12-rc3.

Best,

	Robert Love


The world continually reimplements kstrdup().  Implement an optimal version
and export it to the world.

By: Robert Love and Rusty Russell.

Signed-off-by: Robert Love <rml@novell.com>

 include/linux/string.h |    1 +
 lib/string.c           |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff -urN linux-2.6.12-rc3/include/linux/string.h linux/include/linux/string.h
--- linux-2.6.12-rc3/include/linux/string.h	2005-03-02 02:38:07.000000000 -0500
+++ linux/include/linux/string.h	2005-04-21 21:23:04.000000000 -0400
@@ -17,6 +17,7 @@
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
+extern char * kstrdup(const char *,unsigned int __nocast);
 
 /*
  * Include machine specific inline routines
diff -urN linux-2.6.12-rc3/lib/string.c linux/lib/string.c
--- linux-2.6.12-rc3/lib/string.c	2005-03-02 02:38:25.000000000 -0500
+++ linux/lib/string.c	2005-04-21 21:31:11.000000000 -0400
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
@@ -76,6 +77,25 @@
 EXPORT_SYMBOL(strcpy);
 #endif
 
+/*
+ * kstrdup - allocate space for and then copy an existing string
+ *
+ * @str: the string to duplicate
+ * @gfp: the GFP mask used to allocate the storage for the duplicated string
+ */
+char * kstrdup(const char *str, unsigned int __nocast flags)
+{
+	size_t len;
+	char *buf;
+
+	len = strlen(str) + 1;
+	buf = kmalloc(len, flags);
+	if (likely(buf))
+		memcpy(buf, str, len);
+	return buf;
+}
+EXPORT_SYMBOL(kstrdup);
+
 #ifndef __HAVE_ARCH_STRNCPY
 /**
  * strncpy - Copy a length-limited, %NUL-terminated string


