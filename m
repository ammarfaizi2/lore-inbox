Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSDCQWj>; Wed, 3 Apr 2002 11:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312162AbSDCQWZ>; Wed, 3 Apr 2002 11:22:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31028 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312169AbSDCQWG>; Wed, 3 Apr 2002 11:22:06 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 Boot enhancements, pic 16 4/9
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 09:15:38 -0700
Message-ID: <m11ydwu5at.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus please apply,

This patch makes not changes to the generated object code.

Instead removes the assumption the code is linked to run at 0.  The
binary code is already PIC, this makes the build process the same way,
making the build requirements more flexible. 

Eric


diff -uNr linux-2.5.7.boot2.32bit_entry/arch/i386/boot/bootsect.S linux-2.5.7.boot2.pic16/arch/i386/boot/bootsect.S
--- linux-2.5.7.boot2.32bit_entry/arch/i386/boot/bootsect.S	Sun Mar 10 20:07:02 2002
+++ linux-2.5.7.boot2.pic16/arch/i386/boot/bootsect.S	Tue Apr  2 11:50:27 2002
@@ -71,7 +71,7 @@
 	cld
 	rep
 	movsw
-	ljmp	$INITSEG, $go
+	ljmp	$INITSEG, $go - _start
 
 # bde - changed 0xff00 to 0x4000 to use debugger at 0x6400 up (bde).  We
 # wouldn't have to worry about this if we checked the top of memory.  Also
@@ -123,12 +123,12 @@
 # can be read, 15 if sector 15 can be read.  Otherwise guess 9.
 # Note that %cx = 0 from rep movsw above.
 
-	movw	$disksizes, %si		# table of sizes to try
+	movw	$disksizes - _start, %si	# table of sizes to try
 probe_loop:
 	lodsb
 	cbtw				# extend to word
-	movw	%ax, sectors
-	cmpw	$disksizes+4, %si
+	movw	%ax, sectors - _start
+	cmpw	$disksizes+4 - _start, %si
 	jae	got_sectors		# If all else fails, try 9
 
 	xchgw	%cx, %ax		# %cx = track and sector
@@ -146,7 +146,7 @@
 	movb	$0x07, %bl		# page 0, attribute 7 (normal)
 					# %bh is set above; int10 doesn't
 					# modify it
-	movw	$msg1, %bp
+	movw	$msg1 - _start, %bp
 	movw	$0x1301, %ax		# write string, move cursor
 	int	$0x10			# tell the user we're loading..
 
@@ -155,25 +155,25 @@
 # cylinder (for 9-sector 360K and 720K floppies).
 
 	movw	$0x0001, %ax		# set sread (sector-to-read) to 1 as
-	movw	$sread, %si		# the boot sector has already been read
+	movw	$sread - _start, %si	# the boot sector has already been read
 	movw	%ax, (%si)
 
 	call	kill_motor		# reset FDC
 	movw	$0x0200, %bx		# address = 512, in INITSEG
 next_step:
-	movb	setup_sects, %al
-	movw	sectors, %cx
+	movb	setup_sects - _start, %al
+	movw	sectors - _start, %cx
 	subw	(%si), %cx		# (%si) = sread
 	cmpb	%cl, %al
 	jbe	no_cyl_crossing
-	movw	sectors, %ax
+	movw	sectors - _start, %ax
 	subw	(%si), %ax		# (%si) = sread
 no_cyl_crossing:
 	call	read_track
 	pushw	%ax			# save it
 	call	set_next		# set %bx properly; it uses %ax,%cx,%dx
 	popw	%ax			# restore
-	subb	%al, setup_sects	# rest - for next step
+	subb	%al, setup_sects-_start	# rest - for next step
 	jnz	next_step
 
 	pushw	$SYSSEG
@@ -190,11 +190,11 @@
 # Segments are as follows: %cs = %ds = %ss = INITSEG,
 #	%es = SYSSEG, %fs = 0, %gs is unused.
 
-	movw	root_dev, %ax
+	movw	root_dev-_start, %ax
 	orw	%ax, %ax
 	jne	root_defined
 
-	movw	sectors, %bx
+	movw	sectors-_start, %bx
 	movw	$0x0208, %ax		# /dev/ps0 - 1.2Mb
 	cmpw	$15, %bx
 	je	root_defined
@@ -209,7 +209,7 @@
 
 	movb	$0, %al			# /dev/fd0 - autodetect
 root_defined:
-	movw	%ax, root_dev
+	movw	%ax, root_dev-_start
 
 # After that (everything loaded), we jump to the setup-routine
 # loaded directly after the bootblock:
