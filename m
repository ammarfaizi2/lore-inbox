Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbQLMXct>; Wed, 13 Dec 2000 18:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbQLMXck>; Wed, 13 Dec 2000 18:32:40 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:38917 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129774AbQLMXc0>;
	Wed, 13 Dec 2000 18:32:26 -0500
Date: Thu, 14 Dec 2000 00:01:35 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: [PATCH] VIA82C694X based SMP board...
Message-ID: <20001214000135.A1181@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  after couple of hours of hacking I finally got my VIA82C694X based
SMP board (Gigabyte GA-6VXD7) to work. I had to add 'udelay(300);'
after sending startup ipi, before we print something to screen.

  Without this udelay it died at the beginning of second printk
(that is, Startup point 1. was printed, there was one empty line at
the end of screen, but Waiting for send to finish was not visible.
And cursor was sometime at the beginning of last line, sometime 
at the end of last line, and sometime invisible :-( ) in couple 
of spectacular ways - almost always hard lock, but four times it 
except hardlocking also powered down both CPU fans and did not react 
even to hard reset (well, it reacted, but BIOS was not able to 
initialize machine).

  I have no idea whether memory r-m-w cycle killed it, or whether
PCI outb cycle (vgacon cursor move) killed it, or what-where-why...
But it must be something in our secondary CPU kernel initialization,
as if I add some loop into trampoline.S, I must increase delay.

  If somebody has access to VIA specs (I asked them, but no answer
yet) and can confirm this in their errata, or if someone sees something
like that in Intel PIII errata (Pentium III Coppermine, BIOS says
CPU ID: 0683, Patch ID: 0010)...

  Anyway, without either of two patches below my machine does not
boot. Is there any reason why we cannot add 'udelay(300);' after
sending startup IPI, as first patch does? Both patches are for
2.4.0-test12. I did not tried 2.2.18 yet (should I?).

  And another question, is there anybody successfully using
Gigabyte 6VXD7 board with two CPUs under Linux 2.4.0-test12 (Netware 
worked without any patch, just FYI) ?
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz





Variant #1:

diff -urdN linux/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	Mon Dec  4 01:48:19 2000
+++ linux/arch/i386/kernel/smpboot.c	Wed Dec 13 22:30:47 2000
@@ -694,9 +694,22 @@
 		apic_write_around(APIC_ICR, APIC_DM_STARTUP
 					| (start_eip >> 12));
 
+		/*
+		 * Petr Vandrovec:
+		 *
+		 * We must not do I/O operations for at least
+		 * 300us... printk does (probably acquiring spinlock
+		 * kills it)... Kills VT82C694X based
+		 * SMP board. At least mine GA-6VXD7.
+		 * 100us is not enough, 200us is enough,
+		 * so I use 300us for additional safety.
+		 */
+
+		udelay(300);
+
 		Dprintk("Startup point 1.\n");
 
 		Dprintk("Waiting for send to finish...\n");
 		timeout = 0;
 		do {
 			Dprintk("+");


Variant #2:

--- linux/arch/i386/kernel/smpboot.c	Mon Dec  4 02:48:19 2000
+++ linux/arch/i386/kernel/smpboot.c	Wed Dec 13 23:29:11 2000
@@ -694,9 +694,19 @@
 		apic_write_around(APIC_ICR, APIC_DM_STARTUP
 					| (start_eip >> 12));
 
+		/*
+		 * Petr Vandrovec:
+		 *
+		 * We must not do I/O operations for at least
+		 * 300 us... printk does (probably acquiring spinlock
+		 * kills it)... Kills VT82C694X based
+		 * SMP board. At least mine GA-6VXD7.
+
 		Dprintk("Startup point 1.\n");
 
 		Dprintk("Waiting for send to finish...\n");
+		 */
+		
 		timeout = 0;
 		do {
 			Dprintk("+");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
