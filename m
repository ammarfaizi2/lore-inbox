Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVKQUjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVKQUjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVKQUje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:39:34 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:24452 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964843AbVKQUje convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:39:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=apVH9XpG0dcxc9vA5kd9UFrrM2rxBKueMdD8Uj4UITd1VerE4EAh2Y8/GHpCdZKzcK0CLQ7qUwY2IYWEifuBe7t4H+0Ab/Gkf4XJfXE6KUWed2Aofs/GdbrTVadaHN+c1kCoTEAwm6cpN7ekGli6eusburbfTYFRwPXxOoZEn40=
Message-ID: <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>
Date: Thu, 17 Nov 2005 21:39:32 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support to IDE
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051117153509.5A77ED53@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.5A77ED53@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
> 09_blk_ide-add-fua-support.patch
>
>         Add FUA support to IDE
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
>
>  drivers/ide/ide-disk.c |   57 +++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/hdreg.h  |   16 ++++++++++++-
>  include/linux/ide.h    |    3 ++
>  3 files changed, 65 insertions(+), 11 deletions(-)
>
> Index: work/drivers/ide/ide-disk.c
> ===================================================================
> --- work.orig/drivers/ide/ide-disk.c    2005-11-18 00:35:06.000000000 +0900
> +++ work/drivers/ide/ide-disk.c 2005-11-18 00:35:07.000000000 +0900
> @@ -164,13 +164,14 @@ static ide_startstop_t __ide_do_rw_disk(
>         ide_hwif_t *hwif        = HWIF(drive);
>         unsigned int dma        = drive->using_dma;
>         u8 lba48                = (drive->addressing == 1) ? 1 : 0;
> +       int fua                 = blk_fua_rq(rq);
>         task_ioreg_t command    = WIN_NOP;
>         ata_nsector_t           nsectors;
>
>         nsectors.all            = (u16) rq->nr_sectors;
>
>         if (hwif->no_lba48_dma && lba48 && dma) {
> -               if (block + rq->nr_sectors > 1ULL << 28)
> +               if (block + rq->nr_sectors > 1ULL << 28 || fua)
>                         dma = 0;
>                 else
>                         lba48 = 0;
> @@ -226,6 +227,16 @@ static ide_startstop_t __ide_do_rw_disk(
>                         hwif->OUTB(tasklets[6], IDE_HCYL_REG);
>                         hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
>                 } else {
> +                       if (unlikely(fua)) {
> +                               /*
> +                                * This happens if LBA48 addressing is
> +                                * turned off during operation.
> +                                */
> +                               printk(KERN_ERR "%s: FUA write but LBA48 off\n",
> +                                      drive->name);
> +                               goto fail;
> +                       }
> +
>                         hwif->OUTB(0x00, IDE_FEATURE_REG);
>                         hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
>                         hwif->OUTB(block, IDE_SECTOR_REG);
> @@ -253,9 +264,12 @@ static ide_startstop_t __ide_do_rw_disk(
>         if (dma) {
>                 if (!hwif->dma_setup(drive)) {
>                         if (rq_data_dir(rq)) {
> -                               command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
> -                               if (drive->vdma)
> -                                       command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
> +                               if (!fua) {
> +                                       command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
> +                                       if (drive->vdma)
> +                                               command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
> +                               } else
> +                                       command = ATA_CMD_WRITE_FUA_EXT;

What does happen for fua && drive->vdma case?

>                         } else {
>                                 command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
>                                 if (drive->vdma)
> @@ -284,8 +298,20 @@ static ide_startstop_t __ide_do_rw_disk(
>         } else {
>                 if (drive->mult_count) {
>                         hwif->data_phase = TASKFILE_MULTI_OUT;
> -                       command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
> +                       if (!fua)
> +                               command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
> +                       else
> +                               command = ATA_CMD_WRITE_MULTI_FUA_EXT;
>                 } else {
> +                       if (unlikely(fua)) {
> +                               /*
> +                                * This happens if multisector PIO is
> +                                * turned off during operation.
> +                                */
> +                               printk(KERN_ERR "%s: FUA write but in single "
> +                                      "sector PIO mode\n", drive->name);
> +                               goto fail;
> +                       }

Wouldn't it be better to do the following check at the beginning
of __ide_do_rw_disk() (after checking for dma vs lba48):

        if (fua) {
                if (!lba48 || ((!dma || drive->vdma) && !drive->mult_count))
                        goto fail_fua;
        }

...

and fail the request if needed *before* actually touching any
hardware registers?

fail_fua:
        printk(KERN_ERR "%s: FUA write unsupported (lba48=%u dma=%u"
                                       " vdma=%u mult_count=%u)\n", drive->name,
                                       lba48, dma, drive->vdma,
drive->mult_count);
        ide_end_request(drive, 0, 0);
        return ide_stopped;

>                         hwif->data_phase = TASKFILE_OUT;
>                         command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
>                 }
> @@ -295,6 +321,10 @@ static ide_startstop_t __ide_do_rw_disk(
>
>                 return pre_task_out_intr(drive, rq);
>         }
> +
> + fail:
> +       ide_end_request(drive, 0, 0);
> +       return ide_stopped;
>  }
>
>  /*
> @@ -846,7 +876,7 @@ static void idedisk_setup (ide_drive_t *
>  {
>         struct hd_driveid *id = drive->id;
>         unsigned long long capacity;
> -       int barrier;
> +       int barrier, fua;
>
>         idedisk_add_settings(drive);
>
> @@ -967,10 +997,19 @@ static void idedisk_setup (ide_drive_t *
>                         barrier = 0;
>         }
>
> -       printk(KERN_INFO "%s: cache flushes %ssupported\n",
> -               drive->name, barrier ? "" : "not ");
> +       fua = barrier && idedisk_supports_lba48(id) && ide_id_has_fua(id);
> +       /* When using PIO, FUA needs multisector. */
> +       if ((!drive->using_dma || drive->hwif->no_lba48_dma) &&
> +           drive->mult_count == 0)
> +               fua = 0;

Shouldn't this check also for drive->vdma?

> +
> +       printk(KERN_INFO "%s: cache flushes %ssupported%s\n",
> +              drive->name, barrier ? "" : "not ",
> +              fua ? " w/ FUA" : "");
>         if (barrier) {
> -               blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN_FLUSH,
> +               unsigned ordered = fua ? QUEUE_ORDERED_DRAIN_FUA
> +                                      : QUEUE_ORDERED_DRAIN_FLUSH;
> +               blk_queue_ordered(drive->queue, ordered,
>                                   idedisk_prepare_flush, GFP_KERNEL);
>                 blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
>         } else if (!drive->wcache)
> Index: work/include/linux/hdreg.h
> ===================================================================
> --- work.orig/include/linux/hdreg.h     2005-11-18 00:06:46.000000000 +0900
> +++ work/include/linux/hdreg.h  2005-11-18 00:35:07.000000000 +0900
> @@ -550,7 +550,13 @@ struct hd_driveid {
>                                          * cmd set-feature supported extensions
>                                          * 15:  Shall be ZERO
>                                          * 14:  Shall be ONE
> -                                        * 13:6 reserved
> +                                        * 13:  IDLE IMMEDIATE w/ UNLOAD FEATURE
> +                                        * 12:11 reserved for technical report
> +                                        * 10:  URG for WRITE STREAM
> +                                        *  9:  URG for READ STREAM
> +                                        *  8:  64-bit World wide name
> +                                        *  7:  WRITE DMA QUEUED FUA EXT
> +                                        *  6:  WRITE DMA/MULTIPLE FUA EXT
>                                          *  5:  General Purpose Logging
>                                          *  4:  Streaming Feature Set
>                                          *  3:  Media Card Pass Through
> @@ -600,7 +606,13 @@ struct hd_driveid {
>                                          * command set-feature default
>                                          * 15:  Shall be ZERO
>                                          * 14:  Shall be ONE
> -                                        * 13:6 reserved
> +                                        * 13:  IDLE IMMEDIATE w/ UNLOAD FEATURE
> +                                        * 12:11 reserved for technical report
> +                                        * 10:  URG for WRITE STREAM
> +                                        *  9:  URG for READ STREAM
> +                                        *  8:  64-bit World wide name
> +                                        *  7:  WRITE DMA QUEUED FUA EXT
> +                                        *  6:  WRITE DMA/MULTIPLE FUA EXT
>                                          *  5:  General Purpose Logging enabled
>                                          *  4:  Valid CONFIGURE STREAM executed
>                                          *  3:  Media Card Pass Through enabled
> Index: work/include/linux/ide.h
> ===================================================================
> --- work.orig/include/linux/ide.h       2005-11-18 00:14:29.000000000 +0900
> +++ work/include/linux/ide.h    2005-11-18 00:35:07.000000000 +0900
> @@ -1503,6 +1503,9 @@ extern struct bus_type ide_bus_type;
>  /* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
>  #define ide_id_has_flush_cache(id)     ((id)->cfs_enable_2 & 0x3000)
>
> +/* check if WRITE DMA FUA EXT command is supported (defined in ATA-8) */
> +#define ide_id_has_fua(id)             ((id)->cfsse & 0x0040)
> +
>  /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
>  #define ide_id_has_flush_cache_ext(id) \
>         (((id)->cfs_enable_2 & 0x2400) == 0x2400)
>
>