@@ -242,13 +242,13 @@
 	shr	$4, %cx
 	add	%cx, %ax		# check offset
 #endif
-	cmpw	syssize, %ax		# have we loaded everything yet?
+	cmpw	syssize-_start, %ax	# have we loaded everything yet?
 	jbe	ok1_read
 
 	ret
 
 ok1_read:
-	movw	sectors, %ax
+	movw	sectors-_start, %ax
 	subw	(%si), %ax		# (%si) = sread
 	movw	%ax, %cx
 	shlw	$9, %cx
@@ -297,7 +297,7 @@
 set_next:
 	movw	%ax, %cx
 	addw	(%si), %ax		# (%si) = sread
-	cmp	sectors, %ax
+	cmp	sectors-_start, %ax
 	jne	ok3_set
 	movw	$0x0001, %ax
 	xorw	%ax, 2(%si)		# change head
diff -uNr linux-2.5.7.boot2.32bit_entry/arch/i386/boot/setup.S linux-2.5.7.boot2.pic16/arch/i386/boot/setup.S
--- linux-2.5.7.boot2.32bit_entry/arch/i386/boot/setup.S	Tue Apr  2 11:46:18 2002
+++ linux-2.5.7.boot2.pic16/arch/i386/boot/setup.S	Tue Apr  2 11:50:27 2002
@@ -62,6 +62,12 @@
 #define __SETUP_REAL_CS 0x20
 #define __SETUP_REAL_DS 0x28
 
+#ifndef __BIG_KERNEL__
+#define KERNEL_START 0x1000		/* zImage */
+#else
+#define KERNEL_START 0x100000 		/* bzImage */
+#endif
+
 INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
 SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
 SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
@@ -89,11 +95,12 @@
 		.word	0x0203		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
-start_sys_seg:	.word	SYSSEG
-		.word	kernel_version	# pointing to kernel version string
+start_sys_seg:				# pointing to kernel version string
 					# above section of header is compatible
 					# with loadlin-1.5 (header v1.5). Don't
 					# change it.
+		.word	SYSSEG
+		.word	kernel_version - start
 
 type_of_loader:	.byte	0		# = 0, old one (LILO, Loadlin,
 					#      Bootlin, SYSLX, bootsect...)
@@ -121,13 +128,8 @@
 					# loader knows how much data behind
 					# us also needs to be loaded.
 
-code32_start:				# here loaders can put a different
+code32_start:	.long	KERNEL_START	# here loaders can put a different
 					# start address for 32-bit code.
-#ifndef __BIG_KERNEL__
-		.long	0x1000		#   0x1000 = default for zImage
-#else
-		.long	0x100000	# 0x100000 = default for big kernel
-#endif
 
 ramdisk_image:	.long	0		# address of loaded ramdisk image
 					# Here the loader puts the 32-bit
@@ -137,9 +139,10 @@
 ramdisk_size:	.long	0		# its size in bytes
 
 bootsect_kludge:
-		.word  bootsect_helper, SETUPSEG
+		.word	bootsect_helper - start, SETUPSEG
 
-heap_end_ptr:	.word	modelist+1024	# (Header version 0x0201 or later)
+heap_end_ptr:	.word	modelist+1024 - start
+					# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
 					# end of setup code can be used by setup
 					# for local heap purposes.
@@ -185,10 +188,10 @@
 	movw	%cs, %ax		# aka SETUPSEG
 	movw	%ax, %ds
 # Check signature at end of setup
-	cmpw	$SIG1, setup_sig1
+	cmpw	$SIG1, setup_sig1 - start
 	jne	bad_sig
 
-	cmpw	$SIG2, setup_sig2
+	cmpw	$SIG2, setup_sig2 - start
 	jne	bad_sig
 
 	jmp	good_sig1
@@ -239,7 +242,7 @@
 	movw	%bx, %cx
 	shrw	$3, %bx				# convert to segment
 	addw	$SYSSEG, %bx
-	movw	%bx, %cs:start_sys_seg
+	movw	%bx, %cs:start_sys_seg - start
 # Move rest of setup code/data to here
 	movw	$2048, %di			# four sectors loaded by LILO
 	subw	%si, %si
@@ -251,16 +254,16 @@
 	movsw
 	movw	%cs, %ax			# aka SETUPSEG
 	movw	%ax, %ds
-	cmpw	$SIG1, setup_sig1
+	cmpw	$SIG1, setup_sig1 - start
 	jne	no_sig
 
-	cmpw	$SIG2, setup_sig2
+	cmpw	$SIG2, setup_sig2 - start
 	jne	no_sig
 
 	jmp	good_sig
 
 no_sig:
