Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbRFGUoN>; Thu, 7 Jun 2001 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbRFGUoD>; Thu, 7 Jun 2001 16:44:03 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28429 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263106AbRFGUny>; Thu, 7 Jun 2001 16:43:54 -0400
Date: Thu, 7 Jun 2001 13:43:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Background scanning change on 2.4.6-pre1
In-Reply-To: <Pine.LNX.4.21.0106071545520.1156-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0106071330060.6510-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Jun 2001, Marcelo Tosatti wrote:
> 
> Who did this change to refill_inactive_scan() in 2.4.6-pre1 ? 

I think it was Andreas Dilger..

>         /*
>          * When we are background aging, we try to increase the page aging
>          * information in the system.
>          */
>         if (!target)
>                 maxscan = nr_active_pages >> 4;
> 
> This is going to make all pages have age 0 on an idle system after some
> time (the old code from Rik which has been replaced by this code tried to 
> avoid that)

He posted a nice explanation of how this change made behaviour noticeably
smoother, and how you could actually see the nicer balance between the
active and inactive lists using osview.

The code is not necessarily "correct", but this patch was accompanied by
useful real-life user information.

Now, I think the problem with the old code was that it didn't do _any_
background page aging if "inactive" was large enough. And that really
doesn't make all that much sense. Background page aging is needed to
"sort" the active list, regardless of how many inactive pages there are.

The decision to not do page aging should not be based on the number of
inactive pages, and I think the patch is correct in that sense.

Now, if you were to change the code to something like

	/* background scanning? */
	if (!target) {
		if (atomic_read(page_aging) <= 0)
			return 0;
		maxscan = nr_active_pages >> 4;
	}

and make the "page_aging" be something that goes up when we age stuff up
and goes down when we age it down, and does the proper balancing, THAT
would probably be ok. Then the decision to not age in the background would
be based on whether we have lots of pages getting aged up or not.

Heuristics should make sense, not be "random".

		Linus

