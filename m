Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTIXJVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 05:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTIXJVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 05:21:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61874 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261421AbTIXJVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 05:21:31 -0400
Date: Wed, 24 Sep 2003 11:21:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __make_request() bug and a fix variant
Message-ID: <20030924092130.GN1321@suse.de>
References: <20030919231732.7f7874e6.zap@homelink.ru> <20030920113737.GQ21870@suse.de> <20030920193626.31d2b8f5.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920193626.31d2b8f5.zap@homelink.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20 2003, Andrew Zabolotny wrote:
> On Sat, 20 Sep 2003 13:37:37 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > I dunno if you were the one posting this issue here some months ago?
> No, it wasn't me :-)
> 
> > Show me a regular kernel path that passes invalid b_reqnext to
> > __make_request? That would be a bug, indeed, but I've never heard of
> > such a bug. Most likely it's a bug in your driver, not initialising
> > b_reqnext.
> I have been calling bread() which was causing me troubles. bread does
> not accept a buffer_head from outside, it gets a new one and returns it.
> So I don't have any control over b_reqnext field - the bug happens
> inside bread() between these lines:
> 
> bh = getblk(dev, block, size);
> /* here bh_reqnext is already junk. In fact, I partially solved this
>    problem by making my own clone of bread() and setting b_reqnext
>    to NULL right here. But unfortunately, there is no guarantee we'll
>    fix all invalid buffer_heads - maybe some remain in the pool and
>    will be returned to other innocent drivers requesting them. */
> if (buffer_uptodate(bh))
> 	return bh;
> /* and now ll_rw_block will try to merge the bh with those already in
>    the queue, and if it will take the ELEVATOR_NO_MERGE path, bh_reqnext
>    will still remain junk. */
> ll_rw_block(READ, 1, &bh);

Looks very odd, there must be a bug elsewhere. What else is junk in the
bh?

It follows that if you submit a buffer_head for io, it must be properly
initialized for io. Nobody complains that if b_blocknr is crap that data
ends up in the wrong location. Likewise, b_reqnext must be initialized
to NULL.

> > You can see the initialisor for buffer_heads is
> > init_buffer_head, which memsets the entire buffer_head. When a
> > buffer_head is detached from the request list, b_reqnext is cleared
> > too.
> Ah, so I was correct that __make_request expects b_reqnext to be already
> set to NULL. In this case the bug should be somewhere else - in some
> code that returns buffer_head's back to the pool of buffers.

Exactly!

> Interesting that right before the driver crashes in bread() I call
> grok_partitions. I think the bug is somewhere there. I will do a new
> debug session at Monday (the code that breaks is at work), so I will
> post new details if I find any.

Please do.

-- 
Jens Axboe

