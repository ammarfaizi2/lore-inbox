Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130089AbQJ2SGC>; Sun, 29 Oct 2000 13:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbQJ2SFx>; Sun, 29 Oct 2000 13:05:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28940 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130089AbQJ2SFq>; Sun, 29 Oct 2000 13:05:46 -0500
Date: Sun, 29 Oct 2000 10:05:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0
In-Reply-To: <14843.61434.167836.293141@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10010290957570.18939-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2000, Paul Mackerras wrote:
> 
> I have tracked down why I am getting the oops with page->mapping == 0
> in block_read_full_page.  Well, at least if not the ultimate cause,
> then the penultimate cause.  It's basically yet another truncate bug
> (tm).  I have some fairly detailed traces which I can send you if you
> like, but the executive summary is that a page can get truncated out
> from under us while we are sleeping in lock_page.  The scenario I
> observed is this:

Sorry, maybe our discussions with Al Viro weren't public, but yes, we did
come to the same conclusion a few days ago. 

The only problem right now is deciding how to fix it - because as you
rightly point out, this actually happens in a number of places, and as
such it's not trivial to fix it cleanly. We may have to use a brute-force
approach for 2.4.x where we just re-test against the file size in multiple
places where this can happen - but it would be nicer to handle this more
cleanly.

There are a few details that still elude me, the main one being the big
question about why this started happening to so many people just recently.
The bug is not new, and yet it's become obvious only in the last few
weeks.

I _hope_ that the reason for this is that more people are testing out
2.4.x, and that we've fixed most of the other issues that kept people back
from using it. It may be as simple as that. But I wonder if there is
something else going on too, like the read-ahead being buggy, and that
causing the bug to just happen a lot more (if read-ahead is buggy and
tries to read ahead past the end of the file, a truncate() will be much
more likely to hit these pages past the end, for example. Because most
cases of "truncate" are actually about truncating _upwards_, not
downwards).

So the two worries I have now is (a) the details on how to fix this thing
(minor worry, mainly one of aesthetics) and (b) whether there is something
else going on that brings it out of the woodworks..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
