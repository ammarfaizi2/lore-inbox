Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVFUPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVFUPMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVFUPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:12:36 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32270 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262101AbVFUPKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:10:52 -0400
Date: Tue, 21 Jun 2005 16:10:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: PATCH: IDE - sensible probing for PCI systems
In-Reply-To: <1119363150.3325.151.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
 <1119363150.3325.151.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Alan Cox wrote:

> > > Old ISA/VESA systems sometimes put tertiary IDE controllers at addresses
> > > 0x1e8, 0x168, 0x1e0 or 0x160. Linux thus probes these addresses on x86
> > > systems. Unfortunately some PCI systems now use these addresses for
> > > other purposes which leads to users seeing minute plus hangs during boot
> > > or even crashes.
> > 
> >  Are these addresses visible in BARs?
> 
> Sometimes but often not. They tend to be below the PCI range used by the
> systems but belonging to onboard "magic"

 How is the range defined -- is there a way for us to find it?  I'd assume 
in the absence of a PCI-ISA or PCI-EISA bridge all I/O port addresses 
belong to PCI.  Otherwise the usual rule of "(addr & 0x300) == 0" applies.  
Perhaps with the addition of "(addr & ~0xff) != 0" for safety as junk I/O 
is often not recorded properly in BARs, sigh...

> >  FYI, for MIPS for machines with a PCI bus we only probe for ISA IDE ports 
> > on if there's a PCI-ISA or PCI-EISA bridge somewhere there.  This might be 
> > a good idea for the i386 and probably any platform using PCI as well.
> 
> The primary/secondary ISA ports show up in PC systems because of the PCI
> IDE class devices being in compatibility mode not native mode (so you
> can still run old OS's). There are also a couple of older weird cases.

 Certainly, but as long as they are seen as IDE devices on PCI, our driver 
can discover them and use without the need of probing through 
ide_default_io_base().

> The PCI layer code is smart enough to figure out when a PCI and an ISA
> probe find the same device and to put the entire thing together properly
> so that aspect of it is ok.

 Sure.

> For the 3rd and higher ports probing them isn't safe on a PCI box
> regardless of the presence of ISA bridges so I don't think we need the
> extra complexity - or am I missing something ?

 The code is OK with me, but I've been wondering whether a more general 
approach would be possible.  And poking blindly at any of these ports, 
including the "traditional" primary and secondary IDE interfaces, is 
unsafe if there is no legacy bridge in the system, because you either hit 
an innocent arbitrary device that happens to have a BAR configured for 
that range or get a master abort (I'm not sure what it results in for the 
i386 -- an NMI?) if nobody listens.

 Actually there should have always been a set of BARs for the (E)ISA in 
legacy bridges, which would have made the whole mess be avoided, sigh...

  Maciej
