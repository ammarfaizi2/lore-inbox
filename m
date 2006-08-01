Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWHALHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWHALHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWHALHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:07:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20701 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161123AbWHALHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:07:15 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 32/33] x86_64: Relocatable kernel support
Date: Tue,  1 Aug 2006 05:03:47 -0600
Message-Id: <11544302483667-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the x86_64 kernel so that it can be loaded and run
at any 2M aligned address, below 512G.  The technique used is to
compile the decompressor with -fPIC and modify it so the decompressor
is fully relocatable.  For the main kernel the page tables are
modified so the kernel remains at the same virtual address.  In
addition a variable phys_base is kept that holds the physical address
the kernel is loaded at.  __pa_symbol is modified to add that when
we take the address of a kernel symbol.

When loaded with a normal bootloader the decompressor will decompress
the kernel to 2M and it will run there.  This both ensures the
relocation code is always working, and makes it easier to use 2M
pages for the kernel and the cpu.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/boot/compressed/Makefile    |   13 +
 arch/x86_64/boot/compressed/head.S      |  301 ++++++++++++++++++++++---------
 arch/x86_64/boot/compressed/misc.c      |  248 +++++++++++++-------------
 arch/x86_64/boot/compressed/vmlinux.lds |   44 +++++
 arch/x86_64/boot/compressed/vmlinux.scr |    5 -
 arch/x86_64/kernel/head.S               |  226 +++++++++++++----------
 arch/x86_64/kernel/vmlinux.lds.S        |    2 
 include/asm-x86_64/page.h               |    6 -
 8 files changed, 527 insertions(+), 318 deletions(-)

diff --git a/arch/x86_64/boot/compressed/Makefile b/arch/x86_64/boot/compressed/Makefile
index 8987c97..3dda50c 100644
--- a/arch/x86_64/boot/compressed/Makefile
+++ b/arch/x86_64/boot/compressed/Makefile
@@ -7,16 +7,15 @@ # Note all the files here are compiled/l
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
-EXTRA_AFLAGS	:= -traditional -m32
+EXTRA_AFLAGS	:= -traditional
 
 # cannot use EXTRA_CFLAGS because base CFLAGS contains -mkernel which conflicts with
-# -m32
-CFLAGS := -m32 -D__KERNEL__ -Iinclude -O2  -fno-strict-aliasing -fno-builtin
-LDFLAGS := -m elf_i386
+CFLAGS := -m64 -D__KERNEL__ -Iinclude -O2  -fno-strict-aliasing -fPIC -mcmodel=small -fno-builtin
+LDFLAGS := -m elf_x86_64
 
-LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32 -m elf_i386
+LDFLAGS_vmlinux := -T
 
-$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+$(obj)/vmlinux: $(src)/vmlinux.lds $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
 	@:
 
@@ -26,7 +25,7 @@ LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
+LDFLAGS_piggy.o := -r --format binary --oformat elf64-x86-64 -T
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86_64/boot/compressed/head.S b/arch/x86_64/boot/compressed/head.S
index cf55d09..22c8dc4 100644
--- a/arch/x86_64/boot/compressed/head.S
+++ b/arch/x86_64/boot/compressed/head.S
@@ -26,116 +26,245 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/msr.h>
 
