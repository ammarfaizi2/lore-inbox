Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTKWDYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 22:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTKWDYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 22:24:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:13738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263241AbTKWDYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 22:24:19 -0500
Date: Sat, 22 Nov 2003 19:24:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Len Brown <len.brown@intel.com>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
In-Reply-To: <20031123021537.GA1816@wonderland.linux.it>
Message-ID: <Pine.LNX.4.44.0311221902340.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Marco d'Itri wrote:
>
> It does not. This is the output with your patch applied and PCI
> debugging enabled:

Thanks. This is interesting. Looking at the IRQ probing output:

> hdc: IRQ probe failed (0x3cfa: 0). Guessing at 15

The interesting parts are the 0x3cfa and the 0:
 - the "0" means that we literally didn't see any interrupt at all during 
   the autoprobing. Sometimes autoprobing fails because we see _multiple_ 
   interrupts, but that wasn't the case here.
 - 0x3cfa is the "probe cookie", which tells which irq's were free to be 
   probed. That's

	1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13

   and what's interesting is that irq 15 wasn't even probed at all (14 
   wasn't either, but that's easy to explain: we took that when we probed 
   and registered ide channel 0 earlier. irq 0 and 2 are special - timer 
   and cascade respectively).

So for some reason irq 15 has already been reserved. Somebody has already 
registered IRQ 15 _before_ we probe for it for that hwif. And:

> irq 15: nobody cared!
> Call Trace:
>  [ ... ]
> handlers:
> [<c021a730>] (ide_intr+0x0/0x130)

this shows that the claimer of the irq is the IDE layer itself.

But why has the IDE layer already claimed that interrupt? 

> Before receiving your second message I tried booting with pci=noacpi and
> it worked:

Interesting and good in the sense that this is another clue. Why does ACPI 
interrupt routing cause the IDE layer to register irq 15 too early?

Both the PIRQ routing code and the ACPI code give irq3 to the other IDE 
chip. So why has the IDE stuff registered _another_ irq15 earlier? 

I don't see it.. Len, Bartlomiej, do you see anything?

Marco, can you try this appended (very very stupid) patch with ACPI on, so
that we can see where irq15 gets registered? It won't fix anything, but 
I'm confused by why IRQ 15 has been registered before we probe for it..

Thanks,

			Linus

---
===== arch/i386/kernel/irq.c 1.45 vs edited =====
--- 1.45/arch/i386/kernel/irq.c	Wed Oct 22 20:26:34 2003
+++ edited/arch/i386/kernel/irq.c	Sat Nov 22 19:22:20 2003
@@ -569,6 +569,8 @@
 	if (!action)
 		return -ENOMEM;
 
+	WARN_ON(irq == 15);
+
 	action->handler = handler;
 	action->flags = irqflags;
 	action->mask = 0;

