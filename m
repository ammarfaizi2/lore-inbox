Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUFKRiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUFKRiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUFKRiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:38:19 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:39591 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264211AbUFKRcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:32:31 -0400
Date: Fri, 11 Jun 2004 19:32:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: cleanup string functions.
Message-ID: <20040611173236.GD3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: cleanup string functions.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Cleanup s390* string functions. This replaces the 31/64 bit
assembler files (strcmp[64].S, strcpy[64].S & strncpy[64].S)
with a single string.c file that uses some inline assemblies
to issue the string instructions. In addition some more of
the generic string function got an architecture dependent
implementation.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/s390_ksyms.c |   19 -
 arch/s390/lib/Makefile        |    6 
 arch/s390/lib/memset.S        |   30 ---
 arch/s390/lib/memset64.S      |   30 ---
 arch/s390/lib/strcmp.S        |   27 --
 arch/s390/lib/strcmp64.S      |   27 --
 arch/s390/lib/strcpy.S        |   20 --
 arch/s390/lib/strcpy64.S      |   20 --
 arch/s390/lib/string.c        |  405 ++++++++++++++++++++++++++++++++++++++++++
 arch/s390/lib/strncpy.S       |   35 ---
 arch/s390/lib/strncpy64.S     |   35 ---
 include/asm-s390/string.h     |  228 +++++++++++------------
 12 files changed, 516 insertions(+), 366 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	Mon May 10 04:32:52 2004
+++ linux-2.6-s390/arch/s390/kernel/s390_ksyms.c	Fri Jun 11 19:09:56 2004
@@ -45,25 +45,6 @@
 EXPORT_SYMBOL(__down_interruptible);
 
 /*
- * string functions
- */
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(strlen);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strcmp);
-EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(strncmp);
-EXPORT_SYMBOL_NOVERS(strncpy);
-EXPORT_SYMBOL_NOVERS(strnlen);
-EXPORT_SYMBOL_NOVERS(strrchr);
-EXPORT_SYMBOL_NOVERS(strstr);
-EXPORT_SYMBOL_NOVERS(strpbrk);
-EXPORT_SYMBOL_NOVERS(strcpy);
-
-/*
  * binfmt_elf loader 
  */
 extern int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs);
diff -urN linux-2.6/arch/s390/lib/Makefile linux-2.6-s390/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	Mon May 10 04:31:59 2004
+++ linux-2.6-s390/arch/s390/lib/Makefile	Fri Jun 11 19:09:56 2004
@@ -4,6 +4,6 @@
 
 EXTRA_AFLAGS := -traditional
 
