Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUCLAyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUCLAyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:54:15 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1937 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261875AbUCLAyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:54:04 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] hdparm_X.patch (was: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE)
Date: Fri, 12 Mar 2004 02:02:06 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <4050A913.50809@pobox.com> <200403120221.42082.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200403120221.42082.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403120202.06097.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 of March 2004 01:21, Denis Vlasenko wrote:
> On Thursday 11 March 2004 19:59, Jeff Garzik wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday 11 of March 2004 15:48, Jens Axboe wrote:
> > >>On Thu, Mar 11 2004, Bartlomiej Zolnierkiewicz wrote:
> > >>>On Thursday 11 of March 2004 15:14, Denis Vlasenko wrote:
> > >>>>I discovered that hdparm -X <mode> /dev/hda can lock up IDE
> > >>>>interface if there is some activity.
> > >>>
> > >>>Known bug and is on TODO but fixing it ain't easy.
> > >>>Thanks for a report anyway.
> > >>
> > >>Wouldn't it be possible to do the stuff that needs serializing from the
> > >>end_request() part and get automatic synchronization with normal
> > >>requests?
> > >
> > > That's the way to do it (REQ_SPECIAL) but unfortunately on some
> > > chipsets we need to synchronize both channels (whereas we don't need to
> > > serialize normal operations).
> >
> > blk_stop_queue() on all queues attached to the hardware?
> >
> > You need to synchronize anyway for the rare hardware that reports itself
> > as "simplex" -- one DMA engine for both channels.
>
> This patch survived cyclic switching of all DMA modes from mwdma0 to udma4
> and continuous write load of type
> while(1) { dd if=/dev/zero of=file bs=1M count=<RAM size>; sync; }
> for five minutes.
>
> It does not handle crippled/simplex chipset, it is a TODO.
>
> Things commented by C++ style comments (//) aren't meant to stay.
>
> I think original code was a bit buggy:
> set_transfer() returned 0 for modes < XFER_SW_DMA_0, ie,
> for all PIO modes. Later,
>        if (set_transfer(drive, &tfargs)) {
>                xfer_rate = args[1];
>                if (ide_ata66_check(drive, &tfargs))
>                        goto abort;
>         }
>         err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3],
> argbuf); if (!err && xfer_rate) {
>                ide_set_xfer_rate(drive, xfer_rate);
>                ide_driveid_update(drive);
>        }
> This will never execute ide_set_xfer_rate() for PIO modes

It will also never execute ide_set_xfer_rate() for DMA on PIO only drive.
I must check if "no PIO" thing is a bug or a design decision.

Thanks,
Bartlomiej


