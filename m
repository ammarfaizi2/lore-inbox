Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVILOou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVILOou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVILOou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:44:50 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:37575 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbVILOot convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:44:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a4PPr2ieeF5EcCPTlX/nmH70XpTrrXwVpsZulHv4rQqgPQ+Y2KHq7HvOmynQLBo7qKgmRSak2xOQ/oYVLOKD1SvkDASgThJV6W0JJYyH32Rv5MpiLgZLtXiKuSLjpordc0WNCj1SGckKXfRYnfRNIv3fMeImB/ivDivfeGx+FCM=
Message-ID: <58cb370e05091207442025462a@mail.gmail.com>
Date: Mon, 12 Sep 2005 16:44:48 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: bzolnier@gmail.com
To: Thomas Kleffel <tk@maintech.de>
Subject: Re: [PATCH] fix kernel oops with CF-Cards
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <431DEA51.1080100@maintech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431DEA51.1080100@maintech.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Thomas Kleffel <tk@maintech.de> wrote:
> Hello,

Hi,

> when a mounted CF-Card is removed from the system, inserted back into
> the slot, removed again, and then umount is called for that device the
> kernel oopes.
> 
> (This is a slightly different issue than noted in my last mail.)
> 
> This happens because the reference counting gets confused. When a disk
> gets released by ide_disk_release() it sets the driver_data member of
> the corresponding drive to NULL. This is bad, as the pyhsical drive
> could be assigned to another idkp structure in the meantime (happens,
> when the drive is removed and inserted again).

As another idkp structure is a new object so still keeping the reference
to the old one is a bug.  It looks like the real problem here is that there
are still references to the old idkp object while it is already gone.

Please see my previous mail.

Thanks,
Bartlomiej

> My fix is to simply leave the drive alone when a disk is released. This
> shouldn't cause any side-effects - drive->driver_data isn't tested for
> containing NULL anywhere.
> 
> The following patch (against vanilla 2.6.13) fixes that problem:
> 
> diff -uprN -X b/Documentation/dontdiff a/drivers/ide/ide-disk.c
> b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c    2005-08-24 17:58:02.000000000 +0200
> +++ b/drivers/ide/ide-disk.c    2005-09-05 02:10:30.000000000 +0200
> @@ -1048,11 +1048,8 @@ static int ide_disk_remove(struct device
>   static void ide_disk_release(struct kref *kref)
>   {
>         struct ide_disk_obj *idkp = to_ide_disk(kref);
> -       ide_drive_t *drive = idkp->drive;
>         struct gendisk *g = idkp->disk;
> 
> -       drive->driver_data = NULL;
> -       drive->devfs_name[0] = '\0';
>         g->private_data = NULL;
>         put_disk(g);
>         kfree(idkp);
> 
> Signed-off-by: Thomas Kleffel <tk@maintech.de>
> 
> Best regards,
> Thomas
