Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267849AbTBSCdY>; Tue, 18 Feb 2003 21:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267886AbTBSCdX>; Tue, 18 Feb 2003 21:33:23 -0500
Received: from are.twiddle.net ([64.81.246.98]:5018 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267849AbTBSCdW>;
	Tue, 18 Feb 2003 21:33:22 -0500
Date: Tue, 18 Feb 2003 18:43:17 -0800
From: Richard Henderson <rth@twiddle.net>
To: torvalds@transmeta.com, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eliminate warnings in generated module files
Message-ID: <20030218184317.A20436@twiddle.net>
Mail-Followup-To: torvalds@transmeta.com, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler.h fragment should describe the problem well enough.



r~



===== include/linux/compiler.h 1.10 vs edited =====
--- 1.10/include/linux/compiler.h	Tue Dec 31 15:10:18 2002
+++ edited/include/linux/compiler.h	Tue Feb 18 17:39:38 2003
@@ -25,6 +25,23 @@
 #define __deprecated
 #endif
 
+/*
+ * Allow us to avoid 'defined but not used' warnings on functions and data,
+ * as well as force them to be emitted to the assembly file.
+ *
+ * As of gcc 3.3, static functions that are not marked with attribute((used))
+ * may be elided from the assembly file.  As of gcc 3.3, static data not so
+ * marked will not be elided, but this may change in a future gcc version.
+ *
+ * In prior versions of gcc, such functions and data would be emitted, but
+ * would be warned about except with attribute((unused)).
+ */
+#if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
+#define __attribute_used__	__attribute__((__used__))
+#else
+#define __attribute_used__	__attribute__((__unused__))
+#endif
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\
===== scripts/modpost.c 1.7 vs edited =====
--- 1.7/scripts/modpost.c	Sun Feb 16 17:42:07 2003
+++ edited/scripts/modpost.c	Tue Feb 18 17:41:54 2003
@@ -384,6 +384,7 @@
 {
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
+	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "const char vermagic[]\n");
 	buf_printf(b, "__attribute__((section(\"__vermagic\"))) =\n");
@@ -449,6 +450,7 @@
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const char __module_depends[]\n");
+	buf_printf(b, "__attribute_used__\n");
 	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
 	buf_printf(b, "\"depends=");
 	for (s = mod->unres; s; s = s->next) {