-	lea	no_sig_mess, %si
+	lea	no_sig_mess - start, %si
 	call	prtstr
 
 no_sig_loop:
@@ -272,16 +275,16 @@
 	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
 	movw	%ax, %ds
 # Check if an old loader tries to load a big-kernel
-	testb	$LOADED_HIGH, %cs:loadflags	# Do we have a big kernel?
+	testb	$LOADED_HIGH, %cs:loadflags - start	# Do we have a big kernel?
 	jz	loader_ok			# No, no danger for old loaders.
 
-	cmpb	$0, %cs:type_of_loader 		# Do we have a loader that
+	cmpb	$0, %cs:type_of_loader - start	# Do we have a loader that
 						# can deal with us?
 	jnz	loader_ok			# Yes, continue.
 
 	pushw	%cs				# No, we have an old loader,
 	popw	%ds				# die. 
-	lea	loader_panic_mess, %si
+	lea	loader_panic_mess - start, %si
 	call	prtstr
 
 	jmp	no_sig_loop
@@ -340,7 +343,7 @@
 
 	incb	(E820NR)
 	movw	%di, %ax
-	addw	$20, %ax
+	addw	$E820ENTRY_SIZE, %ax
 	movw	%ax, %di
 again820:
 	cmpl	$0, %ebx			# check to see if
@@ -547,10 +550,10 @@
 #endif
 
 # Now we want to move to protected mode ...
-	cmpw	$0, %cs:realmode_swtch
+	cmpw	$0, %cs:realmode_swtch - start
 	jz	rmodeswtch_normal
 
-	lcall	*%cs:realmode_swtch
+	lcall	*%cs:realmode_swtch - start
 
 	jmp	rmodeswtch_end
 
@@ -561,12 +564,12 @@
 rmodeswtch_end:
 # we get the code32 start address and modify the below 'jmpi'
 # (loader may have changed it)
-	movl	%cs:code32_start, %eax
-	movl	%eax, %cs:code32
+	movl	%cs:code32_start - start, %eax
+	movl	%eax, %cs:code32 - start
 
 # Now we move the system to its rightful place ... but we check if we have a
 # big-kernel. In that case we *must* not move it ...
-	testb	$LOADED_HIGH, %cs:loadflags
+	testb	$LOADED_HIGH, %cs:loadflags - start
 	jz	do_move0			# .. then we have a normal low
 						# loaded zImage
 						# .. or else we have a high
@@ -577,7 +580,7 @@
 	movw	$0x100, %ax			# start of destination segment
 	movw	%cs, %bp			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %bp		# aka INITSEG
-	movw	%cs:start_sys_seg, %bx		# start of source segment
+	movw	%cs:start_sys_seg - start, %bx	# start of source segment
 	cld
 do_move:
 	movw	%ax, %es			# destination segment
@@ -603,9 +606,9 @@
 	movw	%ax, %ds
 		
 # Check whether we need to be downward compatible with version <=201
-	cmpl	$0, cmd_line_ptr
+	cmpl	$0, cmd_line_ptr - start
 	jne	end_move_self		# loader uses version >=202 features
-	cmpb	$0x20, type_of_loader
+	cmpb	$0x20, type_of_loader - start
 	je	end_move_self		# bootsect loader, we know of it
 
 # Boot loader doesnt support boot protocol version 2.02.
@@ -633,20 +636,20 @@
 	movw	%ax, %ds
 	movw	$INITSEG, %ax			# real INITSEG
 	movw	%ax, %es
-	movw	%cs:setup_move_size, %cx
+	movw	%cs:setup_move_size - start, %cx
 	std					# we have to move up, so we use
 						# direction down because the
 						# areas may overlap
 	movw	%cx, %di
 	decw	%di
 	movw	%di, %si
-	subw	$move_self_here+0x200, %cx
+	subw	$move_self_here+0x200 -start, %cx
 	rep
 	movsb
-	ljmp	$SETUPSEG, $move_self_here
+	ljmp	$SETUPSEG, $move_self_here -start
 
 move_self_here:
-	movw	$move_self_here+0x200, %cx
+	movw	$move_self_here+0x200-start, %cx
 	rep
 	movsb
 	movw	$SETUPSEG, %ax
@@ -722,10 +725,10 @@
 
 	# A20 is still not responding.  Try frobbing it again.
 	# 
-	decb	(a20_tries)
+	decb	(a20_tries - start)
 	jnz	a20_try_loop
 	
