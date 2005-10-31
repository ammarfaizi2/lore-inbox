Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVJaVCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVJaVCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVJaVCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:02:03 -0500
Received: from waste.org ([216.27.176.166]:11160 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932540AbVJaVAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:38 -0500
Date: Mon, 31 Oct 2005 14:54:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <9.196662837@selenic.com>
Message-Id: <10.196662837@selenic.com>
Subject: [PATCH 9/20] inflate: (arch) refactor inflate malloc code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: refactor inflate malloc code

Inflate requires some dynamic memory allocation very early in the boot
process and this is provided with a set of four functions:
malloc/free/gzip_mark/gzip_release.

The old inflate code used a mark/release strategy rather than
implement free. This new version instead keeps a count on the number
of outstanding allocations and when it hits zero, it resets the malloc
arena.

This allows removing all the mark and release implementations and
unifying all the malloc/free implementations.

This also fixes bogus usage of malloc/free rather than kmalloc/kfree
in initramfs.c.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14.orig/arch/alpha/boot/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/alpha/boot/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,8 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3 
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
  * Modified for ARM Linux by Russell King
  *
  * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
@@ -49,8 +47,6 @@ static unsigned outcnt;		/* bytes in out
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 static char *input_data;
 static int  input_data_size;
@@ -59,12 +55,6 @@ static uch *output_data;
 static ulg output_ptr;
 static ulg bytes_out;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 extern int end;
 static ulg free_mem_ptr;
 static ulg free_mem_ptr_end;
@@ -73,37 +63,6 @@ static ulg free_mem_ptr_end;
 
 #include "../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr <= 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_ptr_end)
-		error("Out of memory");
-	return p;
-}
-
-static void free(void *where)
-{ /* gzip_mark & gzip_release do the free */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,8 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3 
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
  * Modified for ARM Linux by Russell King
  *
  * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
@@ -67,8 +65,6 @@ static unsigned outcnt;		/* bytes in out
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 extern char input_data[];
 extern char input_data_end[];
@@ -77,12 +73,6 @@ static uch *output_data;
 static ulg output_ptr;
 static ulg bytes_out;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 static void putstr(const char *);
 
 extern int end;
@@ -93,47 +83,8 @@ static ulg free_mem_ptr_end;
 
 #include "../../../../lib/inflate.c"
 
-#ifndef STANDALONE_DEBUG
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr <= 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_ptr_end)
-		error("Out of memory");
-	return p;
-}
-
-static void free(void *where)
-{ /* gzip_mark & gzip_release do the free */
-}
-
-static void gzip_mark(void **ptr)
-{
-	arch_decomp_wdog();
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	arch_decomp_wdog();
-	free_mem_ptr = (long) *ptr;
-}
-#else
-static void gzip_mark(void **ptr)
-{
-}
-
-static void gzip_release(void **ptr)
-{
-}
+#ifdef STANDALONE_DEBUG
+#define NO_INFLATE_MALLOC
 #endif
 
 /* ===========================================================================
Index: 2.6.14/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,8 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3 
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
  * Modified for ARM Linux by Russell King
  *
  * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
@@ -52,8 +50,6 @@ static unsigned outcnt;		/* bytes in out
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 extern char input_data[];
 extern char input_data_end[];
@@ -62,12 +58,6 @@ static uch *output_data;
 static ulg output_ptr;
 static ulg bytes_out;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 static void puts(const char *);
 
 extern int end;
@@ -78,47 +68,8 @@ static ulg free_mem_ptr_end;
 
 #include "../../../../lib/inflate.c"
 
-#ifndef STANDALONE_DEBUG
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr <= 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_ptr_end)
-		error("Out of memory");
-	return p;
-}
-
-static void free(void *where)
-{ /* gzip_mark & gzip_release do the free */
-}
-
-static void gzip_mark(void **ptr)
-{
-	arch_decomp_wdog();
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	arch_decomp_wdog();
-	free_mem_ptr = (long) *ptr;
-}
-#else
-static void gzip_mark(void **ptr)
-{
-}
-
-static void gzip_release(void **ptr)
-{
-}
+#ifdef STANDALONE_DEBUG
+#define NO_INFLATE_MALLOC
 #endif
 
 /* ===========================================================================
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -6,7 +6,6 @@
  * This is a collection of several routines from gzip-1.0.3 
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * adoptation for Linux/CRIS Axis Communications AB, 1999
  * 
@@ -51,57 +50,22 @@ static unsigned outcnt = 0;  /* bytes in
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 extern char *input_data;  /* lives in head.S */
 
 static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
