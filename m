Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132658AbQKSRWR>; Sun, 19 Nov 2000 12:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKSRWH>; Sun, 19 Nov 2000 12:22:07 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13577
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132622AbQKSRVu>; Sun, 19 Nov 2000 12:21:50 -0500
Date: Sun, 19 Nov 2000 08:51:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Taisuke Yamada <tai@imasy.or.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old
 BIOS
In-Reply-To: <Pine.LNX.4.21.0011191816570.857-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.10.10011190849070.20388-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The original was good, but the changes made to do the callout fail to
return structs that need to be filled.  This is my fault.

On Sun, 19 Nov 2000, Dan Aloni wrote:

> On Sun, 19 Nov 2000, Taisuke Yamada wrote:
> 
> > Earlier this month, I had sent in a patch to 2.2.18pre17 (with
> > IDE-patch from http://www.linux-ide.org/ applied) to add support
> > for IDE disk larger than 32GB, even if the disk required "clipping"
> > to reduce apparent disk size due to BIOS limitation.
> >
> > [...] patch 
>  
> This patch is not good. It compiles, but when I boot the kernel, it
> decides to ignore the hdc=5606,255,63 parameter that I pass to the kernel,
> and limits the number of sectors to fill 8.4GB.
> 
> (from dmesg:)
> 
> hdc: lba = 0, cap = 16514064
> hdc: 16514064 sectors (8455 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(33)
> 
> Notes:
>  * Notice the contradiction between 16414064 sectors and 5606/255/63
>    geometry, something is definitly wrong there.
>  * I *didn't* change the jumper settings to 'clipping' mode, only the
>    kernel was modified in this test. 
>  * When I try to read (using dd) from somewhere above the 40GB offset in
>    the drive, no success. I guess if I tried to read pass 8.4GB it
>    wouldn't have yield success either.
>  * In this test, the code in the patch doesn't printk() anything except
>    that 'hdc: lba = 0, cap = 16514064' line.
>  * Normally, without the patch I get:
> 
>      hdc: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63,  
>          UDMA(33)
> 
>    And then there's no problem reading any offset on the drive.
> 
>  * I really need this sort of patch, tired of booting the computer from a
>    floppy...   
>  * The patch didn't want to apply for some reason, so I had to apply the
>    patch manually (to test11-pre7).
> 
>    Here is the version of patch that does apply: (please release an
>    updated patch)
> 
> --- linux/drivers/ide/ide-disk.c	Sun Nov 19 17:15:56 2000
> +++ linux/drivers/ide/ide-disk.c	Sun Nov 19 17:27:31 2000
> @@ -513,24 +513,149 @@
>  			current_capacity(drive));
>  }
>  
> +
> +/*
> + * Tests if the drive supports Host Protected Area feature.
> + * Returns true if supported, false otherwise.
> + */
> +static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
> +{
> +    int flag = (drive->id->command_set_1 & 0x0a) ? 1 : 0;
> +    printk("%s: host protected area => %d\n", drive->name, flag);
> +    return flag;
> +}
> +
> +/*
> + * Queries for true maximum capacity of the drive.
> + * Returns maximum LBA address (> 0) of the drive, 0 if failed.
> + */
> +static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
> +{
> +    byte args[7];
> +    unsigned long addr = 0;
> +
> +    printk("%s: checking for max native LBA...\n", drive->name);
> +
> +    /* Create IDE/ATA command request structure
> +     *
> +     * NOTE: I'm not sure if I can safely use IDE_*_OFFSET macro
> +     *       here...For real ATA command structure, offset for IDE
> +     *       command is 7, but in IDE driver, it needs to be at 0th
> +     *       index (same goes for IDE status offset below). Hmm...
> +     */
> +    args[0]                  = 0xf8; /* READ_NATIVE_MAX - see ATA spec */
> +    args[IDE_FEATURE_OFFSET] = 0x00;
> +    args[IDE_NSECTOR_OFFSET] = 0x00;
> +    args[IDE_SECTOR_OFFSET]  = 0x00;
> +    args[IDE_LCYL_OFFSET]    = 0x00;
> +    args[IDE_HCYL_OFFSET]    = 0x00;
> +    args[IDE_SELECT_OFFSET]  = 0x40;
> +
> +    /* submit command request - if OK, read current max LBA value */
> +    if (ide_wait_cmd_task(drive, args) == 0) {
> +        if ((args[0] & 0x01) == 0) {
> +            addr = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24)
> +                 | ((args[IDE_HCYL_OFFSET]         ) << 16)
> +                 | ((args[IDE_LCYL_OFFSET]         ) <<  8)
> +                 | ((args[IDE_SECTOR_OFFSET]       ));
> +        }
> +    }
> +
> +    printk("%s: max native LBA is %lu\n", drive->name, addr);
> +
> +    return addr;
> +}
> +
> +/*
> + * Sets maximum virtual LBA address of the drive.
> + * Returns new maximum virtual LBA address (> 0) or 0 on failure.
> + */
> +static unsigned long idedisk_set_max_address(ide_drive_t  *drive,
> +                         unsigned long addr_req)
> +{
> +    byte args[7];
> +    unsigned long addr_set = 0;
> +
> +    printk("%s: (un)clipping max LBA...\n", drive->name);
> +
> +    /* Create IDE/ATA command request structure
> +     *
> +     * NOTE: I'm not sure if I can safely use IDE_*_OFFSET macro
> +     *       here...For real ATA command structure, offset for IDE
> +     *       command is 7, but in IDE driver, it needs to be at 0th
> +     *       index (same goes for IDE status offset below). Hmm...
> +     */
> +    args[0]                  = 0xf9; /* SET_MAX - see ATA spec */
> +	args[IDE_FEATURE_OFFSET] = 0x00;
> +    args[IDE_NSECTOR_OFFSET] = 0x00;
> +    args[IDE_SECTOR_OFFSET]  = ((addr_req      ) & 0xff);
> +    args[IDE_LCYL_OFFSET]    = ((addr_req >>  8) & 0xff);
> +    args[IDE_HCYL_OFFSET]    = ((addr_req >> 16) & 0xff);
> +    args[IDE_SELECT_OFFSET]  = ((addr_req >> 24) & 0x0f) | 0x40;
> +
> +    /* submit command request - if OK, read new max LBA value */
> +    if (ide_wait_cmd_task(drive, args) == 0) {
> +        if ((args[0] & 0x01) == 0) {
> +            addr_set = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24)
> +                 | ((args[IDE_HCYL_OFFSET]         ) << 16)
> +                 | ((args[IDE_LCYL_OFFSET]         ) <<  8)
> +                 | ((args[IDE_SECTOR_OFFSET]       ));
> +        }
> +    }
> +
> +    printk("%s: max LBA (un)clipped to %lu\n", drive->name, addr_set);
> +
> +    return addr_set;
> +}
> +
>  /*
>   * Compute drive->capacity, the full capacity of the drive
>   * Called with drive->id != NULL.
> + *
> + * To compute capacity, this uses either of
> + *
> + *    1. CHS value set by user       (whatever user sets will be trusted)
> + *    2. LBA value from target drive (require new ATA feature)
> + *    3. LBA value from system BIOS  (new one is OK, old one may break)
> + *    4. CHS value from system BIOS  (traditional style)
> + *
> + * in above order (i.e., if value of higher priority is available,
> + * rest of the values are ignored).
>   */
>  static void init_idedisk_capacity (ide_drive_t  *drive)
>  {
> +    unsigned long      hd_max;
> +    unsigned long      hd_cap = drive->cyl * drive->head * drive->sect;
> +    int                is_lba = 0;
> +
>  	struct hd_driveid *id = drive->id;
> -	unsigned long capacity = drive->cyl * drive->head * drive->sect;
>  
> -	drive->select.b.lba = 0;
> +    /* Unless geometry is given by user, use autodetected value */
> +    if (! drive->forced_geom) {
> +        /* If BIOS LBA geometry is available, use it */
> +        if ((id->capability & 2) && lba_capacity_is_ok(id)) {
> +            hd_cap = id->lba_capacity;
> +            is_lba = 1;
> +        }
>  
> -	/* Determine capacity, and use LBA if the drive properly supports it */
> -	if ((id->capability & 2) && lba_capacity_is_ok(id)) {
> -		capacity = id->lba_capacity;
> -		drive->cyl = capacity / (drive->head * drive->sect);
> -		drive->select.b.lba = 1;
> +        /* If new ATA feature is supported, try using it */
> +        if (idedisk_supports_host_protected_area(drive)) {
> +            hd_max = idedisk_read_native_max_address(drive);
> +            hd_max = idedisk_set_max_address(drive, hd_max);
> +
> +            if (hd_max > 0) {
> +                hd_cap = hd_max;
> +                is_lba = 1;
> +            }
> +        }
>  	}
> -	drive->capacity = capacity;
> +
> +    printk("%s: lba = %d, cap = %lu\n", drive->name, is_lba, hd_cap);
> +
> +    /* update parameters with fetched results */
> +    drive->select.b.lba = is_lba;
> +    drive->capacity     = hd_cap;
> +    drive->cyl          = hd_cap / (drive->head * drive->sect);
>  }
>  
>  static unsigned long idedisk_capacity (ide_drive_t  *drive)
>  
> 
> -- 
> Dan Aloni 
> dax@karrde.org
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
