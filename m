Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269479AbUI3UTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269479AbUI3UTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269475AbUI3UTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:19:06 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62914 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269470AbUI3US0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:18:26 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Date: Thu, 30 Sep 2004 22:18:47 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040930184535.GA31197@devserv.devel.redhat.com>
In-Reply-To: <20040930184535.GA31197@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409302218.48115.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 30 September 2004 20:45, Alan Cox wrote:
> This is a somewhat adjusted IT8212 driver that can work with the base
> 2.6.9rc3 IDE code (plus the tiny ide-probe patch). It uses a mix of tricks
> to avoid needing the core IDE support fixed (and in some cases to work around
> ide bugs/limits).
>
> Its still being tested so its for comment/testing not general use with a view
> to having a nice working driver for 2.6.9 without the core IDE fixups

Why you are doing this instead of including needed core changes in the
patch and describing them in the patch description is beyond my mind.

> + *  ** NOTE ** - this is the "special edition" driver for the older IDE
> + *  code. It contains some uglies and has some minor limitations not found
> + *  in the 'new ide' version. As the cleanups enter mainstream IDE so the
> + *  hacks internal to this driver will vanish.

The buzzed changes you avoid to include so hard are:
- add hook for hwif->ident_quirks (4 lines of code)
- add hook for hwif->raw_taskfile (8 lines of code)
- make ide-disk allow no geometry (3 lines of code)
- allow rmmod of it8212 module
  (much more LOC but no trick for it present)

First three changes are currently needed only for this driver
and I suggested merging them with it8212 patch last time.

Controller hotswap fixes are being discussed on lkml.

> +/**
> + *	it8212_fake_geometry	-	geometry armwave for raid
> + *	@drive: drive to fake it for
> + *
> + *	IDE permits a drive to report that it has no geometry. Our
> + *	ide disk layer can't handle this and "functions non-optimally"
> + *	We fake up a geometry here until the ide-disk code patches to
> + *	handle this properly are merged, at which point to goes away
> + *
> + *	This will always be called for LBA48 assumptions as raid volumes
> + *	are always LBA48 capable.
> + */
> + 
> +static void it8212_fake_geometry(ide_drive_t *drive)
> +{
> +	struct hd_driveid *id = drive->id;
> +	unsigned long long capacity = id->lba_capacity_2;
> +	unsigned int cap0 = capacity;	/* Trimmed to 32bit */
> +	unsigned int cyl;
> +	
> +	drive->bios_sect = 63;
> +	drive->bios_head = 255;
> +	
> +	if(cap0 != capacity)
> +		drive->bios_cyl = 65536;
> +	else
> +	{
> +		cyl = cap0 / (63 * 255);
> +		if(cyl > 65535)
> +			cyl = 65535;
> +		drive->bios_cyl = cyl;
> +	}
> +	/* We now have a "geometry" to feed back to the ide-disk code */
> +	id->cyls = drive->bios_cyl;
> +	id->heads = drive->bios_head;
> +	id->sectors = drive->bios_sect;
> +	id->cur_cyls = id->cyls;
> +	id->cur_heads = id->heads;
> +	id->cur_sectors = id->sectors;
> +}

trick to avoid 3 LOC change to ide-disk.c

> +	for(i = 0; i < 1; i++) {
> +		ide_drive_t *drive = &hwif->drives[i];
> +		struct hd_driveid *id;
> +		u16 *idbits;
> +		
> +		if(!drive->present)
> +			continue;
> +		id = drive->id;
> +		idbits = (u16 *)drive->id;
> +		

trick to avoid 4 LOC change to IDE core (hwif->ident_quirk hook)

> +			/* Non RAID volume. Fixups to stop the core code
> +			   crashing the driver. Go away when ->taskfile hook
> +			   is present */
> +			id->field_valid &= 1;
> +			id->queue_depth = 0;
> +			id->command_set_1 = 0;
> +			id->command_set_2 &= 0xC400;
> +			id->cfsse &= 0xC000;
> +			id->cfs_enable_1 = 0;
> +			id->cfs_enable_2 &= 0xC400;
> +			id->csf_default &= 0xC000;
> +			id->word127 = 0;
> +			id->dlf = 0;
> +			id->csfo = 0;
> +			id->cfa_power = 0;
> +			printk(KERN_INFO "%s: Performing identify fixups.\n", 
> +				drive->name);

trick to avoid 8 LOC change to IDE core (hwif->raw_taskfile hook)

And you say that you want real fixes to be included in the IDE core,
so they should be tested and reviewed, not the tricky workarounds!

*sigh*

