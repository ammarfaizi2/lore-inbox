Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUEFKwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUEFKwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUEFKwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:52:34 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:51473 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262031AbUEFKwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:52:22 -0400
Date: Thu, 6 May 2004 11:52:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506115220.A14669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org> <20040506075044.GC12862@devserv.devel.redhat.com> <20040506085549.A13098@infradead.org> <20040506104638.GA9929@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040506104638.GA9929@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, May 06, 2004 at 12:46:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 12:46:38PM +0200, Arjan van de Ven wrote:
> Ok the following does the trick for me. Better?
> 
> diff -purN linux-2.6.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
> --- linux-2.6.5/drivers/ide/ide-disk.c	2004-05-06 10:56:55.672139712 +0200
> +++ linux/drivers/ide/ide-disk.c	2004-05-06 11:09:19.470065240 +0200
> @@ -1820,6 +1820,23 @@ static int idedisk_revalidate_disk(struc
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
> +	if (drive->media != ide_disk)
> +		return 0;
> +	printk("Flushing cache: %s \n", drive->name);
> +	ide_cacheflush_p(drive);
> +	/* give the hardware time to finish; it may return prematurely to cheat */
> +	mdelay(300);
> +	return 0;
> +}

Looks good to mz limited understanding of the ide code :)

>  static struct block_device_operations idedisk_ops = {
>  	.owner		= THIS_MODULE,
>  	.open		= idedisk_open,
> @@ -1881,6 +1898,7 @@ static void __exit idedisk_exit (void)
>  
>  static int idedisk_init (void)
>  {
> +	idedisk_driver.gen_driver.shutdown = ide_drive_shutdown;

isn't idedisk_driver initialized statically somewhere?  You should probably
add

	.gen_driver = {
		.shutdown	= ide_drive_shutdown,
	},

to that initializer instead.

