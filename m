Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbUKKNPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUKKNPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 08:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbUKKNOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 08:14:52 -0500
Received: from mail.renesas.com ([202.234.163.13]:20401 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262233AbUKKNMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 08:12:34 -0500
Date: Thu, 11 Nov 2004 22:12:23 +0900 (JST)
Message-Id: <20041111.221223.596521517.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org, gniibe@fsij.org
Subject: [PATCH 2.6.10-rc1 1/2] [m32r] Update for m32r-g00ff
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041111.221136.576022723.takata.hirokazu@renesas.com>
References: <20041111.221136.576022723.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc1 1/2] [m32r] Update for m32r-g00ff
- Position-independent zImage support;
  this aims at removing constraints of zImage(vmlinuz)'s location.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/boot/compressed/Makefile      |    9 +--
 arch/m32r/boot/compressed/head.S        |   96 ++++++++++++++++++++++++--------
 arch/m32r/boot/compressed/m32r_sio.c    |   24 +++++---
 arch/m32r/boot/compressed/misc.c        |   63 ++++++++-------------
 arch/m32r/boot/compressed/vmlinux.lds.S |   16 ++++-
 arch/m32r/boot/compressed/vmlinux.scr   |    6 +-
 arch/m32r/boot/setup.S                  |    2 
 7 files changed, 136 insertions(+), 80 deletions(-)


diff -ruNp a/arch/m32r/boot/compressed/Makefile b/arch/m32r/boot/compressed/Makefile
--- a/arch/m32r/boot/compressed/Makefile	2004-10-19 06:53:06.000000000 +0900
+++ b/arch/m32r/boot/compressed/Makefile	2004-11-11 16:09:39.000000000 +0900
@@ -5,10 +5,10 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o \
-		   m32r-sio.o piggy.o vmlinux.lds
+		   piggy.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 
-OBJECTS = $(obj)/head.o $(obj)/misc.o $(obj)/m32r_sio.o
+OBJECTS = $(obj)/head.o $(obj)/misc.o
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
@@ -28,11 +28,10 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.S FORCE
-	$(CPP) $(EXTRA_AFLAGS) -C -P -I include $< >$@
-
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-m32r-linux -T
 OBJCOPYFLAGS += -R .empty_zero_page
 
+CFLAGS_misc.o += -fpic
+
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
diff -ruNp a/arch/m32r/boot/compressed/head.S b/arch/m32r/boot/compressed/head.S
--- a/arch/m32r/boot/compressed/head.S	2004-10-19 06:53:43.000000000 +0900
+++ b/arch/m32r/boot/compressed/head.S	2004-11-10 21:55:52.000000000 +0900
@@ -13,20 +13,62 @@
 #include <asm/page.h>
 #include <asm/assembler.h>
 
+	/*
+	 * This code can be loaded anywhere, as long as output will not
+	 * overlap it.
+	 *
+	 * NOTE: This head.S should *NOT* be compiled with -fpic.
+	 *
+	 */
+
 	.global	startup
+	.global __bss_start, _ebss, end, zimage_data, zimage_len
 	__ALIGN
 startup:
 	ldi	r0, #0x0000			/* SPI, disable EI */
 	mvtc	r0, psw
 
+	ldi	r12, #-8
+	bl	1f
+	.fillinsn
+1:
+	seth	r1, #high(CONFIG_MEMORY_START + 0x00400000) /* Start address */
+	add	r12, r14				/* Real address */
+	sub	r12, r1					/* difference */
+
+	.global got_len
+	seth	r3, #high(_GLOBAL_OFFSET_TABLE_+8)
+	or3	r3, r3, #low(_GLOBAL_OFFSET_TABLE_+12)
+	add	r3, r14
+
+	/* Update the contents of global offset table */
+	ldi	r1, #low(got_len)
+	srli	r1, #2
+	beqz	r1, 2f
+	.fillinsn
+1:
+	ld	r2, @r3
+	add	r2, r12
+	st	r2, @r3
+	addi	r3, #4
+	addi	r1, #-1
+	bnez	r1, 1b
+	.fillinsn
+2:
+	/* XXX: resolve plt */
+
 /*
  * Clear BSS first so that there are no surprises...
  */
 #ifdef CONFIG_ISA_DUAL_ISSUE
