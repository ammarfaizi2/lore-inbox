Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262578AbSJGRQE>; Mon, 7 Oct 2002 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262577AbSJGRQE>; Mon, 7 Oct 2002 13:16:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262574AbSJGRPT>;
	Mon, 7 Oct 2002 13:15:19 -0400
Date: Mon, 7 Oct 2002 18:20:58 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: RFC: remove bcopy()
Message-ID: <20021007182058.M18545@parcelfarce.linux.theplanet.co.uk>
References: <20021007152510.K18545@parcelfarce.linux.theplanet.co.uk> <20021007162227.A15313@infradead.org> <20021007163827.L18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007163827.L18545@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, Oct 07, 2002 at 04:38:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, here's the patch which removes the implementation of bcopy from
all architectures and lib/string.c.  i also change the one actual
user of bcopy to use memcpy instead and remove a few prototypes.
The __ARCH_HAS_BCOPY define is also gone.

Comments from arch maintainers?

diff -urpNX dontdiff linux-2.5.40/arch/ia64/lib/memcpy_mck.S linux-2.5.40-bcopy/arch/ia64/lib/memcpy_mck.S
--- linux-2.5.40/arch/ia64/lib/memcpy_mck.S	2002-10-01 03:06:59.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ia64/lib/memcpy_mck.S	2002-10-07 12:12:04.000000000 -0400
@@ -21,15 +21,6 @@
 # define EK(y,x...)  x
 #endif
 
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
diff -urpNX dontdiff linux-2.5.40/arch/ia64/lib/memcpy.S linux-2.5.40-bcopy/arch/ia64/lib/memcpy.S
--- linux-2.5.40/arch/ia64/lib/memcpy.S	2002-10-01 03:05:47.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ia64/lib/memcpy.S	2002-10-07 12:11:31.000000000 -0400
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
diff -urpNX dontdiff linux-2.5.40/arch/ia64/sn/io/l1_command.c linux-2.5.40-bcopy/arch/ia64/sn/io/l1_command.c
--- linux-2.5.40/arch/ia64/sn/io/l1_command.c	2002-10-01 03:07:00.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ia64/sn/io/l1_command.c	2002-10-07 12:13:18.000000000 -0400
@@ -34,8 +34,6 @@
 
 #define LBYTE(caddr)	(*(char *) caddr)
 
-extern char *bcopy(const char * src, char * dest, int count);
-
 #define LDEBUG		0
 
 /*
diff -urpNX dontdiff linux-2.5.40/arch/ia64/sn/io/module.c linux-2.5.40-bcopy/arch/ia64/sn/io/module.c
--- linux-2.5.40/arch/ia64/sn/io/module.c	2002-10-01 03:06:55.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ia64/sn/io/module.c	2002-10-07 12:12:53.000000000 -0400
@@ -173,7 +173,6 @@ int module_probe_snum(module_t *m, nasid
 {
     lboard_t	       *board;
     klmod_serial_num_t *comp;
-    char * bcopy(const char * src, char * dest, int count);
     char serial_number[16];
 
     /*
@@ -222,8 +221,7 @@ int module_probe_snum(module_t *m, nasid
 #endif
 
 	    if (comp->snum.snum_str[0] != '\0') {
-		bcopy(comp->snum.snum_str,
-		      m->sys_snum,
+		memcpy(m->sys_snum, comp->snum.snum_str,
 		      MAX_SERIAL_NUM_SIZE);
 		m->sys_snum_valid = 1;
 	    }
diff -urpNX dontdiff linux-2.5.40/arch/ppc/boot/common/misc-common.c linux-2.5.40-bcopy/arch/ppc/boot/common/misc-common.c
--- linux-2.5.40/arch/ppc/boot/common/misc-common.c	2002-10-01 03:06:59.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ppc/boot/common/misc-common.c	2002-10-07 12:05:01.000000000 -0400
@@ -68,7 +68,6 @@ extern char _end[];
 void puts(const char *);
 void putc(const char c);
 void puthex(unsigned long val);
-void _bcopy(char *src, char *dst, int len);
 void gunzip(void *, int, unsigned char *, int *);
 static int _cvt(unsigned long val, char *buf, long radix, char *digits);
 
diff -urpNX dontdiff linux-2.5.40/arch/ppc/lib/string.S linux-2.5.40-bcopy/arch/ppc/lib/string.S
--- linux-2.5.40/arch/ppc/lib/string.S	2002-10-01 03:07:06.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ppc/lib/string.S	2002-10-07 12:05:31.000000000 -0400
@@ -208,12 +208,6 @@ _GLOBAL(memset)
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
diff -urpNX dontdiff linux-2.5.40/arch/ppc64/boot/crt0.S linux-2.5.40-bcopy/arch/ppc64/boot/crt0.S
--- linux-2.5.40/arch/ppc64/boot/crt0.S	2002-10-01 03:07:06.000000000 -0400
+++ linux-2.5.40-bcopy/arch/ppc64/boot/crt0.S	2002-10-07 12:10:56.000000000 -0400
@@ -159,13 +159,6 @@ memset:
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
diff -urpNX dontdiff linux-2.5.40/arch/sparc/kernel/sparc_ksyms.c linux-2.5.40-bcopy/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.5.40/arch/sparc/kernel/sparc_ksyms.c	2002-10-01 03:06:16.000000000 -0400
+++ linux-2.5.40-bcopy/arch/sparc/kernel/sparc_ksyms.c	2002-10-07 12:08:14.000000000 -0400
@@ -71,7 +71,6 @@ extern int __memcmp(const void *, const 
 extern int __strncmp(const char *, const char *, __kernel_size_t);
 extern char saved_command_line[];
 
-extern void bcopy (const char *, char *, int);
 extern int __ashrdi3(int, int);
 extern int __ashldi3(int, int);
 extern int __lshrdi3(int, int);
@@ -233,7 +232,6 @@ EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
 /* sparc library symbols */
