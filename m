Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSG1P3S>; Sun, 28 Jul 2002 11:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSG1P2d>; Sun, 28 Jul 2002 11:28:33 -0400
Received: from mnh-1-03.mv.com ([207.22.10.35]:33540 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317058AbSG1P1K>;
	Sun, 28 Jul 2002 11:27:10 -0400
Message-Id: <200207281633.LAA06298@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: [PATCH] UML - part 1 of 3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Jul 2002 11:33:58 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This a preparatory patch which allows UML to avoid changing linux/linkage.h.

It restructures linkage.h so that all of the arch-specific stuff is in
asm-*/linkage.h.  linux/linkage.h is now arch independent.  It should be
functionally unchanged.

Five arches, i386, ia64, sh, m68k, and arm, have non-empty linkage.h files.
The other arch linkage.h files are all empty.

Also, __ALIGN_STR is no longer defined independently of __ALIGN.  It is now
derived by stringizing __ALIGN.

				Jeff

diff -Naur orig/include/linux/linkage.h linus/include/linux/linkage.h
--- orig/include/linux/linkage.h	Sun Jul 14 14:10:17 2002
+++ linus/include/linux/linkage.h	Sun Jul 28 00:27:38 2002
@@ -2,6 +2,7 @@
 #define _LINUX_LINKAGE_H
 
 #include <linux/config.h>
+#include <asm/linkage.h>
 
 #ifdef __cplusplus
 #define CPP_ASMLINKAGE extern "C"
@@ -9,36 +10,23 @@
 #define CPP_ASMLINKAGE
 #endif
 
-#if defined __i386__
-#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
-#elif defined __ia64__
-#define asmlinkage CPP_ASMLINKAGE __attribute__((syscall_linkage))
-#else
+#ifndef asmlinkage
 #define asmlinkage CPP_ASMLINKAGE
 #endif
 
-#ifdef __arm__
-#define __ALIGN .align 0
-#define __ALIGN_STR ".align 0"
-#else
-#ifdef __mc68000__
-#define __ALIGN .align 4
-#define __ALIGN_STR ".align 4"
-#else
-#ifdef __sh__
-#define __ALIGN .balign 4
-#define __ALIGN_STR ".balign 4"
-#else
-#if defined(__i386__) && defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN .align 16,0x90
-#define __ALIGN_STR ".align 16,0x90"
-#else
+#ifndef __ALIGN
 #define __ALIGN .align 4,0x90
-#define __ALIGN_STR ".align 4,0x90"
 #endif
-#endif /* __sh__ */
-#endif /* __mc68000__ */
-#endif /* __arm__ */
+
+/* The "..." is gcc's cpp vararg macro syntax.  It is required because __ALIGN
+ * contains a comma, which when expanded, causes it to look like two arguments,
+ * which breaks the standard stringizing macros.
+ */
+
+#define __STR(...) #__VA_ARGS__
+#define STR(...) __STR(__VA_ARGS__)
+
+#define __ALIGN_STR STR(__ALIGN)
 
 #ifdef __ASSEMBLY__
 
@@ -52,13 +40,11 @@
 
 #endif
 
-# define NORET_TYPE    /**/
-# define ATTRIB_NORET  __attribute__((noreturn))
-# define NORET_AND     noreturn,
+#define NORET_TYPE    /**/
+#define ATTRIB_NORET  __attribute__((noreturn))
+#define NORET_AND     noreturn,
 
-#ifdef __i386__
-#define FASTCALL(x)	x __attribute__((regparm(3)))
-#else
+#ifndef FASTCALL
 #define FASTCALL(x)	x
 #endif
 
diff -Naur orig/include/asm-i386/linkage.h linus/include/asm-i386/linkage.h
--- orig/include/asm-i386/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-i386/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,11 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
+#define FASTCALL(x)	x __attribute__((regparm(3)))
+
+#ifdef CONFIG_X86_ALIGNMENT_16
+#define __ALIGN .align 16,0x90
+#endif
+
+#endif
diff -Naur orig/include/asm-ia64/linkage.h linus/include/asm-ia64/linkage.h
--- orig/include/asm-ia64/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-ia64/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define asmlinkage CPP_ASMLINKAGE __attribute__((syscall_linkage))
+
+#endif
diff -Naur orig/include/asm-m68k/linkage.h linus/include/asm-m68k/linkage.h
--- orig/include/asm-m68k/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-m68k/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define __ALIGN .align 4
+
+#endif
diff -Naur orig/include/asm-arm/linkage.h linus/include/asm-arm/linkage.h
--- orig/include/asm-arm/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-arm/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define __ALIGN .align 0
+
+#endif
diff -Naur orig/include/asm-alpha/linkage.h linus/include/asm-alpha/linkage.h
--- orig/include/asm-alpha/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-alpha/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-cris/linkage.h linus/include/asm-cris/linkage.h
--- orig/include/asm-cris/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-cris/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-mips/linkage.h linus/include/asm-mips/linkage.h
--- orig/include/asm-mips/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-mips/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-mips64/linkage.h linus/include/asm-mips64/linkage.h
--- orig/include/asm-mips64/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-mips64/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-parisc/linkage.h linus/include/asm-parisc/linkage.h
--- orig/include/asm-parisc/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-parisc/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-ppc/linkage.h linus/include/asm-ppc/linkage.h
--- orig/include/asm-ppc/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-ppc/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-ppc64/linkage.h linus/include/asm-ppc64/linkage.h
--- orig/include/asm-ppc64/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-ppc64/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-s390/linkage.h linus/include/asm-s390/linkage.h
--- orig/include/asm-s390/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-s390/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-s390x/linkage.h linus/include/asm-s390x/linkage.h
--- orig/include/asm-s390x/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-s390x/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-sh/linkage.h linus/include/asm-sh/linkage.h
--- orig/include/asm-sh/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-sh/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define __ALIGN .balign 4
+
+#endif
diff -Naur orig/include/asm-sparc/linkage.h linus/include/asm-sparc/linkage.h
--- orig/include/asm-sparc/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-sparc/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-sparc64/linkage.h linus/include/asm-sparc64/linkage.h
--- orig/include/asm-sparc64/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-sparc64/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif
diff -Naur orig/include/asm-x86_64/linkage.h linus/include/asm-x86_64/linkage.h
--- orig/include/asm-x86_64/linkage.h	Wed Dec 31 19:00:00 1969
+++ linus/include/asm-x86_64/linkage.h	Sun Jul 28 00:27:38 2002
@@ -0,0 +1,6 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif

