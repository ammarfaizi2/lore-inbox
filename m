Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319130AbSHTBQI>; Mon, 19 Aug 2002 21:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319131AbSHTBQH>; Mon, 19 Aug 2002 21:16:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2309 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319130AbSHTBQG>; Mon, 19 Aug 2002 21:16:06 -0400
Date: Mon, 19 Aug 2002 18:19:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
cc: Stanislav Brabec <utx@penguin.cz>, Paul Bristow <paul@paulbristow.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty
In-Reply-To: <3D619776.7010104@cox.net>
Message-ID: <Pine.LNX.4.10.10208191813450.3488-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Kevin!

Regardless we do it now, I have been held off for to long to clean house.

AC and I are on a major role.  AC is putting the final touchs on the my
original modular chipset solution.  He is doing the kernel correctness
while I keep the within the limits of the hardware.  The converse is as I
go broad in design and intentionally bloat code to show common calls, AC
is able to finish the slice and final code reductions as togather we purge
the history of bloating.  AC gets the reason for my bloat direction and on
occassion I beat him to the punch on the net bloat reduction solution.

Cheers,


Andre Hedrick
LAD Storage Consulting Group



On Mon, 19 Aug 2002, Kevin P. Fleming wrote:

> I'll let Paul handle this, since he is the ide-floppy maintainer and has 
> some other changes he wants to make. If you do not get anything from him 
> in a week or so, please let me know and I'll updates the patches to the 
> latest -ac kernel and send them.
> 
> Oh, there is one non-ide-floppy patch, this cleans up a small part of 
> ide-probe and ensures that ide-floppy devices are marked as removable 
> devices. Last kernel I applied it to was 2.4.20-pre2-ac1, it may have 
> problems with the newer ones if you've worked on ide-probe.
> 
> diff -X dontdiff -urN linux/drivers/ide/ide-probe.c 
> linux-probe/drivers/ide/ide-probe.c
> --- linux/drivers/ide/ide-probe.c	Thu Jun  6 10:00:50 2002
> +++ linux-probe/drivers/ide/ide-probe.c	Thu Jun  6 10:37:41 2002
> @@ -130,31 +130,40 @@
>   			goto err_misc;
>   		}
>   #endif /* CONFIG_BLK_DEV_PDC4030 */
> +		/*
> +		 * Handle drive type overrides for "unusual" devices
> +		 */
>   		switch (type) {
> -			case ide_floppy:
> -				if (!strstr(id->model, "CD-ROM")) {
> -					if (!strstr(id->model, "oppy") &&
> -					    !strstr(id->model, "poyp") &&
> -					    !strstr(id->model, "ZIP"))
> -						printk("cdrom or floppy?, assuming ");
> -					if (drive->media != ide_cdrom) {
> -						printk ("FLOPPY");
> -						break;
> -					}
> -				}
> +		case ide_floppy:
> +			if (strstr(id->model, "CD-ROM")) {
> +				type = ide_cdrom;
> +				break;
> +			}
> +			if (!strstr(id->model, "oppy") &&
> +			    !strstr(id->model, "poyp") &&
> +			    !strstr(id->model, "ZIP"))
> +				printk("cdrom or floppy?, assuming ");
> +			if (drive->media == ide_cdrom)
>   				type = ide_cdrom;	/* Early cdrom models used zero */
> -			case ide_cdrom:
> -				drive->removable = 1;
> +			break;
>   #ifdef CONFIG_PPC
> +		case ide_cdrom:
>   				/* kludge for Apple PowerBook internal zip */
> -				if (!strstr(id->model, "CD-ROM") &&
> -				    strstr(id->model, "ZIP")) {
> -					printk ("FLOPPY");
> -					type = ide_floppy;
> -					break;
> -				}
> +			if (!strstr(id->model, "CD-ROM") &&
> +			    strstr(id->model, "ZIP")) {
> +				type = ide_floppy;
> +				break;
> +			}
>   #endif
> +		}
> +		switch (type) {
> + 			case ide_floppy:
> + 				printk ("FLOPPY");
> + 				drive->removable = 1;
> + 				break;
> + 			case ide_cdrom:
>   				printk ("CD/DVD-ROM");
> + 				drive->removable = 1;
>   				break;
>   			case ide_tape:
>   				printk ("TAPE");
> 
> 
> Andre Hedrick wrote:
> > Patch is welcome here.
> > 
> > Drop it on AC and myself please. 
> > 
> > On Mon, 19 Aug 2002, Kevin P. Fleming wrote:
> > 
> > 
> >>There are patches at http://members.cox.net/kpfleming/ide-floppy to 
> >>resolve this.
> >>
> >>Stanislav Brabec wrote:
> >>
> >>>Hallo Paul Bristow,
> >>>
> >>>I have tested ide-floppy on my Linux 2.4.19 with ATAPI ZIP 100. I am
> >>>using devfs.
> >>>
> >>>I found following problem:
> >>>
> >>>If module ide-floppy is loaded and no disc is present in the drive,
> >>>/dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
> >>>inserted media cannot be checked in any way, because no /dev entry
> >>>exists.
> >>>
> >>>Older kernels have also this behavior.
> >>>
> >>>Fix: Create .../disc entry in all cases, even if no disc is present.
> >>>
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> > 
> > 
> > Andre Hedrick
> > LAD Storage Consulting Group
> > 
> 

