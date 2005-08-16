Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVHPUQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVHPUQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVHPUQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:16:13 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:53571 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932694AbVHPUQL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:16:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SWNLkE/mqDVxnH9qFipFnSy3fgQE7yjtWiaOkNnFflQ9v9mF2uVWc63tNx8gdpd4WOlpHCQj2HhRknN7fjBjem4M2izXvOhBaUrlHvojHG/rF/qeEIAP2HJLVmKkkNQCtwEBCmYbP567w8PoY31WRldOZRjva4E8fAjb8rhmrTA=
Message-ID: <58cb370e05081613164027070@mail.gmail.com>
Date: Tue, 16 Aug 2005 22:16:09 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <200508161316.32602.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <200508161316.32602.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Tuesday 16 August 2005 3:38 am, Bartlomiej Zolnierkiewicz wrote:
> > On 8/15/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > On Friday 12 August 2005 2:40 am, Alan Cox wrote:
> > Agreed but I have few comments:
> > * is this change OK w.r.t. IA64_HP_SIM?
> 
> Kernels for the HP simulator (ski) use a SCSI model, not IDE,
> so they should be OK.
> 
> The SGI simulator *does* use IDE, and this will break that.  But
> my friends at SGI are looking at exposing the simulated IDE device
> via PCI, which should fix it.

OK

> > * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
> >   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)
> 
> PCMCIA might be of theoretical interest, but not important enough
> by itself to keep IDE_ARCH_OBSOLETE_INIT, IMHO.  And it sounds like
> ide-cs can be fixed fairly easily to not depend on it.

Yes, ide-cs needs fixing anyway.

> >   * ordering change for ide-pnp interfaces in case of no IDE devices
> >     on default IDE PCI ports, (but there aren't any ide-pnp devices on IA64?)
> 
> I'm not aware of any ide-pnp devices on IA64, so I don't think this
> is a problem for us.  The SGI simulator could use ide-pnp via
> PNPACPI, but ordering shouldn't be a problem there.

OK

> But it is interesting that PNP IDE devices are discovered *after*
> PCI devices.  For serial, we do PNP before PCI, on the theory that
> PNP devices are usually built-in and shouldn't move if you just plug
> in a new PCI card.
> 
> >   * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)
> 
> HDIO_SCAN_HWIF - I don't know about this one.  How are we supposed to
> follow the "new ports shouldn't define IDE_ARCH_OBSOLETE_INIT" injunction
> if we lose all this functionality without it?  ia64 is about as close to
> a new port as you get :-)

* new legacy style interfaces cannot be registered from user-space
  (but they still can be using kernel parameter)
* non-working coldplug support
  (I'm working on sysfs interface for that)

> > This changes default default MAX_HWIFS value from
> > 10 (6 in case of !CONFIG_PCI) to 4 which is not desirable.
> >
> > IMO the best thing for now is to leave MAX_HWIFS alone.
> 
> IDE on ia64 is little-used, so I'm OK with leaving it alone, but
> I do think it's wrong for an architecture with no real restriction
> to specify MAX_HWIFS in ide.h.  Better to have the config option,
> and make the default there larger if necessary.
> 
> > > I noticed that on a box with no devices on ide1, we probed
> > > ide1 twice -- once via ide_setup_pci_device() and again via
> > > ide_generic_init().  This isn't fatal, since the generic probe
> > > uses the I/O ports setup by PCI IDE, but it's unnecessary
> > > and a bit ugly.
> > >
> > > I stuck in a "hwif->noprobe = 1" at the point where probe_hwif()
> > > decides the interface isn't present, which prevents the second
> > > probe by ide_generic_init().
> >
> > Please separate this change out - it is a nice fix but it affects other
> > archs/drivers and somebody needs to audit all IDE host drivers that
> > they set hwif->noprobe = 0 correctly before probing in case of re-using
> > hwif that was already owned/probed by other driver.
> 
> OK, I'll split this and look into it a bit more.

Thanks.

> > Please make IDE_GENERIC depend on !IA_64.
> 
> Huh?  The first patch I posted did exactly that, nothing more.  But
> Alan pointed out that I should instead clean up asm-ia64/ide.h, which
> I think leads to a nicer solution.

Both changes are nice :-)

Thanks,
Bartlomiej
