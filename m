Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbQKFU0Y>; Mon, 6 Nov 2000 15:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129770AbQKFU0O>; Mon, 6 Nov 2000 15:26:14 -0500
Received: from ns.sysgo.de ([213.68.67.98]:4599 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129758AbQKFUZ4>;
	Mon, 6 Nov 2000 15:25:56 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: Re: setup.S: A20 enable sequence (once again)
Date: Mon, 6 Nov 2000 21:20:46 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200011062003.VAA11818@rob.devdep.sysgo.de>
In-Reply-To: <200011062003.VAA11818@rob.devdep.sysgo.de>
MIME-Version: 1.0
Message-Id: <00110621255000.12156@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000 you wrote:
H. Peter Anvin wrote
> I just looked at the code, and it's worse than I first thought: if
> memory location 0x200 happens to contain 0x0001 when the kernel is
> entered, this code with loop indefinitely.

Ooops, you're right !

How about this one:

 
diff -ur linux-2.4.0-test10/arch/i386/boot/setup.S linux/arch/i386/boot/setup.S
--- linux-2.4.0-test10/arch/i386/boot/setup.S	Mon Oct 30 23:44:29 2000
+++ linux/arch/i386/boot/setup.S	Mon Nov  6 21:14:45 2000
@@ -631,6 +631,26 @@
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
+	movw	$0x100,%cx			# small retry count
+	call	a20_check
+	jne		a20_enabled
+
 	call	empty_8042
 
 	movb	$0xD1, %al			# command write
@@ -641,20 +661,20 @@
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
 
+a20_recheck:
+	movw	$0xffff,%cx		# large retry count
+	call	a20_check
+	jne		a20_enabled
+	jmp	a20_recheck			# loop until no longer aliased
+	
+#
+# cx has retry count
+a20_check:
 	xorw	%ax, %ax			# segment 0x0000
 	movw	%ax, %fs
 	decw	%ax				# segment 0xffff (HMA)
@@ -663,9 +683,11 @@
 	incw	%ax				# unused memory location <0xfff0
 	movw	%ax, %fs:(0x200)		# we use the "int 0x80" vector
 	cmpw	%gs:(0x210), %ax		# and its corresponding HMA addr
-	je	a20_wait			# loop until no longer aliased
+	loopz	a20_wait
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