-lib-y += delay.o 
-lib-$(CONFIG_ARCH_S390_31) += memset.o strcmp.o strcpy.o strncpy.o uaccess.o
-lib-$(CONFIG_ARCH_S390X) += memset64.o strcmp64.o strcpy64.o strncpy64.o uaccess64.o
+lib-y += delay.o string.o
+lib-$(CONFIG_ARCH_S390_31) += uaccess.o
+lib-$(CONFIG_ARCH_S390X) += uaccess64.o
diff -urN linux-2.6/arch/s390/lib/memset.S linux-2.6-s390/arch/s390/lib/memset.S
--- linux-2.6/arch/s390/lib/memset.S	Mon May 10 04:32:39 2004
+++ linux-2.6-s390/arch/s390/lib/memset.S	Thu Jan  1 01:00:00 1970
@@ -1,30 +0,0 @@
-/*
- *  arch/s390/lib/memset.S
- *    S390 fast memset routine
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address to memory area
- * R3 = byte to fill memory with
- * R4 = number of bytes to fill
- */
-        .globl  memset
-memset:
-        LTR     4,4
-        JZ      memset_end
-        LR      0,2                    # save pointer to memory area
-        LR      1,3                    # move pad byte to R1
-        LR      3,4
-        SR      4,4                    # no source for MVCLE, only a pad byte
-        SR      5,5
-        MVCLE   2,4,0(1)               # thats it, MVCLE is your friend
-        JO      .-4
-        LR      2,0                    # return pointer to mem.
-memset_end:
-        BR      14
-        
-
diff -urN linux-2.6/arch/s390/lib/memset64.S linux-2.6-s390/arch/s390/lib/memset64.S
--- linux-2.6/arch/s390/lib/memset64.S	Mon May 10 04:32:52 2004
+++ linux-2.6-s390/arch/s390/lib/memset64.S	Thu Jan  1 01:00:00 1970
@@ -1,30 +0,0 @@
-/*
- *  arch/s390/lib/memset.S
- *    S390 fast memset routine
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address to memory area
- * R3 = byte to fill memory with
- * R4 = number of bytes to fill
- */
-        .globl  memset
-memset:
-        LTGR    4,4
-        JZ      memset_end
-        LGR     0,2                    # save pointer to memory area
-        LGR     1,3                    # move pad byte to R1
-        LGR     3,4
-        SGR     4,4                    # no source for MVCLE, only a pad byte
-        SGR     5,5
-        MVCLE   2,4,0(1)               # thats it, MVCLE is your friend
-        JO      .-4
-        LGR     2,0                    # return pointer to mem.
-memset_end:
-        BR      14
-        
-
diff -urN linux-2.6/arch/s390/lib/strcmp.S linux-2.6-s390/arch/s390/lib/strcmp.S
--- linux-2.6/arch/s390/lib/strcmp.S	Mon May 10 04:32:53 2004
+++ linux-2.6-s390/arch/s390/lib/strcmp.S	Thu Jan  1 01:00:00 1970
@@ -1,27 +0,0 @@
-/*
- *  arch/s390/lib/strcmp.S
- *    S390 strcmp routine
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address of compare string
- * R3 = address of test string
- */
-        .globl   strcmp
-strcmp:
-        SR      0,0
-        SR      1,1
-        CLST    2,3
-        JO      .-4
-        JE      strcmp_equal
-        IC      0,0(3)
-        IC      1,0(2)
-        SR      1,0
-strcmp_equal:
-        LR      2,1
-        BR      14
-        
diff -urN linux-2.6/arch/s390/lib/strcmp64.S linux-2.6-s390/arch/s390/lib/strcmp64.S
--- linux-2.6/arch/s390/lib/strcmp64.S	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/arch/s390/lib/strcmp64.S	Thu Jan  1 01:00:00 1970
@@ -1,27 +0,0 @@
-/*
- *  arch/s390/lib/strcmp.S
- *    S390 strcmp routine
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address of compare string
- * R3 = address of test string
- */
-        .globl   strcmp
-strcmp:
-        SGR     0,0
-        SGR     1,1
-        CLST    2,3
-        JO      .-4
-        JE      strcmp_equal
-        IC      0,0(3)
-        IC      1,0(2)
-        SGR     1,0
-strcmp_equal:
-        LGR     2,1
-        BR      14
-        
diff -urN linux-2.6/arch/s390/lib/strcpy.S linux-2.6-s390/arch/s390/lib/strcpy.S
--- linux-2.6/arch/s390/lib/strcpy.S	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/arch/s390/lib/strcpy.S	Thu Jan  1 01:00:00 1970
@@ -1,20 +0,0 @@
-/*
- *  arch/s390/kernel/strcpy.S
- *    S390 strcpy routine
- *
- *  S390 version
- *    Copyright (C) 2004 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address of destination
- * R3 = address of source string
- */
-        .globl   strcpy
-strcpy:
-	sr	%r0,%r0
-0:	mvst	%r2,%r3
-	jo	0b
-	br	%r14
-
diff -urN linux-2.6/arch/s390/lib/strcpy64.S linux-2.6-s390/arch/s390/lib/strcpy64.S
--- linux-2.6/arch/s390/lib/strcpy64.S	Mon May 10 04:33:21 2004
+++ linux-2.6-s390/arch/s390/lib/strcpy64.S	Thu Jan  1 01:00:00 1970
@@ -1,20 +0,0 @@
-/*
- *  arch/s390/kernel/strcpy.S
- *    S390 strcpy routine
- *
- *  S390 version
- *    Copyright (C) 2004 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address of destination
- * R3 = address of source string
- */
-        .globl   strcpy
-strcpy:
-	sgr	%r0,%r0
-0:	mvst	%r2,%r3
-	jo	0b
-	br	%r14
-
diff -urN linux-2.6/arch/s390/lib/string.c linux-2.6-s390/arch/s390/lib/string.c
--- linux-2.6/arch/s390/lib/string.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/lib/string.c	Fri Jun 11 19:09:56 2004
@@ -0,0 +1,405 @@
+/*
+ *  arch/s390/lib/string.c
+ *    Optimized string functions
+ *
+ *  S390 version
+ *    Copyright (C) 2004 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ */
+
+#define IN_ARCH_STRING_C 1
+
+#include <linux/types.h>
+#include <linux/module.h>
+
+/*
+ * Helper functions to find the end of a string
+ */
+static inline char *__strend(const char *s)
+{
+	register unsigned long r0 asm("0") = 0;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b"
+		      : "+d" (r0), "+a" (s) :  : "cc" );
+	return (char *) r0;
+}
+
+static inline char *__strnend(const char *s, size_t n)
+{
+	register unsigned long r0 asm("0") = 0;
+	const char *p = s + n;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b"
+		      : "+d" (p), "+a" (s) : "d" (r0) : "cc" );
+	return (char *) p;
+}
+
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ *
+ * returns the length of @s
+ */
+size_t strlen(const char *s)
+{
+	return __strend(s) - s;
+}
+EXPORT_SYMBOL_NOVERS(strlen);
+
+/**
+ * strnlen - Find the length of a length-limited string
+ * @s: The string to be sized
+ * @n: The maximum number of bytes to search
+ *
+ * returns the minimum of the length of @s and @n
+ */
+size_t strnlen(const char * s, size_t n)
+{
+	return __strnend(s, n) - s;
+}
+EXPORT_SYMBOL_NOVERS(strnlen);
+
+/**
+ * strcpy - Copy a %NUL terminated string
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ *
+ * returns a pointer to @dest
+ */
+char *strcpy(char *dest, const char *src)
+{
+	register int r0 asm("0") = 0;
+	char *ret = dest;
+
+	asm volatile ("0: mvst  %0,%1\n"
+		      "   jo    0b"
+		      : "+&a" (dest), "+&a" (src) : "d" (r0)
+		      : "cc", "memory" );
+	return ret;
+}
+EXPORT_SYMBOL_NOVERS(strcpy);
+
+/**
+ * strlcpy - Copy a %NUL terminated string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @size: size of destination buffer
+ *
+ * Compatible with *BSD: the result is always a valid
+ * NUL-terminated string that fits in the buffer (unless,
+ * of course, the buffer size is zero). It does not pad
+ * out the result like strncpy() does.
+ */
+size_t strlcpy(char *dest, const char *src, size_t size)
+{
+	size_t ret = __strend(src) - src;
+
+	if (size) {
+		size_t len = (ret >= size) ? size-1 : ret;
+		dest[len] = '\0';
+		__builtin_memcpy(dest, src, len);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_NOVERS(strlcpy);
+
+/**
+ * strncpy - Copy a length-limited, %NUL-terminated string
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @n: The maximum number of bytes to copy
+ *
+ * The result is not %NUL-terminated if the source exceeds
+ * @n bytes.
+ */
+char *strncpy(char *dest, const char *src, size_t n)
+{
+	size_t len = __strnend(src, n) - src;
+	__builtin_memset(dest + len, 0, n - len);
+	__builtin_memcpy(dest, src, len);
+	return dest;
+}
+EXPORT_SYMBOL_NOVERS(strncpy);
+
+/**
+ * strcat - Append one %NUL-terminated string to another
+ * @dest: The string to be appended to
+ * @src: The string to append to it
+ *
+ * returns a pointer to @dest
+ */
+char *strcat(char *dest, const char *src)
+{
+	register int r0 asm("0") = 0;
+	unsigned long dummy;
+	char *ret = dest;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b\n"
+		      "1: mvst  %0,%2\n"
+		      "   jo    1b"
+		      : "=&a" (dummy), "+a" (dest), "+a" (src)
+		      : "d" (r0), "0" (0UL) : "cc", "memory" );
+	return ret;
+}
+EXPORT_SYMBOL_NOVERS(strcat);
+
+/**
+ * strlcat - Append a length-limited, %NUL-terminated string to another
+ * @dest: The string to be appended to
+ * @src: The string to append to it
+ * @n: The size of the destination buffer.
+ */
+size_t strlcat(char *dest, const char *src, size_t n)
+{
+	size_t dsize = __strend(dest) - dest;
+	size_t len = __strend(src) - src;
+	size_t res = dsize + len;
+
+	if (dsize < n) {
+		dest += dsize;
+		n -= dsize;
+		if (len >= n)
+			len = n - 1;
+		dest[len] = '\0';
+		__builtin_memcpy(dest, src, len);
+	}
+	return res;
+}
+EXPORT_SYMBOL_NOVERS(strlcat);
+
+/**
+ * strncat - Append a length-limited, %NUL-terminated string to another
+ * @dest: The string to be appended to
+ * @src: The string to append to it
+ * @n: The maximum numbers of bytes to copy
+ *
+ * returns a pointer to @dest
+ *
+ * Note that in contrast to strncpy, strncat ensures the result is
+ * terminated.
+ */
+char *strncat(char *dest, const char *src, size_t n)
+{
+	size_t len = __strnend(src, n) - src;
+	char *p = __strend(dest);
+
+	p[len] = '\0';
+	__builtin_memcpy(p, src, len);
+	return dest;
+}
+EXPORT_SYMBOL_NOVERS(strncat);
+
+/**
+ * strcmp - Compare two strings
+ * @cs: One string
+ * @ct: Another string
+ *
+ * returns   0 if @cs and @ct are equal,
+ *         < 0 if @cs is less than @ct
+ *         > 0 if @cs is greater than @ct
+ */
+int strcmp(const char *cs, const char *ct)
+{
+	register int r0 asm("0") = 0;
+	int ret = 0;
+
+	asm volatile ("0: clst %2,%3\n"
+		      "   jo   0b\n"
+		      "   je   1f\n"
+		      "   ic   %0,0(%2)\n"
+		      "   ic   %1,0(%3)\n"
+		      "   sr   %0,%1\n"
+		      "1:"
+		      : "+d" (ret), "+d" (r0), "+a" (cs), "+a" (ct)
+		      : : "cc" );
+	return ret;
+}
+EXPORT_SYMBOL_NOVERS(strcmp);
+
+/**
+ * strrchr - Find the last occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ */
+char * strrchr(const char * s, int c)
+{
+       size_t len = __strend(s) - s;
+
+       if (len)
+	       do {
+		       if (s[len] == (char) c)
+			       return (char *) s + len;
+	       } while (--len > 0);
+       return 0;
+}
+EXPORT_SYMBOL_NOVERS(strrchr);
+
+/**
+ * strstr - Find the first substring in a %NUL terminated string
+ * @s1: The string to be searched
+ * @s2: The string to search for
+ */
+char * strstr(const char * s1,const char * s2)
+{
+	int l1, l2;
+
+	l2 = __strend(s2) - s2;
+	if (!l2)
+		return (char *) s1;
+	l1 = __strend(s1) - s1;
+	while (l1-- >= l2) {
+		register unsigned long r2 asm("2") = (unsigned long) s1;
+		register unsigned long r3 asm("3") = (unsigned long) l2;
+		register unsigned long r4 asm("4") = (unsigned long) s2;
+		register unsigned long r5 asm("5") = (unsigned long) l2;
+		int cc;
+
+		asm volatile ("0: clcle %1,%3,0\n"
+			      "   jo    0b\n"
+			      "   ipm   %0\n"
+			      "   srl   %0,28"
+			      : "=&d" (cc), "+a" (r2), "+a" (r3),
+			        "+a" (r4), "+a" (r5) : : "cc" );
+		if (!cc)
+			return (char *) s1;
+		s1++;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NOVERS(strstr);
+
+/**
+ * memchr - Find a character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * returns the address of the first occurrence of @c, or %NULL
+ * if @c is not found
+ */
+void *memchr(const void *s, int c, size_t n)
+{
+	register int r0 asm("0") = (char) c;
+	const void *ret = s + n;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b\n"
+		      "   jl	1f\n"
+		      "   la    %0,0\n"
+		      "1:"
+		      : "+a" (ret), "+&a" (s) : "d" (r0) : "cc" );
+	return (void *) ret;
+}
+EXPORT_SYMBOL_NOVERS(memchr);
+
+/**
+ * memcmp - Compare two areas of memory
+ * @cs: One area of memory
+ * @ct: Another area of memory
+ * @count: The size of the area.
+ */
+int memcmp(const void *cs, const void *ct, size_t n)
+{
+	register unsigned long r2 asm("2") = (unsigned long) cs;
+	register unsigned long r3 asm("3") = (unsigned long) n;
+	register unsigned long r4 asm("4") = (unsigned long) ct;
+	register unsigned long r5 asm("5") = (unsigned long) n;
+	int ret;
+
+	asm volatile ("0: clcle %1,%3,0\n"
+		      "   jo    0b\n"
+		      "   ipm   %0\n"
+		      "   srl   %0,28"
+		      : "=&d" (ret), "+a" (r2), "+a" (r3), "+a" (r4), "+a" (r5)
+		      : : "cc" );
+	if (ret)
+		ret = *(char *) r2 - *(char *) r4;
+	return ret;
+}
+EXPORT_SYMBOL_NOVERS(memcmp);
+
+/**
+ * memscan - Find a character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * returns the address of the first occurrence of @c, or 1 byte past
+ * the area if @c is not found
+ */
+void *memscan(void *s, int c, size_t n)
+{
+	register int r0 asm("0") = (char) c;
+	const void *ret = s + n;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b\n"
+		      : "+a" (ret), "+&a" (s) : "d" (r0) : "cc" );
+	return (void *) ret;
+}
+EXPORT_SYMBOL_NOVERS(memscan);
+
+/**
+ * memcpy - Copy one area of memory to another
+ * @dest: Where to copy to
+ * @src: Where to copy from
+ * @n: The size of the area.
+ *
+ * returns a pointer to @dest
+ */
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	return __builtin_memcpy(dest, src, n);
+}
+EXPORT_SYMBOL_NOVERS(memcpy);
+
+/**
+ * bcopy - Copy one area of memory to another
+ * @src: Where to copy from
+ * @dest: Where to copy to
+ * @n: The size of the area.
+ *
+ * Note that this is the same as memcpy(), with the arguments reversed.
+ * memcpy() is the standard, bcopy() is a legacy BSD function.
+ */
+void bcopy(const void *srcp, void *destp, size_t n)
+{
+	__builtin_memcpy(destp, srcp, n);
+}
+EXPORT_SYMBOL_NOVERS(bcopy);
+
+/**
+ * memset - Fill a region of memory with the given value
+ * @s: Pointer to the start of the area.
+ * @c: The byte to fill the area with
+ * @n: The size of the area.
+ *
+ * returns a pointer to @s
+ */
+void *memset(void *s, int c, size_t n)
+{
+	char *xs;
+
+	if (c == 0)
+		return __builtin_memset(s, 0, n);
+
+	xs = (char *) s;
+	if (n > 0)
+		do {
+			*xs++ = c;
+		} while (--n > 0);
+	return s;
+}
+EXPORT_SYMBOL_NOVERS(memset);
+
+/*
+ * missing exports for string functions defined in lib/string.c
+ */
+EXPORT_SYMBOL_NOVERS(memmove);
+EXPORT_SYMBOL_NOVERS(strchr);
+EXPORT_SYMBOL_NOVERS(strnchr);
+EXPORT_SYMBOL_NOVERS(strncmp);
+EXPORT_SYMBOL_NOVERS(strpbrk);
diff -urN linux-2.6/arch/s390/lib/strncpy.S linux-2.6-s390/arch/s390/lib/strncpy.S
--- linux-2.6/arch/s390/lib/strncpy.S	Mon May 10 04:32:52 2004
+++ linux-2.6-s390/arch/s390/lib/strncpy.S	Thu Jan  1 01:00:00 1970
@@ -1,35 +0,0 @@
-/*
- *  arch/s390/kernel/strncpy.S
- *    S390 strncpy routine
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address of destination
- * R3 = address of source string
- * R4 = max number of bytes to copy
- */
-        .globl   strncpy
-strncpy:
-        LR      1,2            # don't touch address in R2
-	LTR     4,4
-        JZ      strncpy_exit   # 0 bytes -> nothing to do
-	SR      0,0
-strncpy_loop:
-        ICM     0,1,0(3)       # ICM sets the cc, IC does not
-	LA      3,1(3)
-        STC     0,0(1)
-	LA      1,1(1)
-        JZ      strncpy_pad    # ICM inserted a 0x00
-        BRCT    4,strncpy_loop # R4 -= 1, jump to strncpy_loop if >  0
-strncpy_exit:
-        BR      14
-strncpy_clear:
-	STC	0,0(1)
-	LA	1,1(1)
-strncpy_pad:
-	BRCT	4,strncpy_clear
-	BR	14
diff -urN linux-2.6/arch/s390/lib/strncpy64.S linux-2.6-s390/arch/s390/lib/strncpy64.S
--- linux-2.6/arch/s390/lib/strncpy64.S	Mon May 10 04:32:02 2004
+++ linux-2.6-s390/arch/s390/lib/strncpy64.S	Thu Jan  1 01:00:00 1970
@@ -1,35 +0,0 @@
-/*
- *  arch/s390/kernel/strncpy.S
- *    S390 strncpy routine
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-/*
- * R2 = address of destination
- * R3 = address of source string
- * R4 = max number of bytes to copy
- */
-        .globl   strncpy
-strncpy:
-        LGR     1,2            # don't touch address in R2
-	LTR     4,4
-        JZ      strncpy_exit   # 0 bytes -> nothing to do
-	SGR     0,0
-strncpy_loop:
-        ICM     0,1,0(3)       # ICM sets the cc, IC does not
-	LA      3,1(3)
-        STC     0,0(1)
-	LA      1,1(1)
-        JZ      strncpy_pad    # ICM inserted a 0x00
-        BRCTG   4,strncpy_loop # R4 -= 1, jump to strncpy_loop if > 0
-strncpy_exit:
-        BR      14
-strncpy_clear:
-	STC	0,0(1)
-	LA	1,1(1)
-strncpy_pad:
-	BRCTG	4,strncpy_clear
-	BR	14
diff -urN linux-2.6/include/asm-s390/string.h linux-2.6-s390/include/asm-s390/string.h
--- linux-2.6/include/asm-s390/string.h	Mon May 10 04:33:22 2004
+++ linux-2.6-s390/include/asm-s390/string.h	Fri Jun 11 19:09:56 2004
@@ -15,136 +15,124 @@
 #include <linux/types.h>
 #endif
 
