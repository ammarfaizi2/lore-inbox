Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbQLOUgM>; Fri, 15 Dec 2000 15:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131190AbQLOUgB>; Fri, 15 Dec 2000 15:36:01 -0500
Received: from office.ilan.net ([216.27.3.20]:27153 "EHLO office.ilan.net")
	by vger.kernel.org with ESMTP id <S129383AbQLOUfx>;
	Fri, 15 Dec 2000 15:35:53 -0500
Message-ID: <3A3A7982.2010503@holly-springs.nc.us>
Date: Fri, 15 Dec 2000 15:05:22 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18pre21 i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Linux 2.2.19pre1 64-bit printk
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------030108080502030708090105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108080502030708090105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> Ok this is the first block of changes before we merge the VM stuff. This is
> mostly the bits left over from the 2.2.18 port that were deferred as too
> risky near the end of a prerelease set and some bug swats

And here is the 64-bit printk patch -- a backport of the 2.4.0 code.

diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-alpha/div64.h linux/include/asm-alpha/div64.h
--- linux-2.2.16/include/asm-alpha/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-alpha/div64.h	Fri Aug 11 20:04:18 2000
@@ -0,0 +1,14 @@
+#ifndef __ALPHA_DIV64
+#define __ALPHA_DIV64
+
+/*
+ * Hey, we're already 64-bit, no
+ * need to play games..
+ */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) (n)) % (unsigned) (base); \
+	(n) = ((unsigned long) (n)) / (unsigned) (base); \
+	__res; })
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-arm/div64.h linux/include/asm-arm/div64.h
--- linux-2.2.16/include/asm-arm/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-arm/div64.h	Fri Aug 11 20:05:41 2000
@@ -0,0 +1,14 @@
+#ifndef __ASM_ARM_DIV64
+#define __ASM_ARM_DIV64
+
+/* We're not 64-bit, but... */
+#define do_div(n,base)						\
+({								\
+	int __res;						\
+	__res = ((unsigned long)n) % (unsigned int)base;	\
+	n = ((unsigned long)n) / (unsigned int)base;		\
+	__res;							\
+})
+
+#endif
+
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-i386/div64.h linux/include/asm-i386/div64.h
--- linux-2.2.16/include/asm-i386/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-i386/div64.h	Fri Aug 11 20:06:05 2000
@@ -0,0 +1,17 @@
+#ifndef __I386_DIV64
+#define __I386_DIV64
+
+#define do_div(n,base) ({ \
+	unsigned long __upper, __low, __high, __mod; \
+	asm("":"=a" (__low), "=d" (__high):"A" (n)); \
+	__upper = __high; \
+	if (__high) { \
+		__upper = __high % (base); \
+		__high = __high / (base); \
+	} \
+	asm("divl %2":"=a" (__low), "=d" (__mod):"rm" (base), "0" (__low), "1" (__upper)); \
+	asm("":"=A" (n):"a" (__low),"d" (__high)); \
+	__mod; \
+})
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-m68k/div64.h linux/include/asm-m68k/div64.h
--- linux-2.2.16/include/asm-m68k/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-m68k/div64.h	Fri Aug 11 20:06:57 2000
@@ -0,0 +1,35 @@
+#ifndef _M68K_DIV64_H
+#define _M68K_DIV64_H
+
+/* n = n / base; return rem; */
+
+#if 1
+#define do_div(n, base) ({					\
+	union {							\
+		unsigned long n32[2];				\
+		unsigned long long n64;				\
+	} __n;							\
+	unsigned long __rem, __upper;				\
+								\
+	__n.n64 = (n);						\
+	if ((__upper = __n.n32[0])) {				\
+		asm ("divul.l %2,%1:%0"				\
+			: "=d" (__n.n32[0]), "=d" (__upper)	\
+			: "d" (base), "0" (__n.n32[0]));	\
+	}							\
+	asm ("divu.l %2,%1:%0"					\
+		: "=d" (__n.n32[1]), "=d" (__rem)		\
+		: "d" (base), "1" (__upper), "0" (__n.n32[1]));	\
+	(n) = __n.n64;						\
+	__rem;							\
+})
+#else
+#define do_div(n,base) ({					\
+	int __res;						\
+	__res = ((unsigned long) n) % (unsigned) base;		\
+	n = ((unsigned long) n) / (unsigned) base;		\
+	__res;							\
+})
+#endif
+
+#endif /* _M68K_DIV64_H */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-mips/div64.h linux/include/asm-mips/div64.h
--- linux-2.2.16/include/asm-mips/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-mips/div64.h	Fri Aug 11 20:41:49 2000
@@ -0,0 +1,20 @@
+/* $Id: div64.h,v 1.1.2.1 2000/08/12 00:41:49 zapman Exp $
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef _ASM_DIV64_H
+#define _ASM_DIV64_H
+
+/*
+ * Hey, we're already 64-bit, no
+ * need to play games..
+ */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) n) % (unsigned) base; \
+	n = ((unsigned long) n) / (unsigned) base; \
+	__res; })
+
+#endif /* _ASM_DIV64_H */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-ppc/div64.h linux/include/asm-ppc/div64.h
--- linux-2.2.16/include/asm-ppc/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-ppc/div64.h	Fri Aug 11 20:07:41 2000
@@ -0,0 +1,10 @@
+#ifndef __PPC_DIV64
+#define __PPC_DIV64
+
+#define do_div(n,base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-s390/div64.h linux/include/asm-s390/div64.h
--- linux-2.2.16/include/asm-s390/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-s390/div64.h	Fri Aug 11 20:08:05 2000
@@ -0,0 +1,10 @@
+#ifndef __S390_DIV64
+#define __S390_DIV64
+
+#define do_div(n,base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-sparc/div64.h linux/include/asm-sparc/div64.h
--- linux-2.2.16/include/asm-sparc/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-sparc/div64.h	Fri Aug 11 20:08:25 2000
@@ -0,0 +1,11 @@
+#ifndef __SPARC_DIV64
+#define __SPARC_DIV64
+
+/* We're not 64-bit, but... */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) n) % (unsigned) base; \
+	n = ((unsigned long) n) / (unsigned) base; \
+	__res; })
+
+#endif /* __SPARC_DIV64 */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-sparc64/div64.h linux/include/asm-sparc64/div64.h
--- linux-2.2.16/include/asm-sparc64/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-sparc64/div64.h	Fri Aug 11 20:08:42 2000
@@ -0,0 +1,14 @@
+#ifndef __SPARC64_DIV64
+#define __SPARC64_DIV64
+
+/*
+ * Hey, we're already 64-bit, no
+ * need to play games..
+ */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) n) % (unsigned) base; \
+	n = ((unsigned long) n) / (unsigned) base; \
+	__res; })
+
+#endif /* __SPARC64_DIV64 */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/lib/vsprintf.c linux/lib/vsprintf.c
--- linux-2.2.16/lib/vsprintf.c	Wed Aug  9 15:58:33 2000
+++ linux/lib/vsprintf.c	Fri Aug 11 20:13:09 2000
@@ -14,6 +14,8 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 
+#include <asm/div64.h>
+
 unsigned long simple_strtoul(const char *cp,char **endp,unsigned int base)
 {
 	unsigned long result = 0,value;
@@ -29,8 +31,8 @@
 			}
 		}
 	}
