Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267810AbTAMTYv>; Mon, 13 Jan 2003 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267813AbTAMTYv>; Mon, 13 Jan 2003 14:24:51 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:21955 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267810AbTAMTYu>; Mon, 13 Jan 2003 14:24:50 -0500
Message-ID: <3E231444.6060209@google.com>
Date: Mon, 13 Jan 2003 11:32:20 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>	 <1042399796.525.215.camel@zion.wanadoo.fr>	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com> <1042484609.30837.31.camel@zion.wanadoo.fr> <3E23114E.8070400@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One thing we could do to solve this entire problem is wait for the 
interrupt to finish before sending the command to the drive in the first 
place.  Basically in ide_do_request we just have to change

        if (masked_irq && hwif->irq != masked_irq)
            disable_irq_nosync(hwif->irq);

to

    if (masked_irq && hwif->irq != masked_irq) {
        BUG();
    }

    if (!masked_irq) {
         disable_irq_sync(hwif->irq);
    }

But that means that we will only queue up new commands to a drive when 
its interrupt is not currently active.

       Ross


Ross Biro wrote:

> Benjamin Herrenschmidt wrote:
>
>>  
>>
>> Exactly. My problem right now is with enforcing that 400ns delay on
>> non-DMA path as with PCI write posting on one side, and other fancy bus
>> store queues etc... you are really not sure when your outb for the
>> command byte will really reach the disk.
>>
>> So the problem turns down to: is it safe for commands with no data
>> transfer and commands with a PIO data transfer to read back from
>> some other task file register right after issuing the command byte
>> (the select register looks like a good choice, better than status
>> for sure) and before doing the delay of 400ns ? On any sane bus
>> architecture, that read will make sure the previous write will
>> have reached the device or your IO accessors are broken...
>>
>>  
>>
> Ahh, good point.  My experience with the promise controller says that 
> it is not safe to talk to the drive after a start of a DMA command.  
> For non-dma commands, it should be safe but I believe it would be an 
> ATA spec violation to do so.  In particular from the ata-6 spec
>
> HPIOI0: INTRQ_Wait State: This state is entered when the host has 
> written a PIO data-in command to the device and nIEN is cleared to 
> zero, or at the completion of a DRQ data block transfer if all the 
> data for the command has not been transferred and nIEN is cleared to 
> zero. When in this state, the host shall wait for INTRQ to be asserted.
>
> So technically we are not allowed to talk to the drive, but must wait 
> for an irq.  The problem becomes how to tell if the irq is meant for 
> us. My guess is that most drives will not care if nIEN is set or not 
> at this point and we can use
>
> HPIOI1: Check_Status State: This state is entered when the host has 
> written a PIO data-in command to the device and nIEN is set to one, or 
> when INTRQ is asserted. When in this state, the host shall read the 
> device Status register. When entering this state from the HI4 state, 
> the host shall wait 400 ns before reading the Status register. When 
> entering this state from the HPIOI2 state, the host shall wait one PIO 
> transfer cycle time before reading the Status register. The wait may 
> be accomplished by reading the Alternate Status register and ignoring 
> the result.
>
> and read the alt status register to get a delay.
>
> This is technically a spec violation, but it's probably safe.  I'm 
> going to send an email to a couple of the drive manufacturers and see 
> what they think.
>
>    Ross
>



