Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWJWTsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWJWTsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWJWTsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7125 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965023AbWJWTsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:48:05 -0400
Date: Mon, 23 Oct 2006 15:39:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 8/11] i386: Relocatable kernel support
Message-ID: <20061023193921.GI13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch modifies the x86 kernel so that if CONFIG_RELOCATABLE is
selected it will be able to be loaded at any 4K aligned address below
1G.  The technique used is to compile the decompressor with -fPIC and
modify it so the decompressor is fully relocatable.  For the main
kernel relocations are generated.  Resulting in a kernel that is relocatable
with no runtime overhead and no need to modify the source code.

A reserved 32bit word in the parameters has been assigned
to serve as a stack so we figure out where are running.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/Kconfig                     |   12 
 arch/i386/Makefile                    |    4 
 arch/i386/boot/compressed/Makefile    |   28 +
 arch/i386/boot/compressed/head.S      |  190 +++++++----
 arch/i386/boot/compressed/misc.c      |  267 ++++++++--------
 arch/i386/boot/compressed/relocs.c    |  563 ++++++++++++++++++++++++++++++++++
 arch/i386/boot/compressed/vmlinux.lds |   43 ++
 arch/i386/boot/compressed/vmlinux.scr |    3 
 arch/i386/boot/setup.S                |   29 +
 include/linux/screen_info.h           |    3 
 10 files changed, 926 insertions(+), 216 deletions(-)

diff -puN arch/i386/boot/compressed/head.S~i386-Relocatable-kernel-support arch/i386/boot/compressed/head.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/head.S~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/head.S	2006-10-23 15:08:45.000000000 -0400
@@ -25,9 +25,11 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/page.h>
 
+.section ".text.head"
 	.globl startup_32
-	
+
 startup_32:
 	cld
 	cli
@@ -36,93 +38,141 @@ startup_32:
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
+	movl %eax,%ss
 
-	lss stack_start,%esp
-	xorl %eax,%eax
-1:	incl %eax		# check that A20 really IS enabled
-	movl %eax,0x000000	# loop forever if it isn't
-	cmpl %eax,0x100000
-	je 1b
+/* Calculate the delta between where we were compiled to run
+ * at and where we were actually loaded at.  This can only be done
+ * with a short local call on x86.  Nothing  else will tell us what
+ * address we are running at.  The reserved chunk of the real-mode
+ * data at 0x34-0x3f are used as the stack for this calculation.
+ * Only 4 bytes are needed.
+ */
+	leal 0x40(%esi), %esp
+	call 1f
+1:	popl %ebp
+	subl $1b, %ebp
+
+/* Compute the delta between where we were compiled to run at
+ * and where the code will actually run at.
+ */
+	/* Start with the delta to where the kernel will run at.  If we are
+	 * a relocatable kernel this is the delta to our load address otherwise
+	 * this is the delta to CONFIG_PHYSICAL start.
+	 */
+#ifdef CONFIG_RELOCATABLE
+	movl %ebp, %ebx
+#else
+	movl $(CONFIG_PHYSICAL_START - startup_32), %ebx
+#endif
+
+	/* Replace the compressed data size with the uncompressed size */
+	subl input_len(%ebp), %ebx
+	movl output_len(%ebp), %eax
+	addl %eax, %ebx
+	/* Add 8 bytes for every 32K input block */
+	shrl $12, %eax
+	addl %eax, %ebx
+	/* Add 32K + 18 bytes of extra slack */
+	addl $(32768 + 18), %ebx
+	/* Align on a 4K boundary */
+	addl $4095, %ebx
+	andl $~4095, %ebx
+
+/* Copy the compressed kernel to the end of our buffer
+ * where decompression in place becomes safe.
+ */
+	pushl %esi
+	leal _end(%ebp), %esi
+	leal _end(%ebx), %edi
+	movl $(_end - startup_32), %ecx
+	std
+	rep
+	movsb
+	cld
+	popl %esi
+
+/* Compute the kernel start address.
+ */
+#ifdef CONFIG_RELOCATABLE
+	leal	startup_32(%ebp), %ebp
+#else
+	movl	$CONFIG_PHYSICAL_START, %ebp
+#endif
 
 /*
- * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
- * confuse the debugger if this code is traced.
- * XXX - best to initialize before switching to protected mode.
+ * Jump to the relocated address.
  */
-	pushl $0
-	popfl
+	leal relocated(%ebx), %eax
+	jmp *%eax
+.section ".text"
+relocated:
+
 /*
  * Clear BSS
  */
 	xorl %eax,%eax
-	movl $_edata,%edi
-	movl $_end,%ecx
+	leal _edata(%ebx),%edi
+	leal _end(%ebx), %ecx
 	subl %edi,%ecx
 	cld
 	rep
 	stosb
+
+/*
+ * Setup the stack for the decompressor
+ */
+	leal stack_end(%ebx), %esp
+
 /*
  * Do the decompression, and jump to the new kernel..
  */
-	subl $16,%esp	# place for structure on the stack
-	movl %esp,%eax
+	movl output_len(%ebx), %eax
+	pushl %eax
+	pushl %ebp	# output address
+	movl input_len(%ebx), %eax
+	pushl %eax	# input_len
+	leal input_data(%ebx), %eax
+	pushl %eax	# input_data
+	leal _end(%ebx), %eax
+	pushl %eax	# end of the image as third argument
 	pushl %esi	# real mode pointer as second arg
-	pushl %eax	# address of structure as first arg
 	call decompress_kernel
