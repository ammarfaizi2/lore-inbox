Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272774AbRIGQ4v>; Fri, 7 Sep 2001 12:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272776AbRIGQ4c>; Fri, 7 Sep 2001 12:56:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30216 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272774AbRIGQ4V>; Fri, 7 Sep 2001 12:56:21 -0400
Date: Fri, 7 Sep 2001 09:52:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: __GFP_HIGH ignored?
In-Reply-To: <20010902175947Z16091-32383+3016@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109070947160.10117-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Sep 2001, Daniel Phillips wrote:
>
> __GFP_HIGH is apparently ignored now.  Its intended function is performed
> instead by PF_MEMALLOC.  Should we take it out?

No. We may have a use for it in the future, especially as PF_MEMALLOC
really means something completely different.

I stronly suspect that the current PF_MEMALLOC handling is much too
strict: instead of trating a PF_MEMALLOC as a atomic high-priority thing,
we could treat it as something like

	/*
	 * recursive call? Make sure to strip out anything
	 * that could cause deadlocks and further recursion..
	 */
	if (current->flags & PF_MEMALLOC) {
		gfp_mask &= ~(__GFP_HIGHIO | __GFP_FS);
		page_launder(gfp_mask);
		page = RMQUEUE(..)
		if (page)
			return page;
		goto repeat;
	}

(Yeah, not exactly like the above, but you get the idea - allow a very
limited form of recursion, and allow a PF_MEMALLOC to always use the
reserves - together they should make us better at handling the current
issues with bounce buffers, for example).

It may be that we'll never need __GFP_HIGH, but let's keep it - it does
have semantics that make some amount of sense.

		Linus