- 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
- 
+
 static void puts(const char *);
 
 /* the "heap" is put directly after the BSS ends, at end */
   
 extern int end;
 static long free_mem_ptr = (long)&end;
- 
-#include "../../../../../lib/inflate.c"
-
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	return p;
-}
-
-static void free(void *where)
-{	/* Don't care */
-}
+static long free_mem_end_ptr = 0xffffffff;
 
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
+#include "../../../../../lib/inflate.c"
 
 /* decompressor info and error messages to serial console */
 
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -6,7 +6,6 @@
  * This is a collection of several routines from gzip-1.0.3
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * adoptation for Linux/CRIS Axis Communications AB, 1999
  *
@@ -53,8 +52,6 @@ static unsigned outcnt = 0;  /* bytes in
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 extern char *input_data;  /* lives in head.S */
 
@@ -62,49 +59,16 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 static void puts(const char *);
 
 /* the "heap" is put directly after the BSS ends, at end */
 
 extern int _end;
 static long free_mem_ptr = (long)&_end;
+static long free_mem_end_ptr = 0xffffffff;
 
 #include "../../../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	return p;
-}
-
-static void free(void *where)
-{	/* Don't care */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
-
 /* decompressor info and error messages to serial console */
 
 static inline void
Index: 2.6.14/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,7 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3 
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
@@ -43,9 +42,7 @@ static unsigned outcnt = 0;  /* bytes in
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-  
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -64,9 +61,6 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-
 static void putstr(const char *);
 
 extern int end;
@@ -91,38 +85,6 @@ static void * xquad_portio = NULL;
 
 #include "../../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr <= 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_end_ptr)
-		error("Out of memory");
-
-	return p;
-}
-
-static void free(void *where)
-{	/* Don't care */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
- 
 static void scroll(void)
 {
 	int i;
Index: 2.6.14/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,8 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
  * Adapted for SH by Stuart Menefy, Aug 1999
  *
  * 2003-02-12:	Support M32R by Takeo Takahashi
@@ -38,8 +36,6 @@ static unsigned outcnt = 0;  /* bytes in
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 static unsigned char *input_data;
 static int input_len;
@@ -50,9 +46,6 @@ static unsigned long output_ptr = 0;
 
 #include "m32r_sio.c"
 
-static void *malloc(int size);
-static void free(void *where);
-
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 
@@ -60,38 +53,6 @@ static unsigned long free_mem_end_ptr;
 
 #include "../../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr == 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_end_ptr)
-		error("Out of memory");
-
-	return p;
-}
-
-static void free(void *where)
-{	/* Don't care */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
-
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
Index: 2.6.14/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,8 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
  * Adapted for SH by Stuart Menefy, Aug 1999
  *
  * Modified to use standard LinuxSH BIOS by Greg Banks 7Jul2000
@@ -40,8 +38,6 @@ static unsigned outcnt = 0;  /* bytes in
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 extern char input_data[];
 extern int input_len;
@@ -50,12 +46,6 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 int puts(const char *);
 
 extern int _text;		/* Defined in vmlinux.lds.S */
@@ -67,38 +57,6 @@ static unsigned long free_mem_end_ptr;
 
 #include "../../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr == 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_end_ptr)
-		error("Out of memory");
-
-	return p;
-}
-
-static void free(void *where)
-{	/* Don't care */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
-
 #ifdef CONFIG_SH_STANDARD_BIOS
 size_t strlen(const char *s)
 {
Index: 2.6.14/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,8 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
  * Adapted for SHmedia from sh by Stuart Menefy, May 2002
  */
 
@@ -40,8 +38,6 @@ static unsigned outcnt = 0;	/* bytes in 
 static int fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
 
 extern char input_data[];
 extern int input_len;
@@ -50,12 +46,6 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 static void puts(const char *);
 
 extern int _text;		/* Defined in vmlinux.lds.S */
@@ -67,40 +57,6 @@ static unsigned long free_mem_end_ptr;
 
 #include "../../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size < 0)
-		error("Malloc error\n");
-	if (free_mem_ptr == 0)
-		error("Memory error\n");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *) free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_end_ptr)
-		error("\nOut of memory\n");
-
-	return p;
-}
-
-static void free(void *where)
-{				/* Don't care */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
-
 void puts(const char *s)
 {
 }
Index: 2.6.14/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:13.000000000 -0700
@@ -4,7 +4,6 @@
  * This is a collection of several routines from gzip-1.0.3 
  * adapted for Linux.
  *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
@@ -36,9 +35,7 @@ static unsigned outcnt = 0;  /* bytes in
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-  
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -57,9 +54,6 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-
 static void putstr(const char *);
 
 extern int end;
@@ -80,38 +74,6 @@ static int lines, cols;
 
 #include "../../../../lib/inflate.c"
 
-static void *malloc(int size)
-{
-	void *p;
-
-	if (size <0) error("Malloc error");
-	if (free_mem_ptr <= 0) error("Memory error");
-
-	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
-
-	p = (void *)free_mem_ptr;
-	free_mem_ptr += size;
-
-	if (free_mem_ptr >= free_mem_end_ptr)
-		error("Out of memory");
-
-	return p;
-}
-
-static void free(void *where)
-{	/* Don't care */
-}
-
-static void gzip_mark(void **ptr)
-{
-	*ptr = (void *) free_mem_ptr;
-}
-
-static void gzip_release(void **ptr)
-{
-	free_mem_ptr = (long) *ptr;
-}
- 
 static void scroll(void)
 {
 	int i;
Index: 2.6.14/init/do_mounts_rd.c
===================================================================
--- 2.6.14.orig/init/do_mounts_rd.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/init/do_mounts_rd.c	2005-10-28 22:04:13.000000000 -0700
@@ -298,32 +298,11 @@ static int crd_infd, crd_outfd;
 
 static int  __init fill_inbuf(void);
 static void __init flush_window(void);
-static void __init *malloc(size_t size);
-static void __init free(void *where);
 static void __init error(char *m);
-static void __init gzip_mark(void **);
-static void __init gzip_release(void **);
 
-#include "../lib/inflate.c"
-
-static void __init *malloc(size_t size)
-{
-	return kmalloc(size, GFP_KERNEL);
-}
-
-static void __init free(void *where)
-{
-	kfree(where);
-}
-
-static void __init gzip_mark(void **ptr)
-{
-}
-
-static void __init gzip_release(void **ptr)
-{
-}
+#define NO_INFLATE_MALLOC
 
+#include "../lib/inflate.c"
 
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
Index: 2.6.14/init/initramfs.c
===================================================================
--- 2.6.14.orig/init/initramfs.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/init/initramfs.c	2005-10-28 22:04:13.000000000 -0700
@@ -14,16 +14,6 @@ static void __init error(char *x)
 		message = x;
 }
 
