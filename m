Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVCUM3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVCUM3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 07:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVCUM3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 07:29:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:18411 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261767AbVCUM3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 07:29:34 -0500
Subject: Re: [PATCH] alpha build fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0503210145375f5092@mail.gmail.com>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net>
	 <20050319231641.GA28070@havoc.gtf.org>
	 <58cb370e0503210005358cf200@mail.gmail.com>
	 <20050321121616.A24129@jurassic.park.msu.ru>
	 <58cb370e0503210145375f5092@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 23:27:39 +1100
Message-Id: <1111408059.25180.277.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Then isn't linux/ide.h the proper place for default pci_get_legacy_ide_irq()
> 
> ide.h is not shared between IDE and libata drivers (but ata.h is)
> 
> > implementation instead of asm-generic/pci.h? The latter is only used by
> > 7 out of 23 architectures, so not only alpha gets broken.


I'm not sure what the original problem is with alpha, but I added this
call to remove the hard coding of irq numbers in various drivers that
"find" the chip in legacy mode. Instead, I give the arch the opportunity
to provide the actual irq numbers in that case.

IRQs on IDE in legacy mode is sort of an out-of-spec piece of junk that
was invented to make PCI based peecees "look like" good old rotten
hardware, unfortunately, some modern and non-x86 HW vendors still don't
haev a clue and configure (wire in some case) their on board IDE in
legacy mode, but with IRQs that, on those archs, aren't 14 and 15. That
hook fixes the problem on some ppc64 machines but should be extended to
cover various other cases where similar shit happens.

It's in PCI because I figured it was as bad there than anywhere else. In
this case, it's the IDE layer asking the PCI layer "hey, that guy
doesn't respect the normal PCI IRQ mapping, can you tell me how it's
routed ?" :) Back then, I didn't know of a header shared between ide and
libata so I put it there.

Ben.


