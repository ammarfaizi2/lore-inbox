Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVLVSeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVLVSeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVLVS2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:17 -0500
Received: from waste.org ([64.81.244.121]:10448 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030270AbVLVS2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:07 -0500
Date: Thu, 22 Dec 2005 12:26:45 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <12.150843412@selenic.com>
Message-Id: <13.150843412@selenic.com>
Subject: [PATCH 12/20] inflate: internalize (arch) most of the output window handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: internalize most of the output window handling

This moves the inflate window definition and handling into
lib/inflate.c and rather than calling a global flush_window function,
now calls a flush callback. The callback in most callers is also
greatly simplified.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-11-29 18:30:58.000000000 -0600
@@ -143,7 +143,10 @@ static void free(void *where)
 	if (!malloc_count)
 		malloc_ptr = free_mem_ptr;
 }
+
+static u8 window[0x8000]; /* use a statically allocated window */
 #else
+static u8 *window; /* dynamically allocate */
 #define malloc(a) kmalloc(a, GFP_KERNEL)
 #define free(a) kfree(a)
 #endif
@@ -169,8 +172,9 @@ struct huft {
 
 struct iostate {
 	u8 *window, *ibuf;
-	int ipos, isize, itotal, opos, osize, bits;
+	int ipos, isize, itotal, opos, osize, ototal, bits;
 	void (*fill)(u8 *ibuf, int len);
+	void (*flush)(const u8 *obuf, int len);
 	u32 buf, crc;
 };
 
@@ -190,10 +194,6 @@ static int INIT inflate(struct iostate *
    stream to find repeated byte strings.  This is implemented here as a
    circular buffer.  The index is updated simply by incrementing and then
    ANDing with 0x7fff (32K-1). */
-/* It is left to other modules to supply the 32 K area.  It is assumed
-   to be usable as if it were declared "u8 window[32768];" or as just
-   "u8 *window;" and then malloc'ed in the latter case.  The definition
-   must be in unzip.h, included above. */
 
 static void flush_output(struct iostate *io)
 {
@@ -203,8 +203,8 @@ static void flush_output(struct iostate 
 		io->crc = crc_32_tab[(io->window[i] ^ (int)io->crc) & 0xff]
 			^ (io->crc >> 8);
 
-	outcnt = io->opos;
-	flush_window();
+	io->flush(io->window, io->opos);
+	io->ototal += io->opos;
 	io->opos = 0;
 }
 
@@ -990,8 +990,10 @@ static void INIT makecrc(void)
  * @ibuf: input character pool
  * @isize: size of pool
  * @fill: function to fill the input pool
+ * @flush: function to flush the output pool
  */
-static int INIT gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size))
+static int INIT gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size),
+		       void (*flush)(const u8 *buf, int size))
 {
 	u8 flags;
 	unsigned char magic[2];	/* magic header */
@@ -1001,13 +1003,13 @@ static int INIT gunzip(u8 *ibuf, int isi
 	int res;
 	struct iostate io;
 
-	io.window = window;
-	io.osize = WSIZE;
-	io.opos = io.bits = io.buf = io.ipos = io.itotal = 0;
+	io.osize = 0x8000; /* 32k for inflate */
+	io.opos = io.bits = io.buf = io.ipos = io.itotal = io.ototal = 0;
 	io.crc = 0xffffffffUL;
 	io.isize = isize;
 	io.ibuf = ibuf;
 	io.fill = fill;
+	io.flush = flush;
 
 	makecrc(); /* initialize the CRC table */
 
@@ -1065,7 +1067,16 @@ static int INIT gunzip(u8 *ibuf, int isi
 			;
 
 	/* Decompress */
-	if ((res = inflate(&io))) {
+	io.window = window ? window : malloc(io.osize);
+	if (!io.window) {
+		error("couldn't allocate gunzip window\n");
+		return -1;
+	}
+	res = inflate(&io);
+	if (!window)
+		free(io.window);
+
+	if (res) {
 		switch (res) {
 		case 0:
 			break;
@@ -1105,7 +1116,7 @@ static int INIT gunzip(u8 *ibuf, int isi
 		error("crc error");
 		return -1;
 	}
-	if (orig_len != bytes_out) {
+	if (orig_len != io.ototal) {
 		error("length error");
 		return -1;
 	}
Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -32,21 +32,12 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch *window;		/* Sliding window buffer */
-static unsigned outcnt;		/* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 static char *input_data;
 static int  input_data_size;
 
 static uch *output_data;
-static ulg output_ptr;
-static ulg bytes_out;
 
 extern int end;
 static char *free_mem_ptr, *free_mem_ptr_end;
@@ -55,24 +46,11 @@ static char *free_mem_ptr, *free_mem_ptr
 
 #include "../../../lib/inflate.c"
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-void flush_window(void)
+/* flush gunzip output window */
+static void flush_window(const u8 *buf, int len)
 {
-	unsigned n;
-	uch *in, *out, ch;
-
-	in = window;
-	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++)
-		ch = *out++ = *in++;
-
-	bytes_out += (ulg)outcnt;
-	output_ptr += (ulg)outcnt;
-	outcnt = 0;
-/*	puts("."); */
+	while(len--)
+		*output_data++ = *buf++;
 }
 
 static void error(char *x)
@@ -90,6 +68,7 @@ decompress_kernel(void *output_start,
 		  size_t ksize,
 		  size_t kzsize)
 {
+	int count;
 	output_data		= (uch *)output_start;
 	input_data		= (uch *)input_start;
 	input_data_size		= kzsize; /* use compressed size */
@@ -99,11 +78,8 @@ decompress_kernel(void *output_start,
 	free_mem_ptr_end	= (char *)output_start + ksize + 0x200000;
 	/* FIXME FIXME FIXME */
 
-	/* put in temp area to reduce initial footprint */
-	window = malloc(WSIZE);
-
 /*	puts("Uncompressing Linux..."); */
-	gunzip(input_data, input_data_size, NULL);
+	count = gunzip(input_data, input_data_size, NULL, flush_window);
 /*	puts(" done, booting the kernel.\n"); */
-	return output_ptr;
+	return count;
 }
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -50,21 +50,12 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];	/* Sliding window buffer */
-static unsigned outcnt;		/* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 extern char input_data[];
 extern char input_data_end[];
 
 static uch *output_data;
-static ulg output_ptr;
-static ulg bytes_out;
 
 static void putstr(const char *);
 
@@ -79,23 +70,11 @@ static char *free_mem_ptr, *free_mem_ptr
 #define NO_INFLATE_MALLOC
 #endif
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-void flush_window(void)
+/* flush gunzip output window */
+static void flush_window(const u8 *buf, int len)
 {
-	unsigned n;
-	uch *in, *out, ch;
-
-	in = window;
-	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++)
-		ch = *out++ = *in++;
-
-	bytes_out += (ulg)outcnt;
-	output_ptr += (ulg)outcnt;
-	outcnt = 0;
+	while(len--)
+		*output_data++ = *buf++;
 	putstr(".");
 }
 
@@ -128,7 +107,7 @@ decompress_kernel(ulg output_start, ulg 
 	arch_decomp_setup();
 
 	putstr("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
 	putstr(" done, booting the kernel.\n");
 	return output_ptr;
 }
@@ -141,7 +120,7 @@ int main()
 	output_data = output_buffer;
 
 	putstr("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
 	putstr("done.\n");
 	return 0;
 }
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -35,21 +35,11 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];	/* Sliding window buffer */
-static unsigned outcnt;		/* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 extern char input_data[];
 extern char input_data_end[];
-
 static uch *output_data;
-static ulg output_ptr;
-static ulg bytes_out;
 
 static void puts(const char *);
 
@@ -64,23 +54,11 @@ static char *free_mem_ptr, *free_mem_ptr
 #define NO_INFLATE_MALLOC
 #endif
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-void flush_window(void)
+/* flush the gunzip output window */
+static void flush_window(const u8 *buf, int len)
 {
-	unsigned n;
-	uch *in, *out, ch;
-
-	in = window;
-	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++)
-		ch = *out++ = *in++;
-
-	bytes_out += (ulg)outcnt;
-	output_ptr += (ulg)outcnt;
-	outcnt = 0;
+	while (len--)
+		*output_data++ = *buf++;
 	puts(".");
 }
 
@@ -109,7 +87,7 @@ decompress_kernel(ulg output_start, ulg 
 	arch_decomp_setup();
 
 	puts("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
 	puts(" done, booting the kernel.\n");
 	return output_ptr;
 }
@@ -122,7 +100,7 @@ int main()
 	output_data = output_buffer;
 
 	puts("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
 	puts("done.\n");
 	return 0;
 }
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -32,21 +32,12 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];    /* Sliding window buffer */
 unsigned compsize; /* compressed size, used by head.S */
-static unsigned outcnt = 0;  /* bytes in output buffer */
 
-static void flush_window(void);
 static void error(char *m);
 
 extern char *input_data;  /* lives in head.S */
-
-static long bytes_out = 0;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void puts(const char *);
 
@@ -85,25 +76,11 @@ puts(const char *s)
 #endif
 }
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-
-static void
-flush_window()
+/* flush the gunzip output window */
+static void flush_window(const u8 *buf, int len)
 {
-    unsigned n;
-    uch *in, *out, ch;
-
-    in = window;
-    out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++)
-	    ch = *out++ = *in++;
-
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
+	while (len--)
+		*output_data++ = *buf++;
 }
 
 static void
@@ -163,6 +140,6 @@ decompress_kernel()
 	}
 
 	puts("Uncompressing Linux...\n");
-	compsize = gunzip(input_data, 0x7fffffff, NULL);
+	compsize = gunzip(input_data, 0x7fffffff, NULL, flush_window);
 	puts("Done. Now booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -34,20 +34,10 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];    /* Sliding window buffer */
-static unsigned outcnt = 0;  /* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 extern char *input_data;  /* lives in head.S */
-
-static long bytes_out = 0;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void puts(const char *);
 
@@ -98,25 +88,11 @@ puts(const char *s)
 #endif
 }
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-
-static void
-flush_window()
+/* flush the gunzip output window */
+static void flush_window(const u8 *buf, int len)
 {
-    unsigned n;
-    uch *in, *out, ch;
-
-    in = window;
-    out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++)
-	    ch = *out++ = *in++;
-
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
+	while (len--)
+		*output_data++ = *buf++;
 }
 
 static void