-	movw	$a20_err_msg, %si
+	movw	$a20_err_msg - start, %si
 	call	prtstr
 
 a20_die:
@@ -743,13 +746,13 @@
 a20_done:
 
 # set up gdt and idt
-	lidt	idt_48				# load idt with 0,0
+	lidt	idt_48 - start			# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
 	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
 	shll	$4, %eax
-	addl	$gdt, %eax
-	movl	%eax, (gdt_48+2)
-	lgdt	gdt_48				# load gdt with whatever is
+	addl	$gdt - start, %eax
+	movl	%eax, (gdt_48+2 - start)
+	lgdt	gdt_48 - start			# load gdt with whatever is
 						# appropriate
 
 # make sure any possible coprocessor is properly reset..
@@ -839,15 +842,15 @@
 # Because there is no place left in the 512 bytes of the boot sector,
 # we must emigrate to code space here.
 bootsect_helper:
-	cmpw	$0, %cs:bootsect_es
+	cmpw	$0, %cs:bootsect_es - start
 	jnz	bootsect_second
 
-	movb	$0x20, %cs:type_of_loader
+	movb	$0x20, %cs:type_of_loader - start
 	movw	%es, %ax
 	shrw	$4, %ax
-	movb	%ah, %cs:bootsect_src_base+2
+	movb	%ah, %cs:bootsect_src_base+2 - start
 	movw	%es, %ax
-	movw	%ax, %cs:bootsect_es
+	movw	%ax, %cs:bootsect_es - start
 	subw	$SYSSEG, %ax
 	lret					# nothing else to do for now
 
@@ -861,15 +864,15 @@
 	movw	$0x8000, %cx			# full 64K, INT15 moves words
 	pushw	%cs
 	popw	%es
-	movw	$bootsect_gdt, %si
+	movw	$bootsect_gdt - start, %si
 	movw	$0x8700, %ax
 	int	$0x15
 	jc	bootsect_panic			# this, if INT15 fails
 
-	movw	%cs:bootsect_es, %es		# we reset %es to always point
-	incb	%cs:bootsect_dst_base+2		# to 0x10000
+	movw	%cs:bootsect_es -start, %es	# we reset %es to always point
+	incb	%cs:bootsect_dst_base+2 -start	# to 0x10000
 bootsect_ex:
-	movb	%cs:bootsect_dst_base+2, %ah
+	movb	%cs:bootsect_dst_base+2 -start, %ah
 	shlb	$4, %ah				# we now have the number of
 						# moved frames in %ax
 	xorb	%al, %al
@@ -907,7 +910,7 @@
 	pushw	%cs
 	popw	%ds
 	cld
-	leaw	bootsect_panic_mess, %si
+	leaw	bootsect_panic_mess -start, %si
 	call	prtstr
 	
 bootsect_panic_loop:
diff -uNr linux-2.5.7.boot2.32bit_entry/arch/i386/boot/video.S linux-2.5.7.boot2.pic16/arch/i386/boot/video.S
--- linux-2.5.7.boot2.32bit_entry/arch/i386/boot/video.S	Thu Jul  5 12:28:16 2001
+++ linux-2.5.7.boot2.pic16/arch/i386/boot/video.S	Tue Apr  2 11:50:27 2002
@@ -126,7 +126,7 @@
 	call	mode_set			# Set the mode
 	jc	vid1
 
-	leaw	badmdt, %si			# Invalid mode ID
+	leaw	badmdt - start, %si			# Invalid mode ID
 	call	prtstr
 vid2:	call	mode_menu
 vid1:
@@ -148,14 +148,14 @@
 	cmpb	$0x10, %bl			# No, it's a CGA/MDA/HGA card.
 	je	basret
 
-	incb	adapter
+	incb	adapter - start
 	movw	$0x1a00, %ax			# Check EGA or VGA?
 	int	$0x10
 	cmpb	$0x1a, %al			# 1a means VGA...
 	jne	basret				# anything else is EGA.
 	
 	incb	%fs:(PARAM_HAVE_VGA)		# We've detected a VGA
-	incb	adapter
+	incb	adapter - start
 basret:	ret
 
 # Store the video mode parameters for later usage by the kernel.
@@ -164,7 +164,7 @@
 # because some very obscure BIOSes supply insane values.
 mode_params:
 #ifdef CONFIG_VIDEO_SELECT
-	cmpb	$0, graphic_mode
+	cmpb	$0, graphic_mode - start
 	jnz	mopar_gr
 #endif
 	movb	$0x03, %ah			# Read cursor position
@@ -178,10 +178,10 @@
 	cmpb	$0x7, %al			# MDA/HGA => segment differs
 	jnz	mopar0
 