+.section ".text.head"
 	.code32
 	.globl startup_32
 	
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
-	movl %eax,%ds
-	movl %eax,%es
-	movl %eax,%fs
-	movl %eax,%gs
-
-	lss stack_start,%esp
-	xorl %eax,%eax
-1:	incl %eax		# check that A20 really IS enabled
-	movl %eax,0x000000	# loop forever if it isn't
-	cmpl %eax,0x100000
-	je 1b
+	movl	$(__KERNEL_DS), %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %ss
+
+/* Calculate the delta between where we were compiled to run
+ * at and where we were actually loaded at.  This can only be done
+ * with a short local call on x86.  Nothing  else will tell us what
+ * address we are running at.  The reserved chunk of the real-mode
+ * data at 0x34-0x3f are used as the stack for this calculation.
+ * Only 4 bytes are needed.
+ */
+	leal	0x40(%esi), %esp
+	call	1f
+1:	popl	%ebp
+	subl	$1b, %ebp
+
+/* Compute the delta between where we were compiled to run at
+ * and where the code will actually run at.
+ */
+	movl	%ebp, %ebx
+	addl	$(LARGE_PAGE_SIZE -1), %ebx
+	andl	$LARGE_PAGE_MASK, %ebx
+
+	/* Replace the compressed data size with the uncompressed size */
+	subl	input_len(%ebp), %ebx
+	movl	output_len(%ebp), %eax
+	addl	%eax, %ebx
+	/* Add 8 bytes for every 32K input block */
+	shrl	$12, %eax
+	addl	%eax, %ebx
+	/* Add 32K + 18 bytes of extra slack and align on a 4K boundary */
+	addl	$(32768 + 18 + 4095), %ebx
+	andl	$~4095, %ebx
 
 /*
- * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
- * confuse the debugger if this code is traced.
- * XXX - best to initialize before switching to protected mode.
+ * Prepare for entering 64 bit mode
  */
-	pushl $0
-	popfl
+
+	/* Load new GDT with the 64bit segments using 32bit descriptor */
+	leal	gdt(%ebp), %eax
+	movl	%eax, gdt+2(%ebp)
+	lgdt	gdt(%ebp)
+
+	/* Enable PAE mode */
+	xorl	%eax, %eax
+	orl	$(1 << 5), %eax
+	movl	%eax, %cr4
+
 /*
- * Clear BSS
+ * Build early 4G boot pagetable
  */
-	xorl %eax,%eax
-	movl $_edata,%edi
-	movl $_end,%ecx
-	subl %edi,%ecx
-	cld
-	rep
-	stosb
+	/* Initialize Page tables to 0*/
+	leal	pgtable(%ebx), %edi
+	xorl	%eax, %eax
+	movl	$((4096*6)/4), %ecx
+	rep	stosl
+
+	/* Build Level 4 */
+	leal	pgtable + 0(%ebx), %edi
+	leal	0x1007 (%edi), %eax
+	movl	%eax, 0(%edi)
+
+	/* Build Level 3 */
+	leal	pgtable + 0x1000(%ebx), %edi
+	leal	0x1007(%edi), %eax
+	movl	$4, %ecx
+1:	movl	%eax, 0x00(%edi)
+	addl	$0x00001000, %eax
+	addl	$8, %edi
+	decl	%ecx
+	jnz	1b
+
+	/* Build Level 2 */
+	leal	pgtable + 0x2000(%ebx), %edi
+	movl	$0x00000183, %eax
+	movl	$2048, %ecx
+1:	movl	%eax, 0(%edi)
+	addl	$0x00200000, %eax
+	addl	$8, %edi
+	decl	%ecx
+	jnz	1b
+
+	/* Enable the boot page tables */
+	leal	pgtable(%ebx), %eax
+	movl	%eax, %cr3
+
+	/* Enable Long mode in EFER (Extended Feature Enable Register) */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+
+	/* Setup for the jump to 64bit mode
+	 *
+	 * When the jump is performend we will be in long mode but
+	 * in 32bit compatibility mode with EFER.LME = 1, CS.L = 0, CS.D = 1
+	 * (and in turn EFER.LMA = 1).	To jump into 64bit mode we use
+	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
+	 * We place all of the values on our mini stack so lret can
+	 * used to perform that far jump.
+	 */
+	pushl	$__KERNEL_CS
+	leal	startup_64(%ebp), %eax
+	pushl	%eax
+
+	/* Enter paged protected Mode, activating Long Mode */
+	movl	$0x80000001, %eax /* Enable Paging and Protected mode */
+	movl	%eax, %cr0
+
+	/* Jump from 32bit compatibility mode into 64bit mode. */
+	lret
+
+	/* Be careful here startup_64 needs to be at a predictable
+	 * address so I can export it in an ELF header.  Bootloaders
+	 * should look at the ELF header to find this address, as
+	 * it may change in the future.
+	 */
+	.code64
+	.org 0x100
+ENTRY(startup_64)
+	/* We come here either from startup_32 or directly from a
+	 * 64bit bootloader.  If we come here from a bootloader we depend on
+	 * an identity mapped page table being provied that maps our
+	 * entire text+data+bss and hopefully all of memory.
+	 */
+
+	/* Setup data segments. */
+	xorl	%eax, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %ss
+
+	/* Compute the decompressed kernel start address.  It is where
+	 * we were loaded at aligned to a 2M boundary.
+	 */
+	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
+	addq	$(LARGE_PAGE_SIZE - 1), %rbp
+	andq	$LARGE_PAGE_MASK, %rbp
+
+/* Compute the delta between where we were compiled to run at
+ * and where the code will actually run at.
+ */
+	/* Start with the delta to where the kernel will run at. */
+	movq	%rbp, %rbx
+
+	/* Replace the compressed data size with the uncompressed size */
+	movl	input_len(%rip), %eax
+	subq	%rax, %rbx
+	movl	output_len(%rip), %eax
+	addq	%rax, %rbx
+	/* Add 8 bytes for every 32K input block */
+	shrq	$12, %rax
+	addq	%rax, %rbx
+	/* Add 32K + 18 bytes of extra slack and align on a 4K boundary */
+	addq	$(32768 + 18 + 4095), %rbx
+	andq	$~4095, %rbx
+
+/* Copy the compressed kernel to the end of our buffer
+ * where decompression in place becomes safe.
+ */
+	leaq	_end(%rip), %r8
+	leaq	_end(%rbx), %r9
+	movq	$_end /* - $startup_32 */, %rcx
+1:	subq	$8, %r8
+	subq	$8, %r9
+	movq	0(%r8), %rax
+	movq	%rax, 0(%r9)
+	subq	$8, %rcx
+	jnz	1b
+
 /*
- * Do the decompression, and jump to the new kernel..
+ * Jump to the relocated address.
  */
