Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRADHng>; Thu, 4 Jan 2001 02:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130812AbRADHn1>; Thu, 4 Jan 2001 02:43:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15886 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129752AbRADHnW>; Thu, 4 Jan 2001 02:43:22 -0500
Date: Wed, 3 Jan 2001 23:42:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() return value problem?
In-Reply-To: <Pine.LNX.4.21.0101040308450.1174-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101032335560.14770-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Marcelo Tosatti wrote:
> 
> Your latest changes to try_to_swap_out() does not seem to be obviously
> correct.

Heh. What a polite way of saying that you think I'm full of sh*t ;)

> Having swap_cnt == 0 does not necessarily mean that we successfully freed
> a page (look at the page aging and locking checks in try_to_swap_out).

No.

What it means, though, is that we did finish what we set out to do.
Nothing more.

> Now refill_inactive() relies on the assumption that swap_out() returning 
> 1 means we successfully freed a page:
> 
>                 while (swap_out(priority, gfp_mask)) {
>                         made_progress = 1;
>                         if (--count <= 0)
>                                 goto done;
>                 }

Well, refill-inactive really relies on the assumption that _some_ progress
was made, which was certainly true. "swap_out()" returning 1 has not
actually meant that a page has been free'd for a _long_ long time: it's
meant that _something_ changed (ie "we added one page to the swap cache"
or similar).

I agree that the return value of swap_out() is fairly meaningless. It's
been fairly meaningless for a long time now, and it's entirely possible
that the "while (swap_out())" loop should be just something like

	/* Scan the VM space, try to clean up the page tables a bit */
	for (i = 0 ; i <= nr_threads >> priority; i++)
		swap_out(gfp_mask);

which just tries to move pages out of the page tables, so that the _real_
page freeing logic (ie page_launder() and friends) have more to work with.
This is especially true these days as swap_out() really doesn't do any IO
at all (and has thus finally become completely misnamed: it's not so much
swapping stuff out, as just aging the page tables).

As it is, I think that the above is fairly close to what the code
effectively ends up actually _doing_. Even if it's not really written that
way.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
