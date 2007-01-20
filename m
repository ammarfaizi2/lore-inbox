Return-Path: <linux-kernel-owner+w=401wt.eu-S965383AbXATUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbXATUWM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbXATUWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:22:11 -0500
Received: from homer.mvista.com ([63.81.120.155]:23849 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965381AbXATUWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:22:09 -0500
Message-ID: <45B279EE.5080807@ru.mvista.com>
Date: Sat, 20 Jan 2007 23:22:06 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] ide: add ide_set_dma() helper
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003206.14846.59852.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003206.14846.59852.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again. :-)

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: add ide_set_dma() helper

> * add ide_set_dma() helper and make ide_hwif_t.ide_dma_check return
>   -1 when DMA needs to be disabled (== need to call ->ide_dma_off_quietly)
>    0 when DMA needs to be enabled  (== need to call ->ide_dma_on)
>    1 when DMA setting shouldn't be changed
> * fix IDE code to use ide_set_dma() instead if using ->ide_dma_check directly

    Here are a few comments related to the code being patched:

> Index: b/drivers/ide/pci/alim15x3.c
> ===================================================================
> --- a/drivers/ide/pci/alim15x3.c
> +++ b/drivers/ide/pci/alim15x3.c
> @@ -507,17 +507,15 @@ static int config_chipset_for_dma (ide_d
>   *
>   *	Configure a drive for DMA operation. If DMA is not possible we
>   *	drop the drive into PIO mode instead.
> - *
> - *	FIXME: exactly what are we trying to return here
>   */
> - 
> +
>  static int ali15x3_config_drive_for_dma(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
>  	struct hd_driveid *id	= drive->id;
>  
>  	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
> -		return hwif->ide_dma_off_quietly(drive);
> +		goto no_dma_set;

    Isn't it better to just return -1?

> @@ -552,9 +550,10 @@ try_dma_modes:
>  ata_pio:
>  		hwif->tuneproc(drive, 255);
>  no_dma_set:
> -		return hwif->ide_dma_off_quietly(drive);
> +		return -1;
>  	}
> -	return hwif->ide_dma_on(drive);
> +
> +	return 0;
>  }

    Ugh, this code looks like it's asking to be converted into calling 
ide_use_dma(). instead all of that...

> Index: b/drivers/ide/pci/cs5520.c
> ===================================================================
> --- a/drivers/ide/pci/cs5520.c
> +++ b/drivers/ide/pci/cs5520.c
> @@ -132,12 +132,11 @@ static void cs5520_tune_drive(ide_drive_
>  
>  static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif = HWIF(drive);
> -
>  	/* Tune the drive for PIO modes up to PIO 4 */	
>  	cs5520_tune_drive(drive, 4);

    Ugh. Why not ask drive? :-/

>  	/* Then tell the core to use DMA operations */
> -	return hwif->ide_dma_on(drive);
> +	return 0;

    That must be the famous VDMA thing... :-)
    I wonder if it *actually* works on HPT36x/37x which seem to have support 
for it...

