Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTECTTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTECTTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:19:44 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5623 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263397AbTECTTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:19:42 -0400
Date: Sat, 3 May 2003 21:31:55 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Reserving an ATA interface
In-Reply-To: <1051987179.7818.69.camel@gaston>
Message-ID: <Pine.SOL.4.30.0305032109390.10296-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 May 2003, Benjamin Herrenschmidt wrote:

> On Sat, 2003-05-03 at 19:21, Bartlomiej Zolnierkiewicz wrote:
>
> > > So my patch may actually fix some cases there too.
> >
> > No, look at ide_match_hwif() in setup-pci.c .
> > PCI grabs only ide_unknown interfaces.
>
> No, you missed my point.

You are right, sorry.

>  1) setup-pci claims a free hwif slot
>  2) the driver sets some custom IOPs (MMIO PCI interface for example)
>     and/or does other tweaks to hwif
>  3) no device is attached to this interface, the IDE probe code leaves
>     hwif->present to 0, but the hwif fields (IOps etc... are still
>     set by the PCI driver)
>  4) later on, ide-cs gets in, and picks that slot since hwif->present
>     is 0 and ide-cs doesn't care about chipset. However, those IOps
>     fields (and possibly other, DMA stuff etc...) are still those of
>     the PCI interface. If the PCI interface set it to MMIO for example,
>     boom !
>
> Note that I haven't actually tested the above scenario as I don't have
> a box with such PCI IDE interfaces, but it seems the problem I have
> with ide-pmac in this case is identical.

Yes, I was thinking about PCI IDE hwif and another PCI IDE hwif case.

> With my patch, since the PCI interface will not set the "hold" flag,
> ide_register_hw() called by ide-cs will call init_hwif_data(), thus
> putting back the hwif to a sane state

So every time you remove your disks from one of your PCI IDE controllers,
your ide-cs will get diffirent hwif and drives mappings and your RAID
on ide-cs won't be recognized ;-)

> > btw, I think the only real long-term solution for all ordering issues
> >      is customizable device mapper... 2.7?
>
> Or not relying on /dev/hdX entries for mounting ? (disk UUID etc..) ;)

Yep, this is what I mean :-) ie. devlabel.
+ adding kernel parameter like idedev_hdX=model,serial for recovery
--
Bartlomiej

