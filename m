Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279823AbRJ0OK4>; Sat, 27 Oct 2001 10:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279822AbRJ0OKq>; Sat, 27 Oct 2001 10:10:46 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:41167 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S279823AbRJ0OKf>;
	Sat, 27 Oct 2001 10:10:35 -0400
Date: Sat, 27 Oct 2001 16:10:59 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110271410.QAA02345@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] arch/i386/boot/bootsect.S incompatibility problem
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

The patch below fixes an incompatibility in arch/i386/boot/bootsect.S,
which kills Linux' floppy driver on some recent motherboards (e.g. my
new ASUS P4T-E Pentium4/I850/S478 mb).

After reading the kernel image, bootsect.S calls kill_motor to stop
the floppy drive, which it does by poking port 0x3f2. On the P4T-E,
this locks up the FDC, casing drivers/block/floppy to report:

Floppy drive(s): fd0 is 1.44M
// long delay here
floppy0: no floppy controllers found

drivers/block/floppy.c:reset_fdc() knows about different vintages of
FDCs, and uses a different method for non-antique FDCs (poking port
0x3f4 instead). If I use that method in bootsect.S, then the FDC doesn't
hang and the floppy driver can identify and use it properly.

However, instead of poking an I/O port there is a BIOS call to reset
the FDC: bootsect.S itself uses that call further up, so my patch simply
replaces the broken I/O port poke with that BIOS call. Tested on a
number of different boxes here, with no breakage observed.

/Mikael

--- linux-2.4.13-ac2/arch/i386/boot/bootsect.S.~1~	Sun Sep 23 21:06:30 2001
+++ linux-2.4.13-ac2/arch/i386/boot/bootsect.S	Sat Oct 27 13:35:13 2001
@@ -395,9 +395,15 @@
 # NOTE: Doesn't save %ax or %dx; do it yourself if you need to.
 
 kill_motor:
+#if 1
+	xorw	%ax, %ax		# reset FDC
+	xorb	%dl, %dl
+	int	$0x13
+#else
 	movw	$0x3f2, %dx
 	xorb	%al, %al
 	outb	%al, %dx
+#endif
 	ret
 
 sectors:	.word 0
