Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUHPQFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUHPQFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUHPQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:03:04 -0400
Received: from the-village.bc.nu ([81.2.110.252]:34276 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267756AbUHPQAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:00:15 -0400
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20040816152816.GD10279@devserv.devel.redhat.com>
References: <20040815144527.GA7983@devserv.devel.redhat.com>
	 <200408161716.35922.bzolnier@elka.pw.edu.pl>
	 <20040816152816.GD10279@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092668252.20736.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 15:57:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/sOn Llu, 2004-08-16 at 16:28, Alan Cox wrote:
> On Mon, Aug 16, 2004 at 05:16:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This should be part of ITE driver patch and be compiled only when ITE driver 
> > is going to be used or even better - there should be new callback for that.
> 
> Nice theory but doesn't work that way. The ITE drive will do this even if
> you don't have the ITE driver compiled in because it'll be seen as the
> mainboard legacy controller (or generic) in some systems.

By way of more explanation here. The ITE chip does some interesting
things. Its got two modes. The first is a generic nodescript and 
slightly irritatingly designed IDE device. The second runs stuff via an
onboard microcontroller which can do stuff like fire transactions up on
both busses and then do the DMA to both at once.

The firmware when you have raid volumes fakes up identity blocks (badly)
and the device is IDE class and capable of being your main IDE
controller. In that situation even the generic PIO driver will 
see the RAID volumes and get confused by the ident blocks.

There is a second problem too resulting from this. Not only might the
IT8212 module not be loaded, but even if it is we probe the generic IDE
devices with the generic PIO and then attach the PCI driver on top of
it. That one can be dealt with by using a little bit of care but the
fact generic IDE sees them I think means it has to be in the generic ide
probe code. A later patch removes the geometry stuff as I fixed that
properly in ide-disk so it isn't needed now.

Alan

