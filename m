Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290634AbSBOSs3>; Fri, 15 Feb 2002 13:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290618AbSBOSsU>; Fri, 15 Feb 2002 13:48:20 -0500
Received: from altus.drgw.net ([209.234.73.40]:29957 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S290636AbSBOSrs>;
	Fri, 15 Feb 2002 13:47:48 -0500
Date: Fri, 15 Feb 2002 12:47:22 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>, wli@holomorphy.com,
        linux-kernel@vger.kernel.org, Gabriel Paubert <paubert@iram.es>
Subject: Updated div64.h cleanup
Message-ID: <20020215124722.D1211@altus.drgw.net>
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <20020207234555.N17426@altus.drgw.net> <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <20020208115726.U17426@altus.drgw.net> <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Feb 08, 2002 at 07:34:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's anothing try at an acceptable div64.h cleanup.

I would appreciate if someone could verify that what I did in the 
matrox_maven.c file is correct.

Index: drivers/acpi/include/platform/aclinux.h
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/drivers/acpi/include/platform/aclinux.h,v
retrieving revision 1.1
diff -u -r1.1 aclinux.h
--- drivers/acpi/include/platform/aclinux.h	2001/11/30 22:29:16	1.1
+++ drivers/acpi/include/platform/aclinux.h	2002/02/15 00:47:05
@@ -36,9 +36,9 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
+
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <asm/div64.h>
 
 #define strtoul simple_strtoul
 
Index: drivers/net/sk98lin/skproc.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/drivers/net/sk98lin/skproc.c,v
retrieving revision 1.1
diff -u -r1.1 skproc.c
--- drivers/net/sk98lin/skproc.c	2001/11/30 22:29:08	1.1
+++ drivers/net/sk98lin/skproc.c	2002/02/15 00:47:13
@@ -43,6 +43,8 @@
  ******************************************************************************/
 
 #include <linux/proc_fs.h>
+#define USE_SLOW_64BIT_DIVIDES
+#include <linux/div64.h>
 
 #include "h/skdrv1st.h"
 #include "h/skdrv2nd.h"
@@ -296,60 +298,6 @@
 	return (min_t(int, buffer_length, len - offset));
 }
 
-
-
-
-
-/*****************************************************************************
- *
- * SkDoDiv - convert 64bit number
- *
- * Description:
- *	This function "converts" a long long number.
- *
- * Returns:
- *	remainder of division
- */
-static long SkDoDiv (long long Dividend, int Divisor, long long *pErg)
-{
- long   	Rest;
- long long 	Ergebnis;
- long   	Akku;
-
-
- Akku  = Dividend >> 32;
-
- Ergebnis = ((long long) (Akku / Divisor)) << 32;
- Rest = Akku % Divisor ;
-
- Akku = Rest << 16;
- Akku |= ((Dividend & 0xFFFF0000) >> 16);
-
-
- Ergebnis += ((long long) (Akku / Divisor)) << 16;
- Rest = Akku % Divisor ;
-
- Akku = Rest << 16;
- Akku |= (Dividend & 0xFFFF);
-
- Ergebnis += (Akku / Divisor);
- Rest = Akku % Divisor ;
-
- *pErg = Ergebnis;
- return (Rest);
-}
-
-
-#if 0
-#define do_div(n,base) ({ \
-long long __res; \
-__res = ((unsigned long long) n) % (unsigned) base; \
-n = ((unsigned long long) n) / (unsigned) base; \
-__res; })
-
-#endif
-
-
 /*****************************************************************************
  *
  * SkNumber - Print results
@@ -398,7 +346,7 @@
 	if (num == 0)
 		tmp[i++]='0';
 	else while (num != 0)
-		tmp[i++] = digits[SkDoDiv(num,base, &num)];
+		tmp[i++] = digits[do_div(&num,base)];
 
 	if (i > precision)
 		precision = i;
Index: drivers/video/matrox/matroxfb_maven.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/drivers/video/matrox/matroxfb_maven.c,v
retrieving revision 1.1
diff -u -r1.1 matroxfb_maven.c
--- drivers/video/matrox/matroxfb_maven.c	2001/11/30 22:29:14	1.1
+++ drivers/video/matrox/matroxfb_maven.c	2002/02/15 00:47:17
@@ -15,7 +15,8 @@
 #include "matroxfb_DAC1064.h"
 #include <linux/i2c.h>
 #include <linux/matroxfb.h>
-#include <asm/div64.h>
+#define USE_SLOW_64BIT_DIVIDES
+#include <linux/div64.h>
 #include <asm/uaccess.h>
 
 #define MAVEN_I2CID	(0x1B)
@@ -698,9 +699,8 @@
 			int vdec;
 			int vlen;
 
-#define MATROX_USE64BIT_DIVIDE
 			if (mt->VTotal) {
-#ifdef MATROX_USE64BIT_DIVIDE
+#ifdef USE_SLOW_64BIT_DIVIDES
 				u64 f1;
 				u32 a;
 				u32 b;
@@ -709,7 +709,11 @@
 				b = (mt->VTotal - 1) * (m->htotal + 2) + m->hcorr + 2;
 
 				f1 = ((u64)a) << 15;	/* *32768 */
