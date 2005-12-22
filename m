Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVLVS2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVLVS2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVLVS2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:13 -0500
Received: from waste.org ([64.81.244.121]:11984 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030271AbVLVS2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:28:08 -0500
Date: Thu, 22 Dec 2005 12:26:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <14.150843412@selenic.com>
Message-Id: <15.150843412@selenic.com>
Subject: [PATCH 14/20] inflate: (arch) use an error callback rather than a global
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: error handling cleanup

This passes the error function as a callback rather than using a
global symbol.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-inflate/arch/alpha/boot/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/alpha/boot/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/alpha/boot/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -28,8 +28,6 @@ extern long srm_printk(const char *, ...
  * gzip delarations
  */
 
-static void error(char *m);
-
 static char *input_data;
 static int  input_data_size;
 
@@ -49,7 +47,7 @@ static void flush_window(const u8 *buf, 
 		*output_data++ = *buf++;
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	puts("\n\n");
 	puts(x);
@@ -75,7 +73,7 @@ decompress_kernel(void *output_start,
 	/* FIXME FIXME FIXME */
 
 /*	puts("Uncompressing Linux..."); */
-	count = gunzip(input_data, input_data_size, NULL, flush_window);
+	count = gunzip(input_data, input_data_size, NULL, flush_window, error);
 /*	puts(" done, booting the kernel.\n"); */
 	return count;
 }
Index: 2.6.14-inflate/arch/arm/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/arm/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -46,8 +46,6 @@ icedcc_putstr(const char *ptr)
  * gzip declarations
  */
 
-static void error(char *m);
-
 extern char input_data[];
 extern char input_data_end[];
 
@@ -78,7 +76,7 @@ static void flush_window(const u8 *buf, 
 #define arch_error(x)
 #endif
 
-static void error(char *x)
+static void error(const char *x)
 {
 	arch_error(x);
 
@@ -103,7 +101,8 @@ decompress_kernel(u32 output_start, u32 
 	arch_decomp_setup();
 
 	putstr("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window,
+	       error);
 	putstr(" done, booting the kernel.\n");
 	return output_ptr;
 }
@@ -116,7 +115,8 @@ int main()
 	output_data = output_buffer;
 
 	putstr("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window,
+	       error);
 	putstr("done.\n");
 	return 0;
 }
Index: 2.6.14-inflate/arch/arm26/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/arm26/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/arm26/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -31,8 +31,6 @@ unsigned int __machine_arch_type;
  * gzip delarations
  */
 
-static void error(char *m);
-
 extern char input_data[];
 extern char input_data_end[];
 static u8 *output_data;
@@ -58,7 +56,7 @@ static void flush_window(const u8 *buf, 
 	puts(".");
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	int ptr;
 
@@ -83,7 +81,8 @@ decompress_kernel(u32 output_start, u32 
 	arch_decomp_setup();
 
 	puts("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window,
+	       error);
 	puts(" done, booting the kernel.\n");
 	return output_ptr;
 }
@@ -96,7 +95,8 @@ int main()
 	output_data = output_buffer;
 
 	puts("Uncompressing Linux...");
-	gunzip(input_data, input_data_end - input_data, NULL, flush_window);
+	gunzip(input_data, input_data_end - input_data, NULL, flush_window,
+	       error);
 	puts("done.\n");
 	return 0;
 }
Index: 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v10/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v10/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -30,8 +30,6 @@
 
 unsigned compsize; /* compressed size, used by head.S */
 
-static void error(char *m);
-
 extern char *input_data;  /* lives in head.S */
 static u8 *output_data;
 
@@ -79,8 +77,7 @@ static void flush_window(const u8 *buf, 
 		*output_data++ = *buf++;
 }
 
-static void
-error(char *x)
+static void error(const char *x)
 {
 	puts("\n\n");
 	puts(x);
@@ -136,6 +133,6 @@ decompress_kernel()
 	}
 
 	puts("Uncompressing Linux...\n");
-	compsize = gunzip(input_data, 0x7fffffff, NULL, flush_window);
+	compsize = gunzip(input_data, 0x7fffffff, NULL, flush_window, error);
 	puts("Done. Now booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/cris/arch-v32/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/cris/arch-v32/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -30,8 +30,6 @@
  * gzip declarations
  */
 
-static void error(char *m);
-
 extern char *input_data;  /* lives in head.S */
 static u8 *output_data;
 
@@ -91,8 +89,7 @@ static void flush_window(const u8 *buf, 
 		*output_data++ = *buf++;
 }
 
-static void
-error(char *x)
+static void error(const char *x)
 {
 	puts("\n\n");
 	puts(x);
@@ -179,6 +176,6 @@ decompress_kernel()
 	}
 
 	puts("Uncompressing Linux...\n");
-	gunzip(input_data, 0x7fffffff, NULL, flush_window);
+	gunzip(input_data, 0x7fffffff, NULL, flush_window, error);
 	puts("Done. Now booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/i386/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/i386/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/i386/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -24,8 +24,6 @@
  * Incomprehensible are the ways of bootloaders.
  */
 
-static void error(char *m);
-
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -124,7 +122,7 @@ static void flush_window(const u8 *buf, 
 	}
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	putstr("\n\n");
 	putstr(x);
@@ -213,7 +211,7 @@ asmlinkage int decompress_kernel(struct 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	putstr("Uncompressing Linux... ");
-	gunzip(input_data, input_len, NULL, flush_window);
+	gunzip(input_data, input_len, NULL, flush_window, error);
 	putstr("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
Index: 2.6.14-inflate/arch/m32r/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/m32r/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/m32r/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -17,8 +17,6 @@
  * gzip declarations
  */
 
-static void error(char *m);
-
 static unsigned char *input_data;
 static int input_len;
 static u8 *output_data;
@@ -39,7 +37,7 @@ static void flush_window(const u8 *buf, 
 		*output_data++ = *buf++;
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	puts("\n\n");
 	puts(x);
@@ -61,6 +59,6 @@ decompress_kernel(int mmu_on, unsigned c
 	input_len = zimage_len;
 
 	puts("Uncompressing Linux... ");
-	gunzip(input_data, input_len, NULL, flush_window);
+	gunzip(input_data, input_len, NULL, flush_window, error);
 	puts("Ok, booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/sh/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/sh/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -19,8 +19,6 @@
  * gzip declarations
  */
 
-static void error(char *m);
-
 extern char input_data[];
 extern int input_len;
 static u8 *output_data;
@@ -66,7 +64,7 @@ static void flush_window(const u8 *buf, 
 		*output_data++ = *buf++;
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	puts("\n\n");
 	puts(x);
@@ -87,6 +85,6 @@ void decompress_kernel(void)
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	puts("Uncompressing Linux... ");
-	gunzip(input_data, input_len, NULL, flush_window);
+	gunzip(input_data, input_len, NULL, flush_window, error);
 	puts("Ok, booting the kernel.\n");
 }
Index: 2.6.14-inflate/arch/sh64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/sh64/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/sh64/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -19,8 +19,6 @@ int cache_control(unsigned int command);
  * gzip declarations
  */
 
-static void error(char *m);
-
 extern char input_data[];
 extern int input_len;
 static u8 *output_data;
@@ -48,7 +46,7 @@ static void flush_window(const u8 *buf, 
 	puts(".");
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	puts("\n\n");
 	puts(x);
@@ -69,7 +67,7 @@ void decompress_kernel(void)
 
 	puts("Uncompressing Linux... ");
 	cache_control(CACHE_ENABLE);
-	gunzip(input_data, input_len, NULL, flush_window);
+	gunzip(input_data, input_len, NULL, flush_window, error);
 	puts("\n");
 
 #if 0
Index: 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c
===================================================================
--- 2.6.14-inflate.orig/arch/x86_64/boot/compressed/misc.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/arch/x86_64/boot/compressed/misc.c	2005-12-21 21:46:15.000000000 -0600
@@ -16,8 +16,6 @@
  * gzip declarations
  */
 
-static void error(char *m);
-
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -113,7 +111,7 @@ static void flush_window(const u8 *buf, 
 	}
 }
 
-static void error(char *x)
+static void error(const char *x)
 {
 	putstr("\n\n");
 	putstr(x);
@@ -191,7 +189,7 @@ int decompress_kernel(struct moveparams 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	putstr(".\nDecompressing Linux...");
-	gunzip(input_data, input_len, NULL, flush_window);
+	gunzip(input_data, input_len, NULL, flush_window, error);
 	putstr("done.\nBooting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
Index: 2.6.14-inflate/init/do_mounts_rd.c
===================================================================
--- 2.6.14-inflate.orig/init/do_mounts_rd.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/init/do_mounts_rd.c	2005-12-21 21:46:15.000000000 -0600
@@ -281,12 +281,17 @@ static int crd_infd, crd_outfd;
 
 #define INIT __init
 
-static void __init error(char *m);
-
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
 
+static void __init error(const char *x)
+{
+	printk(KERN_ERR "%s\n", x);
+	exit_code = 1;
+	unzip_error = 1;
+}
+
 /*
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
@@ -310,13 +315,6 @@ static void __init flush_buffer(const u8
 	}
 }
 
-static void __init error(char *x)
-{
-	printk(KERN_ERR "%s\n", x);
-	exit_code = 1;
-	unzip_error = 1;
-}
-
 static int __init crd_load(int in_fd, int out_fd)
 {
 	int result;
@@ -330,7 +328,7 @@ static int __init crd_load(int in_fd, in
 		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip buffer\n");
 		return -1;
 	}
-	result = gunzip(inbuf, INBUFSIZ, fill_inbuf, flush_buffer);
+	result = gunzip(inbuf, INBUFSIZ, fill_inbuf, flush_buffer, error);
 	if (unzip_error)
 		result = 1;
 	kfree(inbuf);
Index: 2.6.14-inflate/init/initramfs.c
===================================================================
--- 2.6.14-inflate.orig/init/initramfs.c	2005-12-21 21:46:14.000000000 -0600
+++ 2.6.14-inflate/init/initramfs.c	2005-12-21 21:46:15.000000000 -0600
@@ -7,8 +7,8 @@
 #include <linux/string.h>
 #include <linux/syscalls.h>
 
-static __initdata char *message;
-static void __init error(char *x)
+static __initdata const char *message;
+static void __init error(const char *x)
 {
 	if (!message)
 		message = x;
@@ -335,13 +335,12 @@ static void __init flush_buffer(const u8
 
 #define INIT __init
 
-static void __init error(char *m);
-
 #define NO_INFLATE_MALLOC
 
 #include "../lib/inflate.c"
 
-static char * __init unpack_to_rootfs(char *buf, unsigned len, int check_only)
+static const char * __init unpack_to_rootfs(char *buf, unsigned len,
+					    int check_only)
 {
 	int written, cnt;
 	dry_run = check_only;
@@ -369,7 +368,7 @@ static char * __init unpack_to_rootfs(ch
 			continue;
 		}
 		this_header = 0;
-		cnt = gunzip(buf, len, NULL, flush_buffer);
+		cnt = gunzip(buf, len, NULL, flush_buffer, error);
 		if (state != Reset)
 			error("junk in gzipped archive");
 		this_header = saved_offset + cnt;
@@ -397,8 +396,9 @@ static void __init free_initrd(void)
 
 void __init populate_rootfs(void)
 {
-	char *err = unpack_to_rootfs(__initramfs_start,
-			 __initramfs_end - __initramfs_start, 0);
+	const char *err =
+		unpack_to_rootfs(__initramfs_start,
+				 __initramfs_end - __initramfs_start, 0);
 	if (err)
 		panic(err);
 #ifdef CONFIG_BLK_DEV_INITRD
Index: 2.6.14-inflate/lib/inflate.c
===================================================================
--- 2.6.14-inflate.orig/lib/inflate.c	2005-12-21 21:46:13.000000000 -0600
+++ 2.6.14-inflate/lib/inflate.c	2005-12-21 21:46:15.000000000 -0600
@@ -121,8 +121,9 @@ static void *malloc(int size)
 {
 	char *p;
 
-	if (size <0)
-		error("Malloc error");
+	if (size < 0)
+		return NULL;
+
 	if (!malloc_ptr)
 		malloc_ptr = free_mem_ptr;
 
@@ -131,7 +132,7 @@ static void *malloc(int size)
 	malloc_ptr += size;
 
 	if (malloc_ptr >= free_mem_end_ptr)
-		error("Out of memory");
+		return NULL;
 
 	malloc_count++;
 	return p;
@@ -175,6 +176,7 @@ struct iostate {
 	int ipos, isize, itotal, opos, osize, ototal, bits;
 	void (*fill)(u8 *ibuf, int len);
 	void (*flush)(const u8 *obuf, int len);
+	void (*error)(const char *msg);
 	u32 buf, crc;
 };
 
@@ -878,7 +880,7 @@ static int noinline INIT inflate_dynamic
 	if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl))) {
 		DEBG("dyn5b ");
 		if (i == 1) {
-			error("incomplete literal tree");
+			io->error("incomplete literal tree");
 			huft_free(tl);
 		}
 		return i;	/* incomplete code set */
@@ -888,7 +890,7 @@ static int noinline INIT inflate_dynamic
 	if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd))) {
 		DEBG("dyn5d ");
 		if (i == 1) {
-			error("incomplete distance tree");
+			io->error("incomplete distance tree");
 			huft_free(td);
 		}
 		huft_free(tl);
@@ -991,9 +993,11 @@ static void INIT makecrc(void)
  * @isize: size of pool
  * @fill: function to fill the input pool
  * @flush: function to flush the output pool
+ * @error: function to report an error
  */
 static int INIT gunzip(u8 *ibuf, int isize, void (*fill)(u8 *buf, int size),
-		       void (*flush)(const u8 *buf, int size))
+		       void (*flush)(const u8 *buf, int size),
+		       void (*error)(const char *msg))
 {
 	u8 flags;
 	unsigned char magic[2];	/* magic header */
