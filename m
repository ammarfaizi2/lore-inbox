Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267868AbTAHTz4>; Wed, 8 Jan 2003 14:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbTAHTzz>; Wed, 8 Jan 2003 14:55:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54024 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267889AbTAHTzC>; Wed, 8 Jan 2003 14:55:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Killing off the boot sector (was: [STATUS 2.5]  January 8, 2002)
Date: 8 Jan 2003 12:03:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avi06f$89g$1@cesium.transmeta.com>
References: <3E1C2208.6727.5370CB@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3E1C2208.6727.5370CB@localhost>
By author:    "Guillaume Boissiere" <boissiere@adiglobal.com>
In newsgroup: linux.dev.kernel
> 
> 179  nor  bugme-janitors@lists.osdl.org  OPEN   boot from 21
> sec/track floppy  
> 

Can we *please* kill off the stupid in-kernel boot sector?  The
probing method it uses to determine geometry is unreliable (doesn't
work on anything but true legacy floppies, not IDE, not USB, not
firewire); it generates these kinds of requests; doesn't handle
large-size kernels; hard-codes the use of address 0x90000 which isn't
available on all machines; and overall promotes what's fundamentally
bad practice.

People keep asking what's the harm in keeping it, and the answer is,
quite simply: "because people continue to try to use it."

Here is a patch that guts it to print an error message.  It's even
tested.

--- linux-2.5.54/arch/i386/boot/bootsect.S.dist	Wed Jan  8 11:35:52 2003
+++ linux-2.5.54/arch/i386/boot/bootsect.S	Wed Jan  8 11:52:16 2003
@@ -4,29 +4,13 @@
  *	modified by Drew Eckhardt
  *	modified by Bruce Evans (bde)
  *	modified by Chris Noe (May 1999) (as86 -> gas)
- *
- * 360k/720k disk support: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
+ *	gutted by H. Peter Anvin (Jan 2003)
  *
  * BIG FAT NOTE: We're in real mode using 64k segments.  Therefore segment
  * addresses must be multiplied by 16 to obtain their respective linear
  * addresses. To avoid confusion, linear addresses are written using leading
  * hex while segment addresses are written as segment:offset.
  *
- * bde - should not jump blindly, there may be systems with only 512K low
- * memory.  Use int 0x12 to get the top of memory, etc.
- *
- * It then loads 'setup' directly after itself (0x90200), and the system
- * at 0x10000, using BIOS interrupts. 
- *
- * NOTE! currently system is at most (8*65536-4096) bytes long. This should 
- * be no problem, even in the future. I want to keep it simple. This 508 kB
- * kernel size should be enough, especially as this doesn't contain the
- * buffer cache as in minix (and especially now that the kernel is 
- * compressed :-)
- *
- * The loader has been made as simple as possible, and continuous
- * read errors will result in a unbreakable loop. Reboot by hand. It
- * loads pretty fast by getting whole tracks at a time whenever possible.
  */
 
 #include <asm/boot.h>
@@ -59,359 +43,47 @@
 .global _start
 _start:
 
-# First things first. Move ourself from 0x7C00 -> 0x90000 and jump there.
+	# Normalize the start address
+	jmpl	$BOOTSEG, $start2
 
-	movw	$BOOTSEG, %ax
-	movw	%ax, %ds		# %ds = BOOTSEG
-	movw	$INITSEG, %ax
-	movw	%ax, %es		# %ax = %es = INITSEG
-	movw	$256, %cx
-	subw	%si, %si
-	subw	%di, %di
-	cld
-	rep
-	movsw
-	ljmp	$INITSEG, $go
-
-# bde - changed 0xff00 to 0x4000 to use debugger at 0x6400 up (bde).  We
-# wouldn't have to worry about this if we checked the top of memory.  Also
-# my BIOS can be configured to put the wini drive tables in high memory
-# instead of in the vector table.  The old stack might have clobbered the
-# drive table.
-
-go:	movw	$0x4000-12, %di		# 0x4000 is an arbitrary value >=
-					# length of bootsect + length of
-					# setup + room for stack;
-					# 12 is disk parm size.
-	movw	%ax, %ds		# %ax and %es already contain INITSEG
+start2:
+	movw	%cs, %ax
+	movw	%ax, %ds
+	movw	%ax, %es
 	movw	%ax, %ss
