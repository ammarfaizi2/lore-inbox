Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262615AbREOEBU>; Tue, 15 May 2001 00:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbREOEBL>; Tue, 15 May 2001 00:01:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53776 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262615AbREOEA7>; Tue, 15 May 2001 00:00:59 -0400
Date: Mon, 14 May 2001 21:00:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105142319.f4ENJpf19203@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 May 2001, Richard Gooch wrote:
> 
> Is there some fundamental reason why a buffer cache can't ever be
> fast?

Yes.

Or rather, there is a fundamental reason why we must NEVER EVER look at
the buffer cache: it is not coherent with the page cache. 

And keeping it coherent would be _extremely_ expensive. How do we
know? Because we used to do that. Remember the small mindcraft
benchmark? Yup. Double copies all over the place, double lookups, double
everything.

You could think: "oh, we only need to look up the buffer cache when we
create a new page cache mapping, so..".

You'd be wrong. We'd need to go the other way too: every time we create a
new buffer cache entry, we'd need to make sure that it isn't mapped
somewhere in the page cache (impossible), or otherwise we'd do the wrong
thing sometimes (ie we might have two dirty copies, and we wouldn't know
_which_ one is valid etc).

Aliasing is bad. Don't do it.

Really. Give it up. Your silly "make bootup faster" is not going to happen
this way. You're trying to break some rather fundamental data structures,
all for the unusual case of booting up. There are other ways to boot up
quickly: look into pre-filling your memory image (aka "resume from disk"),
which I will _guarantee_ you is a lot faster than anything else you can
come up with, and which doesn't have the downsides that your approach has.

You know, the mark of intelligence is realizing when you're making the
same mistake over and over and over again, and not hitting your head in
the wall five hundred times before you understand that it's not a clever
thing to do.

Please show some intelligence.

			Linus

