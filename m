Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVCBQPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVCBQPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVCBQPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:15:17 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:24280 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262346AbVCBQPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:15:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NUyGz1F09I9h7p4TawdoQmG0aNaEI4kQuY6bI+ZrgPSxc1oppztjfyD3f9vm4/tLSukXvS68fMda1pXlJLhgykqFyhkB5by4m7UmxISJpVHDiOOxmwSLhb4ysP1WNaBfxXN6C+5pTzLpCYfDevCIjKoOydNg+vcyjboaBRwmSsA=
Message-ID: <58cb370e050302081532b21cd@mail.gmail.com>
Date: Wed, 2 Mar 2005 17:15:00 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050301164952.GA22499@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083809.63BF53E6@htj.dyndns.org>
	 <58cb370e05022407587e86f8ad@mail.gmail.com>
	 <20050227064922.GA27728@htj.dyndns.org>
	 <58cb370e050301063069799c75@mail.gmail.com>
	 <20050301164952.GA22499@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 01:49:52 +0900, Tejun Heo <htejun@gmail.com> wrote:
>  Hello, Bartlomiej.
> 
> On Tue, Mar 01, 2005 at 03:30:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sun, 27 Feb 2005 15:49:22 +0900, Tejun Heo <htejun@gmail.com> wrote:
> > >
> > >  Taskfile DMA path is still broken.  Also calling ide_end_request()
> > > will work there, but IMHO it's just cleaner to finish special commands
> > > inside ide_end_drive_cmd().  Currently,
> >
> > I agree but please note that your patch makes *all* taskfile registers to
> > be exposed through HDIO_DRIVE_TASKFILE regardless of ->rf_in_flags
> > (and obviously later you can't revert this change).
> >
> > >  * Successful flagged taskfile                  -> ide_end_drive_cmd()
> > >  * All other successful non-DMA special cmds    -> ide_end_request()
> > >  * Successful DMA taskfile                      -> segfault
> >
> > Have you tested it?  Why would it segfault?
> >
> 
>  It's the same reason why PIO taskfiles were broken.  rq->rq_disk is
> NULL for taskfile requests.
> 
> ide_startstop_t ide_dma_intr (ide_drive_t *drive)
> {
> ...
>                         printk("**HERE0***\n");
>                         drv = *(ide_driver_t **)rq->rq_disk->private_data;;
>                         printk("**HERE1***\n");
>                         drv->end_request(drive, 1, rq->nr_sectors);
>                         return ide_stopped;
> ...
> }

Arghh, indeed I forgot about HDIO_DRIVE_TASKFILE here.

Could you fix to check if (drv == NULL) and call
ide_end_request() it the condition is true?
