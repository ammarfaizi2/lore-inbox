Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUHQOOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUHQOOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQOOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:14:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50943 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268293AbUHQONk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:13:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 16:12:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200408171512.26568.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171612.37898.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one more comment

> > @@ -931,15 +1138,25 @@
> >   */
> >  }
> >
> > -/*
> > - * Register an IDE interface, specifying exactly the registers etc
> > - * Set init=1 iff calling before probes have taken place.
> > +/**
> > + *	ide_register_hw		-	register IDE interface
> > + *	@hw: hardware registers
> > + *	@hwifp: pointer to returned hwif
> > + *
> > + *	Register an IDE interface, specifying exactly the registers etc
> > + *	Set init=1 iff calling before probes have taken place. The
> > + *	ide_cfg_sem protects this against races.
> > + *
> > + *	Returns -1 on error.
> >   */
> > +
> >  int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
> >  {
> >  	int index, retry = 1;
> >  	ide_hwif_t *hwif;
> >
> > +	down(&ide_cfg_sem);
> > +
> >  	do {
> >  		for (index = 0; index < MAX_HWIFS; ++index) {
> >  			hwif = &ide_hwifs[index];
> > @@ -950,28 +1167,37 @@
> >  			hwif = &ide_hwifs[index];
> >  			if (hwif->hold)
> >  				continue;
> > -			if ((!hwif->present && !hwif->mate && !initializing) ||
> > +			if ((!hwif->configured && !hwif->mate && !initializing) ||
> >  			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
> >  				goto found;
> >  		}
> > +		/* FIXME- this check should die as should the retry loop */
> >  		for (index = 0; index < MAX_HWIFS; index++)
> > -			ide_unregister(index);
> > +		{
> > +			hwif = &ide_hwifs[index];
> > +			__ide_unregister_hwif(hwif);
> > +		}
> >  	} while (retry--);
> > +
> > +	up(&ide_cfg_sem);
> >  	return -1;
> >  found:
> > -	if (hwif->present)
> > -		ide_unregister(index);
> > +	/* FIXME: do we really need this case */
> > +	if (hwif->configured)
> > +		__ide_unregister_hwif(hwif);
> >  	else if (!hwif->hold) {
> >  		init_hwif_data(hwif, index);
> >  		init_hwif_default(hwif, index);
> >  	}
> > -	if (hwif->present)
> > +	if (hwif->configured)
> >  		return -1;
> > +	hwif->configured = 1;

this is dubious for many non PCI drivers which use ide_register_hw() to only
claim/fill ide_hwifs[] entry but actual probing is done later by ide-generic 
driver - we end up with hwif->present == 0 and hwif->configured == 1
and if ide_register_hw() will try to unregister such hwif it will possibly 
crash (because we now check for ->configured not ->present in 
ide_unregister_hwif) - you've correctly noticed in the FIXMEs that we 
shouldn't be unregistering hwifs in ide_register_hw() but this has some 
side-effects (breaks HDIO_SCAN_HWIF for all non default/generic hwifs
and can change ordering in some rare situations) - we should go that way but 
we need to be fully aware of results of this change

> >  	memcpy(&hwif->hw, hw, sizeof(*hw));
> >  	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
> >  	hwif->irq = hw->irq;
> >  	hwif->noprobe = 0;
> >  	hwif->chipset = hw->chipset;
> > +	up(&ide_cfg_sem);
> >
> >  	if (!initializing) {
> >  		probe_hwif_init(hwif);
