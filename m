Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270378AbTHLOcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbTHLOcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:32:13 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2292 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S270378AbTHLOcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:32:09 -0400
Date: Tue, 12 Aug 2003 16:31:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
       fxkuehl@gmx.de, linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: [PATCH][2.6.0-test3] Disable APIC on reboot.
In-Reply-To: <16184.62018.545010.839328@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.3.96.1030812160522.7029E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Mikael Pettersson wrote:

>  >  You obviously want to disable I/O APICs first.
> 
> This follows the same order that the SMP reboot code has been using
> for ages. I did check disable_IO_APIC(), and it does not depend on
> the BP's local APIC being enabled.

 Well, I meant the hardware POV.

> I don't think there is a bug, but if there is, it's in the original
> code too (simply trace what an SMP kernel on UP_IOAPIC HW would do).

 We might not care that much that hardware goes wild just before it's
disabled, but it doesn't mean it's OK.  The bug is indeed in the original
code.  I think disable_IO_APIC() should precede smp_send_stop() and
disconnect_bsp_APIC() should be called from smp_send_stop().  More or
less like this (before your fix):

patch-mips-2.6.0-test2-20030804-apic-reboot-0
diff -up --recursive --new-file linux-mips-2.6.0-test2-20030804.macro/arch/i386/kernel/io_apic.c linux-mips-2.6.0-test2-20030804/arch/i386/kernel/io_apic.c
--- linux-mips-2.6.0-test2-20030804.macro/arch/i386/kernel/io_apic.c	2003-07-30 03:56:43.000000000 +0000
+++ linux-mips-2.6.0-test2-20030804/arch/i386/kernel/io_apic.c	2003-08-12 14:21:24.000000000 +0000
@@ -1598,8 +1598,6 @@ void disable_IO_APIC(void)
 	 * Clear the IO-APIC before rebooting:
 	 */
 	clear_IO_APIC();
-
-	disconnect_bsp_APIC();
 }
 
 /*
diff -up --recursive --new-file linux-mips-2.6.0-test2-20030804.macro/arch/i386/kernel/reboot.c linux-mips-2.6.0-test2-20030804/arch/i386/kernel/reboot.c
--- linux-mips-2.6.0-test2-20030804.macro/arch/i386/kernel/reboot.c	2003-06-06 03:57:19.000000000 +0000
+++ linux-mips-2.6.0-test2-20030804/arch/i386/kernel/reboot.c	2003-08-12 14:25:00.000000000 +0000
@@ -248,8 +248,8 @@ void machine_restart(char * __unused)
 	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
 	 * other OSs see a clean IRQ state.
 	 */
-	smp_send_stop();
 	disable_IO_APIC();
+	smp_send_stop();
 #endif
 
 	if(!reboot_thru_bios) {
diff -up --recursive --new-file linux-mips-2.6.0-test2-20030804.macro/arch/i386/kernel/smp.c linux-mips-2.6.0-test2-20030804/arch/i386/kernel/smp.c
--- linux-mips-2.6.0-test2-20030804.macro/arch/i386/kernel/smp.c	2003-06-23 03:57:08.000000000 +0000
+++ linux-mips-2.6.0-test2-20030804/arch/i386/kernel/smp.c	2003-08-12 14:22:49.000000000 +0000
@@ -551,6 +551,7 @@ void smp_send_stop(void)
 
 	local_irq_disable();
 	disable_local_APIC();
+	disconnect_bsp_APIC();
 	local_irq_enable();
 }
 
You should call disconnect_bsp_APIC() just after disable_local_APIC() for
the UP case from your new code as well.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