-	movw	$0xb000, video_segment
+	movw	$0xb000, video_segment - start
 mopar0: movw	%gs:(0x485), %ax		# Font size
 	movw	%ax, %fs:(PARAM_FONT_POINTS)	# (valid only on EGA/VGA)
-	movw	force_size, %ax			# Forced size?
+	movw	force_size - start, %ax		# Forced size?
 	orw	%ax, %ax
 	jz	mopar1
 
@@ -190,7 +190,7 @@
 	ret
 
 mopar1:	movb	$25, %al
-	cmpb	$0, adapter			# If we are on CGA/MDA/HGA, the
+	cmpb	$0, adapter - start		# If we are on CGA/MDA/HGA, the
 	jz	mopar2				# screen must have 25 lines.
 
 	movb	%gs:(0x484), %al		# On EGA/VGA, use the EGA+ BIOS
@@ -201,7 +201,7 @@
 #ifdef CONFIG_VIDEO_SELECT
 # Fetching of VESA frame buffer parameters
 mopar_gr:
-	leaw	modelist+1024, %di
+	leaw	modelist+1024 - start, %di
 	movb	$0x23, %fs:(PARAM_HAVE_VGA)
 	movw	16(%di), %ax
 	movw	%ax, %fs:(PARAM_LFB_LINELENGTH)
@@ -223,7 +223,7 @@
 	movl	%eax, %fs:(PARAM_LFB_COLORS+4)
 
 # get video mem size
-	leaw	modelist+1024, %di
+	leaw	modelist+1024 - start, %di
 	movw	$0x4f00, %ax
 	int	$0x10
 	xorl	%eax, %eax
@@ -243,7 +243,7 @@
 
 # The video mode menu
 mode_menu:
-	leaw	keymsg, %si			# "Return/Space/Timeout" message
+	leaw	keymsg - start, %si		# "Return/Space/Timeout" message
 	call	prtstr
 	call	flush
 nokey:	call	getkt
@@ -260,31 +260,31 @@
 defmd1:	ret					# No mode chosen? Default 80x25
 
 listm:	call	mode_table			# List mode table
-listm0:	leaw	name_bann, %si			# Print adapter name
+listm0:	leaw	name_bann - start, %si		# Print adapter name
 	call	prtstr
-	movw	card_name, %si
+	movw	card_name - start, %si
 	orw	%si, %si
 	jnz	an2
 
-	movb	adapter, %al
-	leaw	old_name, %si
+	movb	adapter - start, %al
+	leaw	old_name - start, %si
 	orb	%al, %al
 	jz	an1
 
-	leaw	ega_name, %si
+	leaw	ega_name - start, %si
 	decb	%al
 	jz	an1
 
-	leaw	vga_name, %si
+	leaw	vga_name - start, %si
 	jmp	an1
 
 an2:	call	prtstr
-	leaw	svga_name, %si
+	leaw	svga_name - start, %si
 an1:	call	prtstr
-	leaw	listhdr, %si			# Table header
+	leaw	listhdr - start, %si		# Table header
 	call	prtstr
 	movb	$0x30, %dl			# DL holds mode number
-	leaw	modelist, %si
+	leaw	modelist - start, %si
 lm1:	cmpw	$ASK_VGA, (%si)			# End?
 	jz	lm2
 
@@ -311,9 +311,9 @@
 	movb	$0x61, %dl
 	jmp	lm1
 
-lm2:	leaw	prompt, %si			# Mode prompt
+lm2:	leaw	prompt - start, %si		# Mode prompt
 	call	prtstr
-	leaw	edit_buf, %di			# Editor buffer
+	leaw	edit_buf - start, %di		# Editor buffer
 lm3:	call	getkey
 	cmpb	$0x0d, %al			# Enter?
 	jz	lment
@@ -324,14 +324,14 @@
 	cmpb	$0x20, %al			# Printable?
 	jc	lm3
 
-	cmpw	$edit_buf+4, %di		# Enough space?
+	cmpw	$edit_buf + 4 - start, %di	# Enough space?
 	jz	lm3
 
 	stosb
 	call	prtchr
 	jmp	lm3
 
-lmbs:	cmpw	$edit_buf, %di			# Backspace
+lmbs:	cmpw	$edit_buf - start, %di		# Backspace
 	jz	lm3
 
 	decw	%di
@@ -343,9 +343,9 @@
 	jmp	lm3
 	
 lment:	movb	$0, (%di)
-	leaw	crlft, %si
+	leaw	crlft - start, %si
 	call	prtstr
