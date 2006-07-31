Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWGaX3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWGaX3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWGaX3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:29:08 -0400
Received: from halon.profiwh.com ([85.93.165.2]:17382 "EHLO orfeus.profiwh.com")
	by vger.kernel.org with ESMTP id S1751473AbWGaX3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:29:07 -0400
Message-id: <io_apic_has_to_be_repaired@huhuhu_blaah>
Subject: [PATCH] io_apic fix spinlock in resume [Was: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]]
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mingo@redhat.com
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Mon, 31 Jul 2006 19:29:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Rafael J. Wysocki napsal(a):
> > > On Sunday 30 July 2006 02:06, Pavel Machek wrote:
> >> >> Hi!
> >> >>
> >>>>>>> >>>>>>> I have problems with swsusp again. While suspending, the very
> >>>>>>> >>>>>>> last thing kernel
> >>>>>>> >>>>>>> writes is 'restoring higmem' and then hangs, hardly. No sysrq
> >>>>>>> >>>>>>> response at all.
> >>>>>>> >>>>>>> Here is a snapshot of the screen:
> >>>>>>> >>>>>>> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
> >>>>>>> >>>>>>>
> >>>>>>> >>>>>>> It's SMP system (HT), higmem enabled (1 gig of ram).
> >>>>>> >>>>>> Most probably it hangs in device_power_up(), so the problem
> >>>>>> >>>>>> seems to be
> >>>>>> >>>>>> with one of the devices that are resumed with IRQs off.
> >>>>>> >>>>>>
> >>>>>> >>>>>> Does vanila .18-rc2 work?
> >>>>> >>>>> Yup, it does.
> >>>> >>>> Can you try up kernel, no highmem? (mem=512M)?
> >>> >>> It writes then:
> >>> >>> p16v: status 0xffffffff, mask 0x00001000, pvoice f7c04a20, use 0
> >>> >>> in endless loop when resuming -- after reading from swap.
> >> >> Okay, so we have two different problems here.
> >> >>
> >> >> One is "hang during suspend" with smp/highmem mode,
> > > 
> > > That one is "interesting".  I've no idea why the restoration of highmem
> > > would
> > > have caused the box to hang like that.  Jiri, could you please post the
> > > output
> > > of dmesg after a fresh boot?
> 
> higmem is ok. ioapic0 is the culprit -- its class resume dies:
>         if (cls->resume)
>                 cls->resume(dev); <----
> in __sysdev_resume

io_apic fix spinlock in resume

In io_apic class resume after Andi's cleanup was wiped out one unlock of
spinlock. Get him back to allow suspending (and resuming) of machine.

Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 2d82ba5b564500cb29613ee9c24b1d0efa829518
tree 64551b2f45e6ffd3f220af85f25dae2199897652
parent 8e013921e94b248b33880b58b46e5eba4a931b51
author Jiri Slaby <ku@bellona.localdomain> Tue, 01 Aug 2006 01:16:13 +0159
committer Jiri Slaby <ku@bellona.localdomain> Tue, 01 Aug 2006 01:16:13 +0159

 arch/i386/kernel/io_apic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index fa0eb9f..617037a 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2360,6 +2360,7 @@ static int ioapic_resume(struct sys_devi
 		reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
 		io_apic_write(dev->id, 0, reg_00.raw);
 	}
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++)
 		ioapic_write_entry(dev->id, i, entry[i]);
 
