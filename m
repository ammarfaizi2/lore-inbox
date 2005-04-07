Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVDGRZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVDGRZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVDGRY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:24:27 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:49077 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S262510AbVDGRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:24:08 -0400
Date: Thu, 7 Apr 2005 13:23:58 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: clock runs at double speed on x86_64 system w/ATI
 RS200 chipset (workaround for APIC mode?)
In-Reply-To: <20050407073713.GA74220@muc.de>
Message-ID: <Pine.LNX.4.58.0504071319180.17904@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
 <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
 <20050405183141.GA27195@muc.de> <Pine.LNX.4.58.0504061758150.4573@hammer.engin.umich.edu>
 <20050407073713.GA74220@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Andi Kleen wrote:

> >
> > I'm still seeing 'APIC error on CPU0: 00(40)' messages from time to time.
>
> Thanks for the analysis. The clear_IO_APIC_pin looks quite hackish,
> I am not sure I want to put that into the mainline kernel.

Of course. The patch was a simplification, the idea was to just prevent it
from using the default routing; here's a patch that's functionally
equivalent for me:



--- arch/x86_64/kernel/io_apic.c.orig	2005-03-25 22:28:21.000000000 -0500
+++ arch/x86_64/kernel/io_apic.c	2005-04-07 13:13:58.813193024 -0400
@@ -1564,6 +1564,8 @@
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
+static int timer_hack = 0;
+
 static inline void check_timer(void)
 {
 	int pin1, pin2;
@@ -1597,7 +1599,7 @@
 		 * Ok, does IRQ0 through the IOAPIC work?
 		 */
 		unmask_IO_APIC_irq(0);
-		if (timer_irq_works()) {
+		if ((!timer_hack) && timer_irq_works()) {
 			nmi_watchdog_default();
 			if (nmi_watchdog == NMI_IO_APIC) {
 				disable_8259A_irq(0);
@@ -1669,6 +1671,14 @@
 	panic("IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter\n");
 }

+static int __init timerhack(char *str)
+{
+	timer_hack = 1;
+	return 1;
+}
+__setup("timerhack", timerhack);
+
+
 /*
  *
  * IRQ's that are handled by the PIC in the MPS IOAPIC case.




With that patch I get the same behavior; the timer interrupt is labeled
'local-APIC-edge' and it ticks at the correct rate.



> The APIC errors are also suspicious.
>
> I don't want to blacklist ATI from just a single report,
> but if there are more it is probably best to just disable
> the IO-APIC by default there for now.

It will be interesting to see if anyone else has problems when systems
with this ATI integrated chipset (Radeon Xpress 200) become more common.


Thanks,

Chris
wingc@engin.umich.edu
