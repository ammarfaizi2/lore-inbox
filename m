Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSHCCfM>; Fri, 2 Aug 2002 22:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSHCCfM>; Fri, 2 Aug 2002 22:35:12 -0400
Received: from mnh-1-14.mv.com ([207.22.10.46]:10502 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317429AbSHCCfH>;
	Fri, 2 Aug 2002 22:35:07 -0400
Message-Id: <200208030340.WAA05687@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: [PATCH] UML - part 1 of 3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 22:40:50 -0500
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

Following a suggestion by Keith Owens, stringify.h was generalized to allow
commas in its argument, linkage.h now includes it, and no longer defines its
own stringify macros.

				Jeff

diff -Naur orig/include/linux/linkage.h linus/include/linux/linkage.h
--- orig/include/linux/linkage.h	Sun Jul 14 14:10:17 2002
+++ linus/include/linux/linkage.h	Fri Aug  2 22:06:06 2002
@@ -2,6 +2,8 @@
 #define _LINUX_LINKAGE_H
 
 #include <linux/config.h>
+#include <linux/stringify.h>
+#include <asm/linkage.h>
 
 #ifdef __cplusplus
 #define CPP_ASMLINKAGE extern "C"
@@ -9,36 +11,15 @@
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
+#define __ALIGN_STR __stringify(__ALIGN)
 
 #ifdef __ASSEMBLY__
 
@@ -52,13 +33,11 @@
 
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
 
diff -Naur orig/include/linux/stringify.h linus/include/linux/stringify.h
--- orig/include/linux/stringify.h	Thu Jul 11 16:35:26 2002
+++ linus/include/linux/stringify.h	Fri Aug  2 22:06:06 2002
@@ -4,9 +4,13 @@
 /* Indirect stringification.  Doing two levels allows the parameter to be a
  * macro itself.  For example, compile with -DFOO=bar, __stringify(FOO)
  * converts to "bar".
+ *
+ * The "..." is gcc's cpp vararg macro syntax.  It is required because __ALIGN,
+ * in linkage.h, contains a comma, which when expanded, causes it to look 
+ * like two arguments, which breaks the standard non-vararg stringizer.
  */
 
-#define __stringify_1(x)	#x
-#define __stringify(x)		__stringify_1(x)
+#define __stringify_1(...)	#__VA_ARGS__
+#define __stringify(...)	__stringify_1(__VA_ARGS__)
 
 #endif	/* !__LINUX_STRINGIFY_H */
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

