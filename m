Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTA2KHh>; Wed, 29 Jan 2003 05:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbTA2KHh>; Wed, 29 Jan 2003 05:07:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52969 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265675AbTA2KHg>;
	Wed, 29 Jan 2003 05:07:36 -0500
Date: Wed, 29 Jan 2003 11:16:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org,
       Larry Sendlosky <Larry.Sendlosky@storigen.com>
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030129101645.GZ31566@suse.de>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0FA@xchangeserver2.storigen.com> <20030128220607.GF31566@suse.de> <1043828587.537.25.camel@zion.wanadoo.fr> <20030129085332.GT31566@suse.de> <1043833440.537.30.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043833440.537.30.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> On Wed, 2003-01-29 at 09:53, Jens Axboe wrote:
> > On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> > > On Tue, 2003-01-28 at 23:06, Jens Axboe wrote:
> > > > On Tue, Jan 28 2003, Larry Sendlosky wrote:
> > > > > I was glad to see the physical page support in 2.4.20.
> > > > > (and also noticed that the current BK tree clobbered it
> > > > > on a patch set from Alan).
> > > > > 
> > > > > One question, 
> > > > > 
> > > > > +		lastdataend = bh_phys(bh) + bh->b_size;
> > > > > 
> > > > > bh_phys(x) uses bh->b_page. Does it make a difference
> > > > > if bh->b_page is zero? What if someone combines virt and phys
> > > > > buffer addresses in bh list?
> > > > 
> > > > Yes good catch! New version attached.
> > > 
> > > That's interesting. I wasn't awaye you could have a request
> > > containing such a "mixed" set of bh without valid pages.
> > > Actually, I though b_page was always valid. Looking at
> > > other drivers (typically the the csiss.c driver), it also
> > > unconditionally use b_page & bh_phys(). So either we are
> > > looking at a false problem, or that driver need fixing as
> > > well.
> > 
> > b_page is not always valid for IDE, this is a special case. ide-scsi
> > fabricates its own buffer_heads. cciss etc can rely on valid b_page
> > always.
> 
> Ok. Well, looking at ide-scsi, I see that:
> 
> #if 1
> 			bh->b_data = sg->address;
> #else
> 			if (sg->address) {
> 				bh->b_page = virt_to_page(sg->address);
> 				bh->b_data = (char *) ((unsigned long) sg->address & ~PAGE_MASK);
> 			} else if (sg->page) {
> 				bh->b_page = sg->page;
> 				bh->b_data = (char *) sg->offset;
> 			}
> #endif
> 
> Can't we just turn that #if 1 into #if 0 ? The case of non segmented
> requests remains, where we have
> 
> 		bh->b_data = pc->scsi_cmd->request_buffer;
> 		bh->b_size = pc->request_transfer;
> 
> But then, can't we use the same approach as above using virt_to_page() ?
> 
> I don't say we should do it now. I'm mostly asking for my own eductation
> about all this, though I admit I don't like the "mixing" done in
> ide_build_sglist.

Sure that is a possibility, there's definitely nothing wrong with doing
so.

-- 
Jens Axboe

