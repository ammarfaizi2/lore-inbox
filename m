Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVEJJDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVEJJDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVEJJDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:03:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55746 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261588AbVEJJCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:02:31 -0400
Date: Tue, 10 May 2005 11:02:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Andi Kleen <ak@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Message-ID: <20050510090209.GJ21649@suse.de>
References: <200505092239.37834.rjw@sisk.pl> <20050509205251.GK25167@wotan.suse.de> <20050510061858.GB21649@suse.de> <1115713686.918.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115713686.918.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2005, Alexander Nyberg wrote:
> tis 2005-05-10 klockan 08:18 +0200 skrev Jens Axboe:
> > On Mon, May 09 2005, Andi Kleen wrote:
> > > On Mon, May 09, 2005 at 10:39:37PM +0200, Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:
> > > 
> > > Probably a generic bug. Block layer is passing some slab flag slab
> > > doesn't like.
> > 
> > Some slab change, perhaps? There's nothing special about the init_bio()
> > slab call:
> > 
> >         bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
> >                             SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
> > 
> > 
> > Hmm, this looks strange. That bug happens if:
> > 
> >         if ((!name) ||
> >                 in_interrupt() ||
> >                 (size < BYTES_PER_WORD) ||
> >                 (size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
> >                 (dtor && !ctor)) {
> >                         printk(KERN_ERR "%s: Early error in slab %s\n",
> >                                         __FUNCTION__, name);
> >                         BUG();
> >                 }
> > 
> > It must be in_interrupt() triggering, perhaps something change in the
> > boot sequence?
> > 
> 
> The funny thing is that it seems to be the name being NULL, from the
> original post:
> kmem_cache_create: Early error in slab <NULL>
> 
> When looking at the code I really can't see how that can be. Rafael,
> what setup is this compiled under?

Huh indeed, smells like bad code generation or hardware.

-- 
Jens Axboe