+	seth	r2, #high(__bss_start)
+	or3	r2, r2, #low(__bss_start)
+	add	r2, r12
+	seth	r3, #high(_ebss)
+	or3	r3, r3, #low(_ebss)
+	add	r3, r12
+	sub	r3, r2
 
-	LDIMM	(r2, __bss_start)
-	LDIMM	(r3, _end)
-	sub	r3, r2		; BSS size in bytes
 	; R4 = BSS size in longwords (rounded down)
 	mv	r4, r3		    ||	ldi	r1, #0
 	srli	r4, #4		    ||	addi	r2, #-4
@@ -52,10 +94,13 @@ startup:
 .Lendloop2:
 
 #else /* not CONFIG_ISA_DUAL_ISSUE */
-
-	LDIMM	(r2, __bss_start)
-	LDIMM	(r3, _end)
-	sub	r3, r2		; BSS size in bytes
+	seth	r2, #high(__bss_start)
+	or3	r2, r2, #low(__bss_start)
+	add	r2, r12
+	seth	r3, #high(_ebss)
+	or3	r3, r3, #low(_ebss)
+	add	r3, r12
+	sub	r3, r2
 	mv	r4, r3
 	srli	r4, #2		; R4 = BSS size in longwords (rounded down)
 	ldi	r1, #0		; clear R1 for longwords store
@@ -66,27 +111,29 @@ startup:
 	addi	r4, #-1		; decrement count
 	bnez	r4, .Lloop1	; go do some more
 .Lendloop1:
-	and3	r4, r3, #3	; get no. of remaining BSS bytes to clear
-	addi	r2, #4		; account for pre-inc store
-	beqz	r4, .Lendloop2	; any more to go?
-.Lloop2:
-	stb	r1, @r2		; yep, zero out another byte
-	addi	r2, #1		; bump address
-	addi	r4, #-1		; decrement count
-	bnez	r4, .Lloop2	; go do some more
-.Lendloop2:
 
 #endif /* not CONFIG_ISA_DUAL_ISSUE */
 
-	seth	r0, #shigh(stack_start)
-	ld	sp, @(r0, low(stack_start))	/* set stack point */
+	seth	r1, #high(end)
+	or3	r1, r1, #low(end)
+	add	r1, r12
+	mv	sp, r1
 
 /*
  * decompress the kernel
  */
+	mv	r0, sp
+	srli	r0, 31				/* MMU is ON or OFF */
+        seth	r1, #high(zimage_data)
+        or3	r1, r1, #low(zimage_data)
+	add	r1, r12
+        seth	r2, #high(zimage_len)
+        or3	r2, r2, #low(zimage_len)
+	mv	r3, sp
+
 	bl	decompress_kernel
 
-#if defined(CONFIG_CHIP_M32700)
+#if defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_VDEC2)
 	/* Cache flush */
 	ldi	r0, -1
 	ldi	r1, 0xd0	; invalidate i-cache, copy back d-cache
@@ -94,9 +141,14 @@ startup:
 #else
 #error "put your cache flush function, please"
 #endif
-        seth	r0, #high(CONFIG_MEMORY_START)
-        or3	r0, r0, #0x2000
-        jmp	r0
+
+	mv	r0, sp
+	srli	r0, 31				/* MMU is ON or OFF */
+	slli	r0, 31
+	or3	r0, r0, #0x2000
+	seth	r1, #high(CONFIG_MEMORY_START)
+	or	r0, r1
+	jmp	r0
 
 	.balign 512
 fake_headers_as_bzImage:
diff -ruNp a/arch/m32r/boot/compressed/m32r_sio.c b/arch/m32r/boot/compressed/m32r_sio.c
--- a/arch/m32r/boot/compressed/m32r_sio.c	2004-10-19 06:54:31.000000000 +0900
+++ b/arch/m32r/boot/compressed/m32r_sio.c	2004-11-10 21:55:52.000000000 +0900
@@ -6,12 +6,10 @@
  */
 
 #include <linux/config.h>
-#include <asm/m32r.h>
-#include <asm/io.h>
 
-void putc(char c);
+static void putc(char c);
 
