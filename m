Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTA3DDl>; Wed, 29 Jan 2003 22:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTA3DDk>; Wed, 29 Jan 2003 22:03:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267371AbTA3DD3>; Wed, 29 Jan 2003 22:03:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [UPDATED PATCH] Removal of boot sector code
Date: 29 Jan 2003 19:12:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1a56v$r3h$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated the boot sector removal code so that it now:

a) Supports "make zdisk", "make bzdisk" and "make fdimage"
   (Requires mtools and syslinux, but will work as a non-root user
   as long as you have your floppy in /etc/fstab or syslinux setuid
   root.)

   There is also "make fdimage288" to create a 2.88 MB floppy image.

b) Is slightly more paranoid about the message-writing code than it
   was before.

The boot sector was very cool in 1992, but in 2003 it has outlived its
usefulness, and it no longer supports what Linux boot loaders need,
especially not with the 1 MB limit and the lack of support for
non-legacy floppy devices (the geometry detection hack fails on
those.)  Even a relatively simple 2.5 build exceeds that size for me,
and with this patch "make bzdisk" actually works, whereas the original
boot sector doesn't.

	-hpa

diff -ruN stock3/linux-2.5.59/arch/i386/boot/bootsect.S linux-2.5.59/arch/i386/boot/bootsect.S
--- stock3/linux-2.5.59/arch/i386/boot/bootsect.S	2003-01-16 18:22:12.000000000 -0800
+++ linux-2.5.59/arch/i386/boot/bootsect.S	2003-01-29 17:12:39.000000000 -0800
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
@@ -59,359 +43,51 @@
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
+	andb	%al, %al
+	jz	die
+	movb	$0xe, %ah
 	movw	$7, %bx
- 	int	$0x10
-	popa		
-
-# Accessing head, track, sread via %si gives shorter code.
+	int	$0x10
+	jmp	msg_loop
 
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
+die:
+	# Allow the user to press a key, then reboot
 	xorw	%ax, %ax
-ok3_set:
-	movw	%ax, (%si)		# set sread
-	shlw	$9, %cx
-	addw	%cx, %bx
-	jnc	set_next_fin
-	movw	%es, %ax
-	addb	$0x10, %ah
-	movw	%ax, %es
-	xorw	%bx, %bx
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
-	int	$0x10
-	movb	$':', %al
-	int	$0x10
-no_reg:
-	addw	$2, %bp			# next register
-	call	print_hex		# print it
-	popw	%cx
-	loop	print_loop
-	ret
+	int	$0x16
+	int	$0x19
 
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
+	# int 0x19 should never return.  In case it does anyway,
+	# invoke the BIOS reset code...
+	ljmp	$0xf000,$0xfff0
 
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
diff -ruN stock3/linux-2.5.59/arch/i386/boot/Makefile linux-2.5.59/arch/i386/boot/Makefile
--- stock3/linux-2.5.59/arch/i386/boot/Makefile	2003-01-16 18:22:03.000000000 -0800
+++ linux-2.5.59/arch/i386/boot/Makefile	2003-01-29 19:00:49.000000000 -0800
@@ -62,8 +62,27 @@
 	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
 					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
-zdisk: $(BOOTIMAGE)
-	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
+$(obj)/mtools.conf: $(obj)/mtools.conf.in
+	sed -e 's|@OBJ@|$(obj)|g' < $< > $@
+
+# This requires write access to /dev/fd0
+zdisk: $(BOOTIMAGE) $(obj)/mtools.conf
+	MTOOLSRC=$(src)/mtools.conf mformat a:			; sync
+	syslinux /dev/fd0					; sync
+	MTOOLSRC=$(src)/mtools.conf mcopy $(BOOTIMAGE) a:linux	; sync
+
+# These require being root or having syslinux run setuid
+fdimage fdimage144: $(BOOTIMAGE) $(src)/mtools.conf
+	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=1440
+	MTOOLSRC=$(src)/mtools.conf mformat v:			; sync
+	syslinux $(obj)/fdimage					; sync
+	MTOOLSRC=$(src)/mtools.conf mcopy $(BOOTIMAGE) v:linux	; sync
+
+fdimage288: $(BOOTIMAGE) $(src)/mtools.conf
+	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=2880
+	MTOOLSRC=$(src)/mtools.conf mformat w:			; sync
+	syslinux $(obj)/fdimage					; sync
+	MTOOLSRC=$(src)/mtools.conf mcopy $(BOOTIMAGE) w:linux	; sync
 
 zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
diff -ruN stock3/linux-2.5.59/arch/i386/boot/mtools.conf.in linux-2.5.59/arch/i386/boot/mtools.conf.in
--- stock3/linux-2.5.59/arch/i386/boot/mtools.conf.in	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.59/arch/i386/boot/mtools.conf.in	2003-01-29 18:59:58.000000000 -0800
@@ -0,0 +1,17 @@
+#
+# mtools configuration file for "make (b)zdisk"
+#
+
+# Actual floppy drive
+drive a:
+  file="/dev/fd0"
+
+# 1.44 MB floppy disk image
+drive v:
+  file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=18 filter
+
+# 2.88 MB floppy disk image (mostly for virtual uses)
+drive w:
+  file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=36 filter
+
+
diff -ruN stock3/linux-2.5.59/arch/i386/boot/tools/build.c linux-2.5.59/arch/i386/boot/tools/build.c
--- stock3/linux-2.5.59/arch/i386/boot/tools/build.c	2003-01-16 18:22:12.000000000 -0800
+++ linux-2.5.59/arch/i386/boot/tools/build.c	2003-01-29 17:11:06.000000000 -0800
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
 
diff -ruN stock3/linux-2.5.59/arch/i386/Makefile linux-2.5.59/arch/i386/Makefile
--- stock3/linux-2.5.59/arch/i386/Makefile	2003-01-16 18:22:01.000000000 -0800
+++ linux-2.5.59/arch/i386/Makefile	2003-01-29 19:04:12.000000000 -0800
@@ -92,8 +92,9 @@
 
 boot := arch/i386/boot
 
-.PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
-		clean archclean archmrproper
+.PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk \
+	fdimage fdimage144 fdimage288 install \
+	clean archclean archmrproper
 
 all: bzImage
 
@@ -111,8 +112,8 @@
 zdisk bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
-install: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) install
+install fdimage fdimage144 fdimage288: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
@@ -125,3 +126,4 @@
   echo  '		   install to $$(INSTALL_PATH) and run lilo'
 endef
 
+CLEAN_FILES += arch/$(ARCH)/boot/fdimage arch/$(ARCH)/boot/mtools.conf
diff -ruN stock3/linux-2.5.59/Documentation/kbuild/makefiles.txt linux-2.5.59/Documentation/kbuild/makefiles.txt
--- stock3/linux-2.5.59/Documentation/kbuild/makefiles.txt	2003-01-16 18:22:27.000000000 -0800
+++ linux-2.5.59/Documentation/kbuild/makefiles.txt	2003-01-29 18:16:05.000000000 -0800
@@ -429,6 +429,7 @@
     bzlilo		i386
     compressed		i386, m68k, mips, mips64, sh
     dasdfmt		s390
+    fdimage		i386
     Image		arm
     image		s390
     install		arm, i386
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
