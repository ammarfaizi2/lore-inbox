Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbTHCKUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271188AbTHCKUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:20:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32926 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271187AbTHCKUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:20:06 -0400
Date: Sun, 3 Aug 2003 12:20:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking problem
Message-ID: <20030803102005.GR7920@suse.de>
References: <1059900149.3524.84.camel@gaston> <20030803100447.GO7920@suse.de> <1059905514.3514.111.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059905514.3514.111.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03 2003, Benjamin Herrenschmidt wrote:
> 
> > > would help making sure we don't get a request sneaking in ?
> > 
> > Hmm not really, there's still a chance that could happen.
> 
> Not too familiar with BIO here, but we would need some kind of
> "dead" flag to cause a reject of any try to insert a new request
> in the queue, don't you think ?

That's exactly right.

> Then, IDE could do something like:
> 
>  - set dead flag
>  - wait for all pending requests to drain (easy: insert a barrier
>    in the queue and wait on it, with a hack for the barrier insertion
>    to bypass the dead flag... ugh... maybe a blk_terminate_queue()
>    doing all that would be helpful ?)
>  - unregister blkdev
>  - then tear down the queue (leaving the "empty" queue with the dead
>    flag set, not just memset(...,0,...), so that any bozo keeping a
>    reference to it will be rejected trying to insert request instead
>    of trying to tap an uninitalized queue object
> 
> What do you think ?

Sounds like just the ticket. It's basically impossible to properly
shutdown a queue without being able to quisce it like you describe. IO
events are unpredictable :)

-- 
Jens Axboe

