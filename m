Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264521AbTCYUOO>; Tue, 25 Mar 2003 15:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbTCYUOO>; Tue, 25 Mar 2003 15:14:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8643 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S264521AbTCYUOL>; Tue, 25 Mar 2003 15:14:11 -0500
Date: Tue, 25 Mar 2003 21:24:53 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alexander Atanasov <alex@ssi.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux@brodo.de>, <linux-kernel@vger.kernel.org>
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
 looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
In-Reply-To: <Pine.SOL.4.30.0303252054510.17346-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303252123490.17346-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Mar 2003, Bartlomiej Zolnierkiewicz wrote:

>
> On Mon, 24 Mar 2003, Alexander Atanasov wrote:
> > 	Hello, Alan!
> >
> > On 24 Mar 2003 17:40:08 +0000
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > > On Mon, 2003-03-24 at 16:01, Alexander Atanasov wrote:
> > > > 	I don't understand, what's the difference and how the list is
> > > > 	lost?
> > > > ata_unused used to hold all drives that were not claimed by any
> > > > driver, now idedefault_driver claims all that drives, all drives go
> > > > in the .list
> > >
> > > ata_unused -> unattached device slots, new hotplug discoveries
> >
> > 	Ok.
> >
> > > idedefault_driver -> attached/known devices with no driver
> > > other list -> driven by that driver
> > >
> > > > The bug is there,  and waiting to explode, keeping both lists would
> > > > mean to add one more  list head  in ide_drive_t,  is that the fix
> > > > you want?
> > >
> > > I don't see where stuff is ending up on both lists yet. I've not had
> > > time to look hard at it though
> > >
> >
> > 	It happens this way:
> > 	ide_register_driver -> ata_attach -> idedefault_driver.attach -> ide_register_subdriver -> list_add(&driver->list, &driver->drives) ->
> > return to ata_attach -> list_add_tail(&drive->list, &ata_unused);
>
> Exactly.
>
> Alan, if we want to keep ata_unused, we should remove
> list_add_tail(%drive->list, &ata_unused) from ata_attach()
> and perhaps use (after fixing it to handle idedefault_driver)
> ide_replace_subdriver() for driver switching for drives owned
> by idedefault_driver.
>
> BTW in ide_register_driver() we don't use ide_drives lock to protect
>     drive->list changes, why?

drives_lock lock of course, writing from memory :-)

>
> --
> bzolnier
>
> > --
> > have fun,
> > alex

