Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTBTAZg>; Wed, 19 Feb 2003 19:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTBTAZg>; Wed, 19 Feb 2003 19:25:36 -0500
Received: from dp.samba.org ([66.70.73.150]:60838 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262807AbTBTAZf>;
	Wed, 19 Feb 2003 19:25:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-reply-to: Your message of "Tue, 18 Feb 2003 22:16:56 -0800."
             <20030218221656.A23989@twiddle.net> 
Date: Thu, 20 Feb 2003 11:01:50 +1100
Message-Id: <20030220003539.8E5E02C25B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030218221656.A23989@twiddle.net> you write:
> gcc version 2.95.4 20011002 (Debian prerelease)
> 
> Seems to work, both wrt the warning message and 
> honoring the section directive.

Excellent.  For Linus's (and Kai's) benefit, this is Richard's patch
again.  Thanks Richard!

From: Richard Henderson <rth@twiddle.net>

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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
