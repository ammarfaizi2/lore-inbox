Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131273AbQLFCJD>; Tue, 5 Dec 2000 21:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131283AbQLFCIn>; Tue, 5 Dec 2000 21:08:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131273AbQLFCIk>; Tue, 5 Dec 2000 21:08:40 -0500
Date: Tue, 5 Dec 2000 17:37:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <3A2D91F0.D8FE8BBC@transmeta.com>
Message-ID: <Pine.LNX.4.10.10012051733010.967-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, H. Peter Anvin wrote:
> 
> I might hack on using INT 15h to do the jump to protected mode, as ugly
> as it is, but I won't have time before my trip.  It would require quite a
> bit of restructuring in setup.S, and would probably break LOADLIN.

Right now this is my interim patch (to clean test11). The thing to note is
that I decreased the keyboard controller timeout by a factor of about 167,
while making the "delay" a bit longer.

Now, if you don't have a keyboard controller, the bootup delay should be
on the order of 1.2 seconds or so (calling empty_8042 three times, each
around 0.4 seconds to time out). Which is acceptable. Especially as the
non-keyboard-controller machines that don't even emulate one are quite
rare. And it's still long enough that if the keyboard controller hasn't
emptied in 0.4 seconds, something else is badly wrong.

The non-keyboard-controller timeout used to be around three minutes
before. Which _definitely_ is excessive. Most people would assume that the
machine had hung.

		Linus

----
--- v2.4.0-test11/linux/arch/i386/boot/setup.S	Tue Oct 31 12:42:26 2000
+++ linux/arch/i386/boot/setup.S	Tue Dec  5 17:31:53 2000
@@ -825,10 +825,18 @@
 #
 # Some machines have delusions that the keyboard buffer is always full
 # with no keyboard attached...
+#
+# If there is no keyboard controller, we will usually get 0xff
+# to all the reads.  With each IO taking a microsecond and
+# a timeout of 100,000 iterations, this can take about half a
+# second ("delay" == outb to port 0x80). That should be ok,
+# and should also be plenty of time for a real keyboard controller
+# to empty.
+#
 
 empty_8042:
 	pushl	%ecx
-	movl	$0x00FFFFFF, %ecx
+	movl	$100000, %ecx
 
 empty_8042_loop:
 	decl	%ecx
@@ -867,7 +875,7 @@
 
 # Delay is needed after doing I/O
 delay:
-	jmp	.+2				# jmp $+2
+	outb	%al,$0x80
 	ret
 
 # Descriptor tables

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
