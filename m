Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUIANbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUIANbA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUIANa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:30:56 -0400
Received: from mail.renesas.com ([202.234.163.13]:52991 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266555AbUIANYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:24:14 -0400
Date: Wed, 01 Sep 2004 22:23:53 +0900 (JST)
Message-Id: <20040901.222353.576022558.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] [m32r] Support a new bootloader "m32r-g00ff"
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is for m32r 2.6.7 kernel.
Please apply this.

       * Support new bootloader "m32r-g00ff".
       m32r-g00ff is newly written by NIIBE Yutaka and is released under GPL.
       http://www.gniibe.org/software/m32r-g00ff-20040729.tar.gz

       * arch/m32r/kernel/setup.c (parse_mem_cmdline):
       Fix to remove unused region at the end of memory.

       * include/asm-m32r/uaccess.h (__put_user_u64): 
       Fix to remove warnings in compilation time.


NOTE: (for m32r users)
  From this version, the bootloader-kernel interface has changed.
  - Section order is changed and rearranged for the new bootloader.
  - Kernel's entry address is also changed : 0x08001000 --> 0x08002000.
  - Paramter-passing method from bootloader to kernel is revised.


---
 arch/m32r/Makefile                      |   20 +++
 arch/m32r/boot/compressed/Makefile      |   15 +-
 arch/m32r/boot/compressed/head.S        |  125 +++--------------------
 arch/m32r/boot/compressed/m32r_sio.c    |    5 
 arch/m32r/boot/compressed/misc.c        |    7 -
 arch/m32r/boot/compressed/vmlinux.lds.S |    4 
 arch/m32r/boot/setup.S                  |   81 ++-------------
 arch/m32r/kernel/entry.S                |    6 -
 arch/m32r/kernel/head.S                 |    3 
 arch/m32r/kernel/io_m32700ut.c          |   88 +++++++++++++++-
 arch/m32r/kernel/setup.c                |   11 --
 arch/m32r/kernel/setup_m32700ut.c       |    3 
 arch/m32r/kernel/traps.c                |  167 ++++++++++----------------------
 arch/m32r/kernel/vmlinux.lds.S          |   23 ----
 include/asm-m32r/ide.h                  |   11 ++
 include/asm-m32r/types.h                |   11 +-
 include/asm-m32r/uaccess.h              |   20 +--
 17 files changed, 245 insertions(+), 355 deletions(-)
---