-int puts(const char *s)
+static int puts(const char *s)
 {
 	char c;
 	while ((c = *s++)) putc(c);
@@ -19,6 +17,9 @@ int puts(const char *s)
 }
 
 #if defined(CONFIG_PLAT_M32700UT_Alpha) || defined(CONFIG_PLAT_M32700UT)
+#include <asm/m32r.h>
+#include <asm/io.h>
+
 #define USE_FPGA_MAP	0
 
 #if USE_FPGA_MAP
@@ -35,7 +36,7 @@ int puts(const char *s)
 #define BOOT_SIO0TXB	PLD_ESIO0TXB
 #endif
 
-void putc(char c)
+static void putc(char c)
 {
 
 	while ((*BOOT_SIO0STS & 0x3) != 0x3) ;
@@ -46,8 +47,17 @@ void putc(char c)
 	*BOOT_SIO0TXB = c;
 }
 #else
-void putc(char c)
+#define SIO0STS	(volatile unsigned short *)(0xa0efd000 + 14)
+#define SIO0TXB	(volatile unsigned short *)(0xa0efd000 + 30)
+
+static void putc(char c)
 {
-	/* do nothing */
+
+	while ((*SIO0STS & 0x1) == 0) ;
+	if (c == '\n') {
+		*SIO0TXB = '\r';
+		while ((*SIO0STS & 0x1) == 0) ;
+	}
+	*SIO0TXB = c;
 }
 #endif
diff -ruNp a/arch/m32r/boot/compressed/misc.c b/arch/m32r/boot/compressed/misc.c
--- a/arch/m32r/boot/compressed/misc.c	2004-10-19 06:53:22.000000000 +0900
+++ b/arch/m32r/boot/compressed/misc.c	2004-11-10 21:55:52.000000000 +0900
@@ -8,8 +8,6 @@
  *
  * Adapted for SH by Stuart Menefy, Aug 1999
  *
- * Modified to use standard LinuxSH BIOS by Greg Banks 7Jul2000
- *
  * 2003-02-12:	Support M32R by Takeo Takahashi
  * 		This is based on arch/sh/boot/compressed/misc.c.
  */
@@ -38,9 +36,9 @@ typedef unsigned long  ulg;
 static uch *inbuf;	     /* input buffer */
 static uch window[WSIZE];    /* Sliding window buffer */
 
-static unsigned insize;  /* valid bytes in inbuf */
-static unsigned inptr;   /* index of next byte to be processed in inbuf */
-static unsigned outcnt;  /* bytes in output buffer */
+static unsigned insize = 0;  /* valid bytes in inbuf */
+static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
+static unsigned outcnt = 0;  /* bytes in output buffer */
 
 /* gzip flag byte */
 #define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
@@ -76,27 +74,21 @@ static void error(char *m);
 static void gzip_mark(void **);
 static void gzip_release(void **);
 
-extern char input_data[];
-extern int input_len;
+static unsigned char *input_data;
+static int input_len;
 
-static long bytes_out;
+static long bytes_out = 0;
 static uch *output_data;
-static unsigned long output_ptr;
+static unsigned long output_ptr = 0;
 
+#include "m32r_sio.c"
 
 static void *malloc(int size);
 static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
-extern int puts(const char *);
-
-extern int _text;		/* Defined in vmlinux.lds.S */
-extern int _end;
+ 
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
-
+ 
 #define HEAP_SIZE             0x10000
 
 #include "../../../../lib/inflate.c"
@@ -105,8 +97,8 @@ static void *malloc(int size)
 {
 	void *p;
 
-	if (size <0) error("Malloc error\n");
-	if (free_mem_ptr == 0) error("Memory error\n");
+	if (size <0) error("Malloc error");
+	if (free_mem_ptr == 0) error("Memory error");
 
 	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
 
@@ -114,7 +106,7 @@ static void *malloc(int size)
 	free_mem_ptr += size;
 
 	if (free_mem_ptr >= free_mem_end_ptr)
-		error("\nOut of memory\n");
+		error("Out of memory");
 
 	return p;
 }
