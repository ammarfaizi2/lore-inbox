Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbULGVe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbULGVe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbULGVe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:34:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34194 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261945AbULGVdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:33:11 -0500
Date: Tue, 7 Dec 2004 22:32:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com, Mark Hemment <markhe@nextd.demon.co.uk>,
       akpm@osdl.org
Subject: Re: [PATCH][2/2] fix unchecked returns from kmalloc() (in mm/slab.c)
Message-ID: <20041207213216.GE10083@suse.de>
References: <Pine.LNX.4.61.0412072213320.3320@dragon.hygekrogen.localhost> <20041207212603.GC10083@suse.de> <Pine.LNX.4.61.0412072237440.3320@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412072237440.3320@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Jesper Juhl wrote:
> On Tue, 7 Dec 2004, Jens Axboe wrote:
> 
> > On Tue, Dec 07 2004, Jesper Juhl wrote:
> > > 
> > > Problem reported by Katrina Tsipenyuk and the Fortify Software engineering
> > > team in thread with subject "PROBLEM: unchecked returns from kmalloc() in
> > > linux-2.6.10-rc2".
> > > 
> > > Unfortunately I'm not very familliar with the code in question, and since 
> > > I didn't find a really good way to deal with a failing kmalloc() here I 
> > > settled for second best which is to add a BUG_ON() in case kmalloc fails. 
> > > This will at least crash in a sane way at the point the problem occoures 
> > > rather than getting strange problems at a (possibly) later time. If 
> > > someone who's familliar with how this code works has a better solution 
> > > then please step forward :) but in the mean time I think this is at least 
> > > a slight improvement over the current situation.
> > > 
> > > Patch has been compile tested and boot tested and didn't blow up 
> > > instantly, but please review before applying.
> > > 
> > > 
> > > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > > 
> > > diff -up linux-2.6.10-rc3-bk2-orig/mm/slab.c linux-2.6.10-rc3-bk2/mm/slab.c
> > > --- linux-2.6.10-rc3-bk2-orig/mm/slab.c	2004-12-06 22:24:56.000000000 +0100
> > > +++ linux-2.6.10-rc3-bk2/mm/slab.c	2004-12-07 21:27:20.000000000 +0100
> > > @@ -804,6 +804,7 @@ void __init kmem_cache_init(void)
> > >  		void * ptr;
> > >  		
> > >  		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
> > > +		BUG_ON(ptr == NULL);	/* FIXME: Can a failed kmalloc be handled better? */
> > >  		local_irq_disable();
> > >  		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
> > >  		memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init));
> > 
> > This is pointless, as a NULL deref on memcpy will give you the exact
> > same info.
> > 
> Hmm, now why didn't I think of that. Thanks Jens.
> I guess I'm not up to the task of fixing this one. I'll try looking 
> harder, but I don't think I can do better in this case.

See my next mail, I'm not so sure there's anything worth fixing. If
there was no fear of it being misused, perhaps GFP_PANIC would be a
proper way to flag that this really should not fail.

-- 
Jens Axboe

