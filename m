Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCABhs>; Wed, 28 Feb 2001 20:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbRCABhg>; Wed, 28 Feb 2001 20:37:36 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129469AbRCAB23>;
	Wed, 28 Feb 2001 20:28:29 -0500
Date: Thu, 1 Mar 2001 01:07:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steve Whitehouse <Steve@ChyGwyn.com>, pavel@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010301010751.Y21518@suse.de>
In-Reply-To: <200102282127.VAA20600@gw.chygwyn.com> <Pine.LNX.4.10.10102281525420.6380-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102281525420.6380-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Feb 28, 2001 at 03:29:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28 2001, Linus Torvalds wrote:
> As far as I can tell, the patch will trigger only for a not-empty request
> list, where the elevator decides to put the new request at the head of the
> queue.
> 
> Which is probably unlikely (and with the current elevator it might even be
> impossible). But it does not look impossible in theory. And I'd really
> prefer _not_ to have something that
>  - looks completely bogus from a design standpoint
>  - might be buggy under some rather unlikely circumstances
> 
> Reading them together they become "might cause disk corruption in some
> really hard-to-trigger circumstances". No, thank you.
> 
> Note that I suspect that all current drivers (or at least the common ones)
> have protection against being called multiple times, simply because 2.2.x
> used to do it. Which again means that you'd probably never see problems
> in practice. But that doesn't make it _right_. 

I think most of the "we want to disable plugging" behaviour stems
from the way task queues behave. Once somebody starts a tq_disk
run, the list is fried and walked one by one. Both old loop
and nbd drop the io_request_lock and block, possibly waiting
for I/O to be done (at least the loop case, don't know about
ndb). But this I/O won't be done just because the target plug every
now and then just happens to be queued behind the nbd/loop one and a new
tq_disk run won't start it.

-- 
Jens Axboe

