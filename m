Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVARTiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVARTiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVARTg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:36:29 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:62602 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261406AbVARTff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:35:35 -0500
Message-Id: <20050118192608.655088000.suse.de>
References: <20050118184123.729034000.suse.de>
Date: Tue, 18 Jan 2005 19:41:23 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [kbuild 5/5] Dont include absolute filenames in binaries
Content-Disposition: inline; filename=remove-buildenv-paths-from-binaries.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild utilities are compiled with absolute patch names, so paths
starting with $RPM_BUILD_ROOT would end up in the binaries.  To avoid
this, remove all references to __FILE__ (directly and indirectly via
assert()).

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc1-bk6/scripts/genksyms/genksyms.h
===================================================================
--- linux-2.6.11-rc1-bk6.orig/scripts/genksyms/genksyms.h
+++ linux-2.6.11-rc1-bk6/scripts/genksyms/genksyms.h
@@ -25,7 +25,6 @@
 #define MODUTILS_GENKSYMS_H 1
 
 #include <stdio.h>
-#include <assert.h>
 
 
 enum symbol_type
@@ -89,8 +88,17 @@ void error_with_pos(const char *, ...);
 
 #define MODUTILS_VERSION "<in-kernel>"
 
-#define xmalloc(size) ({ void *__ptr = malloc(size); assert(__ptr || size == 0); __ptr; })
-#define xstrdup(str)  ({ char *__str = strdup(str); assert(__str); __str; })
-
+#define xmalloc(size) ({ void *__ptr = malloc(size);		\
+	if(!__ptr && size != 0) {				\
+		fprintf(stderr, "out of memory\n");		\
+		exit(1);					\
+	}							\
+	__ptr; })
+#define xstrdup(str)  ({ char *__str = strdup(str);		\
+	if (!__str) {						\
+		fprintf(stderr, "out of memory\n");		\
+		exit(1);					\
+	}							\
+	__str; })
 
 #endif /* genksyms.h */
Index: linux-2.6.11-rc1-bk6/scripts/mod/modpost.c
===================================================================
--- linux-2.6.11-rc1-bk6.orig/scripts/mod/modpost.c
+++ linux-2.6.11-rc1-bk6/scripts/mod/modpost.c
@@ -47,11 +47,10 @@ warn(const char *fmt, ...)
 	va_end(arglist);
 }
 
-void *do_nofail(void *ptr, const char *file, int line, const char *expr)
+void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr) {
-		fatal("Memory allocation failure %s line %d: %s.\n",
-		      file, line, expr);
+		fatal("Memory allocation failure: %s.\n", expr);
 	}
 	return ptr;
 }
Index: linux-2.6.11-rc1-bk6/scripts/mod/modpost.h
===================================================================
--- linux-2.6.11-rc1-bk6.orig/scripts/mod/modpost.h
+++ linux-2.6.11-rc1-bk6/scripts/mod/modpost.h
@@ -53,8 +53,8 @@ static inline void __endian(const void *
 
 #endif
 
-#define NOFAIL(ptr)   do_nofail((ptr), __FILE__, __LINE__, #ptr)
-void *do_nofail(void *ptr, const char *file, int line, const char *expr);
+#define NOFAIL(ptr)   do_nofail((ptr), #ptr)
+void *do_nofail(void *ptr, const char *expr);
 
 struct buffer {
 	char *p;

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

