Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129578AbQJZUp3>; Thu, 26 Oct 2000 16:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQJZUpU>; Thu, 26 Oct 2000 16:45:20 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129578AbQJZUpN>; Thu, 26 Oct 2000 16:45:13 -0400
Date: Thu, 26 Oct 2000 13:44:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: killing read_ahead[]
In-Reply-To: <Pine.GSO.4.21.0010251435100.12098-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10010261332390.2575-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Oct 2000, Alexander Viro wrote:
> 
> Linus, what do you think about that? I can do the remaining filesystems
> and give it initial testing today.

Ok, looks reasonable, if not really pretty. I'd probably prefer

	last_page = size >> PAGE_CACHE_SIZE;
	last_page_size = size & (PAGE_CACHE_SIZE-1);

and then the three cases would be

	if (index < last_page) {
		full page case - ok.
	}
	if (index > last_page || !last_page_size) {
		bad case, past the end
	}
	partial_page.

I see why you did it the way you did, but while it makes it really cheap
to test for "index past the end", it makes for less obvious calculations
in other places, I feel.

The alternative is to have an entirely different approach, where the page
cache itself only knows about the maximum page (in which case your current
"last_page" calculation is right on), and then anybody who needs to know
about partial pages needs to get THAT information from the inode.

I'd almost prefer the alternative approach. Especially as right now the
only real problem we're fighting is to make sure we never return an
invalid page - the sub-page offset really doesn't matter for those things,
and everybody who cares about the sub-page-information already obviously
has it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
