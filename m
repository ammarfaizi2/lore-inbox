Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUITSKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUITSKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUITSKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:10:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25506 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266901AbUITSKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:10:09 -0400
Date: Mon, 20 Sep 2004 20:09:57 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: jmerkey@galt.devicelogics.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 bio sickness with large writes
Message-ID: <20040920180957.GB7616@suse.de>
References: <4148D2C7.3050007@drdos.com> <20040916063416.GI2300@suse.de> <4149C176.2020506@drdos.com> <20040917073653.GA2573@suse.de> <20040917201604.GA12974@galt.devicelogics.com> <414F0F87.9040903@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F0F87.9040903@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20 2004, Jeff V. Merkey wrote:
> jmerkey@galt.devicelogics.com wrote:
> 
> Jens,
> 
> Can you explain the circumstances related to the bio->bi_size callback. 
> You stated (and I have observed)
> that there may be callbacks from bi_end_io with bi_size set and that 
> these should be ignored and
> return a value of 1.

Driver calls bio_endio() with bytes_done < bio->bi_size, thus the bio
isn't completely ended. Drivers may do this for a variety of reasons.

> Can you explain to me under what circumstances I am likely to see this 
> behavior? In other words, would

On drivers that do partial completions :-)

You should not worry about where you'll see it. Either you handle
partial completions by taking bytes_done into account, or you ignore the
issue and just look at bio->bi_size to determine whether all io in this
bio has completed.

> you explain the bio process start to finish with coalesced IO requests, 
> at least as designed. Also, the whole

Well, you build a bio and submit it. If another bio is built after that
and is contig on disk (either before or after the other one), they are
clustered in the request structure if they don't violate the
restrictions of the hardware (max size of a single request, max number
segments, etc).

> page and offset sematics in the interface are also somewhat burdensome. 
> Wouldn't a more reasonable
> interface for async IO be:
> 
> address
> length
> address
> length
> 
> rather than
> 
> page structure
> offset in page structure
> page structure
> offset in page structure

No, because { address, length } cannot fully describe all memory in any
given machine.

> The hardware doesn't care about page mapping above it just needs to see 
> addresses (and not always 4 byte aligned addresses)
> and lengths for building scatter gather lists. Forcing page sematics 
> seems a little orthagonal.

Any chunk of memory has a page associated with it, but it may not have a
kernel address mapping associated with it. So some identifier was needed
other than a virtual address, a page is as good as any so making one up
would be silly.

Once you understand this, it doesn't seem so odd. You need to pass in a
single page or sg table to map for dma anyways, the sg table holds page
pointers as well.

> I can assume from the interface as designed that if you pass an offset 
> for a page that is not page aligned,
> and ask for a 4K write, then you will end up dropping the data on the 
> floor than spans beyond the end of the page.

What kind of bogus example is that? Asking for a 4K write from a 4K page
but asking to start 1K in that page is just stupid and not even remotely
valid.

> No offense, but this is **BUSTED** behavior for an asynch interface. The 
> whole page offset thing is a little
> difficult to use and pushes needless complexity to someone just needing 
> to submit IO to the disk. I think this

It's not difficult at all. Apparently you don't understand it so you
think it's difficult, that's only natural. But you have access to the
page mapping of any given piece of data always, or if you have the
virtual address only it's trivial to go to the { page, offset } mapping.

> is great for mmap for the VFS layer, and it dure makes it a lot easier 
> to submit IO for fs with the mmap layer,
> but as a general purpose async layer on top of generic_make_request, 
> it's a little tough to use, IMHO.

I can only imagine that you are used to a very different interface on
some other OS so you think it's difficult to use. Most of your
complaints seem to be based on false assumptions or because you don't
understand why certain design decisions were made.

> Please advise,

I'll advise that you read and understand Suparnas excellent description
of bio in Documentation/block/biodoc.txt.

-- 
Jens Axboe