-	subl $16,%esp	# place for structure on the stack
-	movl %esp,%eax
-	pushl %esi	# real mode pointer as second arg
-	pushl %eax	# address of structure as first arg
-	call decompress_kernel
-	orl  %eax,%eax 
-	jnz  3f
-	addl $8,%esp
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x200000
+	leaq	relocated(%rbx), %rax
+	jmp	*%rax
+
+.section ".text"
+relocated:
 
 /*
- * We come here, if we were loaded high.
- * We need to move the move-in-place routine down to 0x1000
- * and then start it with the buffer addresses in registers,
- * which we got from the stack.
+ * Clear BSS
  */
-3:
-	movl %esi,%ebx	
-	movl $move_routine_start,%esi
-	movl $0x1000,%edi
-	movl $move_routine_end,%ecx
-	subl %esi,%ecx
-	addl $3,%ecx
-	shrl $2,%ecx
+	xorq	%rax, %rax
+	movq	$_edata, %rdi
+	movq	$_end, %rcx
+	subq	%rdi, %rcx
 	cld
 	rep
-	movsl
-
-	popl %esi	# discard the address
-	addl $4,%esp	# real mode pointer
-	popl %esi	# low_buffer_start
-	popl %ecx	# lcount
-	popl %edx	# high_buffer_start
-	popl %eax	# hcount
-	movl $0x200000,%edi
-	cli		# make sure we don't get interrupted
-	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
+	stosb
+
+	/* Setup the stack */
+	leaq	user_stack_end(%rip), %rsp
+
+	/* zero EFLAGS after setting rsp */
+	pushq	$0
+	popfq
 
 /*
- * Routine (template) for moving the decompressed kernel in place,
- * if we were high loaded. This _must_ PIC-code !
+ * Do the decompression, and jump to the new kernel..
  */
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
-	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x200000
-move_routine_end:
+	pushq	%rsi			# Save the real mode argument
+	movq	%rsi, %rdi		# real mode address
+	leaq	_heap(%rip), %rsi	# _heap
+	leaq	input_data(%rip), %rdx  # input_data
+	movl	input_len(%rip), %eax
+	movq	%rax, %rcx		# input_len
+	movq	%rbp, %r8		# output
+	call	decompress_kernel
+	popq	%rsi
 
