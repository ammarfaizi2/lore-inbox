Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSA2AAh>; Mon, 28 Jan 2002 19:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSA2AAU>; Mon, 28 Jan 2002 19:00:20 -0500
Received: from altus.drgw.net ([209.234.73.40]:21772 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S287809AbSA2AAD>;
	Mon, 28 Jan 2002 19:00:03 -0500
Date: Mon, 28 Jan 2002 18:00:01 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linux-kernel@vger.kernel.org
Subject: 64-bit divide cleanup (tested on ppc)
Message-ID: <20020128180001.G14339@altus.drgw.net>
In-Reply-To: <87r8oez0ks.fsf@fadata.bg> <20020127205141.L5808@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020127205141.L5808@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Sun, Jan 27, 2002 at 08:51:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a patch to get rid of asm/div64.h on arches that don't have 
optimized asm routines.

I didn't include removeing the various arch/div64.h file yet, since I want 
some comments on this.



--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=div64-patch

Index: drivers/acpi/include/platform/aclinux.h
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/drivers/acpi/include/platform/aclinux.h,v
retrieving revision 1.1
diff -u -r1.1 aclinux.h
--- drivers/acpi/include/platform/aclinux.h	2001/11/30 22:29:16	1.1
+++ drivers/acpi/include/platform/aclinux.h	2002/01/29 00:40:01
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
+++ drivers/net/sk98lin/skproc.c	2002/01/29 00:40:08
@@ -296,60 +296,6 @@
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
@@ -398,7 +344,7 @@
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
+++ drivers/video/matrox/matroxfb_maven.c	2002/01/29 00:40:12
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
@@ -709,7 +709,7 @@
 				b = (mt->VTotal - 1) * (m->htotal + 2) + m->hcorr + 2;
 
 				f1 = ((u64)a) << 15;	/* *32768 */
-				do_div(f1, b);
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
+++ fs/affs/file.c	2002/01/29 00:40:13
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
+++ fs/affs/inode.c	2002/01/29 00:40:13
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
+++ fs/ntfs/util.c	2002/01/29 00:40:14
@@ -13,7 +13,8 @@
 #include "util.h"
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <asm/div64.h>		/* For do_div(). */
+#define USE_SLOW_64BIT_DIVIDES
+#include <linux/div64.h>		/* For do_div(). */
 #include "support.h"
 
 /*
@@ -233,7 +234,7 @@
 {
 	/* Subtract the NTFS time offset, then convert to 1s intervals. */
 	ntfs_time64_t t = ntutc - NTFS_TIME_OFFSET;
-	do_div(t, 10000000);
+	do_div(&t, 10000000);
 	return (ntfs_time_t)t;
 }
 
Index: fs/smbfs/proc.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/fs/smbfs/proc.c,v
retrieving revision 1.1
diff -u -r1.1 proc.c
--- fs/smbfs/proc.c	2001/11/30 22:28:58	1.1
+++ fs/smbfs/proc.c	2002/01/29 00:40:17
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
@@ -375,7 +377,7 @@
 	/* FIXME: what about the timezone difference? */
 	/* Subtract the NTFS time offset, then convert to 1s intervals. */
 	u64 t = ntutc - NTFS_TIME_OFFSET;
-	do_div(t, 10000000);
+	do_div(&t, 10000000);
 	return (time_t)t;
 }
 
Index: lib/vsprintf.c
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/lib/vsprintf.c,v
retrieving revision 1.1
diff -u -r1.1 vsprintf.c
--- lib/vsprintf.c	2001/11/30 22:28:59	1.1
+++ lib/vsprintf.c	2002/01/29 00:40:24
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
Index: include/linux/div64.h
===================================================================
RCS file: /cvsdev/hhl-2.4.17/linux/include/linux/div64.h
diff -N div64.h
--- /dev/null	Tue May  5 13:32:27 1998
+++ include/linux/div64.h	Mon Jan 28 16:59:28 2002
@@ -0,0 +1,85 @@
+/*
+ * include/linux/div64.h
+ *
+ * Primarily used by vsprintf to divide a 64 bit int N by a small integer base
+ * We really do NOT want to encourage people to do slow 64 bit divides in
+ * the kernel, so the 'default' version of this function panics if you
+ * try and divide a 64 bit number by anything other than 8 or 16.
+ *
+ * If you really *really* need this, and are prepared to be flamed by 
+ * lkml, #define USE_SLOW_64BIT_DIVIDES before including this file.
+ */
+#ifndef __DIV64
+#define __DIV64
+
+#include <linux/config.h>
+
+/* configurable  */
+#undef __USE_ASM
+
+
+#ifdef __USE_ASM
+/* yeah, this is a mess, and leaves out m68k.... */
+# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) || defined(CONFIG_MIPS)
+#  define __USE_ASM__
+# endif
+#endif
+
+#ifdef __USE_ASM__
+#include <asm/div64.h>
+#else /* __USE_ASM__ */
+static inline int do_div(unsigned long long * n, unsigned long base)
+{
+	int res = 0;
+	unsigned long long t = *n;
+	if ( t == (unsigned long)t ){ /* this should handle 64 bit platforms */
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
+				panic("do_div called with 64 bit arg and unsupported base\n", base);
+		}
+#else /* USE_SLOW_64BIT_DIVIDES */
+		/* this was stolen from the old asm-parisc/div64.h */
+		/*
+		 * Copyright (C) 1999 Hewlett-Packard Co
+		 * Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
+		 *
+		 * vsprintf uses this to divide a 64-bit integer N by a small 
+		 * integer BASE. This is incredibly hard on IA-64 and HPPA
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

--jy6Sn24JjFx/iggw--
