Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLGA1z>; Wed, 6 Dec 2000 19:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbQLGA1p>; Wed, 6 Dec 2000 19:27:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:49412 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129524AbQLGA10>; Wed, 6 Dec 2000 19:27:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: The latest instance in the A20 farce
Date: 6 Dec 2000 15:55:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90mjl3$988$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here is yet another A20 patch (against test12-pre6) this time
for people to try out.  This patch uses the following algorithm for
enabling A20:

1. Try the BIOS call.  If it works, we're cool.
2. Try the KBC (using Linus' lowered timeouts.)
3. If the KBC doesn't work, or is very slow, flip port 92.

After 3 it sits into the same infinite loop waiting for A20 to become
enabled (necessary on for example some Toshiba notebooks which have an
extremely slow response to A20.)

The main differences between this patch and test12-pre6:

- Trying the BIOS first of all.  This should reduce the risk of the
  BIOS getting confused while doing a suspend.  This also gives even
  less of an excuse for any nonstandard arrangement -- if you didn't
  implement the standard KBC *and* you didn't provide the BIOS call,
  you have a seriously broken piece of hardware.

- If the KBC responds quickly enough (within about 10000 cycles), we
  don't ever touch the fast A20 gate.  This is a difference from
  previous code, where the fast A20 gate was toggled immediately after
  the KBC, even if the KBC responded instantly.

- I had to move the A20 code somewhat earlier in setup.S in order for
  the BIOS to still be available.

Please try it out and let me know as soon as possible...

	-hpa


--- arch/i386/boot/setup.S.12p6	Wed Dec  6 12:49:07 2000
+++ arch/i386/boot/setup.S	Wed Dec  6 15:25:01 2000
@@ -532,6 +532,70 @@
 	movl	%cs:code32_start, %eax
 	movl	%eax, %cs:code32
 
+# Make sure interrupts really are disabled here...
+	cli
+
+#
+# That was painless, now we enable A20, which definitely isn't.
+#
+# First, we try the BIOS (INT 15:2401).
+# Second, try the keyboard controller with a timeout.
+# Third, try the "fast A20 gate" manually.
+#
+# The "fast A20 gate" is dangerous to use manually, because of
+# system and BIOS bugs -- some manufacturers have used it as an
+# extra GPIO pin(!!!!) and some BIOSes fail to save/restore it
+# on Suspend/Wakeup.
+#
+	movw	$0x2401,%ax			# BIOS: Enable A20
+	stc
+	int	$0x15
+	jc	a20_no_bios			# CF=0 if success
+	testb	%ah,%ah				# AH=0 if success
+	jnz	a20_no_bios
+
+	# BIOS reported success, verify that it really did work
+	call	a20_test
+	jnz	a20_done
+
+a20_no_bios:					# Try the KBC next...
+	call	empty_8042
+
+	movb	$0xD1, %al			# command write
+	outb	%al, $0x64
+	call	empty_8042
+
+	movb	$0xDF, %al			# A20 on
+	outb	%al, $0x60
+	call	empty_8042
+#
+# If A20 is enabled here, don't touch port 92
+#
+	call	a20_test
+	jnz	a20_done
+	
+#
+# Either the KBC is really slow, or we need to use fast A20.  Flip
+# fast A20 and then sit in a loop and spin waiting for A20 to come alive.
+#
+# You must preserve the other bits here. Otherwise embarrasing things
+# like laptops powering off on boot happen. Corrected version by Kira
+# Brown from Linux 2.2
+#
+	inb	$0x92, %al			# System Control Port A
+	orb	$02, %al			# Fast A20 enable
+	outb	%al, $0x92
+
+# Wait until a20 really *is* enabled; it can take a fair amount of
+# time on certain systems; Toshiba Tecras are known to have this
+# problem.
+
+a20_wait:
+	call	a20_test
+	jz	a20_wait
+	
+a20_done:	# A20 verified enabled here
+
 # Now we move the system to its rightful place ... but we check if we have a
 # big-kernel. In that case we *must* not move it ...
 	testb	$LOADED_HIGH, %cs:loadflags
@@ -581,6 +645,7 @@
 # We also then need to move the params behind it (commandline)
 # Because we would overwrite the code on the current IP, we move
 # it in two steps, jumping high after the first one.
+
 	movw	%cs, %ax
 	cmpw	$SETUPSEG, %ax
 	je	end_move_self
@@ -621,6 +686,9 @@
 	movw	%ax, %ds
 	movw	%dx, %ss
 end_move_self:					# now we are at the right place
+
+# Set up IDT/GDT for protected-mode use.
+
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
 	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
@@ -630,41 +698,6 @@
 	lgdt	gdt_48				# load gdt with whatever is
 						# appropriate
 
-# that was painless, now we enable a20
-	call	empty_8042
-
-	movb	$0xD1, %al			# command write
-	outb	%al, $0x64
-	call	empty_8042
-
-	movb	$0xDF, %al			# A20 on
-	outb	%al, $0x60
-	call	empty_8042
-
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
-
 # make sure any possible coprocessor is properly reset..
 	xorw	%ax, %ax
 	outb	%al, $0xf0
@@ -859,6 +892,36 @@
 	popl	%ecx
 	ret
 
+# Wait for the A20 gate to become enabled.  Time out reasonably quickly;
+# return with ZF=0 is A20 now live; ZF=1 if A20 still masked.
+# The test location, memory address 0x200, is the INT 0x80 vector which
+# should be safe to use.
+
+a20_test:
+	pushw	%fs
+	pushw	%gs
+	pushw	%ax
+	pushw	%cx
+	xorw	%ax,%ax				# Low 64K
+	movw	%ax,%fs
+	decw	%ax				# HMA = segment 0xFFFF
+	movw	%ax,%gs
+	movw	%fs:(0x200),%ax
+	pushw	%ax				# Paranoia
+	movw	$0x1000,%cx			# Loop counter
+a20_loop:
+	incw	%ax
+	movw	%ax,%fs:(0x200)
+	cmpw	%ax,%gs:(0x210)			# Aliased?
+	loope	a20_loop			# If so, continue
+	# ZF=0 if no alias, ZF=1 if timeout
+	popw	%fs:(0x200)
+	popw	%cx
+	popw	%ax
+	popw	%gs
+	popw	%fs
+	ret
+	
 # Read the cmos clock. Return the seconds in al
 gettime:
 	pushw	%cx
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
