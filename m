Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbUASLAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUASLAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:00:43 -0500
Received: from pD95266F8.dip.t-dialin.net ([217.82.102.248]:6016 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S264536AbUASLAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:00:06 -0500
Date: Sun, 18 Jan 2004 21:09:19 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Modernize i386 string.h
Message-ID: <20040118200919.GA26573@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modernizes i386 string.h. It removes all the fragile i386
inline str* functions and just switches to gcc's builtin variants.
Modern gcc should generate equivalent or better code. Sometimes it
calls out-of-line code, in that case the standard C functions in
lib/string.c is used. 

Essentially it's porting the x86-64 string.h to i386.

memcpy and memset use the x86 string functions. They are always
out-of-line now. These seem to do quite well on many modern x86 (C
stepping K8, P3, P4).  On some CPUs (Athlon XP) it may be better to
use special unrolled versions for clear_page/copy_page, that is
subject to further work. I removed the call to MMX memcpy from the
main memcpy because MMX only helps for very big copies and normal
memcpy is rarely used for that.  Longer term it would 
be useful to implement optimized clear_page/copy_page functions and
switch to the correct one for the current CPU using the alternative()
framework.

I also removed struct_cpy and just let the compiler expand it.

[see the big comment in arch/i386/lib/memcpy.c for more details and some
considerations]

-Andi

diff -u /dev/null linux-string/arch/i386/lib/memmove.c
--- /dev/null	2003-09-24 00:19:32.000000000 +0200
+++ linux-string/arch/i386/lib/memmove.c	2004-01-18 17:13:26.991421472 +0100
@@ -0,0 +1,31 @@
+#include <linux/module.h>
+#include <linux/string.h>
+
+/* Normally compiler builtins are used, but sometimes the compiler calls out
+   of line code. Based on asm-i386/string.h.
+
+   memmove is not that time critical, so this simple version should work.
+ */
+
+#undef memmove
+void *memmove(void * dest,const void *src,size_t count)
+{
+	if (dest < src) { 
+		__inline_memcpy(dest,src,count);
+	} else {
+		/* Could be more clever and move longs */
+		unsigned long d0, d1, d2;
+		__asm__ __volatile__(
+			"std\n\t"
+			"rep\n\t"
+			"movsb\n\t"
+			"cld"
+			: "=&c" (d0), "=&S" (d1), "=&D" (d2)
+			:"0" (count),
+			"1" (count-1+(const char *)src),
+			"2" (count-1+(char *)dest)
+			:"memory");
+	}
+	return dest;
+} 
+EXPORT_SYMBOL_NOVERS(memmove);
diff -u linux-string/arch/i386/lib/memcpy.c-STRING linux-string/arch/i386/lib/memcpy.c
--- linux-string/arch/i386/lib/memcpy.c-STRING	2004-01-18 13:26:16.230612088 +0100
+++ linux-string/arch/i386/lib/memcpy.c	2004-01-18 17:14:56.371833584 +0100
@@ -1,19 +1,54 @@
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/string.h>
 
-#undef memcpy
-#undef memset
+/* These are only called by gcc when it decides that inlining the
+   builtins doesn't make sense. This is the case for big copies
+   or for copies where it cannot figure out the alignment or
+   the size.
 
-void * memcpy(void * to, const void * from, size_t n)
-{
-#ifdef CONFIG_X86_USE_3DNOW
-	return __memcpy3d(to, from, n);
-#else
-	return __memcpy(to, from, n);
-#endif
-}
+   The comments here mostly apply to memset too.
+
+   We currently use the rep ; movsl (and stosl for memset) because
+   that seems to do well enough on most CPUs. On modern x86 
+   they are typically quite well optimized in microcode. 
+
+   On some other CPUs (K8 before B stepping, K7 XP+, VIA?, TMTA?) more 
+   optimized functions may be possible. Some preliminary benchmarks
+   suggest rep ; movsl does well on P4.
+
+   If you optimize anything check the alternative() macros in system.h
+   which allow to use different versions for different CPUs with the
+   same binary.
+
+   Also when you write new functions don't even bother with trying
+   write combing (movnt and friends). While they are faster in micro
+   benchmarks they push the target out of cache and cause a heavy 
+   performance penalty in the final user of the target who has to 
+   cache fault everything in again.
+
+   Athlon uses special MMX functions in mmx.c for {clear,copy}_page. 
+   They are not used for memcpy/memset because the kernel rarely 
+   does copies with these big enough for it to matter.
 
-void * memset(void * s, int c, size_t count)
+   These have been tuned for pre Athlon 4. It's quite likely that
+   on newer Athlon an unrolled integer copy like usercopy.c does
+   is better (needs benchmarking). The same is likely true on 
+   B stepping Opteron.
+
+   -AK(2004/01) */
+
+
+void * __memcpy(void * to, const void * from, size_t n)
 {
-	return __memset(s, c, count);
+	return __inline_memcpy(to, from, n);
 }
+EXPORT_SYMBOL_NOVERS(__memcpy);
+
+/* Alias for gcc */ 
+#undef memcpy
+void *memcpy(void * to, const void * from, size_t n) 
+__attribute__((alias("__memcpy")));
+EXPORT_SYMBOL_NOVERS(memcpy);
+
+
diff -u /dev/null linux-string/arch/i386/lib/memset.c
--- /dev/null	2003-09-24 00:19:32.000000000 +0200
+++ linux-string/arch/i386/lib/memset.c	2004-01-18 17:59:13.922824424 +0100
@@ -0,0 +1,27 @@
+#include <linux/module.h>
+#include <linux/string.h>
+
+/* Please see the introductionary comment in memcpy.c. It applies to 
+   memset too. */
+
+#undef memset
+void * memset(void * s, int c, size_t count)
+{
+	unsigned fill = (unsigned)c * 0x01010101; 
+	int d0, d1;
+	asm volatile(
+		"rep ; stosl\n\t"
+		"testl $2,%3\n\t"
+		"je 1f\n\t"
+		"stosw\n"
+		"1:\ttestl $1,%3\n\t"
+		"je 2f\n\t"
+		"stosb\n"
+		"2:"
+		: "=&c" (d0), "=&D" (d1)
+		: "a" (fill), "q" (count), "0" (count/4), "1" ((long) s)
+		: "memory");
+	return (s);     
+}
+
+EXPORT_SYMBOL_NOVERS(memset);
diff -u linux-string/arch/i386/lib/strstr.c-STRING /dev/null
--- linux-string/arch/i386/lib/strstr.c-STRING	2003-05-27 03:00:41.000000000 +0200
+++ linux-string/arch/i386/lib/strstr.c	2003-09-24 00:19:32.000000000 +0200
@@ -1,31 +0,0 @@
-#include <linux/string.h>
-
-char * strstr(const char * cs,const char * ct)
-{
-int	d0, d1;
-register char * __res;
-__asm__ __volatile__(
-	"movl %6,%%edi\n\t"
-	"repne\n\t"
-	"scasb\n\t"
-	"notl %%ecx\n\t"
-	"decl %%ecx\n\t"	/* NOTE! This also sets Z if searchstring='' */
-	"movl %%ecx,%%edx\n"
-	"1:\tmovl %6,%%edi\n\t"
-	"movl %%esi,%%eax\n\t"
-	"movl %%edx,%%ecx\n\t"
-	"repe\n\t"
-	"cmpsb\n\t"
-	"je 2f\n\t"		/* also works for empty string, see above */
-	"xchgl %%eax,%%esi\n\t"
-	"incl %%esi\n\t"
-	"cmpb $0,-1(%%eax)\n\t"
-	"jne 1b\n\t"
-	"xorl %%eax,%%eax\n\t"
-	"2:"
-	:"=a" (__res), "=&c" (d0), "=&S" (d1)
-	:"0" (0), "1" (0xffffffff), "2" (cs), "g" (ct)
-	:"dx", "di");
-return __res;
-}
-
diff -u linux-string/arch/i386/lib/Makefile-STRING linux-string/arch/i386/lib/Makefile
--- linux-string/arch/i386/lib/Makefile-STRING	2003-07-18 02:39:05.000000000 +0200
+++ linux-string/arch/i386/lib/Makefile	2004-01-18 17:18:56.759289136 +0100
@@ -5,7 +5,7 @@
 
 lib-y = checksum.o delay.o \
 	usercopy.o getuser.o \
-	memcpy.o strstr.o
+	memcpy.o memmove.o memset.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -u linux-string/arch/i386/kernel/i386_ksyms.c-STRING linux-string/arch/i386/kernel/i386_ksyms.c
--- linux-string/arch/i386/kernel/i386_ksyms.c-STRING	2003-10-09 00:28:44.000000000 +0200
+++ linux-string/arch/i386/kernel/i386_ksyms.c	2004-01-18 13:26:36.479533784 +0100
@@ -133,6 +133,38 @@
 EXPORT_SYMBOL(pcibios_get_irq_routing_table);
 #endif
 
+/* Export string functions. We normally rely on gcc builtin for most of these,
+   but gcc sometimes decides not to inline them. */    
+#undef memchr
+#undef strlen
+#undef strcpy
+#undef strncmp
+#undef strncpy
+#undef strchr	
+#undef strcmp 
+#undef strcpy 
+#undef strcat
+
+extern size_t strlen(const char *);
+extern char * strcpy(char * dest,const char *src);
+extern int strcmp(const char * cs,const char * ct);
+extern void *memchr(const void *s, int c, size_t n);
+extern char * strcat(char *, const char *);
+
+EXPORT_SYMBOL_NOVERS(strlen);
+EXPORT_SYMBOL_NOVERS(memmove);
+EXPORT_SYMBOL_NOVERS(strcpy);
+EXPORT_SYMBOL_NOVERS(strncmp);
+EXPORT_SYMBOL_NOVERS(strncpy);
+EXPORT_SYMBOL_NOVERS(strchr);
+EXPORT_SYMBOL_NOVERS(strcmp); 
+EXPORT_SYMBOL_NOVERS(strcat);
+EXPORT_SYMBOL_NOVERS(strncat);
+EXPORT_SYMBOL_NOVERS(memchr);
+EXPORT_SYMBOL_NOVERS(strrchr);
+EXPORT_SYMBOL_NOVERS(strnlen);
+EXPORT_SYMBOL_NOVERS(memscan);
+
 #ifdef CONFIG_X86_USE_3DNOW
 EXPORT_SYMBOL(_mmx_memcpy);
 EXPORT_SYMBOL(mmx_clear_page);
@@ -179,13 +211,6 @@
 EXPORT_SYMBOL_GPL(set_nmi_callback);
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
  
-#undef memcpy
-#undef memset
-extern void * memset(void *,int,__kernel_size_t);
-extern void * memcpy(void *,const void *,__kernel_size_t);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-
 #ifdef CONFIG_HAVE_DEC_LOCK
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
diff -u linux-string/arch/i386/kernel/process.c-STRING linux-string/arch/i386/kernel/process.c
--- linux-string/arch/i386/kernel/process.c-STRING	2004-01-09 09:27:09.000000000 +0100
+++ linux-string/arch/i386/kernel/process.c	2004-01-18 13:26:36.480533632 +0100
@@ -344,7 +344,7 @@
 	int err;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
-	struct_cpy(childregs, regs);
+	*childregs = *regs;
 	childregs->eax = 0;
 	childregs->esp = esp;
 	p->set_child_tid = p->clear_child_tid = NULL;
diff -u linux-string/include/asm-i386/string.h-STRING linux-string/include/asm-i386/string.h
--- linux-string/include/asm-i386/string.h-STRING	2004-01-09 09:27:18.000000000 +0100
+++ linux-string/include/asm-i386/string.h	2004-01-18 18:03:34.204255632 +0100
@@ -2,197 +2,10 @@
 #define _I386_STRING_H_
 
 #ifdef __KERNEL__
-#include <linux/config.h>
-/*
- * On a 486 or Pentium, we are better off not using the
- * byte string operations. But on a 386 or a PPro the
- * byte string ops are faster than doing it by hand
- * (MUCH faster on a Pentium).
- */
-
-/*
- * This string-include defines all string functions as inline
- * functions. Use gcc. It also assumes ds=es=data space, this should be
- * normal. Most of the string-functions are rather heavily hand-optimized,
- * see especially strsep,strstr,str[c]spn. They should work, but are not
- * very easy to understand. Everything is done entirely within the register
- * set, making the functions fast and clean. String instructions have been
- * used through-out, making for "slightly" unclear code :-)
- *
- *		NO Copyright (C) 1991, 1992 Linus Torvalds,
- *		consider these trivial functions to be PD.
- */
 
-#define __HAVE_ARCH_STRCPY
-static inline char * strcpy(char * dest,const char *src)
+static inline void * __inline_memcpy(void * to, const void * from, size_t n)
 {
-int d0, d1, d2;
-__asm__ __volatile__(
-	"1:\tlodsb\n\t"
-	"stosb\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b"
-	: "=&S" (d0), "=&D" (d1), "=&a" (d2)
-	:"0" (src),"1" (dest) : "memory");
-return dest;
-}
-
-#define __HAVE_ARCH_STRNCPY
-static inline char * strncpy(char * dest,const char *src,size_t count)
-{
-int d0, d1, d2, d3;
-__asm__ __volatile__(
-	"1:\tdecl %2\n\t"
-	"js 2f\n\t"
-	"lodsb\n\t"
-	"stosb\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b\n\t"
-	"rep\n\t"
-	"stosb\n"
-	"2:"
-	: "=&S" (d0), "=&D" (d1), "=&c" (d2), "=&a" (d3)
-	:"0" (src),"1" (dest),"2" (count) : "memory");
-return dest;
-}
-
-#define __HAVE_ARCH_STRCAT
-static inline char * strcat(char * dest,const char * src)
-{
-int d0, d1, d2, d3;
-__asm__ __volatile__(
-	"repne\n\t"
-	"scasb\n\t"
-	"decl %1\n"
-	"1:\tlodsb\n\t"
-	"stosb\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b"
-	: "=&S" (d0), "=&D" (d1), "=&a" (d2), "=&c" (d3)
-	: "0" (src), "1" (dest), "2" (0), "3" (0xffffffffu):"memory");
-return dest;
-}
-
-#define __HAVE_ARCH_STRNCAT
-static inline char * strncat(char * dest,const char * src,size_t count)
-{
-int d0, d1, d2, d3;
-__asm__ __volatile__(
-	"repne\n\t"
-	"scasb\n\t"
-	"decl %1\n\t"
-	"movl %8,%3\n"
-	"1:\tdecl %3\n\t"
-	"js 2f\n\t"
-	"lodsb\n\t"
-	"stosb\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b\n"
-	"2:\txorl %2,%2\n\t"
-	"stosb"
-	: "=&S" (d0), "=&D" (d1), "=&a" (d2), "=&c" (d3)
-	: "0" (src),"1" (dest),"2" (0),"3" (0xffffffffu), "g" (count)
-	: "memory");
-return dest;
-}
-
-#define __HAVE_ARCH_STRCMP
-static inline int strcmp(const char * cs,const char * ct)
-{
-int d0, d1;
-register int __res;
-__asm__ __volatile__(
-	"1:\tlodsb\n\t"
-	"scasb\n\t"
-	"jne 2f\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b\n\t"
-	"xorl %%eax,%%eax\n\t"
-	"jmp 3f\n"
-	"2:\tsbbl %%eax,%%eax\n\t"
-	"orb $1,%%al\n"
-	"3:"
-	:"=a" (__res), "=&S" (d0), "=&D" (d1)
-		     :"1" (cs),"2" (ct));
-return __res;
-}
-
-#define __HAVE_ARCH_STRNCMP
-static inline int strncmp(const char * cs,const char * ct,size_t count)
-{
-register int __res;
-int d0, d1, d2;
-__asm__ __volatile__(
-	"1:\tdecl %3\n\t"
-	"js 2f\n\t"
-	"lodsb\n\t"
-	"scasb\n\t"
-	"jne 3f\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b\n"
-	"2:\txorl %%eax,%%eax\n\t"
-	"jmp 4f\n"
-	"3:\tsbbl %%eax,%%eax\n\t"
-	"orb $1,%%al\n"
-	"4:"
-		     :"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
-		     :"1" (cs),"2" (ct),"3" (count));
-return __res;
-}
-
-#define __HAVE_ARCH_STRCHR
-static inline char * strchr(const char * s, int c)
-{
-int d0;
-register char * __res;
-__asm__ __volatile__(
-	"movb %%al,%%ah\n"
-	"1:\tlodsb\n\t"
-	"cmpb %%ah,%%al\n\t"
-	"je 2f\n\t"
-	"testb %%al,%%al\n\t"
-	"jne 1b\n\t"
-	"movl $1,%1\n"
-	"2:\tmovl %1,%0\n\t"
-	"decl %0"
-	:"=a" (__res), "=&S" (d0) : "1" (s),"0" (c));
-return __res;
-}
-
-#define __HAVE_ARCH_STRRCHR
-static inline char * strrchr(const char * s, int c)
-{
-int d0, d1;
-register char * __res;
-__asm__ __volatile__(
-	"movb %%al,%%ah\n"
-	"1:\tlodsb\n\t"
-	"cmpb %%ah,%%al\n\t"
-	"jne 2f\n\t"
-	"leal -1(%%esi),%0\n"
-	"2:\ttestb %%al,%%al\n\t"
-	"jne 1b"
-	:"=g" (__res), "=&S" (d0), "=&a" (d1) :"0" (0),"1" (s),"2" (c));
-return __res;
-}
-
-#define __HAVE_ARCH_STRLEN
-static inline size_t strlen(const char * s)
-{
-int d0;
-register int __res;
-__asm__ __volatile__(
-	"repne\n\t"
-	"scasb\n\t"
-	"notl %0\n\t"
-	"decl %0"
-	:"=c" (__res), "=&D" (d0) :"1" (s),"a" (0), "0" (0xffffffffu));
-return __res;
-}
-
-static inline void * __memcpy(void * to, const void * from, size_t n)
-{
-int d0, d1, d2;
+unsigned long d0, d1, d2;
 __asm__ __volatile__(
 	"rep ; movsl\n\t"
 	"testb $2,%b4\n\t"
@@ -208,271 +21,43 @@
 return (to);
 }
 
-/*
- * This looks horribly ugly, but the compiler can optimize it totally,
- * as the count is constant.
- */
-static inline void * __constant_memcpy(void * to, const void * from, size_t n)
-{
-	if (n <= 128)
-		return __builtin_memcpy(to, from, n);
-
-#define COMMON(x) \
-__asm__ __volatile__( \
-	"rep ; movsl" \
-	x \
-	: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
-	: "0" (n/4),"1" ((long) to),"2" ((long) from) \
-	: "memory");
-{
-	int d0, d1, d2;
-	switch (n % 4) {
-		case 0: COMMON(""); return to;
-		case 1: COMMON("\n\tmovsb"); return to;
-		case 2: COMMON("\n\tmovsw"); return to;
-		default: COMMON("\n\tmovsw\n\tmovsb"); return to;
-	}
-}
-  
-#undef COMMON
-}
-
-#define __HAVE_ARCH_MEMCPY
+/* Even with __builtin_ the compiler may decide to use the out of line
+   function. The cutoff at 128 bytes has been unscientifically chosen,
+   better values may be possibl.e */
+
+#define __HAVE_ARCH_MEMCPY 1
+extern void *__memcpy(void *to, const void *from, size_t len); 
+#define memcpy(dst,src,len) \
+	({ size_t __len = (len);				\
+	   void *__ret;						\
+	   if (__builtin_constant_p(len) && __len >= 128)	\
+		 __ret = __memcpy((dst),(src),__len);		\
+	   else							\
+		 __ret = __builtin_memcpy((dst),(src),__len);	\
+	   __ret; }) 
 
-#ifdef CONFIG_X86_USE_3DNOW
-
-#include <asm/mmx.h>
-
-/*
- *	This CPU favours 3DNow strongly (eg AMD Athlon)
- */
-
-static inline void * __constant_memcpy3d(void * to, const void * from, size_t len)
-{
-	if (len < 512)
-		return __constant_memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
-}
-
-static __inline__ void *__memcpy3d(void *to, const void *from, size_t len)
-{
-	if (len < 512)
-		return __memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
-}
-
-#define memcpy(t, f, n) \
-(__builtin_constant_p(n) ? \
- __constant_memcpy3d((t),(f),(n)) : \
- __memcpy3d((t),(f),(n)))
-
-#else
-
-/*
- *	No 3D Now!
- */
- 
-#define memcpy(t, f, n) \
-(__builtin_constant_p(n) ? \
- __constant_memcpy((t),(f),(n)) : \
- __memcpy((t),(f),(n)))
-
-#endif
-
-/*
- * struct_cpy(x,y), copy structure *x into (matching structure) *y.
- *
- * We get link-time errors if the structure sizes do not match.
- * There is no runtime overhead, it's all optimized away at
- * compile time.
- */
-extern void __struct_cpy_bug (void);
-
-#define struct_cpy(x,y) 			\
-({						\
-	if (sizeof(*(x)) != sizeof(*(y))) 	\
-		__struct_cpy_bug();		\
-	memcpy(x, y, sizeof(*(x)));		\
-})
+#define __HAVE_ARCH_MEMSET
+#define memset __builtin_memset
 
 #define __HAVE_ARCH_MEMMOVE
-static inline void * memmove(void * dest,const void * src, size_t n)
-{
-int d0, d1, d2;
-if (dest<src) {
-	memcpy(dest,src,n);
-} else
-__asm__ __volatile__(
-	"std\n\t"
-	"rep\n\t"
-	"movsb\n\t"
-	"cld"
-	: "=&c" (d0), "=&S" (d1), "=&D" (d2)
-	:"0" (n),
-	 "1" (n-1+(const char *)src),
-	 "2" (n-1+(char *)dest)
-	:"memory");
-return dest;
-}
+void * memmove(void * dest,const void *src,size_t count);
 
+/* Use C out of line version for memcmp */ 
 #define memcmp __builtin_memcmp
+int memcmp(const void * cs,const void * ct,size_t count);
 
-#define __HAVE_ARCH_MEMCHR
-static inline void * memchr(const void * cs,int c,size_t count)
-{
-int d0;
-register void * __res;
-if (!count)
-	return NULL;
-__asm__ __volatile__(
-	"repne\n\t"
-	"scasb\n\t"
-	"je 1f\n\t"
-	"movl $1,%0\n"
-	"1:\tdecl %0"
-	:"=D" (__res), "=&c" (d0) : "a" (c),"0" (cs),"1" (count));
-return __res;
-}
+/* out of line string functions use always C versions */ 
+#define strlen __builtin_strlen
+size_t strlen(const char * s);
 
-static inline void * __memset_generic(void * s, char c,size_t count)
-{
-int d0, d1;
-__asm__ __volatile__(
-	"rep\n\t"
-	"stosb"
-	: "=&c" (d0), "=&D" (d1)
-	:"a" (c),"1" (s),"0" (count)
-	:"memory");
-return s;
-}
+#define strcpy __builtin_strcpy
+char * strcpy(char * dest,const char *src);
 
-/* we might want to write optimized versions of these later */
-#define __constant_count_memset(s,c,count) __memset_generic((s),(c),(count))
+#define strcat __builtin_strcat
+char * strcat(char * dest, const char * src);
 
-/*
- * memset(x,0,y) is a reasonably common thing to do, so we want to fill
- * things 32 bits at a time even when we don't know the size of the
- * area at compile-time..
- */
-static inline void * __constant_c_memset(void * s, unsigned long c, size_t count)
-{
-int d0, d1;
-__asm__ __volatile__(
-	"rep ; stosl\n\t"
-	"testb $2,%b3\n\t"
-	"je 1f\n\t"
-	"stosw\n"
-	"1:\ttestb $1,%b3\n\t"
-	"je 2f\n\t"
-	"stosb\n"
-	"2:"
-	: "=&c" (d0), "=&D" (d1)
-	:"a" (c), "q" (count), "0" (count/4), "1" ((long) s)
-	:"memory");
-return (s);	
-}
-
-/* Added by Gertjan van Wingerde to make minix and sysv module work */
-#define __HAVE_ARCH_STRNLEN
-static inline size_t strnlen(const char * s, size_t count)
-{
-int d0;
-register int __res;
-__asm__ __volatile__(
-	"movl %2,%0\n\t"
-	"jmp 2f\n"
-	"1:\tcmpb $0,(%0)\n\t"
-	"je 3f\n\t"
-	"incl %0\n"
-	"2:\tdecl %1\n\t"
-	"cmpl $-1,%1\n\t"
-	"jne 1b\n"
-	"3:\tsubl %2,%0"
-	:"=a" (__res), "=&d" (d0)
-	:"c" (s),"1" (count));
-return __res;
-}
-/* end of additional stuff */
-
-#define __HAVE_ARCH_STRSTR
-
-extern char *strstr(const char *cs, const char *ct);
-
-/*
- * This looks horribly ugly, but the compiler can optimize it totally,
- * as we by now know that both pattern and count is constant..
- */
-static inline void * __constant_c_and_count_memset(void * s, unsigned long pattern, size_t count)
-{
-	switch (count) {
-		case 0:
-			return s;
-		case 1:
-			*(unsigned char *)s = pattern;
-			return s;
-		case 2:
-			*(unsigned short *)s = pattern;
-			return s;
-		case 3:
-			*(unsigned short *)s = pattern;
-			*(2+(unsigned char *)s) = pattern;
-			return s;
-		case 4:
-			*(unsigned long *)s = pattern;
-			return s;
-	}
-#define COMMON(x) \
-__asm__  __volatile__( \
-	"rep ; stosl" \
-	x \
-	: "=&c" (d0), "=&D" (d1) \
-	: "a" (pattern),"0" (count/4),"1" ((long) s) \
-	: "memory")
-{
-	int d0, d1;
-	switch (count % 4) {
-		case 0: COMMON(""); return s;
-		case 1: COMMON("\n\tstosb"); return s;
-		case 2: COMMON("\n\tstosw"); return s;
-		default: COMMON("\n\tstosw\n\tstosb"); return s;
-	}
-}
-  
-#undef COMMON
-}
-
-#define __constant_c_x_memset(s, c, count) \
-(__builtin_constant_p(count) ? \
- __constant_c_and_count_memset((s),(c),(count)) : \
- __constant_c_memset((s),(c),(count)))
-
-#define __memset(s, c, count) \
-(__builtin_constant_p(count) ? \
- __constant_count_memset((s),(c),(count)) : \
- __memset_generic((s),(c),(count)))
-
-#define __HAVE_ARCH_MEMSET
-#define memset(s, c, count) \
-(__builtin_constant_p(c) ? \
- __constant_c_x_memset((s),(0x01010101UL*(unsigned char)(c)),(count)) : \
- __memset((s),(c),(count)))
-
-/*
- * find the first occurrence of byte 'c', or 1 past the area if none
- */
-#define __HAVE_ARCH_MEMSCAN
-static inline void * memscan(void * addr, int c, size_t size)
-{
-	if (!size)
-		return addr;
-	__asm__("repnz; scasb\n\t"
-		"jnz 1f\n\t"
-		"dec %%edi\n"
-		"1:"
-		: "=D" (addr), "=c" (size)
-		: "0" (addr), "1" (size), "a" (c));
-	return addr;
-}
+#define strcmp __builtin_strcmp
+int strcmp(const char * cs,const char * ct);
 
 #endif /* __KERNEL__ */
 



