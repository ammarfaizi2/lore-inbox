Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289213AbSBJDEZ>; Sat, 9 Feb 2002 22:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289214AbSBJDEQ>; Sat, 9 Feb 2002 22:04:16 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56838
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289213AbSBJDD7>; Sat, 9 Feb 2002 22:03:59 -0500
Date: Sat, 9 Feb 2002 18:53:44 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Andries.Brouwer@cwi.nl
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tiny IDE fixes
In-Reply-To: <UTC200202100120.BAA52437.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.10.10202091853120.20733-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, fixed that a few nights ago ...

On Sun, 10 Feb 2002 Andries.Brouwer@cwi.nl wrote:

> In order to use all of my 160 GB disk, I booted linux-2.4.18-pre7-ac3
> and was told that it had geometry 317632/255/63, a disk of terabyte size.
> Moving the assignment to cyls two lines this becomes 19929/255/63,
> as expected.
> 
> The deleted part in the first hunk is dead code.
> 
> As remarked earlier, all addr++ should be done only when
> something was assigned to addr. Maybe there are more such places.
> 
> Apart from such tiny flaws, everything works beautifully.
> 
> Andre, in this geometry stuff more than half of the code can be
> deleted. For example, drive->CHS is used when talking CHS with
> the drive; no use assigning very large values to drive->C; nobody
> will ever use such values. Then again, bios_CHS is what the BIOS
> tells us, which is to be used by fdisk and lilo.
> Again, no use assigning very large values to bios_cyl.
> fdisk has only 10 bits to write these values in,
> lilo cannot use more than 16 bits.
> In particular, the ioctl HDIO_GETGEO_BIG is superfluous.
> 
> I said it before and I repeat: I really hope that you remove
> all occurrences of HDIO_GETGEO_BIG. The values returned by it
> are not used by fdisk, or by lilo, or by the kernel, or by
> the disk drive, they are just nonsense numbers.
> 
> The convention for the use of HDIO_GETGEO is:
> Get heads and sectors from HDIO_GETGEO. In case one wants
> cylinders, ask for total size with BLKGETSIZE and divide by
> heads*sectors. Consider the cyls field of the struct returned
> by HDIO_GETGEO to be undefined.
> 
> Andries
> 
> 
> diff -u --recursive --new-file ../linux-2.4.18-pre7-ac3/linux/drivers/ide/ide-disk.c ./linux/drivers/ide/ide-disk.c
> --- ../linux-2.4.18-pre7-ac3/linux/drivers/ide/ide-disk.c	Mon Feb 11 02:53:28 2002
> +++ ./linux/drivers/ide/ide-disk.c	Mon Feb 11 02:28:09 2002
> @@ -111,11 +111,6 @@
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
> @@ -789,8 +784,8 @@
>  		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
>  		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
>  		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
> +		addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	}
> -	addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	return addr;
>  }
>  
> @@ -818,8 +813,8 @@
>  			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
>  			    (args.tfRegister[IDE_SECTOR_OFFSET]);
>  		addr = ((__u64)high << 24) | low;
> +		addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	}
> -	addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	return addr;
>  }
>  
> @@ -850,8 +845,8 @@
>  			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
>  			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
>  			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
> +		addr_set++;
>  	}
> -	addr_set++;
>  	return addr_set;
>  }
>  
> @@ -929,9 +924,9 @@
>  
>  	if (id->cfs_enable_2 & 0x0400) {
>  		capacity_2 = id->lba_capacity_2;
> -		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
>  		drive->head		= drive->bios_head = 255;
>  		drive->sect		= drive->bios_sect = 63;
> +		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
>  		drive->select.b.lba	= 1;
>  		set_max_ext = idedisk_read_native_max_address_ext(drive);
>  		if (set_max_ext > capacity_2) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