-	orl  %eax,%eax 
-	jnz  3f
-	popl %esi	# discard address
-	popl %esi	# real mode pointer
-	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $CONFIG_PHYSICAL_START
+	addl $20, %esp
+	popl %ecx
+
+#if CONFIG_RELOCATABLE
+/* Find the address of the relocations.
+ */
+	movl %ebp, %edi
+	addl %ecx, %edi
+
+/* Calculate the delta between where vmlinux was compiled to run
+ * and where it was actually loaded.
+ */
+	movl %ebp, %ebx
+	subl $CONFIG_PHYSICAL_START, %ebx
 
 /*
- * We come here, if we were loaded high.
- * We need to move the move-in-place routine down to 0x1000
- * and then start it with the buffer addresses in registers,
- * which we got from the stack.
- */
-3:
-	movl $move_routine_start,%esi
-	movl $0x1000,%edi
-	movl $move_routine_end,%ecx
-	subl %esi,%ecx
-	addl $3,%ecx
-	shrl $2,%ecx
-	cld
-	rep
-	movsl
+ * Process relocations.
+ */
 
-	popl %esi	# discard the address
-	popl %ebx	# real mode pointer
-	popl %esi	# low_buffer_start
-	popl %ecx	# lcount
-	popl %edx	# high_buffer_start
-	popl %eax	# hcount
-	movl $CONFIG_PHYSICAL_START,%edi
-	cli		# make sure we don't get interrupted
-	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
-
-/*
- * Routine (template) for moving the decompressed kernel in place,
- * if we were high loaded. This _must_ PIC-code !
- */
-move_routine_start:
-	movl %ecx,%ebp
-	shrl $2,%ecx
-	rep
-	movsl
-	movl %ebp,%ecx
-	andl $3,%ecx
-	rep
-	movsb
-	movl %edx,%esi
-	movl %eax,%ecx	# NOTE: rep movsb won't move if %ecx == 0
-	addl $3,%ecx
-	shrl $2,%ecx
-	rep
-	movsl
-	movl %ebx,%esi	# Restore setup pointer
+1:	subl $4, %edi
+	movl 0(%edi), %ecx
+	testl %ecx, %ecx
+	jz 2f
+	addl %ebx, -__PAGE_OFFSET(%ebx, %ecx)
+	jmp 1b
+2:
+#endif
+
+/*
+ * Jump to the decompressed kernel.
+ */
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $CONFIG_PHYSICAL_START
-move_routine_end:
+	jmp *%ebp
+
+.bss
+.balign 4
+stack:
+	.fill 4096, 1, 0
+stack_end:
diff -puN arch/i386/boot/compressed/Makefile~i386-Relocatable-kernel-support arch/i386/boot/compressed/Makefile
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/Makefile~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/Makefile	2006-10-23 15:08:47.000000000 -0400
@@ -4,22 +4,42 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o \
+			vmlinux.bin.all vmlinux.relocs
 EXTRA_AFLAGS	:= -traditional
 
-LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
+LDFLAGS_vmlinux := -T
+CFLAGS_misc.o += -fPIC
+hostprogs-y	:= relocs
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+$(obj)/vmlinux: $(src)/vmlinux.lds $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
 	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
+quiet_cmd_relocs = RELOCS  $@
+      cmd_relocs = $(obj)/relocs $< > $@
+$(obj)/vmlinux.relocs: vmlinux $(obj)/relocs FORCE
+	$(call if_changed,relocs)
+
+vmlinux.bin.all-y := $(obj)/vmlinux.bin
+vmlinux.bin.all-$(CONFIG_RELOCATABLE) += $(obj)/vmlinux.relocs
+quiet_cmd_relocbin = BUILD   $@
+      cmd_relocbin = cat $(filter-out FORCE,$^) > $@
+$(obj)/vmlinux.bin.all: $(vmlinux.bin.all-y) FORCE
+	$(call if_changed,relocbin)
+
+ifdef CONFIG_RELOCATABLE
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin.all FORCE
+	$(call if_changed,gzip)
+else
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
+endif
 
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
 
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
+$(obj)/piggy.o: $(src)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
diff -puN arch/i386/boot/compressed/misc.c~i386-Relocatable-kernel-support arch/i386/boot/compressed/misc.c
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/misc.c~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/misc.c	2006-10-23 15:08:45.000000000 -0400
@@ -13,6 +13,88 @@
 #include <linux/vmalloc.h>
 #include <linux/screen_info.h>
 #include <asm/io.h>
