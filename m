Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317803AbSGPIqM>; Tue, 16 Jul 2002 04:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317804AbSGPIqL>; Tue, 16 Jul 2002 04:46:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47051 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317803AbSGPIqK>;
	Tue, 16 Jul 2002 04:46:10 -0400
Date: Tue, 16 Jul 2002 10:48:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716084856.GR811@suse.de>
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de> <3D33DED8.C5C92C06@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D33DED8.C5C92C06@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > On Tue, Jul 16 2002, Andrew Morton wrote:
> > > William Lee Irwin III wrote:
> > > >
> > > > loop.c oopses when bio_copy() returns NULL. This was encountered while
> > > > running dbench 16 on a loopback-mounted reiserfs filesystem.
> > >
> > > ugh.  GFP_NOIO is evil.  I guess it's better to add __GFP_HIGH
> > > there, but it's not a happy solution.
> > 
> > GFP_NOIO has __GFP_WAIT set, so bio_copy -> bio_alloc -> mempool_alloc
> > should never fail. Puzzled.
> > 
> 
> Presumably the loop driver was called from within shrink_cache(),
> as PF_MEMALLOC.  Those allocations can fail.

Maybe I'm being dense, but I don't see how PF_MEMALLOC would prevent
mempool_alloc() from doing the right thing still. In the end we'll just
end up stalling on our own pool.

> That's maybe wrong - if there are a decent number of pages
> under writeback then we should be able to just wait it out.
> But it gets tricky with the loop driver...

Indeed

-- 
Jens Axboe