-	movw	%di, %sp		# put stack at INITSEG:0x4000-12.
+	movw	$0x7c00, %sp
+	sti
+	cld
 
-# Many BIOS's default disk parameter tables will not recognize
-# multi-sector reads beyond the maximum sector number specified
-# in the default diskette parameter tables - this may mean 7
-# sectors in some cases.
-#
-# Since single sector reads are slow and out of the question,
-# we must take care of this by creating new parameter tables
-# (for the first disk) in RAM.  We will set the maximum sector
-# count to 36 - the most we will encounter on an ED 2.88.  
-#
-# High doesn't hurt.  Low does.
-#
-# Segments are as follows: %cs = %ds = %es = %ss = INITSEG, %fs = 0,
-# and %gs is unused.
-
-	movw	%cx, %fs		# %fs = 0
-	movw	$0x78, %bx		# %fs:%bx is parameter table address
-	pushw	%ds
-	ldsw	%fs:(%bx), %si		# %ds:%si is source
-	movb	$6, %cl			# copy 12 bytes
-	pushw	%di			# %di = 0x4000-12.
-	rep				# don't worry about cld
-	movsw				# already done above
-	popw	%di
-	popw	%ds
-	movb	$36, 0x4(%di)		# patch sector count
-	movw	%di, %fs:(%bx)
-	movw	%es, %fs:2(%bx)
-
-# Get disk drive parameters, specifically number of sectors/track.
-
-# It seems that there is no BIOS call to get the number of sectors.
-# Guess 36 sectors if sector 36 can be read, 18 sectors if sector 18
-# can be read, 15 if sector 15 can be read.  Otherwise guess 9.
-# Note that %cx = 0 from rep movsw above.
+	movw	$bugger_off_msg, %si
 
-	movw	$disksizes, %si		# table of sizes to try
-probe_loop:
+msg_loop:
 	lodsb
