Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318683AbSHAJjn>; Thu, 1 Aug 2002 05:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318684AbSHAJjm>; Thu, 1 Aug 2002 05:39:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9988 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S318683AbSHAJjl>;
	Thu, 1 Aug 2002 05:39:41 -0400
Message-ID: <3D483F0D.8000509@evision.ag>
Date: Wed, 31 Jul 2002 21:48:29 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <9A81BA09AB@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> I wrote:
> 
>>On 30 Jul 02 at 16:25, Marcin Dalecki wrote:
>>
>>>>Second problem is that read operation which ends with
>>>>"drive ready, seek complete, data request" (why it happened in first
>>>>place?) will just read one sector from drive (it was DMA transfer,
>>>>so drive->mult_count == 0), and then it returns from ata_error
>>>>with ATA_OP_CONTINUES. But what continues? Drive told us that
>>>>current operation is done, and no new operation was started, so
>>>>there is very low chance that some IRQ will ever come, and timer was
>>>>just removed by ata_irq_request(), so channel will never awake.
>>>
>>>What should continue is the retry of the operation, since otherwise
>>>it will be abondoned in do_ide_request(). However I will recheck.
>>
>>It is UP machine (with SMP non-preemptible kernel). Stack trace does not 
>>look like that it was caused by some race.
> 
> 
> There is something severely broken... I reenabled
> ide: unexpected interrupt in ata_irq_request and to my surprise here
> we get one suprious interrupt for each request we do, on both
> channels - primary and secondary.
> 
> It looked:
> 
> udma_pci_init: sending read command to drive
> ata_irq_request: IRQ arrived, for us, calling handler
> ata_irq_request: handler returned 0
> ide: unexpected interrupt 1 15 handler=00000000
> callstack: ata_irq_request + 7e/234, handle_IRQ_event + 29/4c,
>            do_IRQ + df/190, common_interrupt + 18/20, do_softirq + 50/ac,
>            do_IRQ + 179/190, common_interrupt + 18/20
> udma_pci_init: sending read command to drive
> ata_irq_request: IRQ arrived, for us, calling handler
> ata_irq_request: handler returned 0
> ide: unexpected interrupt 1 15 handler=00000000
> callstack: same as above
> udma_pci_init: sending read command to drive
> ata_irq_request: IRQ arrived, for us, calling handler
> ata_irq_request: handler returned 0
> udma_pci_init: sending read command to drive
> ata_irq_request: command immediately queued by do_ide_request
> ata_irq_request: IRQ arrived, for us, calling handler
> oops: ide_dma_intr: udmastatus=00, diskstatus=58
> 
> So we are getting one spurious interrupt for each UDMA request.
> Until we do not issue new command to the drive immediately, IRQ
> is silently ignored, and everybody is happy (?). But when we
> queue command immediately by call to do_ide_request in
> ata_irq_request, sooner or later spurious interrupt will
> arrive with wrong timming, and we'll think that command is
> done while it is still in progress.
> 
> I see same spurious interrupt problem on primary channel too,
> but somehow timming is different with UDMA100, and we always find
> command done instead of in progress when spurious interrupt happens.
> 
> Unfortunately ATA/ATAPIv7 says that single interrupt is triggered
> after command is done and all data transfered, and we do not play
> with select bit. But we play with nIEN bit of disk. Do you see
> any reason why this should cause spurious interrupt? (system is using
> XT-PIC, FYI)

What I actually try to do is to maintain the nIEN bit enabled the
times we don't do any transfer to the disk in question.
Precisely to prevent the disk from spewing IRQs at times
when it should not. And yes this bit is acting in a reversed manner.
But I'm sure you already know this.
You could of course try to make the ata_irq_enbale()
function a no-op and see whatever this is changing anything.

(Me: Scratching my head with a puzzled expression on the face...;-)


