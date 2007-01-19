Return-Path: <linux-kernel-owner+w=401wt.eu-S932549AbXASQ0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbXASQ0X (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXASQ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:26:23 -0500
Received: from homer.mvista.com ([63.81.120.155]:17672 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932549AbXASQ0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:26:22 -0500
Message-ID: <45B0F12B.3000202@ru.mvista.com>
Date: Fri, 19 Jan 2007 19:26:19 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003154.14846.87217.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003154.14846.87217.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: disable DMA in ->ide_dma_check for "no IORDY" case

    I've looked thru the code, and found more issues with the PIO fallback 
there. Will try to cook up patches for at least some drivers...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/pci/aec62xx.c
> ===================================================================
> --- a/drivers/ide/pci/aec62xx.c
> +++ b/drivers/ide/pci/aec62xx.c
> @@ -214,12 +214,10 @@ static int aec62xx_config_drive_xfer_rat
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>  		return hwif->ide_dma_on(drive);
>  
> -	if (ide_use_fast_pio(drive)) {
> +	if (ide_use_fast_pio(drive))
>  		aec62xx_tune_drive(drive, 5);

    This function looks like it's working (thouugh having the wrong limit of 
PIO5 on auto-tuning) but is unnecassary complex.
    Heh, the driver is certainly a rip-off form hpt366.c. What a doubtful 
example they have chosen... :-)

> Index: b/drivers/ide/pci/atiixp.c
> ===================================================================
> --- a/drivers/ide/pci/atiixp.c
> +++ b/drivers/ide/pci/atiixp.c
> @@ -264,10 +264,9 @@ static int atiixp_dma_check(ide_drive_t 
>  		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
>  		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;

    It's simply stupid to convert PIO mode to PIO mode. The whole idea is 
doubtful as well..

>  		hwif->speedproc(drive, speed);

    Well, well, the tuneproc() method can't ahndle auto-tunuing here (255)...
And it also doesn't set up drive's own speed. The code seem to be another 
rip-off from piix.c, repeating all its mistakes... :-)

> Index: b/drivers/ide/pci/cmd64x.c
> ===================================================================
> --- a/drivers/ide/pci/cmd64x.c
> +++ b/drivers/ide/pci/cmd64x.c
> @@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>  		return hwif->ide_dma_on(drive);
>  
> -	if (ide_use_fast_pio(drive)) {
> +	if (ide_use_fast_pio(drive))
>  		config_chipset_for_pio(drive, 1);

    This function will always set PIO mode 4. Mess.

> Index: b/drivers/ide/pci/cs5535.c
> ===================================================================
> --- a/drivers/ide/pci/cs5535.c
> +++ b/drivers/ide/pci/cs5535.c
> @@ -206,10 +206,9 @@ static int cs5535_dma_check(ide_drive_t 
>  	if (ide_use_fast_pio(drive)) {
>  		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
>  		cs5535_set_drive(drive, speed);

    Could be folded into tuneproc() method call.

> Index: b/drivers/ide/pci/pdc202xx_old.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_old.c
> +++ b/drivers/ide/pci/pdc202xx_old.c
> @@ -339,12 +339,10 @@ static int pdc202xx_config_drive_xfer_ra
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>  		return hwif->ide_dma_on(drive);
>  
> -	if (ide_use_fast_pio(drive)) {
> +	if (ide_use_fast_pio(drive))
>  		hwif->tuneproc(drive, 5);

    This driver's tuneproc() method always auto-tunes here instead of setting 
what it's told too -- I'll send a patch...

> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
> @@ -420,12 +420,10 @@ static int siimage_config_drive_for_dma 
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>  		return hwif->ide_dma_on(drive);
>  
> -	if (ide_use_fast_pio(drive)) {
> +	if (ide_use_fast_pio(drive))
>  		config_chipset_for_pio(drive, 1);

    This function will also always set PIO mode 4. More mess.

> Index: b/drivers/ide/pci/sis5513.c
> ===================================================================
> --- a/drivers/ide/pci/sis5513.c
> +++ b/drivers/ide/pci/sis5513.c
> @@ -678,12 +678,10 @@ static int sis5513_config_xfer_rate(ide_
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>  		return hwif->ide_dma_on(drive);
>  
> -	if (ide_use_fast_pio(drive)) {
> +	if (ide_use_fast_pio(drive))
>  		sis5513_tune_drive(drive, 5);

     Ugh, PIO fallback effectively always tries to set mode 4 here (thanks 
it's not 5). Mess.

MBR, Sergei
