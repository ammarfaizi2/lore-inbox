Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVBXQOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVBXQOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVBXQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:13:10 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:46568 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261553AbVBXQK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:10:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lN1aDkz9SPVfPM2sVY/tuw4woCgGQrFmpF9uemWDnWv/5gvdeh2pF3WRzcPQYLPCv/JTZ5bTfQYZafZJWqzBhv6gnPJuesd9F3kHue/c4GNH1AKANU7HCqmGZzMGHi0SRcKGQSYe079Vt9f/DZ8GM83yQPwUtu1PBcHVnDLgjQ0=
Message-ID: <87f94c370502240810583e3a4a@mail.gmail.com>
Date: Thu, 24 Feb 2005 11:10:57 -0500
From: Greg Freemyer <greg.freemyer@gmail.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch ide-dev 3/9] merge LBA28 and LBA48 Host Protected Area support code
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
In-Reply-To: <Pine.GSO.4.58.0502241539100.13534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0502241539100.13534@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have generic question about HPA, not the patch.

I have noticed with a SUSE 2.6.8 vendor kernel, the HPA behavior is
not consistent.

ie. With exactly the same computer/controller, but with different disk
drives (models/manufacturers) the HPA behavior varies.

In all my testing the HPA was always properly detected, but sometimes
the max_address is set to the native_max_address during bootup and
sometimes it is not.

Is there some reason for this behavior or is one case or the other a bug?

Does this patch somehow address the inconsistency?

Am I right in assuming this behavior also exists in the vanilla
kernels?.  ie. I doubt that vendors are patching this behavior.

Thanks
Greg
-- 
Greg Freemyer


