Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760318AbWLFIwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760318AbWLFIwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760323AbWLFIwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:52:15 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63319 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760318AbWLFIwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:52:14 -0500
Date: Wed, 6 Dec 2006 09:52:04 +0100 (MET)
Message-Id: <200612060852.kB68q4i0024622@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: htejun@gmail.com, jeff@garzik.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, mikpe@it.uu.se
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 22:19:35 +0900, Tejun Heo wrote:
>Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Hello, Mikael.
>>>
>>> Thanks for doing this.
>>>
>>> Mikael Pettersson wrote:
>>> [--snip--]
>>>> +static void pdc_freeze(struct ata_port *ap)
>>>> +{
>>>> +    void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>>>> +    u32 tmp;
>>>> +
>>>> +    tmp = readl(mmio + PDC_CTLSTAT);
>>>> +    tmp |= PDC_IRQ_DISABLE;
>>>> +    tmp &= ~PDC_DMA_ENABLE;
>>>> +    writel(tmp, mmio + PDC_CTLSTAT);
>>>> +    readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil
>>>> does this */
>>>
>>> Just drop the above line.
>>>
>>>> +}
>>>> +
>>>> +static void pdc_thaw(struct ata_port *ap)
>>>> +{
>>>> +    void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>>>> +    u32 tmp;
>>>> +
>>>> +    /* clear IRQ */
>>>> +    readl(mmio + PDC_INT_SEQMASK);
>>>> +
>>>> +    /* turn IRQ back on */
>>>> +    tmp = readl(mmio + PDC_CTLSTAT);
>>>> +    tmp &= ~PDC_IRQ_DISABLE;
>>>> +    writel(tmp, mmio + PDC_CTLSTAT);
>>>> +    readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */
>>>
>>> Ditto.
>> 
>> Why do you think these flushes are not needed?
>
>1. for thaw, it doesn't matter.  it's always followed by further IO
>operations.
>
>2. for freeze, interrupt delivery is asynchronous to IO anyway and
>freeze is also called from outside of interrupt handler.  IRQ handler
>must be ready to handle spurious interrupts on a frozen port (Note they
>automatically are because they can't access aborted qc's).  As long as
>it gets quiesced after finite number of interrupts, it's okay.
>
>3. we don't have them in ahci nor sata_sil24.

But you do in sata_sil.c:sil_freeze().

>But, having those flushes won't hurt either.

libata doesn't specify in its documentation that these driver
operations may have delayed behaviour, so I have to assume that
side-effects are to be completed when the operations return.
In fact, the documentation for __ata_port_freeze explicitly
requires the port to not perform any operations until thawed.
If I didn't flush, the port could do just that.

Since the flushes clearly are safe I'd prefer to keep them, but
of course I'll remove them if you or Jeff can guarantee that not
flushing the PCI writes is OK.

/Mikael
