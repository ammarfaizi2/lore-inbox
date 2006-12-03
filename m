Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759670AbWLCNTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670AbWLCNTo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759672AbWLCNTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:19:44 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:58444 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1759665AbWLCNTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:19:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=OQ9goHHmH71xdgNU7/HUMerroQLDcyoff/1dngGmvsFdAPNyd0ync3/p4ot1elRNDK9VS3vjuV0MR44Z1m1DfDod6ou3UJsdeJd4zfLvAMxt5YFbcJ5w6B+3ti15BdFIQw7r5pBksDPhAdh7GAq57T1Ji21eHaX01qVG4nm9ET8=
Message-ID: <4572CEE7.502@gmail.com>
Date: Sun, 03 Dec 2006 22:19:35 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se> <4572CA7A.6010103@gmail.com> <4572CB2B.8050406@garzik.org>
In-Reply-To: <4572CB2B.8050406@garzik.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, Mikael.
>>
>> Thanks for doing this.
>>
>> Mikael Pettersson wrote:
>> [--snip--]
>>> +static void pdc_freeze(struct ata_port *ap)
>>> +{
>>> +    void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>>> +    u32 tmp;
>>> +
>>> +    tmp = readl(mmio + PDC_CTLSTAT);
>>> +    tmp |= PDC_IRQ_DISABLE;
>>> +    tmp &= ~PDC_DMA_ENABLE;
>>> +    writel(tmp, mmio + PDC_CTLSTAT);
>>> +    readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil
>>> does this */
>>
>> Just drop the above line.
>>
>>> +}
>>> +
>>> +static void pdc_thaw(struct ata_port *ap)
>>> +{
>>> +    void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>>> +    u32 tmp;
>>> +
>>> +    /* clear IRQ */
>>> +    readl(mmio + PDC_INT_SEQMASK);
>>> +
>>> +    /* turn IRQ back on */
>>> +    tmp = readl(mmio + PDC_CTLSTAT);
>>> +    tmp &= ~PDC_IRQ_DISABLE;
>>> +    writel(tmp, mmio + PDC_CTLSTAT);
>>> +    readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */
>>
>> Ditto.
> 
> Why do you think these flushes are not needed?

1. for thaw, it doesn't matter.  it's always followed by further IO
operations.

2. for freeze, interrupt delivery is asynchronous to IO anyway and
freeze is also called from outside of interrupt handler.  IRQ handler
must be ready to handle spurious interrupts on a frozen port (Note they
automatically are because they can't access aborted qc's).  As long as
it gets quiesced after finite number of interrupts, it's okay.

3. we don't have them in ahci nor sata_sil24.

But, having those flushes won't hurt either.  What was the conclusion of
mmio <-> spinlock sync discussion?  I always feel kind of uncomfortable
about readl() flushes.  I think they're too subtle.

-- 
tejun
