Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbUC3PRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUC3PRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:17:51 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:8600 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263716AbUC3PQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:16:18 -0500
Date: Wed, 31 Mar 2004 01:15:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] make 2.4 boot when built with gcc 3.4
Message-Id: <20040331011511.6ac33953.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__31_Mar_2004_01_15_11_+1000_nImuURlfFDYM_q+i"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__31_Mar_2004_01_15_11_+1000_nImuURlfFDYM_q+i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all,

Below is a back port of __attribute_used__ from 2.6 that is needed
(at least on PPC64 iSeries) so that a kernel built with gcc hammer branch
(or 3.4 ...) will actually boot.

Please consider and comment (derision not preferred :-))

I have been told that using -fno-unit-at-a-time is an alternative
to this.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.26-rc1/include/linux/compiler.h 2.4.26-rc1.hammer/include/linux/compiler.h
--- 2.4.26-rc1/include/linux/compiler.h	2001-10-25 11:29:44.000000000 +1000
+++ 2.4.26-rc1.hammer/include/linux/compiler.h	2004-03-30 23:55:36.000000000 +1000
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
diff -ruN 2.4.26-rc1/include/linux/init.h 2.4.26-rc1.hammer/include/linux/init.h
--- 2.4.26-rc1/include/linux/init.h	2001-12-22 07:13:38.000000000 +1100
+++ 2.4.26-rc1.hammer/include/linux/init.h	2004-03-31 00:00:48.000000000 +1000
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
diff -ruN 2.4.26-rc1/include/linux/module.h 2.4.26-rc1.hammer/include/linux/module.h
--- 2.4.26-rc1/include/linux/module.h	2002-08-03 11:17:57.000000000 +1000
+++ 2.4.26-rc1.hammer/include/linux/module.h	2004-03-31 00:00:51.000000000 +1000
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
 

--Signature=_Wed__31_Mar_2004_01_15_11_+1000_nImuURlfFDYM_q+i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAaY7/FG47PeJeR58RApnDAJ9pWHUWbrRkKzJSlHA2TwGFzjSqZgCfQHTt
8bPZYihglJLxPiW3GBXQmfA=
=A2V5
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Mar_2004_01_15_11_+1000_nImuURlfFDYM_q+i--