-				do_div(f1, b);
+				if (b > 65535){ /* messy stuff to make sure b is less than 65536 */
+					do_div(&f1, b & 0xffff);
+					b = (b & 0xffff0000)/(b & 0xffff) + 1;
+				}
+				do_div(&f1, b);
 				vdec = f1;
 #else
 				vdec = m->vlines * 32768 / mt->VTotal;
Index: fs/affs/file.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/fs/affs/file.c,v
retrieving revision 1.1
diff -u -r1.1 file.c
--- fs/affs/file.c	2001/11/30 22:28:58	1.1
+++ fs/affs/file.c	2002/02/15 00:47:18
@@ -12,7 +12,6 @@
  *  affs regular file handling primitives
  */
 
-#include <asm/div64.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/sched.h>
Index: fs/affs/inode.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/fs/affs/inode.c,v
retrieving revision 1.1
diff -u -r1.1 inode.c
--- fs/affs/inode.c	2001/11/30 22:28:58	1.1
+++ fs/affs/inode.c	2002/02/15 00:47:19
@@ -10,7 +10,6 @@
  *  (C) 1991  Linus Torvalds - minix filesystem
  */
 
-#include <asm/div64.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
Index: fs/ntfs/util.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/fs/ntfs/util.c,v
retrieving revision 1.1
diff -u -r1.1 util.c
--- fs/ntfs/util.c	2001/11/30 22:28:59	1.1
+++ fs/ntfs/util.c	2002/02/15 00:47:20
@@ -13,7 +13,8 @@
 #include "util.h"
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <asm/div64.h>		/* For do_div(). */
+#define USE_SLOW_64BIT_DIVIDES
+#include <linux/div64.h>		/* For do_div(). */
 #include "support.h"
 
 /*
@@ -233,7 +234,8 @@
 {
 	/* Subtract the NTFS time offset, then convert to 1s intervals. */
 	ntfs_time64_t t = ntutc - NTFS_TIME_OFFSET;
-	do_div(t, 10000000);
+	do_div(&t, 10000);
+	do_div(&t, 1000);	/* divide by 10000000 */
 	return (ntfs_time_t)t;
 }
 
Index: fs/smbfs/proc.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/fs/smbfs/proc.c,v
retrieving revision 1.1
diff -u -r1.1 proc.c
--- fs/smbfs/proc.c	2001/11/30 22:28:58	1.1
+++ fs/smbfs/proc.c	2002/02/15 00:47:23
@@ -18,12 +18,14 @@
 #include <linux/dirent.h>
 #include <linux/nls.h>
 
+#define USE_SLOW_64BIT_DIVIDES
+#include <linux/div64.h>
+
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
 #include <linux/smb_mount.h>
 
 #include <asm/string.h>
