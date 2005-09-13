Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVIMTEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVIMTEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVIMTEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:04:11 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:54539 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S964994AbVIMTEJ (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:04:09 -0400
Message-ID: <432722A1.8030302@tuxrocks.com>
Date: Tue, 13 Sep 2005 13:04:01 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pascal.bellard@ads-lu.com
CC: Riley@Williams.Name, Linux-Kernel@vger.kernel.org,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [i386 BOOT CODE] kernel bootable again
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192>
In-Reply-To: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/mixed;
 boundary="------------050004020807060004040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004020807060004040109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pascal Bellard wrote:
> Hello,
> 
> Please find attached a patch to build i386/x86_64 kernel directly
> bootable. It may be usefull for rescue floppies and installation
> floppies.

Pascal,

In commit f8eeaaf4180334a8e5c3582fe62a5f8176a8c124, build.c has already
changed, and I don't believe it's very compatible with this change.

See
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8eeaaf4180334a8e5c3582fe62a5f8176a8c124

Also, we'll need to see comments from H. Peter Anvin on this patch.
CC'ing him.


> System sector count is updated by tools/bluid.c at offset 495. The
> system could be up to 32 Mb long.
> 
> -- support any drive geometry --
> 
> Disk geometry detection assumes that no error raises on first track.
> First track is read sector by sector and the first error determinates
> the sectors per track count. Next, reads are performed track by track.
> Tested on floppy H2/S18 and harddisk H16/S63. Should work on
> every exotic drive supporting Int13h CHS.
> 
> -- cmdline support --
> 
> If ram_size (offset 504) bit 13 is set, the kernel cmdline
> is load from the sector following the kernel image.
> 
> If Ctrl, Alt, Shift or CapsLock is pressed the kernel cmdline is
> prompted until Enter key. BackSpace is supported.
> 
> Regards,
> 
> -pascal

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDJyKhaI0dwg4A47wRAjMoAJ9laL5kvIzkbJAxigSJahqkdnmx8gCg6dOy
V6ML9fJQjmfjcdxNGnbSuZ0=
=7P9o
-----END PGP SIGNATURE-----

--------------050004020807060004040109
Content-Type: text/x-patch;
 name="linux-2_6_13-bootblock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2_6_13-bootblock.patch"

diff -purN linux-2.6.13/arch/i386/boot/bootsect.S linux-2.6.13-bootblock/arch/i386/boot/bootsect.S
--- linux-2.6.13/arch/i386/boot/bootsect.S	2005-09-12 10:37:52.000000000 +0200
+++ linux-2.6.13-bootblock/arch/i386/boot/bootsect.S	2005-09-12 10:40:19.000000000 +0200
@@ -4,20 +4,31 @@
  *	modified by Drew Eckhardt
  *	modified by Bruce Evans (bde)
  *	modified by Chris Noe (May 1999) (as86 -> gas)
- *	gutted by H. Peter Anvin (Jan 2003)
+ *
+ *      rewritten to support up to 32Mb kernel, cmdline
+ *      and any disk geometry by <pascal.bellard@ads-lu.com>
  *
  * BIG FAT NOTE: We're in real mode using 64k segments.  Therefore segment
  * addresses must be multiplied by 16 to obtain their respective linear
  * addresses. To avoid confusion, linear addresses are written using leading
  * hex while segment addresses are written as segment:offset.
  *
+ * bde - should not jump blindly, there may be systems with only 512K low
+ * memory.  Use int 0x12 to get the top of memory, etc.
+ *
+ * It then loads 'setup' directly after itself (0x90200), and the system
+ * at 0x10000, using BIOS interrupts. 
+ *
+ * The loader has been made as simple as possible, and continuous
+ * read errors will result in a unbreakable loop. Reboot by hand. It
+ * loads pretty fast by getting whole tracks at a time whenever possible.
  */
 
 #include <asm/boot.h>
 
 SETUPSECTS	= 4			/* default nr of setup-sectors */
 BOOTSEG		= 0x07C0		/* original address of boot-sector */
-INITSEG		= DEF_INITSEG		/* we move boot here - out of the way */
+INITSEG		= DEF_INITSEG		/* we load boot here - out of the way */
 SETUPSEG	= DEF_SETUPSEG		/* setup starts here */
 SYSSEG		= DEF_SYSSEG		/* system loaded at 0x10000 (65536) */
 SYSSIZE		= DEF_SYSSIZE		/* system size: # of 16-byte clicks */
@@ -25,6 +36,12 @@ SYSSIZE		= DEF_SYSSIZE		/* system size: 
 ROOT_DEV	= 0 			/* ROOT_DEV is now written by "build" */
 SWAP_DEV	= 0			/* SWAP_DEV is now written by "build" */
 
+/* some extra features */
+#define DISPLAY_KERNEL_VERSION		as soon as possible
+#define	EDIT_CMDLINE			on hotkey
+#define	LOAD_CMDLINE			according to bit ramsize.13
+#define EXTRA_DEVICES			to fill root_device
+
 #ifndef SVGA_MODE
 #define SVGA_MODE ASK_VGA
 #endif
@@ -42,57 +59,470 @@ SWAP_DEV	= 0			/* SWAP_DEV is now writte
 
 .global _start
 _start:
+	cld				# assume nothing
+	movw	$INITSEG, %ax
+	movw	%ax, %es		# %ax = %es = INITSEG
+#if MOVE_BOOTSECTOR
+# First things first. Move ourself from 0x7C00 -> 0x90000 and jump there.
+	movw	$BOOTSEG, %cx
+	movw	%cx, %ds		# %ds = BOOTSEG
+	movb	$1, %ch			# %cx = 256
+	subw	%si, %si
+	subw	%di, %di
+	rep
+	movsw
+	ljmp	$INITSEG, $go
+go:	
+#else
+	xorw	%cx, %cx		# %cx = 0
+#endif
 
-	# Normalize the start address
-	jmpl	$BOOTSEG, $start2
+# bde - changed 0xff00 to 0x4000 to use debugger at 0x6400 up (bde).  We
+# wouldn't have to worry about this if we checked the top of memory.  Also
+# my BIOS can be configured to put the wini drive tables in high memory
+# instead of in the vector table.  The old stack might have clobbered the
+# drive table.
+
+	movw	$0x4000-12, %di		# 0x4000 is an arbitrary value >=
+					# length of bootsect + length of
+					# setup + room for stack;
+					# 12 is disk parm size.
+					# gdt will heat 48 more bytes.
+	movw	%ax, %ss		# %ax and %es already contain INITSEG
+	movw	%di, %sp		# put stack at INITSEG:0x4000-12.
+
+# Many BIOS's default disk parameter tables will not recognize
+# multi-sector reads beyond the maximum sector number specified
+# in the default diskette parameter tables - this may mean 7
+# sectors in some cases.
+#
+# Since single sector reads are slow and out of the question,
+# we must take care of this by creating new parameter tables
+# (for the first disk) in RAM.  We can set the maximum sector
+# count to 36 - the most we will encounter on an ED 2.88.  
+#
+# High doesn't hurt.  Low does.  Let's use the max: 63
+#
+# Segments are as follows: %es = %ss = INITSEG,
+# %fs and %gs are unused.
+
+	movw	$0x78, %bx		# %ds:%bx is parameter table address
+	movw	%cx, %ds		# %ds = 0
+	ldsw	(%bx), %si		# %ds:%si is source
+	movb	$6, %cl			# copy 12 bytes
+	rep				# don't worry about cld
+	movsw				# already done above
+	movw	%cx, %ds		# %ds = 0
+	movw	%sp, (%bx)		# %sp = 0x4000-12
+	movw	%es, 2(%bx)
+	pushw	%es
+	popw	%ds			# now %ds = %es = %ss = INITSEG
+	movb	$63, 0x4-12(%di)	# patch sector count, %di = 0x4000
+
+	cli
+	cbw				# %ax = 0 : geometry unknown yet
+	xorb	%dh, %dh		# head 0, current drive
+	incw	%cx			# cylinder 0, sector 1
+	movw	%cx, %di		# read 1 sector
+	call	read_first_sector	# read bootsector again to have
+					# access to data segment
+
+#ifndef	DISPLAY_KERNEL_VERSION
+	movw	$msg1, %si
+	call	puts
+#endif
 
-start2:
-	movw	%cs, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %ss
-	movw	$0x7c00, %sp
-	sti
-	cld
+# Load the setup-sectors directly after the moved bootblock (at 0x90200).
 
-	movw	$bugger_off_msg, %si
+	movb	setup_sects, %al
+#ifdef CHECK_SETUP_SIZE
+	orb	%al, %al
+	jne	setup_size_ok
+	movb	$SETUPSECTS, %al
+setup_size_ok:	
+#endif
+	cbw
+	xchg	%ax, %di
+	call	read_sectors		# read setup
+
+#ifdef	DISPLAY_KERNEL_VERSION
+#define kernel_version	0xE
+	movw	$0x200,%si
+	addw	kernel_version(%si),%si	# starting protocol 2.00, Kernel 1.3.73
+	call	puts			# show which kernel we are loading
+#endif
 
-msg_loop:
-	lodsb
-	andb	%al, %al
-	jz	die
-	movb	$0xe, %ah
-	movw	$7, %bx
-	int	$0x10
-	jmp	msg_loop
+# This routine loads the system at address SYSSEG, making sure
+# no 64kB boundaries are crossed. We try to load it as fast as
+# possible, loading whole tracks whenever we can.
+
+#ifdef __BIG_KERNEL__
+type_of_loader	=	528
+	movw	$24, %cx		# allocate 48 bytes in stack
+init_gdt:
+	push	$0			#   initialized with 0
+	loop	init_gdt
+	movw	%sp, %si		# for bootsect_gdt
+	movw	$0x9300+(SYSSEG/4096), %ax	# source = SYSSEG
+	cwd
+	movw	%ax, 20(%si)		# bootsect_src_base+2
+	movb	$0x10-1, %al		# destination = 0x100000
+	movw	%ax, 28(%si)		# bootsect_dst_base+2
+	movw	%dx, 16(%si)		# bootsect_src = 64Kb
+	movw	%dx, 24(%si)		# bootsect_dst = 64Kb
+	movb	%dl, type_of_loader	# loader type = 0xFF
+syslp:
+	movw	$SYSSEG, %ax
+	movw	%ax, %es
+	movw	$128,%di		# 64Kb in sectors
+	subw	%di, sys_sects
+	pushf
+	jnc	not_last
+	addw	sys_sects, %di
+not_last:
+	call	read_sectors
+	incw	28(%si)			# bootsect_dst_base+2
+	movw	$0x8000, %cx		# full 64K
+	movb	$0x87, %ah
+	push	%ss
+	pop	%es			# gdt in es:si
+	int	$0x15
+	popf
+	ja	syslp
+#else
+	movw	$SYSSEG, %ax
+	movw	%ax, %es
+syslp:
+	movw	$128*32,%ax		# 64Kb in paragraphs
+	subw	%ax, syssize
+	pushf
+	jnc	not_last
+	addw	syssize, %ax
+not_last:
+	movb	$5, %cl			# paragraphs -> sectors
+	shrw	%cl, %ax
+	xchg	%ax, %di
+	call	read_sectors
+	popf
+	ja	syslp
+#endif
 
-die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
-	int	$0x16
-	int	$0x19
+# After that we check which root-device to use. If the device is
+# defined (!= 0), nothing is done and the given device is used.
+# Otherwise, one of /dev/fd0H2880 (2,32) or /dev/PS0 (2,28) or /dev/at0 (2,8)
+# depending on the number of sectors we pretend to know we have.
+
+
+	movw	root_dev, %ax
+	orw	%ax, %ax
+	jnz	root_defined
+
+	movw	$floppy_table,%si
+scan_floppy_table:
+	lodsw
+	cmpb	limits, %ah
+	je	set_root
+	jno	scan_floppy_table
+set_root:
+	movb	$2, %ah
+	addb	%dl, %al		# add current (floppy) drive
+	movw	%ax, root_dev
+root_defined:
+
+#if defined(LOAD_CMDLINE) || defined(EDIT_CMDLINE)
+#define BUFFER	0x7F00
+	movw	$BUFFER, %si
+	movw	%si, (%si)		# default : no cmdline
+#endif
 
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
+#ifdef	LOAD_CMDLINE
+	testb	$0x20,ram_size+1	# bit 11 to 13 where unused
+					# now bit 13 means: load cmdline
+	jz	nocmd
+	movw	$BUFFER/16+INITSEG, %ax
+	movw	%ax, %es
+	movw	$1, %di			# cmdline = 512 bytes max
+	call	read_sectors
+nocmd:
+#endif
 
+#define RSHFT   0x01
+#define LSHFT   0x02
+#define CTRL    0x04
+#define ALT     0x08
+#define SCRLCK  0x10
+#define NUMLCK  0x20
+#define CAPSLCK 0x40
+#define INSERT  0x80
+
+#ifdef	EDIT_CMDLINE
+# The cmdline can be entered and modifed on hot key.
+# Only characters before the cursor are passed to the kernel.
+	movb	$2, %ah			# get keyboard status
+	int	$0x16
+	testb	$RSHFT|LSHFT|CTRL|ALT|CAPSLCK, %al
+	jz	nocmdline
+	pushw	%si
+	call	puts			# set %ah and %bx
+cmdlp:
+# if 1
+	movb	$32, %al		# clear end of line
+	int	$0x10			#  with Space
+	movb	$8, %al			#   and BackSpace
+	int	$0x10
+# endif
+	decw	%si
+cmdget:
+	cbw				# %ah = 0, get keyboard character
+	int	$0x16
+	cmpb	$8, %al			# BackSpace ?
+	je	cmdbs
+	cbw
+	movw	%ax, (%si)		# store end of string too
+	incw	%si
+	incw	%si
+cmdbs:
+	cmpw	$BUFFER, %si		# lower limit is checked
+	je	cmdget			#   but upper limit not
+	call	putc
+	cmpb	$13, %al		# Enter ?
+	jne	cmdlp
+	popw	%si
+nocmdline:
+#endif
 
-bugger_off_msg:
-	.ascii	"Direct booting from floppy is no longer supported.\r\n"
-	.ascii	"Please use a boot loader program instead.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot . . .\r\n"
-	.byte	0
+#if defined(LOAD_CMDLINE) || defined(EDIT_CMDLINE)
+#if 1
+cmd_line_magic	=	0x20
+cmd_line_offset	=	0x22
+	movw	$0xA33F, cmd_line_magic
+	movw	%si, cmd_line_offset
+#else
+# protocol >= 2.02, starting Kernel 2.4.0-test3-pre3
+cmd_line_ptr	=	0x228
+	movzx	%si, %eax
+	addl	$INITSEG*16, %eax
+	movl	%eax, cmd_line_ptr
+#endif
+emptycmdline:
+#endif
+	
+# This procedure turns off the floppy drive motor, so
+# that we enter the kernel in a known state, and
+# don't have to worry about it later.
+
+#if 1
+kill_motor:
+	xorw	%ax, %ax		# reset FDC
+	int	$0x13
+#else
+kill_motor:
+	movw	$0x3f2, %dx
+	xorb	%al, %al
+	outb	%al, %dx
+#endif
 
+	call	print_nl
 
-	# Kernel attributes; used by setup
+# After that (everything loaded), we jump to the setup-routine
+# loaded directly after the bootblock:
+# Segments are as follows: %ds = %ss = INITSEG
+
+	ljmp	$SETUPSEG, $0
+
+# read_sectors reads %di sectors into %es:0 buffer.
+# %es:0 is updated to the next memory location.
+# First, sectors are read sector by sector until
+# sector per track count is known. Then they are
+# read track by track.
+# Assume no error on first track.
+
+#define TRACK_BY_TRACK	load as fast as possible !
+#define SHOW_REGS	show int13 status & parameters
+
+check_limits:
+        cmpb    %al, %cl		# max sector known ?
+        ja	next_head		#   no -> store it
+        cmpb    %ah, %dh		# max head known ?
+        ja	next_track		#   no -> store it
+	pusha				# save context
+#ifdef SHOW_REGS
+	pushw	%es			# print %es (named EX)
+	pushw	%dx			# print %dx
+	pushw	%cx			# print %cx
+	xorw	%cx, %cx
+	pushw	%cx			# print %bx
+# ifdef TRACK_BY_TRACK
+	movb	$2, %bh
+# endif
+	pushw	%bx			# print %ax
+	movb	$6,%cl
+	jmp	print_all		# print %bp (status)
+print_loop:
+	movb	$0x6 + 'A' - 1, %al
+	subb	%cl, %al
+	movw	$regs, %si		# caller %si is saved
+	call	putcs			# putc(%al) + puts(%si)
+# it will print out all of the registers.
+	popw	%bp			# load word into %bp
+print_all:
+	pushw	%cx			# save count remaining
+	movb	$4, %cl			# 4 hex digits
+print_digit:
+	rolw	$4, %bp			# rotate to use low 4 bits
+	movb	$0x0f, %al
+	andw	%bp, %ax		# %al = mask for nybble
+	addb	$0x90, %al		# convert %al to ascii hex
+	daa				# in only four instructions!
+	adcb	$0x40, %al
+	daa
+	call	putc			# set %ah and %bx
+	loop	print_digit
+	movb	$0x20, %al		# SPACE
+	int	$0x10
+	popw	%cx
+	loop	print_loop
+	xchg	%ax, %cx		# %ah = 0
+#else
+	cbw				# %ah = 0
+#endif
+        int     $0x13			# reset controler
+	popa				# restore context
+read_sectorslp:
+read_first_sector:
+        pushw   %di			# sector count
+        pushw   %ax			# limits
+        pushw   %dx
+        pushw   %cx
+	xorw	%bx, %bx
+#ifdef TRACK_BY_TRACK
+	subb	%cl, %al		# sectors remaining in track
+	ja	tolastsect
+	movb	$1, %al			# 1 sector mini
+tolastsect:
+	cbw
+	cmpw	%di, %ax
+	jb	more1trk
+	movw	%di, %ax		# sectors to read
+more1trk:
+	push	%ax
+	movb	$2, %ah			# cmd: read chs
+#else
+        movw    $0x201, %ax		# sector by sector
+	push	%ax
+#endif
+        int     $0x13
+	xchg	%ax, %bp		# status
+        popw    %bx			# %ax 
+        popw    %cx
+        popw    %dx
+        popw    %ax			# limits
+        popw    %di			# sector count
+	jc	check_limits
+next_sector:
+#ifdef TRACK_BY_TRACK
+	subw	%bx,%di			# update sector counter
+	addw	%bx,%cx			# next sector
+	shlw	$5,%bx			# sectors -> paragraghs
+	movw	%es, %bp
+	addw	%bx, %bp
+#else
+	decw	%di			# update sector counter
+	incw	%cx			# next sector
+	movw	%es, %bp
+	addw	$32, %bp		# sector size in paragraghs
+#endif
+	movw	%bp, %es		# next location
+        cmpb    %al,%cl			# reach sector limit ?
+        jne     bdendlp
+next_head:
+        movb    %cl,%al
+        incb    %dh			# next head
+        movb    $1,%cl			# first sector
+        cmpb    %ah,%dh			# reach head limit ?
+        jne     bdendlp
+next_track:
+        movb    %dh,%ah
+        movb    $0,%dh			# first head
+# NOTE : support 256 cylinders max
+        incb    %ch			# next cylinder
+bdendlp:
+curdrive =	_start
+curdx	=	_start
+curcx	=	_start+2
+limits	=	_start+4
+	movw	%dx, curdx		# save disk state
+	movw	%cx, curcx
+	movw	%ax, limits
+read_sectors:
+	movw	curdx, %dx		# restore disk state
+	movw	curcx, %cx
+#   al is last sector+1
+#   ah is last head+1
+	movw	limits, %ax
+	orw	%di,%di
+        jne	read_sectorslp
+	movb	$0x2e, %al 		# loading... message 2e = .
+putc:
+	movb	$0xe, %ah
+	movw	$7, %bx			#   one dot each 64k
+ 	int	$0x10
+return:
+	ret
+
+print_nl:
+	
+	movb	$0xd, %al		# CR
+	call	putc
+	movb	$0xa, %al		# LF
+	jmp	putc
+
+puts:
+	call	print_nl		# set %ah and %bx
+putslp:
+	lodsb
+	orb	%al,%al			# end of string is \0
+	jz	return
+putcs:
+	int	$0x10
+	jmp	putslp
 
-	.org 497
+floppy_table:
+#ifdef EXTRA_DEVICES		
+		.byte	16,9			# /dev/fd0u720
+		.byte	12,10			# /dev/fd0u800
+		.byte	80,11			# /dev/fd0u880
+		.byte	125,20			# /dev/fd0u1600
+		.byte	44,21			# /dev/fd0u1680
+		.byte	96,22			# /dev/fd0u1760
+		.byte	116,23			# /dev/fd0u1840
+		.byte	100,24			# /dev/fd0u1920
+		.byte	105,40			# /dev/fd0u3200
+		.byte	109,44			# /dev/fd0u3520
+		.byte	113,48			# /dev/fd0u3840
+#endif		
+		.byte	8,15			# /dev/fd0h1200 - /dev/ps0
+		.byte	28,18			# /dev/fd0u1440 - /dev/PS0
+		.byte	32,36			# /dev/fd0u2880 - /dev/fd0H2880
+		.byte	0,128			# /dev/fd0 - default: autodetect
+
+regs:		.asciz	"X:"
+
+#ifndef	DISPLAY_KERNEL_VERSION
+msg1:		.asciz	"Loading"
+#endif		
+
+tail:
+		.space	495+start-tail		
+
+#.org 495
+sys_sects:	.word SYSSIZE / 32		# size max is now 32Mb
+#.org 497
 setup_sects:	.byte SETUPSECTS
 root_flags:	.word ROOT_RDONLY
-syssize:	.word SYSSIZE
+syssize:	.word SYSSIZE % 0x10000		# size max was 1Mb
 swap_dev:	.word SWAP_DEV
-ram_size:	.word RAMDISK
+ram_size:	.word RAMDISK			# ramdisk size, ramdisk flags and cmdline flag
 vid_mode:	.word SVGA_MODE
 root_dev:	.word ROOT_DEV
 boot_flag:	.word 0xAA55
diff -purN linux-2.6.13/arch/i386/boot/tools/build.c linux-2.6.13-bootblock/arch/i386/boot/tools/build.c
--- linux-2.6.13/arch/i386/boot/tools/build.c	2005-09-12 10:38:52.000000000 +0200
+++ linux-2.6.13-bootblock/arch/i386/boot/tools/build.c	2005-09-12 10:46:25.000000000 +0200
@@ -168,10 +168,13 @@ int main(int argc, char ** argv)
 	}
 	close(fd);
 
-	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
+	if (lseek(1, 495, SEEK_SET) != 495)		    /* Write sizes to the bootsector */
 		die("Output: seek failed");
-	buf[0] = setup_sectors;
-	if (write(1, buf, 1) != 1)
+	sz = (sb.st_size + 511) / 512;
+	buf[0] = (sz & 0xff);
+	buf[1] = ((sz >> 8) & 0xff);
+	buf[2] = setup_sectors;
+	if (write(1, buf, 3) != 3)
 		die("Write of setup sector count failed");
 	if (lseek(1, 500, SEEK_SET) != 500)
 		die("Output: seek failed");
diff -purN linux-2.6.13/arch/i386/kernel/setup.c linux-2.6.13-bootblock/arch/i386/kernel/setup.c
--- linux-2.6.13/arch/i386/kernel/setup.c	2005-09-12 10:38:53.000000000 +0200
+++ linux-2.6.13-bootblock/arch/i386/kernel/setup.c	2005-09-12 10:57:01.000000000 +0200
@@ -156,6 +156,7 @@ unsigned long saved_videomode;
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
+#define CMDLINE_LOAD_FLAG		0x2000	
 
 static char command_line[COMMAND_LINE_SIZE];
 
diff -purN linux-2.6.13/arch/x86_64/boot/bootsect.S linux-2.6.13-bootblock/arch/x86_64/boot/bootsect.S
--- linux-2.6.13/arch/x86_64/boot/bootsect.S	2005-09-12 10:37:58.000000000 +0200
+++ linux-2.6.13-bootblock/arch/x86_64/boot/bootsect.S	2005-09-12 10:58:07.000000000 +0200
@@ -4,20 +4,31 @@
  *	modified by Drew Eckhardt
  *	modified by Bruce Evans (bde)
  *	modified by Chris Noe (May 1999) (as86 -> gas)
- *	gutted by H. Peter Anvin (Jan 2003)
+ *
+ *      rewritten to support up to 32Mb kernel, cmdline
+ *      and any disk geometry by <pascal.bellard@ads-lu.com>
  *
  * BIG FAT NOTE: We're in real mode using 64k segments.  Therefore segment
  * addresses must be multiplied by 16 to obtain their respective linear
  * addresses. To avoid confusion, linear addresses are written using leading
  * hex while segment addresses are written as segment:offset.
  *
+ * bde - should not jump blindly, there may be systems with only 512K low
+ * memory.  Use int 0x12 to get the top of memory, etc.
+ *
+ * It then loads 'setup' directly after itself (0x90200), and the system
+ * at 0x10000, using BIOS interrupts. 
+ *
+ * The loader has been made as simple as possible, and continuous
+ * read errors will result in a unbreakable loop. Reboot by hand. It
+ * loads pretty fast by getting whole tracks at a time whenever possible.
  */
 
 #include <asm/boot.h>
 
 SETUPSECTS	= 4			/* default nr of setup-sectors */
 BOOTSEG		= 0x07C0		/* original address of boot-sector */
-INITSEG		= DEF_INITSEG		/* we move boot here - out of the way */
+INITSEG		= DEF_INITSEG		/* we load boot here - out of the way */
 SETUPSEG	= DEF_SETUPSEG		/* setup starts here */
 SYSSEG		= DEF_SYSSEG		/* system loaded at 0x10000 (65536) */
 SYSSIZE		= DEF_SYSSIZE		/* system size: # of 16-byte clicks */
@@ -25,6 +36,12 @@ SYSSIZE		= DEF_SYSSIZE		/* system size: 
 ROOT_DEV	= 0 			/* ROOT_DEV is now written by "build" */
 SWAP_DEV	= 0			/* SWAP_DEV is now written by "build" */
 
+/* some extra features */
+#define DISPLAY_KERNEL_VERSION		as soon as possible
+#define	EDIT_CMDLINE			on hotkey
+#define	LOAD_CMDLINE			according to bit ramsize.13
+#define EXTRA_DEVICES			to fill root_device
+
 #ifndef SVGA_MODE
 #define SVGA_MODE ASK_VGA
 #endif
@@ -42,57 +59,470 @@ SWAP_DEV	= 0			/* SWAP_DEV is now writte
 
 .global _start
 _start:
+	cld				# assume nothing
+	movw	$INITSEG, %ax
+	movw	%ax, %es		# %ax = %es = INITSEG
+#if MOVE_BOOTSECTOR
+# First things first. Move ourself from 0x7C00 -> 0x90000 and jump there.
+	movw	$BOOTSEG, %cx
+	movw	%cx, %ds		# %ds = BOOTSEG
+	movb	$1, %ch			# %cx = 256
+	subw	%si, %si
+	subw	%di, %di
+	rep
+	movsw
+	ljmp	$INITSEG, $go
+go:	
+#else
+	xorw	%cx, %cx		# %cx = 0
+#endif
 
-	# Normalize the start address
-	jmpl	$BOOTSEG, $start2
+# bde - changed 0xff00 to 0x4000 to use debugger at 0x6400 up (bde).  We
+# wouldn't have to worry about this if we checked the top of memory.  Also
+# my BIOS can be configured to put the wini drive tables in high memory
+# instead of in the vector table.  The old stack might have clobbered the
+# drive table.
+
+	movw	$0x4000-12, %di		# 0x4000 is an arbitrary value >=
+					# length of bootsect + length of
+					# setup + room for stack;
+					# 12 is disk parm size.
+					# gdt will heat 48 more bytes.
+	movw	%ax, %ss		# %ax and %es already contain INITSEG
+	movw	%di, %sp		# put stack at INITSEG:0x4000-12.
+
+# Many BIOS's default disk parameter tables will not recognize
+# multi-sector reads beyond the maximum sector number specified
+# in the default diskette parameter tables - this may mean 7
+# sectors in some cases.
+#
+# Since single sector reads are slow and out of the question,
+# we must take care of this by creating new parameter tables
+# (for the first disk) in RAM.  We can set the maximum sector
+# count to 36 - the most we will encounter on an ED 2.88.  
+#
+# High doesn't hurt.  Low does.  Let's use the max: 63
+#
+# Segments are as follows: %es = %ss = INITSEG,
+# %fs and %gs are unused.
+
+	movw	$0x78, %bx		# %ds:%bx is parameter table address
+	movw	%cx, %ds		# %ds = 0
+	ldsw	(%bx), %si		# %ds:%si is source
+	movb	$6, %cl			# copy 12 bytes
+	rep				# don't worry about cld
+	movsw				# already done above
+	movw	%cx, %ds		# %ds = 0
+	movw	%sp, (%bx)		# %sp = 0x4000-12
+	movw	%es, 2(%bx)
+	pushw	%es
+	popw	%ds			# now %ds = %es = %ss = INITSEG
+	movb	$63, 0x4-12(%di)	# patch sector count, %di = 0x4000
+
+	cli
+	cbw				# %ax = 0 : geometry unknown yet
+	xorb	%dh, %dh		# head 0, current drive
+	incw	%cx			# cylinder 0, sector 1
+	movw	%cx, %di		# read 1 sector
+	call	read_first_sector	# read bootsector again to have
+					# access to data segment
+
+#ifndef	DISPLAY_KERNEL_VERSION
+	movw	$msg1, %si
+	call	puts
+#endif
 
-start2:
-	movw	%cs, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %ss
-	movw	$0x7c00, %sp
-	sti
-	cld
+# Load the setup-sectors directly after the moved bootblock (at 0x90200).
 
-	movw	$bugger_off_msg, %si
+	movb	setup_sects, %al
+#ifdef CHECK_SETUP_SIZE
+	orb	%al, %al
+	jne	setup_size_ok
+	movb	$SETUPSECTS, %al
+setup_size_ok:	
+#endif
+	cbw
+	xchg	%ax, %di
+	call	read_sectors		# read setup
+
+#ifdef	DISPLAY_KERNEL_VERSION
+#define kernel_version	0xE
+	movw	$0x200,%si
+	addw	kernel_version(%si),%si	# starting protocol 2.00, Kernel 1.3.73
+	call	puts			# show which kernel we are loading
+#endif
 
-msg_loop:
-	lodsb
-	andb	%al, %al
-	jz	die
-	movb	$0xe, %ah
-	movw	$7, %bx
-	int	$0x10
-	jmp	msg_loop
+# This routine loads the system at address SYSSEG, making sure
+# no 64kB boundaries are crossed. We try to load it as fast as
+# possible, loading whole tracks whenever we can.
+
+#ifdef __BIG_KERNEL__
+type_of_loader	=	528
+	movw	$24, %cx		# allocate 48 bytes in stack
+init_gdt:
+	push	$0			#   initialized with 0
+	loop	init_gdt
+	movw	%sp, %si		# for bootsect_gdt
+	movw	$0x9300+(SYSSEG/4096), %ax	# source = SYSSEG
+	cwd
+	movw	%ax, 20(%si)		# bootsect_src_base+2
+	movb	$0x10-1, %al		# destination = 0x100000
+	movw	%ax, 28(%si)		# bootsect_dst_base+2
+	movw	%dx, 16(%si)		# bootsect_src = 64Kb
+	movw	%dx, 24(%si)		# bootsect_dst = 64Kb
+	movb	%dl, type_of_loader	# loader type = 0xFF
+syslp:
+	movw	$SYSSEG, %ax
+	movw	%ax, %es
+	movw	$128,%di		# 64Kb in sectors
+	subw	%di, sys_sects
+	pushf
+	jnc	not_last
+	addw	sys_sects, %di
+not_last:
+	call	read_sectors
+	incw	28(%si)			# bootsect_dst_base+2
+	movw	$0x8000, %cx		# full 64K
+	movb	$0x87, %ah
+	push	%ss
+	pop	%es			# gdt in es:si
+	int	$0x15
+	popf
+	ja	syslp
+#else
+	movw	$SYSSEG, %ax
+	movw	%ax, %es
+syslp:
+	movw	$128*32,%ax		# 64Kb in paragraphs
+	subw	%ax, syssize
+	pushf
+	jnc	not_last
+	addw	syssize, %ax
+not_last:
+	movb	$5, %cl			# paragraphs -> sectors
+	shrw	%cl, %ax
+	xchg	%ax, %di
+	call	read_sectors
+	popf
+	ja	syslp
+#endif
 
-die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
-	int	$0x16
-	int	$0x19
+# After that we check which root-device to use. If the device is
+# defined (!= 0), nothing is done and the given device is used.
+# Otherwise, one of /dev/fd0H2880 (2,32) or /dev/PS0 (2,28) or /dev/at0 (2,8)
+# depending on the number of sectors we pretend to know we have.
+
+
+	movw	root_dev, %ax
+	orw	%ax, %ax
+	jnz	root_defined
+
+	movw	$floppy_table,%si
+scan_floppy_table:
+	lodsw
+	cmpb	limits, %ah
+	je	set_root
+	jno	scan_floppy_table
+set_root:
+	movb	$2, %ah
+	addb	%dl, %al		# add current (floppy) drive
+	movw	%ax, root_dev
+root_defined:
+
+#if defined(LOAD_CMDLINE) || defined(EDIT_CMDLINE)
+#define BUFFER	0x7F00
+	movw	$BUFFER, %si
+	movw	%si, (%si)		# default : no cmdline
+#endif
 
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
+#ifdef	LOAD_CMDLINE
+	testb	$0x20,ram_size+1	# bit 11 to 13 where unused
+					# now bit 13 means: load cmdline
+	jz	nocmd
+	movw	$BUFFER/16+INITSEG, %ax
+	movw	%ax, %es
+	movw	$1, %di			# cmdline = 512 bytes max
+	call	read_sectors
+nocmd:
+#endif
 
+#define RSHFT   0x01
+#define LSHFT   0x02
+#define CTRL    0x04
+#define ALT     0x08
+#define SCRLCK  0x10
+#define NUMLCK  0x20
+#define CAPSLCK 0x40
+#define INSERT  0x80
+
+#ifdef	EDIT_CMDLINE
+# The cmdline can be entered and modifed on hot key.
+# Only characters before the cursor are passed to the kernel.
+	movb	$2, %ah			# get keyboard status
+	int	$0x16
+	testb	$RSHFT|LSHFT|CTRL|ALT|CAPSLCK, %al
+	jz	nocmdline
+	pushw	%si
+	call	puts			# set %ah and %bx
+cmdlp:
+# if 1
+	movb	$32, %al		# clear end of line
+	int	$0x10			#  with Space
+	movb	$8, %al			#   and BackSpace
+	int	$0x10
+# endif
+	decw	%si
+cmdget:
+	cbw				# %ah = 0, get keyboard character
+	int	$0x16
+	cmpb	$8, %al			# BackSpace ?
+	je	cmdbs
+	cbw
+	movw	%ax, (%si)		# store end of string too
+	incw	%si
+	incw	%si
+cmdbs:
+	cmpw	$BUFFER, %si		# lower limit is checked
+	je	cmdget			#   but upper limit not
+	call	putc
+	cmpb	$13, %al		# Enter ?
+	jne	cmdlp
+	popw	%si
+nocmdline:
+#endif
 
-bugger_off_msg:
-	.ascii	"Direct booting from floppy is no longer supported.\r\n"
-	.ascii	"Please use a boot loader program instead.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot . . .\r\n"
-	.byte	0
+#if defined(LOAD_CMDLINE) || defined(EDIT_CMDLINE)
+#if 1
+cmd_line_magic	=	0x20
+cmd_line_offset	=	0x22
+	movw	$0xA33F, cmd_line_magic
+	movw	%si, cmd_line_offset
+#else
+# protocol >= 2.02, starting Kernel 2.4.0-test3-pre3
+cmd_line_ptr	=	0x228
+	movzx	%si, %eax
+	addl	$INITSEG*16, %eax
+	movl	%eax, cmd_line_ptr
+#endif
+emptycmdline:
+#endif
+	
+# This procedure turns off the floppy drive motor, so
+# that we enter the kernel in a known state, and
+# don't have to worry about it later.
+
+#if 1
+kill_motor:
+	xorw	%ax, %ax		# reset FDC
+	int	$0x13
+#else
+kill_motor:
+	movw	$0x3f2, %dx
+	xorb	%al, %al
+	outb	%al, %dx
+#endif
 
+	call	print_nl
 
-	# Kernel attributes; used by setup
+# After that (everything loaded), we jump to the setup-routine
+# loaded directly after the bootblock:
+# Segments are as follows: %ds = %ss = INITSEG
+
+	ljmp	$SETUPSEG, $0
+
+# read_sectors reads %di sectors into %es:0 buffer.
+# %es:0 is updated to the next memory location.
+# First, sectors are read sector by sector until
+# sector per track count is known. Then they are
+# read track by track.
+# Assume no error on first track.
+
+#define TRACK_BY_TRACK	load as fast as possible !
+#define SHOW_REGS	show int13 status & parameters
+
+check_limits:
+        cmpb    %al, %cl		# max sector known ?
+        ja	next_head		#   no -> store it
+        cmpb    %ah, %dh		# max head known ?
+        ja	next_track		#   no -> store it
+	pusha				# save context
+#ifdef SHOW_REGS
+	pushw	%es			# print %es (named EX)
+	pushw	%dx			# print %dx
+	pushw	%cx			# print %cx
+	xorw	%cx, %cx
+	pushw	%cx			# print %bx
+# ifdef TRACK_BY_TRACK
+	movb	$2, %bh
+# endif
+	pushw	%bx			# print %ax
+	movb	$6,%cl
+	jmp	print_all		# print %bp (status)
+print_loop:
+	movb	$0x6 + 'A' - 1, %al
+	subb	%cl, %al
+	movw	$regs, %si		# caller %si is saved
+	call	putcs			# putc(%al) + puts(%si)
+# it will print out all of the registers.
+	popw	%bp			# load word into %bp
+print_all:
+	pushw	%cx			# save count remaining
+	movb	$4, %cl			# 4 hex digits
+print_digit:
+	rolw	$4, %bp			# rotate to use low 4 bits
+	movb	$0x0f, %al
+	andw	%bp, %ax		# %al = mask for nybble
+	addb	$0x90, %al		# convert %al to ascii hex
+	daa				# in only four instructions!
+	adcb	$0x40, %al
+	daa
+	call	putc			# set %ah and %bx
+	loop	print_digit
+	movb	$0x20, %al		# SPACE
+	int	$0x10
+	popw	%cx
+	loop	print_loop
+	xchg	%ax, %cx		# %ah = 0
+#else
+	cbw				# %ah = 0
+#endif
+        int     $0x13			# reset controler
+	popa				# restore context
+read_sectorslp:
+read_first_sector:
+        pushw   %di			# sector count
+        pushw   %ax			# limits
+        pushw   %dx
+        pushw   %cx
+	xorw	%bx, %bx
+#ifdef TRACK_BY_TRACK
+	subb	%cl, %al		# sectors remaining in track
+	ja	tolastsect
+	movb	$1, %al			# 1 sector mini
+tolastsect:
+	cbw
+	cmpw	%di, %ax
+	jb	more1trk
+	movw	%di, %ax		# sectors to read
+more1trk:
+	push	%ax
+	movb	$2, %ah			# cmd: read chs
+#else
+        movw    $0x201, %ax		# sector by sector
+	push	%ax
+#endif
+        int     $0x13
+	xchg	%ax, %bp		# status
+        popw    %bx			# %ax 
+        popw    %cx
+        popw    %dx
+        popw    %ax			# limits
+        popw    %di			# sector count
+	jc	check_limits
+next_sector:
+#ifdef TRACK_BY_TRACK
+	subw	%bx,%di			# update sector counter
+	addw	%bx,%cx			# next sector
+	shlw	$5,%bx			# sectors -> paragraghs
+	movw	%es, %bp
+	addw	%bx, %bp
+#else
+	decw	%di			# update sector counter
+	incw	%cx			# next sector
+	movw	%es, %bp
+	addw	$32, %bp		# sector size in paragraghs
+#endif
+	movw	%bp, %es		# next location
+        cmpb    %al,%cl			# reach sector limit ?
+        jne     bdendlp
+next_head:
+        movb    %cl,%al
+        incb    %dh			# next head
+        movb    $1,%cl			# first sector
+        cmpb    %ah,%dh			# reach head limit ?
+        jne     bdendlp
+next_track:
+        movb    %dh,%ah
+        movb    $0,%dh			# first head
+# NOTE : support 256 cylinders max
+        incb    %ch			# next cylinder
+bdendlp:
+curdrive =	_start
+curdx	=	_start
+curcx	=	_start+2
+limits	=	_start+4
+	movw	%dx, curdx		# save disk state
+	movw	%cx, curcx
+	movw	%ax, limits
+read_sectors:
+	movw	curdx, %dx		# restore disk state
+	movw	curcx, %cx
+#   al is last sector+1
+#   ah is last head+1
+	movw	limits, %ax
+	orw	%di,%di
+        jne	read_sectorslp
+	movb	$0x2e, %al 		# loading... message 2e = .
+putc:
+	movb	$0xe, %ah
+	movw	$7, %bx			#   one dot each 64k
+ 	int	$0x10
+return:
+	ret
+
+print_nl:
+	
+	movb	$0xd, %al		# CR
+	call	putc
+	movb	$0xa, %al		# LF
+	jmp	putc
+
+puts:
+	call	print_nl		# set %ah and %bx
+putslp:
+	lodsb
+	orb	%al,%al			# end of string is \0
+	jz	return
+putcs:
+	int	$0x10
+	jmp	putslp
 
-	.org 497
+floppy_table:
+#ifdef EXTRA_DEVICES		
+		.byte	16,9			# /dev/fd0u720
+		.byte	12,10			# /dev/fd0u800
+		.byte	80,11			# /dev/fd0u880
+		.byte	125,20			# /dev/fd0u1600
+		.byte	44,21			# /dev/fd0u1680
+		.byte	96,22			# /dev/fd0u1760
+		.byte	116,23			# /dev/fd0u1840
+		.byte	100,24			# /dev/fd0u1920
+		.byte	105,40			# /dev/fd0u3200
+		.byte	109,44			# /dev/fd0u3520
+		.byte	113,48			# /dev/fd0u3840
+#endif		
+		.byte	8,15			# /dev/fd0h1200 - /dev/ps0
+		.byte	28,18			# /dev/fd0u1440 - /dev/PS0
+		.byte	32,36			# /dev/fd0u2880 - /dev/fd0H2880
+		.byte	0,128			# /dev/fd0 - default: autodetect
+
+regs:		.asciz	"X:"
+
+#ifndef	DISPLAY_KERNEL_VERSION
+msg1:		.asciz	"Loading"
+#endif		
+
+tail:
+		.space	495+start-tail		
+
+#.org 495
+sys_sects:	.word SYSSIZE / 32		# size max is now 32Mb
+#.org 497
 setup_sects:	.byte SETUPSECTS
 root_flags:	.word ROOT_RDONLY
-syssize:	.word SYSSIZE
+syssize:	.word SYSSIZE % 0x10000		# size max was 1Mb
 swap_dev:	.word SWAP_DEV
-ram_size:	.word RAMDISK
+ram_size:	.word RAMDISK			# ramdisk size, ramdisk flags and cmdline flag
 vid_mode:	.word SVGA_MODE
 root_dev:	.word ROOT_DEV
 boot_flag:	.word 0xAA55
diff -purN linux-2.6.13/arch/x86_64/boot/tools/build.c linux-2.6.13-bootblock/arch/x86_64/boot/tools/build.c
--- linux-2.6.13/arch/x86_64/boot/tools/build.c	2005-09-12 10:38:57.000000000 +0200
+++ linux-2.6.13-bootblock/arch/x86_64/boot/tools/build.c	2005-09-12 11:00:44.000000000 +0200
@@ -169,10 +169,13 @@ int main(int argc, char ** argv)
 	}
 	close(fd);
 
-	if (lseek(1, 497, SEEK_SET) != 497)		    /* Write sizes to the bootsector */
+	if (lseek(1, 495, SEEK_SET) != 495)		    /* Write sizes to the bootsector */
 		die("Output: seek failed");
-	buf[0] = setup_sectors;
-	if (write(1, buf, 1) != 1)
+	sz = (sb.st_size + 511) / 512;
+	buf[0] = (sz & 0xff);
+	buf[1] = ((sz >> 8) & 0xff);
+	buf[2] = setup_sectors;
+	if (write(1, buf, 3) != 3)
 		die("Write of setup sector count failed");
 	if (lseek(1, 500, SEEK_SET) != 500)
 		die("Output: seek failed");
diff -purN linux-2.6.13/Documentation/i386/boot.txt linux-2.6.13-bootblock/Documentation/i386/boot.txt
--- linux-2.6.13/Documentation/i386/boot.txt	2005-09-12 10:36:50.000000000 +0200
+++ linux-2.6.13-bootblock/Documentation/i386/boot.txt	2005-09-12 12:22:43.000000000 +0200
@@ -103,6 +103,7 @@ The header looks like:
 Offset	Proto	Name		Meaning
 /Size
 
+01EF/2	N/A	sys_sects	DO NOT USE - for bootsect.S use only
 01F1/1	ALL	setup_sects	The size of the setup in sectors
 01F2/2	ALL	root_flags	If set, the root is mounted readonly
 01F4/2	ALL	syssize		DO NOT USE - for bootsect.S use only
diff -purN linux-2.6.13/Documentation/ramdisk.txt linux-2.6.13-bootblock/Documentation/ramdisk.txt
--- linux-2.6.13/Documentation/ramdisk.txt	2005-09-12 10:35:39.000000000 +0200
+++ linux-2.6.13-bootblock/Documentation/ramdisk.txt	2005-09-12 10:55:35.000000000 +0200
@@ -63,12 +63,14 @@ to 2 MB (2^11) of where to find the RAM 
 14 indicates that a RAM disk is to be loaded, and bit 15 indicates whether a
 prompt/wait sequence is to be given before trying to read the RAM disk. Since
 the RAM disk dynamically grows as data is being written into it, a size field
-is not required. Bits 11 to 13 are not currently used and may as well be zero.
+is not required. Bit 13 indicates that a cmdline is to be loaded by the kernel
+bootblock, Bits 11 to 12 are not currently used and may as well be zero.
 These numbers are no magical secrets, as seen below:
 
 ./arch/i386/kernel/setup.c:#define RAMDISK_IMAGE_START_MASK     0x07FF
 ./arch/i386/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
 ./arch/i386/kernel/setup.c:#define RAMDISK_LOAD_FLAG            0x4000
+./arch/i386/kernel/setup.c:#define CMDLINE_LOAD_FLAG            0x2000
 
 Consider a typical two floppy disk setup, where you will have the 
 kernel on disk one, and have already put a RAM disk image onto disk #2.
@@ -159,6 +161,8 @@ users may wish to combine steps (d) and 
 Changelog:
 ----------
 
+09-05 :		Reserve CMDLINE_LOAD bit.
+
 10-22-04 :	Updated to reflect changes in command line options, remove
 		obsolete references, general cleanup.
 		James Nelson (james4765@gmail.com)

--------------050004020807060004040109--