-EXPORT_SYMBOL(bcopy);
 EXPORT_SYMBOL_NOVERS(memscan);
 EXPORT_SYMBOL_NOVERS(strlen);
 EXPORT_SYMBOL(strnlen);
diff -urpNX dontdiff linux-2.5.40/arch/sparc/lib/memcpy.S linux-2.5.40-bcopy/arch/sparc/lib/memcpy.S
--- linux-2.5.40/arch/sparc/lib/memcpy.S	2002-10-01 03:07:51.000000000 -0400
+++ linux-2.5.40-bcopy/arch/sparc/lib/memcpy.S	2002-10-07 12:10:23.000000000 -0400
@@ -1,5 +1,5 @@
-/* memcpy.S: Sparc optimized memcpy, bcopy and memmove code
- * Hand optimized from GNU libc's memcpy, bcopy and memmove
+/* memcpy.S: Sparc optimized memcpy and memmove code
+ * Hand optimized from GNU libc's memcpy and memmove
  * Copyright (C) 1991,1996 Free Software Foundation
  * Copyright (C) 1995 Linus Torvalds (Linus.Torvalds@helsinki.fi)
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
@@ -190,17 +190,6 @@ C_LABEL(x):
 
 #endif /* FASTER_REVERSE */
 
-0:
-	retl
-	 nop		! Only bcopy returns here and it retuns void...
-
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
diff -urpNX dontdiff linux-2.5.40/arch/sparc64/lib/VIScopy.S linux-2.5.40-bcopy/arch/sparc64/lib/VIScopy.S
--- linux-2.5.40/arch/sparc64/lib/VIScopy.S	2002-10-01 03:06:17.000000000 -0400
+++ linux-2.5.40-bcopy/arch/sparc64/lib/VIScopy.S	2002-10-07 12:07:00.000000000 -0400
@@ -16,7 +16,7 @@
 	 * is put in here just for this purpose.
 	 *
 	 * For userland, compiling this without __KERNEL__ defined makes
