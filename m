Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWFVQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWFVQuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFVQuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:50:54 -0400
Received: from mx27.mail.ru ([194.67.23.63]:1130 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1751485AbWFVQux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:50:53 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver patch for 2.6.17
Date: Thu, 22 Jun 2006 20:50:33 +0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <1150740947.2871.42.camel@localhost.localdomain> <e79a9e$2kt$1@sea.gmane.org> <1150925002.15275.128.camel@localhost.localdomain>
In-Reply-To: <1150925002.15275.128.camel@localhost.localdomain>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606222050.34248.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 22 June 2006 01:23, Alan Cox wrote:
> Ar Maw, 2006-06-20 am 21:12 +0400, ysgrifennodd Andrey Borzenkov:
> > Running vanilla 2.6.17 + ide1 patch on ALi M5229 does not find CD-ROM.
> > Notice "ata2: command 0xa0 timeout" below.
>
> Not sure immediately but does the following help
>

Not really. AFAIK lowest nibble bit has meaning only in DMA mode anyway.

Anything else I could try to help pinpoint the problem?

> --- ../libata-devo/drivers/scsi/pata_ali.c	2006-06-20 11:50:15.000000000
> +0100 +++ drivers/scsi/pata_ali.c	2006-06-21 21:42:27.458542280 +0100
> @@ -181,11 +181,12 @@
>  	u8 fifo;
>  	int shift = 4 * adev->devno;
>
> -	/* Bits 3:2 (7:6 for slave) control the PIO. 00 is off 01
> -	   is on. The FIFO must not be used for ATAPI. We preserve
> -	   BIOS set thresholds */
> +	/* ATA - FIFO on set nibble to 0x05, ATAPI - FIFO off, set nibble to
> +	   0x00. Not all the docs agree but the behaviour we now use is the
> +	   one stated in the BIOS Programming Guide */
> +
>  	pci_read_config_byte(pdev, pio_fifo, &fifo);
> -	fifo &= ~(0x0C << shift);
> +	fifo &= ~(0x0F << shift);
>  	if (on)
>  		fifo |= (on << shift);
>  	pci_write_config_byte(pdev, pio_fifo, fifo);
> @@ -261,10 +262,10 @@
>
>  	/* PIO FIFO is only permitted on ATA disk */
>  	if (adev->class != ATA_DEV_ATA)
> -		ali_fifo_control(ap, adev, 0);
> +		ali_fifo_control(ap, adev, 0x00);
>  	ali_program_modes(ap, adev, &t, 0);
>  	if (adev->class == ATA_DEV_ATA)
> -		ali_fifo_control(ap, adev, 0x04);
> +		ali_fifo_control(ap, adev, 0x05);
>
>  }
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEmspZR6LMutpd94wRApEgAJ4q7AQM09lZ/uTnSPJIM296LYnF9QCgp63W
5lygD8TmjYh+1QwOGTWbQkg=
=SDOQ
-----END PGP SIGNATURE-----
