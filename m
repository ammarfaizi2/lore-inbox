Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTKWQlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 11:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTKWQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 11:41:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:62912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262280AbTKWQlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 11:41:03 -0500
Date: Sun, 23 Nov 2003 08:40:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@muc.de>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
In-Reply-To: <20031123114055.GA1844@wonderland.linux.it>
Message-ID: <Pine.LNX.4.44.0311230829270.17378-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Marco d'Itri wrote:
> 
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: IRQ probe failed (0x3cfa: 0). Guessing at 15
> hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
> hdd: 32X10, ATAPI CD/DVD-ROM drive
> Badness in request_irq at arch/i386/kernel/irq.c:572
> Call Trace:
>  [<c021a770>] ide_intr+0x0/0x130

There was nothing before this?

The probe failed _before_ the first warning?

If so, that means that the probing didn't try IRQ 15 for some other reason 
than it already being requested for a device. That other reason is most 
likely that IRQ 15 was "screaming" when the IRQ probe already started, 
which would have made the irq probing turn it off.

So something in the ACPI code made IRQ15 active, or caused there to be a 
pending interrupt. I'd guess that ACPI incorrectly turns the legacy IDE 
interrupts to be PCI interrupts (level-triggered, active low) instead of 
legacy interrupts (edge-triggered, active high).

But I also have to admit that the IDE irq probing code looks a bit 
fragile. We could be more careful about making sure that the IDE 
controller has its interrupt turned off before we start probing. So a 
patch like this might be in order - it should just make autoprobing a bit 
more robust.

Does this one make a difference?

Len - does ACPI ever change the polarity of an interrupt? Just turning the 
irq level-triggered shouldn't matter that much, but if some part of ACPI 
switches polarities around (and gets the wrong one) that would be deadly 
and would cause screaming interrupts when no event is pending.

			Linus

-----
===== drivers/ide/ide-probe.c 1.65 vs edited =====
--- 1.65/drivers/ide/ide-probe.c	Wed Sep  3 09:52:16 2003
+++ edited/drivers/ide/ide-probe.c	Sun Nov 23 08:35:37 2003
@@ -393,13 +393,19 @@
 	 */
 	if (IDE_CONTROL_REG) {
 		u8 ctl = drive->ctl | 2;
+		hwif->OUTB(ctl, IDE_CONTROL_REG);
+
+		/* Clear drive IRQ */
+		(void) hwif->INB(IDE_STATUS_REG);
+		udelay(5);
+
 		if (!hwif->irq) {
 			autoprobe = 1;
 			cookie = probe_irq_on();
 			/* enable device irq */
 			ctl &= ~2;
+			hwif->OUTB(ctl, IDE_CONTROL_REG);
 		}
-		hwif->OUTB(ctl, IDE_CONTROL_REG);
 	}
 
 	retval = actual_try_to_identify(drive, cmd);


