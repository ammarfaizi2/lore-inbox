Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269767AbRHKAlw>; Fri, 10 Aug 2001 20:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269782AbRHKAln>; Fri, 10 Aug 2001 20:41:43 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:31762 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269767AbRHKAlf>; Fri, 10 Aug 2001 20:41:35 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: That horrible thing from hell called A20... *again*...
Date: 10 Aug 2001 17:41:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9l1uvj$70a$1@cesium.transmeta.com>
In-Reply-To: <3B7477A5.3000602@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the base64-encoded patch; I didn't realize Mozilla
pulled that kind of mess for plain textfiles.  Here it is again,
inline.

	-hpa

--- arch/i386/boot/setup.S.old	Fri Aug 10 15:20:51 2001
+++ arch/i386/boot/setup.S	Fri Aug 10 17:05:27 2001
@@ -253,6 +253,7 @@
 	call	prtstr
 
 no_sig_loop:
+	hlt
 	jmp	no_sig_loop
 
 good_sig:
@@ -641,18 +642,40 @@
 	movw	%ax, %ds
 	movw	%dx, %ss
 end_move_self:					# now we are at the right place
-	lidt	idt_48				# load idt with 0,0
-	xorl	%eax, %eax			# Compute gdt_base
-	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
-	shll	$4, %eax
-	addl	$gdt, %eax
-	movl	%eax, (gdt_48+2)
-	lgdt	gdt_48				# load gdt with whatever is
-						# appropriate
 
-# that was painless, now we enable a20
+#
+# Enable A20.  This is at the very best an annoying procedure.
+# A20 code ported from SYSLINUX 1.52-1.63 by H. Peter Anvin.
+#
+
+A20_TEST_LOOPS		=  32		# Iterations per wait
+A20_ENABLE_LOOPS	= 255		# Total loops to try		
+
+
+a20_try_loop:
+
+	# First, see if we are on a system with no A20 gate.
+a20_none:
+	call	a20_test
+	jnz	a20_done
+
+	# Next, try the BIOS (INT 0x15, AX=0x2401)
+a20_bios:
+	movw	$0x2401, %ax
+	pushfl					# Be paranoid about flags
+	int	$0x15
+	popfl
+
+	call	a20_test
+	jnz	a20_done
+
+	# Try enabling A20 through the keyboard controller
+a20_kbc:
 	call	empty_8042
 
+	call	a20_test			# Just in case the BIOS worked
+	jnz	a20_done			# but had a delayed reaction.
+
 	movb	$0xD1, %al			# command write
 	outb	%al, $0x64
 	call	empty_8042
@@ -661,29 +684,62 @@
 	outb	%al, $0x60
 	call	empty_8042
 
-#
-#	You must preserve the other bits here. Otherwise embarrasing things
-#	like laptops powering off on boot happen. Corrected version by Kira
-#	Brown from Linux 2.2
-#
-	inb	$0x92, %al			# 
-	orb	$02, %al			# "fast A20" version
-	outb	%al, $0x92			# some chips have only this
-
-# wait until a20 really *is* enabled; it can take a fair amount of
-# time on certain systems; Toshiba Tecras are known to have this
-# problem.  The memory location used here (0x200) is the int 0x80
-# vector, which should be safe to use.
-
-	xorw	%ax, %ax			# segment 0x0000
-	movw	%ax, %fs
-	decw	%ax				# segment 0xffff (HMA)
-	movw	%ax, %gs
-a20_wait:
-	incw	%ax				# unused memory location <0xfff0
-	movw	%ax, %fs:(0x200)		# we use the "int 0x80" vector
-	cmpw	%gs:(0x210), %ax		# and its corresponding HMA addr
-	je	a20_wait			# loop until no longer aliased
+	# Wait until a20 really *is* enabled; it can take a fair amount of
+	# time on certain systems; Toshiba Tecras are known to have this
+	# problem.
+a20_kbc_wait:
+	xorw	%cx, %cx
+a20_kbc_wait_loop:
+	call	a20_test
+	jnz	a20_done
+	loop	a20_kbc_wait_loop
+
+	# Final attempt: use "configuration port A"
+a20_fast:
+	inb	$0x92, %al			# Configuration Port A
+	orb	$0x02, %al			# "fast A20" version
+	andb	$0xFE, %al			# don't accidentally reset
+	outb	%al, $0x92
+
+	# Wait for configuration port A to take effect
+a20_fast_wait:
+	xorw	%cx, %cx
+a20_fast_wait_loop:
+	call	a20_test
+	jnz	a20_done
+	loop	a20_fast_wait_loop
+
+	# A20 is still not responding.  Try frobbing it again.
+	# 
+	decb	(a20_tries)
+	jnz	a20_try_loop
+	
+	movw	$a20_err_msg, %si
+	call	prtstr
+
+a20_die:
+	hlt
+	jmp	a20_die
+
+a20_tries:
+	.byte	A20_ENABLE_LOOPS
+
+a20_err_msg:
+	.ascii	"linux: fatal error: A20 gate not responding!"
+	.byte	13, 10, 0
+
+	# If we get here, all is good
+a20_done:
+
+# set up gdt and idt
+	lidt	idt_48				# load idt with 0,0
+	xorl	%eax, %eax			# Compute gdt_base
+	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
+	shll	$4, %eax
+	addl	$gdt, %eax
+	movl	%eax, (gdt_48+2)
+	lgdt	gdt_48				# load gdt with whatever is
+						# appropriate
 
 # make sure any possible coprocessor is properly reset..
 	xorw	%ax, %ax
@@ -839,6 +895,37 @@
 
 bootsect_panic_mess:
 	.string	"INT15 refuses to access high mem, giving up."
+
+
+# This routine tests whether or not A20 is enabled.  If so, it
+# exits with zf = 0.
+#
+# The memory address used, 0x200, is the int $0x80 vector, which
+# should be safe.
+
+A20_TEST_ADDR = 4*0x80
+
+a20_test:
+	pushw	%cx
+	pushw	%ax
+	xorw	%cx, %cx
+	movw	%cx, %fs			# Low memory
+	decw	%cx
+	movw	%cx, %gs			# High memory area
+	movw	$A20_TEST_LOOPS, %cx
+	movw	%fs:(A20_TEST_ADDR), %ax
+	pushw	%ax
+a20_test_wait:
+	incw	%ax
+	movw	%ax, %fs:(A20_TEST_ADDR)
+	call	delay				# Serialize and make delay constant
+	cmpw	%gs:(A20_TEST_ADDR+0x10), %ax
+	loope	a20_test_wait
+
+	popw	%fs:(A20_TEST_ADDR)
+	popw	%ax
+	popw	%cx
+	ret	
 
 # This routine checks that the keyboard command queue is empty
 # (after emptying the output buffers)
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