-#include <asm/div64.h>
 
 #include "smb_debug.h"
 #include "proto.h"
@@ -375,7 +377,8 @@
 	/* FIXME: what about the timezone difference? */
 	/* Subtract the NTFS time offset, then convert to 1s intervals. */
 	u64 t = ntutc - NTFS_TIME_OFFSET;
-	do_div(t, 10000000);
+	do_div(&t, 10000);
+	do_div(&t, 1000);
 	return (time_t)t;
 }
 
Index: include/asm-alpha/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvs4OfhPk	Thu Feb 14 16:48:20 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,14 +0,0 @@
-#ifndef __ALPHA_DIV64
-#define __ALPHA_DIV64
-
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) (n)) % (unsigned) (base); \
-	(n) = ((unsigned long) (n)) / (unsigned) (base); \
-	__res; })
-
-#endif
Index: include/asm-arm/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsFC1yur	Thu Feb 14 16:48:20 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,14 +0,0 @@
-#ifndef __ASM_ARM_DIV64
-#define __ASM_ARM_DIV64
-
-/* We're not 64-bit, but... */
-#define do_div(n,base)						\
-({								\
-	int __res;						\
-	__res = ((unsigned long)n) % (unsigned int)base;	\
-	n = ((unsigned long)n) / (unsigned int)base;		\
-	__res;							\
-})
-
-#endif
-
Index: include/asm-cris/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsYOw3W7	Thu Feb 14 16:48:20 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,16 +0,0 @@
-#ifndef __ASM_CRIS_DIV64
-#define __ASM_CRIS_DIV64
-
-/* copy from asm-arm */
-
-/* We're not 64-bit, but... */
-#define do_div(n,base)						\
-({								\
-	int __res;						\
-	__res = ((unsigned long)n) % (unsigned int)base;	\
-	n = ((unsigned long)n) / (unsigned int)base;		\
-	__res;							\
-})
-
-#endif
-
Index: include/asm-ia64/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvshL7A10	Thu Feb 14 16:48:20 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,20 +0,0 @@
-#ifndef _ASM_IA64_DIV64_H
-#define _ASM_IA64_DIV64_H
-
-/*
- * Copyright (C) 1999 Hewlett-Packard Co
- * Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
- *
- * vsprintf uses this to divide a 64-bit integer N by a small integer BASE.
- * This is incredibly hard on IA-64...
- */
-
-#define do_div(n,base)						\
-({								\
-	int _res;						\
-	_res = ((unsigned long) (n)) % (unsigned) (base);	\
-	(n) = ((unsigned long) (n)) / (unsigned) (base);	\
-	_res;							\
-})
-
-#endif /* _ASM_IA64_DIV64_H */
Index: include/asm-mips64/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsjVZJpB	Thu Feb 14 16:48:21 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,19 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef _ASM_DIV64_H
-#define _ASM_DIV64_H
-
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
-
-#endif /* _ASM_DIV64_H */
Index: include/asm-parisc/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsvkng5v	Thu Feb 14 16:48:21 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,54 +0,0 @@
-#ifndef __ASM_PARISC_DIV64
-#define __ASM_PARISC_DIV64
-
-#ifdef __LP64__
-
-/*
- * Copyright (C) 1999 Hewlett-Packard Co
- * Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
- *
- * vsprintf uses this to divide a 64-bit integer N by a small integer BASE.
- * This is incredibly hard on IA-64 and HPPA
- */
-
-#define do_div(n,base)						\
-({								\
-	int _res;						\
-	_res = ((unsigned long) (n)) % (unsigned) (base);	\
-	(n) = ((unsigned long) (n)) / (unsigned) (base);	\
-	_res;							\
-})
-
-#else
-/*
- * unsigned long long division.  Yuck Yuck!  What is Linux coming to?
- * This is 100% disgusting
- */
-#define do_div(n,base)							\
-({									\
-	unsigned long __low, __low2, __high, __rem;			\
-	__low  = (n) & 0xffffffff;					\
-	__high = (n) >> 32;						\
-	if (__high) {							\
-		__rem   = __high % (unsigned long)base;			\
-		__high  = __high / (unsigned long)base;			\
-		__low2  = __low >> 16;					\
-		__low2 += __rem << 16;					\
-		__rem   = __low2 % (unsigned long)base;			\
-		__low2  = __low2 / (unsigned long)base;			\
-		__low   = __low & 0xffff;				\
-		__low  += __rem << 16;					\
-		__rem   = __low  % (unsigned long)base;			\
-		__low   = __low  / (unsigned long)base;			\
-		n = __low  + ((long long)__low2 << 16) +		\
-			((long long) __high << 32);			\
-	} else {							\
-		__rem = __low % (unsigned long)base;			\
-		n = (__low / (unsigned long)base);			\
-	}								\
-	__rem;								\
-})
-#endif
-
-#endif
-
Index: include/asm-ppc/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsl8SXkz	Thu Feb 14 16:48:21 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,13 +0,0 @@
-/*
- * BK Id: SCCS/s.div64.h 1.5 05/17/01 18:14:24 cort
- */
-#ifndef __PPC_DIV64
-#define __PPC_DIV64
-
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-#endif
Index: include/asm-s390x/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvs0sUH4K	Thu Feb 14 16:48:22 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,10 +0,0 @@
-#ifndef __S390_DIV64
-#define __S390_DIV64
-
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-#endif
Index: include/asm-sh/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsvYhpX1	Thu Feb 14 16:48:22 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,10 +0,0 @@
-#ifndef __ASM_SH_DIV64
-#define __ASM_SH_DIV64
-
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-#endif /* __ASM_SH_DIV64 */
Index: include/asm-sparc/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsgmV0Up	Thu Feb 14 16:48:22 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,11 +0,0 @@
-#ifndef __SPARC_DIV64
-#define __SPARC_DIV64
-
-/* We're not 64-bit, but... */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
-
-#endif /* __SPARC_DIV64 */
Index: include/asm-sparc64/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /tmp/cvsRaRtBV	Thu Feb 14 16:48:22 2002
+++ /dev/null	Tue May  5 13:32:27 1998
@@ -1,14 +0,0 @@
-#ifndef __SPARC64_DIV64
-#define __SPARC64_DIV64
-
-/*
- * Hey, we're already 64-bit, no
- * need to play games..
- */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
-
-#endif /* __SPARC64_DIV64 */
Index: include/linux/div64.h
===================================================================
RCS file: div64.h
diff -N div64.h
--- /dev/null	Tue May  5 13:32:27 1998
+++ div64.h	Thu Feb 14 16:47:33 2002
@@ -0,0 +1,89 @@
+/*
+ * include/linux/div64.h
+ *
+ * Primarily used by vsprintf to divide a 64 bit int N by a small integer base
+ * and provide both quotient and remainder.
+ * 
+ * We really do NOT want to encourage people to do slow 64 bit divides in
+ * the kernel, so the 'default' version of this function prints a warning
+ * try and divide a 64 bit number by anything other than 8 or 16.
+ *
+ * If you really *really* need this, #define USE_SLOW_64BIT_DIVIDES 
+ * before including this file.
+ *
+ * 
+ */
+#ifndef __DIV64
+#define __DIV64
+
+#include <linux/config.h>
+#include <asm/processor.h>
+
+/* configurable, define this if you want the original ASM */
+#undef __USE_ASM
+
+
+#ifdef __USE_ASM
+/* yeah, this is a mess, and leaves out m68k.... */
+# if defined(CONFIG_X86) || defined(CONFIG_ARCH_S390) || defined(CONFIG_MIPS) || defined(__mc68000__)
+#  define __USE_ASM__
+# endif
+#endif
+
+#ifdef __USE_ASM__
+#include <asm/div64.h>
+#else /* __USE_ASM__ */
+static inline int do_div(unsigned long long * n, uint16_t base)
+{
+	int res = 0;
+	unsigned long long t = *n;
+	/* this should handle 64 bit platforms, as well as
+	 * the case of n < 32 bits (vsprintf does this a lot) */
+	if ((BITS_PER_LONG == 64) || (t == (unsigned long)t)){
+		res = ((unsigned long) t) % base;
+		t = ((unsigned long) t) / base;
+	} else {
+#ifndef USE_SLOW_64BIT_DIVIDES 
+		switch (base) {
+			case 8:
+				res = ((unsigned long) t & 0x7);
+				t = t >> 3;
+				break;
+			case 16:
+				res = ((unsigned long) t & 0xf);
+				t = t >> 4;
+				break;
+			default:
+				printk(KERN_WARNING "do_div called at 0x%x\n with unsupported base %d", current_text_addr(), base);
+				t = 0;
+				res = 0;
+		}
+#else /* USE_SLOW_64BIT_DIVIDES */
+		/*
+		 * generic C 64 bit divide for a 'small' base ( < 65536)
+		 */
+		unsigned long low, low2, high;
+		low  = (t) & 0xffffffff;
+		high = (t) >> 32;
+		res   = high % base;
+		high  = high / base;
+		low2  = low >> 16;
+		low2 += res << 16;
+		res   = low2 % base;
+		low2  = low2 / base;
+		low   = low & 0xffff;
+		low  += res << 16;
+		res   = low  % base;
+		low   = low  / base;
+		t = low  + ((long long)low2 << 16) +
+			((long long) high << 32);
+#endif  /* USE_SLOW_64BIT_DIVIDES */
+	}
+	*n = t;
+	return res;
+}
+
+
+#endif /* __USE_ASM__ */
+
+#endif
Index: lib/vsprintf.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/lib/vsprintf.c,v
retrieving revision 1.1
diff -u -r1.1 vsprintf.c
--- lib/vsprintf.c	2001/11/30 22:28:59	1.1
+++ lib/vsprintf.c	2002/02/15 00:47:56
@@ -19,9 +19,9 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+/* #define USE_SLOW_64BIT_DIVIDE */
+#include <linux/div64.h>
 
