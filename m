Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSG3TXQ>; Tue, 30 Jul 2002 15:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSG3TXQ>; Tue, 30 Jul 2002 15:23:16 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:22287 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315923AbSG3TXP>;
	Tue, 30 Jul 2002 15:23:15 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: dalecki@evision.ag
Date: Tue, 30 Jul 2002 21:26:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9B9F331783@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> 
> Unfortunately ATA/ATAPIv7 says that single interrupt is triggered
> after command is done and all data transfered, and we do not play
> with select bit. But we play with nIEN bit of disk. Do you see
> any reason why this should cause spurious interrupt? (system is using
> XT-PIC, FYI)

OK. As I am using only one device on each channel, I commented
out ata_irq_enable(drive, 1) in ide-disk.c when issuing command,
and removed disabling irq in ide_do_request in ide.c when we
do not issue command to the drive, and spurious interrupts disappeared.
So now I'm getting only half of IRQs for channel 0, and system still
works as before ;-)

Unfortunately, problem is still here: when kernel was in idedisk_do_request
performed on channel 0, IRQ for channel 1 arrived, and this irq found 
channel 1 DMA engine ready, but drive had DRQ set... oops. Shortly after 
that IRQ for channel 1 arrived again, but as it was unexpected, nothing 
happened. 

I hope that i845 is not simplex device, but first (unexpected) IRQ arrived 
just when channel 0 code wrote new value to its IDE_SELECT_REG register. 
Now I even disconnected DVD drive, so it is simple two masters, two
channels configuration, but it still happens.

And as always, something else: ata_error does:

OUT_BYTE(WIN_NOP, ch->ports[IDE_CONTROL_OFFSET])

I'd say that it should use 0x00 instead of WIN_NOP, and also that
comment above OUT_BYTE(0x04, ch->ports[IDE_CONTROL_OFFSET]) is bogus.
Command register is IDE_COMMAND, not IDE_CONTROL ;-)
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
