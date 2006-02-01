Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWBAKt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWBAKt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWBAKt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:49:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51422 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161011AbWBAKtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:49:25 -0500
Date: Wed, 1 Feb 2006 02:49:13 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] SGIIOC4 limit request size
Message-ID: <20060201104913.GA152005@sgi.com>
References: <yq0vevzpi8r.fsf@jaguar.mkp.net> <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 11:34:18AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 01 Feb 2006 03:59:16 -0500, Jes Sorensen <jes@sgi.com> wrote:
> > Hi,
> 
> Hi,
> 
> > This one takes care of a problem with the SGI IOC4 driver where it
> > hits DMA problems if the request grows too large.
> 
> Does this happen only for CONFIG_IA64_PAGE_SIZE_4KB=y
> or CONFIG_IA64_PAGE_SIZE_8KB=y?

Actually, it happens with a 16KB page size.

> from sgiioc4.c:
> 
> /* Each Physical Region Descriptor Entry size is 16 bytes (2 * 64 bits) */
> /* IOC4 has only 1 IDE channel */
> #define IOC4_PRD_BYTES       16
> #define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
> 
> As limiting request size to 127 sectors punishes performance
> wouldn't it be better to define IOC4_PRD_ENTRIES to 256
> if this is possible (would need 4 pages for PAGE_SIZE=4096
> and 2 for PAGE_SIZE=8192)?

I may be misunderstanding something, but it looks to me as though
IOC4_PRD_ENTRIES may be ignored, since ide_init_queue() just uses
PRD_ENTRIES.  Fortunately, with a 16KB page size, the arithmetic
works out to the same.  In any case, it seems that the 64KB
limit is the problem.  Whether that is due to too many s/g entries
or total byte count I cannot say.  I do know that with a 2KB
physical sector size, the minimum size for a s/g entry should be
2KB, which would mean we're using at most 32 with 127 max sectors --
well below the 256 that we get from PRD_ENTRIES and IOC4_PRD_ENTRIES.

We're still looking for root cause of this problem.  But with the
default 128KB max request size, we occasionally get timeouts on
DMA commands.

jeremy

> Cheers.
> Bartlomiej
> 
> > Cheers,
> > Jes
> >
> > Avoid requests larger than the number of SG table entries, to avoid
> > DMA timeouts.
> >
> > Signed-off-by: Jes Sorensen <jes@sgi.com>
> >
> > ----
> >
> >  drivers/ide/pci/sgiioc4.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletion(-)
> >
> > Index: linux-2.6/drivers/ide/pci/sgiioc4.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
> > +++ linux-2.6/drivers/ide/pci/sgiioc4.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
> > + * Copyright (C) 2003, 2006 Silicon Graphics, Inc.  All Rights Reserved.
> >   *
> >   * This program is free software; you can redistribute it and/or modify it
> >   * under the terms of version 2 of the GNU General Public License
> > @@ -613,6 +613,12 @@
> >         hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
> >         hwif->ide_dma_timeout = &__ide_dma_timeout;
> >         hwif->INB = &sgiioc4_INB;
> > +
> > +       /*
> > +        * Limit the request size to avoid DMA timeouts when
> > +        * requesting  more entries than goes in the sg table.
> > +        */
> > +       hwif->rqsize = 127;
> >  }
> >
> >  static int __devinit
