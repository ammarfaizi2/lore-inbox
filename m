Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVBLDyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVBLDyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVBLDyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:54:49 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27359 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262386AbVBLDyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:54:45 -0500
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() &&
	irqs_disabled()
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Jody McIntyre <scjody@modernduck.com>
Cc: Dan Dennedy <dan@dennedy.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20050211184307.GQ16141@conscoop.ottawa.on.ca>
References: <41FD498C.9000708@comcast.net>
	 <20050130131723.781991d3.akpm@osdl.org> <41FD6478.9040404@comcast.net>
	 <20050130150224.33299170.akpm@osdl.org> <41FD8796.2020509@comcast.net>
	 <1108136133.4149.3.camel@kino.dennedy.org>
	 <20050211184307.GQ16141@conscoop.ottawa.on.ca>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 22:54:36 -0500
Message-Id: <1108180477.30605.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody,
This happens every time you connect a device which ends up doing
ISO_LISTEN_CHANNEL. We fixed the device disconnect case in -mm recently.

I had sent you and Andrew an alternative patch which fixes this
dma_pool_create case as well as the dma_pool_destroy case, albeit with a
disadvantage - The patch does pre-allocation of the IR Legacy DMA in
_pci_probe and deallocates it in _pci_remove. However I am not truly
happy with it since it possibly wastes 200K of memory for people who
don't have devices which need it.

As I said earlier, I think the way to fix this is via schedule_work
similar to the disconnect case, but it involves good amount of code
change. I am working on it - any better ideas most welcome.

Dan - Can you try the attached patch - on top current -mm1? (It's pretty
no brainer that it will fix both cases but two testing heads are better
than one.. :)

Thanks

Parag

On Fri, 2005-02-11 at 13:43 -0500, Jody McIntyre wrote:
> On Fri, Feb 11, 2005 at 10:35:33AM -0500, Dan Dennedy wrote:
> 
> > I am testing this patch in the same manner as you: exiting Kino capture.
> > I am getting a similar error in a different location. Can you look into
> > it, please?
> > 
> > Debug: sleeping function called from invalid context at mm/slab.c:2082
> > in_atomic():1, irqs_disabled():1
> >  [<c0119eb1>] __might_sleep+0xa1/0xc0
> >  [<c0144914>] kmem_cache_alloc+0x64/0x80
> >  [<c037f07b>] dma_pool_create+0x7b/0x190
> >  [<e09ede32>] alloc_dma_rcv_ctx+0x1a2/0x400 [ohci1394]
> >  [<e09eb239>] ohci_devctl+0x3d9/0x640 [ohci1394]
> >  [<e0bc5d4e>] handle_iso_listen+0xee/0x160 [raw1394]
> >  [<e0bc878e>] state_connected+0x2de/0x2f0 [raw1394]
> >  [<e0bc884e>] raw1394_write+0xae/0xe0 [raw1394]
> >  [<c015c80c>] vfs_write+0x14c/0x160
> >  [<c015c8f1>] sys_write+0x51/0x80
> >  [<c0102a39>] sysenter_past_esp+0x52/0x75
> 
> Does this happen on exit or on startup?  Looks like allocation problems,
> which will be harder to fix, since you can't return to userland until
> the allocation is complete.  AFAICT the correct fix is to use
> finer-grained locks, hold them for less time, and not use _irq or
> _irqsave unless necessary.  host_info_lock, in particular, is held for
> far too long.
> 
> Jody
> 
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > mailing list linux1394-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux1394-devel
> 

