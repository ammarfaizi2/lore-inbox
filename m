Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVLVSbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVLVSbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVLVS2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:33 -0500
Received: from waste.org ([64.81.244.121]:6608 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030265AbVLVS17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:59 -0500
Date: Thu, 22 Dec 2005 12:26:38 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <8.150843412@selenic.com>
Message-Id: <9.150843412@selenic.com>
Subject: [PATCH 8/20] inflate: (arch) kill unneeded declarations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: remove a bunch of declarations/definitions from callers

This removes:

- memset/memzero/memcpy implementations
- OF
- STATIC
- gzip flag byte defines
- unused debug defines

and saves an average of 50 lines in each of 12 users.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14.orig/arch/alpha/boot/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/alpha/boot/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -22,7 +22,6 @@
 
 #include <asm/uaccess.h>
 
-#define memzero(s,n)	memset ((s),0,(n))
 #define puts		srm_printk
 extern long srm_printk(const char *, ...)
      __attribute__ ((format (printf, 1, 2)));
@@ -30,8 +29,6 @@ extern long srm_printk(const char *, ...
 /*
  * gzip delarations
  */
-#define OF(args)  args
-#define STATIC static
 
 typedef unsigned char  uch;
 typedef unsigned short ush;
@@ -47,34 +44,8 @@ static unsigned insize;		/* valid bytes 
 static unsigned inptr;		/* index of next byte to be processed in inbuf */
 static unsigned outcnt;		/* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
Index: 2.6.14/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/arm/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -45,90 +45,8 @@ icedcc_putstr(const char *ptr)
 #define __ptr_t void *
 
 /*
- * Optimised C version of memzero for the ARM.
+ * gzip declarations
  */
-void __memzero (__ptr_t s, size_t n)
-{
-	union { void *vp; unsigned long *ulp; unsigned char *ucp; } u;
-	int i;
-
-	u.vp = s;
-
-	for (i = n >> 5; i > 0; i--) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 4) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 3) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 2)
-		*u.ulp++ = 0;
-
-	if (n & 1 << 1) {
-		*u.ucp++ = 0;
-		*u.ucp++ = 0;
-	}
-
-	if (n & 1)
-		*u.ucp++ = 0;
-}
-
-static inline __ptr_t memcpy(__ptr_t __dest, __const __ptr_t __src,
-			    size_t __n)
-{
-	int i = 0;
-	unsigned char *d = (unsigned char *)__dest, *s = (unsigned char *)__src;
-
-	for (i = __n >> 3; i > 0; i--) {
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1 << 2) {
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1 << 1) {
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1)
-		*d++ = *s++;
-
-	return __dest;
-}
-
-/*
- * gzip delarations
- */
-#define OF(args)  args
-#define STATIC static
 
 typedef unsigned char  uch;
 typedef unsigned short ush;
@@ -144,34 +62,8 @@ static unsigned insize;		/* valid bytes 
 static unsigned inptr;		/* index of next byte to be processed in inbuf */
 static unsigned outcnt;		/* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
Index: 2.6.14/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/arm26/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -30,90 +30,8 @@ unsigned int __machine_arch_type;
 #define __ptr_t void *
 
 /*
- * Optimised C version of memzero for the ARM.
- */
-void __memzero (__ptr_t s, size_t n)
-{
-	union { void *vp; unsigned long *ulp; unsigned char *ucp; } u;
-	int i;
-
-	u.vp = s;
-
-	for (i = n >> 5; i > 0; i--) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 4) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 3) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 2)
-		*u.ulp++ = 0;
-
-	if (n & 1 << 1) {
-		*u.ucp++ = 0;
-		*u.ucp++ = 0;
-	}
-
-	if (n & 1)
-		*u.ucp++ = 0;
-}
-
-static inline __ptr_t memcpy(__ptr_t __dest, __const __ptr_t __src,
-			    size_t __n)
-{
-	int i = 0;
-	unsigned char *d = (unsigned char *)__dest, *s = (unsigned char *)__src;
-
-	for (i = __n >> 3; i > 0; i--) {
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1 << 2) {
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1 << 1) {
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1)
-		*d++ = *s++;
-
-	return __dest;
-}
-
-/*
  * gzip delarations
  */
-#define OF(args)  args
-#define STATIC static
 
 typedef unsigned char  uch;
 typedef unsigned short ush;
