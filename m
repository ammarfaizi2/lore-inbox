Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWJDX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWJDX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJDX06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:26:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:23169 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751233AbWJDX0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:26:30 -0400
Message-Id: <20061004232455.402668000@linux-m68k.org>
References: <20061004232414.730831000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 05 Oct 2006 01:24:16 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] m68k: cleanup string functions
Content-Disposition: inline; filename=string
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- cleanup asm of string functions
- deinline strncat()/strncmp()
- provide non-inlined strcpy()

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 arch/m68k/kernel/m68k_ksyms.c |    4 
 arch/m68k/lib/string.c        |   15 +++
 include/asm-m68k/string.h     |  194 ++++++++++++++++++------------------------
 3 files changed, 100 insertions(+), 113 deletions(-)

Index: linux-2.6/arch/m68k/kernel/m68k_ksyms.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/m68k_ksyms.c
+++ linux-2.6/arch/m68k/kernel/m68k_ksyms.c
@@ -1,7 +1,6 @@
 #include <linux/module.h>
 #include <linux/linkage.h>
 #include <linux/sched.h>
-#include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/user.h>
 #include <linux/elfcore.h>
@@ -53,9 +52,6 @@ EXPORT_SYMBOL(mach_beep);
 #endif
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_thread);
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(kernel_thread);
 #ifdef CONFIG_VME
 EXPORT_SYMBOL(vme_brdtype);
Index: linux-2.6/arch/m68k/lib/string.c
===================================================================
--- linux-2.6.orig/arch/m68k/lib/string.c
+++ linux-2.6/arch/m68k/lib/string.c
@@ -1,6 +1,19 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#define __IN_STRING_C
 
-#include <linux/types.h>
 #include <linux/module.h>
+#include <linux/string.h>
+
+char *strcpy(char *dest, const char *src)
+{
+	return __kernel_strcpy(dest, src);
+}
+EXPORT_SYMBOL(strcpy);
 
 void *memset(void *s, int c, size_t count)
 {
Index: linux-2.6/include/asm-m68k/string.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/string.h
+++ linux-2.6/include/asm-m68k/string.h
@@ -1,138 +1,114 @@
 #ifndef _M68K_STRING_H_
 #define _M68K_STRING_H_
 
-#include <asm/setup.h>
-#include <asm/page.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
 
-#define __HAVE_ARCH_STRCPY
-static inline char * strcpy(char * dest,const char *src)
+static inline size_t __kernel_strlen(const char *s)
 {
-  char *xdest = dest;
+	const char *sc;
 
-  __asm__ __volatile__
-       ("1:\tmoveb %1@+,%0@+\n\t"
-        "jne 1b"
-	: "=a" (dest), "=a" (src)
-        : "0" (dest), "1" (src) : "memory");
-  return xdest;
+	for (sc = s; *sc++; )
+		;
+	return sc - s - 1;
 }
 
-#define __HAVE_ARCH_STRNCPY
-static inline char * strncpy(char *dest, const char *src, size_t n)
+static inline char *__kernel_strcpy(char *dest, const char *src)
 {
-  char *xdest = dest;
+	char *xdest = dest;
 
-  if (n == 0)
-    return xdest;
-
-  __asm__ __volatile__
-       ("1:\tmoveb %1@+,%0@+\n\t"
-	"jeq 2f\n\t"
-        "subql #1,%2\n\t"
-        "jne 1b\n\t"
-        "2:"
-        : "=a" (dest), "=a" (src), "=d" (n)
-        : "0" (dest), "1" (src), "2" (n)
-        : "memory");
-  return xdest;
+	asm volatile ("\n"
+		"1:	move.b	(%1)+,(%0)+\n"
+		"	jne	1b"
+		: "+a" (dest), "+a" (src)
+		: : "memory");
+	return xdest;
 }
 
-#define __HAVE_ARCH_STRCAT
-static inline char * strcat(char * dest, const char * src)
-{
-	char *tmp = dest;
-
-	while (*dest)
-		dest++;
-	while ((*dest++ = *src++))
-		;
+#ifndef __IN_STRING_C
 
-	return tmp;
+#define __HAVE_ARCH_STRLEN
+#define strlen(s)	(__builtin_constant_p(s) ?	\
+			 __builtin_strlen(s) :		\
+			 __kernel_strlen(s))
+
+#define __HAVE_ARCH_STRNLEN
+static inline size_t strnlen(const char *s, size_t count)
+{
+	const char *sc = s;
+
+	asm volatile ("\n"
+		"1:     subq.l  #1,%1\n"
+		"       jcs     2f\n"
+		"       tst.b   (%0)+\n"
+		"       jne     1b\n"
+		"       subq.l  #1,%0\n"
+		"2:"
+		: "+a" (sc), "+d" (count));
+	return sc - s;
 }
 
-#define __HAVE_ARCH_STRNCAT
-static inline char * strncat(char *dest, const char *src, size_t count)
-{
-	char *tmp = dest;
-
-	if (count) {
-		while (*dest)
-			dest++;
-		while ((*dest++ = *src++)) {
-			if (--count == 0) {
-				*dest++='\0';
-				break;
-			}
-		}
-	}
-
-	return tmp;
-}
+#define __HAVE_ARCH_STRCPY
+#if __GNUC__ >= 4
+#define strcpy(d, s)	(__builtin_constant_p(s) &&	\
+			 __builtin_strlen(s) <= 32 ?	\
+			 __builtin_strcpy(d, s) :	\
+			 __kernel_strcpy(d, s))
+#else
+#define strcpy(d, s)	__kernel_strcpy(d, s)
+#endif
 
