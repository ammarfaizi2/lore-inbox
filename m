Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266804AbUF3Sqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266804AbUF3Sqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUF3Sq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:46:28 -0400
Received: from grex.cyberspace.org ([216.93.104.34]:53010 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP id S266804AbUF3Soa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:44:30 -0400
Date: Wed, 30 Jun 2004 14:45:07 -0400 (EDT)
From: Joshua <jhudson@cyberspace.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] restore floppy boot image
Message-ID: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing the 2.6.7 kernel a week ago, I had LILO problems
(lilo bombed on the kernel image). My first thought was to dd the kernel
to a floppy, and boot Windows so that I could get a new LILO (I have
a winmodem for dialup). My second thought was better check w/ hexdump
first.

I saw that "booting from floppy is no longer supported" message, and
thought "This won't do.

Rather than go back to the old version, I thought that I could do it
better.  Maybe I did and maybe I didn't, but this time the bzImage loading
code fits into a single sector (no more need of bootsect_kludge).

Patch-signed-off-by: Joshua Hudson <jhudson@cyberspace.org>

diff -ru linux-2.6.7/arch/i386/boot/bootsect.S
linux-2.6.7c/arch/i386/boot/bootsect.S
--- linux-2.6.7/arch/i386/boot/bootsect.S	Tue Jun 15 22:19:23 2004
+++ linux-2.6.7c/arch/i386/boot/bootsect.S	Wed Jun 30 04:22:00 2004
@@ -5,6 +5,7 @@
  *	modified by Bruce Evans (bde)
  *	modified by Chris Noe (May 1999) (as86 -> gas)
  *	gutted by H. Peter Anvin (Jan 2003)
+ *	rewritten by Joshua Hudson (June 2004)
  *
  * BIG FAT NOTE: We're in real mode using 64k segments.  Therefore
segment
  * addresses must be multiplied by 16 to obtain their respective linear
@@ -43,50 +44,320 @@
 .global _start
 _start:
 
-	# Normalize the start address
-	jmpl	$BOOTSEG, $start2
+#define KS_LOAD 0x2000
 
-start2:
-	movw	%cs, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %ss
-	movw	$0x7c00, %sp
-	sti
-	cld
+/* 
+ * Actually, ld86 has no clue what is going on here.
+ * We are at 0000:7C00, not 7C0:0000
+ * Therefore, we correct it.
+ */
 
-	movw	$bugger_off_msg, %si
+	nop				/* Place to insert debug trap */
+	ljmp	$0x7C0, $6		/* Didn't assemble "realstart" */
+realstart:
+	xor	%dx, %dx
+	mov	%dx, %ss		/* This is a 386 (I should hope)
*/
+	mov	$0x7C00, %sp		/* You don't need a cli first. */
+
+	/*
+	 * Many BIOS's default disk parameter tables will not
+	 * recognize multi-sector reads beyond the maximum sector number
+	 * specified in the default diskette parameter tables - this may
+	 * mean 7 sectors in some cases.
+	 *
+	 * Since single sector reads are slow and out of the question,
+	 * we must take care of this by creating new parameter tables
+	 * (for the first disk) in RAM.  We will set the maximum sector
+	 * count to 36 - the most we will encounter on an ED 2.88.
+	 *
+	 * High doesn't hurt.  Low does.
+	 *
+	 * Previous versions copied the param table.
+	 * We are just going to tweak it. It is in ram anyway
+	 */
+	mov	%dx, %ds
+	movb	$36, 0x7C
+	mov	$01, %ah
+	int	$0x13
+
+	/* Now correct ds to normalized load position */
+	push	%cs
+	pop	%ds
+
+	/*
+	 * Determine how many sectors we have. Since there is no call
+	 * that will determine how many sectors (int 13h, ah=8h doesn't
+	 * always work on floppies, probe it)
+	 *
+	 * We probe by determining what highest sector we can load.
+	 * Never probe by trying to read X sectors. Some bioses will
+	 * actually span tracks.
+	 */
+	mov	$dflags, %si
+	mov	$KS_LOAD, %ax
+	mov	%ax, %es
+	push	%ax		/* Remember this for later */
+	xor	%bx, %bx
 
