Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTJGNYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJGNYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:24:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62093 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262095AbTJGNYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:24:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Higdon <jeremy@SGI.COM>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Tue, 7 Oct 2003 15:27:56 +0200
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, gwh@SGI.COM, jbarnes@SGI.COM, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com> <200310041930.15385.bzolnier@elka.pw.edu.pl> <20031007082727.GA27934@sgi.com>
In-Reply-To: <20031007082727.GA27934@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310071527.56813.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 of October 2003 10:27, Jeremy Higdon wrote:
> Hello Bartlomiej,

Hi,

> I have a few questions.  I'm going to be submitting the rest
> of the patches that Aniket was working on, as he started at a new
> company today (he was attempting to finish the submission before he
> left).  Please forgive a lack of expertise on my part.

Okay.

> On Sat, Oct 04, 2003 at 07:30:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > +       return p - buffer;
> > > +}
> > >
> > > >Do you really need /proc/ide/sgiioc4?
> > > >You can print revision number during init.
> > >
> > > It has been helpful to be able to see the firmware revision num anytime
> > > during system operation.
> > > So the new patch still creates the above entry.
> >
> > I don't buy this, lspci can be used :-).
>
> lspci gives the version number.
> /proc/ide/sgiioc4 gives you:
>
>         SGI IOC4 Chipset rev 79.
>         Chipset has 1 IDE channel and supports 2 devices on that channel.
>         Chipset supports DMA in MultiMode-2 data transfer protocol.
>
> Is the # of IDE channels/devices and the DMA mode also available elsewhere?

Channels/devices is only available indirectly by /proc/ide/ device symlinks
and mate entry in (ie.) ide0 proc directory.  Controller DMA mode info is not
available.  However /proc/ide/sgiioc4 is useless for programs (parsing it to
obtain needed info is a really bad idea) and info for users should be provided
by drivers/ide/Kconfig (and optionally by init time message).

> > > +                                           int ddir);
> > > +static unsigned int __init pci_init_sgiioc4(struct pci_dev
> > > *dev,ide_pci_device_t *d);
> > >
> > > >Most of this declarations are not needed as sgiioc4.h is only included
> > > > from shiioc4.c.
> > >
> > > The sgiioc4.h file has been removed in the new patch.
> >
> > sgiioc4.h was removed, but declarations weren't.
> > You can shuffle code around to get rid of them.
>
> How important is this to you?  It seems more a style issue.  I agree with
> you, by the way.  When I write code, I try to minimize forward
> declarations. If I can get rid of some easily, will that be good enough?

Okay, I can clear the rest.

It is good for simplicity (people reading this code) and maintainability
(you don't have to update declaration if you change corresponding function).

> > There are no .enablebits on SGI IOC4?  Please add a comment about it.
>
> What are they used for (i.e. what are you looking for in the comment)?

It is mainly x86 thing (if channel is disabled in BIOS we don't probe it).
You can just put "/* SGI IOC4 doesn't have enablebits. */ somewhere.

> > sgiioc4_init_one():
> > +	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> > +	class_rev &= 0xff;
> >
> > Access to PCI devices before pci_enable_device()
> > (it is called later in pci_init_sgiioc4).
>
> Is pci_enable_device required before a config space access?

Yes, please read Documentation/pci.txt chapter 3.

> I will make changes in accordance with the other comments and based on
> your responses to this.

Thanks,
--bartlomiej

