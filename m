Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143800AbRA1SkV>; Sun, 28 Jan 2001 13:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143807AbRA1SkL>; Sun, 28 Jan 2001 13:40:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16907 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S143800AbRA1Sj7>;
	Sun, 28 Jan 2001 13:39:59 -0500
Date: Sun, 28 Jan 2001 19:39:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 deadlock (Re: ps hang in 241-pre10)
Message-ID: <20010128193949.A5522@suse.de>
In-Reply-To: <20010128192306.C4871@suse.de> <Pine.LNX.4.10.10101281026250.3812-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101281026250.3812-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 28, 2001 at 10:29:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28 2001, Linus Torvalds wrote:
> On Sun, 28 Jan 2001, Jens Axboe wrote:
> > 
> > How about this instead?
> 
> I really don't like this one. It will basically re-introduce the old
> behaviour of waking people up in a trickle, as far as I can tell. The
> reason we want the batching is to make people have more requests to sort
> in the elevator, and as far as I can tell this will just hurt that.
> 
> Are there any downsides to just _always_ batching, regardless of whether
> the request freelist is empty or not? Sure, it will make the "effective"
> size of the freelist a bit smaller, but that's probably not actually
> noticeable under any load except for the one that empties the freelist (in
> which case the old code would have triggered the batching anyway).

The problem with removing the !list_empty test like you suggested
is that batching is no longer controlled anymore. If we start
batching once the lists are empty and start wakeups once batch_requests
has been reached, we know we'll give the elevator enough to work
with to be effective. With !list_empty removed, batch_requests is no
longer a measure of how many requests we want to batch. Always
batching is not a in problem in itself, the effective smaller freelist
effect should be neglible.

The sent patch will only trickle wakeups in case of batching already
in effect, but batch_request wakeups were not enough to deplete
the freelist again. At least that was the intended effect :-)

> Performance numbers?

Don't have any right now, will test a bit later.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
