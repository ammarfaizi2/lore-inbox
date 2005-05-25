Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVEYIoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVEYIoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 04:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEYIo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 04:44:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4013 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261486AbVEYIne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 04:43:34 -0400
Date: Wed, 25 May 2005 09:43:32 +0100
From: arjan@pentafluge.infradead.org
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Add "FORTIFY_SOURCE" to the linux kernel
Message-ID: <20050525084332.GA16865@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In recent Fedora Core and RHEL distributions, gcc and glibc have a feature
called FORTIFY_SOURCE. In a nutshell, for code like

void foo(char *string)
{
	char buf[20];
	strcpy(buf, string);
}

gcc *knows* that buf is 20 bytes in size. glibc in turn gets this knowledge
from gcc (via a __builtin function) and will use a version of strcpy() that
checks and makes sure that never more than 20 bytes are copied, and that
abort()s the program if it was asked to do so anyway.

The patch below is an initial attempt to "port" this new functionality to
the kernel. In this patch, the following functions are using this
functionality:
strcpy(), strncpy(), strcat(), strncat(), memcpy(), memset(), copy_from_user()
some other functions aren't converted yet, most notably the "l" variants of
the string functions.

The way this works is that when gcc doesn't know the size of the buffer, or
if it can be proven that there never is an overflow, there is no overhead or
change in existing functionality.

One could argue that instead of doing this, all the places where this code
triggers should be fixed to be provably not overflowing. I'm open to
discussion on this as well; the tests in the patch trigger in about 50
places for a vmlinux, so it's not an impossible task to fix all. On the
other hand, fixing all future ones would be an ongoing task..


The gcc patch for this is not yet commited to the mainline branch of gcc;
however it is listed on the gcc wiki as slated for 4.1 and work is ongoing.
As a result of this, the #ifdef's in the compiler.h files are a bit nasty
for now, just to allow people who have a compiler with this support already
to test and use this patch. (The compilers from Fedora Core 3, Fedora Core 4
and Red Hat Enterprise Linux 4 have the needed infrastructure. I'm not aware
of other distribution gcc's to have this feature at present; if there are
please let me know)


The work on the ppc bits was done by David Woodhouse.





Signed-Off-By: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.12-rc5/include/asm-i386/string.h linux-fortify/include/asm-i386/string.h
--- linux-2.6.12-rc5/include/asm-i386/string.h	2005-05-25 10:10:45.000000000 +0200
+++ linux-fortify/include/asm-i386/string.h	2005-05-25 10:21:27.000000000 +0200
@@ -23,11 +23,14 @@
  *		consider these trivial functions to be PD.
  */
 
+
 /* AK: in fact I bet it would be better to move this stuff all out of line.
+ * Arjan: .. or just straight use the gcc built-in versions
  */
 
+
 #define __HAVE_ARCH_STRCPY
