Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTHXQst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbTHXQst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:48:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25297 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261240AbTHXQsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:48:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: andersen@codepoet.org
Subject: Re: [PATCH] 6/8 Backport recent 2.6 IDE updates to 2.4.x
Date: Sun, 24 Aug 2003 18:49:08 +0200
User-Agent: KMail/1.5
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030817061352.GG17621@codepoet.org>
In-Reply-To: <20030817061352.GG17621@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241849.08528.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch kills drive->cyl recalculation thus changes return value of
HDIO_GETGEO_BIG_RAW ioctl (it becomes useless for potential lusers).
Thats why I've removed this ioctl from 2.6.x before applying this change.
If Alan wants this ioctl to stay in 2.4.x (yep, ioctls shouldn't be removed
from stable kernels), drive->cyl recalculation should also stay.

--bartlomiej

On Sunday 17 of August 2003 08:13, Erik Andersen wrote:
> This patch further refines IDE geometry detection, and takes an
> easier path toward detecting when a drive happens to support
> things like lba48, making the code more readable and more
> consistant.
>
>  -Erik
>
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
>
>
> --- linux/drivers/ide/ide-disk.c.orig	2003-08-16 20:51:58.000000000 -0600
> +++ linux/drivers/ide/ide-disk.c	2003-08-16 20:56:49.000000000 -0600
> @@ -106,11 +106,6 @@
>  {
>  	unsigned long lba_sects, chs_sects, head, tail;
>
> -	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
> -		printk("48-bit Drive: %llu \n", id->lba_capacity_2);
> -		return 1;
> -	}
> -
>  	/*
>  	 * The ATA spec tells large drives to return
>  	 * C/H/S = 16383/16/63 independent of their size.
> @@ -1139,11 +1134,29 @@
>  	return n;
>  }
>
> +/*
> + * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
> + * so on non-buggy drives we need test only one.
> + * However, we should also check whether these fields are valid.
> + */
> +static inline int idedisk_supports_hpa(const struct hd_driveid *id)
> +{
> +	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
> +}
> +
> +/*
> + * The same here.
> + */
> +static inline int idedisk_supports_lba48(const struct hd_driveid *id)
> +{
> +	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
> +}
> +
>  static inline void idedisk_check_hpa_lba28(ide_drive_t *drive)
>  {
>  	unsigned long capacity, set_max;
>
> -	capacity = drive->id->lba_capacity;
> +	capacity = drive->capacity;
>  	set_max = idedisk_read_native_max_address(drive);
>
>  	if (set_max <= capacity)
> @@ -1158,7 +1171,7 @@
>  #ifdef CONFIG_IDEDISK_STROKE
>  	set_max = idedisk_set_max_address(drive, set_max);
>  	if (set_max) {
> -		drive->id->lba_capacity = set_max;
> +		drive->capacity = set_max;
>  		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
>  				 drive->name);
>  	}
> @@ -1169,7 +1182,7 @@
>  {
>  	unsigned long long capacity_2, set_max_ext;
>
> -	capacity_2 = drive->id->lba_capacity_2;
> +	capacity_2 = drive->capacity48;
>  	set_max_ext = idedisk_read_native_max_address_ext(drive);
>
>  	if (set_max_ext <= capacity_2)
> @@ -1184,7 +1197,8 @@
>  #ifdef CONFIG_IDEDISK_STROKE
>  	set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
>  	if (set_max_ext) {
> -		drive->id->lba_capacity_2 = set_max_ext;
> +		drive->capacity48 = set_max_ext;
> +		drive->capacity = (unsigned long) set_max_ext;
>  		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
>  				 drive->name);
>  	}
> @@ -1212,32 +1226,21 @@
>  	 * If this drive supports the Host Protected Area feature set,
>  	 * then we may need to change our opinion about the drive's capacity.
>  	 */
> -	int hpa = (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
> +	int hpa = idedisk_supports_hpa(id);
>
> -	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
> +	if (idedisk_supports_lba48(id)) {
>  		/* drive speaks 48-bit LBA */
> -		unsigned long long capacity_2;
> -
>  		drive->select.b.lba = 1;
> +		drive->capacity48 = id->lba_capacity_2;
> +		drive->capacity = (unsigned long) drive->capacity48;
>  		if (hpa)
>  			idedisk_check_hpa_lba48(drive);
> -		capacity_2 = id->lba_capacity_2;
> -		drive->head		= drive->bios_head = 255;
> -		drive->sect		= drive->bios_sect = 63;
> -		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
> -		drive->bios_cyl		= drive->cyl;
> -		drive->capacity48	= capacity_2;
> -		drive->capacity		= (unsigned long) capacity_2;
>  	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
>  		/* drive speaks 28-bit LBA */
> -		unsigned long capacity;
> -
>  		drive->select.b.lba = 1;
> +		drive->capacity = id->lba_capacity;
>  		if (hpa)
>  			idedisk_check_hpa_lba28(drive);
> -		capacity = id->lba_capacity;
> -		drive->cyl = capacity / (drive->head * drive->sect);
> -		drive->capacity = capacity;
>  	} else {
>  		/* drive speaks boring old 28-bit CHS */
>  		drive->capacity = drive->cyl * drive->head * drive->sect;
> @@ -1246,7 +1249,7 @@
>
>  static u64 idedisk_capacity (ide_drive_t *drive)
>  {
> -	if (drive->id->cfs_enable_2 & 0x0400)
> +	if (idedisk_supports_lba48(drive->id))
>  		return (drive->capacity48 - drive->sect0);
>  	return (drive->capacity - drive->sect0);
>  }
> @@ -1572,7 +1575,7 @@
>  	if (HWIF(drive)->addressing)
>  		return 0;
>
> -	if (!(drive->id->cfs_enable_2 & 0x0400))
> +	if (!idedisk_supports_lba48(drive->id))
>                  return -EIO;
>  	drive->addressing = arg;
>  	return 0;
> @@ -1696,19 +1699,28 @@
>  	 * by correcting bios_cyls:
>  	 */
>  	capacity = idedisk_capacity (drive);
> -	if (!drive->forced_geom && drive->bios_sect && drive->bios_head) {
> -		unsigned int cap0 = capacity;	/* truncate to 32 bits */
> -		unsigned int cylsz, cyl;
> -
> -		if (cap0 != capacity)
> -			drive->bios_cyl = 65535;
> -		else {
> -			cylsz = drive->bios_sect * drive->bios_head;
> -			cyl = cap0 / cylsz;
> -			if (cyl > 65535)
> -				cyl = 65535;
> -			if (cyl > drive->bios_cyl)
> -				drive->bios_cyl = cyl;
> +	if (!drive->forced_geom) {
> +
> +		if (idedisk_supports_lba48(drive->id)) {
> +			/* compatibility */
> +			drive->bios_sect = 63;
> +			drive->bios_head = 255;
> +		}
> +
> +		if (drive->bios_sect && drive->bios_head) {
> +			unsigned int cap0 = capacity; /* truncate to 32 bits */
> +			unsigned int cylsz, cyl;
> +
> +			if (cap0 != capacity)
> +				drive->bios_cyl = 65535;
> +			else {
> +				cylsz = drive->bios_sect * drive->bios_head;
> +				cyl = cap0 / cylsz;
> +				if (cyl > 65535)
> +					cyl = 65535;
> +				if (cyl > drive->bios_cyl)
> +					drive->bios_cyl = cyl;
> +			}
>  		}
>  	}
>  	printk(KERN_INFO "%s: %llu sectors (%llu MB)",