On Thu, 24 Feb 2005 15:39:51 +0100 (CET), Bartlomiej Zolnierkiewicz
<bzolnier@elka.pw.edu.pl> wrote:
> 
> * merge idedisk_read_native_max_address()
>   and idedisk_read_native_max_address_ext()
> * merge idedisk_set_max_address()
>   and idedisk_set_max_address_ext()
> 
> diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c    2005-02-19 17:22:44 +01:00
> +++ b/drivers/ide/ide-disk.c    2005-02-19 17:22:44 +01:00
> @@ -325,32 +325,7 @@
>   * Queries for true maximum capacity of the drive.
>   * Returns maximum LBA address (> 0) of the drive, 0 if failed.
>   */
> -static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
> -{
> -       ide_task_t args;
> -       struct ata_taskfile *tf = &args.tf;
> -       unsigned long addr = 0;
> -
> -       /* Create IDE/ATA command request structure */
> -       memset(&args, 0, sizeof(ide_task_t));
> -
> -       tf->device      = 0x40;
> -       tf->command     = WIN_READ_NATIVE_MAX;
> -
> -       args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
> -       args.handler                            = &task_no_data_intr;
> -       /* submit command request */
> -       ide_raw_taskfile(drive, &args, NULL);
> -
> -       /* if OK, compute maximum address value */
> -       if ((tf->command & 1) == 0) {
> -               addr = (u32)ide_tf_get_address(tf);
> -               addr++; /* since the return value is (maxlba - 1), we add 1 */
> -       }
> -       return addr;
> -}
> -
> -static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
> +static u64 idedisk_read_native_max_address(ide_drive_t *drive, unsigned int lba48)
>  {
>         ide_task_t args;
>         struct ata_taskfile *tf = &args.tf;
> @@ -360,13 +335,15 @@
>         memset(&args, 0, sizeof(ide_task_t));
> 
>         tf->device      = 0x40;
> -       tf->command     = WIN_READ_NATIVE_MAX_EXT;
> +       if (lba48) {
> +               tf->command = WIN_READ_NATIVE_MAX_EXT;
> +               tf->flags |= ATA_TFLAG_LBA48;
> +       } else
> +               tf->command = WIN_READ_NATIVE_MAX;
> 
>         args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
>         args.handler                            = &task_no_data_intr;
> 
> -       tf->flags |= ATA_TFLAG_LBA48;
> -
>          /* submit command request */
>          ide_raw_taskfile(drive, &args, NULL);
> 
> @@ -382,35 +359,7 @@
>   * Sets maximum virtual LBA address of the drive.
>   * Returns new maximum virtual LBA address (> 0) or 0 on failure.
>   */
> -static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
> -{
> -       ide_task_t args;
> -       struct ata_taskfile *tf = &args.tf;
> -       unsigned long addr_set = 0;
> -
> -       addr_req--;
> -       /* Create IDE/ATA command request structure */
> -       memset(&args, 0, sizeof(ide_task_t));
> -
> -       tf->lbal        = addr_req;
> -       tf->lbam        = addr_req >> 8;
> -       tf->lbah        = addr_req >> 16;
> -       tf->device      = ((addr_req >> 24) & 0xf) | 0x40;
> -       tf->command     = WIN_SET_MAX;
> -
> -       args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
> -       args.handler                            = &task_no_data_intr;
> -       /* submit command request */
> -       ide_raw_taskfile(drive, &args, NULL);
> -       /* if OK, read new maximum address value */
> -       if ((tf->command & 1) == 0) {
> -               addr_set = (u32)ide_tf_get_address(tf);
> -               addr_set++;
> -       }
> -       return addr_set;
> -}
> -
> -static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
> +static u64 idedisk_set_max_address(ide_drive_t *drive, u64 addr_req, unsigned int lba48)
>  {
>         ide_task_t args;
>         struct ata_taskfile *tf = &args.tf;
> @@ -423,17 +372,22 @@
>         tf->lbal        = addr_req;
>         tf->lbam        = addr_req >> 8;
>         tf->lbah        = addr_req >> 16;
> -       tf->device      = 0x40;
> -       tf->command     = WIN_SET_MAX_EXT;
> -       tf->hob_lbal    = addr_req >> 24;
> -       tf->hob_lbam    = addr_req >> 32;
> -       tf->hob_lbah    = addr_req >> 40;
> +       if (lba48) {
> +               tf->hob_lbal    = addr_req >> 24;
> +               tf->hob_lbam    = addr_req >> 32;
> +               tf->hob_lbah    = addr_req >> 40;
> +               tf->device      = 0x40;
> +               tf->command     = WIN_SET_MAX_EXT;
> +
> +               tf->flags |= ATA_TFLAG_LBA48;
> +       } else {
> +               tf->device      = ((addr_req >> 24) & 0xf) | 0x40;
> +               tf->command     = WIN_SET_MAX;
> +       }
> 
>         args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
>         args.handler                            = &task_no_data_intr;
> 
> -       tf->flags |= ATA_TFLAG_LBA48;
> -
>         /* submit command request */
>         ide_raw_taskfile(drive, &args, NULL);
>         /* if OK, compute maximum address value */
> @@ -476,10 +430,8 @@
>         int lba48 = idedisk_supports_lba48(drive->id);
> 
>         capacity = drive->capacity64;
> -       if (lba48)
> -               set_max = idedisk_read_native_max_address_ext(drive);
> -       else
> -               set_max = idedisk_read_native_max_address(drive);
> +
> +       set_max = idedisk_read_native_max_address(drive, lba48);
> 
>         if (set_max <= capacity)
>                 return;
> @@ -491,10 +443,8 @@
>                          capacity, sectors_to_MB(capacity),
>                          set_max, sectors_to_MB(set_max));
> 
> -       if (lba48)
> -               set_max = idedisk_set_max_address_ext(drive, set_max);
> -       else
> -               set_max = idedisk_set_max_address(drive, set_max);
> +       set_max = idedisk_set_max_address(drive, set_max, lba48);
> +
>         if (set_max) {
>                 drive->capacity64 = set_max;
>                 printk(KERN_INFO "%s: Host Protected Area disabled.\n",
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