diff -ruNp linux-2.6.7_20040819/arch/m32r/Makefile linux-2.6.7/arch/m32r/Makefile
--- linux-2.6.7_20040819/arch/m32r/Makefile	2004-04-23 16:09:37.000000000 +0900
+++ linux-2.6.7/arch/m32r/Makefile	2004-08-23 20:53:31.000000000 +0900
@@ -32,7 +32,23 @@ LIBGCC	:= $(shell $(CC) $(CFLAGS) -print
 libs-y	+= arch/m32r/lib/ $(LIBGCC)
 core-y	+= arch/m32r/kernel/	\
 	   arch/m32r/mm/	\
-	   arch/m32r/boot/	\
-	   arch/m32r/drivers/
+	   arch/m32r/boot/
+
+drivers-y			+= arch/m32r/drivers/
 drivers-$(CONFIG_OPROFILE)	+= arch/m32r/oprofile/
 
+boot := arch/m32r/boot
+
+.PHONY: zImage
+
+zImage: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+compressed: zImage
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+define archhelp
+	@echo '  zImage			- Compressed kernel image (arch/m32r/boot/zImage)'
+endef
diff -ruNp linux-2.6.7_20040819/arch/m32r/boot/compressed/Makefile linux-2.6.7/arch/m32r/boot/compressed/Makefile
--- linux-2.6.7_20040819/arch/m32r/boot/compressed/Makefile	2004-07-29 22:07:12.000000000 +0900
+++ linux-2.6.7/arch/m32r/boot/compressed/Makefile	2004-08-24 21:17:44.000000000 +0900
@@ -5,7 +5,7 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o \
-		   m32r-sio.o piggy.o vmlinux.lds.s
+		   m32r-sio.o piggy.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 
 OBJECTS = $(obj)/head.o $(obj)/misc.o $(obj)/m32r_sio.o
@@ -13,11 +13,12 @@ OBJECTS = $(obj)/head.o $(obj)/misc.o $(
 #
 # IMAGE_OFFSET is the load offset of the compression loader
 #
-IMAGE_OFFSET := $(shell printf "0x%08x" $$[$(CONFIG_MEMORY_START)+0x1000])
+#IMAGE_OFFSET := $(shell printf "0x%08x" $$[$(CONFIG_MEMORY_START)+0x2000])
+#IMAGE_OFFSET := $(shell printf "0x%08x" $$[$(CONFIG_MEMORY_START)+0x00400000])
 
-LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T 
+LDFLAGS_vmlinux := -T 
 
-$(obj)/vmlinux: $(obj)/vmlinux.lds.s $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
 	@:
 
@@ -27,11 +28,11 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-$(obj)/vmlinux.lds.s: $(obj)/vmlinux.lds.S FORCE
-	$(CPP) -E -P $< >$@
+$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.S FORCE
+	$(CPP) $(EXTRA_AFLAGS) -C -P -I include $< >$@
 
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-m32r-linux -T
-#OBJCOPYFLAGS += -R .empty_zero_page
+OBJCOPYFLAGS += -R .empty_zero_page
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
diff -ruNp linux-2.6.7_20040819/arch/m32r/boot/compressed/head.S linux-2.6.7/arch/m32r/boot/compressed/head.S
--- linux-2.6.7_20040819/arch/m32r/boot/compressed/head.S	2004-07-29 22:07:12.000000000 +0900
+++ linux-2.6.7/arch/m32r/boot/compressed/head.S	2004-08-24 14:42:30.000000000 +0900
@@ -3,6 +3,7 @@
  *
  *  Copyright (c) 2001-2003	Hiroyuki Kondo, Hirokazu Takata,
  *				Hitoshi Yamamoto, Takeo Takahashi
+ *  Copyright (c) 2004		Hirokazu Takata
  */
 
 	.text
@@ -11,7 +12,6 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 #include <asm/assembler.h>
-#include "boot.h"
 
 	.global	startup
 	__ALIGN
@@ -85,118 +85,31 @@ startup:
  * decompress the kernel
  */
 	bl	decompress_kernel
-	mv	r12, r0 		/* size of decompressed kernel */
 
-/*
- * relocate copy routine & jump routine
- */
-	LDIMM	(r1, BOOT_RELOC_ADDR)
-	mv	r5, r1		; save reloc addr to jump
-
-	LDIMM	(r2, startup_reloc)
-	LDIMM	(r3, exit_reloc)
-	sub	r3, r2		; relocated code size in bytes
-	mv	r4, r3
-	srli	r4, #2		; R4 = code size in longwords (rounded down)
-	addi	r1, #-4		; account for pre-inc store
-	beqz	r4, 2f		; any more to go?
-	.fillinsn
-1:	
-	ld	r6, @r2+	; code to be relocated
-	st	r6, @+r1	; relocate code
-	addi	r4, #-1		; decrement count
-	bnez	r4, 1b		; go do some more
-	.fillinsn
-2:
-	and3	r4, r3, #3	; get no. of remaining bytes
-	addi	r1, #4		; account for pre-inc store
-	beqz	r4, 4f		; any more to go?
-	.fillinsn
-3:
-	ldb	r6, @r2		; code to be relocated
-	stb	r6, @r1		; relocate code
-	addi	r1, #1		; bump address
-	addi	r2, #1		; bump address
-	addi	r4, #-1		; decrement count
-	bnez	r4, 3b		; go do some more
-	.fillinsn
-4:		
-	jmp	r5		; jump to relocated code
-
-/*
- * startup_reloc runs on BOOT_RELOC_ADDR.
- * copy decompressed kernel to original location
- */
-	.text
-	__ALIGN
-startup_reloc:
-	LDIMM	(r1, CONFIG_MEMORY_START)
-	LDIMM	(r2, KERNEL_DECOMPRESS_ADDR)
-	mv	r4, r12		; r12 holds size of decompressed kernel
-	srli	r4, #2		; R4 = code size in longwords (rounded down)
-	addi	r1, #-4		; account for pre-inc store
-	beqz	r4, 2f		; any more to go?
-	.fillinsn
-1:	
-	ld	r6, @r2+	; code to be relocated
-	st	r6, @+r1	; relocate code
-	addi	r4, #-1		; decrement count
-	bnez	r4, 1b		; go do some more
-	.fillinsn
-2:
-	and3	r4, r12, #3	; get no. of remaining bytes
-	addi	r1, #4		; account for pre-inc store
-	beqz	r4, 4f		; any more to go?
-	.fillinsn
-3:
-	ldb	r6, @r2		; code to be relocated
-	stb	r6, @r1		; relocate code
-	addi	r1, #1		; bump address
-	addi	r2, #1		; bump address
-	addi	r4, #-1		; decrement count
-	bnez	r4, 3b		; go do some more
-	.fillinsn
-4:		
-	/*
-	 * invalidate i-cache before jump to kernel
-	 */
-#if defined(CONFIG_CHIP_VDEC2)
-	ldi	r0, #-1
-	ldi	r1, #0xc0	; invalidate i-cache
-	stb	r1, @r0
-#elif defined(CONFIG_CHIP_XNUX2)
-	ldi	r0, #-2
-	ldi	r1, #0x0100	; invalidate
-	sth	r1, @r0
-#elif defined(CONFIG_CHIP_M32700)
-	ldi	r0, #-1		; MCCR(cache control register)
-	ldi	r1, #0xc0	; invalidate i-cache
+#if defined(CONFIG_CHIP_M32700)
+	/* Cache flush */
+	ldi	r0, -1
+	ldi	r1, 0xd0	; invalidate i-cache, copy back d-cache
 	stb	r1, @r0
 #else
-#error unknown chip configuration
+#error "put your cache flush function, please"
 #endif
-	LDIMM	(r0, KERNEL_ENTRY)
-	jmp	r0				/* jump to kernel */
-
-	__ALIGN
-exit_reloc:
-
-	.balign 4096
-.fake_empty_zero_page:
-	/* FIXME: correct table value */
-	.word	0
+        seth	r0, #high(CONFIG_MEMORY_START)
+        or3	r0, r0, #0x2000
+        jmp	r0
+
+	.balign 512
+fake_headers_as_bzImage:
+	.short	0
 	.ascii	"HdrS"
-	.word	0x0202
-	.word	0
-	.word	0
-	.word	0x1000
-	.word	0
+	.short	0x0202
+	.short	0
+	.short	0
+	.byte	0x00, 0x10
+	.short	0
 	.byte	0
 	.byte	1
-	.word	0x8000
+	.byte	0x00, 0x80
 	.long	0
 	.long	0
 
-	.section	.fake_eit_vector, "aw"
-	.long	0
-
diff -ruNp linux-2.6.7_20040819/arch/m32r/boot/compressed/m32r_sio.c linux-2.6.7/arch/m32r/boot/compressed/m32r_sio.c
--- linux-2.6.7_20040819/arch/m32r/boot/compressed/m32r_sio.c	2003-09-09 10:15:02.000000000 +0900
+++ linux-2.6.7/arch/m32r/boot/compressed/m32r_sio.c	2004-08-24 14:21:43.000000000 +0900
@@ -11,10 +11,11 @@
 
 void putc(char c);
 
-void puts(char *s)
+int puts(const char *s)
 {
 	char c;
 	while ((c = *s++)) putc(c);
+	return 0;
 }
 
 #if defined(CONFIG_PLAT_M32700UT_Alpha) || defined(CONFIG_PLAT_M32700UT)
@@ -28,6 +29,8 @@ void puts(char *s)
 #define BOOT_SIO0STS	(volatile unsigned short *)(0x02c00000 + 0x20006)
 #define BOOT_SIO0TXB	(volatile unsigned short *)(0x02c00000 + 0x2000c)
 #else
+#undef PLD_BASE
+#define PLD_BASE	0xa4c00000
 #define BOOT_SIO0STS	PLD_ESIO0STS
 #define BOOT_SIO0TXB	PLD_ESIO0TXB
 #endif
diff -ruNp linux-2.6.7_20040819/arch/m32r/boot/compressed/misc.c linux-2.6.7/arch/m32r/boot/compressed/misc.c
--- linux-2.6.7_20040819/arch/m32r/boot/compressed/misc.c	2003-09-09 10:15:02.000000000 +0900
+++ linux-2.6.7/arch/m32r/boot/compressed/misc.c	2004-08-24 20:18:39.000000000 +0900
@@ -15,8 +15,7 @@
  */
 
 #include <linux/config.h>
-#include <asm/uaccess.h>
-#include "boot.h"
+#include <linux/string.h>
 
 /*
  * gzip declarations
@@ -91,7 +90,7 @@ static void error(char *m);
 static void gzip_mark(void **);
 static void gzip_release(void **);
  
-extern void puts(const char *);
+extern int puts(const char *);
   
 extern int _text;		/* Defined in vmlinux.lds.S */
 extern int _end;
@@ -212,7 +211,7 @@ long decompress_kernel(void)
 	bytes_out = 0;
 	outcnt = 0;
 	output_data = 0;
-	output_ptr = (unsigned long)KERNEL_DECOMPRESS_ADDR;
+	output_ptr = CONFIG_MEMORY_START + 0x2000;
 	free_mem_ptr = (unsigned long)&_end;
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
diff -ruNp linux-2.6.7_20040819/arch/m32r/boot/compressed/vmlinux.lds.S linux-2.6.7/arch/m32r/boot/compressed/vmlinux.lds.S
--- linux-2.6.7_20040819/arch/m32r/boot/compressed/vmlinux.lds.S	2004-07-29 22:07:12.000000000 +0900
+++ linux-2.6.7/arch/m32r/boot/compressed/vmlinux.lds.S	2004-08-23 20:53:31.000000000 +0900
@@ -4,10 +4,8 @@ OUTPUT_ARCH(m32r)
 ENTRY(startup)
 SECTIONS
 {
-  . = CONFIG_MEMORY_START;
-  .fake_eit_vector : { *(.fake_eit_vector) }
+  . = CONFIG_MEMORY_START + 0x00400000;
   
-  . = ALIGN(4096);
   _text = .;
   .text : { *(.text) } = 0
   .rodata : { *(.rodata) }
diff -ruNp linux-2.6.7_20040819/arch/m32r/boot/setup.S linux-2.6.7/arch/m32r/boot/setup.S
--- linux-2.6.7_20040819/arch/m32r/boot/setup.S	2004-07-27 15:54:20.000000000 +0900
+++ linux-2.6.7/arch/m32r/boot/setup.S	2004-08-24 20:18:01.000000000 +0900
@@ -60,7 +60,7 @@
 /*------------------------------------------------------------------------
  * Kernel entry
  */
-	.section .boot,"ax"
+	.section .boot, "ax"
 ENTRY(boot)
 
 /* Set cache mode */
@@ -69,74 +69,12 @@ ENTRY(boot)
 	ldi	r1, #0x0101		; cache on (with invalidation)
 ;	ldi	r1, #0x00		; cache off
 	sth	r1, @r0
-#elif defined(CONFIG_CHIP_VDEC2)
-	; cache condition is controlled by loader
-	; r13 = pointer to kernel parameter passed from loader
-	beqz	r13, param_skip
-	ldi	r2, #4096				; size
-	seth	r1, #high(empty_zero_page)
-	or3	r1, r1, #low(empty_zero_page)
-	seth	r3, #high(__PAGE_OFFSET)
-	or3	r3, r3, #low(__PAGE_OFFSET)
-	not	r3, r3
-	and	r1, r3
-	addi	r1, #-4
-param_loop:
-	ld	r3, @r13+
-	st	r3, @+r1
-	addi	r2, #-4
-	bnez	r2, param_loop
-	bra	param_end
-param_skip:
-	ldi	r0, #-1              ;LDIMM	(r0, M32R_MCCR)
-	ldi	r1, #0x63      		; cache on
-;	ldi	r1, #0x00		; cache off
-	stb	r1, @r0
-param_end:
-
-#elif defined(CONFIG_CHIP_M32700) && (defined(CONFIG_PLAT_M32700UT) \
-	|| defined(CONFIG_PLAT_USRV)) || \
-	defined(CONFIG_CHIP_OPSP) && defined(CONFIG_PLAT_OPSPUT)	
-	; cache condition is controlled by loader
-	; r13 = pointer to kernel parameter passed from loader
-	ldi     r0, #-4
-	ldi     r1, #0x63		;  cache Ion/Don
-	st      r1, @r0
-#if defined(CONFIG_SMP) && !defined(CONFIG_PLAT_USRV)
-	seth    r5, #high(M32R_CPUID_PORTL)
-	or3     r5, r5, #low(M32R_CPUID_PORTL)
-	ld      r5, @r5
-	bnez    r5, param_end
-		;;  boot AP
-	ld24    r5, #0xeff2f8		;  IPICR7
-	ldi     r6, #0x2		;  IPI to CPU1
-	st      r6, @r5
-#endif
-	beqz	r13, param_end
-	ldi	r2, #4096				; size
-	seth	r1, #high(empty_zero_page)
-	or3	r1, r1, #low(empty_zero_page)
-	seth	r3, #high(__PAGE_OFFSET)
-	or3	r3, r3, #low(__PAGE_OFFSET)
-	not	r3, r3
-	and	r1, r3
-	addi	r1, #-4
-param_loop:
-	ld	r3, @r13+
-	st	r3, @+r1
-	addi	r2, #-4
-	bnez	r2, param_loop
-param_end:
-#elif defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_OPSP)
-	ldi	r0, #-4			;LDIMM	(r0, M32R_MCCR)
-	ldi	r1, #0x63		; cache Ion/Don (with invalidation)
+#elif defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_VDEC2) \
+    || defined(CONFIG_CHIP_OPSP)
+	ldi	r0, #-4              ;LDIMM	(r0, M32R_MCCR)
+	ldi	r1, #0x73		; cache on (with invalidation)
 ;	ldi	r1, #0x00		; cache off
 	st	r1, @r0
-#elif defined(CONFIG_CHIP_M32102)
-        ldi     r0, #-4                 ;LDIMM  (r0, M32R_MCCR)
-        ldi     r1, #0x101              ; cache Ion (with invalidation)
-;       ldi     r1, #0x00               ; cache off
-        st      r1, @r0
 #else
 #error unknown chip configuration
 #endif
@@ -146,6 +84,12 @@ param_end:
 	seth	r5, #shigh(M32R_CPUID_PORTL)
 	ld      r5, @(low(M32R_CPUID_PORTL), r5)
 	bnez	r5, AP_loop
+#if !defined(CONFIG_PLAT_USRV)
+	;; boot AP
+	ld24	r5, #0xeff2f8		; IPICR7
+	ldi	r6, #0x2		; IPI to CPU1
+	st	r6, @r5
+#endif
 #endif
 
 /*
@@ -153,11 +97,12 @@ param_end:
  *        if with MMU,    TLB on.
  *        if with no MMU, only jump.
  */
+ 	.global	eit_vector
 mmu_on:
 	LDIMM	(r13, stext)
 #ifdef CONFIG_MMU
 	bl	init_tlb
-	LDIMM	(r2, _RE)			; set EVB(cr5)
+	LDIMM	(r2, eit_vector)		; set EVB(cr5)
 	mvtc    r2, cr5	
 	seth	r0, #high(MMU_REG_BASE)		; Set MMU_REG_BASE higher
 	or3     r0, r0, #low(MMU_REG_BASE)	; Set MMU_REG_BASE lower
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/entry.S linux-2.6.7/arch/m32r/kernel/entry.S
--- linux-2.6.7_20040819/arch/m32r/kernel/entry.S	2004-07-27 15:54:20.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/entry.S	2004-08-23 20:53:31.000000000 +0900
@@ -297,6 +297,10 @@ syscall_badsys:
 	st	r4, R0(sp)
 	bra	resume_userspace
 
+	.global	eit_vector
+
+	.equ ei_vec_table, eit_vector + 0x0200
+
 /* 
  * EI handler routine
  */
@@ -335,7 +339,7 @@ ENTRY(ei_handler)
 	bc	2f
 	cmpi	r0, #((M32R_IRQ_IPI7+1)<<2)	; ISN > IPI7 check
 	bnc	2f
-	LDIMM	(r2, _EI_VEC_TABLE)
+	LDIMM	(r2, ei_vec_table)
 	add	r2, r0
 	ld	r2, @r2
 	beqz	r2, 1f			; if (no IPI handler) goto exit
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/head.S linux-2.6.7/arch/m32r/kernel/head.S
--- linux-2.6.7_20040819/arch/m32r/kernel/head.S	2004-06-01 14:00:10.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/head.S	2004-08-23 20:53:31.000000000 +0900
@@ -138,9 +138,10 @@ loop1:
  * AP startup routine
  */
 	.text
+	.global	eit_vector
 ENTRY(startup_AP)
 ;; setup EVB
-	LDIMM  (r4, _RE)
+	LDIMM  (r4, eit_vector)
 	mvtc   r4, cr5
 	
 ;; enable MMU
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/io_m32700ut.c linux-2.6.7/arch/m32r/kernel/io_m32700ut.c
--- linux-2.6.7_20040819/arch/m32r/kernel/io_m32700ut.c	2004-06-22 18:42:09.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/io_m32700ut.c	2004-08-23 20:53:31.000000000 +0900
@@ -40,6 +40,26 @@ static __inline__ void *_port2addr(unsig
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
+#if defined(CONFIG_IDE)
+static __inline__ void *__port2addr_ata(unsigned long port)
+{
+	static int	dummy_reg;
+
+	switch (port) {
+	case 0x1f0:	return (void *)0xac002000;
+	case 0x1f1:	return (void *)0xac012800;
+	case 0x1f2:	return (void *)0xac012002;
+	case 0x1f3:	return (void *)0xac012802;
+	case 0x1f4:	return (void *)0xac012004;
+	case 0x1f5:	return (void *)0xac012804;
+	case 0x1f6:	return (void *)0xac012006;
+	case 0x1f7:	return (void *)0xac012806;
+	case 0x3f6:	return (void *)0xac01200e;
+	default: 	return (void *)&dummy_reg;
+	}
+}
+#endif
+
 /*
  * M32700UT-LAN is located in the extended bus space
  * from 0x10000000 to 0x13ffffff on physical address.
@@ -99,6 +119,11 @@ unsigned char _inb(unsigned long port)
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inb(PORT2ADDR_NE(port));
 
+#if defined(CONFIG_IDE)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned char *)__port2addr_ata(port);
+	}
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned char b;
@@ -114,13 +139,17 @@ unsigned short _inw(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inw(PORT2ADDR_NE(port));
+#if defined(CONFIG_IDE)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned short *)__port2addr_ata(port);
+	}
+#endif
 #if defined(CONFIG_USB)
 	else if(port >= 0x340 && port < 0x3a0)
 	  return *(volatile unsigned short *)PORT2ADDR_USB(port);
 #endif
-	
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
+	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned short w;
 	   pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
 	   return w;
@@ -148,6 +177,11 @@ unsigned char _inb_p(unsigned long port)
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		v = _ne_inb(PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned char *)__port2addr_ata(port);
+	} else
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned char b;
@@ -168,12 +202,16 @@ unsigned short _inw_p(unsigned long port
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		v = _ne_inw(PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		return *(volatile unsigned short *)__port2addr_ata(port);
+	} else
+#endif
 #if defined(CONFIG_USB)
 	  if(port >= 0x340 && port < 0x3a0)
 	    return *(volatile unsigned short *)PORT2ADDR_USB(port);
 	else
 #endif
-
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned short w;
@@ -201,6 +239,11 @@ void _outb(unsigned char b, unsigned lon
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned char *)__port2addr_ata(port) = b;
+	} else
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
@@ -214,12 +257,16 @@ void _outw(unsigned short w, unsigned lo
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned short *)__port2addr_ata(port) = w;
+	} else
+#endif
 #if defined(CONFIG_USB)
 	if(port >= 0x340 && port < 0x3a0)
 	  *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
-
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
@@ -243,6 +290,11 @@ void _outb_p(unsigned char b, unsigned l
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned char *)__port2addr_ata(port) = b;
+	} else
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
@@ -258,12 +310,16 @@ void _outw_p(unsigned short w, unsigned 
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
+#if defined(CONFIG_IDE)
+	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		*(volatile unsigned short *)__port2addr_ata(port) = w;
+	} else
+#endif
 #if defined(CONFIG_USB)
 	  if(port >= 0x340 && port < 0x3a0)
 	    *(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
-
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
@@ -284,6 +340,13 @@ void _insb(unsigned int port, void * add
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
+#if defined(CONFIG_IDE)
+	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		unsigned char *buf = addr;
+		unsigned char *portp = __port2addr_ata(port);
+		while(count--) *buf++ = *(volatile unsigned char *)portp;
+	}
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
@@ -312,6 +375,11 @@ void _insw(unsigned int port, void * add
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
 #endif
+#if defined(CONFIG_IDE)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while (count--) *buf++ = *(volatile unsigned short *)portp;
+#endif
 	} else {
 		portp = PORT2ADDR(port);
 		while (count--) *buf++ = *(volatile unsigned short *)portp;
@@ -335,6 +403,11 @@ void _outsb(unsigned int port, const voi
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) _ne_outb(*buf++, portp);
+#if defined(CONFIG_IDE)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while(count--) *(volatile unsigned char *)portp = *buf++;
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_byte(0, port, (void *)addr, sizeof(unsigned char), count, 1);
@@ -357,6 +430,11 @@ void _outsw(unsigned int port, const voi
 		 */
 		portp = PORT2ADDR_NE(port);
 		while(count--) *(volatile unsigned short *)portp = *buf++;
+#if defined(CONFIG_IDE)
+	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
+		portp = __port2addr_ata(port);
+		while(count--) *(volatile unsigned short *)portp = *buf++;
+#endif
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/setup.c linux-2.6.7/arch/m32r/kernel/setup.c
--- linux-2.6.7_20040819/arch/m32r/kernel/setup.c	2004-08-04 10:55:09.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/setup.c	2004-08-24 15:16:14.000000000 +0900
@@ -32,7 +32,6 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 
-extern void init_IRQ(void);
 #ifdef CONFIG_MMU
 extern void init_mmu(void);
 #endif
@@ -93,16 +92,8 @@ static __inline__ void parse_mem_cmdline
 	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
-	/*
-	 * Due to prefetching and similar mechanism the CPU sometimes
-	 * generates addresses beyond the end of memory.  We leave the size
-	 * of one cache line at the end of memory unused to make shure we
-	 * don't catch this type of bus errors.
-	 */
 	memory_start = (unsigned long)CONFIG_MEMORY_START+PAGE_OFFSET;
 	memory_end = memory_start+(unsigned long)CONFIG_MEMORY_SIZE;
-	memory_end -= 128;
-	memory_end &= PAGE_MASK;
 
 	for ( ; ; ) {
 		if (c == ' ' && !memcmp(from, "mem=", 4)) {
@@ -268,8 +259,6 @@ void __init setup_arch(char **cmdline_p)
 	setup_memory();
 
 	paging_init();
-
-	init_IRQ();
 }
 
 #ifdef CONFIG_PROC_FS
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/setup_m32700ut.c linux-2.6.7/arch/m32r/kernel/setup_m32700ut.c
--- linux-2.6.7_20040819/arch/m32r/kernel/setup_m32700ut.c	2004-01-27 10:58:04.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/setup_m32700ut.c	2004-08-23 20:53:31.000000000 +0900
@@ -381,7 +381,6 @@ void __init init_IRQ(void)
 	disable_m32700ut_pld_irq(PLD_IRQ_SIO0_SND);
 #endif  /* CONFIG_SERIAL_M32R_PLDSIO */
 
-#if defined(CONFIG_M32R_CFC)
 	/* INT#1: CFC IREQ on PLD */
 	irq_desc[PLD_IRQ_CFIREQ].status = IRQ_DISABLED;
 	irq_desc[PLD_IRQ_CFIREQ].handler = &m32700ut_pld_irq_type;
@@ -405,8 +404,6 @@ void __init init_IRQ(void)
 	irq_desc[PLD_IRQ_CFC_EJECT].depth = 1;	/* disable nested irq */
 	pld_icu_data[irq2pldirq(PLD_IRQ_CFC_EJECT)].icucr = PLD_ICUCR_IEN|PLD_ICUCR_ISMOD02;	/* 'H' edge sense */
 	disable_m32700ut_pld_irq(PLD_IRQ_CFC_EJECT);
-#endif /* CONFIG_M32R_CFC */
-
 
 	/*
 	 * INT0# is used for LAN, DIO
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/traps.c linux-2.6.7/arch/m32r/kernel/traps.c
--- linux-2.6.7_20040819/arch/m32r/kernel/traps.c	2004-05-19 18:53:08.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/traps.c	2004-08-23 20:53:31.000000000 +0900
@@ -30,122 +30,18 @@
 
 #include <linux/module.h>
 
-#if defined(CONFIG_MMU)
-#define PIE_HANDLER "pie_handler"
-#define ACE_HANDLER "ace_handler"
-#define TME_HANDLER "tme_handler"
-#else
-#define PIE_HANDLER "default_eit_handler"
-#define ACE_HANDLER "default_eit_handler"
-#define TME_HANDLER "default_eit_handler"
-#endif
-
 asmlinkage void alignment_check(void);
 asmlinkage void ei_handler(void);
 asmlinkage void rie_handler(void);
 asmlinkage void debug_trap(void);
 asmlinkage void cache_flushing_handler(void);
 
-asm (
-	"	.section .eit_vector,\"ax\"	\n"
-	"	.balign 4			\n"
-	"	.global _RE			\n"
-	"	.global default_eit_handler	\n"
-	"	.global system_call		\n"
-	"	.global " PIE_HANDLER "		\n"
-	"	.global " ACE_HANDLER "		\n"
-	"	.global " TME_HANDLER "		\n"
-	"_RE:	seth	r0, 0x01		\n"
-	"	bra	default_eit_handler	\n"
-	"	.long	0,0			\n"
-	"_SBI:	seth	r0, 0x10		\n"
-	"	bra	default_eit_handler	\n"
-	"	.long	0,0			\n"
-	"_RIE:	bra	rie_handler		\n"
-	"	.long	0,0,0			\n"
-	"_AE:	bra	alignment_check		\n"
-	"	.long	0,0,0			\n"
-	"_TRAP0:				\n"
-	"	bra	_TRAP0			\n"
-	"_TRAP1:				\n"
-	"	bra	debug_trap		\n"
-	"_TRAP2:				\n"
-	"	bra	system_call		\n"
-	"_TRAP3:				\n"
-	"	bra	_TRAP3			\n"
-	"_TRAP4:				\n"
-	"	bra	_TRAP4			\n"
-	"_TRAP5:				\n"
-	"	bra	_TRAP5			\n"
-	"_TRAP6:				\n"
-	"	bra	_TRAP6			\n"
-	"_TRAP7:				\n"
-	"	bra	_TRAP7			\n"
-	"_TRAP8:				\n"
-	"	bra	_TRAP8			\n"
-	"_TRAP9:				\n"
-	"	bra	_TRAP9			\n"
-	"_TRAP10:				\n"
-	"	bra	_TRAP10			\n"
-	"_TRAP11:				\n"
-	"	bra	_TRAP11			\n"
-	"_TRAP12:				\n"
-	"	bra	cache_flushing_handler	\n"
-	"_TRAP13:				\n"
-	"	bra	_TRAP13			\n"
-	"_TRAP14:				\n"
-	"	bra	_TRAP14			\n"
-	"_TRAP15:				\n"
-	"	bra	_TRAP15			\n"
-	"_EI:	bra	ei_handler		\n"
-	"	.long   0,0,0			\n"
-	"	.previous			\n"
-);
-
-asm (
-	"	.section .eit_vector1,\"ax\"	\n"
-	"_BRA_SYSCAL:				\n"
-	"	bra	system_call		\n"
-	"	.long	0,0,0			\n"
-	"	.previous			\n"
-);
-
-asm (
-	"	.section .eit_vector2,\"ax\"	\n"
-	"_PIE:					\n"
-	"	bra	" PIE_HANDLER "		\n"
-	"	.long   0,0,0			\n"
-	"_TLB_ACE:				\n"
-	"	bra	" ACE_HANDLER "		\n"
-	"	.long   0,0,0			\n"
-	"_TLB_MIS:				\n"
-	"	bra	" TME_HANDLER "		\n"
-	"	.long   0,0,0			\n"
-	"	.previous 			\n"
-);
-
 #ifdef CONFIG_SMP
-/* 
- * for IPI
- */
-asm (
-	"	.section .eit_vector3,\"ax\"		\n"
-	"	.global smp_reschedule_interrupt	\n"
-	"	.global smp_invalidate_interrupt	\n"
-	"	.global smp_call_function_interrupt	\n"
-	"	.global smp_ipi_timer_interrupt		\n"
-	"	.global smp_flush_cache_all_interrupt	\n"
-	"	.global _EI_VEC_TABLE			\n"
-	"_EI_VEC_TABLE:					\n"
-	"	.fill 56, 4, 0				\n"
-	"	.long smp_reschedule_interrupt		\n"
-	"	.long smp_invalidate_interrupt		\n"
-	"	.long smp_call_function_interrupt	\n"
-	"	.long smp_ipi_timer_interrupt		\n"
-	"	.long smp_flush_cache_all_interrupt	\n"
-	"	.fill 4, 4, 0				\n"
-	"	.previous				\n"
-);
+extern void smp_reschedule_interrupt(void);
+extern void smp_invalidate_interrupt(void);
+extern void smp_call_function_interrupt(void);
+extern void smp_ipi_timer_interrupt(void);
+extern void smp_flush_cache_all_interrupt(void);
 
 /* 
  * for Boot AP function
@@ -161,7 +57,58 @@ asm (
 );
 #endif  /* CONFIG_SMP */
 
-#define	set_eit_vector_entries(void)	do { } while (0)
+extern unsigned long	eit_vector[];
+#define BRA_INSN(func, entry)	\
+	((unsigned long)func - (unsigned long)eit_vector - entry*4)/4 \
+	+ 0xff000000UL
+
+void	set_eit_vector_entries(void)
+{
+	extern void default_eit_handler(void);
+	extern void system_call(void);
+	extern void pie_handler(void);
+	extern void ace_handler(void);
+	extern void tme_handler(void);
+	extern void _flush_cache_copyback_all(void);
+
+	eit_vector[0] = 0xd0c00001; /* seth r0, 0x01 */
+	eit_vector[1] = BRA_INSN(default_eit_handler, 1);
+	eit_vector[4] = 0xd0c00010; /* seth r0, 0x10 */
+	eit_vector[5] = BRA_INSN(default_eit_handler, 5);
+	eit_vector[8] = BRA_INSN(rie_handler, 8);
+	eit_vector[12] = BRA_INSN(alignment_check, 12);
+	eit_vector[16] = 0xff000000UL;
+	eit_vector[17] = BRA_INSN(debug_trap, 17);
+	eit_vector[18] = BRA_INSN(system_call, 18);
+	eit_vector[19] = 0xff000000UL;
+	eit_vector[20] = 0xff000000UL;
+	eit_vector[21] = 0xff000000UL;
+	eit_vector[22] = 0xff000000UL;
+	eit_vector[23] = 0xff000000UL;
+	eit_vector[24] = 0xff000000UL;
+	eit_vector[25] = 0xff000000UL;
+	eit_vector[26] = 0xff000000UL;
+	eit_vector[27] = 0xff000000UL;
+	eit_vector[28] = BRA_INSN(cache_flushing_handler, 28);
+	eit_vector[29] = 0xff000000UL;
+	eit_vector[30] = 0xff000000UL;
+	eit_vector[31] = 0xff000000UL;
+	eit_vector[32] = BRA_INSN(ei_handler, 32);
+	eit_vector[64] = BRA_INSN(pie_handler, 64);
+	eit_vector[68] = BRA_INSN(ace_handler, 68);
+	eit_vector[72] = BRA_INSN(tme_handler, 72);
+#ifdef CONFIG_SMP
+	eit_vector[184] = (unsigned long)smp_reschedule_interrupt;
+	eit_vector[185] = (unsigned long)smp_invalidate_interrupt;
+	eit_vector[186] = (unsigned long)smp_call_function_interrupt;
+	eit_vector[187] = (unsigned long)smp_ipi_timer_interrupt;
+	eit_vector[188] = (unsigned long)smp_flush_cache_all_interrupt;
+	eit_vector[189] = 0;
+	eit_vector[190] = 0;
+	eit_vector[191] = 0;
+#endif
+	_flush_cache_copyback_all();
+}
 
 void __init trap_init(void)
 {
diff -ruNp linux-2.6.7_20040819/arch/m32r/kernel/vmlinux.lds.S linux-2.6.7/arch/m32r/kernel/vmlinux.lds.S
--- linux-2.6.7_20040819/arch/m32r/kernel/vmlinux.lds.S	2004-07-27 15:54:20.000000000 +0900
+++ linux-2.6.7/arch/m32r/kernel/vmlinux.lds.S	2004-08-23 20:53:31.000000000 +0900
@@ -15,30 +15,15 @@ ENTRY(startup_32)
 #endif
 SECTIONS
 {
-#if defined(CONFIG_PLAT_MAPPI) || defined(CONFIG_PLAT_USRV) \
-	|| defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_OAKS32R) \
-	|| defined(CONFIG_PLAT_MAPPI2) || defined(CONFIG_PLAT_OPSPUT)
-  . = CONFIG_MEMORY_START + __PAGE_OFFSET + 0x00000000;
-  .eit_vector : { *(.eit_vector) }
-  . = CONFIG_MEMORY_START + __PAGE_OFFSET + 0x00000100;
-  .eit_vector2 : { *(.eit_vector2) }
-#if defined(CONFIG_SMP)
-  . = CONFIG_MEMORY_START + __PAGE_OFFSET + 0x00000200;
-  .eit_vector3 : { *(.eit_vector3) }
-#endif
-  . = CONFIG_MEMORY_START + __PAGE_OFFSET + 0x00001000;
-#else
-#error "Unknown platform"
-#endif
-
-  _boot = .;
-  .boot : { *(.boot) } = 0
+  . = CONFIG_MEMORY_START + __PAGE_OFFSET;
+  eit_vector = .;
 
-  . = ALIGN(4096);
+  . = . + 0x1000;
   .empty_zero_page : { *(.empty_zero_page) } = 0
 
   /* read-only */
   _text = .;			/* Text and read-only data */
+  .boot : { *(.boot) } = 0
   .text : {
 	*(.text)
 	SCHED_TEXT
diff -ruNp linux-2.6.7_20040819/include/asm-m32r/ide.h linux-2.6.7/include/asm-m32r/ide.h
--- linux-2.6.7_20040819/include/asm-m32r/ide.h	2004-07-15 13:43:17.000000000 +0900
+++ linux-2.6.7/include/asm-m32r/ide.h	2004-08-23 20:53:30.000000000 +0900
@@ -25,11 +25,21 @@
 # endif
 #endif
 
+#if defined(CONFIG_PLAT_M32700UT)
+#include <asm/irq.h>
+#include <asm/m32700ut/m32700ut_pld.h>
+#endif
+
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
+#if defined(CONFIG_PLAT_M32700UT)
+		case 0x1f0: return PLD_IRQ_CFIREQ;
+		default:
+			return 0;
+#else
 		case 0x1f0: return 14;
 		case 0x170: return 15;
 		case 0x1e8: return 11;
@@ -38,6 +48,7 @@ static __inline__ int ide_default_irq(un
 		case 0x160: return 12;
 		default:
 			return 0;
+#endif
 	}
 }
 
diff -ruNp linux-2.6.7_20040819/include/asm-m32r/types.h linux-2.6.7/include/asm-m32r/types.h
--- linux-2.6.7_20040819/include/asm-m32r/types.h	2004-07-15 13:43:17.000000000 +0900
+++ linux-2.6.7/include/asm-m32r/types.h	2004-08-23 18:25:13.000000000 +0900
@@ -1,6 +1,8 @@
 #ifndef _ASM_M32R_TYPES_H
 #define _ASM_M32R_TYPES_H
 
+#ifndef __ASSEMBLY__
+
 /* $Id$ */
 
 /* orig : i386 2.4.18 */
@@ -25,12 +27,17 @@ typedef unsigned int __u32;
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
+#endif /* __ASSEMBLY__ */
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
  */
 #ifdef __KERNEL__
 
+#define BITS_PER_LONG 32
+
+#ifndef __ASSEMBLY__
+
 typedef signed char s8;
 typedef unsigned char u8;
 
@@ -43,8 +50,6 @@ typedef unsigned int u32;
 typedef signed long long s64;
 typedef unsigned long long u64;
 
-#define BITS_PER_LONG 32
-
 /* DMA addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
@@ -52,6 +57,8 @@ typedef u64 dma64_addr_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* __KERNEL__ */
 
 #endif  /* _ASM_M32R_TYPES_H */
diff -ruNp linux-2.6.7_20040819/include/asm-m32r/uaccess.h linux-2.6.7/include/asm-m32r/uaccess.h
--- linux-2.6.7_20040819/include/asm-m32r/uaccess.h	2004-07-15 13:43:17.000000000 +0900
+++ linux-2.6.7/include/asm-m32r/uaccess.h	2004-08-24 12:22:53.000000000 +0900
@@ -254,14 +254,14 @@ struct __large_struct { unsigned long bu
 #define __put_user_u64(x, addr, err)                                    \
         __asm__ __volatile__(                                           \
                 "       .fillinsn\n"                                    \
-                "1:     st %2,@%3\n"                                    \
+                "1:     st %L1,@%2\n"                                    \
                 "       .fillinsn\n"                                    \
-                "2:     st %1,@(4,%3)\n"                                \
+                "2:     st %H1,@(4,%2)\n"                                \
                 "       .fillinsn\n"                                    \
                 "3:\n"                                                  \
                 ".section .fixup,\"ax\"\n"                              \
                 "       .balign 4\n"                                    \
-                "4:     ldi %0,%4\n"                                    \
+                "4:     ldi %0,%3\n"                                    \
                 "       seth r14,#high(3b)\n"                           \
                 "       or3 r14,r14,#low(3b)\n"                         \
                 "       jmp r14\n"                                      \
@@ -272,23 +272,21 @@ struct __large_struct { unsigned long bu
                 "       .long 2b,4b\n"                                  \
                 ".previous"                                             \
                 : "=r"(err)                                             \
-                : "r"((unsigned long)((unsigned long long)x >> 32)),    \
-                  "r"((unsigned long)x ),                               \
-                  "r"(addr), "i"(-EFAULT), "0"(err)                     \
+                : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
                 : "r14", "memory")
 
 #elif defined(__BIG_ENDIAN__)
 #define __put_user_u64(x, addr, err)					\
 	__asm__ __volatile__(						\
 		"	.fillinsn\n"					\
-		"1:	st %1,@%3\n"					\
+		"1:	st %H1,@%2\n"					\
 		"	.fillinsn\n"					\
-		"2:	st %2,@(4,%3)\n"				\
+		"2:	st %L1,@(4,%2)\n"				\
 		"	.fillinsn\n"					\
 		"3:\n"							\
 		".section .fixup,\"ax\"\n"				\
 		"	.balign 4\n"					\
-		"4:	ldi %0,%4\n"					\
+		"4:	ldi %0,%3\n"					\
 		"	seth r14,#high(3b)\n"				\
 		"	or3 r14,r14,#low(3b)\n"				\
 		"	jmp r14\n"					\
@@ -299,9 +297,7 @@ struct __large_struct { unsigned long bu
 		"	.long 2b,4b\n"					\
 		".previous"						\
 		: "=r"(err)						\
-		: "r"((unsigned long)((unsigned long long)x >> 32)),	\
-		  "r"((unsigned long)x ),				\
-		  "r"(addr), "i"(-EFAULT), "0"(err)			\
+		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
 		: "r14", "memory")
 #else
 #error no endian defined

--
Hirokazu Takata
Linux/M32R Project: http://www.linux-m32r.org/
