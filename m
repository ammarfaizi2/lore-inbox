Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318281AbSG3O1P>; Tue, 30 Jul 2002 10:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318285AbSG3O1P>; Tue, 30 Jul 2002 10:27:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56337 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318281AbSG3O1O>; Tue, 30 Jul 2002 10:27:14 -0400
Message-ID: <3D46A1D9.3060901@evision.ag>
Date: Tue, 30 Jul 2002 16:25:29 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <963E6E41A8@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Hi Martin,
>   here at work I have i845 chipset, with one UDMA100 disk connected
> to the primary channel, and one UDMA100 disk and one CD-DVD on the
> secondary one. CD-DVD driver is not loaded at all, all three devices
> are configured for UDMA by kernel. 
> 
>   Today 2.5.29-cset511 died when rebooting to 2.5.29-cset536 (rmap.c:212 
> BUG(), but I believe that it is fixed by Paulus's page->index patch 
> (cset520)) and after reboot I'm not able to fsck /dev/hdc1. It dies with
> 
> hdc: ide_dma_intr: status=0x58 [ drive ready,seek complete,data request]
> hdc: request error, nr. 1

That is usually indicating that some operation was started before
some other really finished.

> and fsck is D, and channel is stopped :-( First something easy: I think 
> that we should use ", " as a separator in dump_bits, and if there is
> space after opening "[", there should be also space before closing "]".

Yeep. No problem.
>
> Second problem is that read operation which ends with
> "drive ready, seek complete, data request" (why it happened in first
> place?) will just read one sector from drive (it was DMA transfer,
> so drive->mult_count == 0), and then it returns from ata_error
> with ATA_OP_CONTINUES. But what continues? Drive told us that
> current operation is done, and no new operation was started, so
> there is very low chance that some IRQ will ever come, and timer was
> just removed by ata_irq_request(), so channel will never awake.

What should continue is the retry of the operation, since otherwise
it will be abondoned in do_ide_request(). However I will recheck.

> And third, why this happens at all? When I instrumented ide_dma_intr 
> with printk, udma_stop() returns zero: it means that everything went 
> fine, UDMA engine asked for interrupt, no error, UDMA engine stopped. 
> Only reason I can invent is that drive did not clear DRQ bit yet, or 
> that we programmed UDMA engine with too few bytes to transfer. Either 
> of these explanations looks strange to me, as this does not explain
> why it happens only when both channels are in use simultaneously.
> 
> And last thing: problem does not happen when only one of channels is
> active, it is triggered only when both channels are active, and
> channel #1 is always one which dies. Channel #0 uses IRQ14, channel #1
> IRQ15, so there should be no sharing involved.

Hmm, the order of channels matters for the way the queues are feed.
I think we could expirence reentrancy problems. Or there
are some errors in ata_irq_handler() in dispatching the incomming
IRQs. It should be a good idea to add an IRQ number parameter to the
IRQ handler type, since this would allow to detect such situtations.

One check that could help would be to discover the drive to serive next, 
based on drive->queue in do_ide_request() instead of naively looking
through all drives in do_ide_request(). At least comparing it to the
queue parameter after selection would make sense.

Do you do unmasking of IRQs? Holding them a bit longer could have some
impact as well...

Thanks for the input, I will have to think through it a bit longer :-).