+#include <asm/page.h>
+
+/* WARNING!!
+ * This code is compiled with -fPIC and it is relocated dynamically
+ * at run time, but no relocation processing is performed.
+ * This means that it is not safe to place pointers in static structures.
+ */
+
+/*
+ * Getting to provable safe in place decompression is hard.
+ * Worst case behaviours need to be analized.
+ * Background information:
+ *
+ * The file layout is:
+ *    magic[2]
+ *    method[1]
+ *    flags[1]
+ *    timestamp[4]
+ *    extraflags[1]
+ *    os[1]
+ *    compressed data blocks[N]
+ *    crc[4] orig_len[4]
+ *
+ * resulting in 18 bytes of non compressed data overhead.
+ *
+ * Files divided into blocks
+ * 1 bit (last block flag)
+ * 2 bits (block type)
+ *
+ * 1 block occurs every 32K -1 bytes or when there 50% compression has been achieved.
+ * The smallest block type encoding is always used.
+ *
+ * stored:
+ *    32 bits length in bytes.
+ *
+ * fixed:
+ *    magic fixed tree.
+ *    symbols.
+ *
+ * dynamic:
+ *    dynamic tree encoding.
+ *    symbols.
+ *
+ *
+ * The buffer for decompression in place is the length of the
+ * uncompressed data, plus a small amount extra to keep the algorithm safe.
+ * The compressed data is placed at the end of the buffer.  The output
+ * pointer is placed at the start of the buffer and the input pointer
+ * is placed where the compressed data starts.  Problems will occur
+ * when the output pointer overruns the input pointer.
+ *
+ * The output pointer can only overrun the input pointer if the input
+ * pointer is moving faster than the output pointer.  A condition only
+ * triggered by data whose compressed form is larger than the uncompressed
+ * form.
+ *
+ * The worst case at the block level is a growth of the compressed data
+ * of 5 bytes per 32767 bytes.
+ *
+ * The worst case internal to a compressed block is very hard to figure.
+ * The worst case can at least be boundined by having one bit that represents
+ * 32764 bytes and then all of the rest of the bytes representing the very
+ * very last byte.
+ *
+ * All of which is enough to compute an amount of extra data that is required
+ * to be safe.  To avoid problems at the block level allocating 5 extra bytes
+ * per 32767 bytes of data is sufficient.  To avoind problems internal to a block
+ * adding an extra 32767 bytes (the worst case uncompressed block size) is
+ * sufficient, to ensure that in the worst case the decompressed data for
+ * block will stop the byte before the compressed data for a block begins.
+ * To avoid problems with the compressed data's meta information an extra 18
+ * bytes are needed.  Leading to the formula:
+ *
+ * extra_bytes = (uncompressed_size >> 12) + 32768 + 18 + decompressor_size.
+ *
+ * Adding 8 bytes per 32K is a bit excessive but much easier to calculate.
+ * Adding 32768 instead of 32767 just makes for round numbers.
+ * Adding the decompressor_size is necessary as it musht live after all
+ * of the data as well.  Last I measured the decompressor is about 14K.
+ * 10K of actuall data and 4K of bss.
+ *
+ */
 
 /*
  * gzip declarations
@@ -29,15 +111,20 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
-
-static uch *inbuf;	     /* input buffer */
-static uch window[WSIZE];    /* Sliding window buffer */
-
-static unsigned insize = 0;  /* valid bytes in inbuf */
-static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
-static unsigned outcnt = 0;  /* bytes in output buffer */
+#define WSIZE 0x80000000	/* Window size must be at least 32k,
+				 * and a power of two
+				 * We don't actually have a window just
+				 * a huge output buffer so I report
+				 * a 2G windows size, as that should
+				 * always be larger than our output buffer.
+				 */
+
+static uch *inbuf;	/* input buffer */
+static uch *window;	/* Sliding window buffer, (and final output buffer) */
+
+static unsigned insize;  /* valid bytes in inbuf */
+static unsigned inptr;   /* index of next byte to be processed in inbuf */
+static unsigned outcnt;  /* bytes in output buffer */
 
 /* gzip flag byte */
 #define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
@@ -88,8 +175,6 @@ extern unsigned char input_data[];
 extern int input_len;
 
 static long bytes_out = 0;
-static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void *malloc(int size);
 static void free(void *where);
