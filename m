Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRIPWzw>; Sun, 16 Sep 2001 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272966AbRIPWzm>; Sun, 16 Sep 2001 18:55:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272980AbRIPWze>; Sun, 16 Sep 2001 18:55:34 -0400
Date: Sun, 16 Sep 2001 15:55:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Andreas Steinmetz <ast@domdv.de>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <180945403.1000684019@[169.254.62.211]>
Message-ID: <Pine.LNX.4.33.0109161548290.982-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Sep 2001, Alex Bligh - linux-kernel wrote:
>
> >  - age a non-referenced page on a list: move to "next" list downwards (ie
> >    free if already inactive, move to inactive if currently active)
>
> Do you still make the distinction between Inactive Clean
> and Inactive Dirty (& just move to appropriate list)?

That part of the code doesn't.

> Effectively this is just a 'binary' aging function (OK position
> on the list matters too). Others on the list have observed
> page->age performs in a binary manner anyhow with exponential
> aging.

Right. I'm not saying that this is anything _exiting_ - I'm just saying
that the old code did not have any clear behaviour at all. It would
inappropriately raise a page from the inactive lists to the active list
even if the code that actually _touched_ the page had decided that the
page was not active.

And the behaviour of the referenced bit once on the active list was
unclear. I personally think that clearing the reference bit when moving to
the active list is the right thing to do (so that it is marked
"unimportant" on the active list and needs a _third_ access to be marked
important), but this is an example of one of the tweaks/decisions we
should clearly make instead of leaving the behaviour undefined (which it
was before).

> How do you balance between Inactive Clean before Inactive Dirty
> and avoid evicting many (infrequently used) code pages at
> the expense of many (historic, even less frequently used) dirty
> data pages? Or don't we care?

We probably _do_ care. I suspect that if there are balancing problems,
they could easily be in the reclaim_page() vs page_launder() balance (ie
aging of inactive_clean vs inactive_dirty).

		Linus

