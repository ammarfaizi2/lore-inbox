Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314545AbSEBPDt>; Thu, 2 May 2002 11:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSEBPDs>; Thu, 2 May 2002 11:03:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13417 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314545AbSEBPDn>; Thu, 2 May 2002 11:03:43 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.12] x86 Boot enhancements, heap  5/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<m1wuumy5eo.fsf@frodo.biederman.org>
	<m1sn5ay5ac.fsf_-_@frodo.biederman.org>
	<m1offyy55x.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 08:55:52 -0600
Message-ID: <m1it66y4xz.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,

This patch introduces better heap management into setup.S 
this allows a compiled in command line to be introduced later on.

Eric

diff -uNr linux-2.5.12.boot.syntax/arch/i386/boot/setup.S linux-2.5.12.boot.heap/arch/i386/boot/setup.S
--- linux-2.5.12.boot.syntax/arch/i386/boot/setup.S	Wed May  1 09:39:11 2002
+++ linux-2.5.12.boot.heap/arch/i386/boot/setup.S	Wed May  1 09:39:29 2002
@@ -65,6 +65,8 @@
 #define KERNEL_START HIGH_BASE 		/* bzImage */
 #endif
 
+#define DELTA_BOOTSECT 512
+
 INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
 SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
 SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
@@ -73,15 +75,10 @@
 DELTA_INITSEG = SETUPSEG - INITSEG	# 0x0020
 
 .code16
-.globl begtext, begdata, begbss, endtext, enddata, endbss
+.globl _setup, _esetup
 
 .text
-begtext:
-.data
-begdata:
-.bss
-begbss:
-.text
+_setup:	
 
 start:
 	jmp	trampoline
@@ -137,7 +134,7 @@
 bootsect_kludge:
 		.word  bootsect_helper, SETUPSEG
 
-heap_end_ptr:	.word	modelist+1024	# (Header version 0x0201 or later)
+heap_end_ptr:	.word	_esetup_heap	# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
 					# end of setup code can be used by setup
 					# for local heap purposes.
@@ -162,8 +159,12 @@
 					# The highest safe address for
 					# the contents of an initrd
 
+# variables private to setup.S (not for bootloaders)
+real_filesz:				# Datasize of the real mode kernel
+		.long (_esetup - _setup) + DELTA_BOOTSECT
 trampoline:	call	start_of_setup
-		.space	1024
+		# Don't let the E820 map overlap code
+		. = (E820MAP - DELTA_BOOTSECT) + (E820MAX * E820ENTRY_SIZE)
 # End of setup header #####################################################
 
 start_of_setup:
@@ -1042,11 +1043,8 @@
 # After this point, there is some free space which is used by the video mode
 # handling code to store the temporary mode table (not used by the kernel).
 
-modelist:
-
-.text
-endtext:
-.data
-enddata:
-.bss
-endbss:
+_esetup:
+.section ".setup.heap", "a", @nobits
+_setup_heap:
+. = DEF_HEAP_SIZE
+_esetup_heap:
diff -uNr linux-2.5.12.boot.syntax/arch/i386/boot/video.S linux-2.5.12.boot.heap/arch/i386/boot/video.S
--- linux-2.5.12.boot.syntax/arch/i386/boot/video.S	Thu Jul  5 12:28:16 2001
+++ linux-2.5.12.boot.heap/arch/i386/boot/video.S	Wed May  1 09:39:29 2002
@@ -117,6 +117,12 @@
 	xorw	%ax, %ax
 	movw	%ax, %gs	# GS is zero
 	cld
+
+	# Setup the heap
+	movl	real_filesz, %eax
+	subl	$DELTA_BOOTSECT, %eax
+	movw	%ax, heap_start
+	
 	call	basic_detect	# Basic adapter type testing (EGA/VGA/MDA/CGA)
 #ifdef CONFIG_VIDEO_SELECT
 	movw	%fs:(0x01fa), %ax		# User selected video mode
@@ -201,7 +207,7 @@
 #ifdef CONFIG_VIDEO_SELECT
 # Fetching of VESA frame buffer parameters
 mopar_gr:
-	leaw	modelist+1024, %di
+	movw	heap_start, %di
 	movb	$0x23, %fs:(PARAM_HAVE_VGA)
 	movw	16(%di), %ax
 	movw	%ax, %fs:(PARAM_LFB_LINELENGTH)
@@ -223,7 +229,7 @@
 	movl	%eax, %fs:(PARAM_LFB_COLORS+4)
 
 # get video mem size
-	leaw	modelist+1024, %di
+	movw	heap_start, %di
 	movw	$0x4f00, %ax
 	int	$0x10
 	xorl	%eax, %eax
@@ -284,7 +290,7 @@
 	leaw	listhdr, %si			# Table header
 	call	prtstr
 	movb	$0x30, %dl			# DL holds mode number
-	leaw	modelist, %si
+	movw	modelist, %si
 lm1:	cmpw	$ASK_VGA, (%si)			# End?
 	jz	lm2
 
