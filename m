Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTKWFt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 00:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTKWFt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 00:49:28 -0500
Received: from fmr03.intel.com ([143.183.121.5]:38568 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263290AbTKWFtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 00:49:23 -0500
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Marco d'Itri" <md@Linux.IT>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.44.0311221902340.2379-100000@home.osdl.org>
References: <Pine.LNX.4.44.0311221902340.2379-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1069566548.3249.30.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Nov 2003 00:49:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was ACPI enabled on the version of 2.4 that worked?  If yes, I'd like to
see the 2.4 dmesg and /proc/interrupts.

[BTW Marco, If you collect a lot of info related to this failure, please
be encouraged to attach it to a bug report --
http://bugzilla.kernel.org/ Category: Power Management, Component: ACPI
-- the output from acpidmp would be helpful]

> noapic
This will have no effect -- we're already in PIC mode.

I don't know anything about the ide layer probing interrupts, but this
one is an interesting case at the low level.

> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12)

Here the BIOS gives us a lot of possible choices for where to send LNKH,
but the list does not include 15.

> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 15
>  -> edge<6>PCI: Using ACPI for IRQ routing

Here we program LNKH to 15, which means the BIOS told us it was already
active on 15 -- there's no way we would have selected 15 based on the
list of possibles above.

Then we set the interrupt to level triggered -- as we do with all PCI
interrupts.  This may be a bad assumption -- though we do exactly the
same thing in 2.4...  In any case, Marco, perhaps you can try this quick
hack to skip that setting  for 15 and perhaps that will add a clue.

thanks,
-Len

===== drivers/acpi/pci_irq.c 1.22 vs edited =====
--- 1.22/drivers/acpi/pci_irq.c	Tue Sep  9 06:24:14 2003
+++ edited/drivers/acpi/pci_irq.c	Sun Nov 23 00:15:52 2003
@@ -372,7 +372,7 @@
 	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
 	 */
 #ifdef CONFIG_X86
-	if ((dev->irq < 16) &&  !((1 << dev->irq) & irq_mask)) {
+	if ((dev->irq < 15) &&  !((1 << dev->irq) & irq_mask)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d as
level-triggered\n", dev->irq));
 		irq_mask |= (1 << dev->irq);
 		eisa_set_level_irq(dev->irq);








On Sat, 2003-11-22 at 22:24, Linus Torvalds wrote:
> On Sun, 23 Nov 2003, Marco d'Itri wrote:
> >
> > It does not. This is the output with your patch applied and PCI
> > debugging enabled:
> 
> Thanks. This is interesting. Looking at the IRQ probing output:
> 
> > hdc: IRQ probe failed (0x3cfa: 0). Guessing at 15
> 
> The interesting parts are the 0x3cfa and the 0:
>  - the "0" means that we literally didn't see any interrupt at all during 
>    the autoprobing. Sometimes autoprobing fails because we see _multiple_ 
>    interrupts, but that wasn't the case here.
>  - 0x3cfa is the "probe cookie", which tells which irq's were free to be 
>    probed. That's
> 
> 	1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
> 
>    and what's interesting is that irq 15 wasn't even probed at all (14 
>    wasn't either, but that's easy to explain: we took that when we probed 
>    and registered ide channel 0 earlier. irq 0 and 2 are special - timer 
>    and cascade respectively).
> 
> So for some reason irq 15 has already been reserved. Somebody has already 
> registered IRQ 15 _before_ we probe for it for that hwif. And:
> 
> > irq 15: nobody cared!
> > Call Trace:
> >  [ ... ]
> > handlers:
> > [<c021a730>] (ide_intr+0x0/0x130)
> 
> this shows that the claimer of the irq is the IDE layer itself.
> 
> But why has the IDE layer already claimed that interrupt? 
> 
> > Before receiving your second message I tried booting with pci=noacpi and
> > it worked:
> 
> Interesting and good in the sense that this is another clue. Why does ACPI 
> interrupt routing cause the IDE layer to register irq 15 too early?
> 
> Both the PIRQ routing code and the ACPI code give irq3 to the other IDE 
> chip. So why has the IDE stuff registered _another_ irq15 earlier? 
> 
> I don't see it.. Len, Bartlomiej, do you see anything?
> 
> Marco, can you try this appended (very very stupid) patch with ACPI on, so
> that we can see where irq15 gets registered? It won't fix anything, but 
> I'm confused by why IRQ 15 has been registered before we probe for it..
> 
> Thanks,
> 
> 			Linus
> 
> ---
> ===== arch/i386/kernel/irq.c 1.45 vs edited =====
> --- 1.45/arch/i386/kernel/irq.c	Wed Oct 22 20:26:34 2003
> +++ edited/arch/i386/kernel/irq.c	Sat Nov 22 19:22:20 2003
> @@ -569,6 +569,8 @@
>  	if (!action)
>  		return -ENOMEM;
>  
> +	WARN_ON(irq == 15);
> +
>  	action->handler = handler;
>  	action->flags = irqflags;
>  	action->mask = 0;
> 

