Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289663AbSBFJxN>; Wed, 6 Feb 2002 04:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290062AbSBFJwz>; Wed, 6 Feb 2002 04:52:55 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:207 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289663AbSBFJwk>; Wed, 6 Feb 2002 04:52:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.4-pre1, move zlib headers to the right place
Date: Wed, 6 Feb 2002 10:52:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YOkR-0002WF-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The files zconf.h and zutil.h are in the linux/ directory; they should be
in include/linux/
This patch moves them there (and deletes the spurious linux directory).
Of course, it is probably easier just to move them there by hand!

Duncan.

diff -urN kernel-source-2.5.4-pre1-orig/include/linux/zconf.h kernel-source-2.5.4-pre1-new/include/linux/zconf.h
--- kernel-source-2.5.4-pre1-orig/include/linux/zconf.h	Thu Jan  1 01:00:00 1970
+++ kernel-source-2.5.4-pre1-new/include/linux/zconf.h	Wed Jan 30 06:30:49 2002
@@ -0,0 +1,90 @@
+/* zconf.h -- configuration of the zlib compression library
+ * Copyright (C) 1995-1998 Jean-loup Gailly.
+ * For conditions of distribution and use, see copyright notice in zlib.h 
+ */
+
+/* @(#) $Id$ */
+
+#ifndef _ZCONF_H
+#define _ZCONF_H
+
+#if defined(__GNUC__) || defined(__386__) || defined(i386)
+#  ifndef __32BIT__
+#    define __32BIT__
+#  endif
+#endif
+
+#if defined(__STDC__) || defined(__cplusplus)
+#  ifndef STDC
+#    define STDC
+#  endif
+#endif
+
+/* The memory requirements for deflate are (in bytes):
+            (1 << (windowBits+2)) +  (1 << (memLevel+9))
+ that is: 128K for windowBits=15  +  128K for memLevel = 8  (default values)
+ plus a few kilobytes for small objects. For example, if you want to reduce
+ the default memory requirements from 256K to 128K, compile with
+     make CFLAGS="-O -DMAX_WBITS=14 -DMAX_MEM_LEVEL=7"
+ Of course this will generally degrade compression (there's no free lunch).
+
+   The memory requirements for inflate are (in bytes) 1 << windowBits
+ that is, 32K for windowBits=15 (default value) plus a few kilobytes
+ for small objects.
+*/
+
+/* Maximum value for memLevel in deflateInit2 */
+#ifndef MAX_MEM_LEVEL
+#  define MAX_MEM_LEVEL 9
+#endif
+
+/* Maximum value for windowBits in deflateInit2 and inflateInit2.
+ * WARNING: reducing MAX_WBITS makes minigzip unable to extract .gz files
+ * created by gzip. (Files created by minigzip can still be extracted by
+ * gzip.)
+ */
+#ifndef MAX_WBITS
+#  define MAX_WBITS   15 /* 32K LZ77 window */
+#endif
+
+                        /* Type declarations */
+
+#ifndef OF /* function prototypes */
+#  ifdef STDC
+#    define OF(args)  args
+#  else
+#    define OF(args)  ()
+#  endif
+#endif
+
+#ifndef ZEXPORT
+#  define ZEXPORT
+#endif
+#ifndef ZEXPORTVA
+#  define ZEXPORTVA
+#endif
+#ifndef ZEXTERN
+#  define ZEXTERN extern
+#endif
+#ifndef FAR
+#   define FAR
+#endif
+
+typedef unsigned char  Byte;  /* 8 bits */
+typedef unsigned int   uInt;  /* 16 bits or more */
+typedef unsigned long  uLong; /* 32 bits or more */
+
+typedef Byte  FAR Bytef;
+typedef char  FAR charf;
+typedef int   FAR intf;
+typedef uInt  FAR uIntf;
+typedef uLong FAR uLongf;
+
+typedef void FAR *voidpf;
+typedef void     *voidp;
+
+#include <linux/types.h> /* for off_t */
+#include <linux/unistd.h>    /* for SEEK_* and off_t */
+#define z_off_t  off_t
+
+#endif /* _ZCONF_H */
diff -urN kernel-source-2.5.4-pre1-orig/include/linux/zutil.h kernel-source-2.5.4-pre1-new/include/linux/zutil.h
--- kernel-source-2.5.4-pre1-orig/include/linux/zutil.h	Thu Jan  1 01:00:00 1970
+++ kernel-source-2.5.4-pre1-new/include/linux/zutil.h	Wed Jan 30 06:30:49 2002
@@ -0,0 +1,126 @@
+/* zutil.h -- internal interface and configuration of the compression library
+ * Copyright (C) 1995-1998 Jean-loup Gailly.
+ * For conditions of distribution and use, see copyright notice in zlib.h
+ */
+
+/* WARNING: this file should *not* be used by applications. It is
+   part of the implementation of the compression library and is
+   subject to change. Applications should only use zlib.h.
+ */
+
+/* @(#) $Id: zutil.h,v 1.1 2000/01/01 03:32:23 davem Exp $ */
+
+#ifndef _Z_UTIL_H
+#define _Z_UTIL_H
+
+#include <linux/zlib.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+#ifndef local
+#  define local static
+#endif
+/* compile with -Dlocal if your debugger can't find static symbols */
+
+typedef unsigned char  uch;
+typedef uch FAR uchf;
+typedef unsigned short ush;
+typedef ush FAR ushf;
+typedef unsigned long  ulg;
+
+        /* common constants */
+
+#ifndef DEF_WBITS
+#  define DEF_WBITS MAX_WBITS
+#endif
+/* default windowBits for decompression. MAX_WBITS is for compression only */
+
+#if MAX_MEM_LEVEL >= 8
+#  define DEF_MEM_LEVEL 8
+#else
+#  define DEF_MEM_LEVEL  MAX_MEM_LEVEL
+#endif
+/* default memLevel */
+
+#define STORED_BLOCK 0
+#define STATIC_TREES 1
+#define DYN_TREES    2
+/* The three kinds of block type */
+
+#define MIN_MATCH  3
+#define MAX_MATCH  258
+/* The minimum and maximum match lengths */
+
+#define PRESET_DICT 0x20 /* preset dictionary flag in zlib header */
+
+        /* target dependencies */
+
+        /* Common defaults */
+
+#ifndef OS_CODE
+#  define OS_CODE  0x03  /* assume Unix */
+#endif
+
+         /* functions */
+
+typedef uLong (ZEXPORT *check_func) OF((uLong check, const Bytef *buf,
+				       uInt len));
+
+
+                        /* checksum functions */
+
+#define BASE 65521L /* largest prime smaller than 65536 */
+#define NMAX 5552
+/* NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 */
+
+#define DO1(buf,i)  {s1 += buf[i]; s2 += s1;}
+#define DO2(buf,i)  DO1(buf,i); DO1(buf,i+1);
+#define DO4(buf,i)  DO2(buf,i); DO2(buf,i+2);
+#define DO8(buf,i)  DO4(buf,i); DO4(buf,i+4);
+#define DO16(buf)   DO8(buf,0); DO8(buf,8);
+
+/* ========================================================================= */
+/*
+     Update a running Adler-32 checksum with the bytes buf[0..len-1] and
+   return the updated checksum. If buf is NULL, this function returns
+   the required initial value for the checksum.
+   An Adler-32 checksum is almost as reliable as a CRC32 but can be computed
+   much faster. Usage example:
+
+     uLong adler = adler32(0L, Z_NULL, 0);
+
+     while (read_buffer(buffer, length) != EOF) {
+       adler = adler32(adler, buffer, length);
+     }
+     if (adler != original_adler) error();
+*/
+static inline uLong zlib_adler32(uLong adler,
+				 const Bytef *buf,
+				 uInt len)
+{
+    unsigned long s1 = adler & 0xffff;
+    unsigned long s2 = (adler >> 16) & 0xffff;
+    int k;
+
+    if (buf == Z_NULL) return 1L;
+
+    while (len > 0) {
+        k = len < NMAX ? len : NMAX;
+        len -= k;
+        while (k >= 16) {
+            DO16(buf);
+	    buf += 16;
+            k -= 16;
+        }
+        if (k != 0) do {
+            s1 += *buf++;
+	    s2 += s1;
+        } while (--k);
+        s1 %= BASE;
+        s2 %= BASE;
+    }
+    return (s2 << 16) | s1;
+}
+
+#endif /* _Z_UTIL_H */
diff -urN kernel-source-2.5.4-pre1-orig/linux/zconf.h kernel-source-2.5.4-pre1-new/linux/zconf.h
--- kernel-source-2.5.4-pre1-orig/linux/zconf.h	Wed Jan 30 06:30:49 2002
+++ kernel-source-2.5.4-pre1-new/linux/zconf.h	Thu Jan  1 01:00:00 1970
@@ -1,90 +0,0 @@
-/* zconf.h -- configuration of the zlib compression library
- * Copyright (C) 1995-1998 Jean-loup Gailly.
- * For conditions of distribution and use, see copyright notice in zlib.h 
- */
-
-/* @(#) $Id$ */
-
-#ifndef _ZCONF_H
-#define _ZCONF_H
-
-#if defined(__GNUC__) || defined(__386__) || defined(i386)
-#  ifndef __32BIT__
-#    define __32BIT__
-#  endif
-#endif
-
-#if defined(__STDC__) || defined(__cplusplus)
-#  ifndef STDC
-#    define STDC
-#  endif
-#endif
-
-/* The memory requirements for deflate are (in bytes):
-            (1 << (windowBits+2)) +  (1 << (memLevel+9))
- that is: 128K for windowBits=15  +  128K for memLevel = 8  (default values)
- plus a few kilobytes for small objects. For example, if you want to reduce
- the default memory requirements from 256K to 128K, compile with
-     make CFLAGS="-O -DMAX_WBITS=14 -DMAX_MEM_LEVEL=7"
- Of course this will generally degrade compression (there's no free lunch).
-
-   The memory requirements for inflate are (in bytes) 1 << windowBits
- that is, 32K for windowBits=15 (default value) plus a few kilobytes
- for small objects.
-*/
-
-/* Maximum value for memLevel in deflateInit2 */
-#ifndef MAX_MEM_LEVEL
-#  define MAX_MEM_LEVEL 9
-#endif
-
-/* Maximum value for windowBits in deflateInit2 and inflateInit2.
- * WARNING: reducing MAX_WBITS makes minigzip unable to extract .gz files
- * created by gzip. (Files created by minigzip can still be extracted by
- * gzip.)
- */
-#ifndef MAX_WBITS
-#  define MAX_WBITS   15 /* 32K LZ77 window */
-#endif
-
-                        /* Type declarations */
-
-#ifndef OF /* function prototypes */
-#  ifdef STDC
-#    define OF(args)  args
-#  else
-#    define OF(args)  ()
-#  endif
-#endif
-
-#ifndef ZEXPORT
-#  define ZEXPORT
-#endif
-#ifndef ZEXPORTVA
-#  define ZEXPORTVA
-#endif
-#ifndef ZEXTERN
-#  define ZEXTERN extern
-#endif
-#ifndef FAR
-#   define FAR
-#endif
-
-typedef unsigned char  Byte;  /* 8 bits */
-typedef unsigned int   uInt;  /* 16 bits or more */
-typedef unsigned long  uLong; /* 32 bits or more */
-
-typedef Byte  FAR Bytef;
-typedef char  FAR charf;
-typedef int   FAR intf;
-typedef uInt  FAR uIntf;
-typedef uLong FAR uLongf;
-
-typedef void FAR *voidpf;
-typedef void     *voidp;
-
-#include <linux/types.h> /* for off_t */
-#include <linux/unistd.h>    /* for SEEK_* and off_t */
-#define z_off_t  off_t
-
-#endif /* _ZCONF_H */
diff -urN kernel-source-2.5.4-pre1-orig/linux/zutil.h kernel-source-2.5.4-pre1-new/linux/zutil.h
--- kernel-source-2.5.4-pre1-orig/linux/zutil.h	Wed Jan 30 06:30:49 2002
+++ kernel-source-2.5.4-pre1-new/linux/zutil.h	Thu Jan  1 01:00:00 1970
@@ -1,126 +0,0 @@
-/* zutil.h -- internal interface and configuration of the compression library
- * Copyright (C) 1995-1998 Jean-loup Gailly.
- * For conditions of distribution and use, see copyright notice in zlib.h
- */
-
-/* WARNING: this file should *not* be used by applications. It is
-   part of the implementation of the compression library and is
-   subject to change. Applications should only use zlib.h.
- */
-
-/* @(#) $Id: zutil.h,v 1.1 2000/01/01 03:32:23 davem Exp $ */
-
-#ifndef _Z_UTIL_H
-#define _Z_UTIL_H
-
-#include <linux/zlib.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-
-#ifndef local
-#  define local static
-#endif
-/* compile with -Dlocal if your debugger can't find static symbols */
-
-typedef unsigned char  uch;
-typedef uch FAR uchf;
-typedef unsigned short ush;
-typedef ush FAR ushf;
-typedef unsigned long  ulg;
-
-        /* common constants */
-
-#ifndef DEF_WBITS
-#  define DEF_WBITS MAX_WBITS
-#endif
-/* default windowBits for decompression. MAX_WBITS is for compression only */
-
-#if MAX_MEM_LEVEL >= 8
-#  define DEF_MEM_LEVEL 8
-#else
-#  define DEF_MEM_LEVEL  MAX_MEM_LEVEL
-#endif
-/* default memLevel */
-
-#define STORED_BLOCK 0
-#define STATIC_TREES 1
-#define DYN_TREES    2
-/* The three kinds of block type */
-
-#define MIN_MATCH  3
-#define MAX_MATCH  258
-/* The minimum and maximum match lengths */
-
-#define PRESET_DICT 0x20 /* preset dictionary flag in zlib header */
-
-        /* target dependencies */
-
-        /* Common defaults */
-
-#ifndef OS_CODE
-#  define OS_CODE  0x03  /* assume Unix */
-#endif
-
-         /* functions */
-
-typedef uLong (ZEXPORT *check_func) OF((uLong check, const Bytef *buf,
-				       uInt len));
-
-
-                        /* checksum functions */
-
-#define BASE 65521L /* largest prime smaller than 65536 */
-#define NMAX 5552
-/* NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 */
-
-#define DO1(buf,i)  {s1 += buf[i]; s2 += s1;}
-#define DO2(buf,i)  DO1(buf,i); DO1(buf,i+1);
-#define DO4(buf,i)  DO2(buf,i); DO2(buf,i+2);
-#define DO8(buf,i)  DO4(buf,i); DO4(buf,i+4);
-#define DO16(buf)   DO8(buf,0); DO8(buf,8);
-
-/* ========================================================================= */
-/*
-     Update a running Adler-32 checksum with the bytes buf[0..len-1] and
-   return the updated checksum. If buf is NULL, this function returns
-   the required initial value for the checksum.
-   An Adler-32 checksum is almost as reliable as a CRC32 but can be computed
-   much faster. Usage example:
-
-     uLong adler = adler32(0L, Z_NULL, 0);
-
-     while (read_buffer(buffer, length) != EOF) {
-       adler = adler32(adler, buffer, length);
-     }
-     if (adler != original_adler) error();
-*/
-static inline uLong zlib_adler32(uLong adler,
-				 const Bytef *buf,
-				 uInt len)
-{
-    unsigned long s1 = adler & 0xffff;
-    unsigned long s2 = (adler >> 16) & 0xffff;
-    int k;
-
-    if (buf == Z_NULL) return 1L;
-
-    while (len > 0) {
-        k = len < NMAX ? len : NMAX;
-        len -= k;
-        while (k >= 16) {
-            DO16(buf);
-	    buf += 16;
-            k -= 16;
-        }
-        if (k != 0) do {
-            s1 += *buf++;
-	    s2 += s1;
-        } while (--k);
-        s1 %= BASE;
-        s2 %= BASE;
-    }
-    return (s2 << 16) | s1;
-}
-
-#endif /* _Z_UTIL_H */
