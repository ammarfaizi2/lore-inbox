Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUADG2U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 01:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUADG2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 01:28:19 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:14720 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S264410AbUADG2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 01:28:13 -0500
Date: Sun, 4 Jan 2004 17:31:29 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules
 (linux 2.6.0)
Message-Id: <20040104173129.60cde487.davmac@ozonline.com.au>
In-Reply-To: <200401040452.17659.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401040256.57419.bzolnier@elka.pw.edu.pl>
	<20040104142141.2bf4f230.davmac@ozonline.com.au>
	<200401040452.17659.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'm resending this as I forgot to CC: it to the lists.

On Sun, 4 Jan 2004 04:52:17 +0100
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> > 1) unless "idex=base,ctl,irq" is used, the hwif->chipset is left as
> > "ide_unknown" (this means for that the hwif can get re-allocated in
> > setup-pci.c - ide_match_hwif() - and clobbered)
> 
> Hmm.  What if hwif is freed by a driver?

I don't think I'm really sure what you're asking. (which driver frees hwif? why is it a problem? I see a "ide_unregister" call, it resets the hwif to default state - this should be fine.

> > What about this is a solution to these problems:
> >  - set hwif->chipset to "ide_generic" instead of leaving it as
> > "ide_unknown" (ide-probe.c); - if ide_match_hwif() returns an already
> > allocated hwif, do not clobber it in ide_hwif_configure() (setup-pci.c)
>
> This brakes "idex=base..." parameters for PCI chipsets.
> They shouldn't be needed in this case, but...

As far as i can see "idex=base.." is broken for PCI chipsets anyway- if the detected PCI base doesn't match the forced one, the PCI will be allocated a seperate hwif (ie as a seperate ideX) anyway. So you can't force the base port of a PCI-chipset controller.

Do you mean that, if "idex=base..." is give, and the base is correct for the PCI device, then it should work ok? If so it seems the easiest way to fix it is to introduce another dummy chipset type (lets say "ide_generic_forced") which is set (instead of ide_generic) when "idex=.." is parsed. Then check for this in ide_hwif_configure(). Would also need to modify ide_match_hwif() (so it returns a match for "ide_generic_forced" as well as for "ide_generic") and ide_probe_init() would have to change "ide_generic_force" to "ide_generic" (to handle the case that no PCI chipset took control).

So we handle these situations:
- idex=... specified and no PCI chipset
- idex=... specified and PCI chipset present
- PCI chipset module loaded after ide initialization complete

Does that sound ok? If so I will write another patch.

Davin