+/*
+ * Jump to the decompressed kernel.
+ */
+	jmp	*%rbp
 
-/* Stack for uncompression */ 	
-	.align 32
+	.data
+gdt:
+	.word	gdt_end - gdt
+	.long	gdt
+	.word	0
+	.quad	0x0000000000000000	/* NULL descriptor */
+	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
+	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
+gdt_end:
+	.bss
+/* Stack for uncompression */
+	.balign 4
 user_stack:	 	
 	.fill 4096,4,0
-stack_start:	
-	.long user_stack+4096
-	.word __KERNEL_DS
-
+user_stack_end:
diff --git a/arch/x86_64/boot/compressed/misc.c b/arch/x86_64/boot/compressed/misc.c
index 2cbd7cb..0e6c4b7 100644
--- a/arch/x86_64/boot/compressed/misc.c
+++ b/arch/x86_64/boot/compressed/misc.c
@@ -9,12 +9,97 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#define _LINUX_STRING_H_ 1
+#define __LINUX_BITMAP_H 1
+
+#include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/serial_reg.h>
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/setup.h>
 
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
+
 /*
  * gzip declarations
  */
@@ -30,15 +115,20 @@ typedef unsigned char  uch;
 typedef unsigned short ush;
 typedef unsigned long  ulg;
 
-#define WSIZE 0x8000		/* Window size must be at least 32k, */
-				/* and a power of two */
+#define WSIZE 0x80000000	/* Window size must be at least 32k,
+				 * and a power of two
+				 * We don't actually have a window just
+				 * a huge output buffer so I report
+				 * a 2G windows size, as that should
+				 * always be larger than our output buffer.
+				 */
 
-static uch *inbuf;	     /* input buffer */
-static uch window[WSIZE];    /* Sliding window buffer */
+static uch *inbuf;	/* input buffer */
+static uch *window;	/* Sliding window buffer, (and final output buffer) */
 
-static unsigned insize = 0;  /* valid bytes in inbuf */
-static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
-static unsigned outcnt = 0;  /* bytes in output buffer */
+static unsigned insize;  /* valid bytes in inbuf */
+static unsigned inptr;   /* index of next byte to be processed in inbuf */
+static unsigned outcnt;  /* bytes in output buffer */
 
 /* gzip flag byte */
 #define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
@@ -94,8 +184,6 @@ extern unsigned char input_data[];
 extern int input_len;
 
 static long bytes_out = 0;
-static uch *output_data;
-static unsigned long output_ptr = 0;
 
 static void *malloc(int size);
 static void free(void *where);