-	cbtw				# extend to word
-	movw	%ax, sectors
-	cmpw	$disksizes+4, %si
-	jae	got_sectors		# If all else fails, try 9
-
-	xchgw	%cx, %ax		# %cx = track and sector
-	xorw	%dx, %dx		# drive 0, head 0
-	movw	$0x0200, %bx		# address = 512, in INITSEG (%es = %cs)
-	movw	$0x0201, %ax		# service 2, 1 sector
-	int	$0x13
-	jc	probe_loop		# try next value
-
-got_sectors:
-	movb	$0x03, %ah		# read cursor pos
-	xorb	%bh, %bh
-	int	$0x10
-	movw	$9, %cx
-	movb	$0x07, %bl		# page 0, attribute 7 (normal)
-					# %bh is set above; int10 doesn't
-					# modify it
-	movw	$msg1, %bp
-	movw	$0x1301, %ax		# write string, move cursor
-	int	$0x10			# tell the user we're loading..
-
-# Load the setup-sectors directly after the moved bootblock (at 0x90200).
-# We should know the drive geometry to do it, as setup may exceed first
-# cylinder (for 9-sector 360K and 720K floppies).
-
-	movw	$0x0001, %ax		# set sread (sector-to-read) to 1 as
-	movw	$sread, %si		# the boot sector has already been read
-	movw	%ax, (%si)
-
-	call	kill_motor		# reset FDC
-	movw	$0x0200, %bx		# address = 512, in INITSEG
-next_step:
-	movb	setup_sects, %al
-	movw	sectors, %cx
-	subw	(%si), %cx		# (%si) = sread
-	cmpb	%cl, %al
-	jbe	no_cyl_crossing
-	movw	sectors, %ax
-	subw	(%si), %ax		# (%si) = sread
-no_cyl_crossing:
-	call	read_track
-	pushw	%ax			# save it
-	call	set_next		# set %bx properly; it uses %ax,%cx,%dx
-	popw	%ax			# restore
-	subb	%al, setup_sects	# rest - for next step
-	jnz	next_step
-
-	pushw	$SYSSEG
-	popw	%es			# %es = SYSSEG
-	call	read_it
-	call	kill_motor
-	call	print_nl
-
-# After that we check which root-device to use. If the device is
-# defined (!= 0), nothing is done and the given device is used.
-# Otherwise, one of /dev/fd0H2880 (2,32) or /dev/PS0 (2,28) or /dev/at0 (2,8)
-# depending on the number of sectors we pretend to know we have.
-
-# Segments are as follows: %cs = %ds = %ss = INITSEG,
-#	%es = SYSSEG, %fs = 0, %gs is unused.
-
-	movw	root_dev, %ax
-	orw	%ax, %ax
-	jne	root_defined
-
-	movw	sectors, %bx
-	movw	$0x0208, %ax		# /dev/ps0 - 1.2Mb
-	cmpw	$15, %bx
-	je	root_defined
-
-	movb	$0x1c, %al		# /dev/PS0 - 1.44Mb
-	cmpw	$18, %bx
-	je	root_defined
-
-	movb	$0x20, %al		# /dev/fd0H2880 - 2.88Mb
-	cmpw	$36, %bx
-	je	root_defined
-
-	movb	$0, %al			# /dev/fd0 - autodetect
-root_defined:
-	movw	%ax, root_dev
-
-# After that (everything loaded), we jump to the setup-routine
-# loaded directly after the bootblock:
-
-	ljmp	$SETUPSEG, $0
-
-# These variables are addressed via %si register as it gives shorter code.
-
-sread:	.word 0				# sectors read of current track
-head:	.word 0				# current head
-track:	.word 0				# current track
-
-# This routine loads the system at address SYSSEG, making sure
-# no 64kB boundaries are crossed. We try to load it as fast as
-# possible, loading whole tracks whenever we can.
-
-read_it:
-	movw	%es, %ax		# %es = SYSSEG when called
-	testw	$0x0fff, %ax
-die:	jne	die			# %es must be at 64kB boundary
-	xorw	%bx, %bx		# %bx is starting address within segment
-rp_read:
-#ifdef __BIG_KERNEL__			# look in setup.S for bootsect_kludge
-	bootsect_kludge = 0x220		# 0x200 + 0x20 which is the size of the
-	lcall	*bootsect_kludge	# bootsector + bootsect_kludge offset
-#else
-	movw	%es, %ax
-	subw	$SYSSEG, %ax
-	movw	%bx, %cx
-	shr	$4, %cx
-	add	%cx, %ax		# check offset
-#endif
-	cmpw	syssize, %ax		# have we loaded everything yet?
-	jbe	ok1_read
-
-	ret
-
-ok1_read:
-	movw	sectors, %ax
-	subw	(%si), %ax		# (%si) = sread
-	movw	%ax, %cx
-	shlw	$9, %cx
-	addw	%bx, %cx
-	jnc	ok2_read
-
-	je	ok2_read
-
-	xorw	%ax, %ax
-	subw	%bx, %ax
-	shrw	$9, %ax
-ok2_read:
-	call	read_track
-	call	set_next
-	jmp	rp_read
-
-read_track:
-	pusha
-	pusha	
-	movw	$0xe2e, %ax 		# loading... message 2e = .
-	movw	$7, %bx
- 	int	$0x10
-	popa		
-
-# Accessing head, track, sread via %si gives shorter code.
-
-	movw	4(%si), %dx		# 4(%si) = track
-	movw	(%si), %cx		# (%si)  = sread
-	incw	%cx
-	movb	%dl, %ch
-	movw	2(%si), %dx		# 2(%si) = head
-	movb	%dl, %dh
-	andw	$0x0100, %dx
-	movb	$2, %ah
-	pushw	%dx			# save for error dump
-	pushw	%cx
-	pushw	%bx
-	pushw	%ax
-	int	$0x13
-	jc	bad_rt
-
-	addw	$8, %sp
-	popa
-	ret
-
-set_next:
-	movw	%ax, %cx
-	addw	(%si), %ax		# (%si) = sread
-	cmp	sectors, %ax
-	jne	ok3_set
-	movw	$0x0001, %ax
-	xorw	%ax, 2(%si)		# change head
-	jne	ok4_set
-	incw	4(%si)			# next track
-ok4_set:
-	xorw	%ax, %ax
-ok3_set:
-	movw	%ax, (%si)		# set sread
-	shlw	$9, %cx
-	addw	%cx, %bx
-	jnc	set_next_fin
-	movw	%es, %ax
-	addb	$0x10, %ah
-	movw	%ax, %es
+	andb	%al, %al
+	jz	die
+	mov	$0xe, %ah
 	xorw	%bx, %bx
