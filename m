Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261926AbREYV10>; Fri, 25 May 2001 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261929AbREYV1H>; Fri, 25 May 2001 17:27:07 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:41476 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261926AbREYV04>; Fri, 25 May 2001 17:26:56 -0400
Date: Fri, 25 May 2001 14:27:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc checks for drivers/ide/ide-probe.c (244ac16)
In-Reply-To: <20010525225646.J851@jaquet.dk>
Message-ID: <Pine.LNX.4.10.10105251416230.2098-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Rasmus Andersen wrote:

> On Fri, May 25, 2001 at 01:47:52PM -0700, Andre Hedrick wrote:
> > 
> > Not valid because the jump to that part of the code is protected.
> > If a polling response for a valid status and no timeout, is detected then
> > it attempts to the command for real only after success or a test.
> > 
> > Otherwise it would be valid.

/*
 * try_to_identify() sends an ATA(PI) IDENTIFY request to a drive
 * and waits for a response.  It also monitors irqs while this is
 * happening, in hope of automatically determining which one is
 * being used by the interface.
 *
 * Returns:     0  device was identified
 *              1  device timed-out (no response to identify request)
 *              2  device aborted the command (refused to identify itself)
 */
static int actual_try_to_identify (ide_drive_t *drive, byte cmd)
{
<snip>
        if (OK_STAT(GET_STAT(),DRQ_STAT,BAD_R_STAT)) {
                unsigned long flags;
                __save_flags(flags);    /* local CPU only */
                __cli();                /* local CPU only; some systems need this */
                do_identify(drive, cmd); /* drive returned ID */
                rc = 0;                 /* drive responded with ID */
                (void) GET_STAT();      /* clear drive IRQ */
                __restore_flags(flags); /* local CPU only */
        } else
                rc = 2;                 /* drive refused ID */
        return rc;
}

If you get_stat returns a bad status we do not go into the test loop.

> So the EXABYTE case should return normally, I take (otherwise you
> confused me good;))? The patch below drops this change and keeps
> the rest.


/*
 * probe_for_drive() tests for existence of a given drive using do_probe().
 *
 * Returns:     0  no device was found
 *              1  device was found (note: drive->present might still be 0)
 */
static inline byte probe_for_drive (ide_drive_t *drive)

This calls out for the poke in the ribbon, and if it fail anywhere we
never get to the top function for the kmallocs.

Does that help?

This is potentially valid for modules but if it built in and you are out
of memory before partition checking....go buy some memory.  Also if you
are adding devices with a system under hard load eating/using memory to
that scale, you will have other issues to go KABOOM.

Will look at it for verification and run a gedanken process and get back
about it.

> 
> --- linux-244-ac16-clean/drivers/ide/ide-probe.c	Fri May 25 21:11:08 2001
> +++ linux-244-ac16/drivers/ide/ide-probe.c	Fri May 25 22:54:15 2001
> @@ -58,6 +58,11 @@
>  	struct hd_driveid *id;
>  
>  	id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);	/* called with interrupts disabled! */
> +        if (!id) {
> +                printk(KERN_WARNING "(ide-probe::do_identify) Out of memory.\n");
> +                goto err_kmalloc;
> +        }
> +
>  	ide_input_data(drive, id, SECTOR_WORDS);		/* read 512 bytes of id info */
>  	ide__sti();	/* local CPU only */
>  	ide_fix_driveid(id);
> @@ -76,8 +81,7 @@
>  	if ((id->model[0] == 'P' && id->model[1] == 'M')
>  	 || (id->model[0] == 'S' && id->model[1] == 'K')) {
>  		printk("%s: EATA SCSI HBA %.10s\n", drive->name, id->model);
> -		drive->present = 0;
> -		return;
> +                goto err_misc;
>  	}
>  #endif /* CONFIG_SCSI_EATA_DMA || CONFIG_SCSI_EATA_PIO */
>  
> @@ -111,8 +115,7 @@
>  #ifdef CONFIG_BLK_DEV_PDC4030
>  		if (HWIF(drive)->channel == 1 && HWIF(drive)->chipset == ide_pdc4030) {
>  			printk(" -- not supported on 2nd Promise port\n");
> -			drive->present = 0;
> -			return;
> +                        goto err_misc;
>  		}
>  #endif /* CONFIG_BLK_DEV_PDC4030 */
>  		switch (type) {
> @@ -174,6 +177,12 @@
>  	printk("ATA DISK drive\n");
>  	QUIRK_LIST(HWIF(drive),drive);
>  	return;
> +
> +err_misc:
> +        kfree(id);
> +err_kmalloc:
> +        drive->present = 0;
> +        return;
>  }
>  
>  /*
> @@ -759,11 +768,23 @@
>  	}
>  	minors    = units * (1<<PARTN_BITS);
>  	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
> -	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
> -	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
> -	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
> -	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
> -	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
> +        if (!gd)
> +                goto err_kmalloc_gd;
> +        gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
> +        if (!gd->sizes)
> +                goto err_kmalloc_gd_sizes;
> +        gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
> +        if (!gd->part)
> +                goto err_kmalloc_gd_part;
> +        bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
> +        if (!bs)
> +                goto err_kmalloc_gs;
> +        max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
> +        if (!max_sect)
> +                goto err_kmalloc_max_sect;
> +        max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
> +        if (!max_ra)
> +                goto err_kmalloc_max_ra;
>  
>  	memset(gd->part, 0, minors * sizeof(struct hd_struct));
>  
> @@ -816,6 +837,21 @@
>  				devfs_mk_dir (ide_devfs_handle, name, NULL);
>  		}
>  	}
> +        return;
> +
> +err_kmalloc_max_ra:
> +        kfree(max_sect);
> +err_kmalloc_max_sect:
> +        kfree(bs);
> +err_kmalloc_gs:
> +        kfree(gd->part);
> +err_kmalloc_gd_part:
> +        kfree(gd->sizes);
> +err_kmalloc_gd_sizes:
> +        kfree(gd);
> +err_kmalloc_gd:
> +        printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
> +        return;
>  }
>  
>  static int hwif_init (ide_hwif_t *hwif)
> 
> Regards,
>    Rasmus
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