@@ -109,17 +197,10 @@ static char *strstr(const char *haystack
 static void putstr(const char *);
 static unsigned simple_strtou(const char *cp, char **endp, unsigned base);
 
-extern int end;
-static long free_mem_ptr = (long)&end;
+static long free_mem_ptr;
 static long free_mem_end_ptr;
 
-#define INPLACE_MOVE_ROUTINE  0x1000
-#define LOW_BUFFER_START      0x2000
-#define LOW_BUFFER_MAX       0x90000
-#define HEAP_SIZE             0x3000
-static unsigned int low_buffer_end, low_buffer_size;
-static int high_loaded =0;
-static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+#define HEAP_SIZE             0x6000
 
 static char *vidmem;
 static int vidport;
@@ -444,58 +525,31 @@ static char *strstr(const char *haystack
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
@@ -507,56 +561,6 @@ static void error(char *x)
 	while(1);	/* Halt */
 }
 
-static void setup_normal_output_buffer(void)
-{
-#ifdef STANDARD_MEMORY_BIOS_CALL
-	if (RM_EXT_MEM_K < 1024) error("Less than 2MB of memory");
-#else
-	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
-#endif
-	output_data = (unsigned char *)0x200000;
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
-	if ( (0x200000 + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(0x200000 + low_buffer_size);
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
 static void save_command_line(void)
 {
 	/* Find the command line */
@@ -571,20 +575,28 @@ static void save_command_line(void)
 	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 }
 
-int decompress_kernel(struct moveparams *mv, void *rmode)
+asmlinkage void decompress_kernel(void *rmode, unsigned long heap,
+	uch *input_data, unsigned long input_len, uch *output)
 {
 	real_mode = rmode;
-
 	save_command_line();
 	console_init(saved_command_line);
 
-	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
-	else setup_output_buffer_if_we_run_high(mv);
+	window = output;  		/* Output buffer (Normally at 1M) */
+	free_mem_ptr     = heap;	/* Heap  */
+	free_mem_end_ptr = heap + HEAP_SIZE;
+	inbuf  = input_data;		/* Input buffer */
+	insize = input_len;
+	inptr  = 0;
+
+	if ((ulg)output & 0x1fffffUL)
+		error("Destination address not 2M aligned");
+	if ((ulg)output >= 0xffffffffffUL)
+		error("Destination address too large");
 
 	makecrc();
 	putstr(".\nDecompressing Linux...");
 	gunzip();
 	putstr("done.\nBooting the kernel.\n");
-	if (high_loaded) close_output_buffer_if_we_run_high(mv);
-	return high_loaded;
+	return;
 }
diff --git a/arch/x86_64/boot/compressed/vmlinux.lds b/arch/x86_64/boot/compressed/vmlinux.lds
new file mode 100644
index 0000000..94c13e5
--- /dev/null
+++ b/arch/x86_64/boot/compressed/vmlinux.lds
@@ -0,0 +1,44 @@
+OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
+OUTPUT_ARCH(i386:x86-64)
+ENTRY(startup_64)
+SECTIONS
+{
+	/* Be careful parts of head.S assume startup_32 is at
+ 	 * address 0.
+	 */
+	. = 0;
+	.text :	{
+		_head = . ;
+		*(.text.head)
+		_ehead = . ;
+		*(.text.compressed)
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
+		. = ALIGN(8);
+		_end = . ;
+		. = ALIGN(4096);
+		pgtable = . ;
+		. = . + 4096 * 6;
+		_heap = .;
+	}
+}
diff --git a/arch/x86_64/boot/compressed/vmlinux.scr b/arch/x86_64/boot/compressed/vmlinux.scr
index 1ed9d79..48117cf 100644
--- a/arch/x86_64/boot/compressed/vmlinux.scr
+++ b/arch/x86_64/boot/compressed/vmlinux.scr
@@ -1,9 +1,10 @@
 SECTIONS
 {
-  .data : { 
+  .text.compressed : {
 	input_len = .;
 	LONG(input_data_end - input_data) input_data = .; 
-	*(.data) 
+	*(.data)
+	output_len = . - 4;
 	input_data_end = .; 
 	}
 }
diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index b0b5618..b821d13 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -5,6 +5,7 @@
  *  Copyright (C) 2000 Pavel Machek <pavel@suse.cz>
  *  Copyright (C) 2000 Karsten Keil <kkeil@suse.de>
  *  Copyright (C) 2001,2002 Andi Kleen <ak@suse.de>
+ *  Copyright (C) 2005 Eric Biederman <ebiederm@xmission.com>
  *
  *  $Id: head.S,v 1.49 2002/03/19 17:39:25 ak Exp $
  */
@@ -21,94 +22,121 @@ #include <asm/msr.h>
 #include <asm/cache.h>
 	
 /* we are not able to switch in one step to the final KERNEL ADRESS SPACE
- * because we need identity-mapped pages on setup so define __START_KERNEL to
- * 0x100000 for this stage
+ * because we need identity-mapped pages.
  * 
  */
 
 	.text
 	.section .bootstrap.text
-	.code32
-	.globl startup_32
-/* %bx:	 1 if coming from smp trampoline on secondary cpu */ 
-startup_32:
-	
+	.code64
+	.globl startup_64
+startup_64:
+
 	/*
-	 * At this point the CPU runs in 32bit protected mode (CS.D = 1) with
-	 * paging disabled and the point of this file is to switch to 64bit
-	 * long mode with a kernel mapping for kerneland to jump into the
-	 * kernel virtual addresses.
- 	 * There is no stack until we set one up.
+	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 1,
+	 * and someone has loaded an identity mapped page table
+	 * for us.  These identity mapped page tables map all of the
+	 * kernel pages and possibly all of memory.
+	 *
+	 * %esi holds a physical pointer to real_mode_data.
+	 *
+	 * We come here either directly from a 64bit bootloader, or from
+	 * arch/x86_64/boot/compressed/head.S.
+	 *
+	 * We only come here initially at boot nothing else comes here.
+	 *
+	 * Since we may be loaded at an address different from what we were
+	 * compiled to run at we first fixup the physical addresses in our page
+	 * tables and then reload them.
 	 */
 
-	/* Initialize the %ds segment register */
-	movl $__KERNEL_DS,%eax
-	movl %eax,%ds
-
-	/* Load new GDT with the 64bit segments using 32bit descriptor */
-	lgdt	pGDT32 - __START_KERNEL_map
-
-	/* If the CPU doesn't support CPUID this will double fault.
-	 * Unfortunately it is hard to check for CPUID without a stack. 
+	/* Compute the delta between the address I am compiled to run at and the
+	 * address I am actually running at.
 	 */
-	
-	/* Check if extended functions are implemented */		
-	movl	$0x80000000, %eax
-	cpuid
-	cmpl	$0x80000000, %eax
-	jbe	no_long_mode
-	/* Check if long mode is implemented */
-	mov	$0x80000001, %eax
-	cpuid
-	btl	$29, %edx
-	jnc	no_long_mode
-
-	/*
-	 * Prepare for entering 64bits mode
+	leaq	_text(%rip), %rbp
+	subq	$_text - __START_KERNEL_map, %rbp
+
+	/* Is the address not 2M aligned? */
+	movq	%rbp, %rax
+	andl	$~LARGE_PAGE_MASK, %eax
+	testl	%eax, %eax
+	jnz	bad_address
+
+	/* Is the address too large? */
+	leaq	_text(%rip), %rdx
+	movq	$PGDIR_SIZE, %rax
+	cmpq	%rax, %rdx
+	jae	bad_address
+
+	/* Fixup the physical addresses in the page table
 	 */
-
-	/* Enable PAE mode */
-	xorl	%eax, %eax
-	btsl	$5, %eax
-	movl	%eax, %cr4
-
-	/* Setup early boot stage 4 level pagetables */
-	movl	$(init_level4_pgt - __START_KERNEL_map), %eax
-	movl	%eax, %cr3
-
-	/* Setup EFER (Extended Feature Enable Register) */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-
-	/* Enable Long Mode */
-	btsl	$_EFER_LME, %eax
-				
-	/* Make changes effective */
-	wrmsr
-
-	xorl	%eax, %eax
-	btsl	$31, %eax			/* Enable paging and in turn activate Long Mode */
-	btsl	$0, %eax			/* Enable protected mode */
-	/* Make changes effective */
-	movl	%eax, %cr0
-	/*
-	 * At this point we're in long mode but in 32bit compatibility mode
-	 * with EFER.LME = 1, CS.L = 0, CS.D = 1 (and in turn
-	 * EFER.LMA = 1). Now we want to jump in 64bit mode, to do that we use
-	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
+	addq	%rbp, init_level4_pgt + 0(%rip)
+	addq	%rbp, init_level4_pgt + (258*8)(%rip)
+	addq	%rbp, init_level4_pgt + (511*8)(%rip)
+
+	addq	%rbp, level3_ident_pgt + 0(%rip)
+	addq	%rbp, level3_kernel_pgt + (510*8)(%rip)
+
+	/* Add an Identity mapping if I am above 1G */
+	leaq	_text(%rip), %rdi
+	andq	$LARGE_PAGE_MASK, %rdi
+
+	movq	%rdi, %rax
+	shrq	$PUD_SHIFT, %rax
+	andq	$(PTRS_PER_PUD - 1), %rax
+	jz	ident_complete
+
+	leaq	(level2_spare_pgt - __START_KERNEL_map + _KERNPG_TABLE)(%rbp), %rdx
+	leaq	level3_ident_pgt(%rip), %rbx
+	movq	%rdx, 0(%rbx, %rax, 8)
+
+	movq	%rdi, %rax
+	shrq	$PMD_SHIFT, %rax
+	andq	$(PTRS_PER_PMD - 1), %rax
+	leaq	__PAGE_KERNEL_LARGE_EXEC(%rdi), %rdx
+	leaq	level2_spare_pgt(%rip), %rbx
+	movq	%rdx, 0(%rbx, %rax, 8)
+ident_complete:
+
+	/* Fixup the kernel text+data virtual addresses
 	 */
-	ljmp	$__KERNEL_CS, $(startup_64 - __START_KERNEL_map)
+	leaq	level2_kernel_pgt(%rip), %rdi
+	leaq	4096(%rdi), %r8
+	/* See if it is a valid page table entry */
+1:	testq	$1, 0(%rdi)
+	jz	2f
+	addq	%rbp, 0(%rdi)
+	/* Go to the next page */
+2:	addq	$8, %rdi
+	cmp	%r8, %rdi
+	jne	1b
+
+	/* Fixup phys_base */
+	addq	%rbp, phys_base(%rip)
+
+#ifdef CONFIG_SMP
+	addq	%rbp, trampoline_level4_pgt + 0(%rip)
+	addq	%rbp, trampoline_level4_pgt + (511*8)(%rip)
+#endif
+#ifdef CONFIG_ACPI_SLEEP
+	addq	%rbp, wakeup_level4_pgt + 0(%rip)
+	addq	%rbp, wakeup_level4_pgt + (511*8)(%rip)
+#endif
 
-	.code64
-	.org 0x100	
-	.globl startup_64
-startup_64:
 ENTRY(secondary_startup_64)
-	/* We come here either from startup_32
-	 * or directly from a 64bit bootloader.
-	 * Since we may have come directly from a bootloader we
-	 * reload the page tables here.
-	 */
+	/*
+	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 1,
+	 * and someone has loaded a mapped page table.
+	 *
+	 * %esi holds a physical pointer to real_mode_data.
+	 *
+	 * We come here either from startup_64 (using physical addresses)
+	 * or from trampoline.S (using virtual addresses).
+	 *
+	 * Using virtual addresses from trampoline.S removes the need
+	 * to have any identity mapped pages in the kernel page table
+	 * after the boot processor executes this code.
+ 	 */
 
 	/* Enable PAE mode and PGE */
 	xorq	%rax, %rax
@@ -118,8 +146,14 @@ ENTRY(secondary_startup_64)
 
 	/* Setup early boot stage 4 level pagetables. */
 	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
+	addq	phys_base(%rip), %rax
 	movq	%rax, %cr3
 
+	/* Ensure I am executing from virtual addresses */
+	movq	$1f, %rax
+	jmp	*%rax
+1:
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -128,17 +162,11 @@ ENTRY(secondary_startup_64)
 	/* Setup EFER (Extended Feature Enable Register) */
 	movl	$MSR_EFER, %ecx
 	rdmsr
-
-	/* Enable System Call */
-	btsl	$_EFER_SCE, %eax
-
-	/* No Execute supported? */
-	btl	$20,%edi
+	btsl	$_EFER_SCE, %eax	/* Enable System Call */
+	btl	$20,%edi		/* No Execute supported? */
 	jnc     1f
 	btsl	$_EFER_NX, %eax
-1:
-	/* Make changes effective */
-	wrmsr
+1:	wrmsr				/* Make changes effective */
 
 	/* Setup cr0 */
 #define CR0_PM				1		/* protected mode */
@@ -165,7 +193,7 @@ #define CR0_PAGING 			(1<<31)
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	cpu_gdt_descr
+	lgdt	cpu_gdt_descr(%rip)
 
 	/* 
 	 * Setup up a dummy PDA. this is just for some early bootup code
@@ -204,6 +232,9 @@ initial_code:
 init_rsp:
 	.quad  init_thread_union+THREAD_SIZE-8
 
+bad_address:
+	jmp bad_address
+
 ENTRY(early_idt_handler)
 	cmpl $2,early_recursion_flag(%rip)
 	jz  1f
@@ -232,23 +263,7 @@ early_idt_msg:
 early_idt_ripmsg:
 	.asciz "RIP %s\n"
 
-.code32
-ENTRY(no_long_mode)
-	/* This isn't an x86-64 CPU so hang */
-1:
-	jmp	1b
-
-.org 0xf00
-	.globl pGDT32
-pGDT32:
-	.word	gdt_end-cpu_gdt_table-1
-	.long	cpu_gdt_table-__START_KERNEL_map
-
-.org 0xf10	
-ljumpvector:
-	.long	startup_64-__START_KERNEL_map
-	.word	__KERNEL_CS
-
+.balign PAGE_SIZE
 ENTRY(stext)
 ENTRY(_stext)
 
@@ -303,6 +318,9 @@ NEXT_PAGE(level2_kernel_pgt)
 	/* Module mapping starts here */
 	.fill	(PTRS_PER_PMD - (KERNEL_TEXT_SIZE/PMD_SIZE)),8,0
 
+NEXT_PAGE(level2_spare_pgt)
+	.fill	512,8,0
+
 #undef PMDS
 #undef NEXT_PAGE
 
@@ -325,6 +343,10 @@ #ifdef CONFIG_SMP
 	.endr
 #endif
 
+ENTRY(phys_base)
+	/* This must match the first entry in level2_kernel_pgt */
+	.quad	0x0000000000000000
+
 /* We need valid kernel segments for data and code in long mode too
  * IRET will check the segment types  kkeil 2000/10/28
  * Also sysret mandates a special GDT layout 
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index 741487b..456fe8e 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -15,7 +15,7 @@ ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
 SECTIONS
 {
-  . = __START_KERNEL_map + 0x200000;
+  . = __START_KERNEL_map;
   phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;			/* Text and read-only data */
   .text :  AT(ADDR(.text) - LOAD_OFFSET) {
diff --git a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
index deed41a..d125c09 100644
--- a/include/asm-x86_64/page.h
+++ b/include/asm-x86_64/page.h
@@ -61,6 +61,8 @@ #define PTE_MASK	PHYSICAL_PAGE_MASK
 
 typedef struct { unsigned long pgprot; } pgprot_t;
 
+extern unsigned long phys_base;
+
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).pmd)
 #define pud_val(x)	((x).pud)
@@ -99,14 +101,14 @@ #endif /* __ASSEMBLY__ */
 #define PAGE_OFFSET		__PAGE_OFFSET
 
 /* Note: __pa(&symbol_visible_to_c) should be always replaced with __pa_symbol.
-   Otherwise you risk miscompilation. */ 
+   Otherwise you risk miscompilation. */
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
 /* __pa_symbol should be used for C visible symbols.
    This seems to be the official gcc blessed way to do such arithmetic. */ 
 #define __pa_symbol(x)		\
 	({unsigned long v;  \
 	  asm("" : "=r" (v) : "0" (x)); \
-	  (v - __START_KERNEL_map); })
+	  ((v - __START_KERNEL_map) + phys_base); })
 
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #ifdef CONFIG_FLATMEM
-- 
1.4.2.rc2.g5209e