-set_next_fin:
-	ret
-
-bad_rt:
-	pushw	%ax			# save error code
-	call	print_all		# %ah = error, %al = read
-	xorb	%ah, %ah
-	xorb	%dl, %dl
-	int	$0x13
-	addw	$10, %sp
-	popa
-	jmp read_track
-
-# print_all is for debugging purposes.  
-#
-# it will print out all of the registers.  The assumption is that this is
-# called from a routine, with a stack frame like
-#
-#	%dx 
-#	%cx
-#	%bx
-#	%ax
-#	(error)
-#	ret <- %sp
- 
-print_all:
-	movw	$5, %cx			# error code + 4 registers
-	movw	%sp, %bp
-print_loop:
-	pushw	%cx			# save count remaining
-	call	print_nl		# <-- for readability
-	cmpb	$5, %cl
-	jae	no_reg			# see if register name is needed
-	
-	movw	$0xe05 + 'A' - 1, %ax
-	subb	%cl, %al
-	int	$0x10
-	movb	$'X', %al
 	int	$0x10
-	movb	$':', %al
-	int	$0x10
-no_reg:
-	addw	$2, %bp			# next register
-	call	print_hex		# print it
-	popw	%cx
-	loop	print_loop
-	ret
+	jmp	msg_loop
 
-print_nl:
-	movw	$0xe0d, %ax		# CR
-	int	$0x10
-	movb	$0xa, %al		# LF
-	int 	$0x10
-	ret
-
-# print_hex is for debugging purposes, and prints the word
-# pointed to by %ss:%bp in hexadecimal.
-
-print_hex:
-	movw	$4, %cx			# 4 hex digits
-	movw	(%bp), %dx		# load word into %dx
-print_digit:
-	rolw	$4, %dx			# rotate to use low 4 bits
-	movw	$0xe0f, %ax		# %ah = request
-	andb	%dl, %al		# %al = mask for nybble
-	addb	$0x90, %al		# convert %al to ascii hex
-	daa				# in only four instructions!
-	adc	$0x40, %al
-	daa
-	int	$0x10
-	loop	print_digit
-	ret
+die:
+	# Allow the user to press a key, then reboot
+	xorw	%ax, %ax
+	int	$0x16
+	int	$0x19
 
-# This procedure turns off the floppy drive motor, so
-# that we enter the kernel in a known state, and
-# don't have to worry about it later.
-# NOTE: Doesn't save %ax or %dx; do it yourself if you need to.
-
-kill_motor:
-#if 1
-	xorw	%ax, %ax		# reset FDC
-	xorb	%dl, %dl
-	int	$0x13
-#else
-	movw	$0x3f2, %dx
-	xorb	%al, %al
-	outb	%al, %dx
-#endif
-	ret
 
-sectors:	.word 0
-disksizes:	.byte 36, 18, 15, 9
-msg1:		.byte 13, 10
-		.ascii "Loading"
+bugger_off_msg:
+	.ascii	"Direct booting from floppy is no longer supported.\r\n"
+	.ascii	"Please use a boot loader program instead.\r\n"
+	.ascii	"\n"
+	.ascii	"Remove disk and press any key to reboot . . .\r\n"
+	.byte	0
+	
 
-# XXX: This is a fairly snug fit.
+	# Kernel attributes; used by setup
 
-.org 497
+	.org 497
 setup_sects:	.byte SETUPSECTS
 root_flags:	.word ROOT_RDONLY
 syssize:	.word SYSSIZE
--- linux-2.5.54/arch/i386/boot/tools/build.c.dist	Wed Jan  1 19:22:04 2003
+++ linux-2.5.54/arch/i386/boot/tools/build.c	Wed Jan  8 11:53:32 2003
@@ -150,13 +150,10 @@
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	/* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
+	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
+	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
 		die("System is too big. Try using %smodules.",
 			is_big_kernel ? "" : "bzImage or ");
-	if (sys_size > 0xefff)
-		fprintf(stderr,"warning: kernel is too big for standalone boot "
-		    "from floppy\n");
 	while (sz > 0) {
 		int l, n;
 

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
