Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVACW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVACW3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVACW1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:27:07 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:14380 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261940AbVACWWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:22:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=huRd3ilRv3/kb5lyOP4InW0S6DeTIbRsRSS4O9Xi7AUEmbNP2hOT0rKnq/P726IhTOUFK+mVx0quYQO9y8bQdoVxUSc7d7LONM2Epp87h1B9bdRt6dMSD8OivFl1a4iKlCeT74EUuYAoqvFbLArF6vffnqrHiqgAYjVPkthKyuw=
Message-ID: <58cb370e050103142269e1f67f@mail.gmail.com>
Date: Mon, 3 Jan 2005 23:22:37 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ide] clean up error path in do_ide_setup_pci_device()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <1104773262.13302.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412310343.iBV3hqvd015595@hera.kernel.org>
	 <1104773262.13302.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2005 18:42:26 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> This changeset will break support for several systems because the PCI
> IDE controller uses some BARs on a multifunction PCI northbridge. The
> old IDE code was extremely careful *NOT* to play pci_disable_device
> games because of this.

Well, I supposed something like this but since pci_disable_device()
is called *only* in error paths I decided to take the risk. ;-)

> Nothing in the IDE specification requires the PCI IDE controller be the
> only use of that PCI function. The damage is probably minimal as it
> deals with error paths but this change should be reverted (and will be
> for -ac).

Different PCI functions should have different struct pci_dev instances
so is this really a problem?

> On Iau, 2004-12-30 at 19:08, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2034.118.8, 2004/12/30 20:08:53+01:00, bzolnier@trik.(none)
> >
> >       [ide] clean up error path in do_ide_setup_pci_device()
> >
> >       ide_setup_pci_controller() puts the device in a PCI enabled state.
> >       The patch adds a small helper to balance it when things go wrong.
> >
> >       Actually the helper does not *exactly* balance the setup: if it can
> >       not do a better job, ide_setup_pci_controller() may only enable some
> >       BARS whereas the new counterpart will try to disable everything.
> >
> >       Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
> >       Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >
> >
> >
> >  setup-pci.c |   15 +++++++++++++--
> >  1 files changed, 13 insertions(+), 2 deletions(-)
> >
> >
> > diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
> > --- a/drivers/ide/setup-pci.c 2004-12-30 19:44:05 -08:00
> > +++ b/drivers/ide/setup-pci.c 2004-12-30 19:44:05 -08:00
> > @@ -542,6 +542,13 @@
> >       return 0;
> >  }
> >
> > +static void ide_release_pci_controller(struct pci_dev *dev, ide_pci_device_t *d,
> > +                                    int noisy)
> > +{
> > +     /* Balance ide_pci_enable() */
> > +     pci_disable_device(dev);
> > +}
> > +
> >  /**
> >   *   ide_pci_setup_ports     -       configure ports/devices on PCI IDE
> >   *   @dev: PCI device
> > @@ -672,7 +679,7 @@
> >                */
> >               ret = d->init_chipset ? d->init_chipset(dev, d->name) : 0;
> >               if (ret < 0)
> > -                     goto out;
> > +                     goto err_release_pci_controller;
> >               pciirq = ret;
> >       } else if (tried_config) {
> >               if (noisy)
> > @@ -687,7 +694,7 @@
> >               if (d->init_chipset) {
> >                       ret = d->init_chipset(dev, d->name);
> >                       if (ret < 0)
> > -                             goto out;
> > +                             goto err_release_pci_controller;
> >               }
> >               if (noisy)
> >  #ifdef __sparc__
> > @@ -705,6 +712,10 @@
> >       ide_pci_setup_ports(dev, d, pciirq, index);
> >  out:
> >       return ret;
> > +
> > +err_release_pci_controller:
> > +     ide_release_pci_controller(dev, d, noisy);
> > +     goto out;
> >  }
> >
> >  int ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d)