-msg_loop:
+	cld
+	mov	$0, %ch
+	lodsb
+probe:
+	mov	%al, %cl
+	mov	$0x201, %ax
+	int	$0x13
+	cmp	$0, %ah
+	je	probeok
 	lodsb
-	andb	%al, %al
-	jz	die
-	movb	$0xe, %ah
-	movw	$7, %bx
+	cmp	$0, %al
+	jne	probe
+	call	errcode
+halt:	jmp	halt
+probeok:
+
+	/* Load first track */
+	xchg	%al, %cl
+load1:	mov	$2, %ah
+	int	$0x13
+	jnc	load1ok
+	call	errcode
+	jmp	load1
+load1ok:
+
+	/*
+	 * Print some innane message...
+	 */
+	push	%ax
+	mov	$msg, %si
+	mov	$0xE, %ah
+	mov	$7, %bx
+	lodsb
+mloop:	int	$0x10
+	lodsb
+	cmp	$0, %al
+	jne	mloop
+	pop	%ax
+
+	/*
+	 * If the root device is set to FLOPPY (0), set to the
+	 * appropriate kind of floppy. /dev/fd0 will correctly
+	 * autodetect everything but /dev/fd0u1722 (2, 60).
+	 */
+
+	push	%ds
+	push	%es
+	pop	%ds
+	cmpw	$0, root_dev
+	jne	rootok
+	movb	$0x2, root_dev + 1
+	cmp	$21, %al
+	jne	rootok
+	movb	$60, root_dev
+rootok:
+	pop	%ds
+
+	/*
+	 * I would like to assume that setup is less than 9 sectors, but
+	 * it is not. This is too much code.
+	 */
+	movzx	setup_sects, %si
+	or	%si, %si		/* If setup_sects is zero */
+	jnz	sv_ok
+	mov	$4, %si			/* The real value is 4 */
+sv_ok:	inc	%si			/* Tricky: count bootsect as setup
*/
+	jmp	fix_setup
+
+more_setup:
+	call	next_track
+load_setup:
+	int	$0x13
+	cmp	$0, %ah
+	je	fix_setup
+	pusha
+	call	errcode
+	popa
+	jmp	load_setup
+
+fix_setup:
+	push	%ax
+	shl	$9, %ax		/* ax *= 512 */
+	add	%ax, %bx
+	pop	%ax
+	sub	%ax, %si
+	or	%si, %si
+	jns	more_setup
+
+	/*
+	 * 3. Compute the slop, and load it high
+	 */
+	neg	%si		/* How many sectors too many */
+	mov	%ax, %bx
+	sub	%si, %bx	/* How many sectors to skip */
+	shl	$5, %bx
+	add	$KS_LOAD, %bx
+	mov	syssize, %bp	/* Get system size */
+	add	$31, %bp	/* Convert 16 byte clicks to sectors */
+	shr	$5, %bp
+	mov	%bx, %es	/* New high memory ptr */
+	mov	%bx, %ds
+	xor	%bx, %bx
+
+	/*
+	 * 4. Load the rest.
+	 */
+ldr_ct:
+	call	upload
+	sub	%si, %bp
+	jna	enter
+	call	next_track
+loader:
+	mov	$2, %ah
+	int	$0x13
+	cmp	$0, %ah
+	je	ldr_ok
+	pusha
+	call	errcode
+	popa
+	jmp	loader
+ldr_ok:
+	mov	%ax, %si
+	jmp	ldr_ct
+
+	/*
+	 * 5. Set up entry paramiters
+	 */
+enter:
+	pop	%ax	/* Pointer to setup area */
+	mov	%ax, %ds
+	mov	%ax, %es
+	mov	%ax, %fs
+	mov	%ax, %gs
+	movb	$0x20, 0x210	/* Tell setup.S that we are the bootsect
*/
+	orb	$0x1, 0x211	/* Covert any zImage to bzImage (weird) */
+	movw	$0x0, 0x214	/* This is where we loaded it */
+	movw	$0x10, 0x216
+
+	/*
+	 * This procedure turns off the floppy drive motor, so
+	 * that we enter the kernel in a known state, and
+	 * don't have to worry about it later.
+	 *
+	 * Actually, all this does is not annoy sysadmin, when he is
+	 * forced to use this method of booting, because if the floppy
+	 * is a demand-loaded module, the motor just won't turn off
+	 * otherwise.
+	 */
+
+	mov	$0x3f2, %dx
+	mov	$0, %al
+	/* outb */
+	.byte	0xEE		/* I don't have time to figure out
+				 * why this didn't assemble. */
+
+	/*
+	 * Enter kernel with interrupts off, and at segment +20 from
+	 * legacy bootsect location
+	 */
+	cli
+	mov	%ax, %ss
+	mov	$0xFFF0, %sp	/* Plenty heap */
+	ljmp	$KS_LOAD + 0x20, $0
+	
+/*
+ * This routine skips to next track.
+ */
+next_track:
+	test	$1, %dh
+	jnz	nt2
+	inc	%dh
+	ret
+nt2:	mov	$0, %dh
+	inc	%ch
+	ret
+
+/*
+ * Routine errcode prints a diagnostic to the screen
+ * Used for debugging and for printing BIOS error codes
+ */
+errcode:
+	mov	%ah, %dh
+	mov	$1, %cx
+print_hex:
+	mov	$10, %ah
+	mov	$7, %bx
+phl:	mov	%dh, %al
+	shr	$4, %al
+	and	15, %al
+	add	$0x90, %al
+	daa
+	add	$0x40, %al
+	daa
+	int	$0x10
+	shl	$4, %dx
+	loop	phl
+	mov	$32, %al
+	int	$0x10
+	ret
+
+/* Routine to upload memory into high region */
+upload:
+	pusha			/* Remember registers */
+	push	%si		/* Prepare GDT */
+	mov	$0xFF00, %di
+	push	%di
+	mov	$25, %cx
+	xor	%ax, %ax
+	rep	stosw
+	pop	%si
+	pop	%cx
+	dec	%ax
+	mov	%ax, 16(%si)
+	mov	%ax, 24(%si)
+	movb	$0x93, 21(%si)
+	movb	$0x93, 29(%si)
+
+	mov	%bx, 18(%si)	/* Compute soruce */
+	mov	%es, %ax
+	shl	$4, %ax
+	add	%ax, 18(%si)
+	pushf
+	mov	%es, %ax
+	shr	$12, %ax
+	popf
+	adc	$0, %al
+	mov	%al, 20(%si)
+
+	push	%ds		/* So that we can read dest ptr */
+	push	%cs
+	pop	%ds
+	mov	hiptr, %ax	/* Copy in dest */
+	shl	$1, %cx
+	add	%cx, hiptr	/* Apply delta to dest */
+	pop	%ds		/* Restore old data segment */
+	mov	%ax, 27(%si)
+
+	shl	$7, %cx		/* Number of words to upload */
+	mov	$0x8700, %ax	/* ??? */
+	int	$0x15		/* Do upload */
+	jc	uperr
+	/*
+	 * Stuff has been loaded. Tick the delay bar.
+	 */
+	mov	$0x0E2E, %ax
+	mov	$7, %bx
 	int	$0x10
-	jmp	msg_loop
+	popa
+	ret
 
-die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
-	int	$0x16
-	int	$0x19
-
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
-
-
-bugger_off_msg:
-	.ascii	"Direct booting from floppy is no longer supported.\r\n"
-	.ascii	"Please use a boot loader program instead.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot . . .\r\n"
+uperr:	call	errcode
+hltx:	jmp	hltx
+
+hiptr:	.word	0x1000
+dflags:	.byte	36, 21, 18, 15, 9, 0
+msg:	.ascii	"Loading"
 	.byte	0
-	
 
 	# Kernel attributes; used by setup
-
 	.org 497
 setup_sects:	.byte SETUPSECTS
 root_flags:	.word ROOT_RDONLY


