Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312162AbSDCQdD>; Wed, 3 Apr 2002 11:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312193AbSDCQcy>; Wed, 3 Apr 2002 11:32:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32308 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312162AbSDCQcl>; Wed, 3 Apr 2002 11:32:41 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 Boot enhancements, boot memory cleanup 5/9
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 09:26:14 -0700
Message-ID: <m1wuvosq8p.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus please apply,

Currently video.S uses a small boot time heap.  As well as a large
1K data structure mode_list allocated in a ``bss'' segment at the end
the image.  This patch modifies video.S to allocate mode_list from
the heap, saving a small about of memory, and making a sane
implementation of a compiled in command line possible.

Additionally on systems with large e820 memory maps it is possible to
start overwriting our real mode code segment.  This patch modifies
the actual code start address in setup.S so that even at maximum
allocation the e820 map will not overwrite our code.

setup.S tries to have sane labels for various code sections but only
one code section is actually implemented, and the rest of the labels
have never been used so I have reduced this to simple arrangement of
having just _setup and _esetup labels.  And actually using them.

Eric

diff -uNr linux-2.5.7.boot2.pic16/arch/i386/boot/setup.S linux-2.5.7.boot2.heap/arch/i386/boot/setup.S
--- linux-2.5.7.boot2.pic16/arch/i386/boot/setup.S	Tue Apr  2 11:50:27 2002
+++ linux-2.5.7.boot2.heap/arch/i386/boot/setup.S	Tue Apr  2 11:52:04 2002
@@ -62,6 +62,8 @@
 #define __SETUP_REAL_CS 0x20
 #define __SETUP_REAL_DS 0x28
 
+#define MIN_HEAP_SIZE 1024
+
 #ifndef __BIG_KERNEL__
 #define KERNEL_START 0x1000		/* zImage */
 #else
@@ -76,15 +78,10 @@
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
@@ -141,10 +138,10 @@
 bootsect_kludge:
 		.word	bootsect_helper - start, SETUPSEG
 
-heap_end_ptr:	.word	modelist+1024 - start
+heap_end_ptr:	.word	_esetup + MIN_HEAP_SIZE  - start
 					# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
-					# end of setup code can be used by setup
+					# heap_start can be used by setup
 					# for local heap purposes.
 
 pad1:		.word	0
@@ -167,8 +164,11 @@
 					# The highest safe address for
 					# the contents of an initrd
 
+# variables private to setup.S (not for bootloaders)
+real_filesz:	.long (_esetup - start) + (DELTA_INITSEG << 4)
 trampoline:	call	start_of_setup
-		.space	1024
+		# Don't let the E820 map overlap code
+		. = (0x2d0 - 0x200) + (E820MAX * E820ENTRY_SIZE)
 # End of setup header #####################################################
 
 start_of_setup:
@@ -1044,11 +1044,4 @@
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
diff -uNr linux-2.5.7.boot2.pic16/arch/i386/boot/video.S linux-2.5.7.boot2.heap/arch/i386/boot/video.S
--- linux-2.5.7.boot2.pic16/arch/i386/boot/video.S	Tue Apr  2 11:50:27 2002
+++ linux-2.5.7.boot2.heap/arch/i386/boot/video.S	Tue Apr  2 11:52:04 2002
@@ -117,6 +117,12 @@
 	xorw	%ax, %ax
 	movw	%ax, %gs	# GS is zero
 	cld
+
+	# Setup the heap
+	movl	real_filesz - start, %eax
+	subl	$(DELTA_INITSEG << 4), %eax
+	movw	%ax, heap_start - start
+	
 	call	basic_detect	# Basic adapter type testing (EGA/VGA/MDA/CGA)
 #ifdef CONFIG_VIDEO_SELECT
 	movw	%fs:(0x01fa), %ax		# User selected video mode
@@ -201,7 +207,7 @@
 #ifdef CONFIG_VIDEO_SELECT
 # Fetching of VESA frame buffer parameters
 mopar_gr:
-	leaw	modelist+1024 - start, %di
+	movw	heap_start - start, %di
 	movb	$0x23, %fs:(PARAM_HAVE_VGA)
 	movw	16(%di), %ax
 	movw	%ax, %fs:(PARAM_LFB_LINELENGTH)