@@ -129,34 +47,8 @@ static unsigned insize;		/* valid bytes 
 static unsigned inptr;		/* index of next byte to be processed in inbuf */
 static unsigned outcnt;		/* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -29,16 +29,6 @@
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-void* memset(void* s, int c, size_t n);
-void* memcpy(void* __dest, __const void* __src,
-	     size_t __n);
-
-#define memzero(s, n)     memset ((s), 0, (n))
-
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -56,33 +46,7 @@ unsigned inptr = 0;	/* index of next byt
 
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
-#define get_byte() inbuf[inptr++]	
-	
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
+#define get_byte() inbuf[inptr++]
 
 static int  fill_inbuf(void);
 static void flush_window(void);
@@ -166,25 +130,6 @@ puts(const char *s)
 #endif
 }
 
-void*
-memset(void* s, int c, size_t n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-}
-
-void*
-memcpy(void* __dest, __const void* __src,
-			    size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i=0;i<__n;i++) d[i] = s[i];
-}
-
 /* ===========================================================================
  * Write the output window window[0..outcnt-1] and update crc and bytes_out.
  * (Used for the decompressed data only.)
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -31,16 +31,6 @@
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-void* memset(void* s, int c, size_t n);
-void* memcpy(void* __dest, __const void* __src,
-	     size_t __n);
-
-#define memzero(s, n)     memset ((s), 0, (n))
-
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -58,34 +48,8 @@ unsigned inptr = 0;	/* index of next byt
 
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte() inbuf[inptr++]
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
@@ -180,25 +144,6 @@ puts(const char *s)
 #endif
 }
 
-void*
-memset(void* s, int c, size_t n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-}
-
-void*
-memcpy(void* __dest, __const void* __src,
-			    size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i=0;i<__n;i++) d[i] = s[i];
-}
-
 /* ===========================================================================
  * Write the output window window[0..outcnt-1] and update crc and bytes_out.
  * (Used for the decompressed data only.)
Index: 2.6.14/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/i386/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -19,21 +19,11 @@
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-#undef memset
-#undef memcpy
-
 /*
  * Why do we do this? Don't ask me..
  *
  * Incomprehensible are the ways of bootloaders.
  */
-static void* memset(void *, int, size_t);
-static void* memcpy(void *, __const void *, size_t);
-#define memzero(s, n)     memset ((s), 0, (n))
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -48,33 +38,7 @@ static unsigned insize = 0;  /* valid by
 static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-		
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
 
 static int  fill_inbuf(void);
 static void flush_window(void);
@@ -163,7 +127,9 @@ static void scroll(void)
 {
 	int i;
 
-	memcpy ( vidmem, vidmem + cols * 2, ( lines - 1 ) * cols * 2 );
+	for (i = 0; i < (lines - 1) * cols * 2; i++)
+		vidmem[i] = vidmem[i + cols * 2];
+
 	for ( i = ( lines - 1 ) * cols * 2; i < lines * cols * 2; i += 2 )
 		vidmem[i] = ' ';
 }
@@ -205,25 +171,6 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-static void* memset(void* s, int c, size_t n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-	return s;
-}
-
-static void* memcpy(void* __dest, __const void* __src,
-			    size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i=0;i<__n;i++) d[i] = s[i];
-	return __dest;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/m32r/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -19,13 +19,6 @@
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-#undef memset
-#undef memcpy
-#define memzero(s, n)     memset ((s), 0, (n))
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -40,34 +33,8 @@ static unsigned insize = 0;  /* valid by
 static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
@@ -125,25 +92,6 @@ static void gzip_release(void **ptr)
 	free_mem_ptr = (long) *ptr;
 }
 
-void* memset(void* s, int c, size_t n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-	return s;
-}
-
-void* memcpy(void* __dest, __const void* __src,
-			    size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i=0;i<__n;i++) d[i] = s[i];
-	return __dest;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/sh/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -21,13 +21,6 @@
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-#undef memset
-#undef memcpy
-#define memzero(s, n)     memset ((s), 0, (n))
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -42,34 +35,8 @@ static unsigned insize = 0;  /* valid by
 static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
@@ -156,25 +123,6 @@ int puts(const char *s)
 }
 #endif
 
-void* memset(void* s, int c, size_t n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-	return s;
-}
-
-void* memcpy(void* __dest, __const void* __src,
-			    size_t __n)
-{
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
-
-	for (i=0;i<__n;i++) d[i] = s[i];
-	return __dest;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/sh64/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -21,13 +21,6 @@ int cache_control(unsigned int command);
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-#undef memset
-#undef memcpy
-#define memzero(s, n)     memset ((s), 0, (n))
-
 typedef unsigned char uch;
 typedef unsigned short ush;
 typedef unsigned long ulg;
@@ -42,34 +35,8 @@ static unsigned insize = 0;	/* valid byt
 static unsigned inptr = 0;	/* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;	/* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01	/* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02	/* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04	/* bit 2 set: extra field present */