-static inline char * strcpy(char * dest,const char *src)
+extern inline char * strcpy(char * dest,const char *src)
 {
 int d0, d1, d2;
 __asm__ __volatile__(
@@ -41,7 +44,7 @@ return dest;
 }
 
 #define __HAVE_ARCH_STRNCPY
-static inline char * strncpy(char * dest,const char *src,size_t count)
+extern inline char * strncpy(char * dest,const char *src,size_t count)
 {
 int d0, d1, d2, d3;
 __asm__ __volatile__(
@@ -60,7 +63,7 @@ return dest;
 }
 
 #define __HAVE_ARCH_STRCAT
-static inline char * strcat(char * dest,const char * src)
+extern inline char * strcat(char * dest,const char * src)
 {
 int d0, d1, d2, d3;
 __asm__ __volatile__(
@@ -77,7 +80,7 @@ return dest;
 }
 
 #define __HAVE_ARCH_STRNCAT
-static inline char * strncat(char * dest,const char * src,size_t count)
+extern inline char * strncat(char * dest,const char * src,size_t count)
 {
 int d0, d1, d2, d3;
 __asm__ __volatile__(
diff -purN linux-2.6.12-rc5/include/asm-i386/uaccess.h linux-fortify/include/asm-i386/uaccess.h
--- linux-2.6.12-rc5/include/asm-i386/uaccess.h	2005-05-25 10:10:45.000000000 +0200
+++ linux-fortify/include/asm-i386/uaccess.h	2005-05-25 10:21:27.000000000 +0200
@@ -9,6 +9,7 @@
 #include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <linux/string.h>
+#include <linux/compiler.h>
 #include <asm/page.h>
 
 #define VERIFY_READ 0
@@ -507,10 +508,6 @@ __copy_from_user(void *to, const void __
        might_sleep();
        return __copy_from_user_inatomic(to, from, n);
 }
-unsigned long __must_check copy_to_user(void __user *to,
-				const void *from, unsigned long n);
-unsigned long __must_check copy_from_user(void *to,
-				const void __user *from, unsigned long n);
 long __must_check strncpy_from_user(char *dst, const char __user *src,
 				long count);
 long __must_check __strncpy_from_user(char *dst,
@@ -536,4 +533,40 @@ long strnlen_user(const char __user *str
 unsigned long __must_check clear_user(void __user *mem, unsigned long len);
 unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 
+
+unsigned long __must_check copy_to_user(void __user *to,
+				const void *from, unsigned long n);
+
+#ifdef CONFIG_FORTIFY_SOURCE
+
+extern void __chk_fail(void);
+
+/* 
+ * the inline function with the check wants to call the non-inlined function
+ * with the same name for the actual work. The easiest way to do this is to make 
+ * an alias of the real function and just call this alias from the inline. 
+ */
+extern int __c_f_u_alias(void *to, const void __user *from, unsigned long __nbytes) __asm__ ("" "copy_from_user");
+
+
+extern unsigned long __always_inline __must_check 
+copy_from_user (void *to, const void __user *from, unsigned long __nbytes)
+{
+	/* 
+ 	 * if we know the size of "to" then we can validate that we don't overrun the buffer.
+	 * note that if __nbytes is known at compiletime this check is nicely optimized out
+         */
+	if (__bos0 (to) != (size_t) -1 && __nbytes > __bos0 (to))
+		__chk_fail();
+	return __c_f_u_alias (to, from, __nbytes);
+}
+
+#else
+
+unsigned long __must_check copy_from_user(void *to,
+				const void __user *from, unsigned long n);
+
+#endif
+
+
 #endif /* __i386_UACCESS_H */
diff -purN linux-2.6.12-rc5/include/asm-ppc/uaccess.h linux-fortify/include/asm-ppc/uaccess.h
--- linux-2.6.12-rc5/include/asm-ppc/uaccess.h	2005-05-25 10:10:45.000000000 +0200
+++ linux-fortify/include/asm-ppc/uaccess.h	2005-05-25 10:23:00.000000000 +0200
@@ -330,8 +330,18 @@ copy_to_user(void __user *to, const void
 	return n;
 }
 
+extern void __chk_fail(void);
+
 static inline unsigned long __copy_from_user(void *to, const void __user *from, unsigned long size)
 {
+#ifdef CONFIG_FORTIFY_SOURCE
+	/* 
+	 * if we know the size of "to" then we can validate that we don't overrun the buffer.
+	 * note that if __nbytes is known at compiletime this check is nicely optimized out
+         */
+	if (__bos0 (to) != (size_t) -1 && size > __bos0 (to))
+		__chk_fail();
+#endif
 	return __copy_tofrom_user((__force void __user *)to, from, size);
 }
 
diff -purN linux-2.6.12-rc5/include/linux/compiler-gcc3.h linux-fortify/include/linux/compiler-gcc3.h
--- linux-2.6.12-rc5/include/linux/compiler-gcc3.h	2005-05-25 10:10:45.000000000 +0200
+++ linux-fortify/include/linux/compiler-gcc3.h	2005-05-25 10:21:27.000000000 +0200
@@ -30,3 +30,8 @@
 #define __must_check		__attribute__((warn_unused_result))
 #endif
 
+
+#if  defined(__GNUC_RH_RELEASE__) && __GNUC_MINOR__ >= 4 && __GNUC_PATCHLEVEL__ >=2 
+#define __bos(ptr) __builtin_object_size (ptr, 1)
+#define __bos0(ptr) __builtin_object_size (ptr, 0)
+#endif
diff -purN linux-2.6.12-rc5/include/linux/compiler-gcc4.h linux-fortify/include/linux/compiler-gcc4.h
--- linux-2.6.12-rc5/include/linux/compiler-gcc4.h	2005-05-25 10:10:45.000000000 +0200
+++ linux-fortify/include/linux/compiler-gcc4.h	2005-05-25 10:21:27.000000000 +0200
@@ -14,3 +14,7 @@
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
 
+#if defined(__GNUC_RH_RELEASE__) || __GNUC_MINOR__ >= 1
+#define __bos(ptr) __builtin_object_size (ptr, 1)
+#define __bos0(ptr) __builtin_object_size (ptr, 0)
+#endif
diff -purN linux-2.6.12-rc5/include/linux/compiler.h linux-fortify/include/linux/compiler.h
--- linux-2.6.12-rc5/include/linux/compiler.h	2005-05-25 10:10:45.000000000 +0200
+++ linux-fortify/include/linux/compiler.h	2005-05-25 10:21:27.000000000 +0200
@@ -155,4 +155,13 @@ extern void __chk_io_ptr(void __iomem *)
 #define __always_inline inline
 #endif
 
+#ifndef __bos
+#define __bos(x) -1
+#endif
+
+#ifndef __bos0
+#define __bos0(x) -1
+#endif
+
+
 #endif /* __LINUX_COMPILER_H */
diff -purN linux-2.6.12-rc5/include/linux/slab.h linux-fortify/include/linux/slab.h
--- linux-2.6.12-rc5/include/linux/slab.h	2005-05-25 10:10:46.000000000 +0200
+++ linux-fortify/include/linux/slab.h	2005-05-25 10:21:27.000000000 +0200
@@ -73,9 +73,9 @@ struct cache_sizes {
 	kmem_cache_t	*cs_dmacachep;
 };
 extern struct cache_sizes malloc_sizes[];
-extern void *__kmalloc(size_t, unsigned int __nocast);
+extern __attribute__((malloc)) void *__kmalloc(size_t, unsigned int __nocast); 
 
-static inline void *kmalloc(size_t size, unsigned int __nocast flags)
+static inline __attribute__((malloc)) void *kmalloc(size_t size, unsigned int __nocast flags) 
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
diff -purN linux-2.6.12-rc5/include/linux/string.h linux-fortify/include/linux/string.h
--- linux-2.6.12-rc5/include/linux/string.h	2005-03-02 08:38:07.000000000 +0100
+++ linux-fortify/include/linux/string.h	2005-05-25 10:21:27.000000000 +0200
@@ -88,6 +88,96 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+
+#ifdef CONFIG_FORTIFY_SOURCE
+
+/*
+ * "fortified" variants of some of these functions that for certain cases make
+ * gcc emit code that checks for buffer overflows.
+ */
+
+#undef strcpy
+#undef __HAVE_ARCH_STRCPY
+#define strcpy(dest, src) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strcpy_chk (dest, src, __bos (dest))                   \
+   : __strcpy_ichk (dest, src))
+static __always_inline char *
+__strcpy_ichk (char * __dest, const char * __src)
+{
+  return __builtin___strcpy_chk (__dest, __src, __bos (__dest));
+}
+
+#undef strncpy
+#undef __HAVE_ARCH_STRNCPY
+#define strncpy(dest, src, len) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strncpy_chk (dest, src, len, __bos (dest))             \
+   : __strncpy_ichk (dest, src, len))
+static __always_inline char *
+__strncpy_ichk (char * __dest, const char * __src, size_t __len)
+{
+  return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
+}
+
+#undef strcat
+#undef __HAVE_ARCH_STRCAT
+#define strcat(dest, src) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strcat_chk (dest, src, __bos (dest))                   \
+   : __strcat_ichk (dest, src))
+static __always_inline char *
+__strcat_ichk (char * __dest, const char * __src)
+{
+  return __builtin___strcat_chk (__dest, __src, __bos (__dest));
+}
+
+#undef strncat
+#undef __HAVE_ARCH_STRNCAT
+#define strncat(dest, src, len) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strncat_chk (dest, src, len, __bos (dest))             \
+   : __strncat_ichk (dest, src, len))
+static __always_inline char *
+__strncat_ichk (char * __dest, const char * __src, size_t __len)
+{
+  return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
+}
+
+#undef memcpy
+#define memcpy(dest, src, len) \
+  ((__bos0 (dest) != (size_t) -1)                                       \
+   ? __builtin___memcpy_chk (dest, src, len, __bos0 (dest))             \
+   : __memcpy_ichk (dest, src, len))
+static __always_inline void *
+__memcpy_ichk (void * __dest, const void *__src, size_t __len)
+{
+  return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
+}
+
+/* memset(x,y,0) is a common typo; this dummy non-existent function is
+ * there to create a linker error in that case
+ */
+extern void __warn_memset_zero_len(void);
+
+#undef memset
+#define memset(dest, ch, len) \
+  (__builtin_constant_p (len) && (len) == 0 && (!__builtin_constant_p(ch) || ((ch)!=0)) \
+   ? (__warn_memset_zero_len (), (void) (ch), (void) (len), (void *) (dest))  \
+   : ((__bos0 (dest) != (size_t) -1)                                          \
+      ? __builtin___memset_chk (dest, ch, len, __bos0 (dest))                 \
+      : __memset_ichk (dest, ch, len)))
+
+static __always_inline void *
+__memset_ichk (void *__dest, int __ch, size_t __len)
+{
+  return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest));
+}
+
+
+#endif
+
+
 #ifdef __cplusplus
 }
 #endif
