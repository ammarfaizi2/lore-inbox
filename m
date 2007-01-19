Return-Path: <linux-kernel-owner+w=401wt.eu-S932845AbXASTHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbXASTHa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXASTHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:07:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:45758 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845AbXASTH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:07:29 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AEL7Ii7xRn/mX23eBEMNHfIOAKjnG5boJcmeflSWxolpNGPLfY1KvHOb5M3MvYzCTavmxWcUqoVBiKIlLE5HtV9zRTrx9Fg+caYyXuywYFxvYm9JXhJF6t+dXv8CkIelqahCAhYmaecc926yZql5YkCX/hEL8UEZWemXvt8eEpo=
Message-ID: <45B117D4.7050406@gmail.com>
Date: Fri, 19 Jan 2007 20:11:16 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003154.14846.87217.sendpatchset@localhost.localdomain>	 <45B0F12B.3000202@ru.mvista.com> <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com>
In-Reply-To: <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sergei Shtylyov wrote:
> Hello.

Hi,

> Bartlomiej Zolnierkiewicz wrote:
>> [PATCH] ide: disable DMA in ->ide_dma_check for "no IORDY" case
> 
>    I've looked thru the code, and found more issues with the PIO fallback
> there. Will try to cook up patches for at least some drivers...

Great, if possible please base them on top of the IDE tree...

>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>> Index: b/drivers/ide/pci/aec62xx.c
>> ===================================================================
>> --- a/drivers/ide/pci/aec62xx.c
>> +++ b/drivers/ide/pci/aec62xx.c
>> @@ -214,12 +214,10 @@ static int aec62xx_config_drive_xfer_rat
>>       if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>               return hwif->ide_dma_on(drive);
>>
>> -     if (ide_use_fast_pio(drive)) {
>> +     if (ide_use_fast_pio(drive))
>>               aec62xx_tune_drive(drive, 5);
> 
>    This function looks like it's working (thouugh having the wrong limit of
> PIO5 on auto-tuning) but is unnecassary complex.

Yes, it seems that there are actually two bugs here:
* the maximum allowed PIO mode should be PIO4 not PIO5
* for auto-tuning ("pio" == 255) it incorrectly sets PIO0
  (255 fails to the default case in the switch statement)

>    Heh, the driver is certainly a rip-off form hpt366.c. What a doubtful
> example they have chosen... :-)

hehe

>> Index: b/drivers/ide/pci/atiixp.c
>> ===================================================================
>> --- a/drivers/ide/pci/atiixp.c
>> +++ b/drivers/ide/pci/atiixp.c
>> @@ -264,10 +264,9 @@ static int atiixp_dma_check(ide_drive_t
>>               tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
>>               speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
> 
>    It's simply stupid to convert PIO mode to PIO mode. The whole idea is
> doubtful as well..

It is side-effect of basing atiixp on piix driver.  Fixing it will allow PIO1
to be used (good) because atiixp_dma_2_pio() always downgrades PIO1 to PIO0
(leftover from piix - on Intel chipsets same timings are used for PIO0/1).

>>               hwif->speedproc(drive, speed);
> 
>    Well, well, the tuneproc() method can't ahndle auto-tunuing here
> (255)...

Yes, definitely a bug.

> And it also doesn't set up drive's own speed. The code seem to be another
> rip-off from piix.c, repeating all its mistakes... :-)

:)

>> Index: b/drivers/ide/pci/cmd64x.c
>> ===================================================================
>> --- a/drivers/ide/pci/cmd64x.c
>> +++ b/drivers/ide/pci/cmd64x.c
>> @@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
>>       if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>               return hwif->ide_dma_on(drive);
>>
>> -     if (ide_use_fast_pio(drive)) {
>> +     if (ide_use_fast_pio(drive))
>>               config_chipset_for_pio(drive, 1);
> 
>    This function will always set PIO mode 4. Mess.

Yep.

>> Index: b/drivers/ide/pci/cs5535.c
>> ===================================================================
>> --- a/drivers/ide/pci/cs5535.c
>> +++ b/drivers/ide/pci/cs5535.c
>> @@ -206,10 +206,9 @@ static int cs5535_dma_check(ide_drive_t
>>       if (ide_use_fast_pio(drive)) {
>>               speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
>>               cs5535_set_drive(drive, speed);
> 
>    Could be folded into tuneproc() method call.

Using ->tuneproc() will also set the PIO mode on the drive
which is not done currently... 

>> Index: b/drivers/ide/pci/pdc202xx_old.c
>> ===================================================================
>> --- a/drivers/ide/pci/pdc202xx_old.c
>> +++ b/drivers/ide/pci/pdc202xx_old.c
>> @@ -339,12 +339,10 @@ static int pdc202xx_config_drive_xfer_ra
>>       if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>               return hwif->ide_dma_on(drive);
>>
>> -     if (ide_use_fast_pio(drive)) {
>> +     if (ide_use_fast_pio(drive))
>>               hwif->tuneproc(drive, 5);
> 
>    This driver's tuneproc() method always auto-tunes here instead of
> setting
> what it's told too -- I'll send a patch...

Please do...

>> Index: b/drivers/ide/pci/siimage.c
>> ===================================================================
>> --- a/drivers/ide/pci/siimage.c
>> +++ b/drivers/ide/pci/siimage.c
>> @@ -420,12 +420,10 @@ static int siimage_config_drive_for_dma
>>       if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>               return hwif->ide_dma_on(drive);
>>
>> -     if (ide_use_fast_pio(drive)) {
>> +     if (ide_use_fast_pio(drive))
>>               config_chipset_for_pio(drive, 1);
> 
>    This function will also always set PIO mode 4. More mess.

Yep, same bug as in cmd64x.c.

>> Index: b/drivers/ide/pci/sis5513.c
>> ===================================================================
>> --- a/drivers/ide/pci/sis5513.c
>> +++ b/drivers/ide/pci/sis5513.c
>> @@ -678,12 +678,10 @@ static int sis5513_config_xfer_rate(ide_
>>       if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>               return hwif->ide_dma_on(drive);
>>
>> -     if (ide_use_fast_pio(drive)) {
>> +     if (ide_use_fast_pio(drive))
>>               sis5513_tune_drive(drive, 5);
> 
>     Ugh, PIO fallback effectively always tries to set mode 4 here (thanks
> it's not 5). Mess.

Yep, but it seems to be even more complicated since config_art_rwp_pio()
is a mess^2 - chipset is programmed to the best PIO mode while the
device is set to PIO4... *sigh*...

Thanks,
Bart

