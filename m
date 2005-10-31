Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVJaVDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVJaVDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVJaVB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:01:56 -0500
Received: from waste.org ([216.27.176.166]:11672 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932543AbVJaVAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:40 -0500
Date: Mon, 31 Oct 2005 14:54:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <11.196662837@selenic.com>
Message-Id: <12.196662837@selenic.com>
Subject: [PATCH 11/20] inflate: (arch) kill get_byte
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: replace get_byte with readbyte

Each inflate user was providing a get_byte macro that hid the details
of tracking the input buffer. This is now handled with new variables
in the iostate structure and a callback (most users pass NULL as the
entire input is provided in a single buffer).

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14.orig/arch/alpha/boot/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/alpha/boot/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -35,16 +35,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;		/* input buffer */
 static uch *window;		/* Sliding window buffer */
-
-static unsigned insize;		/* valid bytes in inbuf */
-static unsigned inptr;		/* index of next byte to be processed in inbuf */
 static unsigned outcnt;		/* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -64,22 +57,6 @@ static ulg free_mem_ptr_end;
 #include "../../../lib/inflate.c"
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-int fill_inbuf(void)
-{
-	if (insize != 0)
-		error("ran out of input data");
-
-	inbuf = input_data;
-	insize = input_data_size;
-
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -127,7 +104,7 @@ decompress_kernel(void *output_start,
 	window = malloc(WSIZE);
 
 /*	puts("Uncompressing Linux..."); */
-	gunzip();
+	gunzip(input_data, input_data_size, NULL);
 /*	puts(" done, booting the kernel.\n"); */
 	return output_ptr;
 }
Index: 2.6.14/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/arm/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -53,16 +53,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;		/* input buffer */
 static uch window[WSIZE];	/* Sliding window buffer */
-
-static unsigned insize;		/* valid bytes in inbuf */
-static unsigned inptr;		/* index of next byte to be processed in inbuf */
 static unsigned outcnt;		/* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -88,22 +81,6 @@ static ulg free_mem_ptr_end;
 #endif
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-int fill_inbuf(void)
-{
-	if (insize != 0)
-		error("ran out of input data");
-
-	inbuf = input_data;
-	insize = &input_data_end[0] - &input_data[0];
-
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -146,7 +123,7 @@ decompress_kernel(ulg output_start, ulg 
 	arch_decomp_setup();
 
 	putstr("Uncompressing Linux...");
-	gunzip();
+	gunzip(input_data, input_data_end - input_data, NULL);
 	putstr(" done, booting the kernel.\n");
 	return output_ptr;
 }
@@ -159,7 +136,7 @@ int main()
 	output_data = output_buffer;
 
 	putstr("Uncompressing Linux...");
-	gunzip();
+	gunzip(input_data, input_data_end - input_data, NULL);
 	putstr("done.\n");
 	return 0;
 }
Index: 2.6.14/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/arm26/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -38,16 +38,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;		/* input buffer */
 static uch window[WSIZE];	/* Sliding window buffer */
-
-static unsigned insize;		/* valid bytes in inbuf */
-static unsigned inptr;		/* index of next byte to be processed in inbuf */
 static unsigned outcnt;		/* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -73,22 +66,6 @@ static ulg free_mem_ptr_end;
 #endif
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-int fill_inbuf(void)
-{
-	if (insize != 0)
-		error("ran out of input data");
-
-	inbuf = input_data;
-	insize = &input_data_end[0] - &input_data[0];
-
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -133,7 +110,7 @@ decompress_kernel(ulg output_start, ulg 
 	arch_decomp_setup();
 
 	puts("Uncompressing Linux...");
-	gunzip();
+	gunzip(input_data, input_data_end - input_data, NULL);
 	puts(" done, booting the kernel.\n");
 	return output_ptr;
 }
@@ -146,7 +123,7 @@ int main()
 	output_data = output_buffer;
 
 	puts("Uncompressing Linux...");
-	gunzip();
+	gunzip(input_data, input_data_end - input_data, NULL);
 	puts("done.\n");
 	return 0;
 }
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/head.S
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/head.S	2005-10-28 22:01:13.000000000 -0700
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/head.S	2005-10-28 22:04:17.000000000 -0700
@@ -104,7 +104,7 @@ basse:	move.d	pc, r5
 	;; when mounting from flash
 
 	move.d	[_input_data], r9	; flash address of compressed kernel
-	add.d	[_inptr], r9		; size of compressed kernel
+	add.d	[_compsize], r9		; size of compressed kernel
 
 	;; Restore command line magic and address.
 	move.d  _cmd_line_magic, $r10
Index: 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/cris/arch-v10/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -35,19 +35,10 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
-
-unsigned inptr = 0;	/* index of next byte to be processed in inbuf
-			 * After decompression it will contain the
-			 * compressed size, and head.S will read it.
-			 */
-
+unsigned compsize; /* compressed size, used by head.S */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-#define get_byte() inbuf[inptr++]
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -172,6 +163,6 @@ decompress_kernel()
 	}
 
 	puts("Uncompressing Linux...\n");
