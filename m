Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUEFMxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUEFMxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUEFMwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:52:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31675 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261718AbUEFMwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:52:10 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Force IDE cache flush on shutdown
Date: Thu, 6 May 2004 14:36:58 +0200
User-Agent: KMail/1.5.3
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506115220.A14669@infradead.org> <20040506113309.GB16548@devserv.devel.redhat.com>
In-Reply-To: <20040506113309.GB16548@devserv.devel.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405061436.58692.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 of May 2004 13:33, Arjan van de Ven wrote:
> On Thu, May 06, 2004 at 11:52:20AM +0100, Christoph Hellwig wrote:
> > > +	idedisk_driver.gen_driver.shutdown = ide_drive_shutdown;
> >
> > isn't idedisk_driver initialized statically somewhere?  You should
> > probably
>
> ok ok you win
>
> diff -purN linux-2.6.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
> --- linux-2.6.5/drivers/ide/ide-disk.c	2004-05-06 13:26:53.350284720 +0200
> +++ linux/drivers/ide/ide-disk.c	2004-05-06 13:32:01.322465832 +0200
> @@ -1725,6 +1725,9 @@ static ide_driver_t idedisk_driver = {
>  	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
>  	.start_power_step	= idedisk_start_power_step,
>  	.complete_power_step	= idedisk_complete_power_step,
> +	.gen_driver = {
> +		.shutdown	= ide_drive_shutdown,
> +	},
>  };
>
> @@ -1820,6 +1823,23 @@ static int idedisk_revalidate_disk(struc
>  	return 0;
>  }
>
> +static int ide_drive_shutdown(struct device * dev)
> +{
> +	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
> +
> +	/* safety checks */
> +	if (!drive->present)
> +		return 0;

not needed / BUG_ON

> +	if (drive->media != ide_disk)
> +		return 0;

not needed / BUG_ON

> +	printk("Flushing cache: %s \n", drive->name);
> +	ide_cacheflush_p(drive);
> +	/* give the hardware time to finish; it may return prematurely to cheat
> */ +	mdelay(300);

I really don't like it.

Is this delay arbitrary or you know about such devices?

> +	return 0;
> +}
> +
> +
>  static struct block_device_operations idedisk_ops = {
>  	.owner		= THIS_MODULE,
>  	.open		= idedisk_open,