> Index: b/drivers/ide/pci/jmicron.c
> ===================================================================
> --- a/drivers/ide/pci/jmicron.c
> +++ b/drivers/ide/pci/jmicron.c
> @@ -164,14 +164,12 @@ static int config_chipset_for_dma (ide_d
>  
>  static int jmicron_config_drive_for_dma (ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif	= drive->hwif;
> +	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
> +		return 0;
>  
> -	if (ide_use_dma(drive)) {
> -		if (config_chipset_for_dma(drive))
> -			return hwif->ide_dma_on(drive);
> -	}
>  	config_jmicron_chipset_for_pio(drive, 1);

    The 2nd argument of that funtion is useless -- it basically does nothing 
if 0 is passed. Another case of mindless copy-paste. :-)

> Index: b/drivers/ide/pci/pdc202xx_old.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_old.c
> +++ b/drivers/ide/pci/pdc202xx_old.c
> @@ -332,17 +332,15 @@ chipset_is_set:
>  
>  static int pdc202xx_config_drive_xfer_rate (ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif	= HWIF(drive);
> -
>  	drive->init_speed = 0;
>  
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
> -		return hwif->ide_dma_on(drive);
> +		return 0;
>  
>  	if (ide_use_fast_pio(drive))
> -		hwif->tuneproc(drive, 5);
> +		config_chipset_for_pio(drive, 5);

    That part is obsoleted by my recent fix...

> Index: b/drivers/ide/pci/piix.c
> ===================================================================
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
> @@ -386,20 +386,18 @@ static int piix_config_drive_for_dma (id
>   
>  static int piix_config_drive_xfer_rate (ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif	= HWIF(drive);
> -
>  	drive->init_speed = 0;
>  
>  	if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
> -		return hwif->ide_dma_on(drive);
> +		return 0;
>  
>  	if (ide_use_fast_pio(drive)) {
>  		/* Find best PIO mode. */
> -		(void) hwif->speedproc(drive, XFER_PIO_0 +
> -				       ide_get_best_pio_mode(drive, 255, 4, NULL));
> +		u8 pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
> +		(void)piix_tune_chipset(drive, XFER_PIO_0 + pio);
>  	}

    Will try to fix the tuneproc() nuisance RSN. :-)

> Index: b/drivers/ide/pci/serverworks.c
> ===================================================================
> --- a/drivers/ide/pci/serverworks.c
> +++ b/drivers/ide/pci/serverworks.c
> @@ -315,17 +315,15 @@ static int config_chipset_for_dma (ide_d
>  
>  static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif	= HWIF(drive);
> -
>  	drive->init_speed = 0;
>  
>  	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
> -		return hwif->ide_dma_on(drive);
> +		return 0;
>  
>  	if (ide_use_fast_pio(drive))
>  		config_chipset_for_pio(drive);

    I have no idea why that function is so huge in this driver, i.e. why all 
this code is not in svwks_tune_chipset()...

> -	return hwif->ide_dma_off_quietly(drive);
> +	return -1;
>  }
>  
>  static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
> Index: b/drivers/ide/pci/sl82c105.c
> ===================================================================
> --- a/drivers/ide/pci/sl82c105.c
> +++ b/drivers/ide/pci/sl82c105.c
> @@ -161,14 +161,14 @@ static int sl82c105_check_drive (ide_dri
>  		if (id->field_valid & 2) {
>  			if ((id->dma_mword & hwif->mwdma_mask) ||
>  			    (id->dma_1word & hwif->swdma_mask))

    Ugh. This driver claims the full MW/SW DMA support while actually only 
supports MWDMA2.

> -				return hwif->ide_dma_on(drive);
> +				return 0;
>  		}
>  
>  		if (__ide_dma_good_drive(drive))
> -			return hwif->ide_dma_on(drive);
> +			return 0;
>  	} while (0);

    This also asks to be converted into ide_use_dma() call. The patch is 
cooking...

> -	return hwif->ide_dma_off_quietly(drive);
> +	return -1;
>  }
>  
>  /*
> Index: b/drivers/ide/pci/slc90e66.c
> ===================================================================
> --- a/drivers/ide/pci/slc90e66.c
> +++ b/drivers/ide/pci/slc90e66.c
> @@ -179,19 +179,17 @@ static int slc90e66_config_drive_for_dma
>  
>  static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif	= HWIF(drive);
> -
>  	drive->init_speed = 0;
>  
>  	if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
> -		return hwif->ide_dma_on(drive);
> +		return 0;
>  
>  	if (ide_use_fast_pio(drive)) {
> -		(void) hwif->speedproc(drive, XFER_PIO_0 +
> -				       ide_get_best_pio_mode(drive, 255, 4, NULL));
> +		u8 pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
> +		(void)slc90e66_tune_chipset(drive, XFER_PIO_0 + pio);
>  	}

    The same promise about tuneproc() in this driver... :-)

MBR, Sergei
