Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263836AbTCUUjm>; Fri, 21 Mar 2003 15:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263853AbTCUTEz>; Fri, 21 Mar 2003 14:04:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39300
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263836AbTCUS6r>; Fri, 21 Mar 2003 13:58:47 -0500
Date: Fri, 21 Mar 2003 20:13:58 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212013.h2LKDwfk026334@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: boot code for PC9800 systems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/bootsect.S linux-2.5.65-ac2/arch/i386/boot98/bootsect.S
--- linux-2.5.65/arch/i386/boot98/bootsect.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/bootsect.S	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,397 @@
+/*	
+ *	bootsect.S - boot sector for NEC PC-9800 series
+ *
+ *	Linux/98 project at Kyoto University Microcomputer Club (KMC)
+ *		    FUJITA Norimasa, TAKAI Kousuke  1997-1998
+ *	rewritten by TAKAI Kousuke (as86 -> gas), Nov 1999
+ *
+ * Based on:
+ *	bootsect.S		Copyright (C) 1991, 1992 Linus Torvalds
+ *	modified by Drew Eckhardt
+ *	modified by Bruce Evans (bde)
+ *
+ * bootsect.S is loaded at 0x1FC00 or 0x1FE00 by the bios-startup routines,
+ * and moves itself out of the way to address 0x90000, and jumps there.
+ *
+ * It then loads 'setup' directly after itself (0x90200), and the system
+ * at 0x10000, using BIOS interrupts. 
+ *
+ * NOTE! currently system is at most (8*65536-4096) bytes long. This should 
+ * be no problem, even in the future. I want to keep it simple. This 508 kB
+ * kernel size should be enough, especially as this doesn't contain the
+ * buffer cache as in minix (and especially now that the kernel is 
+ * compressed :-)
+ *
+ * The loader has been made as simple as possible, and continuous
+ * read errors will result in a unbreakable loop. Reboot by hand. It
+ * loads pretty fast by getting whole tracks at a time whenever possible.
+ */
+
+#include <linux/config.h>		/* for CONFIG_ROOT_RDONLY */
+#include <asm/boot.h>
+
+SETUPSECTS	= 4			/* default nr of setup-sectors */
+BOOTSEG		= 0x1FC0		/* original address of boot-sector */
+INITSEG		= DEF_INITSEG		/* we move boot here - out of the way */
+SETUPSEG	= DEF_SETUPSEG		/* setup starts here */
+SYSSEG		= DEF_SYSSEG		/* system loaded at 0x10000 (65536) */
+SYSSIZE		= DEF_SYSSIZE		/* system size: # of 16-byte clicks */
+					/* to be loaded */
+ROOT_DEV	= 0 			/* ROOT_DEV is now written by "build" */
+SWAP_DEV	= 0			/* SWAP_DEV is now written by "build" */
+
+#ifndef SVGA_MODE
+#define SVGA_MODE ASK_VGA
+#endif
+
+#ifndef RAMDISK
+#define RAMDISK 0
+#endif 
+
+#ifndef ROOT_RDONLY
+#define ROOT_RDONLY 1
+#endif
+
+/* normal/hireso text VRAM segments */
+#define NORMAL_TEXT	0xa000
+#define HIRESO_TEXT	0xe000
+
+/* bios work area addresses */
+#define EXPMMSZ		0x0401
+#define BIOS_FLAG	0x0501
+#define	DISK_BOOT	0x0584
+
+.code16
+.text
+
+.global _start
+_start:
+
+#if 0 /* hook for debugger, harmless unless BIOS is fussy (old HP) */
+	int	$0x3
+#endif
+	jmp	real_start
+	.ascii	"Linux 98"
+	.word	0
+real_start:
+	xorw	%di, %di		/* %di = 0 */
+	movw	%di, %ss		/* %ss = 0 */
+	movw	$0x03F0, %sp
+	pushw	%cx			/* for hint */
+
+	movw	$0x0A00, %ax		/* normal mode defaults (80x25) */
+
+	testb	$0x08, %ss:BIOS_FLAG	/* check hi-reso bit */
+	jnz	set_crt_mode
+/*
+ * Hi-Reso (high-resolution) machine.
+ *
+ * Some hi-reso machines have no RAMs on bank 8/A (0x080000 - 0x0BFFFF).
+ * On such machines we get two RAM banks from top of protect menory and
+ * map them on bank 8/A.
+ * These work-around must be done before moving myself on INITSEG (0x090000-).
+ */
+	movw	$(HIRESO_TEXT >> 8), %cs:(vram + 1)	/* text VRAM segment */
+
+	/* set memory window */
+	movb	$0x08, %al
+	outb	%al, $0x91		/* map native RAM (if any) */
+	movb	$0x0A, %al
+	outb	%al, $0x93
+
+	/* check bank ram A */
+	pushw	$0xA500
+	popw	%ds
+	movw	(%di), %cx		/* %si == 0 from entry */
+	notw	%cx
+	movw	%cx, (%di)
+
+	movw	$0x43F, %dx		/* cache flush for 486 and up. */
+	movb	$0xA0, %al
+	outb	%al, %dx
+	
+	cmpw	%cx, (%di)
+	je	hireso_done
+
+	/* 
+	 * Write test failed; we have no native RAM on 080000h - 0BFFFFh.
+	 * Take 256KB of RAM from top of protected memory.
+	 */
+	movb	%ss:EXPMMSZ, %al
+	subb	$2, %al			/* reduce 2 x 128KB */
+	movb	%al, %ss:EXPMMSZ
+	addb	%al, %al
+	addb	$0x10, %al
+	outb	%al, $0x91
+	addb	$2, %al
+	outb	%al, $0x93
+
+hireso_done:
+	movb	$0x10, %al		/* CRT mode 80x31, %ah still 0Ah */
+
+set_crt_mode:
+	int	$0x18			/* set CRT mode */
+
+	movb	$0x0C, %ah		/* turn on text displaying */
+	int	$0x18
+
+	xorw	%dx, %dx		/* position cursor to home */
+	movb	$0x13, %ah
+	int	$0x18
+
+	movb	$0x11, %ah		/* turn cursor displaying on */
+	int	$0x18
+
+	/* move 1 kilobytes from [BOOTSEG:0000h] to [INITSEG:0000h] */
+	cld
+	xorw	%si, %si
+	pushw	$INITSEG
+	popw	%es
+	movw	$512, %cx		/* %di == 0 from entry */
+	rep
+	cs
+	movsw
+
+	ljmp	$INITSEG, $go
+
+go:
+	pushw	%cs
+	popw	%ds		/* %ds = %cs */
+
+	popw	%dx		/* %dh = saved %ch passed from BIOS */
+	movb	%ss:DISK_BOOT, %al
+	andb	$0xf0, %al	/* %al = Device Address */
+	movb	$18, %ch	/* 18 secs/track,  512 b/sec (1440 KB) */
+	cmpb	$0x30, %al
+	je	try512
+	cmpb	$0x90, %al	/* 1 MB I/F, 1 MB floppy */
+	je	try1.2M
+	cmpb	$0xf0, %al	/* 640 KB I/F, 1 MB floppy */
+	je	try1.2M
+	movb	$9, %ch		/*  9 secs/track,  512 b/sec ( 720 KB) */
+	cmpb	$0x10, %al	/* 1 MB I/F, 640 KB floppy */
+	je	try512
+	cmpb	$0x70, %al	/* 640 KB I/F, 640 KB floppy */
+	jne	error		/* unknown device? */
+
+	/* XXX: Does it make sense to support 8 secs/track, 512 b/sec 
+		(640 KB) floppy? */
+
+try512:	movb	$2, %cl		/* 512 b/sec */
+lasttry:call	tryload
+/*
+ * Display error message and halt
+ */
+error:	movw	$error_msg, %si
+	call	print
+wait_reboot:
+	movb	$0x0, %ah
+	int	$0x18			/* wait keyboard input */
+1:	movb	$0, %al
+	outb	%al, $0xF0		/* reset CPU */
+	jmp	1b			/* just in case... */
+
+try1.2M:cmpb	$2, %dh
+	je	try2HC
+	movw	$0x0803, %cx	/*  8 secs/track, 1024 b/sec (1232 KB) */
+	call	tryload
+	movb	$15, %ch	/* 15 secs/track,  512 b/sec (1200 KB) */
+	jmp	try512
+try2HC:	movw	$0x0F02, %cx	/* 15 secs/track,  512 b/sec (1200 KB) */
+	call	tryload
+	movw	$0x0803, %cx	/*  8 secs/track, 1024 b/sec (1232 KB) */
+	jmp	lasttry
+
+/*
+ * Try to load SETUP and SYSTEM provided geometry information in %cx.
+ * This routine *will not* return on successful load...
+ */
+tryload:
+	movw	%cx, sectlen
+	movb	%ss:DISK_BOOT, %al
+	movb	$0x7, %ah		/* recalibrate the drive */
+	int	$0x1b
+	jc	error			/* recalibration should succeed */
+
+	/*
+	 * Load SETUP into memory. It is assumed that SETUP fits into
+	 * first cylinder (2 tracks, 9KB on 2DD, 15-18KB on 2HD).
+	 */
+	movb	$0, %bl
+	movb	setup_sects, %bh
+	incb	%bh
+	shlw	%bx			/* %bx = (setup_sects + 1) * 512 */
+	movw	$128, %bp
+	shlw	%cl, %bp		/* %bp = <sector size> */
+	subw	%bp, %bx		/* length to load */
+	movw	$0x0002, %dx		/* head 0, sector 2 */
+	movb	%cl, %ch		/* `N' for sector address */
+	movb	$0, %cl			/* cylinder 0 */
+	pushw	%cs
+	popw	%es			/* %es = %cs (= INITSEG) */
+	movb	$0xd6, %ah		/* read, multi-track, MFM */
+	int	$0x1b			/* load it! */
+	jc	read_error
+
+	movw	$loading_msg, %si
+	call	print
+
+	movw	$SYSSEG, %ax
+	movw	%ax, %es		/* %es = SYSSEG */
+
+/*
+ * This routine loads the system at address 0x10000, making sure
+ * no 64kB boundaries are crossed. We try to load it as fast as
+ * possible, loading whole tracks whenever we can.
+ *
+ * in:	es - starting address segment (normally 0x1000)
+ */
+	movb	%ch, %cl
+	addb	$7, %cl			/* %cl = log2 <sector_size> */
+	shrw	%cl, %bx		/* %bx = # of phys. sectors in SETUP */
+	addb	%bl, %dl		/* %dl = start sector # of SYSTEM */
+	decb	%dl			/* %dl is 0-based in below loop */
+
+rp_read_newseg:
+	xorw	%bp, %bp		/* = starting address within segment */
+#ifdef __BIG_KERNEL__
+	bootsect_kludge = 0x220		/* 0x200 (size of bootsector) + 0x20 (offset */
+	lcall	*bootsect_kludge	/* of bootsect_kludge in setup.S */
+#else
+	movw	%es, %ax
+	subw	$SYSSEG, %ax
+#endif
+	cmpw	syssize, %ax
+	ja	boot			/* done! */
+
+rp_read:
+	movb	sectors, %al
+	addb	%al, %al
+	movb	%al, %ch		/* # of sectors on both surface */
+	subb	%dl, %al		/* # of sectors left on this track */
+	movb	$0, %ah
+	shlw	%cl, %ax		/* # of bytes left on this track */
+	movw	%ax, %bx		/* transfer length */
+	addw	%bp, %ax		/* cross 64K boundary? */
+	jnc	1f			/* ok. */
+	jz	1f			/* also ok. */
+	/*
+	 * Oops, we are crossing 64K boundary...
+	 * Adjust transfer length to make transfer fit in the boundary.
+	 *
+	 * Note: sector size is assumed to be a measure of 65536.
+	 */
+	xorw	%bx, %bx
+	subw	%bp, %bx
+1:	pushw	%dx
+	movw	$dot_msg, %si		/* give progress message */
+	call	print
+	xchgw	%ax, %dx
+	movb	$0, %ah
+	divb	sectors
+	xchgb	%al, %ah
+	xchgw	%ax, %dx		/* %dh = head # / %dl = sector # */
+	incb	%dl			/* fix %dl to 1-based */
+	pushw	%cx
+	movw	cylinder, %cx
+	movb	$0xd6, %ah		/* read, multi-track, seek, MFM */
+	movb	%ss:DISK_BOOT, %al
+	int	$0x1b
+	popw	%cx
+	popw	%dx
+	jc	read_error
+	movw	%bx, %ax		/* # of bytes just read */
+	shrw	%cl, %ax		/* %ax = # of sectors just read */
+	addb	%al, %dl		/* advance sector # */
+	cmpb	%ch, %dl		/* %ch = # of sectors/cylinder */
+	jb	2f
+	incb	cylinder		/* next cylinder */
+	xorb	%dl, %dl		/* sector 0 */
+2:	addw	%bx, %bp		/* advance offset pointer */
+	jnc	rp_read
+	/* offset pointer wrapped; advance segment pointer. */
+	movw	%es, %ax
+	addw	$0x1000, %ax
+	movw	%ax, %es
+	jmp	rp_read_newseg
+
+read_error:
+	ret
+
+boot:	movw	%cs, %ax		/* = INITSEG */
+	/* movw	%ax, %ds */
+	movw	%ax, %ss
+	movw	$0x4000, %sp		/* 0x4000 is arbitrary value >=
+					 * length of bootsect + length of
+					 * setup + room for stack;
+					 * PC-9800 never have BIOS workareas
+					 * on high memory.
+					 */
+/*
+ * After that we check which root-device to use. If the device is
+ * not defined, /dev/fd0 (2, 0) will be used.
+ */
+	cmpw	$0, root_dev
+	jne	3f
+	movb	$2, root_dev+1
+3:
+
+/*
+ * After that (everything loaded), we jump to the setup-routine
+ * loaded directly after the bootblock:
+ */
+	ljmp	$SETUPSEG, $0
+
+/*
+ * Subroutine for print string on console.
+ *	%cs:%si	- pointer to message
+ */
+print:
+	pushaw
+	pushw	%ds
+	pushw	%es
+	pushw	%cs
+	popw	%ds
+	lesw	curpos, %di		/* %es:%di = current text VRAM addr. */
+1:	xorw	%ax, %ax
+	lodsb
+	testb	%al, %al
+	jz	2f			/* end of string */
+	stosw					/* character code */
+	movb	$0xE1, %es:0x2000-2(%di)	/* character attribute */
+	jmp	1b
+2:	movw	%di, %dx
+	movb	$0x13, %ah
+	int	$0x18			/* move cursor to current point */
+	popw	%es
+	popw	%ds
+	popaw
+	ret
+
+loading_msg:
+	.string	"Loading"
+dot_msg:
+	.string	"."
+error_msg:
+	.string	"Read Error!"
+
+	.org	490
+
+curpos:	.word	160		/* current cursor position */
+vram:	.word	NORMAL_TEXT	/* text VRAM segment */
+
+cylinder:	.byte	0	/* current cylinder (lower byte)	*/
+sectlen:	.byte	0	/* (log2 of <sector size>) - 7		*/
+sectors:	.byte	0x0F	/* default is 2HD (15 sector/track)	*/
+
+# XXX: This is a fairly snug fit.
+
+.org 497
+setup_sects:	.byte SETUPSECTS
+root_flags:	.word ROOT_RDONLY
+syssize:	.word SYSSIZE
+swap_dev:	.word SWAP_DEV
+ram_size:	.word RAMDISK
+vid_mode:	.word SVGA_MODE
+root_dev:	.word ROOT_DEV
+boot_flag:	.word 0xAA55
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/compressed/head.S linux-2.5.65-ac2/arch/i386/boot98/compressed/head.S
--- linux-2.5.65/arch/i386/boot98/compressed/head.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/compressed/head.S	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,128 @@
+/*
+ *  linux/boot/head.S
+ *
+ *  Copyright (C) 1991, 1992, 1993  Linus Torvalds
+ */
+
+/*
+ *  head.S contains the 32-bit startup code.
+ *
+ * NOTE!!! Startup happens at absolute address 0x00001000, which is also where
+ * the page directory will exist. The startup code will be overwritten by
+ * the page directory. [According to comments etc elsewhere on a compressed
+ * kernel it will end up at 0x1000 + 1Mb I hope so as I assume this. - AC]
+ *
+ * Page 0 is deliberately kept safe, since System Management Mode code in 
+ * laptops may need to access the BIOS data stored there.  This is also
+ * useful for future device drivers that either access the BIOS via VM86 
+ * mode.
+ */
+
+/*
+ * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+ */
+.text
+
+#include <linux/linkage.h>
+#include <asm/segment.h>
+
+	.globl startup_32
+	
+startup_32:
+	cld
+	cli
+	movl $(__BOOT_DS),%eax
+	movl %eax,%ds
+	movl %eax,%es
+	movl %eax,%fs
+	movl %eax,%gs
+
+	lss stack_start,%esp
+	xorl %eax,%eax
+1:	incl %eax		# check that A20 really IS enabled
+	movl %eax,0x000000	# loop forever if it isn't
+	cmpl %eax,0x100000
+	je 1b
+
+/*
+ * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
+ * confuse the debugger if this code is traced.
+ * XXX - best to initialize before switching to protected mode.
+ */
+	pushl $0
+	popfl
+/*
+ * Clear BSS
+ */
+	xorl %eax,%eax
+	movl $_edata,%edi
+	movl $_end,%ecx
+	subl %edi,%ecx
+	cld
+	rep
+	stosb
+/*
+ * Do the decompression, and jump to the new kernel..
+ */
+	subl $16,%esp	# place for structure on the stack
+	movl %esp,%eax
+	pushl %esi	# real mode pointer as second arg
+	pushl %eax	# address of structure as first arg
+	call decompress_kernel
+	orl  %eax,%eax 
+	jnz  3f
+	popl %esi	# discard address
+	popl %esi	# real mode pointer
+	xorl %ebx,%ebx
+	ljmp $(__BOOT_CS), $0x100000
+
+/*
+ * We come here, if we were loaded high.
+ * We need to move the move-in-place routine down to 0x1000
+ * and then start it with the buffer addresses in registers,
+ * which we got from the stack.
+ */
+3:
+	movl $move_routine_start,%esi
+	movl $0x1000,%edi
+	movl $move_routine_end,%ecx
+	subl %esi,%ecx
+	addl $3,%ecx
+	shrl $2,%ecx
+	cld
+	rep
+	movsl
+
+	popl %esi	# discard the address
+	popl %ebx	# real mode pointer
+	popl %esi	# low_buffer_start
+	popl %ecx	# lcount
+	popl %edx	# high_buffer_start
+	popl %eax	# hcount
+	movl $0x100000,%edi
+	cli		# make sure we don't get interrupted
+	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
+
+/*
+ * Routine (template) for moving the decompressed kernel in place,
+ * if we were high loaded. This _must_ PIC-code !
+ */
+move_routine_start:
+	movl %ecx,%ebp
+	shrl $2,%ecx
+	rep
+	movsl
+	movl %ebp,%ecx
+	andl $3,%ecx
+	rep
+	movsb
+	movl %edx,%esi
+	movl %eax,%ecx	# NOTE: rep movsb won't move if %ecx == 0
+	addl $3,%ecx
+	shrl $2,%ecx
+	rep
+	movsl
+	movl %ebx,%esi	# Restore setup pointer
+	xorl %ebx,%ebx
+	ljmp $(__BOOT_CS), $0x100000
+move_routine_end:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/compressed/Makefile linux-2.5.65-ac2/arch/i386/boot98/compressed/Makefile
--- linux-2.5.65/arch/i386/boot98/compressed/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/compressed/Makefile	2003-02-20 16:28:06.000000000 +0000
@@ -0,0 +1,25 @@
+#
+# linux/arch/i386/boot/compressed/Makefile
+#
+# create a compressed vmlinux image from the original vmlinux
+#
+
+EXTRA_TARGETS	:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+EXTRA_AFLAGS	:= -traditional
+
+LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
+
+$(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
+	$(call if_changed,ld)
+	@:
+
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T
+
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,ld)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/compressed/misc.c linux-2.5.65-ac2/arch/i386/boot98/compressed/misc.c
--- linux-2.5.65/arch/i386/boot98/compressed/misc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/compressed/misc.c	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,379 @@
+/*
+ * misc.c
+ * 
+ * This is a collection of several routines from gzip-1.0.3 
+ * adapted for Linux.
+ *
+ * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ * puts by Nick Holloway 1993, better puts by Martin Mares 1995
+ * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+ */
+
+#include <linux/linkage.h>
+#include <linux/vmalloc.h>
+#include <linux/tty.h>
+#include <asm/io.h>
+#ifdef STANDARD_MEMORY_BIOS_CALL
+#undef STANDARD_MEMORY_BIOS_CALL
+#endif
+
+/*
+ * gzip declarations
+ */
+
+#define OF(args)  args
+#define STATIC static
+
+#undef memset
+#undef memcpy
+
+/*
+ * Why do we do this? Don't ask me..
+ *
+ * Incomprehensible are the ways of bootloaders.
+ */
+static void* memset(void *, int, size_t);
+static void* memcpy(void *, __const void *, size_t);
+#define memzero(s, n)     memset ((s), 0, (n))
+
+typedef unsigned char  uch;
+typedef unsigned short ush;
+typedef unsigned long  ulg;
+
+#define WSIZE 0x8000		/* Window size must be at least 32k, */
+				/* and a power of two */
+
+static uch *inbuf;	     /* input buffer */
+static uch window[WSIZE];    /* Sliding window buffer */
+
+static unsigned insize = 0;  /* valid bytes in inbuf */
+static unsigned inptr = 0;   /* index of next byte to be processed in inbuf */
+static unsigned outcnt = 0;  /* bytes in output buffer */
+
+/* gzip flag byte */
+#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
+#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
+#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
+#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
+#define COMMENT      0x10 /* bit 4 set: file comment present */
+#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
+#define RESERVED     0xC0 /* bit 6,7:   reserved */
+
+#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
+		
+/* Diagnostic functions */
+#ifdef DEBUG
+#  define Assert(cond,msg) {if(!(cond)) error(msg);}
+#  define Trace(x) fprintf x
+#  define Tracev(x) {if (verbose) fprintf x ;}
+#  define Tracevv(x) {if (verbose>1) fprintf x ;}
+#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
+#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
+#else
+#  define Assert(cond,msg)
+#  define Trace(x)
+#  define Tracev(x)
+#  define Tracevv(x)
+#  define Tracec(c,x)
+#  define Tracecv(c,x)
+#endif
+
+static int  fill_inbuf(void);
+static void flush_window(void);
+static void error(char *m);
+static void gzip_mark(void **);
+static void gzip_release(void **);
+  
+/*
+ * This is set up by the setup-routine at boot-time
+ */
+static unsigned char *real_mode; /* Pointer to real-mode data */
+
+#define EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
+#ifndef STANDARD_MEMORY_BIOS_CALL
+#define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
+#endif
+#define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+
+extern char input_data[];
+extern int input_len;
+
+static long bytes_out = 0;
+static uch *output_data;
+static unsigned long output_ptr = 0;
+
+static void *malloc(int size);
+static void free(void *where);
+
+static void puts(const char *);
+
+extern int end;
+static long free_mem_ptr = (long)&end;
+static long free_mem_end_ptr;
+
+#define INPLACE_MOVE_ROUTINE  0x1000
+#define LOW_BUFFER_START      0x2000
+#define LOW_BUFFER_MAX       0x90000
+#define HEAP_SIZE             0x3000
+static unsigned int low_buffer_end, low_buffer_size;
+static int high_loaded =0;
+static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
+
+static char *vidmem = (char *)0xa0000;
+static int lines, cols;
+
+#ifdef CONFIG_X86_NUMAQ
+static void * xquad_portio = NULL;
+#endif
+
+#include "../../../../lib/inflate.c"
+
+static void *malloc(int size)
+{
+	void *p;
+
+	if (size <0) error("Malloc error\n");
+	if (free_mem_ptr <= 0) error("Memory error\n");
+
+	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
+
+	p = (void *)free_mem_ptr;
+	free_mem_ptr += size;
+
+	if (free_mem_ptr >= free_mem_end_ptr)
+		error("\nOut of memory\n");
+
+	return p;
+}
+
+static void free(void *where)
+{	/* Don't care */
+}
+
+static void gzip_mark(void **ptr)
+{
+	*ptr = (void *) free_mem_ptr;
+}
+
+static void gzip_release(void **ptr)
+{
+	free_mem_ptr = (long) *ptr;
+}
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
+static void puts(const char *s)
+{
+	int x,y,pos;
+	char c;
+
+	x = SCREEN_INFO.orig_x;
+	y = SCREEN_INFO.orig_y;
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
+	SCREEN_INFO.orig_x = x;
+	SCREEN_INFO.orig_y = y;
+
+	pos = x + cols * y;	/* Update cursor position */
+	while (!(inb_p(0x60) & 4));
+	outb_p(0x49, 0x62);
+	outb_p(pos & 0xff, 0x60);
+	outb_p((pos >> 8) & 0xff, 0x60);
+}
+
+static void* memset(void* s, int c, size_t n)
+{
+	int i;
+	char *ss = (char*)s;
+
+	for (i=0;i<n;i++) ss[i] = c;
+	return s;
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
+/* ===========================================================================
+ * Fill the input buffer. This is called only when the buffer is empty
+ * and at least one byte is really needed.
+ */
+static int fill_inbuf(void)
+{
+	if (insize != 0) {
+		error("ran out of input data\n");
+	}
+
+	inbuf = input_data;
+	insize = input_len;
+	inptr = 1;
+	return inbuf[0];
+}
+
+/* ===========================================================================
+ * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * (Used for the decompressed data only.)
+ */
+static void flush_window_low(void)
+{
+    ulg c = crc;         /* temporary variable */
+    unsigned n;
+    uch *in, *out, ch;
+    
+    in = window;
+    out = &output_data[output_ptr]; 
+    for (n = 0; n < outcnt; n++) {
+	    ch = *out++ = *in++;
+	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
+    }
+    crc = c;
+    bytes_out += (ulg)outcnt;
+    output_ptr += (ulg)outcnt;
+    outcnt = 0;
+}
+
+static void flush_window_high(void)
+{
+    ulg c = crc;         /* temporary variable */
+    unsigned n;
+    uch *in,  ch;
+    in = window;
+    for (n = 0; n < outcnt; n++) {
+	ch = *output_data++ = *in++;
+	if ((ulg)output_data == low_buffer_end) output_data=high_buffer_start;
+	c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
+    }
+    crc = c;
+    bytes_out += (ulg)outcnt;
+    outcnt = 0;
+}
+
+static void flush_window(void)
+{
+	if (high_loaded) flush_window_high();
+	else flush_window_low();
+}
+
+static void error(char *x)
+{
+	puts("\n\n");
+	puts(x);
+	puts("\n\n -- System halted");
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
+	if (EXT_MEM_K < 1024) error("Less than 2MB of memory.\n");
+#else
+	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < 1024) error("Less than 2MB of memory.\n");
+#endif
+	output_data = (char *)0x100000; /* Points to 1M */
+	free_mem_end_ptr = (long)real_mode;
+}
+
+struct moveparams {
+	uch *low_buffer_start;  int lcount;
+	uch *high_buffer_start; int hcount;
+};
+
+static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
+{
+	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
+#ifdef STANDARD_MEMORY_BIOS_CALL
+	if (EXT_MEM_K < (3*1024)) error("Less than 4MB of memory.\n");
+#else
+	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory.\n");
+#endif	
+	mv->low_buffer_start = output_data = (char *)LOW_BUFFER_START;
+	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
+	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
+	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
+	high_loaded = 1;
+	free_mem_end_ptr = (long)high_buffer_start;
+	if ( (0x100000 + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(0x100000 + low_buffer_size);
+		mv->hcount = 0; /* say: we need not to move high_buffer */
+	}
+	else mv->hcount = -1;
+	mv->high_buffer_start = high_buffer_start;
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
+
+asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+{
+	real_mode = rmode;
+
+	vidmem = (char *)(((unsigned int)SCREEN_INFO.orig_video_page) << 4);
+
+	lines = SCREEN_INFO.orig_video_lines;
+	cols = SCREEN_INFO.orig_video_cols;
+
+	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
+	else setup_output_buffer_if_we_run_high(mv);
+
+	makecrc();
+	puts("Uncompressing Linux... ");
+	gunzip();
+	puts("Ok, booting the kernel.\n");
+	if (high_loaded) close_output_buffer_if_we_run_high(mv);
+	return high_loaded;
+}
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/compressed/vmlinux.scr linux-2.5.65-ac2/arch/i386/boot98/compressed/vmlinux.scr
--- linux-2.5.65/arch/i386/boot98/compressed/vmlinux.scr	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/compressed/vmlinux.scr	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,9 @@
+SECTIONS
+{
+  .data : { 
+	input_len = .;
+	LONG(input_data_end - input_data) input_data = .; 
+	*(.data) 
+	input_data_end = .; 
+	}
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/install.sh linux-2.5.65-ac2/arch/i386/boot98/install.sh
--- linux-2.5.65/arch/i386/boot98/install.sh	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/install.sh	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# arch/i386/boot/install.sh
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+#
+# "make install" script for i386 architecture
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+#
+
+# User may have a custom install script
+
+if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
+if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+
+# Default install - same as make zlilo
+
+if [ -f $4/vmlinuz ]; then
+	mv $4/vmlinuz $4/vmlinuz.old
+fi
+
+if [ -f $4/System.map ]; then
+	mv $4/System.map $4/System.old
+fi
+
+cat $2 > $4/vmlinuz
+cp $3 $4/System.map
+
+if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/Makefile linux-2.5.65-ac2/arch/i386/boot98/Makefile
--- linux-2.5.65/arch/i386/boot98/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/Makefile	2003-03-14 01:03:19.000000000 +0000
@@ -0,0 +1,76 @@
+#
+# arch/i386/boot/Makefile
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1994 by Linus Torvalds
+#
+
+# ROOT_DEV specifies the default root-device when making the image.
+# This can be either FLOPPY, CURRENT, /dev/xxxx or empty, in which case
+# the default of FLOPPY is used by 'build'.
+
+ROOT_DEV := CURRENT
+
+# If you want to preset the SVGA mode, uncomment the next line and
+# set SVGA_MODE to whatever number you want.
+# Set it to -DSVGA_MODE=NORMAL_VGA if you just want the EGA/VGA mode.
+# The number is the same as you would ordinarily press at bootup.
+
+SVGA_MODE := -DSVGA_MODE=NORMAL_VGA
+
+# If you want the RAM disk device, define this to be the size in blocks.
+
+#RAMDISK := -DRAMDISK=512
+
+EXTRA_TARGETS	:= vmlinux.bin bootsect bootsect.o \
+		   setup setup.o zImage bzImage
+
+subdir- 	:= compressed
+
+host-progs	:= tools/build
+
+# ---------------------------------------------------------------------------
+
+$(obj)/zImage:  IMAGE_OFFSET := 0x1000
+$(obj)/zImage:  EXTRA_AFLAGS := -traditional $(SVGA_MODE) $(RAMDISK)
+$(obj)/bzImage: IMAGE_OFFSET := 0x100000
+$(obj)/bzImage: EXTRA_AFLAGS := -traditional $(SVGA_MODE) $(RAMDISK) -D__BIG_KERNEL__
+$(obj)/bzImage: BUILDFLAGS   := -b
+
+quiet_cmd_image = BUILD   $@
+cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/bootsect $(obj)/setup \
+	    $(obj)/vmlinux.bin $(ROOT_DEV) > $@
+
+$(obj)/zImage $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
+			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
+	$(call if_changed,image)
+	@echo 'Kernel: $@ is ready'
+
+$(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
+	$(call if_changed,objcopy)
+
+LDFLAGS_bootsect := -Ttext 0x0 -s --oformat binary
+LDFLAGS_setup	 := -Ttext 0x0 -s --oformat binary -e begtext
+
+$(obj)/setup $(obj)/bootsect: %: %.o FORCE
+	$(call if_changed,ld)
+
+$(obj)/compressed/vmlinux: FORCE
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
+					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
+
+zdisk: $(BOOTIMAGE)
+	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
+
+zlilo: $(BOOTIMAGE)
+	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
+	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
+	cat $(BOOTIMAGE) > $(INSTALL_PATH)/vmlinuz
+	cp System.map $(INSTALL_PATH)/
+	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
+
+install: $(BOOTIMAGE)
+	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/setup.S linux-2.5.65-ac2/arch/i386/boot98/setup.S
--- linux-2.5.65/arch/i386/boot98/setup.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/setup.S	2003-03-20 18:43:51.000000000 +0000
@@ -0,0 +1,961 @@
+/*
+ *	setup.S		Copyright (C) 1991, 1992 Linus Torvalds
+ *
+ * setup.s is responsible for getting the system data from the BIOS,
+ * and putting them into the appropriate places in system memory.
+ * both setup.s and system has been loaded by the bootblock.
+ *
+ * This code asks the bios for memory/disk/other parameters, and
+ * puts them in a "safe" place: 0x90000-0x901FF, ie where the
+ * boot-block used to be. It is then up to the protected mode
+ * system to read them from there before the area is overwritten
+ * for buffer-blocks.
+ *
+ * Move PS/2 aux init code to psaux.c
+ * (troyer@saifr00.cfsat.Honeywell.COM) 03Oct92
+ *
+ * some changes and additional features by Christoph Niemann,
+ * March 1993/June 1994 (Christoph.Niemann@linux.org)
+ *
+ * add APM BIOS checking by Stephen Rothwell, May 1994
+ * (sfr@canb.auug.org.au)
+ *
+ * High load stuff, initrd support and position independency
+ * by Hans Lermen & Werner Almesberger, February 1996
+ * <lermen@elserv.ffm.fgan.de>, <almesber@lrc.epfl.ch>
+ *
+ * Video handling moved to video.S by Martin Mares, March 1996
+ * <mj@k332.feld.cvut.cz>
+ *
+ * Extended memory detection scheme retwiddled by orc@pell.chi.il.us (david
+ * parsons) to avoid loadlin confusion, July 1997
+ *
+ * Transcribed from Intel (as86) -> AT&T (gas) by Chris Noe, May 1999.
+ * <stiker@northlink.com>
+ *
+ * Fix to work around buggy BIOSes which dont use carry bit correctly
+ * and/or report extended memory in CX/DX for e801h memory size detection 
+ * call.  As a result the kernel got wrong figures.  The int15/e801h docs
+ * from Ralf Brown interrupt list seem to indicate AX/BX should be used
+ * anyway.  So to avoid breaking many machines (presumably there was a reason
+ * to orginally use CX/DX instead of AX/BX), we do a kludge to see
+ * if CX/DX have been changed in the e801 call and if so use AX/BX .
+ * Michael Miller, April 2001 <michaelm@mjmm.org>
+ *
+ * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
+ * by Robert Schwebel, December 2001 <robert@schwebel.de>
+ *
+ * Heavily modified for NEC PC-9800 series by Kyoto University Microcomputer
+ * Club (KMC) Linux/98 project <seraphim@kmc.kyoto-u.ac.jp>, 1997-1999
+ */
+
+#include <linux/config.h>
+#include <asm/segment.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <asm/boot.h>
+#include <asm/e820.h>
+#include <asm/page.h>
+	
+/* Signature words to ensure LILO loaded us right */
+#define SIG1	0xAA55
+#define SIG2	0x5A5A
+
+#define HIRESO_TEXT	0xe000
+#define NORMAL_TEXT	0xa000
+
+#define BIOS_FLAG2	0x0400
+#define BIOS_FLAG5	0x0458
+#define RDISK_EQUIP	0x0488
+#define BIOS_FLAG	0x0501
+#define KB_SHFT_STS	0x053a
+#define DISK_EQUIP	0x055c
+
+INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
+SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
+SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
+				# ... and the former contents of CS
+
+DELTA_INITSEG = SETUPSEG - INITSEG	# 0x0020
+
+.code16
+.globl begtext, begdata, begbss, endtext, enddata, endbss
+
+.text
+begtext:
+.data
+begdata:
+.bss
+begbss:
+.text
+
+start:
+	jmp	trampoline
+
+# This is the setup header, and it must start at %cs:2 (old 0x9020:2)
+
+		.ascii	"HdrS"		# header signature
+		.word	0x0203		# header version number (>= 0x0105)
+					# or else old loadlin-1.5 will fail)
+realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
+start_sys_seg:	.word	SYSSEG
+		.word	kernel_version	# pointing to kernel version string
+					# above section of header is compatible
+					# with loadlin-1.5 (header v1.5). Don't
+					# change it.
+
+type_of_loader:	.byte	0		# = 0, old one (LILO, Loadlin,
+					#      Bootlin, SYSLX, bootsect...)
+					# See Documentation/i386/boot.txt for
+					# assigned ids
+	
+# flags, unused bits must be zero (RFU) bit within loadflags
+loadflags:
+LOADED_HIGH	= 1			# If set, the kernel is loaded high
+CAN_USE_HEAP	= 0x80			# If set, the loader also has set
+					# heap_end_ptr to tell how much
+					# space behind setup.S can be used for
+					# heap purposes.
+					# Only the loader knows what is free
+#ifndef __BIG_KERNEL__
+		.byte	0
+#else
+		.byte	LOADED_HIGH
+#endif
+
+setup_move_size: .word  0x8000		# size to move, when setup is not
+					# loaded at 0x90000. We will move setup 
+					# to 0x90000 then just before jumping
+					# into the kernel. However, only the
+					# loader knows how much data behind
+					# us also needs to be loaded.
+
+code32_start:				# here loaders can put a different
+					# start address for 32-bit code.
+#ifndef __BIG_KERNEL__
+		.long	0x1000		#   0x1000 = default for zImage
+#else
+		.long	0x100000	# 0x100000 = default for big kernel
+#endif
+
+ramdisk_image:	.long	0		# address of loaded ramdisk image
+					# Here the loader puts the 32-bit
+					# address where it loaded the image.
+					# This only will be read by the kernel.
+
+ramdisk_size:	.long	0		# its size in bytes
+
+bootsect_kludge:
+		.word  bootsect_helper, SETUPSEG
+
+heap_end_ptr:	.word	modelist+1024	# (Header version 0x0201 or later)
+					# space from here (exclusive) down to
+					# end of setup code can be used by setup
+					# for local heap purposes.
+
+pad1:		.word	0
+cmd_line_ptr:	.long 0			# (Header version 0x0202 or later)
+					# If nonzero, a 32-bit pointer
+					# to the kernel command line.
+					# The command line should be
+					# located between the start of
+					# setup and the end of low
+					# memory (0xa0000), or it may
+					# get overwritten before it
+					# gets read.  If this field is
+					# used, there is no longer
+					# anything magical about the
+					# 0x90000 segment; the setup
+					# can be located anywhere in
+					# low memory 0x10000 or higher.
+
+ramdisk_max:	.long __MAXMEM-1	# (Header version 0x0203 or later)
+					# The highest safe address for
+					# the contents of an initrd
+
+trampoline:	call	start_of_setup
+		.space	1024
+# End of setup header #####################################################
+
+start_of_setup:
+# Set %ds = %cs, we know that SETUPSEG = %cs at this point
+	movw	%cs, %ax		# aka SETUPSEG
+	movw	%ax, %ds
+# Check signature at end of setup
+	cmpw	$SIG1, setup_sig1
+	jne	bad_sig
+
+	cmpw	$SIG2, setup_sig2
+	jne	bad_sig
+
+	jmp	good_sig1
+
+# Routine to print asciiz string at ds:si
+prtstr:
+	lodsb
+	andb	%al, %al
+	jz	fin
+
+	call	prtchr
+	jmp	prtstr
+
+fin:	ret
+
+no_sig_mess: .string	"No setup signature found ..."
+
+good_sig1:
+	jmp	good_sig
+
+# We now have to find the rest of the setup code/data
+bad_sig:
+	movw	%cs, %ax			# SETUPSEG
+	subw	$DELTA_INITSEG, %ax		# INITSEG
+	movw	%ax, %ds
+	xorb	%bh, %bh
+	movb	(497), %bl			# get setup sect from bootsect
+	subw	$4, %bx				# LILO loads 4 sectors of setup
+	shlw	$8, %bx				# convert to words (1sect=2^8 words)
+	movw	%bx, %cx
+	shrw	$3, %bx				# convert to segment
+	addw	$SYSSEG, %bx
+	movw	%bx, %cs:start_sys_seg
+# Move rest of setup code/data to here
+	movw	$2048, %di			# four sectors loaded by LILO
+	subw	%si, %si
+	pushw	%cs
+	popw	%es
+	movw	$SYSSEG, %ax
+	movw	%ax, %ds
+	rep
+	movsw
+	movw	%cs, %ax			# aka SETUPSEG
+	movw	%ax, %ds
+	cmpw	$SIG1, setup_sig1
+	jne	no_sig
+
+	cmpw	$SIG2, setup_sig2
+	jne	no_sig
+
+	jmp	good_sig
+
+no_sig:
+	lea	no_sig_mess, %si
+	call	prtstr
+
+no_sig_loop:
+	hlt
+	jmp	no_sig_loop
+
+good_sig:
+	movw	%cs, %ax			# aka SETUPSEG
+	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
+	movw	%ax, %ds
+# Check if an old loader tries to load a big-kernel
+	testb	$LOADED_HIGH, %cs:loadflags	# Do we have a big kernel?
+	jz	loader_ok			# No, no danger for old loaders.
+
+	cmpb	$0, %cs:type_of_loader 		# Do we have a loader that
+						# can deal with us?
+	jnz	loader_ok			# Yes, continue.
+
+	pushw	%cs				# No, we have an old loader,
+	popw	%ds				# die. 
+	lea	loader_panic_mess, %si
+	call	prtstr
+
+	jmp	no_sig_loop
+
+loader_panic_mess: .string "Wrong loader, giving up..."
+
+loader_ok:
+# Get memory size (extended mem, kB)
+
+# On PC-9800, memory size detection is done completely in 32-bit
+# kernel initialize code (kernel/setup.c).
+	pushw	%es
+	xorl	%eax, %eax
+	movw	%ax, %es
+	movb	%al, (E820NR)		# PC-9800 has no E820
+	movb	%es:(0x401), %al
+	shll	$7, %eax
+	addw	$1024, %ax
+	movw	%ax, (2)
+	movl	%eax, (0x1e0)
+	movw	%es:(0x594), %ax
+	shll	$10, %eax
+	addl	%eax, (0x1e0)
+	popw	%es
+
+# Check for video adapter and its parameters and allow the
+# user to browse video modes.
+	call	video				# NOTE: we need %ds pointing
+						# to bootsector
+
+# Get text video mode
+	movb	$0x0B, %ah
+	int	$0x18		# CRT mode sense
+	movw	$(20 << 8) + 40, %cx
+	testb	$0x10, %al
+	jnz	3f
+	movb	$20, %ch
+	testb	$0x01, %al
+	jnz	1f
+	movb	$25, %ch
+	jmp	1f
+3:	# If bit 4 was 1, it means either 1) 31 lines for hi-reso mode,
+	# or 2) 30 lines for PC-9821.
+	movb	$31, %ch	# hireso mode value
+	pushw	$0
+	popw	%es
+	testb	$0x08, %es:BIOS_FLAG
+	jnz	1f
+	movb	$30, %ch
+1:	# Now we got # of rows in %ch
+	movb	%ch, (14)
+
+	testb	$0x02, %al
+	jnz	2f
+	movb	$80, %cl
+2:	# Now we got # of columns in %cl
+	movb	%cl, (7)
+
+	# Next, get horizontal frequency if supported
+	movw	$0x3100, %ax
+	int	$0x18		# Call CRT bios
+	movb	%al, (6)	# If 31h is unsupported, %al remains 0
+
+# Get hd0-3 data...
+	pushw	%ds				# aka INITSEG
+	popw	%es
+	xorw	%ax, %ax
+	movw	%ax, %ds
+	cld
+	movw	$0x0080, %di
+	movb	DISK_EQUIP+1, %ah
+	movb	$0x80, %al
+
+get_hd_info:
+	shrb	%ah
+	pushw	%ax
+	jnc	1f
+	movb	$0x84, %ah
+	int	$0x1b
+	jnc	2f				# Success
+1:	xorw	%cx, %cx			# `0 cylinders' means no drive
+2:	# Attention! Work area (drive_info) is arranged for PC-9800.
+	movw	%cx, %ax			# # of cylinders
+	stosw
+	movw	%dx, %ax			# # of sectors / # of heads
+	stosw
+	movw	%bx, %ax			# sector size in bytes
+	stosw
+	popw	%ax
+	incb	%al
+	cmpb	$0x84, %al
+	jb	get_hd_info
+
+# Get fd data...
+	movw	DISK_EQUIP, %ax
+	andw	$0xf00f, %ax
+	orb	%al, %ah
+	movb	RDISK_EQUIP, %al
+	notb	%al
+	andb	%al, %ah			# ignore all `RAM drive'
+
+	movb	$0x30, %al
+
+get_fd_info:
+	shrb	%ah
+	pushw	%ax
+	jnc	1f
+	movb	$0xc4, %ah
+	int	$0x1b
+	movb	%ah, %al
+	andb	$4, %al				# 1.44MB support flag
+	shrb	%al
+	addb	$2, %al				# %al = 2 (1.2MB) or 4 (1.44MB)
+	jmp	2f
+1:	movb	$0, %al				# no drive
+2:	stosb
+	popw	%ax
+	incb	%al
+	testb	$0x04, %al
+	jz	get_fd_info
+
+	addb	$(0xb0 - 0x34), %al
+	jnc	get_fd_info			# check FDs on 640KB I/F
+
+	pushw	%es
+	popw	%ds				# %ds got bootsector again
+#if 0
+	mov	$0, (0x1ff)			# default is no pointing device
+#endif
+
+#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
+# Then check for an APM BIOS...
+						# %ds points to the bootsector
+	movw	$0, 0x40			# version = 0 means no APM BIOS
+	movw	$0x09a00, %ax			# APM BIOS installation check
+	xorw	%bx, %bx
+	int	$0x1f
+	jc	done_apm_bios			# Nope, no APM BIOS
+
+	cmpw	$0x0504d, %bx			# Check for "PM" signature
+	jne	done_apm_bios			# No signature, no APM BIOS
+
+	testb	$0x02, %cl			# Is 32 bit supported?
+	je	done_apm_bios			# No 32-bit, no (good) APM BIOS
+
+	movw	$0x09a04, %ax			# Disconnect first just in case
+	xorw	%bx, %bx
+	int	$0x1f				# ignore return code
+	movw	$0x09a03, %ax			# 32 bit connect
+	xorl	%ebx, %ebx
+	int	$0x1f
+	jc	no_32_apm_bios			# Ack, error.
+
+	movw	%ax,  (66)			# BIOS code segment
+	movl	%ebx, (68)			# BIOS entry point offset
+	movw	%cx,  (72)			# BIOS 16 bit code segment
+	movw	%dx,  (74)			# BIOS data segment
+	movl	%esi, (78)			# BIOS code segment length
+	movw	%di,  (82)			# BIOS data segment length
+# Redo the installation check as the 32 bit connect
+# modifies the flags returned on some BIOSs
+	movw	$0x09a00, %ax			# APM BIOS installation check
+	xorw	%bx, %bx
+	int	$0x1f
+	jc	apm_disconnect			# error -> shouldn't happen
+
+	cmpw	$0x0504d, %bx			# check for "PM" signature
+	jne	apm_disconnect			# no sig -> shouldn't happen
+
+	movw	%ax, (64)			# record the APM BIOS version
+	movw	%cx, (76)			# and flags
+	jmp	done_apm_bios
+
+apm_disconnect:					# Tidy up
+	movw	$0x09a04, %ax			# Disconnect
+	xorw	%bx, %bx
+	int	$0x1f				# ignore return code
+
+	jmp	done_apm_bios
+
+no_32_apm_bios:
+	andw	$0xfffd, (76)			# remove 32 bit support bit
+done_apm_bios:
+#endif
+
+# Pass cursor position to kernel...
+	movw	%cs:cursor_address, %ax
+	shrw	%ax		# cursor_address is 2 bytes unit
+	movb	$80, %cl
+	divb	%cl
+	xchgb	%al, %ah	# (0) = %al = X, (1) = %ah = Y
+	movw	%ax, (0)
+
+#if 0
+	movw	$msg_cpos, %si
+	call	prtstr_cs
+	call	prthex
+	call	prtstr_cs
+	movw	%ds, %ax
+	call	prthex
+	call	prtstr_cs
+	movb	$0x11, %ah
+	int	$0x18
+	movb	$0, %ah
+	int	$0x18
+	.section .rodata, "a"
+msg_cpos:	.string	"Cursor position: 0x"
+		.string	", %ds:0x"
+		.string	"\r\n"
+	.previous
+#endif
+
+# Now we want to move to protected mode ...
+	cmpw	$0, %cs:realmode_swtch
+	jz	rmodeswtch_normal
+
+	lcall	*%cs:realmode_swtch
+
+	jmp	rmodeswtch_end
+
+rmodeswtch_normal:
+        pushw	%cs
+	call	default_switch
+
+rmodeswtch_end:
+# we get the code32 start address and modify the below 'jmpi'
+# (loader may have changed it)
+	movl	%cs:code32_start, %eax
+	movl	%eax, %cs:code32
+
+# Now we move the system to its rightful place ... but we check if we have a
+# big-kernel. In that case we *must* not move it ...
+	testb	$LOADED_HIGH, %cs:loadflags
+	jz	do_move0			# .. then we have a normal low
+						# loaded zImage
+						# .. or else we have a high
+						# loaded bzImage
+	jmp	end_move			# ... and we skip moving
+
+do_move0:
+	movw	$0x100, %ax			# start of destination segment
+	movw	%cs, %bp			# aka SETUPSEG
+	subw	$DELTA_INITSEG, %bp		# aka INITSEG
+	movw	%cs:start_sys_seg, %bx		# start of source segment
+	cld
+do_move:
+	movw	%ax, %es			# destination segment
+	incb	%ah				# instead of add ax,#0x100
+	movw	%bx, %ds			# source segment
+	addw	$0x100, %bx
+	subw	%di, %di
+	subw	%si, %si
+	movw 	$0x800, %cx
+	rep
+	movsw
+	cmpw	%bp, %bx			# assume start_sys_seg > 0x200,
+						# so we will perhaps read one
+						# page more than needed, but
+						# never overwrite INITSEG
+						# because destination is a
+						# minimum one page below source
+	jb	do_move
+
+end_move:
+# then we load the segment descriptors
+	movw	%cs, %ax			# aka SETUPSEG
+	movw	%ax, %ds
+               
+# Check whether we need to be downward compatible with version <=201
+	cmpl	$0, cmd_line_ptr
+	jne	end_move_self		# loader uses version >=202 features
+	cmpb	$0x20, type_of_loader
+	je	end_move_self		# bootsect loader, we know of it
+ 
+# Boot loader does not support boot protocol version 2.02.
+# If we have our code not at 0x90000, we need to move it there now.
+# We also then need to move the params behind it (commandline)
+# Because we would overwrite the code on the current IP, we move
+# it in two steps, jumping high after the first one.
+	movw	%cs, %ax
+	cmpw	$SETUPSEG, %ax
+	je	end_move_self
+
+	cli					# make sure we really have
+						# interrupts disabled !
+						# because after this the stack
+						# should not be used
+	subw	$DELTA_INITSEG, %ax		# aka INITSEG
+	movw	%ss, %dx
+	cmpw	%ax, %dx
+	jb	move_self_1
+
+	addw	$INITSEG, %dx
+	subw	%ax, %dx			# this will go into %ss after
+						# the move
+move_self_1:
+	movw	%ax, %ds
+	movw	$INITSEG, %ax			# real INITSEG
+	movw	%ax, %es
+	movw	%cs:setup_move_size, %cx
+	std					# we have to move up, so we use
+						# direction down because the
+						# areas may overlap
+	movw	%cx, %di
+	decw	%di
+	movw	%di, %si
+	subw	$move_self_here+0x200, %cx
+	rep
+	movsb
+	ljmp	$SETUPSEG, $move_self_here
+
+move_self_here:
+	movw	$move_self_here+0x200, %cx
+	rep
+	movsb
+	movw	$SETUPSEG, %ax
+	movw	%ax, %ds
+	movw	%dx, %ss
+
+end_move_self:					# now we are at the right place
+	lidt	idt_48				# load idt with 0,0
+	xorl	%eax, %eax			# Compute gdt_base
+	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
+	shll	$4, %eax
+	addl	$gdt, %eax
+	movl	%eax, (gdt_48+2)
+	lgdt	gdt_48				# load gdt with whatever is
+						# appropriate
+
+# that was painless, now we enable A20
+
+	outb	%al, $0xf2			# A20 on
+	movb	$0x02, %al
+	outb	%al, $0xf6			# also A20 on; making ITF's
+						# way our model
+
+	# PC-9800 seems to enable A20 at the moment of `outb';
+	# so we don't wait unlike IBM PCs (see ../setup.S).
+
+# enable DMA to access memory over 0x100000 (1MB).
+
+	movw	$0x439, %dx
+	inb	%dx, %al
+	andb	$(~4), %al
+	outb	%al, %dx
+
+# Set DMA to increment its bank address automatically at 16MB boundary.
+# Initial setting is 64KB boundary mode so that we can't run DMA crossing
+# physical address 0xXXXXFFFF.
+
+	movb	$0x0c, %al
+	outb	%al, $0x29			# ch. 0
+	movb	$0x0d, %al
+	outb	%al, $0x29			# ch. 1
+	movb	$0x0e, %al
+	outb	%al, $0x29			# ch. 2
+	movb	$0x0f, %al
+	outb	%al, $0x29			# ch. 3
+	movb	$0x50, %al
+	outb	%al, $0x11			# reinitialize DMAC
+
+# make sure any possible coprocessor is properly reset..
+	movb	$0, %al
+	outb	%al, $0xf8
+	outb	%al, $0x5f			# delay
+
+# well, that went ok, I hope. Now we mask all interrupts - the rest
+# is done in init_IRQ().
+	movb	$0xFF, %al			# mask all interrupts for now
+	outb	%al, $0x0A
+	outb	%al, $0x5f			# delay
+	
+	movb	$0x7F, %al			# mask all irq's but irq7 which
+	outb	%al, $0x02			# is cascaded
+
+# Well, that certainly wasn't fun :-(. Hopefully it works, and we don't
+# need no steenking BIOS anyway (except for the initial loading :-).
+# The BIOS-routine wants lots of unnecessary data, and it's less
+# "interesting" anyway. This is how REAL programmers do it.
+#
+# Well, now's the time to actually move into protected mode. To make
+# things as simple as possible, we do no register set-up or anything,
+# we let the gnu-compiled 32-bit programs do that. We just jump to
+# absolute address 0x1000 (or the loader supplied one),
+# in 32-bit protected mode.
+#
+# Note that the short jump isn't strictly needed, although there are
+# reasons why it might be a good idea. It won't hurt in any case.
+	movw	$1, %ax				# protected mode (PE) bit
+	lmsw	%ax				# This is it!
+	jmp	flush_instr
+
+flush_instr:
+	xorw	%bx, %bx			# Flag to indicate a boot
+	xorl	%esi, %esi			# Pointer to real-mode code
+	movw	%cs, %si
+	subw	$DELTA_INITSEG, %si
+	shll	$4, %esi			# Convert to 32-bit pointer
+# NOTE: For high loaded big kernels we need a
+#	jmpi    0x100000,__BOOT_CS
+#
+#	but we yet haven't reloaded the CS register, so the default size 
+#	of the target offset still is 16 bit.
+#       However, using an operand prefix (0x66), the CPU will properly
+#	take our 48 bit far pointer. (INTeL 80386 Programmer's Reference
+#	Manual, Mixing 16-bit and 32-bit code, page 16-6)
+
+	.byte 0x66, 0xea			# prefix + jmpi-opcode
+code32:	.long	0x1000				# will be set to 0x100000
+						# for big kernels
+	.word	__BOOT_CS
+
+# Here's a bunch of information about your current kernel..
+kernel_version:	.ascii	UTS_RELEASE
+		.ascii	" ("
+		.ascii	LINUX_COMPILE_BY
+		.ascii	"@"
+		.ascii	LINUX_COMPILE_HOST
+		.ascii	") "
+		.ascii	UTS_VERSION
+		.byte	0
+
+# This is the default real mode switch routine.
+# to be called just before protected mode transition
+default_switch:
+	cli					# no interrupts allowed !
+	outb	%al, $0x50			# disable NMI for bootup
+						# sequence
+	lret
+
+# This routine only gets called, if we get loaded by the simple
+# bootsect loader _and_ have a bzImage to load.
+# Because there is no place left in the 512 bytes of the boot sector,
+# we must emigrate to code space here.
+bootsect_helper:
+	cmpw	$0, %cs:bootsect_es
+	jnz	bootsect_second
+
+	movb	$0x20, %cs:type_of_loader
+	movw	%es, %ax
+	shrw	$4, %ax
+	movb	%ah, %cs:bootsect_src_base+2
+	movw	%es, %ax
+	movw	%ax, %cs:bootsect_es
+	subw	$SYSSEG, %ax
+	lret					# nothing else to do for now
+
+bootsect_second:
+	pushw	%bx
+	pushw	%cx
+	pushw	%si
+	pushw	%di
+	testw	%bp, %bp			# 64K full ?
+	jne	bootsect_ex
+
+	xorw	%cx, %cx			# zero means full 64K
+	pushw	%cs
+	popw	%es
+	movw	$bootsect_gdt, %bx
+	xorw	%si, %si			# source address
+	xorw	%di, %di			# destination address
+	movb	$0x90, %ah
+	int	$0x1f
+	jc	bootsect_panic			# this, if INT1F fails
+
+	movw	%cs:bootsect_es, %es		# we reset %es to always point
+	incb	%cs:bootsect_dst_base+2		# to 0x10000
+bootsect_ex:
+	movb	%cs:bootsect_dst_base+2, %ah
+	shlb	$4, %ah				# we now have the number of
+						# moved frames in %ax
+	xorb	%al, %al
+	popw	%di
+	popw	%si
+	popw	%cx
+	popw	%bx
+	lret
+
+bootsect_gdt:
+	.word	0, 0, 0, 0
+	.word	0, 0, 0, 0
+
+bootsect_src:
+	.word	0xffff
+
+bootsect_src_base:
+	.byte	0x00, 0x00, 0x01		# base = 0x010000
+	.byte	0x93				# typbyte
+	.word	0				# limit16,base24 =0
+
+bootsect_dst:
+	.word	0xffff
+
+bootsect_dst_base:
+	.byte	0x00, 0x00, 0x10		# base = 0x100000
+	.byte	0x93				# typbyte
+	.word	0				# limit16,base24 =0
+	.word	0, 0, 0, 0			# BIOS CS
+	.word	0, 0, 0, 0			# BIOS DS
+
+bootsect_es:
+	.word	0
+
+bootsect_panic:
+	pushw	%cs
+	popw	%ds
+	cld
+	leaw	bootsect_panic_mess, %si
+	call	prtstr
+
+bootsect_panic_loop:
+	jmp	bootsect_panic_loop
+
+bootsect_panic_mess:
+	.string	"INT1F refuses to access high mem, giving up."
+
+# This routine prints one character (in %al) on console.
+# PC-9800 doesn't have BIOS-function to do it like IBM PC's INT 10h - 0Eh,
+# so we hardcode `prtchr' subroutine here.
+prtchr:
+	pushaw
+	pushw	%es
+	cmpb	$0, %cs:prtchr_initialized
+	jnz	prtchr_ok
+	xorw	%cx, %cx
+	movw	%cx, %es
+	testb	$0x8, %es:BIOS_FLAG
+	jz	1f
+	movb	$(HIRESO_TEXT >> 8), %cs:cursor_address+3
+	movw	$(80 * 31 * 2), %cs:max_cursor_offset
+1:	pushw	%ax
+	call	get_cursor_position
+	movw	%ax, %cs:cursor_address
+	popw	%ax
+	movb	$1, %cs:prtchr_initialized
+prtchr_ok:
+	lesw	%cs:cursor_address, %di
+	movw	$160, %bx
+	movb	$0, %ah
+	cmpb	$13, %al
+	je	do_cr
+	cmpb	$10, %al
+	je	do_lf
+
+	# normal (printable) character
+	stosw
+	movb	$0xe1, %es:0x2000-2(%di)
+	jmp	1f
+
+do_cr:	movw	%di, %ax
+	divb	%bl				# %al = Y, %ah = X * 2
+	mulb	%bl
+	movw	%ax, %dx
+	jmp	2f
+
+do_lf:	addw	%bx, %di
+1:	movw	%cs:max_cursor_offset, %cx
+	cmpw	%cx, %di
+	movw	%di, %dx
+	jb	2f
+	# cursor reaches bottom of screen; scroll it
+	subw	%bx, %dx
+	xorw	%di, %di
+	movw	%bx, %si
+	cld
+	subw	%bx, %cx
+	shrw	%cx
+	pushw	%cx
+	rep; es; movsw
+	movb	$32, %al			# clear bottom line characters
+	movb	$80, %cl
+	rep; stosw
+	movw	$0x2000, %di
+	popw	%cx
+	leaw	(%bx,%di), %si
+	rep; es; movsw
+	movb	$0xe1, %al			# clear bottom line attributes
+	movb	$80, %cl
+	rep; stosw
+2:	movw	%dx, %cs:cursor_address
+	movb	$0x13, %ah			# move cursor to right position
+	int	$0x18
+	popw	%es
+	popaw
+	ret
+
+cursor_address:
+	.word	0
+	.word	NORMAL_TEXT
+max_cursor_offset:
+	.word	80 * 25 * 2			# for normal 80x25 mode
+
+# putstr may called without running through start_of_setup (via bootsect_panic)
+# so we should initialize ourselves on demand.
+prtchr_initialized:
+	.byte	0
+
+# This routine queries GDC (graphic display controller) for current cursor
+# position. Cursor position is returned in %ax (CPU offset address).
+get_cursor_position:
+1:	inb	$0x60, %al
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+	testb	$0x04, %al			# Is FIFO empty?
+	jz	1b				# no -> wait until empty
+
+	movb	$0xe0, %al			# CSRR command
+	outb	%al, $0x62			# command write
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+
+2:	inb	$0x60, %al
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+	testb	$0x01, %al			# Is DATA READY?
+	jz	2b				# no -> wait until ready
+
+	inb	$0x62, %al			# read xAD (L)
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+	movb	%al, %ah
+	inb	$0x62, %al			# read xAD (H)
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+	xchgb	%al, %ah			# correct byte order
+	pushw	%ax
+	inb	$0x62, %al			# read yAD (L)
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+	inb	$0x62, %al			# read yAD (M)
+	outb	%al, $0x5f			# delay
+	outb	%al, $0x5f			# delay
+	inb	$0x62, %al			# read yAD (H)
+						# yAD is not our interest,
+						# so discard it.
+	popw	%ax
+	addw	%ax, %ax			# convert to CPU address
+	ret
+
+# Descriptor tables
+#
+# NOTE: The intel manual says gdt should be sixteen bytes aligned for
+# efficiency reasons.  However, there are machines which are known not
+# to boot with misaligned GDTs, so alter this at your peril!  If you alter
+# GDT_ENTRY_BOOT_CS (in asm/segment.h) remember to leave at least two
+# empty GDT entries (one for NULL and one reserved).
+#
+# NOTE:	On some CPUs, the GDT must be 8 byte aligned.  This is
+# true for the Voyager Quad CPU card which will not boot without
+# This directive.  16 byte aligment is recommended by intel.
+#
+	.align 16
+gdt:
+	.fill GDT_ENTRY_BOOT_CS,8,0
+
+	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
+	.word	0				# base address = 0
+	.word	0x9A00				# code read/exec
+	.word	0x00CF				# granularity = 4096, 386
+						#  (+5th nibble of limit)
+
+	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
+	.word	0				# base address = 0
+	.word	0x9200				# data read/write
+	.word	0x00CF				# granularity = 4096, 386
+						#  (+5th nibble of limit)
+gdt_end:
+	.align	4
+	
+	.word	0				# alignment byte
+idt_48:
+	.word	0				# idt limit = 0
+	.word	0, 0				# idt base = 0L
+
+	.word	0				# alignment byte
+gdt_48:
+	.word	gdt_end - gdt - 1		# gdt limit
+	.word	0, 0				# gdt base (filled in later)
+
+# Include video setup & detection code
+
+#include "video.S"
+
+# Setup signature -- must be last
+setup_sig1:	.word	SIG1
+setup_sig2:	.word	SIG2
+
+# After this point, there is some free space which is used by the video mode
+# handling code to store the temporary mode table (not used by the kernel).
+
+modelist:
+
+.text
+endtext:
+.data
+enddata:
+.bss
+endbss:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/tools/build.c linux-2.5.65-ac2/arch/i386/boot98/tools/build.c
--- linux-2.5.65/arch/i386/boot98/tools/build.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/tools/build.c	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,188 @@
+/*
+ *  $Id: build.c,v 1.5 1997/05/19 12:29:58 mj Exp $
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 1997 Martin Mares
+ */
+
+/*
+ * This file builds a disk-image from three different files:
+ *
+ * - bootsect: exactly 512 bytes of 8086 machine code, loads the rest
+ * - setup: 8086 machine code, sets up system parm
+ * - system: 80386 code for actual system
+ *
+ * It does some checking that all files are of the correct type, and
+ * just writes the result to stdout, removing headers and padding to
+ * the right amount. It also writes some system data to stderr.
+ */
+
+/*
+ * Changes by tytso to allow root device specification
+ * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+ * Cross compiling fixes by Gertjan van Wingerde, July 1996
+ * Rewritten by Martin Mares, April 1997
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <asm/boot.h>
+
+typedef unsigned char byte;
+typedef unsigned short word;
+typedef unsigned long u32;
+
+#define DEFAULT_MAJOR_ROOT 0
+#define DEFAULT_MINOR_ROOT 0
+
+/* Minimal number of setup sectors (see also bootsect.S) */
+#define SETUP_SECTS 4
+
+byte buf[1024];
+int fd;
+int is_big_kernel;
+
+void die(const char * str, ...)
+{
+	va_list args;
+	va_start(args, str);
+	vfprintf(stderr, str, args);
+	fputc('\n', stderr);
+	exit(1);
+}
+
+void file_open(const char *name)
+{
+	if ((fd = open(name, O_RDONLY, 0)) < 0)
+		die("Unable to open `%s': %m", name);
+}
+
+void usage(void)
+{
+	die("Usage: build [-b] bootsect setup system [rootdev] [> image]");
+}
+
+int main(int argc, char ** argv)
+{
+	unsigned int i, c, sz, setup_sectors;
+	u32 sys_size;
+	byte major_root, minor_root;
+	struct stat sb;
+
+	if (argc > 2 && !strcmp(argv[1], "-b"))
+	  {
+	    is_big_kernel = 1;
+	    argc--, argv++;
+	  }
+	if ((argc < 4) || (argc > 5))
+		usage();
+	if (argc > 4) {
+		if (!strcmp(argv[4], "CURRENT")) {
+			if (stat("/", &sb)) {
+				perror("/");
+				die("Couldn't stat /");
+			}
+			major_root = major(sb.st_dev);
+			minor_root = minor(sb.st_dev);
+		} else if (strcmp(argv[4], "FLOPPY")) {
+			if (stat(argv[4], &sb)) {
+				perror(argv[4]);
+				die("Couldn't stat root device.");
+			}
+			major_root = major(sb.st_rdev);
+			minor_root = minor(sb.st_rdev);
+		} else {
+			major_root = 0;
+			minor_root = 0;
+		}
+	} else {
+		major_root = DEFAULT_MAJOR_ROOT;
+		minor_root = DEFAULT_MINOR_ROOT;
+	}
+	fprintf(stderr, "Root device is (%d, %d)\n", major_root, minor_root);
+
+	file_open(argv[1]);
+	i = read(fd, buf, sizeof(buf));
+	fprintf(stderr,"Boot sector %d bytes.\n",i);
+	if (i != 512)
+		die("Boot block must be exactly 512 bytes");
+	if (buf[510] != 0x55 || buf[511] != 0xaa)
+		die("Boot block hasn't got boot flag (0xAA55)");
+	buf[508] = minor_root;
+	buf[509] = major_root;
+	if (write(1, buf, 512) != 512)
+		die("Write call failed");
+	close (fd);
+
+	file_open(argv[2]);				    /* Copy the setup code */
+	for (i=0 ; (c=read(fd, buf, sizeof(buf)))>0 ; i+=c )
+		if (write(1, buf, c) != c)
+			die("Write call failed");
+	if (c != 0)
+		die("read-error on `setup'");
+	close (fd);
+
+	setup_sectors = (i + 511) / 512;	/* Pad unused space with zeros */
+	if (!(setup_sectors & 1))
+		setup_sectors++;    /* setup_sectors must be odd on NEC PC-9800 */
+	fprintf(stderr, "Setup is %d bytes.\n", i);
+	memset(buf, 0, sizeof(buf));
+	while (i < setup_sectors * 512) {
+		c = setup_sectors * 512 - i;
+		if (c > sizeof(buf))
+			c = sizeof(buf);
+		if (write(1, buf, c) != c)
+			die("Write call failed");
+		i += c;
+	}
+
+	file_open(argv[3]);
+	if (fstat (fd, &sb))
+		die("Unable to stat `%s': %m", argv[3]);
+	sz = sb.st_size;
+	fprintf (stderr, "System is %d kB\n", sz/1024);
+	sys_size = (sz + 15) / 16;
+	/* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
+	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
+		die("System is too big. Try using %smodules.",
+			is_big_kernel ? "" : "bzImage or ");
+	if (sys_size > 0xefff)
+		fprintf(stderr,"warning: kernel is too big for standalone boot "
+		    "from floppy\n");
+	while (sz > 0) {
+		int l, n;
+
+		l = (sz > sizeof(buf)) ? sizeof(buf) : sz;
+		if ((n=read(fd, buf, l)) != l) {
+			if (n < 0)
+				die("Error reading %s: %m", argv[3]);
+			else
+				die("%s: Unexpected EOF", argv[3]);
+		}
+		if (write(1, buf, l) != l)
+			die("Write failed");
+		sz -= l;
+	}
+	close(fd);
+
+	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
+		die("Output: seek failed");
+	buf[0] = setup_sectors;
+	if (write(1, buf, 1) != 1)
+		die("Write of setup sector count failed");
+	if (lseek(1, 500, SEEK_SET) != 500)
+		die("Output: seek failed");
+	buf[0] = (sys_size & 0xff);
+	buf[1] = ((sys_size >> 8) & 0xff);
+	if (write(1, buf, 2) != 2)
+		die("Write of image length failed");
+
+	return 0;					    /* Everything is OK */
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/boot98/video.S linux-2.5.65-ac2/arch/i386/boot98/video.S
--- linux-2.5.65/arch/i386/boot98/video.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/boot98/video.S	2003-02-14 22:38:01.000000000 +0000
@@ -0,0 +1,262 @@
+/*	video.S
+ *
+ *  Video mode setup, etc. for NEC PC-9800 series.
+ *
+ *  Copyright (C) 1997,98,99  Linux/98 project  <seraphim@kmc.kyoto-u.ac.jp>
+ *
+ *  Based on the video.S for IBM PC:
+ *	copyright (C) Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ */
+
+/* Positions of various video parameters passed to the kernel */
+/* (see also include/linux/tty.h) */
+#define PARAM_CURSOR_POS	0x00
+#define PARAM_VIDEO_PAGE	0x04
+#define PARAM_VIDEO_MODE	0x06
+#define PARAM_VIDEO_COLS	0x07
+#define PARAM_VIDEO_EGA_BX	0x0a
+#define PARAM_VIDEO_LINES	0x0e
+#define PARAM_HAVE_VGA		0x0f
+#define PARAM_FONT_POINTS	0x10
+
+#define PARAM_VIDEO98_COMPAT	0x0a
+#define PARAM_VIDEO98_HIRESO	0x0b
+#define PARAM_VIDEO98_MACHTYPE	0x0c
+#define PARAM_VIDEO98_LINES	0x0e
+#define PARAM_VIDEO98_COLS	0x0f
+
+# PARAM_LFB_* and PARAM_VESAPM_* are unused on PC-9800.
+
+# This is the main entry point called by setup.S
+# %ds *must* be pointing to the bootsector
+video:	xorw	%ax, %ax
+	movw	%ax, %es			# %es = 0
+
+	movb	%es:BIOS_FLAG, %al
+	movb	%al, PARAM_VIDEO_MODE
+
+	movb	$0, PARAM_VIDEO98_HIRESO	# 0 = normal
+	movw	$NORMAL_TEXT, PARAM_VIDEO_PAGE
+	testb	$0x8, %al
+	movw	$(80 * 256 + 25), %ax
+	jz	1f
+	# hireso machine.
+	movb	$1, PARAM_VIDEO98_HIRESO	# !0 = hi-reso
+	movb	$(HIRESO_TEXT >> 8), PARAM_VIDEO_PAGE + 1
+	movw	$(80 * 256 + 31), %ax
+1:	movw	%ax, PARAM_VIDEO98_LINES	# also sets VIDEO98_COLS
+
+	movb	$0xc0, %ch			# 400-line graphic mode
+	movb	$0x42, %ah
+	int	$0x18
+
+	movw	$80, PARAM_VIDEO_COLS
+
+	movw	$msg_probing, %si
+	call	prtstr_cs
+
+# Check vendor from font pattern of `A'...
+
+1:	inb	$0x60, %al			# wait V-sync
+	testb	$0x20, %al
+	jnz	1b
+2:	inb	$0x60, %al
+	testb	$0x20, %al
+	jz	2b
+
+	movb	$0x00, %al			# select font of `A'
+	outb	%al, $0xa1
+	movb	$0x41, %al
+	outb	%al, $0xa3
+
+	movw	$8, %cx
+	movw	PARAM_VIDEO_PAGE, %ax
+	cmpw	$NORMAL_TEXT, %ax
+	je	3f
+	movb	$24, %cl			# for hi-reso machine
+3:	addw	$0x400, %ax			# %ax = CG window segment
+	pushw	%ds
+	movw	%ax, %ds
+	xorw	%dx, %dx			# get sum of `A' pattern...
+	xorw	%si, %si
+4:	lodsw
+	addw	%ax, %dx
+	loop	4b
+	popw	%ds
+
+	movw	%dx, %ax
+	movw	$msg_nec, %si
+	xorw	%bx, %bx			# vendor info will go into %bx
+	testb	$8, %es:BIOS_FLAG
+	jnz	check_hireso_vendor
+	cmpw	$0xc7f8, %ax
+	je	5f
+	jmp	6f
+check_hireso_vendor:
+	cmpw	$0x9639, %ax			# XXX: NOT VERIFIED!!!
+	je	5f
+6:	incw	%bx				# compatible machine
+	movw	$msg_compat, %si
+5:	movb	%bl, PARAM_VIDEO98_COMPAT
+	call	prtstr_cs
+
+	movw	$msg_fontdata, %si
+	call	prtstr_cs			# " (CG sum of A = 0x"
+	movw	%dx, %ax
+	call	prthex
+	call	prtstr_cs			# ") PC-98"
+
+	movb	$'0', %al
+	pushw	%ds
+	pushw	$0xf8e8
+	popw	%ds
+	cmpw	$0x2198, (0)
+	popw	%ds
+	jne	7f
+	movb	$'2', %al
+7:	call	prtchr
+	call	prtstr_cs			# "1 "
+
+	movb	$0, PARAM_VIDEO98_MACHTYPE
+#if 0	/* XXX - This check is bogus? [0000:BIOS_FLAG2]-bit7 does NOT
+		 indicate whether it is a note machine, but merely indicates
+		 whether it has ``RAM drive''. */
+# check note machine
+	testb	$0x80, %es:BIOS_FLAG2
+	jnz	is_note
+	pushw	%ds
+	pushw	$0xfd80
+	popw	%ds
+	movb	(4), %al
+	popw	%ds
+	cmpb	$0x20, %al			# EPSON note A
+	je	epson_note
+	cmpb	$0x22, %al			# EPSON note W
+	je	epson_note
+	cmpb	$0x27, %al			# EPSON note AE
+	je	epson_note
+	cmpb	$0x2a, %al			# EPSON note WR
+	jne	note_done
+epson_note:
+	movb	$1, PARAM_VIDEO98_MACHTYPE
+	movw	$msg_note, %si
+	call	prtstr_cs
+note_done:
+#endif
+	
+# print h98 ? (only NEC)
+	cmpb	$0, PARAM_VIDEO98_COMPAT
+	jnz	8f				# not NEC -> not H98
+
+	testb	$0x80, %es:BIOS_FLAG5
+	jz	8f				# have NESA bus -> H98
+	movw	$msg_h98, %si
+	call	prtstr_cs
+	orb	$2, PARAM_VIDEO98_MACHTYPE
+8:	testb	$0x40, %es:BIOS_FLAG5
+	jz	9f
+	movw	$msg_gs, %si
+	call	prtstr_cs			# only prints it :-)
+9:
+	movw	$msg_normal, %si		# "normal"
+	testb	$0x8, %es:BIOS_FLAG
+	jz	1f
+	movw	$msg_hireso, %si
+1:	call	prtstr_cs
+
+	movw	$msg_sysclk, %si
+	call	prtstr_cs
+	movb	$'5', %al
+	testb	$0x80, %es:BIOS_FLAG
+	jz	2f
+	movb	$'8', %al
+2:	call	prtchr
+	call	prtstr_cs
+
+#if 0
+	testb	$0x40, %es:(0x45c)
+	jz	no_30line			# no 30-line support
+
+	movb	%es:KB_SHFT_STS, %al
+	testb	$0x01, %al			# is SHIFT key pressed?
+	jz	no_30line
+
+	testb	$0x10, %al			# is CTRL key pressed?
+	jnz	line40
+
+	# switch to 30-line mode
+	movb	$30, PARAM_VIDEO98_LINES
+	movw	$msg_30line, %si
+	jmp	3f
+
+line40:
+	movb	$37, PARAM_VIDEO98_LINES
+	movw	$40, PARAM_VIDEO_LINES
+	movw	$msg_40line, %si
+3:	call	prtstr_cs
+
+	movb	$0x32, %bh
+	movw	$0x300c, %ax
+	int	$0x18				# switch video mode
+	movb	$0x0c, %ah
+	int	$0x18				# turn on text plane
+	movw	%cs:cursor_address, %dx
+	movb	$0x13, %ah
+	int	$0x18				# move cursor to correct place
+	mov	$0x11, %ah
+	int	$0x18				# turn on text plane
+
+	call	prtstr_cs			# "Ok.\r\n"
+no_30line:
+#endif
+	ret
+
+prtstr_cs:
+	pushw	%ds
+	pushw	%cs
+	popw	%ds
+	call	prtstr
+	popw	%ds
+	ret
+
+# prthex is for debugging purposes, and prints %ax in hexadecimal.
+prthex:	pushw	%cx
+	movw	$4, %cx
+1:	rolw	$4, %ax
+	pushw	%ax
+	andb	$0xf, %al
+	cmpb	$10, %al
+	sbbb	$0x69, %al
+	das
+	call	prtchr
+	popw	%ax
+	loop	1b
+	popw	%cx
+	ret
+
+msg_probing:	.string	"Probing machine: "
+
+msg_nec:	.string	"NEC"
+msg_compat:	.string	"compatible"
+
+msg_fontdata:	.string	" (CG sum of A = 0x"
+		.string	") PC-98"
+		.string	"1 "
+
+msg_gs:		.string	"(GS) "
+msg_h98:	.string	"(H98) "
+
+msg_normal:	.string	"normal"
+msg_hireso:	.string	"Hi-reso"
+
+msg_sysclk:	.string	" mode, system clock "
+		.string	"MHz\r\n"
+
+#if 0
+msg_40line:	# cpp will concat following lines, so the assembler can deal.
+		.ascii	"\
+Video mode will be adjusted to 37-line (so-called ``40-line'') mode later.\r\n\
+THIS MODE MAY DAMAGE YOUR MONITOR PHYSICALLY. USE AT YOUR OWN RISK.\r\n"
+msg_30line:	.string	"Switching video mode to 30-line (640x480) mode... "
+		.string	"Ok.\r\n"
+#endif
