Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272635AbTHEKuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272634AbTHEKuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:50:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62201 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272635AbTHEKuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:50:10 -0400
Date: Tue, 5 Aug 2003 12:49:42 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking problem
In-Reply-To: <1060070884.615.47.camel@gaston>
Message-ID: <Pine.SOL.4.30.0308051236250.552-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Aug 2003, Benjamin Herrenschmidt wrote:

> On Tue, 2003-08-05 at 02:28, Bartlomiej Zolnierkiewicz wrote:
> > On 3 Aug 2003, Benjamin Herrenschmidt wrote:
> >
> > > And there's more to it... ide_unregister() doesn't copy hwif->hold from
> > > old to new hwif causing my hotswap bay to lose it's iops on next plug,
> > > it doesn't call unregister_device() for neither hwif->gendev nor
> > > drive[n]->gendev, causing the device model list to be corrupted after
> > > an unregister, ...
> >
> > What is a goal of calling init_hwif_data() in ide_unregister()?
> > I guess it is used mainly to clear hwif->io_ports and hwif->irq.
> > Therefore even if you are using hwif->hold flag io_ports will be set to
> > default values, so how do you later find your hwif?
>
> What is the goal ? good question ;) I'd be happy with removing most
> of the junk in init_hwif_data, but we need to go a bit further there
> for 2.7, maybe we should discuss that one irc one of these days ;)
> We probably want to remove the static array of hwifs and change that
> into pointers, hwif themselves beeing fully initialized 'offline' by
> the host driver, then handed out to the ide layer...

Yes, plus adding HBA structure.

> In the meantime, the current code works because init_hwif_data()
> calls ide_init_hwif_ports() which is an arch hook, which will fill
> the proper io base, so the hwif can still be found. Since the IOps

It only works with default/legacy io bases.

> themselves are saved/restored in ide_unregister, we end up with
> proper IO base and proper IOps still there.
> In fact, I suspect the only remaining useful thing done by
> init_hwif_date() in there is to clear the drive structures.
>
> > Hmmm... what about not copying anything and calling init_hwif_data()
> > only if !hwif->hold?
>
> We may probably still want to clear the drive array and maybe a
> the present flag, no ?

Oh yes, this is the main goal if ide_unregister() :-).

> Also, look at my patch, we also _NEED_ to add some proper
> device_unregister calls to ide_unregister() or this function will
> leave dangling entries in the device list, and since those have the
> same restrictions as the new blk_cleanup_queue(), we really need to
> do that without the lock held.

Yes.

> I'd suggest merging my patch for now, it won't make things much
> worse than what they are today regarding racyness of IDE registration
> and unregistration, we an look into sanitizing this as a 2.7 goal.

Okay :\.

--
Bartlomiej

