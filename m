Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318682AbSHAJjo>; Thu, 1 Aug 2002 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318684AbSHAJjo>; Thu, 1 Aug 2002 05:39:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9732 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S318682AbSHAJjl>;
	Thu, 1 Aug 2002 05:39:41 -0400
Message-ID: <3D48420F.5050407@evision.ag>
Date: Wed, 31 Jul 2002 22:01:19 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <9B9F331783@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> I wrote:
> 
>>Unfortunately ATA/ATAPIv7 says that single interrupt is triggered
>>after command is done and all data transfered, and we do not play
>>with select bit. But we play with nIEN bit of disk. Do you see
>>any reason why this should cause spurious interrupt? (system is using
>>XT-PIC, FYI)
> 
> 
> OK. As I am using only one device on each channel, I commented
> out ata_irq_enable(drive, 1) in ide-disk.c when issuing command,
> and removed disabling irq in ide_do_request in ide.c when we
> do not issue command to the drive, and spurious interrupts disappeared.
> So now I'm getting only half of IRQs for channel 0, and system still
> works as before ;-)

Well OK this was my next idea, but apparently you already did the
experient on your own. Thanks for the result. I'm still scratching my
head and I have already observed this before myself.
It's always funny to see what happens when one stops a driver
from deliberately disabling IRQs for eons of jiffies :-).

> Unfortunately, problem is still here: when kernel was in idedisk_do_request
> performed on channel 0, IRQ for channel 1 arrived, and this irq found 
> channel 1 DMA engine ready, but drive had DRQ set... oops. Shortly after 
> that IRQ for channel 1 arrived again, but as it was unexpected, nothing 
> happened. 
> 
> I hope that i845 is not simplex device, but first (unexpected) IRQ arrived 
> just when channel 0 code wrote new value to its IDE_SELECT_REG register. 
> Now I even disconnected DVD drive, so it is simple two masters, two
> channels configuration, but it still happens.

One idea and one experiment I was already thinking about is
to change do_ide_request to actually *not* select delibreately which 
device do handle. (The big for loop found there...)
One can instead search for a device on the channel which is matching
the queue for which do_ide_request() was called.

for (unit = 0; unit < MAX_DEVICES; ++unit) {
   ....
   if (tmp->queue == q) {
         drive = tmp;
	break;
   }
}
if (!drive)
   BUG();

Just please forget temporarly that there is a mechanism for "sleeping".
It is bogous anyway (doesn give time back to anybody) and the only
consumer of it is ide-cd (easly removed there) and ide-tape.c (don't 
care the driver was never usable in 2.5.xx)

> And as always, something else: ata_error does:
> 
> OUT_BYTE(WIN_NOP, ch->ports[IDE_CONTROL_OFFSET])
> 
> I'd say that it should use 0x00 instead of WIN_NOP, and also tha
> comment above OUT_BYTE(0x04, ch->ports[IDE_CONTROL_OFFSET]) is bogus.
> Command register is IDE_COMMAND, not IDE_CONTROL ;-)

Yes I know already about this I will remove the comment.
(Must have forgotten about it.)


