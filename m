Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTECQsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTECQsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:48:12 -0400
Received: from AMarseille-201-1-2-221.abo.wanadoo.fr ([193.253.217.221]:5928
	"EHLO gaston") by vger.kernel.org with ESMTP id S263350AbTECQsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:48:10 -0400
Subject: Re: Reserving an ATA interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305031805170.10296-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305031805170.10296-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051981168.4107.58.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 May 2003 18:59:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yesterday I was thinking about:
> - default arch hwifs, added/probed in ide_init_defult_hwifs() if no
>   IDE PCI/PCI (depends on arch, should be IDE PCI?) support is compiled in
> - PCI hwifs
> - legacy hwifs probed in ide_setup()
> - legacy hwifs probed after PCI
> and about ide_register_hw() + initializing flag.
> 
> What a mess... ordering issues can make you crazy.

Yup, I'd suggest we think about re-writing all that stuff for 2.7 :)
 
> > The simplest solution I have in mind is to add an hwif flag,
> > called "hold" (or whatever better name you find). Drivers like
> > ide/ppc/pmac.c would set this flag for the "hotswap" media bay
> > interface, and not for others.
> 
> This change is obviously correct and it doesn't have influence on
> any existing code.
> 
> > The only change to the core code would then be for ide_register_hw
> > to 'skip' those when searching for an available slot, and to call
> > init_hwif_data when (!hwif->present && !hwif->hold) to handle case 2
> > where the iops & other hwif fields (mmio among others) need to be
> > reset to initial/legacy state.
> 
> Less safe change but also okay, as callers .
> btw, Can't "ghost ides" be dealed inside ppc specific code?
>      Do you know when interface is valid and when it is "ghost",
>      and what other OS-es do in this case?

Not re-using the slot for an interface with the "hold" bit won't
affect anybody but setters of that bit, so we are ok. The act of
calling init_hwif_data when !present && !hold is the one bringing
a possible change of behaviour to existing code.

However, who calls ide_register_hw() dynamically ? ide-cs and ?
I don't think there would much harm in re-calling init_hwif_data
at this point since hwif->present is not set, we _are_ re-using
the hwif, wether it was previously initialized or not by somebody
else. In this case, we really want to "clean" it, don't we ?

Right now, the only problem with re-initializing this way that
I've found is with hotswap interfaces like ide-pmac, because
they will have preset special MMIO ops etc... and that call
would revert that pre-setting. That's exactly why such interfaces
should set the "hold" bit to "reserve" the hwif slot. You see
the point ? I don't think there are much drivers aroung playing
with such tricks though.

All I can do within ide pmac itself is set or not that "hold"
bit for those interfaces. I just need to set it on the hotswap
ones (wthr they have devices connected or not) that way they
stay around "reserved" for when a device gets plugged. Other
"fixed" interfaces will have hwif->present cleared automatically
by the probe code, and thus will be "freed" for other uses, if
they don't have any device attached.
(Which is why that init_hwif_data is needed to reset their hwif
to something good default, and not whatever ide pmac have set).

In 2.5, I can be slightly smarted since I'm calling the probe
myself and no longer rely on the automatic initial probe done
by the IDE layer, like for PCI devices, so I can actually 
"clear" those "empty" interfaces myself after they are probed.
But still, it makes sense to have this "hold" flag to let a
hotswap interface reserve a slot, and it makes sense when the
interface isn't held by anybody to "clean it up" before giving
it to somebody else.

The only problem I see right now is for a dynamic interface
(like ide-cs) where the _controller_ itself is hotswap, so
the hwif slot cannot be reserved in advance _and_ that interface
needs special IOps (which is fortunately not the case of ide-cs)

Such an interface can't really know what slot will be
picked by ide_register_hw() and can't "prepare" the HWIF with
special iops, so it won't be much harmed by the fact we are
calling init_hwif_data, but still, we should ultimately think
about splitting completely the fact of allocating an hwif slot,
setting it up, and triggering a probe on it. Those are 3 different
things that are currently mixed in bad ways. I don't beleive
fixing that fits in the 2.6 timeframe though.

Ben.