-#define ORIG_NAME    0x08	/* bit 3 set: original file name present */
-#define COMMENT      0x10	/* bit 4 set: file comment present */
-#define ENCRYPTED    0x20	/* bit 5 set: file is encrypted */
-#define RESERVED     0xC0	/* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
 static int fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
@@ -138,26 +105,6 @@ void puts(const char *s)
 {
 }
 
-void *memset(void *s, int c, size_t n)
-{
-	int i;
-	char *ss = (char *) s;
-
-	for (i = 0; i < n; i++)
-		ss[i] = c;
-	return s;
-}
-
-void *memcpy(void *__dest, __const void *__src, size_t __n)
-{
-	int i;
-	char *d = (char *) __dest, *s = (char *) __src;
-
-	for (i = 0; i < __n; i++)
-		d[i] = s[i];
-	return __dest;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/misc.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/arch/x86_64/boot/compressed/misc.c	2005-10-28 21:05:01.000000000 -0700
@@ -17,13 +17,6 @@
  * gzip declarations
  */
 
-#define OF(args)  args
-#define STATIC static
-
-#undef memset
-#undef memcpy
-#define memzero(s, n)     memset ((s), 0, (n))
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -38,33 +31,7 @@ static unsigned insize = 0;  /* valid by
 static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-		
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
 
 static int  fill_inbuf(void);
 static void flush_window(void);
@@ -92,9 +59,6 @@ static unsigned long output_ptr = 0;
 
 static void *malloc(int size);
 static void free(void *where);
- 
-void* memset(void* s, int c, unsigned n);
-void* memcpy(void* dest, const void* src, unsigned n);
 
 static void putstr(const char *);
 
@@ -152,7 +116,9 @@ static void scroll(void)
 {
 	int i;
 
-	memcpy ( vidmem, vidmem + cols * 2, ( lines - 1 ) * cols * 2 );
+	for (i = 0; i < (lines - 1) * cols * 2; i++)
+		vidmem[i] = vidmem[i + cols * 2];
+
 	for ( i = ( lines - 1 ) * cols * 2; i < lines * cols * 2; i += 2 )
 		vidmem[i] = ' ';
 }
@@ -194,24 +160,6 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-void* memset(void* s, int c, unsigned n)
-{
-	int i;
-	char *ss = (char*)s;
-
-	for (i=0;i<n;i++) ss[i] = c;
-	return s;
-}
-
-void* memcpy(void* dest, const void* src, unsigned n)
-{
-	int i;
-	char *d = (char *)dest, *s = (char *)src;
-
-	for (i=0;i<n;i++) d[i] = s[i];
-	return dest;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/init/do_mounts_rd.c
===================================================================
--- 2.6.14.orig/init/do_mounts_rd.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/init/do_mounts_rd.c	2005-10-28 21:05:01.000000000 -0700
@@ -273,12 +273,6 @@ int __init rd_load_disk(int n)
  * gzip declarations
  */
 
-#define OF(args)  args
-
-#ifndef memzero
-#define memzero(s, n)     memset ((s), 0, (n))
-#endif
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -299,16 +293,7 @@ static long bytes_out;
 static int crd_infd, crd_outfd;
 
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-		
-/* Diagnostic functions (stubbed out) */
-#define Assert(cond,msg)
-#define Trace(x)
-#define Tracev(x)
-#define Tracevv(x)
-#define Tracec(c,x)
-#define Tracecv(c,x)
 
-#define STATIC static
 #define INIT __init
 
 static int  __init fill_inbuf(void);
Index: 2.6.14/init/initramfs.c
===================================================================
--- 2.6.14.orig/init/initramfs.c	2005-10-28 20:39:32.000000000 -0700
+++ 2.6.14/init/initramfs.c	2005-10-28 21:05:01.000000000 -0700
@@ -343,12 +343,6 @@ static void __init flush_buffer(char *bu
  * gzip declarations
  */
 
-#define OF(args)  args
-
-#ifndef memzero
-#define memzero(s, n)     memset ((s), 0, (n))
-#endif
-
 typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
@@ -365,16 +359,7 @@ static unsigned outcnt;  /* bytes in out
 static long bytes_out;
 
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : -1)
-		
-/* Diagnostic functions (stubbed out) */
-#define Assert(cond,msg)
-#define Trace(x)
-#define Tracev(x)
-#define Tracevv(x)
-#define Tracec(c,x)
-#define Tracecv(c,x)
 
-#define STATIC static
 #define INIT __init
 
 static void __init flush_window(void);