-	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
-	    ? toupper(*cp) : *cp)-'A'+10) < base) {
+	while (isxdigit(*cp) &&
+	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < base) {
 		result = result*base + value;
 		cp++;
 	}
@@ -46,14 +48,11 @@
 	return simple_strtoul(cp,endp,base);
 }
 
-/* we use this so that we can do without the ctype library */
-#define is_digit(c)	((c) >= '0' && (c) <= '9')
-
 static int skip_atoi(const char **s)
 {
 	int i=0;
 
-	while (is_digit(**s))
+	while (isdigit(**s))
 		i = i*10 + *((*s)++) - '0';
 	return i;
 }
@@ -66,14 +65,7 @@
 #define SPECIAL	32		/* 0x */
 #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
 
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-static char * number(char * str, long num, int base, int size, int precision
-	,int type)
+static char * number(char * str, long long num, int base, int size, int precision, int type)
 {
 	char c,sign,tmp[66];
 	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
@@ -145,7 +137,7 @@
 int vsprintf(char *buf, const char *fmt, va_list args)
 {
 	int len;
-	unsigned long num;
+	unsigned long long num;
 	int i, base;
 	char * str;
 	const char *s;
@@ -156,7 +148,10 @@
 	int precision;		/* min. # of digits for integers; max
 				   number of chars for from string */
 	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+	                        /* 'z' support added 23/7/1999 S.H.    */
+				/* 'z' changed to 'Z' --davidm 1/25/99 */
 
+	
 	for (str=buf ; *fmt ; ++fmt) {
 		if (*fmt != '%') {
 			*str++ = *fmt;
@@ -177,7 +172,7 @@
 		
 		/* get field width */
 		field_width = -1;
-		if (is_digit(*fmt))
+		if (isdigit(*fmt))
 			field_width = skip_atoi(&fmt);
 		else if (*fmt == '*') {
 			++fmt;
@@ -193,7 +188,7 @@
 		precision = -1;
 		if (*fmt == '.') {
 			++fmt;	
-			if (is_digit(*fmt))
+			if (isdigit(*fmt))
 				precision = skip_atoi(&fmt);
 			else if (*fmt == '*') {
 				++fmt;
@@ -206,7 +201,7 @@
 
 		/* get the conversion qualifier */
 		qualifier = -1;
-		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
+		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt =='Z') {
 			qualifier = *fmt;
 			++fmt;
 		}
@@ -255,6 +250,9 @@
 			if (qualifier == 'l') {
 				long * ip = va_arg(args, long *);
 				*ip = (str - buf);
+			} else if (qualifier == 'Z') {
+				size_t * ip = va_arg(args, size_t *);
+				*ip = (str - buf);
 			} else {
 				int * ip = va_arg(args, int *);
 				*ip = (str - buf);
@@ -290,16 +288,23 @@
 				--fmt;
 			continue;
 		}
-		if (qualifier == 'l')
+		if (qualifier == 'L')
+			num = va_arg(args, long long);
+		else if (qualifier == 'l') {
 			num = va_arg(args, unsigned long);
-		else if (qualifier == 'h') {
+			if (flags & SIGN)
+				num = (signed long) num;
+		} else if (qualifier == 'Z') {
+			num = va_arg(args, size_t);
+		} else if (qualifier == 'h') {
 			num = (unsigned short) va_arg(args, int);
 			if (flags & SIGN)
-				num = (short) num;
-		} else if (flags & SIGN)
-			num = va_arg(args, int);
-		else
+				num = (signed short) num;
+		} else {
 			num = va_arg(args, unsigned int);
+			if (flags & SIGN)
+				num = (signed int) num;
+		}
 		str = number(str, num, base, field_width, precision, flags);
 	}
 	*str = '\0';


--------------030108080502030708090105
Content-Type: text/plain;
 name="printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printk.patch"

diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-alpha/div64.h linux/include/asm-alpha/div64.h
--- linux-2.2.16/include/asm-alpha/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-alpha/div64.h	Fri Aug 11 20:04:18 2000
@@ -0,0 +1,14 @@
+#ifndef __ALPHA_DIV64
+#define __ALPHA_DIV64
+
+/*
+ * Hey, we're already 64-bit, no
+ * need to play games..
+ */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) (n)) % (unsigned) (base); \
+	(n) = ((unsigned long) (n)) / (unsigned) (base); \
+	__res; })
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-arm/div64.h linux/include/asm-arm/div64.h
--- linux-2.2.16/include/asm-arm/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-arm/div64.h	Fri Aug 11 20:05:41 2000
@@ -0,0 +1,14 @@
+#ifndef __ASM_ARM_DIV64
+#define __ASM_ARM_DIV64
+
+/* We're not 64-bit, but... */
+#define do_div(n,base)						\
+({								\
+	int __res;						\
+	__res = ((unsigned long)n) % (unsigned int)base;	\
+	n = ((unsigned long)n) / (unsigned int)base;		\
+	__res;							\
+})
+
+#endif
+
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-i386/div64.h linux/include/asm-i386/div64.h
--- linux-2.2.16/include/asm-i386/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-i386/div64.h	Fri Aug 11 20:06:05 2000
@@ -0,0 +1,17 @@
+#ifndef __I386_DIV64
+#define __I386_DIV64
+
+#define do_div(n,base) ({ \
+	unsigned long __upper, __low, __high, __mod; \
+	asm("":"=a" (__low), "=d" (__high):"A" (n)); \
+	__upper = __high; \
+	if (__high) { \
+		__upper = __high % (base); \
+		__high = __high / (base); \
+	} \
+	asm("divl %2":"=a" (__low), "=d" (__mod):"rm" (base), "0" (__low), "1" (__upper)); \
+	asm("":"=A" (n):"a" (__low),"d" (__high)); \
+	__mod; \
+})
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-m68k/div64.h linux/include/asm-m68k/div64.h
--- linux-2.2.16/include/asm-m68k/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-m68k/div64.h	Fri Aug 11 20:06:57 2000
@@ -0,0 +1,35 @@
+#ifndef _M68K_DIV64_H
+#define _M68K_DIV64_H
+
+/* n = n / base; return rem; */
+
+#if 1
+#define do_div(n, base) ({					\
+	union {							\
+		unsigned long n32[2];				\
+		unsigned long long n64;				\
+	} __n;							\
+	unsigned long __rem, __upper;				\
+								\
+	__n.n64 = (n);						\
+	if ((__upper = __n.n32[0])) {				\
+		asm ("divul.l %2,%1:%0"				\
+			: "=d" (__n.n32[0]), "=d" (__upper)	\
+			: "d" (base), "0" (__n.n32[0]));	\
+	}							\
+	asm ("divu.l %2,%1:%0"					\
+		: "=d" (__n.n32[1]), "=d" (__rem)		\
+		: "d" (base), "1" (__upper), "0" (__n.n32[1]));	\
+	(n) = __n.n64;						\
+	__rem;							\
+})
+#else
+#define do_div(n,base) ({					\
+	int __res;						\
+	__res = ((unsigned long) n) % (unsigned) base;		\
+	n = ((unsigned long) n) / (unsigned) base;		\
+	__res;							\
+})
+#endif
+
+#endif /* _M68K_DIV64_H */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-mips/div64.h linux/include/asm-mips/div64.h
--- linux-2.2.16/include/asm-mips/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-mips/div64.h	Fri Aug 11 20:41:49 2000
@@ -0,0 +1,20 @@
+/* $Id: div64.h,v 1.1.2.1 2000/08/12 00:41:49 zapman Exp $
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef _ASM_DIV64_H
+#define _ASM_DIV64_H
+
+/*
+ * Hey, we're already 64-bit, no
+ * need to play games..
+ */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) n) % (unsigned) base; \
+	n = ((unsigned long) n) / (unsigned) base; \
+	__res; })
+
+#endif /* _ASM_DIV64_H */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-ppc/div64.h linux/include/asm-ppc/div64.h
--- linux-2.2.16/include/asm-ppc/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-ppc/div64.h	Fri Aug 11 20:07:41 2000
@@ -0,0 +1,10 @@
+#ifndef __PPC_DIV64
+#define __PPC_DIV64
+
+#define do_div(n,base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-s390/div64.h linux/include/asm-s390/div64.h
--- linux-2.2.16/include/asm-s390/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-s390/div64.h	Fri Aug 11 20:08:05 2000
@@ -0,0 +1,10 @@
+#ifndef __S390_DIV64
+#define __S390_DIV64
+
+#define do_div(n,base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+#endif
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-sparc/div64.h linux/include/asm-sparc/div64.h
--- linux-2.2.16/include/asm-sparc/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-sparc/div64.h	Fri Aug 11 20:08:25 2000
@@ -0,0 +1,11 @@
+#ifndef __SPARC_DIV64
+#define __SPARC_DIV64
+
+/* We're not 64-bit, but... */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) n) % (unsigned) base; \
+	n = ((unsigned long) n) / (unsigned) base; \
+	__res; })
+
+#endif /* __SPARC_DIV64 */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/include/asm-sparc64/div64.h linux/include/asm-sparc64/div64.h
--- linux-2.2.16/include/asm-sparc64/div64.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-sparc64/div64.h	Fri Aug 11 20:08:42 2000
@@ -0,0 +1,14 @@
+#ifndef __SPARC64_DIV64
+#define __SPARC64_DIV64
+
+/*
+ * Hey, we're already 64-bit, no
+ * need to play games..
+ */
+#define do_div(n,base) ({ \
+	int __res; \
+	__res = ((unsigned long) n) % (unsigned) base; \
+	n = ((unsigned long) n) / (unsigned) base; \
+	__res; })
+
+#endif /* __SPARC64_DIV64 */
diff -B --unidirectional-new-file --exclude-from=DiffExcludeList --recursive --unified linux-2.2.16/lib/vsprintf.c linux/lib/vsprintf.c
--- linux-2.2.16/lib/vsprintf.c	Wed Aug  9 15:58:33 2000
+++ linux/lib/vsprintf.c	Fri Aug 11 20:13:09 2000
@@ -14,6 +14,8 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 
+#include <asm/div64.h>
+
 unsigned long simple_strtoul(const char *cp,char **endp,unsigned int base)
 {
 	unsigned long result = 0,value;
@@ -29,8 +31,8 @@
 			}
 		}
 	}
