Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWBALId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWBALId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWBALId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:08:33 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:15893 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932400AbWBALIc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:08:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vm0ujGqf6tDkfnn0ikCx4xY1zCqPwBXm7w4SjeIFiGIVZcb9GGY+RGMk2ogTL+FAG29Z+vQpfFFIEkWZ2kbmus7HBGdpZr6FGHFtlfo8jTVPQIa0isxwkXwIJeJzeI7Oiyr/L//A92AQ+MTvlL6Nj3Nz+3WH8ru/0VKqzuYR3qQ=
Message-ID: <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com>
Date: Wed, 1 Feb 2006 12:08:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [patch] SGIIOC4 limit request size
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060201104913.GA152005@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <yq0vevzpi8r.fsf@jaguar.mkp.net>
	 <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
	 <20060201104913.GA152005@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Jeremy Higdon <jeremy@sgi.com> wrote:
> On Wed, Feb 01, 2006 at 11:34:18AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 01 Feb 2006 03:59:16 -0500, Jes Sorensen <jes@sgi.com> wrote:
> > > Hi,
> >
> > Hi,
> >
> > > This one takes care of a problem with the SGI IOC4 driver where it
> > > hits DMA problems if the request grows too large.
> >
> > Does this happen only for CONFIG_IA64_PAGE_SIZE_4KB=y
> > or CONFIG_IA64_PAGE_SIZE_8KB=y?
>
> Actually, it happens with a 16KB page size.
>
> > from sgiioc4.c:
> >
> > /* Each Physical Region Descriptor Entry size is 16 bytes (2 * 64 bits) */
> > /* IOC4 has only 1 IDE channel */
> > #define IOC4_PRD_BYTES       16
> > #define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
> >
> > As limiting request size to 127 sectors punishes performance
> > wouldn't it be better to define IOC4_PRD_ENTRIES to 256
> > if this is possible (would need 4 pages for PAGE_SIZE=4096
> > and 2 for PAGE_SIZE=8192)?
>
> I may be misunderstanding something, but it looks to me as though
> IOC4_PRD_ENTRIES may be ignored, since ide_init_queue() just uses
> PRD_ENTRIES.  Fortunately, with a 16KB page size, the arithmetic
> works out to the same.  In any case, it seems that the 64KB
> limit is the problem.  Whether that is due to too many s/g entries

Indeed, seems that hwif->max_sg_nents is not respected when
setting queue ->max_hw_segments and ->max_phys_segments.

Does the logic really work the same?
Isn't PCI_DMA_BUS_IS_PHYS == 0 for SN2?

If so then the code sets ->max_{hw,phys}_segments
to IOC4_PRD_ENTRIES/2 which actually shouldn't hurt...

> or total byte count I cannot say.  I do know that with a 2KB
> physical sector size, the minimum size for a s/g entry should be
> 2KB, which would mean we're using at most 32 with 127 max sectors --
> well below the 256 that we get from PRD_ENTRIES and IOC4_PRD_ENTRIES.
>
> We're still looking for root cause of this problem.  But with the
> default 128KB max request size, we occasionally get timeouts on
> DMA commands.

I have no big problem with applying patch as it is but I think that
it just hides the real problem and/or makes it harder to hit...

Bartlomiej

> jeremy
>
> > Cheers.
> > Bartlomiej
> >
> > > Cheers,
> > > Jes
> > >
> > > Avoid requests larger than the number of SG table entries, to avoid
> > > DMA timeouts.
> > >
> > > Signed-off-by: Jes Sorensen <jes@sgi.com>
> > >
> > > ----
> > >
> > >  drivers/ide/pci/sgiioc4.c |    8 +++++++-
> > >  1 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-2.6/drivers/ide/pci/sgiioc4.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
> > > +++ linux-2.6/drivers/ide/pci/sgiioc4.c
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
> > > + * Copyright (C) 2003, 2006 Silicon Graphics, Inc.  All Rights Reserved.
> > >   *
> > >   * This program is free software; you can redistribute it and/or modify it
> > >   * under the terms of version 2 of the GNU General Public License
> > > @@ -613,6 +613,12 @@
> > >         hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
> > >         hwif->ide_dma_timeout = &__ide_dma_timeout;
> > >         hwif->INB = &sgiioc4_INB;
> > > +
> > > +       /*
> > > +        * Limit the request size to avoid DMA timeouts when
> > > +        * requesting  more entries than goes in the sg table.
> > > +        */
> > > +       hwif->rqsize = 127;
> > >  }
> > >
> > >  static int __devinit
>
