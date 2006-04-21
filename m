Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWDUQkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDUQkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWDUQkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:40:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751248AbWDUQks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:40:48 -0400
Date: Fri, 21 Apr 2006 18:39:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
Message-ID: <20060421163930.GA1648@elf.ucw.cz>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz> <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > System suspends ok. Resume ok. but no disk access after that.
> > > 
> > > Not the same disk model, but I've been having similar trouble on a T43p.
> > 
> > Could you
> > 
> > 1) try if mdelay(2000) also helps?
> > 
> > 2) binary-search on drivers to see which one breaks it?
> 
> Thanks for looking into this.  But we already know mdelay(2000) works
> around it, and that the failure is "ata1: qc timeout (cmd 0xef)"
 > when

Aha, sorry, I was confused.

> trying to resume the SATA disk (in my case, don't know about Jeff's):
> so I'm confused as to what binary search to be doing.  I just tried
> backing out the time.c patch I sent originally, and substituting the
> patch below, much closer to the heart of the problem: that works too.
> This is with ata_piix, by the way; resuming from suspend to RAM.
> Do let me know what else to try if you've got an idea.

Not sure why it needs time. Waiting for disk to spin up?

Will it recover from the timeout? Would sticking ata_set_mode() at the
end of timeout routine help?
								Pavel


> --- 2.6.17-rc2/drivers/scsi/libata-core.c	2006-04-19 09:14:11.000000000 +0100
> +++ linux/drivers/scsi/libata-core.c	2006-04-21 13:19:54.000000000 +0100
> @@ -4287,6 +4287,7 @@ static int ata_start_drive(struct ata_po
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> +		mdelay(2000);
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);
>  	}

-- 
Thanks for all the (sleeping) penguins.
