Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTA2IoY>; Wed, 29 Jan 2003 03:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTA2IoX>; Wed, 29 Jan 2003 03:44:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11232 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265608AbTA2IoW>;
	Wed, 29 Jan 2003 03:44:22 -0500
Date: Wed, 29 Jan 2003 09:53:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org,
       Larry Sendlosky <Larry.Sendlosky@storigen.com>
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030129085332.GT31566@suse.de>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0FA@xchangeserver2.storigen.com> <20030128220607.GF31566@suse.de> <1043828587.537.25.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043828587.537.25.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> On Tue, 2003-01-28 at 23:06, Jens Axboe wrote:
> > On Tue, Jan 28 2003, Larry Sendlosky wrote:
> > > I was glad to see the physical page support in 2.4.20.
> > > (and also noticed that the current BK tree clobbered it
> > > on a patch set from Alan).
> > > 
> > > One question, 
> > > 
> > > +		lastdataend = bh_phys(bh) + bh->b_size;
> > > 
> > > bh_phys(x) uses bh->b_page. Does it make a difference
> > > if bh->b_page is zero? What if someone combines virt and phys
> > > buffer addresses in bh list?
> > 
> > Yes good catch! New version attached.
> 
> That's interesting. I wasn't awaye you could have a request
> containing such a "mixed" set of bh without valid pages.
> Actually, I though b_page was always valid. Looking at
> other drivers (typically the the csiss.c driver), it also
> unconditionally use b_page & bh_phys(). So either we are
> looking at a false problem, or that driver need fixing as
> well.

b_page is not always valid for IDE, this is a special case. ide-scsi
fabricates its own buffer_heads. cciss etc can rely on valid b_page
always.

> Now assuming that mix can happen, I don't like the fact that
> your new version will use lastdataend to compare against both
> physical and virtual addresses.

They should not be mixed in one call of build_sglist().

> Maybe the solution is to have an additional variable indicating
> if the last bh was virtual or physical, and reset lastdataend
> to ~0 when the current one is different... 

That should be a BUG(), if anything.

-- 
Jens Axboe

