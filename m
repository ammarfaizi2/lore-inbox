Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULHJxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULHJxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULHJxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:53:22 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:49493 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261172AbULHJxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:53:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=agBhqxIrpBhmkLv7fg7qFQTiAayaldIPZ2B/m+9W/jABcySbtjq3s10P2o6a1lp1HHyMVckqx5OcEIsJ8sEo8AJz++FF9kJxfCNtvZsBSchcPjCevrs1mh6MIgb1hf2xeR64EVZQmb5EQDcFsoKZGyY9jgm+zbMQBIeUgJi3nIQ=
Message-ID: <84144f0204120801534470153c@mail.gmail.com>
Date: Wed, 8 Dec 2004 11:53:09 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87acsrqval.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <87acsrqval.fsf@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,

Few comments below.

On Mon, 06 Dec 2004 10:51:46 -0500, Ed L Cashin <ecashin@coraid.com> wrote:
> diff -urpN linux-2.6.9/drivers/block/aoe/all.h linux-2.6.9-aoe/drivers/block/aoe/all.h
> --- linux-2.6.9/drivers/block/aoe/all.h 1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/all.h     2004-12-06 10:40:00.000000000 -0500

How about calling this aoe.h or similar?

> @@ -0,0 +1,156 @@
> +#include <linux/ctype.h>
> +#include <linux/string.h>
> +#include <linux/hdreg.h>
> +#include <linux/blkdev.h>
> +#include <linux/types.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/blkpg.h>
> +#include <linux/slab.h>
> +#include <linux/skbuff.h>
> +#include <linux/ioctl.h>
> +#include <linux/if.h>
> +#include <linux/netdevice.h>
> +#include <linux/kdev_t.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/poll.h>
> +#include <linux/timer.h>
> +#include <linux/genhd.h>
> +#include <asm/uaccess.h>
> +#include <asm/namei.h>
> +#include <asm/semaphore.h>

This looks wrong. I don't see you using, for example, semaphores
everywhere you include this header. Please just move these includes to
the appropriate .c files.

> +enum {
> +       DEVFL_UP = 1,           /* device is installed in system and ready for AoE->ATA commands */
> +       DEVFL_TKILL = (1<<1),   /* flag for timer to know when to kill self */
> +       DEVFL_EXT = (1<<2),     /* device accepts lba48 commands */
> +       DEVFL_CLOSEWAIT = (1<<3),       /* device is waiting for all closes to revalidate */
> +       DEVFL_WC_UPDATE = (1<<4),       /* this device needs to update write cache status */
> +       DEVFL_WORKON = (1<<4),
> +
> +       BUFFL_FAIL = 1,
> +
> +       MAXATADATA = 1024,
> +       NPERSHELF = 10,
> +       FREETAG = -1,
> +};

Perhaps it would be cleaner if you kept DEVFL flags in separate enum
block as they're related and have nothing to do with the rest?

> +typedef struct Buf Buf;
> +struct Buf {

Please don't introduce typedefs for structs. Furthermore, please make
the struct name start with a lower case letter like the rest of the
kernel.

> diff -urpN linux-2.6.9/drivers/block/aoe/aoeblk.c linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c
> --- linux-2.6.9/drivers/block/aoe/aoeblk.c      1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c  2004-12-06 10:40:00.000000000 -0500
> +static int
> +aoeblk_open(struct inode *inode, struct file *filp)
> +{
> +       Aoedev *d;
> +       ulong flags;
> +
> +       d = (Aoedev *) inode->i_bdev->bd_disk->private_data;

Please remove the redundant casts when converting from a void pointer.
The conversion is guaranteed by the C standard.

                               Pekka
