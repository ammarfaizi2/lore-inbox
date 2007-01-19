Return-Path: <linux-kernel-owner+w=401wt.eu-S932878AbXASTfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbXASTfr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbXASTfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:35:47 -0500
Received: from h155.mvista.com ([63.81.120.155]:18599 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932871AbXASTfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:35:46 -0500
Message-ID: <45B11D8D.8070105@ru.mvista.com>
Date: Fri, 19 Jan 2007 22:35:41 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003154.14846.87217.sendpatchset@localhost.localdomain>	 <45B0F12B.3000202@ru.mvista.com> <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com> <45B117D4.7050406@gmail.com>
In-Reply-To: <45B117D4.7050406@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>[PATCH] ide: disable DMA in ->ide_dma_check for "no IORDY" case

>>   I've looked thru the code, and found more issues with the PIO fallback
>>there. Will try to cook up patches for at least some drivers...

> Great, if possible please base them on top of the IDE tree...

    Erm, I had doubts about it (having in mind that all that code is more of a 
cleanups than fixes). Maybe it'd be a good idea to separate the fix and 
cleanup series somehow...

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>>Index: b/drivers/ide/pci/aec62xx.c
>>>===================================================================
>>>--- a/drivers/ide/pci/aec62xx.c
>>>+++ b/drivers/ide/pci/aec62xx.c
>>>@@ -214,12 +214,10 @@ static int aec62xx_config_drive_xfer_rat
>>>      if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>              return hwif->ide_dma_on(drive);
>>>
>>>-     if (ide_use_fast_pio(drive)) {
>>>+     if (ide_use_fast_pio(drive))
>>>              aec62xx_tune_drive(drive, 5);
>>
>>   This function looks like it's working (thouugh having the wrong limit of
>>PIO5 on auto-tuning) but is unnecassary complex.

> Yes, it seems that there are actually two bugs here:
> * the maximum allowed PIO mode should be PIO4 not PIO5
> * for auto-tuning ("pio" == 255) it incorrectly sets PIO0
>   (255 fails to the default case in the switch statement)

    Yeah, you if you pass 255, it won't work (so, drive->autotune must be 
broken). But the driver itself have the wrong idea of 5 meaning auto-tune, so 
fallback should still work.

>>   Heh, the driver is certainly a rip-off form hpt366.c. What a doubtful
>>example they have chosen... :-)

> hehe

    The driver's authorship explains it all. :-)

>>>Index: b/drivers/ide/pci/atiixp.c
>>>===================================================================
>>>--- a/drivers/ide/pci/atiixp.c
>>>+++ b/drivers/ide/pci/atiixp.c
>>>@@ -264,10 +264,9 @@ static int atiixp_dma_check(ide_drive_t
>>>              tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
>>>              speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;

>>   It's simply stupid to convert PIO mode to PIO mode. The whole idea is
>>doubtful as well..

> It is side-effect of basing atiixp on piix driver.  Fixing it will allow PIO1
> to be used (good) because atiixp_dma_2_pio() always downgrades PIO1 to PIO0
> (leftover from piix - on Intel chipsets same timings are used for PIO0/1).

>>>              hwif->speedproc(drive, speed);

>>   Well, well, the tuneproc() method can't ahndle auto-tunuing here
>>(255)...

> Yes, definitely a bug.

    Ugh... don't expect patches form me soon though. My first priority is the 
drivers that we support here...

>>And it also doesn't set up drive's own speed. The code seem to be another
>>rip-off from piix.c, repeating all its mistakes... :-)

> :)

>>>Index: b/drivers/ide/pci/cmd64x.c
>>>===================================================================
>>>--- a/drivers/ide/pci/cmd64x.c
>>>+++ b/drivers/ide/pci/cmd64x.c
>>>@@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
>>>      if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>              return hwif->ide_dma_on(drive);
>>>
>>>-     if (ide_use_fast_pio(drive)) {
>>>+     if (ide_use_fast_pio(drive))
>>>              config_chipset_for_pio(drive, 1);

>>   This function will always set PIO mode 4. Mess.

> Yep.

    I'm going to send the patch for both this and siimage.c...

>>>Index: b/drivers/ide/pci/cs5535.c
>>>===================================================================
>>>--- a/drivers/ide/pci/cs5535.c
>>>+++ b/drivers/ide/pci/cs5535.c
>>>@@ -206,10 +206,9 @@ static int cs5535_dma_check(ide_drive_t
>>>      if (ide_use_fast_pio(drive)) {
>>>              speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
>>>              cs5535_set_drive(drive, speed);

>>   Could be folded into tuneproc() method call.

> Using ->tuneproc() will also set the PIO mode on the drive
> which is not done currently... 

    Hm, ide_config_drive_speed() is called by both tuneproc() method and 
cs5535_set_drive(), so I saw no issue there...

>>>Index: b/drivers/ide/pci/sis5513.c
>>>===================================================================
>>>--- a/drivers/ide/pci/sis5513.c
>>>+++ b/drivers/ide/pci/sis5513.c
>>>@@ -678,12 +678,10 @@ static int sis5513_config_xfer_rate(ide_
>>>      if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>              return hwif->ide_dma_on(drive);

>>>-     if (ide_use_fast_pio(drive)) {
>>>+     if (ide_use_fast_pio(drive))
>>>              sis5513_tune_drive(drive, 5);

>>    Ugh, PIO fallback effectively always tries to set mode 4 here (thanks
>>it's not 5). Mess.

> Yep, but it seems to be even more complicated since config_art_rwp_pio()
> is a mess^2 - chipset is programmed to the best PIO mode while the
> device is set to PIO4... *sigh*...

    Sorry, this one is low prio for me... :-)

> Thanks,
> Bart

MBR, Sergei