-	leaw	edit_buf, %si
+	leaw	edit_buf - start, %si
 	cmpb	$0, (%si)			# Empty string = default mode
 	jz	lmdef
 
@@ -402,14 +402,14 @@
 lmuse:	call	mode_set
 	jc	lmdef
 
-lmbad:	leaw	unknt, %si
+lmbad:	leaw	unknt - start, %si
 	call	prtstr
 	jmp	lm2
-lmscan:	cmpb	$0, adapter			# Scanning only on EGA/VGA
+lmscan:	cmpb	$0, adapter - start		# Scanning only on EGA/VGA
 	jz	lmbad
 
-	movw	$0, mt_end			# Scanning of modes is
-	movb	$1, scanning			# done as new autodetection.
+	movw	$0, mt_end - start		# Scanning of modes is
+	movb	$1, scanning - start		# done as new autodetection.
 	call	mode_table
 	jmp	listm0
 lmdef:	ret
@@ -464,7 +464,7 @@
 	jz	setbios
 
 setbad:	clc
-	movb	$0, do_restore			# The screen needn't be restored
+	movb	$0, do_restore - start		# The screen needn't be restored
 	ret
 
 setvesa:
@@ -496,7 +496,7 @@
 	jnc	setbad
 	
 	addw	%bx, %bx
-	jmp	*spec_inits(%bx)
+	jmp	*spec_inits - start(%bx)
 
 setmenu:
 	orb	%al, %al			# 80x25 is an exception
@@ -529,7 +529,7 @@
 	jmp	_m_s
 
 check_vesa:
-	leaw	modelist+1024, %di
+	leaw	modelist+1024-start, %di
 	subb	$VIDEO_FIRST_VESA>>8, %bh
 	movw	%bx, %cx			# Get mode information structure
 	movw	$0x4f01, %ax
@@ -555,8 +555,8 @@
 	cmpw	$0x004f, %ax			# AL=4f if implemented
 	jnz	_setbad				# AH=0 if OK
 
-	movb	$1, graphic_mode		# flag graphic mode
-	movb	$0, do_restore			# no screen restore
+	movb	$1, graphic_mode - start	# flag graphic mode
+	movb	$0, do_restore - start		# no screen restore
 	stc
 	ret
 
@@ -597,19 +597,19 @@
 
 # Table of routines for setting of the special modes.
 spec_inits:
-	.word	set_80x25
-	.word	set_8pixel
-	.word	set_80x43
-	.word	set_80x28
-	.word	set_current
-	.word	set_80x30
-	.word	set_80x34
-	.word	set_80x60
-	.word	set_gfx
+	.word	set_80x25 - start
+	.word	set_8pixel - start
+	.word	set_80x43 - start
+	.word	set_80x28 - start
+	.word	set_current - start
+	.word	set_80x30 - start
+	.word	set_80x34 - start
+	.word	set_80x60 - start
+	.word	set_gfx - start
 
 # Set the 80x25 mode. If already set, do nothing.
 set_80x25:
-	movw	$0x5019, force_size		# Override possibly broken BIOS
+	movw	$0x5019, force_size - start	# Override possibly broken BIOS
 use_80x25:
 #ifdef CONFIG_VIDEO_400_HACK
 	movw	$0x1202, %ax			# Force 400 scan lines
@@ -624,7 +624,7 @@
 	cmpw	$0x5003, %ax	# Unknown mode, force 80x25 color
 	jnz	force3
 
-st80:	cmpb	$0, adapter	# CGA/MDA/HGA => mode 3/7 is always 80x25
+st80:	cmpb	$0, adapter - start	# CGA/MDA/HGA => mode 3/7 is always 80x25
 	jz	set80
 
 	movb	%gs:(0x0484), %al	# This is EGA+ -- beware of 80x50 etc.
@@ -719,7 +719,7 @@
  	orb	$0xe2, %al			# Set correct sync polarity
  	outb	%al, %dx
 	popw	%dx
-	movw	$0x501e, force_size
+	movw	$0x501e, force_size - start
 	stc					# That's all.
 	ret
 
@@ -728,7 +728,7 @@
 	call	set_80x30			# Set 480 scans
 	call	set14				# And 14-pt font
 	movw	$0xdb12, %ax			# VGA vertical display end
-	movw	$0x5022, force_size
+	movw	$0x5022, force_size - start
 setvde:	call	outidx
 	stc
 	ret
@@ -738,7 +738,7 @@
 	call	set_80x30			# Set 480 scans
 	call	set_8pt				# And 8-pt font
 	movw	$0xdf12, %ax			# VGA vertical display end
