Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVBFTKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVBFTKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBFTKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:10:18 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:8043 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261277AbVBFSqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:46:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=K2Gilz6xJyg1YAuX0UeH0C5CVijBC/ZIjmmJV85vt1ogov9yTVmfOWe/Vk9BCeCNy1PorBZZdF5QHn4E+5+g0MTVDRfOXe+Mpyu7rGkRyS+FqKcq4n7a20FbsURJVD0UncwpNxrsGHiUlW6ZPNVoTJYNV6T5S7rHY8GEyZvF9ow=
Message-ID: <58cb370e050206104674386588@mail.gmail.com>
Date: Sun, 6 Feb 2005 19:46:49 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 08/09] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050205021557.6A692132705@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050205021502.GA17767@htj.dyndns.org>
	 <20050205021557.6A692132705@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not fully reviewed it yet but I've noticed two things...

> @@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
> 
>  EXPORT_SYMBOL(eighty_ninty_three);
> 
> -int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
> +int ide_ata66_check(ide_drive_t *drive, task_ioreg_t *regs)
>  {
> -       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> -           (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> -           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> +       if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
> +           regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2 &&
> +           regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) {
>  #ifndef CONFIG_IDEDMA_IVB
>                 if ((drive->id->hw_config & 0x6000) == 0) {
>  #else /* !CONFIG_IDEDMA_IVB */

What is the rationale for this change?
ide_task_t is available in ide_cmd_ioctl().

> @@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
>   * 1 : Safe to update drive->id DMA registers.
>   * 0 : OOPs not allowed.
>   */
> -int set_transfer (ide_drive_t *drive, ide_task_t *args)
> +int set_transfer(ide_drive_t *drive, task_ioreg_t *regs)
>  {
> -       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> -           (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> -           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> +       if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
> +           regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0 &&
> +           regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER &&
>             (drive->id->dma_ultra ||
>              drive->id->dma_mword ||
>              drive->id->dma_1word))

ditto

> +       io_32bit = drive->io_32bit;
> +       drive->io_32bit = 0;    /* racy */
> +       ret = ide_diag_taskfile(drive, &task, in_size, buf);
> +       drive->io_32bit = io_32bit;

It wasn't racy before this patch.  I know that it is like that
in ide_taskfile_ioctl() but it is not an excuse for propagating
the bug.  It can be easily fixed if you use drive_cmd_intr()
instead of task_in_intr() as task->handler.

Thanks,
Bartlomiej