diff -purN linux-2.6.12-rc5/lib/fortify.c linux-fortify/lib/fortify.c
--- linux-2.6.12-rc5/lib/fortify.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-fortify/lib/fortify.c	2005-05-25 10:23:00.000000000 +0200
@@ -0,0 +1,285 @@
+/*
+ * Copyright (C) 1991, 1997, 2003, 2004 Free Software Foundation, Inc.
+ * Portions Copyright (C) 2005 Arjan van de Ven <arjan@infreadead.org>
+ * Portions Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ * (Several of these functions were copied from various FSF projects)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/module.h>
+
+
+void __chk_fail(void) 
+{
+	printk("** kernel buffer overflow detected via application %s ***\n", current->comm);
+	BUG();
+}
+EXPORT_SYMBOL_GPL(__chk_fail);
+
+void * __memcpy_chk (void *dstpp, const void* srcpp, size_t len, size_t dstlen)
+{
+	char *d = (char *) dstpp, *s = (char *) srcpp;
+
+	if (unlikely(dstlen < len))
+		__chk_fail ();
+
+        while (len--)
+                *d++ = *s++;
+
+        return d;
+}
+
+EXPORT_SYMBOL_GPL(__memcpy_chk);
+
+void * __memset_chk (void *dst, const int c, size_t len, size_t dstlen)
+{
+	char *d = (char *) dst;
+
+	if (unlikely(dstlen < len))
+		__chk_fail ();
+
+        while (len--)
+                *d++ = c;
+
+        return d;
+}
+
+EXPORT_SYMBOL_GPL(__memset_chk);
+
+/* Copy SRC to DEST with checking of destination buffer overflow.  */
+char * __strcpy_chk (char *dest, const char *src, size_t destlen)
+{
+  char c;
+  char *s = (char *) src;
+  const ptrdiff_t off = dest - s;
+
+  while (__builtin_expect (destlen >= 4, 0))
+    {
+      c = s[0];
+      s[off] = c;
+      if (c == '\0')
+        return dest;
+      c = s[1];
+      s[off + 1] = c;
+      if (c == '\0')
+        return dest;
+      c = s[2];
+      s[off + 2] = c;
+      if (c == '\0')
+        return dest;
+      c = s[3];
+      s[off + 3] = c;
+      if (c == '\0')
+        return dest;
+      destlen -= 4;
+      s += 4;
+    }
+
+  do
+    {
+      if (__builtin_expect (destlen-- == 0, 0))
+        __chk_fail ();
+      c = *s;
+      *(s++ + off) = c;
+    }
+  while (c != '\0');
+
+  return dest;
+}
+
+EXPORT_SYMBOL_GPL(__strcpy_chk);
+
+
+char * __strcat_chk (char *dest, const char *src, size_t destlen)
+{
+  char *s1 = dest;
+  const char *s2 = src;
+  char c;
+
+  /* Find the end of the string.  */
+  do
+    {
+      if (__builtin_expect (destlen-- == 0, 0))
+        __chk_fail ();
+      c = *s1++;
+    }
+  while (c != '\0');
+
+  /* Make S1 point before the next character, so we can increment
+     it while memory is read (wins on pipelined cpus).  */
+  ++destlen;
+  s1 -= 2;
+
+  do
+    {
+      if (__builtin_expect (destlen-- == 0, 0))
+        __chk_fail ();
+      c = *s2++;
+      *++s1 = c;
+    }
+  while (c != '\0');
+
+  return dest;
+}
+
+EXPORT_SYMBOL_GPL(__strcat_chk);
+
+char * __strncat_chk (char *s1, const char *s2, size_t n, size_t s1len)
+{
+  char c;
+  char *s = s1;
+
+  /* Find the end of S1.  */
+  do
+    {
+      if (__builtin_expect (s1len-- == 0, 0))
+	__chk_fail ();
+      c = *s1++;
+    }
+  while (c != '\0');
+
+  /* Make S1 point before next character, so we can increment
+     it while memory is read (wins on pipelined cpus).  */
+  ++s1len;
+  s1 -= 2;
+
+  if (n >= 4)
+    {
+      size_t n4 = n >> 2;
+      do
+	{
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	} while (--n4 > 0);
+      n &= 3;
+    }
+
+  while (n > 0)
+    {
+      if (__builtin_expect (s1len-- == 0, 0))
+	__chk_fail ();
+      c = *s2++;
+      *++s1 = c;
+      if (c == '\0')
+	return s;
+      n--;
+    }
+
+  if (c != '\0')
+    {
+      if (__builtin_expect (s1len-- == 0, 0))
+	__chk_fail ();
+      *++s1 = '\0';
+    }
+
+  return s;
+}
+
+EXPORT_SYMBOL_GPL(__strncat_chk);
+
+
+char * __strncpy_chk (char *s1, const char *s2, size_t n, size_t s1len)
+{
+  char c;
+  char *s = s1;
+
+  if (__builtin_expect (s1len < n, 0))
+    __chk_fail ();
+
+  --s1;
+
+  if (n >= 4)
+    {
+      size_t n4 = n >> 2;
+
+      for (;;)
+	{
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  if (--n4 == 0)
+	    goto last_chars;
+	}
+      n = n - (s1 - s) - 1;
+      if (n == 0)
+	return s;
+      goto zero_fill;
+    }
+
+ last_chars:
+  n &= 3;
+  if (n == 0)
+    return s;
+
+  do
+    {
+      c = *s2++;
+      *++s1 = c;
+      if (--n == 0)
+	return s;
+    }
+  while (c != '\0');
+
+ zero_fill:
+  do
+    *++s1 = '\0';
+  while (--n > 0);
+
+  return s;
+}
+
+EXPORT_SYMBOL_GPL(__strncpy_chk);
+
+
diff -purN linux-2.6.12-rc5/lib/Kconfig.debug linux-fortify/lib/Kconfig.debug
--- linux-2.6.12-rc5/lib/Kconfig.debug	2005-05-25 10:10:46.000000000 +0200
+++ linux-fortify/lib/Kconfig.debug	2005-05-25 10:23:00.000000000 +0200
@@ -149,6 +149,16 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
+config FORTIFY_SOURCE
+	bool "Enable limited buffer overflow checking"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here the kernel will use a recent gcc feature that
+	  allows several key kernel primitives to check for buffer overflows
+	  when dealing with static buffers. Do not enable this feature unless
+	  you have a very recent gcc (version 4.1 or gccs from FC3, FC4, RHEL4)
+	  If you want to use non-GPL kernel modules, say N.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV)
diff -purN linux-2.6.12-rc5/lib/Makefile linux-fortify/lib/Makefile
--- linux-2.6.12-rc5/lib/Makefile	2005-05-25 10:10:46.000000000 +0200
+++ linux-fortify/lib/Makefile	2005-05-25 10:21:27.000000000 +0200
@@ -18,6 +18,7 @@ endif
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
+lib-$(CONFIG_FORTIFY_SOURCE) += fortify.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
diff -purN linux-2.6.12-rc5/lib/string.c linux-fortify/lib/string.c
--- linux-2.6.12-rc5/lib/string.c	2005-05-25 10:10:46.000000000 +0200
+++ linux-fortify/lib/string.c	2005-05-25 10:23:00.000000000 +0200
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(strnicmp);
  * @src: Where to copy the string from
  */
 #undef strcpy
