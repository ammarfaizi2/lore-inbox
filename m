Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279029AbRJ2GHS>; Mon, 29 Oct 2001 01:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279031AbRJ2GHJ>; Mon, 29 Oct 2001 01:07:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59264 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279029AbRJ2GGu>;
	Mon, 29 Oct 2001 01:06:50 -0500
Date: Mon, 29 Oct 2001 01:07:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: alain@linux.lu
cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200110290538.f9T5c5Q07069@hitchhiker.org.lu>
Message-ID: <Pine.GSO.4.21.0110290101230.26445-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Oct 2001, Alain Knaff wrote:

> Problem number 2 is not yet addressed, Alex Viro is working on a patch
> (probably by having a variant of invalidate_bdev that just stops
> transfers in progress, loudly warn about dirty pages, but without
> killing clean cached pages)
> 
> Number 3 is fixed by making struct block_device "long
> lived". Formerly, it only existed as long as there were active open
> descriptors using it; now it exists as long as there are frontend
> inodes referencing it.

IMO that's bogus.  Correct test is "do we have any data in page cache
for this guy?" (combined with "... and if driver says that it goes
away, we'd better drop them all").  See the patch I've just sent to you
and Linus - right now I consider it as too dangerous for public testing, so...

Notice that it _doesn't_ trust check_media_change() - it still has
both detach_metadata() (needed in all cases) and truncate_inode_pages()
(kills cache, needed only for drivers with b0rken ->check_media_change())
in blkdev_put().  You'll need to make the latter call conditional to
actually keep the cache around, but I'd really like to make sure that
infrastructure changes are sane before doing that step.