-	movw	$0x503c, force_size
+	movw	$0x503c, force_size - start
 	jmp	setvde
 
 # Special hack for ThinkPad graphics
@@ -747,7 +747,7 @@
 	movw	$VIDEO_GFX_BIOS_AX, %ax
 	movw	$VIDEO_GFX_BIOS_BX, %bx
 	int	$0x10
-	movw	$VIDEO_GFX_DUMMY_RESOLUTION, force_size
+	movw	$VIDEO_GFX_DUMMY_RESOLUTION, force_size - start
 	stc
 #endif
 	ret
@@ -756,53 +756,53 @@
 
 # Store screen contents to temporary buffer.
 store_screen:
-	cmpb	$0, do_restore			# Already stored?
+	cmpb	$0, do_restore - start		# Already stored?
 	jnz	stsr
 
-	testb	$CAN_USE_HEAP, loadflags	# Have we space for storing?
+	testb	$CAN_USE_HEAP, loadflags -start	# Have we space for storing?
 	jz	stsr
 	
 	pushw	%ax
 	pushw	%bx
-	pushw	force_size			# Don't force specific size
-	movw	$0, force_size
+	pushw	force_size - start		# Don't force specific size
+	movw	$0, force_size - start
 	call	mode_params			# Obtain params of current mode
-	popw	force_size
+	popw	force_size - start
 	movb	%fs:(PARAM_VIDEO_LINES), %ah
 	movb	%fs:(PARAM_VIDEO_COLS), %al
 	movw	%ax, %bx			# BX=dimensions
 	mulb	%ah
 	movw	%ax, %cx			# CX=number of characters
 	addw	%ax, %ax			# Calculate image size
-	addw	$modelist+1024+4, %ax
-	cmpw	heap_end_ptr, %ax
+	addw	$modelist+1024+4-start, %ax
+	cmpw	heap_end_ptr - start, %ax
 	jnc	sts1				# Unfortunately, out of memory
 
 	movw	%fs:(PARAM_CURSOR_POS), %ax	# Store mode params
-	leaw	modelist+1024, %di
+	leaw	modelist+1024-start, %di
 	stosw
 	movw	%bx, %ax
 	stosw
 	pushw	%ds				# Store the screen
-	movw	video_segment, %ds
+	movw	video_segment - start, %ds
 	xorw	%si, %si
 	rep
 	movsw
 	popw	%ds
-	incb	do_restore			# Screen will be restored later
+	incb	do_restore - start		# Screen will be restored later
 sts1:	popw	%bx
 	popw	%ax
 stsr:	ret
 
 # Restore screen contents from temporary buffer.
 restore_screen:
-	cmpb	$0, do_restore			# Has the screen been stored?
+	cmpb	$0, do_restore - start		# Has the screen been stored?
 	jz	res1
 
 	call	mode_params			# Get parameters of current mode
 	movb	%fs:(PARAM_VIDEO_LINES), %cl
 	movb	%fs:(PARAM_VIDEO_COLS), %ch
-	leaw	modelist+1024, %si		# Screen buffer
+	leaw	modelist+1024-start, %si	# Screen buffer
 	lodsw					# Set cursor position
 	movw	%ax, %dx
 	cmpb	%cl, %dh
@@ -841,7 +841,7 @@
 	xchgb	%ch, %cl
 	movw	%cx, %bp			# BP=width of dest. line
 	pushw	%es
-	movw	video_segment, %es
+	movw	video_segment - start, %es
 	xorw	%di, %di			# Move the data
 	addw	%bx, %bx			# Convert BX and BP to _bytes_
 	addw	%bp, %bp
@@ -879,14 +879,14 @@
 # Returns address of the end of the table in DI, the end is marked
 # with a ASK_VGA ID.
 mode_table:
-	movw	mt_end, %di			# Already filled?
+	movw	mt_end - start, %di		# Already filled?
 	orw	%di, %di
 	jnz	mtab1x
 	
-	leaw	modelist, %di			# Store standard modes:
+	leaw	modelist - start, %di		# Store standard modes:
 	movl	$VIDEO_80x25 + 0x50190000, %eax	# The 80x25 mode (ALL)
 	stosl
-	movb	adapter, %al			# CGA/MDA/HGA -- no more modes
+	movb	adapter - start, %al		# CGA/MDA/HGA -- no more modes
 	orb	%al, %al
 	jz	mtabe
 	
@@ -899,12 +899,12 @@
 
 mtab1x:	jmp	mtab1
 
