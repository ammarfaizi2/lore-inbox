Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSCRSRb>; Mon, 18 Mar 2002 13:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSCRSRV>; Mon, 18 Mar 2002 13:17:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6917 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291169AbSCRSRL>;
	Mon, 18 Mar 2002 13:17:11 -0500
Message-ID: <3C962ED6.6090706@evision-ventures.com>
Date: Mon, 18 Mar 2002 19:15:50 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Console output from IDE lockup
In-Reply-To: <200203142315.PAA21531@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	I don't know if this is helpful, but I was able to extract the
> console output from a machine got an IDE hang.  I have not seen these
> messages previously, and they may have been output long before the IDE
> hang and be unrelated.  However, they are the last thing in the console
> log:
> 
> hda: timeout waiting for DMA
> hda: ide_dma_timeout: Lets do it again!stat = 0x58, dma_stat = 0x20
> hda: DMA disabled
> hda: ide_set_handler: handler not null; old=d8802258, new=d88008ac
> bug: kernel timer added twice at d8801f51.


Ah this actually gives some insight!

It is showing us, that the problem is occurring in the
case where the drivers fall back from DMA mode to PIO
transfer mode.

Apparently it seems that in this case we don't recover properly
from the previous transfer.

But, since you mention that the lockup is very infrequent
and there are quite a lot of places in the IDE code, where
timeout values are directly compared by subtracting from
jiffies it could be that we have here just a simple case
of 32 bit timer overflow. (Assuming that you have a *very*
highly clocked CPU.)

Since unfortunately the code path involved here depends
upon the particular chipset you use:
ll {} \;
./include/linux/ide.h:          ide_dma_lostirq,                        ide_dma_
timeout
./drivers/ide/icside.c: case ide_dma_timeout:
./drivers/ide/hpt366.c:         case ide_dma_timeout:
./drivers/ide/hpt366.c:                 func = ide_dma_timeout;
./drivers/ide/hpt366.c:         case ide_dma_timeout:
./drivers/ide/ide-dma.c:                case ide_dma_timeout:
./drivers/ide/pdc202xx.c:               case ide_dma_timeout:
./drivers/ide/aec62xx.c:                case ide_dma_timeout:
./drivers/ide/ide.c:void ide_dma_timeout_retry(ide_drive_t *drive)
./drivers/ide/ide.c:    hwif->dmaproc(ide_dma_timeout, drive);
./drivers/ide/ide.c:                                    ide_dma_timeout_retry(dr
ive);
./drivers/ide/ide-features.c:           case ide_dma_timeout:           return("
ide_dma_timeout");
./drivers/ide/ide-pmac.c:       case ide_dma_timeout:
[root@kozaczek linux]#

Could you have a look at the corresponding ide_dma_timeout
or ide_dma_lostirq usage places by just comparing whatever
there are some omissions in comparision of the different
implementations found there? (Four eyes may see more than
just two...) Thank you in advance.

I will just try to replace all the subtractions done
there by proper additive values at the places where the
ticks matter. This has to be done anywaym, since the macros
time_before and time_after are for serious reasons
out there ;-).