@@ -207,6 +183,6 @@ decompress_kernel()
 	}
 
 	puts("Uncompressing Linux...\n");
-	gunzip(input_data, 0x7fffffff, NULL);
+	gunzip(input_data, 0x7fffffff, NULL, flush_window);
 	puts("Done. Now booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -27,13 +27,6 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];    /* Sliding window buffer */
-static unsigned outcnt = 0;  /* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 /*
@@ -49,10 +42,8 @@ static unsigned char *real_mode; /* Poin
 
 extern char input_data[];
 extern int input_len;
-
-static long bytes_out = 0;
+static long bytes_out;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void putstr(const char *);
 
@@ -125,43 +116,15 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void flush_window_low(void)
-{
-    unsigned n;
-    uch *in, *out, ch;
-
-    in = window;
-    out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++)
-	    ch = *out++ = *in++;
-
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
-}
-
-static void flush_window_high(void)
+/* flush the gunzip output buffer */
+static void flush_window(const u8 *buf, int len)
 {
-    unsigned n;
-    uch *in,  ch;
-    in = window;
-    for (n = 0; n < outcnt; n++) {
-	ch = *output_data++ = *in++;
-	if ((ulg)output_data == low_buffer_end) output_data=high_buffer_start;
-    }
-
-    bytes_out += (ulg)outcnt;
-    outcnt = 0;
-}
-
-static void flush_window(void)
-{
-	if (high_loaded) flush_window_high();
-	else flush_window_low();
+	bytes_out += len;
+	while (len--) {
+		*output_data++ = *buf++;
+		if (high_loaded && (u32)output_data == low_buffer_end)
+			output_data = high_buffer_start;
+	}
 }
 
 static void error(char *x)
@@ -253,7 +216,7 @@ asmlinkage int decompress_kernel(struct 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	putstr("Uncompressing Linux... ");
-	gunzip(input_data, input_len, NULL);
+	gunzip(input_data, input_len, NULL, flush_window);
 	putstr("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -21,21 +21,11 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];    /* Sliding window buffer */
-static unsigned outcnt = 0;  /* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 static unsigned char *input_data;
 static int input_len;
-
-static long bytes_out = 0;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 #include "m32r_sio.c"
 
@@ -46,23 +36,11 @@ static char *free_mem_end_ptr;
 
 #include "../../../../lib/inflate.c"
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void flush_window(void)
+/* flush the gunzip output buffer */
+static void flush_window(const u8 *buf, int len)
 {
-    unsigned n;
-    uch *in, *out, ch;
-
-    in = window;
-    out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++)
-	    ch = *out++ = *in++;
-
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
+	while (len--)
+		*output_data++ = *buf++;
 }
 
 static void error(char *x)
@@ -87,6 +65,6 @@ decompress_kernel(int mmu_on, unsigned c
 	input_len = zimage_len;
 
 	puts("Uncompressing Linux... ");
-	gunzip(input_data, input_len, NULL);
+	gunzip(input_data, input_len, NULL, flush_window);
 	puts("Ok, booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -23,21 +23,11 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];    /* Sliding window buffer */
-static unsigned outcnt = 0;  /* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 extern char input_data[];
 extern int input_len;
-
-static long bytes_out = 0;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 int puts(const char *);
 
@@ -73,23 +63,11 @@ int puts(const char *s)
 }
 #endif
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void flush_window(void)
-{
-    unsigned n;
-    uch *in, *out, ch;
-
-    in = window;
-    out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++)
-	    ch = *out++ = *in++;
-
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
+/* flush the gunzip output window */
+static void flush_window(const u8 *buf, int len)
+{
+	while (len--)
+		*output_data++ = *buf++;
 }
 
 static void error(char *x)
@@ -113,6 +91,6 @@ void decompress_kernel(void)
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	puts("Uncompressing Linux... ");
-	gunzip(input_data, input_len, NULL);
+	gunzip(input_data, input_len, NULL, flush_window);
 	puts("Ok, booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -23,21 +23,11 @@ typedef unsigned char uch;
 typedef unsigned short ush;
 typedef unsigned long ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];	/* Sliding window buffer */
-static unsigned outcnt = 0;	/* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 extern char input_data[];
 extern int input_len;
-
-static long bytes_out = 0;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void puts(const char *);
 
@@ -53,23 +43,12 @@ void puts(const char *s)
 {
 }
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void flush_window(void)
+/* flush the gunzip window */
+static void flush_window(const u8 *buf, int len)
 {
-	unsigned n;
-	uch *in, *out, ch;
+	while(len--)
+		*output_data++ = *buf++;
 
-	in = window;
-	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++)
-		ch = *out++ = *in++;
-
-	bytes_out += (ulg) outcnt;
-	output_ptr += (ulg) outcnt;
-	outcnt = 0;
 	puts(".");
 }
 
@@ -94,7 +73,7 @@ void decompress_kernel(void)
 
 	puts("Uncompressing Linux... ");
 	cache_control(CACHE_ENABLE);
-	gunzip(input_data, input_len, NULL);
+	gunzip(input_data, input_len, NULL, flush_window);
 	puts("\n");
 
 #if 0
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:30:58.000000000 -0600
@@ -20,13 +20,6 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch window[WSIZE];    /* Sliding window buffer */
-static unsigned outcnt = 0;  /* bytes in output buffer */
-
-static void flush_window(void);
 static void error(char *m);
 
 /*
@@ -43,9 +36,8 @@ static unsigned char *real_mode; /* Poin
 extern unsigned char input_data[];
 extern int input_len;
 
-static long bytes_out = 0;
+static long bytes_out;
 static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void putstr(const char *);
 
@@ -114,43 +106,15 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void flush_window_low(void)
+/* flush the gunzip output window */
+static void flush_window(const u8 *buf, int len)
 {
-    unsigned n;
-    uch *in, *out, ch;
-
-    in = window;
-    out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++)
-	    ch = *out++ = *in++;
-
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
-}
-
-static void flush_window_high(void)
-{
-    unsigned n;
-    uch *in,  ch;
-    in = window;
-    for (n = 0; n < outcnt; n++) {
-	ch = *output_data++ = *in++;
-	if ((ulg)output_data == low_buffer_end) output_data=high_buffer_start;
-    }
-
-    bytes_out += (ulg)outcnt;
-    outcnt = 0;
-}
-
-static void flush_window(void)
-{
-	if (high_loaded) flush_window_high();
-	else flush_window_low();
+	bytes_out += len;
+	while (len--) {
+		*output_data++ = *buf++;
+		if (high_loaded && output_data == (u8 *)low_buffer_end)
+			output_data = high_buffer_start;
+	}
 }
 
 static void error(char *x)
@@ -200,7 +164,7 @@ void setup_output_buffer_if_we_run_high(
 	mv->high_buffer_start = high_buffer_start;
 }
 
-void close_output_buffer_if_we_run_high(struct moveparams *mv)
+void close_output_buffer_if_we_run_high(struct moveparams *mv, int bytes_out)
 {
 	if (bytes_out > low_buffer_size) {
 		mv->lcount = low_buffer_size;
@@ -231,7 +195,7 @@ int decompress_kernel(struct moveparams 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	putstr(".\nDecompressing Linux...");
-	gunzip(input_data, input_len, NULL);
+	gunzip(input_data, input_len, NULL, flush_window);
 	putstr("done.\nBooting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-11-29 18:30:58.000000000 -0600
@@ -278,20 +278,13 @@ typedef unsigned short ush;
 typedef unsigned long  ulg;
 
 #define INBUFSIZ 4096
-#define WSIZE 0x8000    /* window size--must be a power of two, and */
-			/*  at least 32K for zip's deflate method */
-
 static uch *inbuf;
-static uch *window;
-static unsigned outcnt;  /* bytes in output buffer */
 static int exit_code;
 static int unzip_error;
-static long bytes_out;
 static int crd_infd, crd_outfd;
 
 #define INIT __init
 
-static void __init flush_window(void);
 static void __init error(char *m);
 
 #define NO_INFLATE_MALLOC
@@ -308,27 +301,17 @@ static void __init fill_inbuf(u8 *buf, i
 		error("RAMDISK: ran out of compressed data");
 }
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void __init flush_window(void)
+/* Write the output window from gunzip */
+static void __init flush_buffer(const u8 *buf, int len)
 {
-    unsigned n, written;
-    uch *in, ch;
-
-    written = sys_write(crd_outfd, window, outcnt);
-    if (written != outcnt && unzip_error == 0) {
-	printk(KERN_ERR "RAMDISK: incomplete write (%d != %d) %ld\n",
-	       written, outcnt, bytes_out);
-	unzip_error = 1;
-    }
-    in = window;
-    for (n = 0; n < outcnt; n++)
-	    ch = *in++;
+	unsigned written;
 
-    bytes_out += (ulg)outcnt;
-    outcnt = 0;
+	written = sys_write(crd_outfd, buf, len);
+	if (written != len && unzip_error == 0) {
+		printk(KERN_ERR "RAMDISK: incomplete write (%d != %d)\n",
+		       written, len);
+		unzip_error = 1;
+	}
 }
 
 static void __init error(char *x)
@@ -342,9 +325,7 @@ static int __init crd_load(int in_fd, in
 {
 	int result;
 
-	outcnt = 0;		/* bytes in output buffer */
 	exit_code = 0;
-	bytes_out = 0;
 
 	crd_infd = in_fd;
 	crd_outfd = out_fd;
@@ -353,17 +334,10 @@ static int __init crd_load(int in_fd, in
 		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip buffer\n");
 		return -1;
 	}
-	window = kmalloc(WSIZE, GFP_KERNEL);
-	if (window == 0) {
-		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip window\n");
-		kfree(inbuf);
-		return -1;
-	}
-	result = gunzip(inbuf, INBUFSIZ, fill_inbuf);
+	result = gunzip(inbuf, INBUFSIZ, fill_inbuf, flush_buffer);
 	if (unzip_error)
 		result = 1;
 	kfree(inbuf);
-	kfree(window);
 	return result;
 }
 
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-11-29 18:30:19.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-11-29 18:30:58.000000000 -0600
@@ -309,12 +309,12 @@ static int __init write_buffer(char *buf
 	return len - count;
 }
 
-static void __init flush_buffer(char *buf, unsigned len)
+static void __init flush_buffer(const u8 *buf, int len)
 {
 	int written;
 	if (message)
 		return;
-	while ((written = write_buffer(buf, len)) < len && !message) {
+	while ((written = write_buffer((char *)buf, len)) < len && !message) {
 		char c = buf[written];
 		if (c == '0') {
 			buf += written;
@@ -337,41 +337,14 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000    /* window size--must be a power of two, and */
-			/*  at least 32K for zip's deflate method */
-
-static uch *window;
-
-static unsigned outcnt;  /* bytes in output buffer */
-static long bytes_out;
-
 #define INIT __init
 
-static void __init flush_window(void);
 static void __init error(char *m);
 
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
 
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update bytes_out.
- * (Used for the decompressed data only.)
- */
-static void __init flush_window(void)
-{
-	unsigned n;
-	uch *in, ch;
-
-	flush_buffer(window, outcnt);
-	in = window;
-	for (n = 0; n < outcnt; n++)
-		ch = *in++;
-
-	bytes_out += (ulg)outcnt;
-	outcnt = 0;
-}
-
 static char * __init unpack_to_rootfs(char *buf, unsigned len, int check_only)
 {
 	int written, cnt;
@@ -379,8 +352,7 @@ static char * __init unpack_to_rootfs(ch
 	header_buf = kmalloc(110, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
-	window = kmalloc(WSIZE, GFP_KERNEL);
-	if (!window || !header_buf || !symlink_buf || !name_buf)
+	if (!header_buf || !symlink_buf || !name_buf)
 		panic("can't allocate buffers");
 	state = Start;
 	this_header = 0;
@@ -401,16 +373,13 @@ static char * __init unpack_to_rootfs(ch
 			continue;
 		}
 		this_header = 0;
-		outcnt = 0;		/* bytes in output buffer */
-		bytes_out = 0;
-		cnt = gunzip(buf, len, NULL);
+		cnt = gunzip(buf, len, NULL, flush_buffer);
 		if (state != Reset)
 			error("junk in gzipped archive");
 		this_header = saved_offset + cnt;
 		buf += cnt;
 		len -= cnt;
 	}
-	kfree(window);
 	kfree(name_buf);
 	kfree(symlink_buf);
 	kfree(header_buf);