@@ -159,7 +151,7 @@ void* memcpy(void* __dest, __const void*
 static int fill_inbuf(void)
 {
 	if (insize != 0) {
-		error("ran out of input data\n");
+		error("ran out of input data");
 	}
 
 	inbuf = input_data;
@@ -177,9 +169,9 @@ static void flush_window(void)
     ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
-
+    
     in = window;
-    out = &output_data[output_ptr];
+    out = &output_data[output_ptr]; 
     for (n = 0; n < outcnt; n++) {
 	    ch = *out++ = *in++;
 	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
@@ -199,25 +191,20 @@ static void error(char *x)
 	while(1);	/* Halt */
 }
 
-#define STACK_SIZE (4096)
-long user_stack [STACK_SIZE];
-long* stack_start = &user_stack[STACK_SIZE];
-
 /* return decompressed size */
-long decompress_kernel(void)
-{
-	insize = 0;
-	inptr = 0;
-	bytes_out = 0;
-	outcnt = 0;
-	output_data = 0;
-	output_ptr = CONFIG_MEMORY_START + 0x2000;
-	free_mem_ptr = (unsigned long)&_end;
+void
+decompress_kernel(int mmu_on, unsigned char *zimage_data,
+		  unsigned int zimage_len, unsigned long heap)
+{
+	output_data = (unsigned char *)CONFIG_MEMORY_START + 0x2000
+		+ (mmu_on ? 0x80000000 : 0);
+	free_mem_ptr = heap;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
+	input_data = zimage_data;
+	input_len = zimage_len;
 
 	makecrc();
 	puts("Uncompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
-	return bytes_out;
 }
diff -ruNp a/arch/m32r/boot/compressed/vmlinux.lds.S b/arch/m32r/boot/compressed/vmlinux.lds.S
--- a/arch/m32r/boot/compressed/vmlinux.lds.S	2004-10-19 06:54:37.000000000 +0900
+++ b/arch/m32r/boot/compressed/vmlinux.lds.S	2004-11-10 21:55:52.000000000 +0900
@@ -8,16 +8,24 @@ SECTIONS
 
   _text = .;
   .text : { *(.text) } = 0
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   _etext = .;
 
-  . = ALIGN(32) + (. & (32 - 1));
+  . = ALIGN(32 / 8);
   .data : { *(.data) }
+  . = ALIGN(32 / 8);
+  _got = .;
+  .got  : { *(.got) _egot = .; *(.got.*) }
   _edata  =  .;
 
   . = ALIGN(32 / 8);
   __bss_start = .;
-  .bss : { *(.bss) }
+  .bss : { *(.bss) *(.sbss) }
   . = ALIGN(32 / 8);
-  _end = . ;
+  _ebss = .;
+  . = ALIGN(4096);
+  . += 4096;
+  end = . ;
+
+  got_len = (_egot - _got);
 }
diff -ruNp a/arch/m32r/boot/compressed/vmlinux.scr b/arch/m32r/boot/compressed/vmlinux.scr
--- a/arch/m32r/boot/compressed/vmlinux.scr	2004-10-19 06:53:43.000000000 +0900
+++ b/arch/m32r/boot/compressed/vmlinux.scr	2004-11-10 21:55:52.000000000 +0900
@@ -1,9 +1,9 @@
 SECTIONS
 {
   .data : {
-	input_len = .;
-	LONG(input_data_end - input_data) input_data = .;
+	zimage_data = .;
 	*(.data)
-	input_data_end = .;
+	zimage_data_end = .;
 	}
+  zimage_len = zimage_data_end - zimage_data;
 }
diff -ruNp a/arch/m32r/boot/setup.S b/arch/m32r/boot/setup.S
--- a/arch/m32r/boot/setup.S	2004-10-19 06:54:08.000000000 +0900
+++ b/arch/m32r/boot/setup.S	2004-11-11 15:35:22.000000000 +0900
@@ -24,7 +24,7 @@
 #define CPU_PARAMS	boot_cpu_data
 #define M32R_MCICAR	 0xfffffff0
 #define M32R_MCDCAR	 0xfffffff4
-#define	M32R_MCCR 	 0xfffffffc
+#define M32R_MCCR 	 0xfffffffc
 #define M32R_BSCR0	 0xffffffd2
 
 ;BSEL

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