-static void __init *malloc(size_t size)
-{
-	return kmalloc(size, GFP_KERNEL);
-}
-
-static void __init free(void *where)
-{
-	kfree(where);
-}
-
 /* link hash */
 
 static __initdata struct hash {
@@ -51,7 +41,7 @@ static char __init *find_link(int major,
 			continue;
 		return (*p)->name;
 	}
-	q = (struct hash *)malloc(sizeof(struct hash));
+	q = kmalloc(sizeof(struct hash), GFP_KERNEL);
 	if (!q)
 		panic("can't allocate link hash entry");
 	q->ino = ino;
@@ -70,7 +60,7 @@ static void __init free_hash(void)
 		while (*p) {
 			q = *p;
 			*p = q->next;
-			free(q);
+			kfree(q);
 		}
 	}
 }
@@ -364,18 +354,10 @@ static long bytes_out;
 
 static void __init flush_window(void);
 static void __init error(char *m);
-static void __init gzip_mark(void **);
-static void __init gzip_release(void **);
 
-#include "../lib/inflate.c"
+#define NO_INFLATE_MALLOC
 
-static void __init gzip_mark(void **ptr)
-{
-}
-
-static void __init gzip_release(void **ptr)
-{
-}
+#include "../lib/inflate.c"
 
 /* ===========================================================================
  * Write the output window window[0..outcnt-1] and update crc and bytes_out.
@@ -402,10 +384,10 @@ static char * __init unpack_to_rootfs(ch
 {
 	int written;
 	dry_run = check_only;
-	header_buf = malloc(110);
-	symlink_buf = malloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1);
-	name_buf = malloc(N_ALIGN(PATH_MAX));
-	window = malloc(WSIZE);
+	header_buf = kmalloc(110, GFP_KERNEL);
+	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
+	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
+	window = kmalloc(WSIZE, GFP_KERNEL);
 	if (!window || !header_buf || !symlink_buf || !name_buf)
 		panic("can't allocate buffers");
 	state = Start;
@@ -441,10 +423,10 @@ static char * __init unpack_to_rootfs(ch
 		buf += inptr;
 		len -= inptr;
 	}
-	free(window);
-	free(name_buf);
-	free(symlink_buf);
-	free(header_buf);
+	kfree(window);
+	kfree(name_buf);
+	kfree(symlink_buf);
+	kfree(header_buf);
 	return message;
 }
 
Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 22:03:58.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 22:04:13.000000000 -0700
@@ -109,6 +109,46 @@
 
 #include <asm/types.h>
 
+#ifndef NO_INFLATE_MALLOC
+/* A trivial malloc implementation, adapted from
+ *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ */
+
+static unsigned long malloc_ptr;
+static int malloc_count;
+
+static void *malloc(int size)
+{
+	void *p;
+
+	if (size <0)
+		error("Malloc error");
+	if (!malloc_ptr)
+		malloc_ptr = free_mem_ptr;
+
+	malloc_ptr = (malloc_ptr + 3) & ~3;	/* Align */
+
+	p = (void *)malloc_ptr;
+	malloc_ptr += size;
+
+	if (malloc_ptr >= free_mem_end_ptr)
+		error("Out of memory");
+
+	malloc_count++;
+	return p;
+}
+
+static void free(void *where)
+{
+	malloc_count--;
+	if (!malloc_count)
+		malloc_ptr = free_mem_ptr;
+}
+#else
+#define malloc(a) kmalloc(a, GFP_KERNEL)
+#define free(a) kfree(a)
+#endif
+
 static u32 crc_32_tab[256];
 static u32 crc;		/* dummy var until users get cleaned up */
 #define CRCPOLY_LE 0xedb88320
@@ -895,16 +935,12 @@ static int INIT inflate(struct iostate *
 {
 	int e;			/* last block flag */
 	int r;			/* result code */
-	void *ptr;
 
 	/* decompress until the last block */
 	do {
-		gzip_mark(&ptr);
-		if ((r = inflate_block(io, &e))) {
-			gzip_release(&ptr);
+		r = inflate_block(io, &e);
+		if (r)
 			return r;
-		}
-		gzip_release(&ptr);
 	} while (!e);
 
 	popbytes(io);
