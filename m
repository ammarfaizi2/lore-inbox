Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268202AbTALCdA>; Sat, 11 Jan 2003 21:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268203AbTALCdA>; Sat, 11 Jan 2003 21:33:00 -0500
Received: from users.ccur.com ([208.248.32.211]:14852 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S268202AbTALCc5>;
	Sat, 11 Jan 2003 21:32:57 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301120241.CAA16791@rudolph.ccur.com>
Subject: [PATCH] some large create_module(2) sizes can oops a kernel
To: trivial@rustcorp.com.au
Date: Sat, 11 Jan 2003 21:41:36 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty aka trivial patch monkey, everyone,

The 2.4 kernel will oops when create_module(2) is passed a size of
-1, -2, or any size larger than num_physpages.  The following patch
is one of the many simple ways to fix this.  Please consider it or
some variant for inclusion in 2.4.

I mention this issue only because the kernel should not be panic-able
based on user input to system services.

This patch leaves unfixed the sparc64, x86_64, and generic
architectures.  Only the i386 was tested.

Regards,
Joe



diff -ur 2.4.21-pre3/include/asm-alpha/module.h 2.4.21-pre3-jak/include/asm-alpha/module.h
--- 2.4.21-pre3/include/asm-alpha/module.h	2001-09-13 18:21:32.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-alpha/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the alpha architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	alpha_module_init(x)
 #define arch_init_modules(x)	alpha_init_modules(x)
diff -ur 2.4.21-pre3/include/asm-arm/module.h 2.4.21-pre3-jak/include/asm-arm/module.h
--- 2.4.21-pre3/include/asm-arm/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-arm/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the arm architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-cris/module.h 2.4.21-pre3-jak/include/asm-cris/module.h
--- 2.4.21-pre3/include/asm-cris/module.h	2001-10-08 14:43:54.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-cris/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the CRIS architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)    do { } while (0)
diff -ur 2.4.21-pre3/include/asm-i386/module.h 2.4.21-pre3-jak/include/asm-i386/module.h
--- 2.4.21-pre3/include/asm-i386/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-i386/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the i386 architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
Only in 2.4.21-pre3-jak/include/asm-i386: module.h.orig
diff -ur 2.4.21-pre3/include/asm-ia64/module.h 2.4.21-pre3-jak/include/asm-ia64/module.h
--- 2.4.21-pre3/include/asm-ia64/module.h	2002-11-28 18:53:15.000000000 -0500
+++ 2.4.21-pre3-jak/include/asm-ia64/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -11,7 +11,7 @@
 #include <linux/vmalloc.h>
 #include <asm/unwind.h>
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		ia64_module_unmap(x)
 #define module_arch_init(x)	ia64_module_init(x)
 
diff -ur 2.4.21-pre3/include/asm-m68k/module.h 2.4.21-pre3-jak/include/asm-m68k/module.h
--- 2.4.21-pre3/include/asm-m68k/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-m68k/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the m68k architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-mips/module.h 2.4.21-pre3-jak/include/asm-mips/module.h
--- 2.4.21-pre3/include/asm-mips/module.h	2001-09-09 13:43:01.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-mips/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	mips_module_init(x)
 #define arch_init_modules(x)	mips_init_modules(x)
diff -ur 2.4.21-pre3/include/asm-mips64/module.h 2.4.21-pre3-jak/include/asm-mips64/module.h
--- 2.4.21-pre3/include/asm-mips64/module.h	2001-09-09 13:43:02.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-mips64/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	mips64_module_init(x)
 #define arch_init_modules(x)	mips64_init_modules(x)
diff -ur 2.4.21-pre3/include/asm-parisc/module.h 2.4.21-pre3-jak/include/asm-parisc/module.h
--- 2.4.21-pre3/include/asm-parisc/module.h	2002-11-28 18:53:15.000000000 -0500
+++ 2.4.21-pre3-jak/include/asm-parisc/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the parisc architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-ppc/module.h 2.4.21-pre3-jak/include/asm-ppc/module.h
--- 2.4.21-pre3/include/asm-ppc/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-ppc/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -7,7 +7,7 @@
  * This file contains the PPC architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-ppc64/module.h 2.4.21-pre3-jak/include/asm-ppc64/module.h
--- 2.4.21-pre3/include/asm-ppc64/module.h	2002-08-02 20:39:45.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-ppc64/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -11,7 +11,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define arch_init_modules(x)	do { } while (0)
 #define module_arch_init(x)  (0)
diff -ur 2.4.21-pre3/include/asm-s390/module.h 2.4.21-pre3-jak/include/asm-s390/module.h
--- 2.4.21-pre3/include/asm-s390/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-s390/module.h	2003-01-11 20:51:39.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the s390 architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-s390x/module.h 2.4.21-pre3-jak/include/asm-s390x/module.h
--- 2.4.21-pre3/include/asm-s390x/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-s390x/module.h	2003-01-11 20:51:40.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the s390 architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-sh/module.h 2.4.21-pre3-jak/include/asm-sh/module.h
--- 2.4.21-pre3/include/asm-sh/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-sh/module.h	2003-01-11 20:51:40.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the SH architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
diff -ur 2.4.21-pre3/include/asm-sparc/module.h 2.4.21-pre3-jak/include/asm-sparc/module.h
--- 2.4.21-pre3/include/asm-sparc/module.h	2001-09-13 19:33:03.000000000 -0400
+++ 2.4.21-pre3-jak/include/asm-sparc/module.h	2003-01-11 20:51:40.000000000 -0500
@@ -4,7 +4,7 @@
  * This file contains the sparc architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
+#define module_map(x)		(((size >> PAGE_SHIFT) > num_physpages) ? NULL : vmalloc(x))
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