@@ -529,7 +535,7 @@
 	jmp	_m_s
 
 check_vesa:
-	leaw	modelist+1024, %di
+	movw	heap_start, %di
 	subb	$VIDEO_FIRST_VESA>>8, %bh
 	movw	%bx, %cx			# Get mode information structure
 	movw	$0x4f01, %ax
@@ -774,12 +780,13 @@
 	mulb	%ah
 	movw	%ax, %cx			# CX=number of characters
 	addw	%ax, %ax			# Calculate image size
-	addw	$modelist+1024+4, %ax
+	addw	heap_start, %ax
+	addw	$4, %ax
 	cmpw	heap_end_ptr, %ax
 	jnc	sts1				# Unfortunately, out of memory
 
 	movw	%fs:(PARAM_CURSOR_POS), %ax	# Store mode params
-	leaw	modelist+1024, %di
+	movw	heap_start, %di
 	stosw
 	movw	%bx, %ax
 	stosw
@@ -802,7 +809,7 @@
 	call	mode_params			# Get parameters of current mode
 	movb	%fs:(PARAM_VIDEO_LINES), %cl
 	movb	%fs:(PARAM_VIDEO_COLS), %ch
-	leaw	modelist+1024, %si		# Screen buffer
+	movw	heap_start, %si			# Screen buffer
 	lodsw					# Set cursor position
 	movw	%ax, %dx
 	cmpb	%cl, %dh
@@ -883,7 +890,8 @@
 	orw	%di, %di
 	jnz	mtab1x
 	
-	leaw	modelist, %di			# Store standard modes:
+	movw	heap_start, %di			# Store standard modes:
+	movw	%di, modelist
 	movl	$VIDEO_80x25 + 0x50190000, %eax	# The 80x25 mode (ALL)
 	stosl
 	movb	adapter, %al			# CGA/MDA/HGA -- no more modes
@@ -929,13 +937,13 @@
 mtabe:
 
 #ifdef CONFIG_VIDEO_COMPACT
-	leaw	modelist, %si
+	movw	modelist, %si
 	movw	%di, %dx
 	movw	%si, %di
 cmt1:	cmpw	%dx, %si			# Scan all modes
 	jz	cmt2
 
-	leaw	modelist, %bx			# Find in previous entries
+	movw	modelist, %bx			# Find in previous entries
 	movw	2(%si), %cx
 cmt3:	cmpw	%bx, %si
 	jz	cmt4
@@ -957,7 +965,8 @@
 
 	movw	$ASK_VGA, (%di)			# End marker
 	movw	%di, mt_end
-mtab1:	leaw	modelist, %si			# SI=mode list, DI=list end
+	movw	%di, heap_start
+mtab1:	movw	modelist, %si			# SI=mode list, DI=list end
 ret0:	ret
 
 # Modes usable on all standard VGAs
@@ -1932,3 +1941,5 @@
 adapter:	.byte	0	# Video adapter: 0=CGA/MDA/HGA,1=EGA,2=VGA
 video_segment:	.word	0xb800	# Video memory segment
 force_size:	.word	0	# Use this size instead of the one in BIOS vars
+modelist:	.word	0	# Start of modelist on the heap
+heap_start:	.word	0	# low heap address
diff -uNr linux-2.5.12.boot.syntax/include/asm-i386/boot.h linux-2.5.12.boot.heap/include/asm-i386/boot.h
--- linux-2.5.12.boot.syntax/include/asm-i386/boot.h	Wed May  1 09:39:11 2002
+++ linux-2.5.12.boot.heap/include/asm-i386/boot.h	Wed May  1 09:39:29 2002
@@ -19,6 +19,7 @@
 #define DEF_SYSSEG	0x1000
 #define DEF_SETUPSEG	0x9020
 #define DEF_SYSSIZE	0x7F00
+#define DEF_HEAP_SIZE	1024
 
 /* Internal svga startup constants */
 #define NORMAL_VGA	0xffff		/* 80x25 mode */
diff -uNr linux-2.5.12.boot.syntax/include/asm-i386/boot_param.h linux-2.5.12.boot.heap/include/asm-i386/boot_param.h
--- linux-2.5.12.boot.syntax/include/asm-i386/boot_param.h	Wed May  1 09:38:30 2002
+++ linux-2.5.12.boot.heap/include/asm-i386/boot_param.h	Wed May  1 09:39:29 2002
@@ -72,7 +72,9 @@
 	__u32 cmd_line_ptr;			/* 0x228 */
 	/* 2.03+ */
 	__u32 ramdisk_max;			/* 0x22c */
-	__u8  reserved15[0x2d0 - 0x230];	/* 0x230 */
+	/* Below this point for internal kernel use only */
+	__u32 real_filesz;			/* 0x230 */
+	__u8  reserved15[0x2d0 - 0x234];	/* 0x234 */
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
 } __attribute__((packed));
