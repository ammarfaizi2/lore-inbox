Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVFGVnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVFGVnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVFGVnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:43:53 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:42909 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261994AbVFGVl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:41:29 -0400
Date: Tue, 7 Jun 2005 23:41:28 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 2/2] lzma support: lzma compressed kernel image
Message-ID: <20050607214128.GB2645@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.6.12-rc6.

Makes it possible on i386 to select lzma compression instead of gzip
compression, this is especially usefull for embedded systems or when
there are special size restrictions, like a kernel on a floppy image.

Other architectures aren't affected, obviously.

I also want to mention that the misc_lzma.c is much cleaner than the
orginal misc.c  :-)

The memory requirements are only a little big higher than with gzip,
namely low_buffer_size or even lower when !high_loaded.

Size example:
-rw-r--r--  1 ijuz ijuz 1233099 Jun  7 20:12 bzImage.gz
-rw-r--r--  1 ijuz ijuz 1041267 Jun  7 20:12 bzImage.lzma
(download them from here to try them out:
http://debian.christian-leber.de/kernel_lzma/)

To build a kernel with lzma compression you have to go to:
Executable file formats -> Kernel compression format


Building the lzma tool cut and paste style:

mkdir build-lzma
wget http://www.7-zip.org/dl/lzma417.tar.bz2
tar xjf lzma417.tar.bz2
cd SRC/7zip/Compress/LZMA_Alone/
make
cp lzma ../../../../../
cd ../../../../../


Signed-off-by: Christian Leber <christian@leber.de>


--- linux-2.6.12-rc6.orig/arch/i386/Kconfig	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-07 21:33:40.000000000 +0200
@@ -1236,6 +1236,34 @@
 
 source "fs/Kconfig.binfmt"
 
+choice
+       prompt "Kernel compression format"
+       depends on EXPERIMENTAL
+       default KERNEL_GZIP
+
+config KERNEL_GZIP
+       bool "Compress kernel image using gzip"
+       help
+         The linux kernel is a self-extracting executable.
+
+         Choosing Gzip here, makes the kernel image beeing compressed
+         using Gzip.
+
+         Gzip is the standard compression method for the kernel image.
+         If you do not know what to say, take gzip.
+
+
+config KERNEL_LZMA
+       bool "Compress kernel image using lzma (EXPERIMENTAL)"
+       depends on EXPERIMENTAL
+       help
+         The linux kernel is a self-extracting executable.
+
+         Choosing lzma here, makes the kernel beeing compressed using
+         lzma.
+
+endchoice
+
 endmenu
 
 source "drivers/Kconfig"
--- linux-2.6.12-rc6.orig/arch/i386/boot/compressed/misc_lzma.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6/arch/i386/boot/compressed/misc_lzma.c	2005-06-07 21:39:17.000000000 +0200
@@ -0,0 +1,296 @@
+/*
+ * misc.c
+ * 
+ * This code uses LzmaDecode.c and LzmaDecode.h to decompress the lzma
+ * compressed Linux kernel
+ *
+ * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ * puts by Nick Holloway 1993, better puts by Martin Mares 1995
+ * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+ * lzma decompression support by Christian Leber, June 2005
+ */
+
+#include <linux/linkage.h>
+#include <linux/vmalloc.h>
+#include <linux/tty.h>
+#include <video/edid.h>
+#include <asm/io.h>
+
+#undef memcpy
+/*
+ * Why do we do this? Don't ask me..
+ *
+ * Incomprehensible are the ways of bootloaders.
+ */
+
+static void* memcpy(void *, __const void *, size_t);
+static void error(char *m);
+  
+/*
+ * This is set up by the setup-routine at boot-time
+ */
+static unsigned char *real_mode; /* Pointer to real-mode data */
+
+#define RM_EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
+#ifndef STANDARD_MEMORY_BIOS_CALL
+#define RM_ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
+#endif
+#define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+
+extern char input_data[];
+extern int input_len;
+
+static long bytes_out = 0;
+
+/* with high_loaded it points to high_buffer_start otherwise to 1MB */
+static unsigned char *working_area;
+
+static void putstr(const char *);
+
+extern int end;
+static long free_mem_ptr = (long)&end;
+
+#define LOW_BUFFER_START      0x2000
+#define LOW_BUFFER_MAX       0x90000
+#define HEAP_SIZE             0x3000
+static unsigned int low_buffer_end, low_buffer_size;
+static int high_loaded =0;
+static unsigned char *high_buffer_start /* = (unsigned char *)(((unsigned log)&end) + HEAP_SIZE)*/;
+
+static char *vidmem = (char *)0xb8000;
+static int vidport;
+static int lines, cols;
+
+#ifdef CONFIG_X86_NUMAQ
+static void * xquad_portio = NULL;
+#endif
+
+static void scroll(void)
+{
+	int i;
+
+	memcpy ( vidmem, vidmem + cols * 2, ( lines - 1 ) * cols * 2 );
+	for ( i = ( lines - 1 ) * cols * 2; i < lines * cols * 2; i += 2 )
+		vidmem[i] = ' ';
+}
+
+static void putstr(const char *s)
+{
+	int x,y,pos;
+	char c;
+
+	x = RM_SCREEN_INFO.orig_x;
+	y = RM_SCREEN_INFO.orig_y;
+
+	while ( ( c = *s++ ) != '\0' ) {
+		if ( c == '\n' ) {
+			x = 0;
+			if ( ++y >= lines ) {
+				scroll();
+				y--;
+			}
+		} else {
+			vidmem [ ( x + cols * y ) * 2 ] = c; 
+			if ( ++x >= cols ) {
+				x = 0;
+				if ( ++y >= lines ) {
+					scroll();
+					y--;
+				}
+			}
+		}
+	}
+
+	RM_SCREEN_INFO.orig_x = x;
+	RM_SCREEN_INFO.orig_y = y;
+
+	pos = (x + cols * y) * 2;	/* Update cursor position */
+	outb_p(14, vidport);
+	outb_p(0xff & (pos >> 9), vidport+1);
+	outb_p(15, vidport);
+	outb_p(0xff & (pos >> 1), vidport+1);
+}
+
+static void* memcpy(void* __dest, __const void* __src,
+			    size_t __n)
+{
+	int i;
+	char *d = (char *)__dest, *s = (char *)__src;
+
+	for (i=0;i<__n;i++) d[i] = s[i];
+	return __dest;
+}
+
+static void error(char *x)
+{
+	putstr("\n\n");
+	putstr(x);
+	putstr("\n\n -- System halted");
+
+	while(1);	/* Halt */
+}
+
+#define STACK_SIZE (4096)
+
+long user_stack [STACK_SIZE];
+
+struct {
+	long * a;
+	short b;
+	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
+
+static void setup_normal_output_buffer(void)
+{
+#ifdef STANDARD_MEMORY_BIOS_CALL
+	if (RM_EXT_MEM_K < 1024) error("Less than 2MB of memory");
+#else
+	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
+#endif
+	working_area = (char *)0x100000; /* Points to 1M */
+}
+
+struct moveparams {
+	unsigned char *low_buffer_start;  int lcount;
+	unsigned char *high_buffer_start; int hcount;
+};
+
+static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
+{
+	high_buffer_start = (unsigned char *)(((unsigned long)&end) + HEAP_SIZE);
+#ifdef STANDARD_MEMORY_BIOS_CALL
+	if (RM_EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
+#else
+	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) <
+			(3*1024))
+		error("Less than 4MB of memory");
+#endif	
+	mv->low_buffer_start = (char *)LOW_BUFFER_START;
+	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
+	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
+	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
+	high_loaded = 1;
+	if ( (0x100000 + low_buffer_size) > ((unsigned long)high_buffer_start)) {
+		high_buffer_start = (unsigned char *)(0x100000 + low_buffer_size);
+		mv->hcount = 0; /* say: we need not to move high_buffer */
+	} else {
+		mv->hcount = -1;
+	}
+	mv->high_buffer_start = high_buffer_start;
+	working_area = high_buffer_start;
+}
+
+static void close_output_buffer_if_we_run_high(struct moveparams *mv)
+{
+	if (bytes_out > low_buffer_size) {
+		mv->lcount = low_buffer_size;
+		if (mv->hcount)
+			mv->hcount = bytes_out - low_buffer_size;
+	} else {
+		mv->lcount = bytes_out;
+		mv->hcount = 0;
+	}
+}
+
+/* this defines increase the speed significantly */
+#define _LZMA_PROB32
+#define _LZMA_LOC_OPT
+#include "../../../../lib/LzmaDecode.h"
+#include "../../../../lib/LzmaDecode.c"
+
+/*
+ * Do the lzma decompression
+ */
+static int lzma_unzip(void)
+{
+	unsigned int i;
+	unsigned char prop0, properties[5];
+	unsigned int lc, lp, pb; /* lzma properties */
+	unsigned char* workspace;
+	unsigned int uncompressed_size, workspace_size;
+	unsigned int memsize;
+	
+	for (i=0;i<=5;i++) {
+		properties[i] = (unsigned char)input_data[i];
+	}
+	
+	uncompressed_size = 0;
+	for (i = 0; i < 4; i++) {
+		uncompressed_size += (unsigned char)input_data[5+i] << (i * 8);
+	}
+	
+	prop0 = properties[0];
+	if (prop0 >= (9*5*5)) {
+		error("Properties error");
+	}
+	for (pb = 0; prop0 >= (9 * 5); pb++, prop0 -= (9 * 5));
+	for (lp = 0; prop0 >= 9; lp++, prop0 -= 9);
+	lc = prop0;
+
+	workspace_size = (LZMA_BASE_SIZE + (LZMA_LIT_SIZE << (lc + lp)))* sizeof(CProb);
+	workspace = working_area + uncompressed_size;
+
+
+	/* now we have to check if there is enough memory at all */
+#ifdef STANDARD_MEMORY_BIOS_CALL
+	memsize = RM_EXT_MEM_K * 1024;
+#else
+	if(RM_ALT_MEM_K > RM_EXT_MEM_K)
+		memsize=RM_ALT_MEM_K * 1024;
+	else
+		memsize=RM_EXT_MEM_K * 1024;
+#endif
+	if( (unsigned int)(workspace + workspace_size) > memsize)
+		error("you don't have enough memory to boot this kernel\n");
+	
+	if (LzmaDecode(workspace, workspace_size, lc, lp, pb, 
+	   (unsigned char *)input_data + 13, input_len - 13,
+	   (unsigned char *)working_area, uncompressed_size,
+	   &i) == LZMA_RESULT_OK)
+	{
+		if ( i != uncompressed_size )
+			error( "kernel corrupted!\n");
+		if(high_loaded) {
+			/* when we are high_loaded we have to copy the kernel around
+			 * before we can boot */
+			if ( uncompressed_size > low_buffer_size ) {
+				memcpy((char*)LOW_BUFFER_START, high_buffer_start,
+					low_buffer_size);
+				memcpy(high_buffer_start, high_buffer_start+low_buffer_size,
+					uncompressed_size-low_buffer_size);
+			} else {
+				memcpy((char*)LOW_BUFFER_START, high_buffer_start, uncompressed_size );
+			}
+		}
+		bytes_out = i;
+		return 0;
+	}
+	return 1;
+}
+
+
+asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+{
+	real_mode = rmode;
+
+	if (RM_SCREEN_INFO.orig_video_mode == 7) {
+		vidmem = (char *) 0xb0000;
+		vidport = 0x3b4;
+	} else {
+		vidmem = (char *) 0xb8000;
+		vidport = 0x3d4;
+	}
+
+	lines = RM_SCREEN_INFO.orig_video_lines;
+	cols = RM_SCREEN_INFO.orig_video_cols;
+
+	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
+	else setup_output_buffer_if_we_run_high(mv);
+
+	putstr("Uncompressing (lzma) Linux... ");
+	if( lzma_unzip() != 0 ) {
+		error("inflate error\n");
+	}
+	putstr("Ok, booting the kernel.\n");
+	if (high_loaded) close_output_buffer_if_we_run_high(mv);
+	return high_loaded;
+}



--- linux-2.6.12-rc6.orig/arch/i386/boot/compressed/Makefile	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6/arch/i386/boot/compressed/Makefile	2005-06-07 22:49:31.000000000 +0200
@@ -4,22 +4,41 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+targets		:= vmlinux vmlinux.bin head.o piggy.o
 EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
-	$(call if_changed,ld)
-	@:
+LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
+ifeq ($(CONFIG_KERNEL_GZIP),y)
+targets                += vmlinux.bin.gz misc.o
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+	$(call if_changed,ld)
+	@:
+
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
-
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
+endif
+
+ifeq ($(CONFIG_KERNEL_LZMA),y)
+targets                += vmlinux.bin.lzma misc_lzma.o
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc_lzma.o $(obj)/piggy.o FORCE
+	$(call if_changed,ld)
+	@:
+
+$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
+	lzma e $(obj)/vmlinux.bin $(obj)/vmlinux.bin.lzma
+
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.lzma FORCE
+	$(call if_changed,ld)
+endif
+
