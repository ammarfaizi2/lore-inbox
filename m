Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUDFB5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUDFB5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:57:33 -0400
Received: from ozlabs.org ([203.10.76.45]:33440 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263591AbUDFB53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:57:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16498.3704.252459.691039@cargo.ozlabs.ibm.com>
Date: Tue, 6 Apr 2004 11:57:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc2
In-Reply-To: <20040406004251.GA24918@logos.cnet>
References: <20040406004251.GA24918@logos.cnet>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Any chance of getting this patch in before 2.4.26 final?

This patch is needed for compiling 2.4 with recent versions of gcc,
such as the gcc 3.3.3 hammer branch or gcc 3.4.  The gcc developers
changed the name of the attribute that indicates that something is
actually needed, even though gcc can't see why, from "__unused__" to
"__used__".  This patch copes with that.

The patch is from Stephen Rothwell.  He discovered the problem on
ppc64, but in fact it would exist on any architecture.

Thanks,
Paul.

diff -ruN ppc64-linux-2.4/include/linux/compiler.h ppc64-linux-2.4.used/include/linux/compiler.h
--- ppc64-linux-2.4/include/linux/compiler.h	2003-08-22 12:30:56.000000000 +1000
+++ ppc64-linux-2.4.used/include/linux/compiler.h	2004-03-30 15:15:18.000000000 +1000
@@ -13,4 +13,18 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)

+#if __GNUC__ > 3
+#define __attribute_used__	__attribute((__used__))
+#elif __GNUC__ == 3
+#if  __GNUC_MINOR__ >= 3
+# define __attribute_used__	__attribute__((__used__))
+#else
+# define __attribute_used__	__attribute__((__unused__))
+#endif /* __GNUC_MINOR__ >= 3 */
+#elif __GNUC__ == 2
+#define __attribute_used__	__attribute__((__unused__))
+#else
+#define __attribute_used__	/* not implemented */
+#endif /* __GNUC__ */
+
 #endif /* __LINUX_COMPILER_H */
diff -ruN ppc64-linux-2.4/include/linux/init.h ppc64-linux-2.4.used/include/linux/init.h
--- ppc64-linux-2.4/include/linux/init.h	2003-08-22 12:30:56.000000000 +1000
+++ ppc64-linux-2.4.used/include/linux/init.h	2004-03-30 15:22:50.000000000 +1000
@@ -2,6 +2,7 @@
 #define _LINUX_INIT_H

 #include <linux/config.h>
+#include <linux/compiler.h>

 /* These macros are used to mark some functions or
  * initialized data (doesn't apply to uninitialized data)
@@ -51,7 +52,7 @@
 extern initcall_t __initcall_start, __initcall_end;

 #define __initcall(fn)								\
-	static initcall_t __initcall_##fn __init_call = fn
+	static initcall_t __initcall_##fn __attribute_used__ __init_call = fn
 #define __exitcall(fn)								\
 	static exitcall_t __exitcall_##fn __exit_call = fn

@@ -67,7 +68,7 @@

 #define __setup(str, fn)								\
 	static char __setup_str_##fn[] __initdata = str;				\
-	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
+	static struct kernel_param __setup_##fn __attribute_used__ __initsetup = { __setup_str_##fn, fn }

 #endif /* __ASSEMBLY__ */

@@ -76,12 +77,12 @@
  * or exit time.
  */
 #define __init		__attribute__ ((__section__ (".text.init")))
-#define __exit		__attribute__ ((unused, __section__(".text.exit")))
+#define __exit		__attribute_used__ __attribute__ (( __section__(".text.exit")))
 #define __initdata	__attribute__ ((__section__ (".data.init")))
-#define __exitdata	__attribute__ ((unused, __section__ (".data.exit")))
-#define __initsetup	__attribute__ ((unused,__section__ (".setup.init")))
-#define __init_call	__attribute__ ((unused,__section__ (".initcall.init")))
-#define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
+#define __exitdata	__attribute_used__ __attribute__ ((__section__ (".data.exit")))
+#define __initsetup	__attribute_used__ __attribute__ ((__section__ (".setup.init")))
+#define __init_call	__attribute_used__ __attribute__ ((__section__ (".initcall.init")))
+#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))

 /* For assembly routines */
 #define __INIT		.section	".text.init","ax"
diff -ruN ppc64-linux-2.4/include/linux/module.h ppc64-linux-2.4.used/include/linux/module.h
--- ppc64-linux-2.4/include/linux/module.h	2003-08-22 12:30:56.000000000 +1000
+++ ppc64-linux-2.4.used/include/linux/module.h	2004-03-30 15:24:25.000000000 +1000
@@ -254,9 +254,9 @@
  */
 #define MODULE_GENERIC_TABLE(gtype,name)	\
 static const unsigned long __module_##gtype##_size \
-  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
+  __attribute_used__ = sizeof(struct gtype##_id); \
 static const struct gtype##_id * __module_##gtype##_table \
-  __attribute__ ((unused)) = name
+  __attribute_used__ = name

 /*
  * The following license idents are currently accepted as indicating free
@@ -319,7 +319,7 @@
  */
 #define MODULE_GENERIC_TABLE(gtype,name) \
 static const struct gtype##_id * __module_##gtype##_table \
-  __attribute__ ((unused, __section__(".data.exit"))) = name
+  __attribute_used__ __attribute__ ((__section__(".data.exit"))) = name

 #ifndef __GENKSYMS__