-#define __HAVE_ARCH_STRCHR
-static inline char * strchr(const char * s, int c)
+#define __HAVE_ARCH_STRNCPY
+static inline char *strncpy(char *dest, const char *src, size_t n)
 {
-  const char ch = c;
+	char *xdest = dest;
 
-  for(; *s != ch; ++s)
-    if (*s == '\0')
-      return( NULL );
-  return( (char *) s);
+	asm volatile ("\n"
+		"	jra	2f\n"
+		"1:	move.b	(%1),(%0)+\n"
+		"	jeq	2f\n"
+		"	addq.l	#1,%1\n"
+		"2:	subq.l	#1,%2\n"
+		"	jcc	1b\n"
+		: "+a" (dest), "+a" (src), "+d" (n)
+		: : "memory");
+	return xdest;
 }
 
-/* strstr !! */
+#define __HAVE_ARCH_STRCAT
+#define strcat(d, s)	({			\
+	char *__d = (d);			\
+	strcpy(__d + strlen(__d), (s));		\
+})
 
-#define __HAVE_ARCH_STRLEN
-static inline size_t strlen(const char * s)
+#define __HAVE_ARCH_STRCHR
+static inline char *strchr(const char *s, int c)
 {
-  const char *sc;
-  for (sc = s; *sc != '\0'; ++sc) ;
-  return(sc - s);
-}
+	char sc, ch = c;
 
-/* strnlen !! */
+	for (; (sc = *s++) != ch; ) {
+		if (!sc)
+			return NULL;
+	}
+	return (char *)s - 1;
+}
 
 #define __HAVE_ARCH_STRCMP
-static inline int strcmp(const char * cs,const char * ct)
+static inline int strcmp(const char *cs, const char *ct)
 {
-  char __res;
+	char res;
 
-  __asm__
-       ("1:\tmoveb %0@+,%2\n\t" /* get *cs */
-        "cmpb %1@+,%2\n\t"      /* compare a byte */
-        "jne  2f\n\t"           /* not equal, break out */
-        "tstb %2\n\t"           /* at end of cs? */
-        "jne  1b\n\t"           /* no, keep going */
-        "jra  3f\n\t"		/* strings are equal */
-        "2:\tsubb %1@-,%2\n\t"  /* *cs - *ct */
-        "3:"
-        : "=a" (cs), "=a" (ct), "=d" (__res)
-        : "0" (cs), "1" (ct));
-  return __res;
-}
-
-#define __HAVE_ARCH_STRNCMP
-static inline int strncmp(const char * cs,const char * ct,size_t count)
-{
-  char __res;
-
-  if (!count)
-    return 0;
-  __asm__
-       ("1:\tmovb %0@+,%3\n\t"          /* get *cs */
-        "cmpb   %1@+,%3\n\t"            /* compare a byte */
-        "jne    3f\n\t"                 /* not equal, break out */
-        "tstb   %3\n\t"                 /* at end of cs? */
-        "jeq    4f\n\t"                 /* yes, all done */
-        "subql  #1,%2\n\t"              /* no, adjust count */
-        "jne    1b\n\t"                 /* more to do, keep going */
-        "2:\tmoveq #0,%3\n\t"           /* strings are equal */
-        "jra    4f\n\t"
-        "3:\tsubb %1@-,%3\n\t"          /* *cs - *ct */
-        "4:"
-        : "=a" (cs), "=a" (ct), "=d" (count), "=d" (__res)
-        : "0" (cs), "1" (ct), "2" (count));
-  return __res;
+	asm ("\n"
+		"1:	move.b	(%0)+,%2\n"	/* get *cs */
+		"	cmp.b	(%1)+,%2\n"	/* compare a byte */
+		"	jne	2f\n"		/* not equal, break out */
+		"	tst.b	%2\n"		/* at end of cs? */
+		"	jne	1b\n"		/* no, keep going */
+		"	jra	3f\n"		/* strings are equal */
+		"2:	sub.b	-(%1),%2\n"	/* *cs - *ct */
+		"3:"
+		: "+a" (cs), "+a" (ct), "=d" (res));
+	return res;
 }
 
 #define __HAVE_ARCH_MEMSET
@@ -150,4 +126,6 @@ extern void *memmove(void *, const void 
 extern int memcmp(const void *, const void *, __kernel_size_t);
 #define memcmp(d, s, n) __builtin_memcmp(d, s, n)
 
+#endif
+
 #endif /* _M68K_STRING_H_ */

--

