Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310731AbSCHIV0>; Fri, 8 Mar 2002 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310732AbSCHIVO>; Fri, 8 Mar 2002 03:21:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:50704 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310731AbSCHIVI>; Fri, 8 Mar 2002 03:21:08 -0500
Message-ID: <3C88742A.4090804@evision-ventures.com>
Date: Fri, 08 Mar 2002 09:19:54 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Hank Yang <hanky@promise.com.tw>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, Linus Chen <linusc@promise.com.tw>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <E16j9pb-0004dV-00@the-village.bc.nu> <010c01c1c64d$85550e90$59cca8c0@hank>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hank Yang wrote:
>>>    That's because the linux-kernel misunderstand the raid controller
>>>to IDE controller. If do so, The raid driver will be unstable when
>>>be loaded.
>>>    So we must to prevent the raio controller to be as IDE controller
>>>here.
>>>
>>The ataraid driver in the standard kernel requires the IDE drive is seen
>>by the ide layer otherwise ataraid cannot bind it into a raid module
>>
> 
> First, the IDE driver doesn't check the controller's class code is raid
> controller (0x0104) or other controller(0x0180). So If our raid controller
> (FastTrak series) be seen by IDE driver. It will snatch the same IRQ.
> It will cause our trouble.

Uhh oh, that's actually interresting and you are right on this point.
One should just add the functionality. If you dare to wait the weekend
it will happen in 2.5 ;-). Or of you care your self, then plase
have a look at the following code in 2.5.6-pre3 in ide-pci:

/*
  * Setup DMA transfers on a channel.
  */
static void __init setup_channel_dma(ide_hwif_t *hwif, struct pci_dev *dev,
                 ide_pci_device_t *d,
                 int port,
                 u8 class_rev,
                 int pciirq, ide_hwif_t **mate,
                 int autodma, unsigned short *pcicmd)
{
         unsigned long dma_base;

         if (d->flags & ATA_F_NOADMA)
                 autodma = 0;

         if (autodma)
                 hwif->autodma = 1;

         if (!((d->flags & ATA_F_DMA) || ((dev->class >> 8) == 
PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))))
                 return;

Would it be sufficient to just prevent the classes you mention to
bail out from initialization?

> It's pity that the linux kernel could agree this point also.

It can be fixed I think.

