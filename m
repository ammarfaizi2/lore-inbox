Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUCLHeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUCLHeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:34:14 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:51978 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262003AbUCLHeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:34:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] hdparm_X.patch (was: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE)
Date: Fri, 12 Mar 2004 09:24:03 +0200
X-Mailer: KMail [version 1.4]
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <200403120221.42082.vda@port.imtp.ilyichevsk.odessa.ua> <200403120202.06097.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403120202.06097.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403120924.03431.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch survived cyclic switching of all DMA modes from mwdma0 to
> > udma4 and continuous write load of type
> > while(1) { dd if=/dev/zero of=file bs=1M count=<RAM size>; sync; }
> > for five minutes.
> >
> > It does not handle crippled/simplex chipset, it is a TODO.
> >
> > Things commented by C++ style comments (//) aren't meant to stay.
> >
> > I think original code was a bit buggy:
> > set_transfer() returned 0 for modes < XFER_SW_DMA_0, ie,
> > for all PIO modes. Later,
> >        if (set_transfer(drive, &tfargs)) {
> >                xfer_rate = args[1];
> >                if (ide_ata66_check(drive, &tfargs))
> >                        goto abort;
> >         }
> >         err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3],
> > argbuf); if (!err && xfer_rate) {
> >                ide_set_xfer_rate(drive, xfer_rate);
> >                ide_driveid_update(drive);
> >        }
> > This will never execute ide_set_xfer_rate() for PIO modes
>
> It will also never execute ide_set_xfer_rate() for DMA on PIO only drive.
> I must check if "no PIO" thing is a bug or a design decision.

I think IDE driver will never ask for DMA on PIO only drive

Bartlomiej, do you have comments on my patch? So far, I myself spotted
some minor problems:

I forgot to remove now-extraneous if() from ide.c:

static int set_xfer_rate (ide_drive_t *drive, int arg)
{
        int err = ide_wait_cmd(drive,
                        WIN_SETFEATURES, (u8) arg,
                        SETFEATURES_XFER, 0, NULL);

        if (!err && arg) {
                ide_set_xfer_rate(drive, (u8) arg);
                ide_driveid_update(drive);
        }
        return err;
}

And second, in ide_do_drive_cmd(), mdelay(2000)
after WIN_SETFEATURES is a bit rude.
-- 
vda