-mtabv:	leaw	vga_modes, %si			# All modes for std VGA
+mtabv:	leaw	vga_modes - start, %si		# All modes for std VGA
 	movw	$vga_modes_end-vga_modes, %cx
 	rep	# I'm unable to use movsw as I don't know how to store a half
 	movsb	# of the expression above to cx without using explicit shr.
 
-	cmpb	$0, scanning			# Mode scan requested?
+	cmpb	$0, scanning - start		# Mode scan requested?
 	jz	mscan1
 	
 	call	mode_scan
@@ -929,13 +929,13 @@
 mtabe:
 
 #ifdef CONFIG_VIDEO_COMPACT
-	leaw	modelist, %si
+	leaw	modelist - start, %si
 	movw	%di, %dx
 	movw	%si, %di
 cmt1:	cmpw	%dx, %si			# Scan all modes
 	jz	cmt2
 
-	leaw	modelist, %bx			# Find in previous entries
+	leaw	modelist - start, %bx		# Find in previous entries
 	movw	2(%si), %cx
 cmt3:	cmpw	%bx, %si
 	jz	cmt4
@@ -956,8 +956,8 @@
 #endif	/* CONFIG_VIDEO_COMPACT */
 
 	movw	$ASK_VGA, (%di)			# End marker
-	movw	%di, mt_end
-mtab1:	leaw	modelist, %si			# SI=mode list, DI=list end
+	movw	%di, mt_end - start
+mtab1:	leaw	modelist - start, %si		# SI=mode list, DI=list end
 ret0:	ret
 
 # Modes usable on all standard VGAs
@@ -984,7 +984,7 @@
 
 #ifdef CONFIG_VIDEO_VESA
 vesa_modes:
-	cmpb	$2, adapter			# VGA only
+	cmpb	$2, adapter - start		# VGA only
 	jnz	ret0
 
 	movw	%di, %bp			# BP=original mode table end
@@ -1001,7 +1001,7 @@
 	cmpw	$0x4153, 0x202(%di)
 	jnz	ret0
 	
-	movw	$vesa_name, card_name		# Set name to "VESA VGA"
+	movw	$vesa_name - start, card_name - start	# Set name to "VESA VGA"
 	pushw	%gs
 	lgsw	0x20e(%di), %si			# GS:SI=mode list
 	movw	$128, %cx			# Iteration limit
@@ -1066,11 +1066,11 @@
 	cmpw	$5, %bx
 	jnc	vesan
 
-	movw	vesa_text_mode_table(%bx), %ax
+	movw	vesa_text_mode_table - start(%bx), %ax
 	movw	%ax, 2(%di)
 vesaok:	addw	$4, %di				# The mode is valid. Store it.
 vesan:	loop	vesa1			# Next mode. Limit exceeded => error
-vesae:	leaw	vesaer, %si
+vesae:	leaw	vesaer - start, %si
 	call	prtstr
 	movw	%bp, %di			# Discard already found modes.
 vesar:	popw	%gs
@@ -1160,7 +1160,7 @@
 	jz	dosvga
 	
 	movw	%bp, %si			# Found, copy the modes
-	movb	svga_prefix, %ah
+	movb	svga_prefix - start, %ah
 cpsvga:	lodsb
 	orb	%al, %al
 	jz	didsv
@@ -1169,7 +1169,7 @@
 	movsw
 	jmp	cpsvga
 
-didsv:	movw	%si, card_name			# Store pointer to card name
+didsv:	movw	%si, card_name - start		# Store pointer to card name
 didsv1:	ret
 
 # Table of all known SVGA cards. For each card, we store a pointer to
@@ -1741,7 +1741,7 @@
 	cmpb	%bh, %al
 	jne	isnot
 	
-	movb	$VIDEO_FIRST_V7>>8, svga_prefix # Use special mode switching
+	movb	$VIDEO_FIRST_V7>>8, svga_prefix - start	# Use special mode switching
 	ret
 
 video7_md:
diff -uNr linux-2.5.7.boot2.32bit_entry/include/asm-i386/e820.h linux-2.5.7.boot2.pic16/include/asm-i386/e820.h
--- linux-2.5.7.boot2.32bit_entry/include/asm-i386/e820.h	Fri Aug 18 10:30:51 2000
+++ linux-2.5.7.boot2.pic16/include/asm-i386/e820.h	Tue Apr  2 11:50:27 2002
@@ -15,6 +15,7 @@
 #define E820MAP	0x2d0		/* our map */
 #define E820MAX	32		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
+#define E820ENTRY_SIZE 20	/* size of an E820MAP entry */
 
 #define E820_RAM	1
 #define E820_RESERVED	2