-	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
-	    ? toupper(*cp) : *cp)-'A'+10) < base) {
+	while (isxdigit(*cp) &&
+	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < base) {
 		result = result*base + value;
 		cp++;
 	}
@@ -46,14 +48,11 @@
 	return simple_strtoul(cp,endp,base);
 }
 
-/* we use this so that we can do without the ctype library */
-#define is_digit(c)	((c) >= '0' && (c) <= '9')
-
 static int skip_atoi(const char **s)
 {
 	int i=0;
 
-	while (is_digit(**s))
+	while (isdigit(**s))
 		i = i*10 + *((*s)++) - '0';
 	return i;
 }
@@ -66,14 +65,7 @@
 #define SPECIAL	32		/* 0x */
 #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
 
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-static char * number(char * str, long num, int base, int size, int precision
-	,int type)
+static char * number(char * str, long long num, int base, int size, int precision, int type)
 {
 	char c,sign,tmp[66];
 	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
@@ -145,7 +137,7 @@
 int vsprintf(char *buf, const char *fmt, va_list args)
 {
 	int len;
-	unsigned long num;
+	unsigned long long num;
 	int i, base;
 	char * str;
 	const char *s;
@@ -156,7 +148,10 @@
 	int precision;		/* min. # of digits for integers; max
 				   number of chars for from string */
 	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+	                        /* 'z' support added 23/7/1999 S.H.    */
+				/* 'z' changed to 'Z' --davidm 1/25/99 */
 
+	
 	for (str=buf ; *fmt ; ++fmt) {
 		if (*fmt != '%') {
 			*str++ = *fmt;
@@ -177,7 +172,7 @@
 		
 		/* get field width */
 		field_width = -1;
-		if (is_digit(*fmt))
+		if (isdigit(*fmt))
 			field_width = skip_atoi(&fmt);
 		else if (*fmt == '*') {
 			++fmt;
@@ -193,7 +188,7 @@
 		precision = -1;
 		if (*fmt == '.') {
 			++fmt;	
-			if (is_digit(*fmt))
+			if (isdigit(*fmt))
 				precision = skip_atoi(&fmt);
 			else if (*fmt == '*') {
 				++fmt;
@@ -206,7 +201,7 @@
 
 		/* get the conversion qualifier */
 		qualifier = -1;
-		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
+		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt =='Z') {
 			qualifier = *fmt;
 			++fmt;
 		}
@@ -255,6 +250,9 @@
 			if (qualifier == 'l') {
 				long * ip = va_arg(args, long *);
 				*ip = (str - buf);
+			} else if (qualifier == 'Z') {
+				size_t * ip = va_arg(args, size_t *);
+				*ip = (str - buf);
 			} else {
 				int * ip = va_arg(args, int *);
 				*ip = (str - buf);
@@ -290,16 +288,23 @@
 				--fmt;
 			continue;
 		}
-		if (qualifier == 'l')
+		if (qualifier == 'L')
+			num = va_arg(args, long long);
+		else if (qualifier == 'l') {
 			num = va_arg(args, unsigned long);
-		else if (qualifier == 'h') {
+			if (flags & SIGN)
+				num = (signed long) num;
+		} else if (qualifier == 'Z') {
+			num = va_arg(args, size_t);
+		} else if (qualifier == 'h') {
 			num = (unsigned short) va_arg(args, int);
 			if (flags & SIGN)
-				num = (short) num;
-		} else if (flags & SIGN)
-			num = va_arg(args, int);
-		else
+				num = (signed short) num;
+		} else {
 			num = va_arg(args, unsigned int);
+			if (flags & SIGN)
+				num = (signed int) num;
+		}
 		str = number(str, num, base, field_width, precision, flags);
 	}
 	*str = '\0';

--------------030108080502030708090105--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
