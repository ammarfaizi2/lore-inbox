Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbTAORrV>; Wed, 15 Jan 2003 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbTAORrV>; Wed, 15 Jan 2003 12:47:21 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:53009 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266848AbTAORrT>; Wed, 15 Jan 2003 12:47:19 -0500
Message-ID: <3E258DA5.4BB14A41@linux-m68k.org>
Date: Wed, 15 Jan 2003 17:34:45 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH] Proposed module init race fix.
References: <20030115082444.13D1A2C128@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17886-linux-2.5-bk/drivers/block/genhd.c .17886-linux-2.5-bk.updated/drivers/block/genhd.c
> --- .17886-linux-2.5-bk/drivers/block/genhd.c   2003-01-13 16:56:23.000000000 +1100
> +++ .17886-linux-2.5-bk.updated/drivers/block/genhd.c   2003-01-13 22:58:07.000000000 +1100
> @@ -104,10 +104,13 @@ static int exact_lock(dev_t dev, void *d
>   * @gp: per-device partitioning information
>   *
>   * This function registers the partitioning information in @gp
> - * with the kernel.
> + * with the kernel.  Your init function MUST NOT FAIL after this.
>   */
>  void add_disk(struct gendisk *disk)
>  {
> +       /* It needs to be accessible so we can read partitions. */
> +       make_module_live(disk->fops->owner);
> +

After this the module can be removed without problems.

>         disk->flags |= GENHD_FL_UP;
>         blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
>                         NULL, exact_match, exact_lock, disk);

blk_register_region() allocates memory, which can fail?

bye, Roman


