Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbQKFUnr>; Mon, 6 Nov 2000 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbQKFUni>; Mon, 6 Nov 2000 15:43:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47622 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129404AbQKFUn1>; Mon, 6 Nov 2000 15:43:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: setup.S: A20 enable sequence (once again)
Date: 6 Nov 2000 12:43:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u754v$173$1@cesium.transmeta.com>
In-Reply-To: <200011062003.VAA11818@rob.devdep.sysgo.de> <00110621255000.12156@rob>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <00110621255000.12156@rob>
By author:    Robert Kaiser <rob@sysgo.de>
In newsgroup: linux.dev.kernel
>
> On Mon, 06 Nov 2000 you wrote:
> H. Peter Anvin wrote
> > I just looked at the code, and it's worse than I first thought: if
> > memory location 0x200 happens to contain 0x0001 when the kernel is
> > entered, this code with loop indefinitely.
> 
> Ooops, you're right !
> 

As I already discussed with you in email, I think the patch I sent you
is better.  I have attached it below for the benefit of other people,
I would very much like it if as many people as possible tested it out,
since the A20 stuff is mostly black magic; especially on systems that
are known to be troublesome, such as Toshiba laptops.

	-hpa

--- setup.S.old	Mon Oct 30 14:44:29 2000
+++ setup.S	Mon Nov  6 12:13:50 2000
@@ -631,39 +631,45 @@
 						# appropriate
 
 # that was painless, now we enable a20
+
+#
+# First, try the "fast A20 gate".
+#
+	inb	$0x92,%al
+	orb	$0x02,%al			# Fast A20 on
+	andb	$0xfe,%al			# Don't reset CPU!
+	outb	%al,$0x92
+
+#
+# Now comes the tricky part: some machines don't have a KBC and thus
+# would end up looping almost indefinitely here.  HOWEVER, once we
+# have done the first command write, we must not stop the sequence.
+# Therefore, the first empty_8042 should check to see if the fast A20
+# did the trick and stop its probing at that stage; but subsequent ones
+# must not do so.
+#
+	movb	$0x01,%dl			# A20-sensitive
 	call	empty_8042
+	jnz	a20_wait			# A20 already on?
 
 	movb	$0xD1, %al			# command write
 	outb	%al, $0x64
+	xorb	%dl,%dl				# Not A20-sensitive
 	call	empty_8042
 
 	movb	$0xDF, %al			# A20 on
 	outb	%al, $0x60
+	xorb	%dl,%dl				# Not A20-sensitive
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
 # wait until a20 really *is* enabled; it can take a fair amount of
 # time on certain systems; Toshiba Tecras are known to have this
 # problem.  The memory location used here (0x200) is the int 0x80
 # vector, which should be safe to use.
 
-	xorw	%ax, %ax			# segment 0x0000
-	movw	%ax, %fs
-	decw	%ax				# segment 0xffff (HMA)
-	movw	%ax, %gs
 a20_wait:
-	incw	%ax				# unused memory location <0xfff0
-	movw	%ax, %fs:(0x200)		# we use the "int 0x80" vector
-	cmpw	%gs:(0x210), %ax		# and its corresponding HMA addr
-	je	a20_wait			# loop until no longer aliased
+	call	a20_test
+	jz	a20_wait
 
 # make sure any possible coprocessor is properly reset..
 	xorw	%ax, %ax
@@ -825,14 +831,24 @@
 #
 # Some machines have delusions that the keyboard buffer is always full
 # with no keyboard attached...
+#
+# If %dl is nonzero on entry, terminate with ZF=0 if A20 becomes alive,
+# otherwise terminate with ZF=1.
 
 empty_8042:
 	pushl	%ecx
-	movl	$0x00FFFFFF, %ecx
+	movl	$0x000FFFFF, %ecx
 
 empty_8042_loop:
 	decl	%ecx
-	jz	empty_8042_end_loop
+	jz	empty_8042_end_loop		# ZF=1
+
+	# Always call the test routine to keep delays constant
+	call	a20_test
+	jz	ignore_a20
+	and	%dl,%dl
+	jnz	empty_8042_end_loop		# ZF=0
+ignore_a20:
 
 	call	delay
 
@@ -847,10 +863,38 @@
 no_output:
 	testb	$2, %al				# is input buffer full?
 	jnz	empty_8042_loop			# yes - loop
+	# ZF=1
+
 empty_8042_end_loop:
 	popl	%ecx
 	ret
 
+a20_test:
+	pushw	%ax
+	pushw	%cx
+	pushw	%fs
+	pushw	%gs
+	xorw	%ax, %ax			# segment 0x0000
+	movw	%ax, %fs
+	decw	%ax				# segment 0xffff (HMA)
+	movw	%ax, %gs
+	movw	0x100,%cx
+	movw	%fs:(0x200),%ax			# So we keep cycling...
+	pushw	%ax				# Be extra paranoid...
+a20_loop:
+	incw	%ax				# unused memory location <0xfff0
+	movw	%ax, %fs:(0x200)		# we use the "int 0x80" vector
+	cmpw	%gs:(0x210), %ax		# and its corresponding HMA addr
+	jnz	a20_ret				# if ZF not set A20 is functional
+	loop	a20_loop
+a20_ret:
+	popw	%fs:(0x200)
+	popw	%gs
+	popw	%fs
+	popw	%cx
+	popw	%ax
+	ret					# if ZF set A20 is not operational
+
 # Read the cmos clock. Return the seconds in al
 gettime:
 	pushw	%cx
@@ -867,7 +911,8 @@
 
 # Delay is needed after doing I/O
 delay:
-	jmp	.+2				# jmp $+2
+	outb	%al,$0x80			# What the main kernel uses
+	outb	%al,$0x80
 	ret
 
 # Descriptor tables
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
