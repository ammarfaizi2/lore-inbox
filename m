Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTECS1k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTECS1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:27:40 -0400
Received: from AMarseille-201-1-2-221.abo.wanadoo.fr ([193.253.217.221]:13864
	"EHLO gaston") by vger.kernel.org with ESMTP id S263358AbTECS1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:27:39 -0400
Subject: Re: Reserving an ATA interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305031912510.10296-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305031912510.10296-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051987179.7818.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 May 2003 20:39:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-03 at 19:21, Bartlomiej Zolnierkiewicz wrote:


> >
> > So my patch may actually fix some cases there too.
> 
> No, look at ide_match_hwif() in setup-pci.c .
> PCI grabs only ide_unknown interfaces.

No, you missed my point.

 1) setup-pci claims a free hwif slot
 2) the driver sets some custom IOPs (MMIO PCI interface for example)
    and/or does other tweaks to hwif
 3) no device is attached to this interface, the IDE probe code leaves
    hwif->present to 0, but the hwif fields (IOps etc... are still
    set by the PCI driver)
 4) later on, ide-cs gets in, and picks that slot since hwif->present
    is 0 and ide-cs doesn't care about chipset. However, those IOps
    fields (and possibly other, DMA stuff etc...) are still those of
    the PCI interface. If the PCI interface set it to MMIO for example,
    boom !

Note that I haven't actually tested the above scenario as I don't have
a box with such PCI IDE interfaces, but it seems the problem I have
with ide-pmac in this case is identical.

With my patch, since the PCI interface will not set the "hold" flag,
ide_register_hw() called by ide-cs will call init_hwif_data(), thus
putting back the hwif to a sane state  

> btw, I think the only real long-term solution for all ordering issues
>      is customizable device mapper... 2.7?

Or not relying on /dev/hdX entries for mounting ? (disk UUID etc..) ;)

