Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSJVOxy>; Tue, 22 Oct 2002 10:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJVOxy>; Tue, 22 Oct 2002 10:53:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59620 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261385AbSJVOxx>;
	Tue, 22 Oct 2002 10:53:53 -0400
Date: Tue, 22 Oct 2002 16:59:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Suparna Bhattacharya <suparna@sparklet.in.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
Message-ID: <20021022145943.GC5616@suse.de>
References: <20021022094911.GE30597@suse.de> <Pine.LNX.4.33L2.0210220743030.13752-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0210220743030.13752-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22 2002, Randy.Dunlap wrote:
> On Tue, 22 Oct 2002, Jens Axboe wrote:
> 
> | On Tue, Oct 22 2002, Suparna Bhattacharya wrote:
> | > On Mon, 21 Oct 2002 19:43:20 +0530, Christoph Hellwig wrote:
> | >
> | >
> | > >> +
> | > >> +	if ((dump_bio = kmalloc(sizeof(struct bio), GFP_KERNEL)) == NULL) { +
> | > >> 	DUMP_PRINTF("Cannot allocate bio\n"); +		retval = -ENOMEM;
> | > >> +		goto err2;
> | > >> +	}
> | > >
> | > > Shouldn't you use the generic bio allocator?
> | > >
> | >
> | > Not sure that this should come from the bio mempool. Objects
> | > allocated from the mem pool are expected to be released back to
> | > the pool within a reasonable period (after i/o is done), which is
> | > not quite the case here.
> | >
> | > Dump preallocates the bio early when configured and holds on to
> | > it all through the time the system is up (avoids allocs at
> | > actual dump time). Doesn't seem like the right thing to hold
> | > on to a bio mempool element that long.
> |
> | Definitely, one must not use the bio pool for long term allocations.
> 
> "must not" ?

Yes

> what happens if one does do that?  [not suggesting doing that]

Well, the whole concept behind mempool and deadlock-free allocation
while doing io, builds on that if slab allocation fails we fall back to
a private pool. If allocation from the private pool also fails, then we
_know_ we have io in progress that will finish "shortly". This is what
makes it safe to sleep on the private pool. Once you start doing long
term allocations from the bio pool, we can no longer make this
guarentee.

-- 
Jens Axboe