-#define __HAVE_ARCH_MEMCHR
-#define __HAVE_ARCH_MEMCPY
-#define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_STRCAT
-#define __HAVE_ARCH_STRCMP
-#define __HAVE_ARCH_STRCPY
-#define __HAVE_ARCH_STRLEN
-#define __HAVE_ARCH_STRNCPY
+#define __HAVE_ARCH_BCOPY	/* arch function */
+#define __HAVE_ARCH_MEMCHR	/* inline & arch function */
+#define __HAVE_ARCH_MEMCMP	/* arch function */
+#define __HAVE_ARCH_MEMCPY	/* gcc builtin & arch function */
+#define __HAVE_ARCH_MEMSCAN	/* inline & arch function */
+#define __HAVE_ARCH_MEMSET	/* gcc builtin & arch function */
+#define __HAVE_ARCH_STRCAT	/* inline & arch function */
+#define __HAVE_ARCH_STRCMP	/* arch function */
+#define __HAVE_ARCH_STRCPY	/* inline & arch function */
+#define __HAVE_ARCH_STRLCAT	/* arch function */
+#define __HAVE_ARCH_STRLCPY	/* arch function */
+#define __HAVE_ARCH_STRLEN	/* inline & arch function */
+#define __HAVE_ARCH_STRNCAT	/* arch function */
+#define __HAVE_ARCH_STRNCPY	/* arch function */
+#define __HAVE_ARCH_STRNLEN	/* inline & arch function */
+#define __HAVE_ARCH_STRRCHR	/* arch function */
+#define __HAVE_ARCH_STRSTR	/* arch function */
+
+/* Prototypes for non-inlined arch strings functions. */
+extern int memcmp(const void *, const void *, size_t);
+extern void *memcpy(void *, const void *, size_t);
+extern void *memset(void *, int, size_t);
+extern int strcmp(const char *,const char *);
+extern size_t strlcat(char *, const char *, size_t);
+extern size_t strlcpy(char *, const char *, size_t);
+extern char *strncat(char *, const char *, size_t);
+extern char *strncpy(char *, const char *, size_t);
+extern char *strrchr(const char *, int);
+extern char *strstr(const char *, const char *);
 
 #undef __HAVE_ARCH_MEMMOVE
