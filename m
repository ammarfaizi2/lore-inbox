Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSG3SQa>; Tue, 30 Jul 2002 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSG3SQa>; Tue, 30 Jul 2002 14:16:30 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:52494 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316210AbSG3SQ3>;
	Tue, 30 Jul 2002 14:16:29 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: dalecki@evision.ag
Date: Tue, 30 Jul 2002 20:19:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9A81BA09AB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> On 30 Jul 02 at 16:25, Marcin Dalecki wrote:
> > > Second problem is that read operation which ends with
> > > "drive ready, seek complete, data request" (why it happened in first
> > > place?) will just read one sector from drive (it was DMA transfer,
> > > so drive->mult_count == 0), and then it returns from ata_error
> > > with ATA_OP_CONTINUES. But what continues? Drive told us that
> > > current operation is done, and no new operation was started, so
> > > there is very low chance that some IRQ will ever come, and timer was
> > > just removed by ata_irq_request(), so channel will never awake.
> > 
> > What should continue is the retry of the operation, since otherwise
> > it will be abondoned in do_ide_request(). However I will recheck.
> 
> It is UP machine (with SMP non-preemptible kernel). Stack trace does not 
> look like that it was caused by some race.

There is something severely broken... I reenabled
ide: unexpected interrupt in ata_irq_request and to my surprise here
we get one suprious interrupt for each request we do, on both
channels - primary and secondary.

It looked:

udma_pci_init: sending read command to drive
ata_irq_request: IRQ arrived, for us, calling handler
ata_irq_request: handler returned 0
ide: unexpected interrupt 1 15 handler=00000000
callstack: ata_irq_request + 7e/234, handle_IRQ_event + 29/4c,
           do_IRQ + df/190, common_interrupt + 18/20, do_softirq + 50/ac,
           do_IRQ + 179/190, common_interrupt + 18/20
udma_pci_init: sending read command to drive
ata_irq_request: IRQ arrived, for us, calling handler
ata_irq_request: handler returned 0
ide: unexpected interrupt 1 15 handler=00000000
callstack: same as above
udma_pci_init: sending read command to drive
ata_irq_request: IRQ arrived, for us, calling handler
ata_irq_request: handler returned 0
udma_pci_init: sending read command to drive
ata_irq_request: command immediately queued by do_ide_request
ata_irq_request: IRQ arrived, for us, calling handler
oops: ide_dma_intr: udmastatus=00, diskstatus=58

So we are getting one spurious interrupt for each UDMA request.
Until we do not issue new command to the drive immediately, IRQ
is silently ignored, and everybody is happy (?). But when we
queue command immediately by call to do_ide_request in
ata_irq_request, sooner or later spurious interrupt will
arrive with wrong timming, and we'll think that command is
done while it is still in progress.

I see same spurious interrupt problem on primary channel too,
but somehow timming is different with UDMA100, and we always find
command done instead of in progress when spurious interrupt happens.

Unfortunately ATA/ATAPIv7 says that single interrupt is triggered
after command is done and all data transfered, and we do not play
with select bit. But we play with nIEN bit of disk. Do you see
any reason why this should cause spurious interrupt? (system is using
XT-PIC, FYI)
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
