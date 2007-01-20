Return-Path: <linux-kernel-owner+w=401wt.eu-S965379AbXATU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbXATU4a (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965385AbXATU4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:56:30 -0500
Received: from h155.mvista.com ([63.81.120.155]:23960 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965379AbXATU43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:56:29 -0500
Message-ID: <45B281FA.9050107@ru.mvista.com>
Date: Sat, 20 Jan 2007 23:56:26 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] ide: make ide_hwif_t.ide_dma_{host_off,off_quietly}
 void
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003213.14846.1366.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003213.14846.1366.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again. :-)

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: make ide_hwif_t.ide_dma_{host_off,off_quietly} void

    Below are my nits on the patch itself, and the code it changes.

> Index: b/drivers/ide/pci/atiixp.c
> ===================================================================
> --- a/drivers/ide/pci/atiixp.c
> +++ b/drivers/ide/pci/atiixp.c
> @@ -121,7 +121,7 @@ static int atiixp_ide_dma_host_on(ide_dr
>  	return __ide_dma_host_on(drive);
>  }
>  
> -static int atiixp_ide_dma_host_off(ide_drive_t *drive)
> +static void atiixp_ide_dma_host_off(ide_drive_t *drive)
>  {
>  	struct pci_dev *dev = drive->hwif->pci_dev;
>  	unsigned long flags;
[...]
> @@ -306,7 +306,7 @@ static void __devinit init_hwif_atiixp(i
>  		hwif->udma_four = 0;
>  
>  	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
> -	hwif->ide_dma_host_off = &atiixp_ide_dma_host_off;
> +	hwif->dma_host_off = &atiixp_ide_dma_host_off;
>  	hwif->ide_dma_check = &atiixp_dma_check;
>  	if (!noautodma)
>  		hwif->autodma = 1;

    Would seem logical to get rid of ide_ in the function's name also...

> Index: b/drivers/ide/pci/sgiioc4.c
> ===================================================================
> --- a/drivers/ide/pci/sgiioc4.c
> +++ b/drivers/ide/pci/sgiioc4.c
> @@ -282,12 +282,11 @@ sgiioc4_ide_dma_on(ide_drive_t * drive)
>  	return HWIF(drive)->ide_dma_host_on(drive);
>  }
>  
> -static int
> -sgiioc4_ide_dma_off_quietly(ide_drive_t * drive)
> +static void sgiioc4_ide_dma_off_quietly(ide_drive_t *drive)
>  {
>  	drive->using_dma = 0;
>  
> -	return HWIF(drive)->ide_dma_host_off(drive);
> +	drive->hwif->dma_host_off(drive);
>  }
>  
>  static int sgiioc4_ide_dma_check(ide_drive_t *drive)
> @@ -317,12 +316,9 @@ sgiioc4_ide_dma_host_on(ide_drive_t * dr
>  	return 1;
>  }
>  
> -static int
> -sgiioc4_ide_dma_host_off(ide_drive_t * drive)
> +static void sgiioc4_ide_dma_host_off(ide_drive_t * drive)
>  {
>  	sgiioc4_clearirq(drive);
> -
> -	return 0;
>  }
>  
>  static int
> @@ -612,10 +608,10 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
>  	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
>  	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
>  	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
> -	hwif->ide_dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
> +	hwif->dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
>  	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
>  	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
> -	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
> +	hwif->dma_host_off = &sgiioc4_ide_dma_host_off;
>  	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
>  	hwif->ide_dma_timeout = &__ide_dma_timeout;

    The same here...

> Index: b/drivers/ide/pci/sl82c105.c
> ===================================================================
> --- a/drivers/ide/pci/sl82c105.c
> +++ b/drivers/ide/pci/sl82c105.c
> @@ -261,26 +261,24 @@ static int sl82c105_ide_dma_on (ide_driv
>  
>  	if (config_for_dma(drive)) {
>  		config_for_pio(drive, 4, 0, 0);

   Ugh, this forces PIO4 on fallback... and dma_on() doesn't select any modes 
in any other driver but this one. :-/

> -		return HWIF(drive)->ide_dma_off_quietly(drive);
> +		drive->hwif->dma_off_quietly(drive);
> +		return 0;
>  	}
>  	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
>  	return __ide_dma_on(drive);
>  }
>  
> -static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
> +static void sl82c105_ide_dma_off_quietly(ide_drive_t *drive)

    Also worth renaming...

>  {
>  	u8 speed = XFER_PIO_0;
> -	int rc;
> -	
> +
>  	DBG(("sl82c105_ide_dma_off_quietly(drive:%s)\n", drive->name));
>  
> -	rc = __ide_dma_off_quietly(drive);
> +	ide_dma_off_quietly(drive);
>  	if (drive->pio_speed)

    Should always be non-zero since explicitly initialized.

>  		speed = drive->pio_speed - XFER_PIO_0;
>  	config_for_pio(drive, speed, 0, 1);
>  	drive->current_speed = drive->pio_speed;

    dma_off() shouldn't be changing current_speed IMHO.

> -
> -	return rc;
>  }

    The patch to fix those two functions is also cooking...

MBR, Sergei