@@ -99,17 +184,10 @@ static void *memcpy(void *dest, const vo
 
 static void putstr(const char *);
 
-extern int end;
-static long free_mem_ptr = (long)&end;
-static long free_mem_end_ptr;
-
-#define INPLACE_MOVE_ROUTINE  0x1000
-#define LOW_BUFFER_START      0x2000
-#define LOW_BUFFER_MAX       0x90000
+static unsigned long free_mem_ptr;
+static unsigned long free_mem_end_ptr;
+
 #define HEAP_SIZE             0x3000
-static unsigned int low_buffer_end, low_buffer_size;
-static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
 
 static char *vidmem = (char *)0xb8000;
 static int vidport;
@@ -150,7 +228,7 @@ static void gzip_mark(void **ptr)
 
 static void gzip_release(void **ptr)
 {
-	free_mem_ptr = (long) *ptr;
+	free_mem_ptr = (unsigned long) *ptr;
 }
  
 static void scroll(void)
@@ -178,7 +256,7 @@ static void putstr(const char *s)
 				y--;
 			}
 		} else {
-			vidmem [ ( x + cols * y ) * 2 ] = c; 
+			vidmem [ ( x + cols * y ) * 2 ] = c;
 			if ( ++x >= cols ) {
 				x = 0;
 				if ( ++y >= lines ) {
@@ -223,58 +301,31 @@ static void* memcpy(void* dest, const vo
  */
 static int fill_inbuf(void)
 {
-	if (insize != 0) {
-		error("ran out of input data");
-	}
-
-	inbuf = input_data;
-	insize = input_len;
-	inptr = 1;
-	return inbuf[0];
+	error("ran out of input data");
+	return 0;
 }
 
 /* ===========================================================================
  * Write the output window window[0..outcnt-1] and update crc and bytes_out.
  * (Used for the decompressed data only.)
  */
-static void flush_window_low(void)
-{
-    ulg c = crc;         /* temporary variable */
-    unsigned n;
-    uch *in, *out, ch;
-    
-    in = window;
-    out = &output_data[output_ptr]; 
-    for (n = 0; n < outcnt; n++) {
-	    ch = *out++ = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
-    bytes_out += (ulg)outcnt;
-    output_ptr += (ulg)outcnt;
-    outcnt = 0;
-}
-
-static void flush_window_high(void)
-{
-    ulg c = crc;         /* temporary variable */
-    unsigned n;
-    uch *in,  ch;
-    in = window;
-    for (n = 0; n < outcnt; n++) {
-	ch = *output_data++ = *in++;
-	if ((ulg)output_data == low_buffer_end) output_data=high_buffer_start;
-	c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
-    bytes_out += (ulg)outcnt;
-    outcnt = 0;
-}
-
 static void flush_window(void)
 {
-	if (high_loaded) flush_window_high();
-	else flush_window_low();
+	/* With my window equal to my output buffer
+	 * I only need to compute the crc here.
+	 */
+	ulg c = crc;         /* temporary variable */
+	unsigned n;
+	uch *in, ch;
+
+	in = window;
+	for (n = 0; n < outcnt; n++) {
+		ch = *in++;
+		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
+	}
+	crc = c;
+	bytes_out += (ulg)outcnt;
+	outcnt = 0;
 }
 
 static void error(char *x)
@@ -286,66 +337,8 @@ static void error(char *x)
 	while(1);	/* Halt */
 }
 
-#define STACK_SIZE (4096)
-
-long user_stack [STACK_SIZE];
-
-struct {
-	long * a;
-	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
-
-static void setup_normal_output_buffer(void)
-{
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (RM_EXT_MEM_K < 1024) error("Less than 2MB of memory");
-#else
-	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
-#endif
-	output_data = (unsigned char *)CONFIG_PHYSICAL_START; /* Normally Points to 1M */
-	free_mem_end_ptr = (long)real_mode;
-}
-
-struct moveparams {
-	uch *low_buffer_start;  int lcount;
-	uch *high_buffer_start; int hcount;
-};
-
-static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
-{
-	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (RM_EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
-#else
-	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory");
-#endif	
-	mv->low_buffer_start = output_data = (unsigned char *)LOW_BUFFER_START;
-	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
-	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
-	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
-	high_loaded = 1;
-	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (CONFIG_PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(CONFIG_PHYSICAL_START + low_buffer_size);
-		mv->hcount = 0; /* say: we need not to move high_buffer */
-	}
-	else mv->hcount = -1;
-	mv->high_buffer_start = high_buffer_start;
-}
-
-static void close_output_buffer_if_we_run_high(struct moveparams *mv)
-{
-	if (bytes_out > low_buffer_size) {
-		mv->lcount = low_buffer_size;
-		if (mv->hcount)
-			mv->hcount = bytes_out - low_buffer_size;
-	} else {
-		mv->lcount = bytes_out;
-		mv->hcount = 0;
-	}
-}
-
-asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+asmlinkage void decompress_kernel(void *rmode, unsigned long end,
+			uch *input_data, unsigned long input_len, uch *output)
 {
 	real_mode = rmode;
 
@@ -360,13 +353,25 @@ asmlinkage int decompress_kernel(struct 
 	lines = RM_SCREEN_INFO.orig_video_lines;
 	cols = RM_SCREEN_INFO.orig_video_cols;
 
-	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
-	else setup_output_buffer_if_we_run_high(mv);
+	window = output;  	/* Output buffer (Normally at 1M) */
+	free_mem_ptr     = end;	/* Heap  */
+	free_mem_end_ptr = end + HEAP_SIZE;
+	inbuf  = input_data;	/* Input buffer */
+	insize = input_len;
+	inptr  = 0;
+
+	if (((u32)output - CONFIG_PHYSICAL_START) & 0x3fffff)
+		error("Destination address not 4M aligned");
+	if (end > ((-__PAGE_OFFSET-(512 <<20)-1) & 0x7fffffff))
+		error("Destination address too large");
+#ifndef CONFIG_RELOCATABLE
+	if ((u32)output != CONFIG_PHYSICAL_START)
+		error("Wrong destination address");
+#endif
 
 	makecrc();
 	putstr("Uncompressing Linux... ");
 	gunzip();
 	putstr("Ok, booting the kernel.\n");
-	if (high_loaded) close_output_buffer_if_we_run_high(mv);
-	return high_loaded;
+	return;
 }
diff -puN /dev/null arch/i386/boot/compressed/relocs.c
--- /dev/null	2006-10-23 14:50:11.327499618 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/relocs.c	2006-10-23 15:08:47.000000000 -0400
@@ -0,0 +1,563 @@
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <elf.h>
+#include <byteswap.h>
+#define USE_BSD
+#include <endian.h>
+
+#define MAX_SHDRS 100
+static Elf32_Ehdr ehdr;
+static Elf32_Shdr shdr[MAX_SHDRS];
+static Elf32_Sym  *symtab[MAX_SHDRS];
+static Elf32_Rel  *reltab[MAX_SHDRS];
+static char *strtab[MAX_SHDRS];
+static unsigned long reloc_count, reloc_idx;
+static unsigned long *relocs;
+
+static void die(char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static const char *sym_type(unsigned type)
+{
+	static const char *type_name[] = {
+#define SYM_TYPE(X) [X] = #X
+		SYM_TYPE(STT_NOTYPE),
+		SYM_TYPE(STT_OBJECT),
+		SYM_TYPE(STT_FUNC),
+		SYM_TYPE(STT_SECTION),
+		SYM_TYPE(STT_FILE),
+		SYM_TYPE(STT_COMMON),
+		SYM_TYPE(STT_TLS),
+#undef SYM_TYPE
+	};
+	const char *name = "unknown sym type name";
+	if (type < sizeof(type_name)/sizeof(type_name[0])) {
+		name = type_name[type];
+	}
+	return name;
+}
+
+static const char *sym_bind(unsigned bind)
+{
+	static const char *bind_name[] = {
+#define SYM_BIND(X) [X] = #X
+		SYM_BIND(STB_LOCAL),
+		SYM_BIND(STB_GLOBAL),
+		SYM_BIND(STB_WEAK),
+#undef SYM_BIND
+	};
+	const char *name = "unknown sym bind name";
+	if (bind < sizeof(bind_name)/sizeof(bind_name[0])) {
+		name = bind_name[bind];
+	}
+	return name;
+}
+
+static const char *sym_visibility(unsigned visibility)
+{
+	static const char *visibility_name[] = {
+#define SYM_VISIBILITY(X) [X] = #X
+		SYM_VISIBILITY(STV_DEFAULT),
+		SYM_VISIBILITY(STV_INTERNAL),
+		SYM_VISIBILITY(STV_HIDDEN),
+		SYM_VISIBILITY(STV_PROTECTED),
+#undef SYM_VISIBILITY
+	};
+	const char *name = "unknown sym visibility name";
+	if (visibility < sizeof(visibility_name)/sizeof(visibility_name[0])) {
+		name = visibility_name[visibility];
+	}
+	return name;
+}
+
+static const char *rel_type(unsigned type)
+{
+	static const char *type_name[] = {
+#define REL_TYPE(X) [X] = #X
+		REL_TYPE(R_386_NONE),
+		REL_TYPE(R_386_32),
+		REL_TYPE(R_386_PC32),
+		REL_TYPE(R_386_GOT32),
+		REL_TYPE(R_386_PLT32),
+		REL_TYPE(R_386_COPY),
+		REL_TYPE(R_386_GLOB_DAT),
+		REL_TYPE(R_386_JMP_SLOT),
+		REL_TYPE(R_386_RELATIVE),
+		REL_TYPE(R_386_GOTOFF),
+		REL_TYPE(R_386_GOTPC),
+#undef REL_TYPE
+	};
+	const char *name = "unknown type rel type name";
+	if (type < sizeof(type_name)/sizeof(type_name[0])) {
+		name = type_name[type];
+	}
+	return name;
+}
+
+static const char *sec_name(unsigned shndx)
+{
+	const char *sec_strtab;
+	const char *name;
+	sec_strtab = strtab[ehdr.e_shstrndx];
+	name = "<noname>";
+	if (shndx < ehdr.e_shnum) {
+		name = sec_strtab + shdr[shndx].sh_name;
+	}
+	else if (shndx == SHN_ABS) {
+		name = "ABSOLUTE";
+	}
+	else if (shndx == SHN_COMMON) {
+		name = "COMMON";
+	}
+	return name;
+}
+
+static const char *sym_name(const char *sym_strtab, Elf32_Sym *sym)
+{
+	const char *name;
+	name = "<noname>";
+	if (sym->st_name) {
+		name = sym_strtab + sym->st_name;
+	}
+	else {
+		name = sec_name(shdr[sym->st_shndx].sh_name);
+	}
+	return name;
+}
+
+
+
+#if BYTE_ORDER == LITTLE_ENDIAN
+#define le16_to_cpu(val) (val)
+#define le32_to_cpu(val) (val)
+#endif
+#if BYTE_ORDER == BIG_ENDIAN
+#define le16_to_cpu(val) bswap_16(val)
+#define le32_to_cpu(val) bswap_32(val)
+#endif
+
+static uint16_t elf16_to_cpu(uint16_t val)
+{
+	return le16_to_cpu(val);
+}
+
+static uint32_t elf32_to_cpu(uint32_t val)
+{
+	return le32_to_cpu(val);
+}
+
+static void read_ehdr(FILE *fp)
+{
+	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
+		die("Cannot read ELF header: %s\n",
+			strerror(errno));
+	}
+	if (memcmp(ehdr.e_ident, ELFMAG, 4) != 0) {
+		die("No ELF magic\n");
+	}
+	if (ehdr.e_ident[EI_CLASS] != ELFCLASS32) {
+		die("Not a 32 bit executable\n");
+	}
+	if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB) {
+		die("Not a LSB ELF executable\n");
+	}
+	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	/* Convert the fields to native endian */
+	ehdr.e_type      = elf16_to_cpu(ehdr.e_type);
+	ehdr.e_machine   = elf16_to_cpu(ehdr.e_machine);
+	ehdr.e_version   = elf32_to_cpu(ehdr.e_version);
+	ehdr.e_entry     = elf32_to_cpu(ehdr.e_entry);
+	ehdr.e_phoff     = elf32_to_cpu(ehdr.e_phoff);
+	ehdr.e_shoff     = elf32_to_cpu(ehdr.e_shoff);
+	ehdr.e_flags     = elf32_to_cpu(ehdr.e_flags);
+	ehdr.e_ehsize    = elf16_to_cpu(ehdr.e_ehsize);
+	ehdr.e_phentsize = elf16_to_cpu(ehdr.e_phentsize);
+	ehdr.e_phnum     = elf16_to_cpu(ehdr.e_phnum);
+	ehdr.e_shentsize = elf16_to_cpu(ehdr.e_shentsize);
+	ehdr.e_shnum     = elf16_to_cpu(ehdr.e_shnum);
+	ehdr.e_shstrndx  = elf16_to_cpu(ehdr.e_shstrndx);
+
+	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN)) {
+		die("Unsupported ELF header type\n");
+	}
+	if (ehdr.e_machine != EM_386) {
+		die("Not for x86\n");
+	}
+	if (ehdr.e_version != EV_CURRENT) {
+		die("Unknown ELF version\n");
+	}
+	if (ehdr.e_ehsize != sizeof(Elf32_Ehdr)) {
+		die("Bad Elf header size\n");
+	}
+	if (ehdr.e_phentsize != sizeof(Elf32_Phdr)) {
+		die("Bad program header entry\n");
+	}
+	if (ehdr.e_shentsize != sizeof(Elf32_Shdr)) {
+		die("Bad section header entry\n");
+	}
+	if (ehdr.e_shstrndx >= ehdr.e_shnum) {
+		die("String table index out of bounds\n");
+	}
+}
+
+static void read_shdrs(FILE *fp)
+{
+	int i;
+	if (ehdr.e_shnum > MAX_SHDRS) {
+		die("%d section headers supported: %d\n",
+			ehdr.e_shnum, MAX_SHDRS);
+	}
+	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
+		die("Seek to %d failed: %s\n",
+			ehdr.e_shoff, strerror(errno));
+	}
+	if (fread(&shdr, sizeof(shdr[0]), ehdr.e_shnum, fp) != ehdr.e_shnum) {
+		die("Cannot read ELF section headers: %s\n",
+			strerror(errno));
+	}
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		shdr[i].sh_name      = elf32_to_cpu(shdr[i].sh_name);
+		shdr[i].sh_type      = elf32_to_cpu(shdr[i].sh_type);
+		shdr[i].sh_flags     = elf32_to_cpu(shdr[i].sh_flags);
+		shdr[i].sh_addr      = elf32_to_cpu(shdr[i].sh_addr);
+		shdr[i].sh_offset    = elf32_to_cpu(shdr[i].sh_offset);
+		shdr[i].sh_size      = elf32_to_cpu(shdr[i].sh_size);
+		shdr[i].sh_link      = elf32_to_cpu(shdr[i].sh_link);
+		shdr[i].sh_info      = elf32_to_cpu(shdr[i].sh_info);
+		shdr[i].sh_addralign = elf32_to_cpu(shdr[i].sh_addralign);
+		shdr[i].sh_entsize   = elf32_to_cpu(shdr[i].sh_entsize);
+	}
+
+}
+
+static void read_strtabs(FILE *fp)
+{
+	int i;
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		if (shdr[i].sh_type != SHT_STRTAB) {
+			continue;
+		}
+		strtab[i] = malloc(shdr[i].sh_size);
+		if (!strtab[i]) {
+			die("malloc of %d bytes for strtab failed\n",
+				shdr[i].sh_size);
+		}
+		if (fseek(fp, shdr[i].sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				shdr[i].sh_offset, strerror(errno));
+		}
+		if (fread(strtab[i], 1, shdr[i].sh_size, fp) != shdr[i].sh_size) {
+			die("Cannot read symbol table: %s\n",
+				strerror(errno));
+		}
+	}
+}
+
+static void read_symtabs(FILE *fp)
+{
+	int i,j;
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		if (shdr[i].sh_type != SHT_SYMTAB) {
+			continue;
+		}
+		symtab[i] = malloc(shdr[i].sh_size);
+		if (!symtab[i]) {
+			die("malloc of %d bytes for symtab failed\n",
+				shdr[i].sh_size);
+		}
+		if (fseek(fp, shdr[i].sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				shdr[i].sh_offset, strerror(errno));
+		}
+		if (fread(symtab[i], 1, shdr[i].sh_size, fp) != shdr[i].sh_size) {
+			die("Cannot read symbol table: %s\n",
+				strerror(errno));
+		}
+		for(j = 0; j < shdr[i].sh_size/sizeof(symtab[i][0]); j++) {
+			symtab[i][j].st_name  = elf32_to_cpu(symtab[i][j].st_name);
+			symtab[i][j].st_value = elf32_to_cpu(symtab[i][j].st_value);
+			symtab[i][j].st_size  = elf32_to_cpu(symtab[i][j].st_size);
+			symtab[i][j].st_shndx = elf16_to_cpu(symtab[i][j].st_shndx);
+		}
+	}
+}
+
+
+static void read_relocs(FILE *fp)
+{
+	int i,j;
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		if (shdr[i].sh_type != SHT_REL) {
+			continue;
+		}
+		reltab[i] = malloc(shdr[i].sh_size);
+		if (!reltab[i]) {
+			die("malloc of %d bytes for relocs failed\n",
+				shdr[i].sh_size);
+		}
+		if (fseek(fp, shdr[i].sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				shdr[i].sh_offset, strerror(errno));
+		}
+		if (fread(reltab[i], 1, shdr[i].sh_size, fp) != shdr[i].sh_size) {
+			die("Cannot read symbol table: %s\n",
+				strerror(errno));
+		}
+		for(j = 0; j < shdr[i].sh_size/sizeof(reltab[0][0]); j++) {
+			reltab[i][j].r_offset = elf32_to_cpu(reltab[i][j].r_offset);
+			reltab[i][j].r_info   = elf32_to_cpu(reltab[i][j].r_info);
+		}
+	}
+}
+
+
+static void print_absolute_symbols(void)
+{
+	int i;
+	printf("Absolute symbols\n");
+	printf(" Num:    Value Size  Type       Bind        Visibility  Name\n");
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf32_Sym *sh_symtab;
+		int j;
+		if (shdr[i].sh_type != SHT_SYMTAB) {
+			continue;
+		}
+		sh_symtab = symtab[i];
+		sym_strtab = strtab[shdr[i].sh_link];
+		for(j = 0; j < shdr[i].sh_size/sizeof(symtab[0][0]); j++) {
+			Elf32_Sym *sym;
+			const char *name;
+			sym = &symtab[i][j];
+			name = sym_name(sym_strtab, sym);
+			if (sym->st_shndx != SHN_ABS) {
+				continue;
+			}
+			printf("%5d %08x %5d %10s %10s %12s %s\n",
+				j, sym->st_value, sym->st_size,
+				sym_type(ELF32_ST_TYPE(sym->st_info)),
+				sym_bind(ELF32_ST_BIND(sym->st_info)),
+				sym_visibility(ELF32_ST_VISIBILITY(sym->st_other)),
+				name);
+		}
+	}
+	printf("\n");
+}
+
+static void print_absolute_relocs(void)
+{
+	int i;
+	printf("Absolute relocations\n");
+	printf("Offset     Info     Type     Sym.Value Sym.Name\n");
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf32_Sym *sh_symtab;
+		unsigned sec_applies, sec_symtab;
+		int j;
+		if (shdr[i].sh_type != SHT_REL) {
+			continue;
+		}
+		sec_symtab  = shdr[i].sh_link;
+		sec_applies = shdr[i].sh_info;
+		if (!(shdr[sec_applies].sh_flags & SHF_ALLOC)) {
+			continue;
+		}
+		sh_symtab = symtab[sec_symtab];
+		sym_strtab = strtab[shdr[sec_symtab].sh_link];
+		for(j = 0; j < shdr[i].sh_size/sizeof(reltab[0][0]); j++) {
+			Elf32_Rel *rel;
+			Elf32_Sym *sym;
+			const char *name;
+			rel = &reltab[i][j];
+			sym = &sh_symtab[ELF32_R_SYM(rel->r_info)];
+			name = sym_name(sym_strtab, sym);
+			if (sym->st_shndx != SHN_ABS) {
+				continue;
+			}
+			printf("%08x %08x %10s %08x  %s\n",
+				rel->r_offset,
+				rel->r_info,
+				rel_type(ELF32_R_TYPE(rel->r_info)),
+				sym->st_value,
+				name);
+		}
+	}
+	printf("\n");
+}
+
+static void walk_relocs(void (*visit)(Elf32_Rel *rel, Elf32_Sym *sym))
+{
+	int i;
+	/* Walk through the relocations */
+	for(i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf32_Sym *sh_symtab;
+		unsigned sec_applies, sec_symtab;
+		int j;
+		if (shdr[i].sh_type != SHT_REL) {
+			continue;
+		}
+		sec_symtab  = shdr[i].sh_link;
+		sec_applies = shdr[i].sh_info;
+		if (!(shdr[sec_applies].sh_flags & SHF_ALLOC)) {
+			continue;
+		}
+		sh_symtab = symtab[sec_symtab];
+		sym_strtab = strtab[shdr[sec_symtab].sh_link];
+		for(j = 0; j < shdr[i].sh_size/sizeof(reltab[0][0]); j++) {
+			Elf32_Rel *rel;
+			Elf32_Sym *sym;
+			unsigned r_type;
+			rel = &reltab[i][j];
+			sym = &sh_symtab[ELF32_R_SYM(rel->r_info)];
+			r_type = ELF32_R_TYPE(rel->r_info);
+			/* Don't visit relocations to absolute symbols */
+			if (sym->st_shndx == SHN_ABS) {
+				continue;
+			}
+			if (r_type == R_386_PC32) {
+				/* PC relative relocations don't need to be adjusted */
+			}
+			else if (r_type == R_386_32) {
+				/* Visit relocations that need to be adjusted */
+				visit(rel, sym);
+			}
+			else {
+				die("Unsupported relocation type: %d\n", r_type);
+			}
+		}
+	}
+}
+
+static void count_reloc(Elf32_Rel *rel, Elf32_Sym *sym)
+{
+	reloc_count += 1;
+}
+
+static void collect_reloc(Elf32_Rel *rel, Elf32_Sym *sym)
+{
+	/* Remember the address that needs to be adjusted. */
+	relocs[reloc_idx++] = rel->r_offset;
+}
+
+static int cmp_relocs(const void *va, const void *vb)
+{
+	const unsigned long *a, *b;
+	a = va; b = vb;
+	return (*a == *b)? 0 : (*a > *b)? 1 : -1;
+}
+
+static void emit_relocs(int as_text)
+{
+	int i;
+	/* Count how many relocations I have and allocate space for them. */
+	reloc_count = 0;
+	walk_relocs(count_reloc);
+	relocs = malloc(reloc_count * sizeof(relocs[0]));
+	if (!relocs) {
+		die("malloc of %d entries for relocs failed\n",
+			reloc_count);
+	}
+	/* Collect up the relocations */
+	reloc_idx = 0;
+	walk_relocs(collect_reloc);
+
+	/* Order the relocations for more efficient processing */
+	qsort(relocs, reloc_count, sizeof(relocs[0]), cmp_relocs);
+
+	/* Print the relocations */
+	if (as_text) {
+		/* Print the relocations in a form suitable that
+		 * gas will like.
+		 */
+		printf(".section \".data.reloc\",\"a\"\n");
+		printf(".balign 4\n");
+		for(i = 0; i < reloc_count; i++) {
+			printf("\t .long 0x%08lx\n", relocs[i]);
+		}
+		printf("\n");
+	}
+	else {
+		unsigned char buf[4];
+		buf[0] = buf[1] = buf[2] = buf[3] = 0;
+		/* Print a stop */
+		printf("%c%c%c%c", buf[0], buf[1], buf[2], buf[3]);
+		/* Now print each relocation */
+		for(i = 0; i < reloc_count; i++) {
+			buf[0] = (relocs[i] >>  0) & 0xff;
+			buf[1] = (relocs[i] >>  8) & 0xff;
+			buf[2] = (relocs[i] >> 16) & 0xff;
+			buf[3] = (relocs[i] >> 24) & 0xff;
+			printf("%c%c%c%c", buf[0], buf[1], buf[2], buf[3]);
+		}
+	}
+}
+
+static void usage(void)
+{
+	die("i386_reloc [--abs | --text] vmlinux\n");
+}
+
+int main(int argc, char **argv)
+{
+	int show_absolute;
+	int as_text;
+	const char *fname;
+	FILE *fp;
+	int i;
+
+	show_absolute = 0;
+	as_text = 0;
+	fname = NULL;
+	for(i = 1; i < argc; i++) {
+		char *arg = argv[i];
+		if (*arg == '-') {
+			if (strcmp(argv[1], "--abs") == 0) {
+				show_absolute = 1;
+				continue;
+			}
+			else if (strcmp(argv[1], "--text") == 0) {
+				as_text = 1;
+				continue;
+			}
+		}
+		else if (!fname) {
+			fname = arg;
+			continue;
+		}
+		usage();
+	}
+	if (!fname) {
+		usage();
+	}
+	fp = fopen(fname, "r");
+	if (!fp) {
+		die("Cannot open %s: %s\n",
+			fname, strerror(errno));
+	}
+	read_ehdr(fp);
+	read_shdrs(fp);
+	read_strtabs(fp);
+	read_symtabs(fp);
+	read_relocs(fp);
+	if (show_absolute) {
+		print_absolute_symbols();
+		print_absolute_relocs();
+		return 0;
+	}
+	emit_relocs(as_text);
+	return 0;
+}
diff -puN /dev/null arch/i386/boot/compressed/vmlinux.lds
--- /dev/null	2006-10-23 14:50:11.327499618 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/vmlinux.lds	2006-10-23 13:15:21.000000000 -0400
@@ -0,0 +1,43 @@
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(startup_32)
+SECTIONS
+{
+        /* Be careful parts of head.S assume startup_32 is at
+         * address 0.
+	 */
+	. =  0 	;
+	.text.head : {
+		_head = . ;
+		*(.text.head)
+		_ehead = . ;
+	}
+	.data.compressed : {
+		*(.data.compressed)
+	}
+	.text :	{
+		_text = .; 	/* Text */
+		*(.text)
+		*(.text.*)
+		_etext = . ;
+	}
+	.rodata : {
+		_rodata = . ;
+		*(.rodata)	 /* read-only data */
+		*(.rodata.*)
+		_erodata = . ;
+	}
+	.data :	{
+		_data = . ;
+		*(.data)
+		*(.data.*)
+		_edata = . ;
+	}
+	.bss : {
+		_bss = . ;
+		*(.bss)
+		*(.bss.*)
+		*(COMMON)
+		_end = . ;
+	}
+}
diff -puN arch/i386/boot/compressed/vmlinux.scr~i386-Relocatable-kernel-support arch/i386/boot/compressed/vmlinux.scr
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/vmlinux.scr~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/vmlinux.scr	2006-10-23 13:15:21.000000000 -0400
@@ -1,9 +1,10 @@
 SECTIONS
 {
-  .data : { 
+  .data.compressed : {
 	input_len = .;
 	LONG(input_data_end - input_data) input_data = .; 
 	*(.data) 
+	output_len = . - 4;
 	input_data_end = .; 
 	}
 }
diff -puN arch/i386/boot/setup.S~i386-Relocatable-kernel-support arch/i386/boot/setup.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/setup.S~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/setup.S	2006-10-23 15:08:42.000000000 -0400
@@ -588,11 +588,6 @@ rmodeswtch_normal:
 	call	default_switch
 
 rmodeswtch_end:
-# we get the code32 start address and modify the below 'jmpi'
-# (loader may have changed it)
-	movl	%cs:code32_start, %eax
-	movl	%eax, %cs:code32
-
 # Now we move the system to its rightful place ... but we check if we have a
 # big-kernel. In that case we *must* not move it ...
 	testb	$LOADED_HIGH, %cs:loadflags
@@ -788,11 +783,12 @@ a20_err_msg:
 a20_done:
 
 #endif /* CONFIG_X86_VOYAGER */
-# set up gdt and idt
+# set up gdt and idt and 32bit start address
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
 	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
 	shll	$4, %eax
+	addl	%eax, code32
 	addl	$gdt, %eax
 	movl	%eax, (gdt_48+2)
 	lgdt	gdt_48				# load gdt with whatever is
@@ -851,9 +847,26 @@ flush_instr:
 #	Manual, Mixing 16-bit and 32-bit code, page 16-6)
 
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
-code32:	.long	0x1000				# will be set to 0x100000
-						# for big kernels
+code32:	.long	startup_32			# will be set to %cs+startup_32
 	.word	__BOOT_CS
+.code32
+startup_32:
+	movl $(__BOOT_DS), %eax
+	movl %eax, %ds
+	movl %eax, %es
+	movl %eax, %fs
+	movl %eax, %gs
+	movl %eax, %ss
+
+	xorl %eax, %eax
+1:	incl %eax				# check that A20 really IS enabled
+	movl %eax, 0x00000000			# loop forever if it isn't
+	cmpl %eax, 0x00100000
+	je 1b
+
+	# Jump to the 32bit entry point
+	jmpl *(code32_start - start + (DELTA_INITSEG << 4))(%esi)
+.code16
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
diff -puN arch/i386/Kconfig~i386-Relocatable-kernel-support arch/i386/Kconfig
--- linux-2.6.19-rc2-git7-reloc/arch/i386/Kconfig~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/Kconfig	2006-10-23 15:08:45.000000000 -0400
@@ -773,6 +773,18 @@ config CRASH_DUMP
           PHYSICAL_START.
 	  For more details see Documentation/kdump/kdump.txt
 
+config RELOCATABLE
+	bool "Build a relocatable kernel"
+	help
+	  This build a kernel image that retains relocation information
+          so it can be loaded someplace besides the default 1MB.
+	  The relocations tend to the kernel binary about 10% larger,
+          but are discarded at runtime.
+
+	  One use is for the kexec on panic case where the recovery kernel
+          must live at a different physical address than the primary
+          kernel.
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
 
diff -puN arch/i386/Makefile~i386-Relocatable-kernel-support arch/i386/Makefile
--- linux-2.6.19-rc2-git7-reloc/arch/i386/Makefile~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/Makefile	2006-10-23 13:15:21.000000000 -0400
@@ -26,7 +26,9 @@ endif
 
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-LDFLAGS_vmlinux :=
+ifdef CONFIG_RELOCATABLE
+LDFLAGS_vmlinux := --emit-relocs
+endif
 CHECKFLAGS	+= -D__i386__
 
 CFLAGS += -pipe -msoft-float
diff -puN include/linux/screen_info.h~i386-Relocatable-kernel-support include/linux/screen_info.h
--- linux-2.6.19-rc2-git7-reloc/include/linux/screen_info.h~i386-Relocatable-kernel-support	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/include/linux/screen_info.h	2006-10-23 13:15:21.000000000 -0400
@@ -42,7 +42,8 @@ struct screen_info {
 	u16 pages;		/* 0x32 */
 	u16 vesa_attributes;	/* 0x34 */
 	u32 capabilities;       /* 0x36 */
-				/* 0x3a -- 0x3f reserved for future expansion */
+				/* 0x3a -- 0x3b reserved for future expansion */
+				/* 0x3c -- 0x3f micro stack for relocatable kernels */
 };
 
 extern struct screen_info screen_info;
_