-#include <asm/div64.h>
-
 /**
  * simple_strtoul - convert a string to an unsigned long
  * @cp: The start of the string
@@ -165,7 +165,7 @@
 	if (num == 0)
 		tmp[i++]='0';
 	else while (num != 0)
-		tmp[i++] = digits[do_div(num,base)];
+		tmp[i++] = digits[do_div(&num,base)];
 	if (i > precision)
 		precision = i;
 	size -= precision;
@@ -426,22 +426,31 @@
 				}
 				continue;
 		}
-		if (qualifier == 'L')
+
+		switch (qualifier) {
+		case 'L':
 			num = va_arg(args, long long);
-		else if (qualifier == 'l') {
-			num = va_arg(args, unsigned long);
+			break;
+		case 'l':
 			if (flags & SIGN)
-				num = (signed long) num;
-		} else if (qualifier == 'Z') {
+				num = (signed long long) va_arg(args, long);
+			else
+				num = va_arg(args, unsigned long);
+			break;
+		case 'Z':
 			num = va_arg(args, size_t);
-		} else if (qualifier == 'h') {
-			num = (unsigned short) va_arg(args, int);
+			break;
+		case 'h':
 			if (flags & SIGN)
-				num = (signed short) num;
-		} else {
-			num = va_arg(args, unsigned int);
+				num = (signed long long) va_arg(args, int);
+			else
+				num = va_arg(args, unsigned int);
+			break;
+		default:
 			if (flags & SIGN)
-				num = (signed int) num;
+				num = (signed long long) va_arg(args, int);
+			else
+				num = va_arg(args, unsigned int);
 		}
 		str = number(str, end, num, base,
 				field_width, precision, flags);