@@ -223,7 +229,7 @@
 	movl	%eax, %fs:(PARAM_LFB_COLORS+4)
 
 # get video mem size
-	leaw	modelist+1024 - start, %di
+	movw	heap_start - start, %di
 	movw	$0x4f00, %ax
 	int	$0x10
 	xorl	%eax, %eax
@@ -284,7 +290,7 @@
 	leaw	listhdr - start, %si		# Table header
 	call	prtstr
 	movb	$0x30, %dl			# DL holds mode number
-	leaw	modelist - start, %si
+	movw	modelist - start, %si
 lm1:	cmpw	$ASK_VGA, (%si)			# End?
 	jz	lm2
 
@@ -529,7 +535,7 @@
 	jmp	_m_s
 
 check_vesa:
-	leaw	modelist+1024-start, %di
+	movw	heap_start - start, %di
 	subb	$VIDEO_FIRST_VESA>>8, %bh
 	movw	%bx, %cx			# Get mode information structure
 	movw	$0x4f01, %ax
@@ -774,12 +780,13 @@
 	mulb	%ah
 	movw	%ax, %cx			# CX=number of characters
 	addw	%ax, %ax			# Calculate image size
-	addw	$modelist+1024+4-start, %ax
+	addw	heap_start - start, %ax
+	addw	$4, %ax
 	cmpw	heap_end_ptr - start, %ax
 	jnc	sts1				# Unfortunately, out of memory
 
 	movw	%fs:(PARAM_CURSOR_POS), %ax	# Store mode params
-	leaw	modelist+1024-start, %di
+	movw	heap_start - start, %di
 	stosw
 	movw	%bx, %ax
 	stosw
@@ -802,7 +809,7 @@
 	call	mode_params			# Get parameters of current mode
 	movb	%fs:(PARAM_VIDEO_LINES), %cl
 	movb	%fs:(PARAM_VIDEO_COLS), %ch
-	leaw	modelist+1024-start, %si	# Screen buffer
+	movw	heap_start - start, %si	# Screen buffer
 	lodsw					# Set cursor position
 	movw	%ax, %dx
 	cmpb	%cl, %dh
@@ -882,8 +889,9 @@
 	movw	mt_end - start, %di		# Already filled?
 	orw	%di, %di
 	jnz	mtab1x
-	
-	leaw	modelist - start, %di		# Store standard modes:
+
+	movw	heap_start - start, %di		# Store standard modes:
+	movw	%di, modelist - start
 	movl	$VIDEO_80x25 + 0x50190000, %eax	# The 80x25 mode (ALL)
 	stosl
 	movb	adapter - start, %al		# CGA/MDA/HGA -- no more modes
@@ -929,13 +937,13 @@
 mtabe:
 
 #ifdef CONFIG_VIDEO_COMPACT
-	leaw	modelist - start, %si
+	movw	modelist - start, %si
 	movw	%di, %dx
 	movw	%si, %di
 cmt1:	cmpw	%dx, %si			# Scan all modes
 	jz	cmt2
 
-	leaw	modelist - start, %bx		# Find in previous entries
+	movw	modelist - start, %bx		# Find in previous entries
 	movw	2(%si), %cx
 cmt3:	cmpw	%bx, %si
 	jz	cmt4
@@ -957,7 +965,8 @@
 
 	movw	$ASK_VGA, (%di)			# End marker
 	movw	%di, mt_end - start
-mtab1:	leaw	modelist - start, %si		# SI=mode list, DI=list end
+	movw	%di, heap_start - start
+mtab1:	movw	modelist - start, %si		# SI=mode list, DI=list end
 ret0:	ret
 
 # Modes usable on all standard VGAs
@@ -1932,3 +1941,5 @@
 adapter:	.byte	0	# Video adapter: 0=CGA/MDA/HGA,1=EGA,2=VGA
 video_segment:	.word	0xb800	# Video memory segment
 force_size:	.word	0	# Use this size instead of the one in BIOS vars
+modelist:	.word	0	# Start of modelist on the heap
+heap_start:	.word	0	# low heap address