-	gunzip();
+	compsize = gunzip(input_data, 0x7fffffff, NULL);
 	puts("Done. Now booting the kernel.\n");
 }
Index: 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/cris/arch-v32/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -37,19 +37,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
-
-unsigned inptr = 0;	/* index of next byte to be processed in inbuf
-			 * After decompression it will contain the
-			 * compressed size, and head.S will read it.
-			 */
-
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-#define get_byte() inbuf[inptr++]
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -217,6 +207,6 @@ decompress_kernel()
 	}
 
 	puts("Uncompressing Linux...\n");
-	gunzip();
+	gunzip(input_data, 0x7fffffff, NULL);
 	puts("Done. Now booting the kernel.\n");
 }
Index: 2.6.14/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/i386/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -30,16 +30,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
-
-static unsigned insize = 0;  /* valid bytes in inbuf */
-static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -134,22 +127,6 @@ static void putstr(const char *s)
 }
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int fill_inbuf(void)
-{
-	if (insize != 0) {
-		error("ran out of input data");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -277,7 +254,7 @@ asmlinkage int decompress_kernel(struct 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	putstr("Uncompressing Linux... ");
-	gunzip();
+	gunzip(input_data, input_len, NULL);
 	putstr("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
Index: 2.6.14/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/m32r/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -24,16 +24,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
-
-static unsigned insize = 0;  /* valid bytes in inbuf */
-static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -54,22 +47,6 @@ static unsigned long free_mem_end_ptr;
 #include "../../../../lib/inflate.c"
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int fill_inbuf(void)
-{
-	if (insize != 0) {
-		error("ran out of input data");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -110,6 +87,6 @@ decompress_kernel(int mmu_on, unsigned c
 	input_len = zimage_len;
 
 	puts("Uncompressing Linux... ");
-	gunzip();
+	gunzip(input_data, input_len, NULL);
 	puts("Ok, booting the kernel.\n");
 }
Index: 2.6.14/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/sh/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -26,16 +26,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
-
-static unsigned insize = 0;  /* valid bytes in inbuf */
-static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -82,22 +75,6 @@ int puts(const char *s)
 #endif
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int fill_inbuf(void)
-{
-	if (insize != 0) {
-		error("ran out of input data");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -137,6 +114,6 @@ void decompress_kernel(void)
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	puts("Uncompressing Linux... ");
-	gunzip();
+	gunzip(input_data, input_len, NULL);
 	puts("Ok, booting the kernel.\n");
 }
Index: 2.6.14/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/sh64/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -26,16 +26,9 @@ typedef unsigned long ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;		/* input buffer */
 static uch window[WSIZE];	/* Sliding window buffer */
-
-static unsigned insize = 0;	/* valid bytes in inbuf */
-static unsigned inptr = 0;	/* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;	/* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -62,22 +55,6 @@ void puts(const char *s)
 }
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int fill_inbuf(void)
-{
-	if (insize != 0) {
-		error("ran out of input data\n");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -118,7 +95,7 @@ void decompress_kernel(void)
 
 	puts("Uncompressing Linux... ");
 	cache_control(CACHE_ENABLE);
-	gunzip();
+	gunzip(input_data, input_len, NULL);
 	puts("\n");
 
 #if 0
Index: 2.6.14/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14.orig/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/arch/x86_64/boot/compressed/misc.c	2005-10-28 22:04:17.000000000 -0700
@@ -23,16 +23,9 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
-
-static unsigned insize = 0;  /* valid bytes in inbuf */
-static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt = 0;  /* bytes in output buffer */
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
-static int  fill_inbuf(void);
 static void flush_window(void);
 static void error(char *m);
 
@@ -123,22 +116,6 @@ static void putstr(const char *s)
 }
 
 /* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int fill_inbuf(void)
-{
-	if (insize != 0) {
-		error("ran out of input data");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
-}
-
-/* ===========================================================================
  * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
@@ -255,7 +232,7 @@ int decompress_kernel(struct moveparams 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	putstr(".\nDecompressing Linux...");
-	gunzip();
+	gunzip(input_data, input_len, NULL);
 	putstr("done.\nBooting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
Index: 2.6.14/init/do_mounts_rd.c
===================================================================
--- 2.6.14.orig/init/do_mounts_rd.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/init/do_mounts_rd.c	2005-10-28 22:04:17.000000000 -0700
@@ -283,20 +283,14 @@ typedef unsigned long  ulg;
 
 static uch *inbuf;
 static uch *window;
-
-static unsigned insize;  /* valid bytes in inbuf */
-static unsigned inptr;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt;  /* bytes in output buffer */
 static int exit_code;
 static int unzip_error;
 static long bytes_out;
 static int crd_infd, crd_outfd;
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-
 #define INIT __init
 
-static int  __init fill_inbuf(void);
 static void __init flush_window(void);
 static void __init error(char *m);
 
@@ -304,24 +298,14 @@ static void __init error(char *m);
 
 #include "../lib/inflate.c"
 
-/* ===========================================================================
+/*
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
- * Returning -1 does not guarantee that gunzip() will ever return.
  */
-static int __init fill_inbuf(void)
+static void __init fill_inbuf(u8 *buf, int len)
 {
-	if (exit_code) return -1;
-	
-	insize = sys_read(crd_infd, inbuf, INBUFSIZ);
-	if (insize == 0) {
+	if (!sys_read(crd_infd, buf, len))
 		error("RAMDISK: ran out of compressed data");
-		return -1;
-	}
-
-	inptr = 1;
-
-	return inbuf[0];
 }
 
 /* ===========================================================================
@@ -358,8 +342,6 @@ static int __init crd_load(int in_fd, in
 {
 	int result;
 
-	insize = 0;		/* valid bytes in inbuf */
-	inptr = 0;		/* index of next byte to be processed in inbuf */
 	outcnt = 0;		/* bytes in output buffer */
 	exit_code = 0;
 	bytes_out = 0;
@@ -377,7 +359,7 @@ static int __init crd_load(int in_fd, in
 		kfree(inbuf);
 		return -1;
 	}
-	result = gunzip();
+	result = gunzip(inbuf, INBUFSIZ, fill_inbuf);
 	if (unzip_error)
 		result = 1;
 	kfree(inbuf);
Index: 2.6.14/init/initramfs.c
===================================================================
--- 2.6.14.orig/init/initramfs.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/init/initramfs.c	2005-10-28 22:04:17.000000000 -0700
@@ -340,16 +340,11 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000    /* window size--must be a power of two, and */
 			/*  at least 32K for zip's deflate method */
 
-static uch *inbuf;
 static uch *window;
 
-static unsigned insize;  /* valid bytes in inbuf */
-static unsigned inptr;   /* index of next byte to be processed in inbuf */
 static unsigned outcnt;  /* bytes in output buffer */
 static long bytes_out;
 
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : -1)
-
 #define INIT __init
 
 static void __init flush_window(void);
@@ -379,7 +374,7 @@ static void __init flush_window(void)
 
 static char * __init unpack_to_rootfs(char *buf, unsigned len, int check_only)
 {
-	int written;
+	int written, cnt;
 	dry_run = check_only;
 	header_buf = kmalloc(110, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
@@ -406,17 +401,14 @@ static char * __init unpack_to_rootfs(ch
 			continue;
 		}
 		this_header = 0;
-		insize = len;
-		inbuf = buf;
-		inptr = 0;
 		outcnt = 0;		/* bytes in output buffer */
 		bytes_out = 0;
-		gunzip();
+		cnt = gunzip(buf, len, NULL);
 		if (state != Reset)
 			error("junk in gzipped archive");
-		this_header = saved_offset + inptr;
-		buf += inptr;
-		len -= inptr;
+		this_header = saved_offset + cnt;
+		buf += cnt;
+		len -= cnt;
 	}
 	kfree(window);
 	kfree(name_buf);
Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-28 22:04:15.000000000 -0700
+++ 2.6.14/lib/inflate.c	2005-10-28 22:04:17.000000000 -0700
@@ -169,8 +169,9 @@ struct huft {
 };
 
 struct iostate {
-	u8 *window;
-	int opos, osize, bits;
+	u8 *window, *ibuf;
+	int ipos, isize, itotal, opos, osize, bits;
+	void (*fill)(u8 *ibuf, int len);
 	u32 buf, crc;
 };
 
@@ -297,10 +298,21 @@ static const u16 cpdext[] = {
    the stream.
  */
 
+static inline u32 readbyte(struct iostate *io)
+{
+	if (io->ipos == io->isize) {
+		io->fill(io->ibuf, io->isize);
+		io->itotal += io->ipos;
+		io->ipos = 0;
+	}
+
+	return io->ibuf[io->ipos++];
+}
+
 static inline u32 readbits(struct iostate *io, int n)
 {
 	for( ; io->bits < n; io->bits += 8)
-		io->buf |= (u32)get_byte() << io->bits;
+		io->buf |= readbyte(io) << io->bits;
 	return io->buf & ((1 << n) - 1);
 }
 
@@ -319,7 +331,7 @@ static inline u32 pullbits(struct iostat
 
 static inline void popbytes(struct iostate *io)
 {
-	inptr -= (io->bits >> 3);
+	io->ipos -= (io->bits >> 3);
 	io->bits &= 7;
 }
 
@@ -711,7 +723,7 @@ static int INIT inflate_stored(struct io
 
 	/* read and output the compressed data */
 	while (n--)
-		put_byte(io, get_byte());
+		put_byte(io, readbyte(io));
 
 	DEBG(">");
 	return 0;
@@ -975,9 +987,12 @@ static void INIT makecrc(void)
 #define RESERVED     0xC0 /* bit 6,7:   reserved */
 
 /*
- * Do the uncompression!
+ * gunzip - do the uncompression!
+ * @ibuf: input character pool
+ * @isize: size of pool
+ * @fill: function to fill the input pool
  */
-static int INIT gunzip(void)
+static int INIT gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size))
 {
 	u8 flags;
 	unsigned char magic[2];	/* magic header */
@@ -989,14 +1004,17 @@ static int INIT gunzip(void)
 
 	io.window = window;
 	io.osize = WSIZE;
-	io.opos = io.bits = io.buf = 0;
+	io.opos = io.bits = io.buf = io.ipos = io.itotal = 0;
 	io.crc = 0xffffffffUL;
+	io.isize = isize;
+	io.ibuf = ibuf;
+	io.fill = fill;
 
 	makecrc(); /* initialize the CRC table */
 
-	magic[0] = get_byte();
-	magic[1] = get_byte();
-	method = get_byte();
+	magic[0] = readbyte(&io);
+	magic[1] = readbyte(&io);
+	method = readbyte(&io);
 
 	if (magic[0] != 037 || ((magic[1] != 0213) && (magic[1] != 0236))) {
 		error("bad gzip magic numbers");
@@ -1009,7 +1027,7 @@ static int INIT gunzip(void)
 		return -1;
 	}
 
-	flags = (u8)get_byte();
+	flags = readbyte(&io);
 	if (flags & ENCRYPTED) {
 		error("Input is encrypted");
 		return -1;
@@ -1022,29 +1040,29 @@ static int INIT gunzip(void)
 		error("Input has invalid flags");
 		return -1;
 	}
-	get_byte();		/* Get timestamp */
-	get_byte();
-	get_byte();
-	get_byte();
+	readbyte(&io); /* skip timestamp */
+	readbyte(&io);
+	readbyte(&io);
+	readbyte(&io);
 
-	get_byte();	/* Ignore extra flags for the moment */
-	get_byte();	/* Ignore OS type for the moment */
+	readbyte(&io); /* Ignore extra flags */
+	readbyte(&io); /* Ignore OS type */
 
 	if (flags & EXTRA_FIELD) {
-		unsigned len = (unsigned)get_byte();
-		len |= ((unsigned)get_byte()) << 8;
+		unsigned len = readbyte(&io);
+		len |= readbyte(&io) << 8;
 		while (len--)
-			get_byte();
+			readbyte(&io);
 	}
 
 	/* Discard original file name if it was truncated */
 	if (flags & ORIG_NAME)
-		while (get_byte())
+		while (readbyte(&io))
 			;
 
 	/* Discard file comment if any */
 	if (flags & COMMENT)
-		while (get_byte())
+		while (readbyte(&io))
 			;
 
 	/* Decompress */
@@ -1073,15 +1091,15 @@ static int INIT gunzip(void)
 	/* Get the crc and original length
 	 * uncompressed input size modulo 2^32
 	 */
-	orig_crc = (u32)get_byte();
-	orig_crc |= (u32)get_byte() << 8;
-	orig_crc |= (u32)get_byte() << 16;
-	orig_crc |= (u32)get_byte() << 24;
-
-	orig_len = (u32)get_byte();
-	orig_len |= (u32)get_byte() << 8;
-	orig_len |= (u32)get_byte() << 16;
-	orig_len |= (u32)get_byte() << 24;
+	orig_crc = readbyte(&io);
+	orig_crc |= readbyte(&io) << 8;
+	orig_crc |= readbyte(&io) << 16;
+	orig_crc |= readbyte(&io) << 24;
+
+	orig_len = readbyte(&io);
+	orig_len |= readbyte(&io) << 8;
+	orig_len |= readbyte(&io) << 16;
+	orig_len |= readbyte(&io) << 24;
 
 	/* Validate decompression */
 	if (orig_crc != ~io.crc) {
@@ -1092,5 +1110,6 @@ static int INIT gunzip(void)
 		error("length error");
 		return -1;
 	}
-	return 0;
+
+	return io.itotal + io.ipos;
 }