-#undef __HAVE_ARCH_STRNICMP
-#undef __HAVE_ARCH_STRNCAT
-#undef __HAVE_ARCH_STRNCMP
 #undef __HAVE_ARCH_STRCHR
-#undef __HAVE_ARCH_STRRCHR
-#undef __HAVE_ARCH_STRNLEN
-#undef __HAVE_ARCH_STRSPN
+#undef __HAVE_ARCH_STRNCHR
+#undef __HAVE_ARCH_STRNCMP
+#undef __HAVE_ARCH_STRNICMP
 #undef __HAVE_ARCH_STRPBRK
-#undef __HAVE_ARCH_STRTOK
-#undef __HAVE_ARCH_BCOPY
-#undef __HAVE_ARCH_MEMCMP
-#undef __HAVE_ARCH_MEMSCAN
-#undef __HAVE_ARCH_STRSTR
+#undef __HAVE_ARCH_STRSEP
+#undef __HAVE_ARCH_STRSPN
 
-extern void *memset(void *, int, size_t);
-extern void *memcpy(void *, const void *, size_t);
-extern void *memmove(void *, const void *, size_t);
-extern char *strncpy(char *, const char *, size_t);
-extern int strcmp(const char *,const char *);
+#if !defined(IN_ARCH_STRING_C)
+
+static inline void *memchr(const void * s, int c, size_t n)
+{
+	register int r0 asm("0") = (char) c;
+	const void *ret = s + n;
 
-static inline void * memchr(const void * cs,int c,size_t count)
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b\n"
+		      "   jl	1f\n"
+		      "   la    %0,0\n"
+		      "1:"
+		      : "+a" (ret), "+&a" (s) : "d" (r0) : "cc" );
+	return (void *) ret;
+}
+
+static inline void *memscan(void *s, int c, size_t n)
+{
+	register int r0 asm("0") = (char) c;
+	const void *ret = s + n;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b\n"
+		      : "+a" (ret), "+&a" (s) : "d" (r0) : "cc" );
+	return (void *) ret;
+}
+
+static inline char *strcat(char *dst, const char *src)
+{
+	register int r0 asm("0") = 0;
+	unsigned long dummy;
+	char *ret = dst;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b\n"
+		      "1: mvst  %0,%2\n"
+		      "   jo    1b"
+		      : "=&a" (dummy), "+a" (dst), "+a" (src)
+		      : "d" (r0), "0" (0) : "cc", "memory" );
+	return ret;
+}
+
+static inline char *strcpy(char *dst, const char *src)
 {
-    void *ptr;
+	register int r0 asm("0") = 0;
+	char *ret = dst;
 
-    __asm__ __volatile__ (
-#ifndef __s390x__
-                          "   lr    0,%2\n"
-                          "   lr    1,%1\n"
-                          "   la    %0,0(%3,%1)\n"
-                          "0: srst  %0,1\n"
-                          "   jo    0b\n"
-                          "   brc   13,1f\n"
-                          "   slr   %0,%0\n"
-#else /* __s390x__ */
-                          "   lgr   0,%2\n"
-                          "   lgr   1,%1\n"
-                          "   la    %0,0(%3,%1)\n"
-                          "0: srst  %0,1\n"
-                          "   jo    0b\n"
-                          "   brc   13,1f\n"
-                          "   slgr  %0,%0\n"
-#endif /* __s390x__ */
-                          "1:"
-                          : "=&a" (ptr) : "a" (cs), "d" (c), "d" (count)
-                          : "cc", "0", "1" );
-    return ptr;
-}
-
-static __inline__ char *strcpy(char *dest, const char *src)
-{
-    char *tmp = dest;
-
-    __asm__ __volatile__ (
-#ifndef __s390x__
-                          "   sr    0,0\n"
-                          "0: mvst  %0,%1\n"
-                          "   jo    0b"
-#else /* __s390x__ */
-                          "   slgr  0,0\n"
-                          "0: mvst  %0,%1\n"
-                          "   jo    0b"
-#endif /* __s390x__ */
-                          : "+&a" (dest), "+&a" (src) :
-                          : "cc", "memory", "0" );
-    return tmp;
-}
-
-static __inline__ size_t strlen(const char *s)
-{
-    size_t len;
-
-    __asm__ __volatile__ (
-#ifndef __s390x__
-                          "   sr    0,0\n"
-                          "   lr    %0,%1\n"
-                          "0: srst  0,%0\n"
-                          "   jo    0b\n"
-                          "   lr    %0,0\n"
-                          "   sr    %0,%1"
-#else /* __s390x__ */
-                          "   slgr  0,0\n"
-                          "   lgr   %0,%1\n"
-                          "0: srst  0,%0\n"
-                          "   jo    0b\n"
-                          "   lgr   %0,0\n"
-                          "   sgr   %0,%1"
-#endif /* __s390x__ */
-                          : "=&a" (len) : "a" (s) 
-                          : "cc", "0" );
-    return len;
-}
-
-static __inline__ char *strcat(char *dest, const char *src)
-{
-    char *tmp = dest;
-
-    __asm__ __volatile__ (
-#ifndef __s390x__
-                          "   sr    0,0\n"
-                          "0: srst  0,%0\n"
-                          "   jo    0b\n"
-                          "   lr    %0,0\n"
-                          "   sr    0,0\n"
-                          "1: mvst  %0,%1\n"
-                          "   jo    1b"
-#else /* __s390x__ */
-                          "   slgr  0,0\n"
-                          "0: srst  0,%0\n"
-                          "   jo    0b\n"
-                          "   lgr   %0,0\n"
-                          "   slgr  0,0\n"
-                          "1: mvst  %0,%1\n"
-                          "   jo    1b"
-#endif /* __s390x__ */
-                          : "+&a" (dest), "+&a" (src) :
-                          : "cc", "memory", "0" );
-    return tmp;
+	asm volatile ("0: mvst  %0,%1\n"
+		      "   jo    0b"
+		      : "+&a" (dst), "+&a" (src) : "d" (r0)
+		      : "cc", "memory" );
+	return ret;
 }
 
-extern void *alloca(size_t);
+static inline size_t strlen(const char *s)
+{
+	register unsigned long r0 asm("0") = 0;
+	const char *tmp = s;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b"
+		      : "+d" (r0), "+a" (tmp) :  : "cc" );
+	return r0 - (unsigned long) s;
+}
+
+static inline size_t strnlen(const char * s, size_t n)
+{
+	register int r0 asm("0") = 0;
+	const char *tmp = s;
+	const char *end = s + n;
+
+	asm volatile ("0: srst  %0,%1\n"
+		      "   jo    0b"
+		      : "+a" (end), "+a" (tmp) : "d" (r0)  : "cc" );
+	return end - s;
+}
+
+#endif /* !IN_ARCH_STRING_C */
+
 #endif /* __KERNEL__ */
 
 #endif /* __S390_STRING_H_ */
