Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266591AbRGEF5F>; Thu, 5 Jul 2001 01:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266624AbRGEF4z>; Thu, 5 Jul 2001 01:56:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19984 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266591AbRGEF4g>; Thu, 5 Jul 2001 01:56:36 -0400
Date: Wed, 4 Jul 2001 22:55:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [wip-PATCH] rfi: PAGE_CACHE_SIZE suppoort
In-Reply-To: <Pine.LNX.4.33.0107050054470.5548-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0107042247230.21720-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jul 2001, Ben LaHaise wrote:
>
> I attacked the PAGE_CACHE_SIZE support in the kernel for the last few days
> in an attempt to get multipage PAGE_CACHE_SIZE support working and below
> is what I've come up with.  It currently boots to single user read only,
> doesn't quite have write support fixed properly yet, but is going pretty
> well.  The reason for sending this out now is the question of what to do
> about kmap() support.

I suggest making kmap _always_ map the "biggest" chunk of physical memory
that the kernel ever touches at a time.

So I would _strongly_ suggest that you make the kmap granularity be at
_least_ PAGE_CACHE_SIZE. For debugging reasons I would suggest you have a
separate "PAGE_KMAP_SIZE" thing, so that you can get the kmap code working
independently of the PAGE_CACHE_SIZE thing.

Once you have the guarantee that "kmap(page)" will actually end up mapping
the (power-of-two-aligned) power-of-two-sized PAGE_KMAP_SIZE around the
page, the loops should all go away, and you should be able to use kmap()
the same way you've always used it (whether the user actually cares about
just one page or not ends up being a non-issue).

> -	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
> +	filp->f_pos = (n << PAGE_SHIFT) | offset;

You're definitely doing something wrong here.

You should _never_ care about PAGE_SHIFT, except in the case of a mmap()
where you obviously end up mapping in "partial" page-cache pages.  I
suspect you're doing all this exactly because of the kmap issue, but you
really shouldn't need to do it.

The whole point with having a bigger page-cache-size is to be able to
process bigger chunks at a time.

Now, one thing you might actually want to look into is to make the dirty
bit be a "dirty bitmap", so that you have the option of marking things
dirty at a finer granularity. But that, I feel, is after you've gotten the
basic stuff working with a PAGE_CACHE_SIZE dirty granularity.

		Linus

