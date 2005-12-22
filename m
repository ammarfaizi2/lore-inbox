Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVLVSbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVLVSbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVLVS22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:28 -0500
Received: from waste.org ([64.81.244.121]:7632 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030267AbVLVS2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:02 -0500
Date: Thu, 22 Dec 2005 12:26:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <9.150843412@selenic.com>
Message-Id: <10.150843412@selenic.com>
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

Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -59,51 +55,13 @@ static uch *output_data;
 static ulg output_ptr;
 static ulg bytes_out;
 
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
 extern int end;
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+static char *free_mem_ptr, *free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
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
@@ -163,8 +121,8 @@ decompress_kernel(void *output_start,
 	input_data_size		= kzsize; /* use compressed size */
 
 	/* FIXME FIXME FIXME */
-	free_mem_ptr		= (ulg)output_start + ksize;
-	free_mem_ptr_end	= (ulg)output_start + ksize + 0x200000;
+	free_mem_ptr		= (char *)output_start + ksize;
+	free_mem_ptr_end	= (char *)output_start + ksize + 0x200000;
 	/* FIXME FIXME FIXME */
 
 	/* put in temp area to reduce initial footprint */
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -77,63 +73,17 @@ static uch *output_data;
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
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+static char *free_mem_ptr, *free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
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
@@ -197,8 +147,8 @@ decompress_kernel(ulg output_start, ulg 
 		  int arch_id)
 {
 	output_data		= (uch *)output_start;	/* Points to kernel start */
-	free_mem_ptr		= free_mem_ptr_p;
-	free_mem_ptr_end	= free_mem_ptr_end_p;
+	free_mem_ptr		= (char *)free_mem_ptr_p;
+	free_mem_ptr_end	= (char *)free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
 
 	arch_decomp_setup();
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -62,63 +58,17 @@ static uch *output_data;
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
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+static char *free_mem_ptr, *free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
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
@@ -178,8 +128,8 @@ decompress_kernel(ulg output_start, ulg 
 		  int arch_id)
 {
 	output_data		= (uch *)output_start;	/* Points to kernel start */
-	free_mem_ptr		= free_mem_ptr_p;
-	free_mem_ptr_end	= free_mem_ptr_end_p;
+	free_mem_ptr		= (char *)free_mem_ptr_p;
+	free_mem_ptr_end	= (char *)free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
 
 	arch_decomp_setup();
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
-static long free_mem_ptr = (long)&end;
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
+static char *free_mem_ptr = (char *)&end;
+static char *free_mem_end_ptr = (char *)0xffffffff;
 
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
 
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
-static long free_mem_ptr = (long)&_end;
+static char *free_mem_ptr = (char *)&_end;
+static char *free_mem_end_ptr = (char *)0xffffffff;
 
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
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -64,14 +61,10 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-
 static void putstr(const char *);
 
 extern int end;
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
+static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
 
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
@@ -91,38 +84,6 @@ static void * xquad_portio = NULL;
 
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
@@ -257,7 +218,7 @@ static void setup_normal_output_buffer(v
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
 	output_data = (char *)__PHYSICAL_START; /* Normally Points to 1M */
-	free_mem_end_ptr = (long)real_mode;
+	free_mem_end_ptr = (char *)real_mode;
 }
 
 struct moveparams {
@@ -280,7 +241,7 @@ static void setup_output_buffer_if_we_ru
 	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
-	free_mem_end_ptr = (long)high_buffer_start;
+	free_mem_end_ptr = (char *)high_buffer_start;
 	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
 		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
@@ -316,7 +277,7 @@ asmlinkage int decompress_kernel(struct 
 	lines = RM_SCREEN_INFO.orig_video_lines;
 	cols = RM_SCREEN_INFO.orig_video_cols;
 
-	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
+	if ((long)free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
 
 	makecrc();
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -50,48 +46,13 @@ static unsigned long output_ptr = 0;
 
 #include "m32r_sio.c"
 
-static void *malloc(int size);
-static void free(void *where);
-
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
+static char *free_mem_ptr;
+static char *free_mem_end_ptr;
 
 #define HEAP_SIZE             0x10000
 
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
@@ -146,7 +107,7 @@ decompress_kernel(int mmu_on, unsigned c
 {
 	output_data = (unsigned char *)CONFIG_MEMORY_START + 0x2000
 		+ (mmu_on ? 0x80000000 : 0);
-	free_mem_ptr = heap;
+	free_mem_ptr = (char *)heap;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 	input_data = zimage_data;
 	input_len = zimage_len;
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -50,55 +46,16 @@ static long bytes_out = 0;
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
 extern int _end;
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
+static char *free_mem_ptr, *free_mem_end_ptr;
 
 #define HEAP_SIZE             0x10000
 
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
@@ -178,7 +135,7 @@ void decompress_kernel(void)
 {
 	output_data = 0;
 	output_ptr = (unsigned long)&_text+0x20001000;
-	free_mem_ptr = (unsigned long)&_end;
+	free_mem_ptr = (char *)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	makecrc();
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -50,57 +46,16 @@ static long bytes_out = 0;
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
 extern int _end;
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
+static char *free_mem_ptr, *free_mem_end_ptr;
 
 #define HEAP_SIZE             0x10000
 
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
@@ -160,7 +115,7 @@ long *stack_start = &user_stack[STACK_SI
 void decompress_kernel(void)
 {
 	output_data = (uch *) (CONFIG_MEMORY_START + 0x2000);
-	free_mem_ptr = (unsigned long) &_end;
+	free_mem_ptr = (char *)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	makecrc();
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-12-21 21:17:05.000000000 -0600
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
@@ -57,14 +54,10 @@ static long bytes_out = 0;
 static uch *output_data;
 static unsigned long output_ptr = 0;
 
-static void *malloc(int size);
-static void free(void *where);
-
 static void putstr(const char *);
 
 extern int end;
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
+static char *free_mem_ptr = (char *)&end, *free_mem_end_ptr;
 
 #define INPLACE_MOVE_ROUTINE  0x1000
 #define LOW_BUFFER_START      0x2000
@@ -80,38 +73,6 @@ static int lines, cols;
 
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
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-12-21 21:17:05.000000000 -0600
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
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-11-29 13:29:39.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-12-21 21:17:05.000000000 -0600
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
 
Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-11-29 13:29:38.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-12-21 21:17:21.000000000 -0600
@@ -109,6 +109,45 @@
 
 #include <asm/types.h>
 
+#ifndef NO_INFLATE_MALLOC
+/* A trivial malloc implementation, adapted from
+ *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ */
+
+static char *malloc_ptr;
+static int malloc_count;
+
+static void *malloc(int size)
+{
+	char *p;
+
+	if (size <0)
+		error("Malloc error");
+	if (!malloc_ptr)
+		malloc_ptr = free_mem_ptr;
+
+	malloc_ptr = (char *)(((unsigned long)malloc_ptr + 3) & ~3);
+	p = malloc_ptr;
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
@@ -895,16 +934,12 @@ static int INIT inflate(struct iostate *
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
