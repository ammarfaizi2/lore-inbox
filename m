Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUL2CwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUL2CwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbUL2CwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:52:20 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:47365 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261314AbUL2CwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:52:16 -0500
Date: Wed, 29 Dec 2004 03:52:12 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.10 - Still mishandles volumes without geometry data
Message-ID: <20041229025212.GA2818@pclin040.win.tue.nl>
References: <1104155840.20898.3.camel@localhost.localdomain> <58cb370e041228124878cb6e2a@mail.gmail.com> <1104271702.26131.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104271702.26131.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 10:08:23PM +0000, Alan Cox wrote:
> Ok how about this revision which also silences the boot time CHS data as
> Bartlomiej suggested.
> 
> --- linux.vanilla-2.6.10/drivers/ide/ide-disk.c	2004-12-25 21:15:34.000000000 +0000
> +++ linux-2.6.10/drivers/ide/ide-disk.c	2004-12-28 23:07:13.195925352 +0000
> @@ -84,6 +84,10 @@
>  {
>  	unsigned long lba_sects, chs_sects, head, tail;
>  
> +	/* No non-LBA info .. so valid! */
> +	if (id->cyls == 0)
> +		return 1;
> +		
>  	/*
>  	 * The ATA spec tells large drives to return
>  	 * C/H/S = 16383/16/63 independent of their size.

Reasonable in case this actually occurs. Do you have examples?

> @@ -201,7 +205,8 @@
>  		head  = track % drive->head;
>  		cyl   = track / drive->head;
>  
> -		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
> +		if(cyl)
> +			pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
>  
>  		hwif->OUTB(0x00, IDE_FEATURE_REG);
>  		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);

Unreasonable. This part must be a misunderstanding.
The cyl here is not the number of cylinders of a disk,
it is the cylinder affected by I/O and may well be zero.

> @@ -1239,8 +1257,9 @@
>  	if (id->buf_size)
>  		printk (" w/%dKiB Cache", id->buf_size/2);
>  
> -	printk(", CHS=%d/%d/%d", 
> -	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
> +	if(drive->bios_cyl)
> +		printk(", CHS=%d/%d/%d", 
> +			drive->bios_cyl, drive->bios_head, drive->bios_sect);
>  	if (drive->using_dma)
>  		ide_dma_verbose(drive);
>  	printk("\n");

Reasonable. (But s/if(/if (/ .)
On the other hand, I like the "CHS=0/0/0" - it makes very clear what is wrong
in case lilo or so has geometry problems.

Andries
