Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVAITY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVAITY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVAITY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:24:57 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:52490 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261709AbVAITXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:23:08 -0500
Date: Sun, 9 Jan 2005 19:23:05 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: removing bcopy... because it's half broken
Message-ID: <20050109192305.GA7476@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nothing in the kernel is using bcopy right know, and that is a good thing.
Why? Because a lot of the architectures implement a broken bcopy()....
the userspace standard bcopy() is basically a memmove() with a weird
parameter order, however a bunch of architectures implement a memcpy() not a
memmove(). 

Instead of fixing this inconsistency, I decided to remove it entirely,
explicit memcpy() and memmove() are prefered anyway (welcome to the 1990's)
and nothing in the kernel is using these functions, so this saves code size
as well for everyone.

Greetings,
    Arjan van de Ven


Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.10/arch/alpha/lib/memmove.S linux/arch/alpha/lib/memmove.S
--- linux-2.6.10/arch/alpha/lib/memmove.S	2004-12-24 22:34:45.000000000 +0100
+++ linux/arch/alpha/lib/memmove.S	2005-01-09 20:10:08.027900120 +0100
@@ -12,18 +12,6 @@
 	.text
 
 	.align 4
-	.globl bcopy
-	.ent bcopy
-bcopy:
-	ldgp $29, 0($27)
-	.prologue 1
-	mov $16,$0
-	mov $17,$16
-	mov $0,$17
-	br  $31, memmove	!samegp
-	.end bcopy
-
-	.align 4
 	.globl memmove
 	.ent memmove
 memmove:
diff -purN linux-2.6.10/arch/ia64/lib/memcpy_mck.S linux/arch/ia64/lib/memcpy_mck.S
--- linux-2.6.10/arch/ia64/lib/memcpy_mck.S	2004-12-24 22:35:50.000000000 +0100
+++ linux/arch/ia64/lib/memcpy_mck.S	2005-01-09 20:10:52.793487402 +0100
@@ -17,15 +17,6 @@
 
 #define EK(y...) EX(y)
 
-GLOBAL_ENTRY(bcopy)
-	.regstk 3,0,0,0
-	mov r8=in0
-	mov in0=in1
-	;;
-	mov in1=r8
-	;;
-END(bcopy)
-
 /* McKinley specific optimization */
 
 #define retval		r8
diff -purN linux-2.6.10/arch/ia64/lib/memcpy.S linux/arch/ia64/lib/memcpy.S
--- linux-2.6.10/arch/ia64/lib/memcpy.S	2004-12-24 22:33:48.000000000 +0100
+++ linux/arch/ia64/lib/memcpy.S	2005-01-09 20:10:35.365594731 +0100
@@ -15,22 +15,6 @@
  */
 #include <asm/asmmacro.h>
 
-GLOBAL_ENTRY(bcopy)
-	.regstk 3,0,0,0
-	mov r8=in0
-	mov in0=in1
-	;;
-	mov in1=r8
-	// gas doesn't handle control flow across procedures, so it doesn't
-	// realize that a stop bit is needed before the "alloc" instruction
-	// below
-{
-	nop.m 0
-	nop.f 0
-	nop.i 0
-}	;;
-END(bcopy)
-	// FALL THROUGH
 GLOBAL_ENTRY(memcpy)
 
 #	define MEM_LAT	21		/* latency to memory */
diff -purN linux-2.6.10/arch/parisc/lib/memcpy.c linux/arch/parisc/lib/memcpy.c
--- linux-2.6.10/arch/parisc/lib/memcpy.c	2004-12-24 22:35:39.000000000 +0100
+++ linux/arch/parisc/lib/memcpy.c	2005-01-09 20:11:30.370950807 +0100
@@ -515,16 +515,8 @@ void * memcpy(void * dst,const void *src
 	return dst;
 }
 
-void bcopy(const void * srcp, void * destp, size_t count)
-{
-	mtsp(get_kernel_space(), 1);
-	mtsp(get_kernel_space(), 2);
-	pa_memcpy(destp, srcp, count);
-}
-
 EXPORT_SYMBOL(copy_to_user);
 EXPORT_SYMBOL(copy_from_user);
 EXPORT_SYMBOL(copy_in_user);
 EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(bcopy);
 #endif
diff -purN linux-2.6.10/arch/ppc/boot/common/misc-common.c linux/arch/ppc/boot/common/misc-common.c
--- linux-2.6.10/arch/ppc/boot/common/misc-common.c	2004-12-24 22:34:45.000000000 +0100
+++ linux/arch/ppc/boot/common/misc-common.c	2005-01-09 20:12:20.245930722 +0100
@@ -52,7 +52,6 @@ extern char _end[];
 void puts(const char *);
 void putc(const char c);
 void puthex(unsigned long val);
-void _bcopy(char *src, char *dst, int len);
 void gunzip(void *, int, unsigned char *, int *);
 static int _cvt(unsigned long val, char *buf, long radix, char *digits);
 
diff -purN linux-2.6.10/arch/ppc/lib/string.S linux/arch/ppc/lib/string.S
--- linux-2.6.10/arch/ppc/lib/string.S	2004-12-24 22:35:00.000000000 +0100
+++ linux/arch/ppc/lib/string.S	2005-01-09 20:11:50.375536299 +0100
@@ -216,12 +216,6 @@ _GLOBAL(memset)
 	bdnz	8b
 	blr
 
-_GLOBAL(bcopy)
-	mr	r6,r3
-	mr	r3,r4
-	mr	r4,r6
-	b	memcpy
-
 /*
  * This version uses dcbz on the complete cache lines in the
  * destination area to reduce memory traffic.  This requires that
diff -purN linux-2.6.10/arch/ppc64/boot/string.S linux/arch/ppc64/boot/string.S
--- linux-2.6.10/arch/ppc64/boot/string.S	2004-12-24 22:33:48.000000000 +0100
+++ linux/arch/ppc64/boot/string.S	2005-01-09 20:14:08.556853992 +0100
@@ -96,13 +96,6 @@ memset:
 	bdnz	8b
 	blr
 
-	.globl	bcopy
-bcopy:
-	mr	r6,r3
-	mr	r3,r4
-	mr	r4,r6
-	b	memcpy
-
 	.globl	memmove
 memmove:
 	cmplw	0,r3,r4
diff -purN linux-2.6.10/arch/s390/lib/string.c linux/arch/s390/lib/string.c
--- linux-2.6.10/arch/s390/lib/string.c	2004-12-24 22:34:31.000000000 +0100
+++ linux/arch/s390/lib/string.c	2005-01-09 20:14:30.358221316 +0100
@@ -357,21 +357,6 @@ void *memcpy(void *dest, const void *src
 EXPORT_SYMBOL(memcpy);
 
 /**
- * bcopy - Copy one area of memory to another
- * @src: Where to copy from
- * @dest: Where to copy to
- * @n: The size of the area.
- *
- * Note that this is the same as memcpy(), with the arguments reversed.
- * memcpy() is the standard, bcopy() is a legacy BSD function.
- */
-void bcopy(const void *srcp, void *destp, size_t n)
-{
-	__builtin_memcpy(destp, srcp, n);
-}
-EXPORT_SYMBOL(bcopy);
-
-/**
  * memset - Fill a region of memory with the given value
  * @s: Pointer to the start of the area.
  * @c: The byte to fill the area with
diff -purN linux-2.6.10/arch/sparc/kernel/sparc_ksyms.c linux/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.10/arch/sparc/kernel/sparc_ksyms.c	2004-12-24 22:33:52.000000000 +0100
+++ linux/arch/sparc/kernel/sparc_ksyms.c	2005-01-09 20:13:50.977976644 +0100
@@ -75,7 +75,6 @@ extern void *__memscan_generic(void *, i
 extern int __memcmp(const void *, const void *, __kernel_size_t);
 extern int __strncmp(const char *, const char *, __kernel_size_t);
 
-extern void bcopy (const char *, char *, int);
 extern int __ashrdi3(int, int);
 extern int __ashldi3(int, int);
 extern int __lshrdi3(int, int);
@@ -261,7 +260,6 @@ EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
 /* sparc library symbols */
-EXPORT_SYMBOL(bcopy);
 EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(strlen);
diff -purN linux-2.6.10/arch/sparc/lib/memcpy.S linux/arch/sparc/lib/memcpy.S
--- linux-2.6.10/arch/sparc/lib/memcpy.S	2004-12-24 22:35:49.000000000 +0100
+++ linux/arch/sparc/lib/memcpy.S	2005-01-09 20:13:32.887160994 +0100
@@ -1,5 +1,5 @@
-/* memcpy.S: Sparc optimized memcpy, bcopy and memmove code
- * Hand optimized from GNU libc's memcpy, bcopy and memmove
+/* memcpy.S: Sparc optimized memcpy and memmove code
+ * Hand optimized from GNU libc's memcpy and memmove
  * Copyright (C) 1991,1996 Free Software Foundation
  * Copyright (C) 1995 Linus Torvalds (Linus.Torvalds@helsinki.fi)
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
@@ -192,13 +192,6 @@ x:
 	retl
 	 nop		! Only bcopy returns here and it retuns void...
 
-FUNC(bcopy)
-	mov		%o0, %o3
-	mov		%o1, %o0
-	mov		%o3, %o1
-	tst		%o2
-	bcs		0b
-	 /* Do the cmp in the delay slot */
 #ifdef __KERNEL__
 FUNC(amemmove)
 FUNC(__memmove)
diff -purN linux-2.6.10/arch/v850/lib/memcpy.c linux/arch/v850/lib/memcpy.c
--- linux-2.6.10/arch/v850/lib/memcpy.c	2004-12-24 22:34:00.000000000 +0100
+++ linux/arch/v850/lib/memcpy.c	2005-01-09 20:12:32.512449966 +0100
@@ -60,11 +60,6 @@ void *memcpy (void *dst, const void *src
 	return dst;
 }
 
-void bcopy (const char *src, char *dst, int size)
-{
-	memcpy (dst, src, size);
-}
-
 void *memmove (void *dst, const void *src, __kernel_size_t size)
 {
 	if ((unsigned long)dst < (unsigned long)src
diff -purN linux-2.6.10/include/asm-alpha/string.h linux/include/asm-alpha/string.h
--- linux-2.6.10/include/asm-alpha/string.h	2004-12-24 22:34:31.000000000 +0100
+++ linux/include/asm-alpha/string.h	2005-01-09 20:15:53.571171144 +0100
@@ -13,7 +13,6 @@
 #define __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *, const void *, size_t);
 #define __HAVE_ARCH_MEMMOVE
-#define __HAVE_ARCH_BCOPY
 extern void * memmove(void *, const void *, size_t);
 
 /* For backward compatibility with modules.  Unused otherwise.  */
diff -purN linux-2.6.10/include/asm-arm/string.h linux/include/asm-arm/string.h
--- linux-2.6.10/include/asm-arm/string.h	2004-12-24 22:34:57.000000000 +0100
+++ linux/include/asm-arm/string.h	2005-01-09 20:15:57.529692986 +0100
@@ -25,8 +25,6 @@ extern void * memchr(const void *, int, 
 #define __HAVE_ARCH_MEMSET
 extern void * memset(void *, int, __kernel_size_t);
 
-#define __HAVE_ARCH_BCOPY
-
 extern void __memzero(void *ptr, __kernel_size_t n);
 
 #define memset(p,v,n)							\
diff -purN linux-2.6.10/include/asm-ia64/string.h linux/include/asm-ia64/string.h
--- linux-2.6.10/include/asm-ia64/string.h	2004-12-24 22:35:27.000000000 +0100
+++ linux/include/asm-ia64/string.h	2005-01-09 20:16:04.466855017 +0100
@@ -14,7 +14,6 @@
 #define __HAVE_ARCH_STRLEN	1 /* see arch/ia64/lib/strlen.S */
 #define __HAVE_ARCH_MEMSET	1 /* see arch/ia64/lib/memset.S */
 #define __HAVE_ARCH_MEMCPY	1 /* see arch/ia64/lib/memcpy.S */
-#define __HAVE_ARCH_BCOPY	1 /* see arch/ia64/lib/memcpy.S */
 
 extern __kernel_size_t strlen (const char *);
 extern void *memcpy (void *, const void *, __kernel_size_t);
diff -purN linux-2.6.10/include/asm-mips/string.h linux/include/asm-mips/string.h
--- linux-2.6.10/include/asm-mips/string.h	2004-12-24 22:33:48.000000000 +0100
+++ linux/include/asm-mips/string.h	2005-01-09 20:16:13.267791892 +0100
@@ -137,9 +137,6 @@ extern void *memcpy(void *__to, __const_
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
 
-/* Don't build bcopy at all ...  */
-#define __HAVE_ARCH_BCOPY
-
 #ifdef CONFIG_MIPS32
 #define __HAVE_ARCH_MEMSCAN
 static __inline__ void *memscan(void *__addr, int __c, size_t __size)
diff -purN linux-2.6.10/include/asm-parisc/string.h linux/include/asm-parisc/string.h
--- linux-2.6.10/include/asm-parisc/string.h	2004-12-24 22:35:18.000000000 +0100
+++ linux/include/asm-parisc/string.h	2005-01-09 20:15:19.211321312 +0100
@@ -7,7 +7,4 @@ extern void * memset(void *, int, size_t
 #define __HAVE_ARCH_MEMCPY
 void * memcpy(void * dest,const void *src,size_t count);
 
-#define __HAVE_ARCH_BCOPY
-void bcopy(const void * srcp, void * destp, size_t count);
-
 #endif
diff -purN linux-2.6.10/include/asm-ppc/string.h linux/include/asm-ppc/string.h
--- linux-2.6.10/include/asm-ppc/string.h	2004-12-24 22:35:23.000000000 +0100
+++ linux/include/asm-ppc/string.h	2005-01-09 20:16:42.961204809 +0100
@@ -9,7 +9,6 @@
 #define __HAVE_ARCH_STRCMP
 #define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
diff -purN linux-2.6.10/include/asm-ppc64/string.h linux/include/asm-ppc64/string.h
--- linux-2.6.10/include/asm-ppc64/string.h	2004-12-24 22:35:01.000000000 +0100
+++ linux/include/asm-ppc64/string.h	2005-01-09 20:16:17.374295829 +0100
@@ -14,7 +14,6 @@
 #define __HAVE_ARCH_STRCMP
 #define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
diff -purN linux-2.6.10/include/asm-s390/string.h linux/include/asm-s390/string.h
--- linux-2.6.10/include/asm-s390/string.h	2004-12-24 22:35:50.000000000 +0100
+++ linux/include/asm-s390/string.h	2005-01-09 20:16:20.728890591 +0100
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #endif
 
-#define __HAVE_ARCH_BCOPY	/* arch function */
 #define __HAVE_ARCH_MEMCHR	/* inline & arch function */
 #define __HAVE_ARCH_MEMCMP	/* arch function */
 #define __HAVE_ARCH_MEMCPY	/* gcc builtin & arch function */
diff -purN linux-2.6.10/include/asm-sh/string.h linux/include/asm-sh/string.h
--- linux-2.6.10/include/asm-sh/string.h	2004-12-24 22:35:25.000000000 +0100
+++ linux/include/asm-sh/string.h	2005-01-09 20:15:27.574311224 +0100
@@ -124,7 +124,4 @@ extern void *memchr(const void *__s, int
 #define __HAVE_ARCH_STRLEN
 extern size_t strlen(const char *);
 
-/* Don't build bcopy at all ...  */
-#define __HAVE_ARCH_BCOPY
-
 #endif /* __ASM_SH_STRING_H */
diff -purN linux-2.6.10/include/asm-sparc/string.h linux/include/asm-sparc/string.h
--- linux-2.6.10/include/asm-sparc/string.h	2005-01-09 14:51:10.270104409 +0100
+++ linux/include/asm-sparc/string.h	2005-01-09 20:16:25.412324821 +0100
@@ -22,7 +22,6 @@ extern __kernel_size_t __memset(void *,i
 #ifndef EXPORT_SYMTAB_STROPS
 
 /* First the mem*() things. */
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMMOVE
 #undef memmove
 #define memmove(_to, _from, _n) \
diff -purN linux-2.6.10/include/asm-v850/string.h linux/include/asm-v850/string.h
--- linux-2.6.10/include/asm-v850/string.h	2004-12-24 22:35:50.000000000 +0100
+++ linux/include/asm-v850/string.h	2005-01-09 20:15:34.961418983 +0100
@@ -14,13 +14,11 @@
 #ifndef __V850_STRING_H__
 #define __V850_STRING_H__
 
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMSET
 #define __HAVE_ARCH_MEMMOVE
 
 extern void *memcpy (void *, const void *, __kernel_size_t);
-extern void bcopy (const char *, char *, int);
 extern void *memset (void *, int, __kernel_size_t);
 extern void *memmove (void *, const void *, __kernel_size_t);
 
diff -purN linux-2.6.10/lib/string.c linux/lib/string.c
--- linux-2.6.10/lib/string.c	2005-01-09 14:51:10.378091142 +0100
+++ linux/lib/string.c	2005-01-09 20:09:38.031526681 +0100
@@ -454,30 +454,6 @@ void * memset(void * s,int c,size_t coun
 EXPORT_SYMBOL(memset);
 #endif
 
-#ifndef __HAVE_ARCH_BCOPY
-/**
- * bcopy - Copy one area of memory to another
- * @srcp: Where to copy from
- * @destp: Where to copy to
- * @count: The size of the area.
- *
- * Note that this is the same as memcpy(), with the arguments reversed.
- * memcpy() is the standard, bcopy() is a legacy BSD function.
- *
- * You should not use this function to access IO space, use memcpy_toio()
- * or memcpy_fromio() instead.
- */
-void bcopy(const void * srcp, void * destp, size_t count)
-{
-	const char *src = srcp;
-	char *dest = destp;
-
-	while (count--)
-		*dest++ = *src++;
-}
-EXPORT_SYMBOL(bcopy);
-#endif
-
 #ifndef __HAVE_ARCH_MEMCPY
 /**
  * memcpy - Copy one area of memory to another

