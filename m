Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbULFWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbULFWpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULFWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:44:12 -0500
Received: from mail.prospeed.net ([12.46.111.140]:13575 "EHLO
	mail.prospeed.net") by vger.kernel.org with ESMTP id S261688AbULFWnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:43:50 -0500
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87acsrqval.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102349564.2721.103.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 06 Dec 2004 11:14:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#include "u.h"

can you give this header a more human friendly name ?

> +#include "if_aoe.h"
> +
> +#define VER 2
> +#define nil NULL

please just use NULL

> +#define nelem(A) (sizeof (A) / sizeof (A)[0])
> +#define AOE_MAJOR 152
> +#define ROOT_PATH "/dev/etherd/"

ehhhh device drivers really should be agnostic to device node paths!

> +typedef struct Bufq Bufq;
> +struct Bufq {
> +	Buf *head, *tail;
> +};

is there a good reason to not use list.h lists ??

> +struct Aoedev {
> +	Aoedev *next;
> +	uchar addr[6];		/* remote mac addr */
> +	ushort flags;
> +	ulong sysminor;
> +	ulong aoemajor;
> +	ulong aoeminor;

sounds like the wrong type, why not use dev_t ?

> +	ulong nopen;		/* user count */

why do you need this ?

> +static int
> +aoeblk_release(struct inode *inode, struct file *filp)
> +{
> +	Aoedev *d;
> +	ulong flags;
> +
> +	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
> +
> +	spin_lock_irqsave(&d->lock, flags);
> +	if (--d->nopen == 0)

eh why not just a ->release function instead that uses the blocklayer
refcounting instead of doing your own ?


> +int
> +aoeblk_make_request(request_queue_t *q, struct bio *bio)
> +{
> +	Aoedev *d;
> +	Buf *buf;
> +	struct sk_buff *sl;
> +	ulong flags;
> +
> +	blk_queue_bounce(q, &bio);
> +
> +	buf = kallocz(sizeof *buf, GFP_KERNEL);

this is deadlocky; you HAVE to use a mempool for allocations here!


