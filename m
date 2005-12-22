Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVLVS2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVLVS2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVLVS2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:30 -0500
Received: from waste.org ([64.81.244.121]:7376 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030266AbVLVS2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:01 -0500
Date: Thu, 22 Dec 2005 12:26:42 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <10.150843412@selenic.com>
Message-Id: <11.150843412@selenic.com>
Subject: [PATCH 10/20] inflate: (arch) kill external CRC calculation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: move CRC calculation

Each inflate user was doing its own open-coded CRC calculation and
initializing its own CRC table. This is now hidden inside
lib/inflate.c

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-11-29 13:33:25.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -79,22 +79,19 @@ int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 void flush_window(void)
 {
-	ulg c = crc;
 	unsigned n;
 	uch *in, *out, ch;
 
 	in = window;
 	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++) {
+	for (n = 0; n < outcnt; n++)
 		ch = *out++ = *in++;
-		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-	}
-	crc = c;
+
 	bytes_out += (ulg)outcnt;
 	output_ptr += (ulg)outcnt;
 	outcnt = 0;
@@ -128,7 +125,6 @@ decompress_kernel(void *output_start,
 	/* put in temp area to reduce initial footprint */
 	window = malloc(WSIZE);
 
-	makecrc();
 /*	puts("Uncompressing Linux..."); */
 	gunzip();
 /*	puts(" done, booting the kernel.\n"); */
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-11-29 14:00:03.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -103,22 +103,19 @@ int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 void flush_window(void)
 {
-	ulg c = crc;
 	unsigned n;
 	uch *in, *out, ch;
 
 	in = window;
 	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++) {
+	for (n = 0; n < outcnt; n++)
 		ch = *out++ = *in++;
-		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-	}
-	crc = c;
+
 	bytes_out += (ulg)outcnt;
 	output_ptr += (ulg)outcnt;
 	outcnt = 0;
@@ -153,7 +150,6 @@ decompress_kernel(ulg output_start, ulg 
 
 	arch_decomp_setup();
 
-	makecrc();
 	putstr("Uncompressing Linux...");
 	gunzip();
 	putstr(" done, booting the kernel.\n");
@@ -167,7 +163,6 @@ int main()
 {
 	output_data = output_buffer;
 
-	makecrc();
 	putstr("Uncompressing Linux...");
 	gunzip();
 	putstr("done.\n");
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-11-29 13:59:39.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -88,22 +88,19 @@ int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 void flush_window(void)
 {
-	ulg c = crc;
 	unsigned n;
 	uch *in, *out, ch;
 
 	in = window;
 	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++) {
+	for (n = 0; n < outcnt; n++)
 		ch = *out++ = *in++;
-		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-	}
-	crc = c;
+
 	bytes_out += (ulg)outcnt;
 	output_ptr += (ulg)outcnt;
 	outcnt = 0;
@@ -134,7 +131,6 @@ decompress_kernel(ulg output_start, ulg 
 
 	arch_decomp_setup();
 
-	makecrc();
 	puts("Uncompressing Linux...");
 	gunzip();
 	puts(" done, booting the kernel.\n");
@@ -148,7 +144,6 @@ int main()
 {
 	output_data = output_buffer;
 
-	makecrc();
 	puts("Uncompressing Linux...");
 	gunzip();
 	puts("done.\n");
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 13:59:04.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -95,24 +95,21 @@ puts(const char *s)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 
 static void
 flush_window()
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
-    
+
     in = window;
-    out = &output_data[output_ptr]; 
-    for (n = 0; n < outcnt; n++) {
+    out = &output_data[output_ptr];
+    for (n = 0; n < outcnt; n++)
 	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     output_ptr += (ulg)outcnt;
     outcnt = 0;
@@ -167,8 +164,6 @@ decompress_kernel()
 
 	setup_normal_output_buffer();
 
-	makecrc();
-
 	__asm__ volatile ("move vr,%0" : "=rm" (revision));
 	if (revision < 10)
 	{
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 13:58:38.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -109,24 +109,21 @@ puts(const char *s)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 
 static void
 flush_window()
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
 
     in = window;
     out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++) {
+    for (n = 0; n < outcnt; n++)
 	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     output_ptr += (ulg)outcnt;
     outcnt = 0;
@@ -212,8 +209,6 @@ decompress_kernel()
 
 	setup_normal_output_buffer();
 
-	makecrc();
-
 	__asm__ volatile ("move $vr,%0" : "=rm" (revision));
 	if (revision < 32)
 	{
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-11-29 13:57:55.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -149,22 +149,19 @@ static int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void flush_window_low(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
-    
+
     in = window;
-    out = &output_data[output_ptr]; 
-    for (n = 0; n < outcnt; n++) {
+    out = &output_data[output_ptr];
+    for (n = 0; n < outcnt; n++)
 	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     output_ptr += (ulg)outcnt;
     outcnt = 0;
@@ -172,16 +169,14 @@ static void flush_window_low(void)
 
 static void flush_window_high(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in,  ch;
     in = window;
     for (n = 0; n < outcnt; n++) {
 	ch = *output_data++ = *in++;
 	if ((ulg)output_data == low_buffer_end) output_data=high_buffer_start;
-	c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
     }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     outcnt = 0;
 }
@@ -280,7 +275,6 @@ asmlinkage int decompress_kernel(struct 
 	if ((long)free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
 
-	makecrc();
 	putstr("Uncompressing Linux... ");
 	gunzip();
 	putstr("Ok, booting the kernel.\n");
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-11-29 13:56:48.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -70,22 +70,19 @@ static int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void flush_window(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
 
     in = window;
     out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++) {
+    for (n = 0; n < outcnt; n++)
 	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     output_ptr += (ulg)outcnt;
     outcnt = 0;
@@ -112,7 +109,6 @@ decompress_kernel(int mmu_on, unsigned c
 	input_data = zimage_data;
 	input_len = zimage_len;
 
-	makecrc();
 	puts("Uncompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-11-29 13:56:07.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -97,22 +97,19 @@ static int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void flush_window(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
 
     in = window;
     out = &output_data[output_ptr];
-    for (n = 0; n < outcnt; n++) {
+    for (n = 0; n < outcnt; n++)
 	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     output_ptr += (ulg)outcnt;
     outcnt = 0;
@@ -138,7 +135,6 @@ void decompress_kernel(void)
 	free_mem_ptr = (char *)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
-	makecrc();
 	puts("Uncompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-11-29 13:55:49.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -77,22 +77,19 @@ static int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void flush_window(void)
 {
-	ulg c = crc;		/* temporary variable */
 	unsigned n;
 	uch *in, *out, ch;
 
 	in = window;
 	out = &output_data[output_ptr];
-	for (n = 0; n < outcnt; n++) {
+	for (n = 0; n < outcnt; n++)
 		ch = *out++ = *in++;
-		c = crc_32_tab[((int) c ^ ch) & 0xff] ^ (c >> 8);
-	}
-	crc = c;
+
 	bytes_out += (ulg) outcnt;
 	output_ptr += (ulg) outcnt;
 	outcnt = 0;
@@ -118,7 +115,6 @@ void decompress_kernel(void)
 	free_mem_ptr = (char *)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
-	makecrc();
 	puts("Uncompressing Linux... ");
 	cache_control(CACHE_ENABLE);
 	gunzip();
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-11-29 13:55:11.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-11-29 18:30:03.000000000 -0600
@@ -138,22 +138,19 @@ static int fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void flush_window_low(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
-    
+
     in = window;
-    out = &output_data[output_ptr]; 
-    for (n = 0; n < outcnt; n++) {
+    out = &output_data[output_ptr];
+    for (n = 0; n < outcnt; n++)
 	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     output_ptr += (ulg)outcnt;
     outcnt = 0;
@@ -161,16 +158,14 @@ static void flush_window_low(void)
 
 static void flush_window_high(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in,  ch;
     in = window;
     for (n = 0; n < outcnt; n++) {
 	ch = *output_data++ = *in++;
 	if ((ulg)output_data == low_buffer_end) output_data=high_buffer_start;
-	c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
     }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     outcnt = 0;
 }
@@ -258,7 +253,6 @@ int decompress_kernel(struct moveparams 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
 
-	makecrc();
 	putstr(".\nDecompressing Linux...");
 	gunzip();
 	putstr("done.\nBooting the kernel.\n");
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-11-29 13:29:41.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-11-29 18:30:03.000000000 -0600
@@ -325,15 +325,14 @@ static int __init fill_inbuf(void)
 }
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void __init flush_window(void)
 {
-    ulg c = crc;         /* temporary variable */
     unsigned n, written;
     uch *in, ch;
-    
+
     written = sys_write(crd_outfd, window, outcnt);
     if (written != outcnt && unzip_error == 0) {
 	printk(KERN_ERR "RAMDISK: incomplete write (%d != %d) %ld\n",
@@ -341,11 +340,9 @@ static void __init flush_window(void)
 	unzip_error = 1;
     }
     in = window;
-    for (n = 0; n < outcnt; n++) {
+    for (n = 0; n < outcnt; n++)
 	    ch = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
+
     bytes_out += (ulg)outcnt;
     outcnt = 0;
 }
@@ -366,7 +363,6 @@ static int __init crd_load(int in_fd, in
 	outcnt = 0;		/* bytes in output buffer */
 	exit_code = 0;
 	bytes_out = 0;
-	crc = (ulg)0xffffffffL; /* shift register contents */
 
 	crd_infd = in_fd;
 	crd_outfd = out_fd;
@@ -381,7 +377,6 @@ static int __init crd_load(int in_fd, in
 		kfree(inbuf);
 		return -1;
 	}
-	makecrc();
 	result = gunzip();
 	if (unzip_error)
 		result = 1;
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-11-29 13:29:41.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-11-29 18:30:03.000000000 -0600
@@ -360,22 +360,19 @@ static void __init error(char *m);
 #include "../lib/inflate.c"
 
 /* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * Write the output window window[0..outcnt-1] and update bytes_out.
  * (Used for the decompressed data only.)
  */
 static void __init flush_window(void)
 {
-	ulg c = crc;         /* temporary variable */
 	unsigned n;
 	uch *in, ch;
 
 	flush_buffer(window, outcnt);
 	in = window;
-	for (n = 0; n < outcnt; n++) {
+	for (n = 0; n < outcnt; n++)
 		ch = *in++;
-		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-	}
-	crc = c;
+
 	bytes_out += (ulg)outcnt;
 	outcnt = 0;
 }
@@ -414,8 +411,6 @@ static char * __init unpack_to_rootfs(ch
 		inptr = 0;
 		outcnt = 0;		/* bytes in output buffer */
 		bytes_out = 0;
-		crc = (ulg)0xffffffffL; /* shift register contents */
-		makecrc();
 		gunzip();
 		if (state != Reset)
 			error("junk in gzipped archive");
Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-11-29 13:43:55.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-11-29 18:30:03.000000000 -0600
@@ -149,7 +149,6 @@ static void free(void *where)
 #endif
 
 static u32 crc_32_tab[256];
-static u32 crc;		/* dummy var until users get cleaned up */
 #define CRCPOLY_LE 0xedb88320
 
 /* Huffman code lookup table entry--this entry is four bytes for machines
@@ -992,6 +991,8 @@ static int INIT gunzip(void)
 	io.opos = io.bits = io.buf = 0;
 	io.crc = 0xffffffffUL;
 
+	makecrc(); /* initialize the CRC table */
+
 	magic[0] = get_byte();
 	magic[1] = get_byte();
 	method = get_byte();