-	 * it work just fine as a generic libc bcopy and memcpy.
+	 * it work just fine as a generic libc memcpy.
 	 * If for userland it is compiled with a 32bit gcc (but you need
 	 * -Wa,-Av9a for as), the code will just rely on lower 32bits of
 	 * IEU registers, if you compile it with 64bit gcc (ie. define
@@ -300,9 +300,6 @@
 		.globl			memcpy
 		.type			memcpy,@function
 
-		.globl			bcopy
-		.type			bcopy,@function
-
 #ifdef __KERNEL__
 		.globl			__memcpy_begin
 __memcpy_begin:
@@ -340,17 +337,7 @@ __copy_in_user:	rd		%asi, asi_src			! IE
 		 mov		asi_src, asi_dest		! IEU1
 		retl						! CTI	Group
 		 clr		%o0				! IEU0	Group
-#endif
-
-bcopy:		or		%o0, 0, %g3			! IEU0	Group
-		addcc		%o1, 0, %o0			! IEU1
-		brgez,pt	%o2, memcpy_private		! CTI
-		 or		%g3, 0, %o1			! IEU0	Group
-		retl						! CTI	Group brk forced
-		 clr		%o0				! IEU0
 
-
-#ifdef __KERNEL__
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define ULTRA3_DO_PATCH(OLD, NEW)	\
diff -urpNX dontdiff linux-2.5.40/arch/sparc64/lib/VIS.h linux-2.5.40-bcopy/arch/sparc64/lib/VIS.h
--- linux-2.5.40/arch/sparc64/lib/VIS.h	2002-10-01 03:06:29.000000000 -0400
+++ linux-2.5.40-bcopy/arch/sparc64/lib/VIS.h	2002-10-07 12:07:39.000000000 -0400
@@ -14,7 +14,7 @@
 	 * is put in here just for this purpose.
 	 *
 	 * For userland, compiling this without __KERNEL__ defined makes
-	 * it work just fine as a generic libc bcopy and memcpy.
+	 * it work just fine as a generic libc memcpy.
 	 * If for userland it is compiled with a 32bit gcc (but you need
 	 * -Wa,-Av9a), the code will just rely on lower 32bits of
 	 * IEU registers, if you compile it with 64bit gcc (ie. define
diff -urpNX dontdiff linux-2.5.40/arch/x86_64/kernel/x8664_ksyms.c linux-2.5.40-bcopy/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.5.40/arch/x86_64/kernel/x8664_ksyms.c	2002-10-01 03:06:19.000000000 -0400
+++ linux-2.5.40-bcopy/arch/x86_64/kernel/x8664_ksyms.c	2002-10-07 12:14:24.000000000 -0400
@@ -149,12 +149,10 @@ EXPORT_SYMBOL(rtc_lock);
 #undef strncpy
 #undef strchr	
 #undef strcmp 
-#undef bcopy
 #undef strcpy 
 
 extern void * memset(void *,int,__kernel_size_t);
 extern size_t strlen(const char *);
-extern char * bcopy(const char * src, char * dest, int count);
 extern void * memmove(void * dest,const void *src,size_t count);
 extern char * strcpy(char * dest,const char *src);
 extern int strcmp(const char * cs,const char * ct);
@@ -173,7 +171,6 @@ EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(strrchr);
 EXPORT_SYMBOL_NOVERS(strnlen);
 EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(bcopy);
 
 EXPORT_SYMBOL(empty_zero_page);
 
diff -urpNX dontdiff linux-2.5.40/include/asm-ia64/string.h linux-2.5.40-bcopy/include/asm-ia64/string.h
--- linux-2.5.40/include/asm-ia64/string.h	2002-10-01 03:07:36.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-ia64/string.h	2002-10-07 13:04:22.000000000 -0400
@@ -14,7 +14,6 @@
 #define __HAVE_ARCH_STRLEN	1 /* see arch/ia64/lib/strlen.S */
 #define __HAVE_ARCH_MEMSET	1 /* see arch/ia64/lib/memset.S */
 #define __HAVE_ARCH_MEMCPY	1 /* see arch/ia64/lib/memcpy.S */
-#define __HAVE_ARCH_BCOPY	1 /* see arch/ia64/lib/memcpy.S */
 
 extern __kernel_size_t strlen (const char *);
 extern void *memcpy (void *, const void *, __kernel_size_t);
diff -urpNX dontdiff linux-2.5.40/include/asm-mips/string.h linux-2.5.40-bcopy/include/asm-mips/string.h
--- linux-2.5.40/include/asm-mips/string.h	2002-10-01 03:05:46.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-mips/string.h	2002-10-07 12:02:17.000000000 -0400
@@ -131,9 +131,6 @@ extern void *memcpy(void *__to, __const_
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
 
-/* Don't build bcopy at all ...  */
-#define __HAVE_ARCH_BCOPY
-
 #define __HAVE_ARCH_MEMSCAN
 extern __inline__ void *memscan(void *__addr, int __c, size_t __size)
 {
diff -urpNX dontdiff linux-2.5.40/include/asm-mips64/string.h linux-2.5.40-bcopy/include/asm-mips64/string.h
--- linux-2.5.40/include/asm-mips64/string.h	2002-10-01 03:07:51.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-mips64/string.h	2002-10-07 12:02:36.000000000 -0400
@@ -18,7 +18,4 @@ extern void *memcpy(void *__to, __const_
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
 
-/* Don't build bcopy at all ...  */
-#define __HAVE_ARCH_BCOPY
-
 #endif /* _ASM_STRING_H */
diff -urpNX dontdiff linux-2.5.40/include/asm-ppc/string.h linux-2.5.40-bcopy/include/asm-ppc/string.h
--- linux-2.5.40/include/asm-ppc/string.h	2002-10-01 03:07:34.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-ppc/string.h	2002-10-07 13:13:26.000000000 -0400
@@ -9,7 +9,6 @@
 #define __HAVE_ARCH_STRCMP
 #define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
diff -urpNX dontdiff linux-2.5.40/include/asm-ppc64/string.h linux-2.5.40-bcopy/include/asm-ppc64/string.h
--- linux-2.5.40/include/asm-ppc64/string.h	2002-10-01 03:07:12.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-ppc64/string.h	2002-10-07 13:02:56.000000000 -0400
@@ -14,7 +14,6 @@
 #define __HAVE_ARCH_STRCMP
 #define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
diff -urpNX dontdiff linux-2.5.40/include/asm-s390/string.h linux-2.5.40-bcopy/include/asm-s390/string.h
--- linux-2.5.40/include/asm-s390/string.h	2002-10-01 03:07:56.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-s390/string.h	2002-10-07 13:11:57.000000000 -0400
@@ -34,7 +34,6 @@
 #undef __HAVE_ARCH_STRSPN
 #undef __HAVE_ARCH_STRPBRK
 #undef __HAVE_ARCH_STRTOK
-#undef __HAVE_ARCH_BCOPY
 #undef __HAVE_ARCH_MEMCMP
 #undef __HAVE_ARCH_MEMSCAN
 #undef __HAVE_ARCH_STRSTR
diff -urpNX dontdiff linux-2.5.40/include/asm-s390x/string.h linux-2.5.40-bcopy/include/asm-s390x/string.h
--- linux-2.5.40/include/asm-s390x/string.h	2002-10-01 03:07:35.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-s390x/string.h	2002-10-07 13:11:44.000000000 -0400
@@ -34,7 +34,6 @@
 #undef __HAVE_ARCH_STRSPN
 #undef __HAVE_ARCH_STRPBRK
 #undef __HAVE_ARCH_STRTOK
-#undef __HAVE_ARCH_BCOPY
 #undef __HAVE_ARCH_MEMCMP
 #undef __HAVE_ARCH_MEMSCAN
 #undef __HAVE_ARCH_STRSTR
diff -urpNX dontdiff linux-2.5.40/include/asm-sh/string.h linux-2.5.40-bcopy/include/asm-sh/string.h
--- linux-2.5.40/include/asm-sh/string.h	2002-10-01 03:07:36.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-sh/string.h	2002-10-07 12:02:58.000000000 -0400
@@ -124,7 +124,4 @@ extern void *memchr(const void *__s, int
 #define __HAVE_ARCH_STRLEN
 extern size_t strlen(const char *);
 
-/* Don't build bcopy at all ...  */
-#define __HAVE_ARCH_BCOPY
-
 #endif /* __ASM_SH_STRING_H */
diff -urpNX dontdiff linux-2.5.40/include/asm-sparc/string.h linux-2.5.40-bcopy/include/asm-sparc/string.h
--- linux-2.5.40/include/asm-sparc/string.h	2002-10-01 03:05:47.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-sparc/string.h	2002-10-07 13:05:39.000000000 -0400
@@ -22,7 +22,6 @@ extern __kernel_size_t __memset(void *,i
 #ifndef EXPORT_SYMTAB_STROPS
 
 /* First the mem*() things. */
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMMOVE
 #undef memmove
 #define memmove(_to, _from, _n) \
diff -urpNX dontdiff linux-2.5.40/include/asm-sparc64/string.h linux-2.5.40-bcopy/include/asm-sparc64/string.h
--- linux-2.5.40/include/asm-sparc64/string.h	2002-10-01 03:07:36.000000000 -0400
+++ linux-2.5.40-bcopy/include/asm-sparc64/string.h	2002-10-07 13:12:09.000000000 -0400
@@ -24,7 +24,6 @@ extern void *__builtin_memset(void *,int
 #ifndef EXPORT_SYMTAB_STROPS
 
 /* First the mem*() things. */
-#define __HAVE_ARCH_BCOPY
 #define __HAVE_ARCH_MEMMOVE
 
 #undef memmove
diff -urpNX dontdiff linux-2.5.40/lib/string.c linux-2.5.40-bcopy/lib/string.c
--- linux-2.5.40/lib/string.c	2002-10-01 03:07:36.000000000 -0400
+++ linux-2.5.40-bcopy/lib/string.c	2002-10-07 13:06:50.000000000 -0400
@@ -340,30 +340,6 @@ void * memset(void * s,int c,size_t coun
 }
 #endif
 
-#ifndef __HAVE_ARCH_BCOPY
-/**
- * bcopy - Copy one area of memory to another
- * @src: Where to copy from
- * @dest: Where to copy to
- * @count: The size of the area.
- *
- * Note that this is the same as memcpy(), with the arguments reversed.
- * memcpy() is the standard, bcopy() is a legacy BSD function.
- *
- * You should not use this function to access IO space, use memcpy_toio()
- * or memcpy_fromio() instead.
- */
-char * bcopy(const char * src, char * dest, int count)
-{
-	char *tmp = dest;
-
-	while (count--)
-		*tmp++ = *src++;
-
-	return dest;
-}
-#endif
-
 #ifndef __HAVE_ARCH_MEMCPY
 /**
  * memcpy - Copy one area of memory to another

-- 
Revolutions do not require corporate support.
