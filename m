Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbTL3LOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbTL3LOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:14:40 -0500
Received: from intra.cyclades.com ([64.186.161.6]:6071 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265753AbTL3LOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:14:31 -0500
Date: Tue, 30 Dec 2003 09:10:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: PATCH: IDE: no DRQ after issuing WRITE (fwd)
In-Reply-To: <200312182153.50552.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.58L.0312300909230.22101@logos.cnet>
References: <Pine.LNX.4.44.0312181134050.4547-100000@logos.cnet>
 <200312182153.50552.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart, Andrew,

The above patch is required to fix a "race" in ide_wait_stat().

It doesnt seem to be in 2.6 yet.

On Thu, 18 Dec 2003, Bartlomiej Zolnierkiewicz wrote:

>
> Thanks Marcelo.  Patch looks okay.
>
> On Thursday 18 of December 2003 14:34, Marcelo Tosatti wrote:
> > FYI
> >
> > ---------- Forwarded message ----------
> > Date: Mon, 15 Dec 2003 20:02:08 +0100
> > From: Daniel Tram Lux <daniel@starbattle.com>
> > To: linux-kernel@vger.kernel.org
> > Subject: [2.4.23][patch]no DRQ after issuing WRITE
> >
> > Hi,
> >
> > basically same patch as for 2.6.0-test 11
> >
> > against following problem:
> >
> > hda: no DRQ after issuing WRITE
> > ide0: reset: success
> > hda: status timeout: status=0xd0 { Busy }
> >
> > Regards
> > Daniel Lux
> >
> > --- linux-2.4.23.org/drivers/ide/ide-iops.c     2003-12-15
> > 14:32:39.000000000 +0100 +++ linux-2.4.23/drivers/ide/ide-iops.c 2003-12-15
> > 19:55:33.000000000 +0100 @@ -664,12 +664,22 @@
> >         if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
> >                 local_irq_set(flags);
> >                 timeout += jiffies;
> > -               while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
> > +               stat = hwif->INB(IDE_STATUS_REG);
> > +               while (stat & BUSY_STAT) {
> >                         if (time_after(jiffies, timeout)) {
> > -                               local_irq_restore(flags);
> > -                               *startstop = DRIVER(drive)->error(drive,
> > "status timeout", stat); -                               return 1;
> > +                               /*
> > +                                * do one more status read in case we were
> > interrupted between last +                                * stat =
> > hwif->INB(IDE_STATUS_REG) and time_after(jiffies, timeout) +
> >                 * in wich case the timeout might have been shorter than
> > specified. +                                */
> > +                               if ((stat = hwif->INB(IDE_STATUS_REG)) &
> > BUSY_STAT) { +
> > local_irq_restore(flags);
> > +                                       *startstop =
> > DRIVER(drive)->error(drive, "status timeout", stat); +
> >                  return 1;
> > +                               }
> >                         }
> > +                       else
> > +                               stat = hwif->INB(IDE_STATUS_REG);
> >                 }
> >                 local_irq_restore(flags);
> >         }
>
