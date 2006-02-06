Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWBFQxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWBFQxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWBFQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:53:31 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:51697 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbWBFQxa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:53:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dDx1RY9h1DmBOmphATzsbJ5Y8HwSvxbMvfWKQgrYDy1beTInAW1w6p+0REAG7niwGPCCD4zflAGhDwW84r+HIrds7xiTEQP2+k/4xNcmWGW2FCrpa8MYU4sntRJU8tX6FyYPZjs8JKPcdS6JfegxgF54inr+DkzA9+284gYL3BA=
Message-ID: <58cb370e0602060853i469d3449j5d2673b407aec460@mail.gmail.com>
Date: Mon, 6 Feb 2006 17:53:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 11/12] LED: Add IDE disk activity LED trigger
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1139154893.14624.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1139154893.14624.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Generally it looks fine, some minor comments below.

On 2/5/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> Add an LED trigger for IDE disk activity to the ide-disk driver.

filesystem activity

> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
>
> Index: linux-2.6.15/drivers/ide/ide-disk.c
> ===================================================================
> --- linux-2.6.15.orig/drivers/ide/ide-disk.c    2006-02-04 13:35:37.000000000 +0000
> +++ linux-2.6.15/drivers/ide/ide-disk.c 2006-02-04 15:17:18.000000000 +0000
> @@ -60,6 +60,7 @@
>  #include <linux/genhd.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/leds.h>
>
>  #define _IDE_DISK
>
> @@ -80,6 +81,8 @@
>
>  static DECLARE_MUTEX(idedisk_ref_sem);
>
> +INIT_LED_TRIGGER(ide_led_trigger);
> +
>  #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
>
>  #define ide_disk_g(disk) \
> @@ -311,10 +314,12 @@
>
>         if (!blk_fs_request(rq)) {
>                 blk_dump_rq_flags(rq, "ide_do_rw_disk - bad command");
> -               ide_end_request(drive, 0, 0);
> +               ide_end_rw_disk(drive, 0, 0);
>                 return ide_stopped;
>         }
>
> +       led_trigger_event(ide_led_trigger, LED_FULL);
> +
>         pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
>                  drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
>                  block, rq->nr_sectors, (unsigned long)rq->buffer);
> @@ -325,6 +330,12 @@
>         return __ide_do_rw_disk(drive, rq, block);
>  }
>
> +static int ide_end_rw_disk(ide_drive_t *drive, int uptodate, int nr_sectors)

ide_end_rw_disk() is used before it is declared.

Does it compile?

> +{
> +       led_trigger_event(ide_led_trigger, LED_OFF);

It should check for blk_fs_request().

->end_request() can be used for other request types.

> +       ide_end_request(drive, uptodate, nr_sectors);
> +}
> +
>  /*
>   * Queries for true maximum capacity of the drive.
>   * Returns maximum LBA address (> 0) of the drive, 0 if failed.
> @@ -1097,7 +1108,7 @@
>         .media                  = ide_disk,
>         .supports_dsc_overlap   = 0,
>         .do_request             = ide_do_rw_disk,
> -       .end_request            = ide_end_request,
> +       .end_request            = ide_end_rw_disk,
>         .error                  = __ide_error,
>         .abort                  = __ide_abort,
>         .proc                   = idedisk_proc,
> @@ -1259,11 +1270,13 @@
>
>  static void __exit idedisk_exit (void)
>  {
> +       led_trigger_unregister_simple(ide_led_trigger);
>         driver_unregister(&idedisk_driver.gen_driver);

Shouldn't ordering be reverse to this in idedisk_init()?
First driver_unregister(), then led_trigger_unregister_simple()?

>  }
>
>  static int __init idedisk_init(void)
>  {
> +       led_trigger_register_simple("ide-disk", &ide_led_trigger);
>         return driver_register(&idedisk_driver.gen_driver);

What does happen if driver_register() fails?

Bartlomiej
