Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQKFRJE>; Mon, 6 Nov 2000 12:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKFRIy>; Mon, 6 Nov 2000 12:08:54 -0500
Received: from ns.sysgo.de ([213.68.67.98]:7408 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129115AbQKFRIl>;
	Mon, 6 Nov 2000 12:08:41 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: setup.S: A20 enable sequence (once again)
Date: Mon, 6 Nov 2000 17:50:44 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00110618083400.11022@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

a while ago, I posted a request here to add the "fast A20" enable sequence to
setup.S in order to enable booting Linux on boards that don't have a keyboard
controller. I was happy to see that this has been added into  2.4.0-test10
already. However, on some embedded boards, booting 2.4.0-test10 does work,
but it takes several minutes which the board spends in complete silence (it took
me almost a day to realize that I only had to wait long enough for the system
to boot ...)

The reason for this is that the A20 enable sequence in setup.S is still
accessing the (in my case not existing) keyboard controller. It times out
eventually, but the timeout takes *very* long, especially on a slowish
embedded 386EX@25MHz.

The attached patch fixes this by doing "fast A20" enable first and then
checking if A20 already is enabled. If it is, the keyboard controller sequence
is skipped. This works for me, so, could people please have a look at this.

Cheers

Rob

diff -ur linux-2.4.0-test10/arch/i386/boot/setup.S linux/arch/i386/boot/setup.S
--- linux-2.4.0-test10/arch/i386/boot/setup.S	Mon Oct 30 23:44:29 2000
+++ linux/arch/i386/boot/setup.S	Mon Nov  6 16:30:40 2000
@@ -631,6 +631,25 @@
 						# appropriate
 
 # that was painless, now we enable a20
+#	Try the "fast A20" version first:
+#	You must preserve the other bits here. Otherwise embarrasing things
+#	like laptops powering off on boot happen. Corrected version by Kira
+#	Brown from Linux 2.2
+#
+	inb	$0x92, %al			# 
+	orb	$02, %al			# "fast A20" version
+	andb	$0xfe, %al			# be sure not to reset CPU
+	outb	%al, $0x92			# some chips have only this
+
+#	See if that already did the job, skip keyboard controller
+#	accesses if so: some boards do not have a keyboard controller.
+#	These boards (especially if running on a slowish 386 EX)
+#	can spend several *minutes* in silence, polling for the
+#	non-existent keyboard controller.
+
+	call	a20_check
+	jne		a20_enabled
+
 	call	empty_8042
 
 	movb	$0xD1, %al			# command write
@@ -641,31 +660,29 @@
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
 # wait until a20 really *is* enabled; it can take a fair amount of
 # time on certain systems; Toshiba Tecras are known to have this
 # problem.  The memory location used here (0x200) is the int 0x80
 # vector, which should be safe to use.
 
+a20_wait:
+	call	a20_check
+	jne		a20_enabled
+	jmp	a20_wait			# loop until no longer aliased
+	
+
+a20_check:
 	xorw	%ax, %ax			# segment 0x0000
 	movw	%ax, %fs
 	decw	%ax				# segment 0xffff (HMA)
 	movw	%ax, %gs
-a20_wait:
 	incw	%ax				# unused memory location <0xfff0
 	movw	%ax, %fs:(0x200)		# we use the "int 0x80" vector
 	cmpw	%gs:(0x210), %ax		# and its corresponding HMA addr
-	je	a20_wait			# loop until no longer aliased
+	ret
 
 # make sure any possible coprocessor is properly reset..
+a20_enabled:
 	xorw	%ax, %ax
 	outb	%al, $0xf0
 	call	delay




 ----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