-char * strcpy(char * dest,const char *src)
+char *  __attribute__((weak)) strcpy(char * dest,const char *src)
 {
 	char *tmp = dest;
 
@@ -91,7 +91,8 @@ EXPORT_SYMBOL(strcpy);
  * count, the remainder of @dest will be padded with %NUL.
  *
  */
-char * strncpy(char * dest,const char *src,size_t count)
+#undef strncpy
+char * __attribute__((weak)) strncpy(char * dest,const char *src,size_t count)
 {
 	char *tmp = dest;
 
@@ -138,7 +139,7 @@ EXPORT_SYMBOL(strlcpy);
  * @src: The string to append to it
  */
 #undef strcat
-char * strcat(char * dest, const char * src)
+char * __attribute__((weak)) strcat(char * dest, const char * src)
 {
 	char *tmp = dest;
 
@@ -162,7 +163,8 @@ EXPORT_SYMBOL(strcat);
  * Note that in contrast to strncpy, strncat ensures the result is
  * terminated.
  */
-char * strncat(char *dest, const char *src, size_t count)
+#undef strncat
+char * __attribute__((weak)) strncat(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
 
@@ -449,6 +451,7 @@ EXPORT_SYMBOL(strsep);
  *
  * Do not use memset() to access IO space, use memset_io() instead.
  */
+#undef memset
 void * memset(void * s,int c,size_t count)
 {
 	char *xs = (char *) s;
@@ -471,6 +474,7 @@ EXPORT_SYMBOL(memset);
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
+#undef memcpy
 void * memcpy(void * dest,const void *src,size_t count)
 {
 	char *tmp = (char *) dest, *s = (char *) src;
