Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbRAIV1O>; Tue, 9 Jan 2001 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132129AbRAIV1E>; Tue, 9 Jan 2001 16:27:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21511 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131841AbRAIV0w>; Tue, 9 Jan 2001 16:26:52 -0500
Date: Tue, 9 Jan 2001 13:26:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: migo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109221254.A10085@caldera.de>
Message-ID: <Pine.LNX.4.10.10101091318181.2331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Christoph Hellwig wrote:
> > 
> > Look at sendfile(). You do NOT have a "bunch" of pages.
> > 
> > Sendfile() is very much a page-at-a-time thing, and expects the actual IO
> > layers to do it's own scatter-gather. 
> > 
> > So sendfile() doesn't want any array at all: it only wants a single
> > page-offset-length tuple interface.
> 
> The current implementations does.
> But others are possible.  I could post one in a few days to show that it is
> possible.

Why do you bother arguing, when I've shown you that even if sendfile()
_did_ do multiple pages, it STILL wouldn't make kibuf's the right
interface. You just snipped out that part of my email, which states that
the networking layer would still need to do better scatter-gather than
kiobuf's can give it for multiple send-file invocations.

Let me iterate:

 - the layers like TCP _need_ to do scatter-gather anyway: you absolutely
   want to be able to send out just one packet even if the data comes from
   two different sources (for example, one source might be the http
   header, while the other source is the actual file contents. This is
   definitely not a made-up-example, this is THE example of something like
   this, and happens with just about all protocols that have a notion of 
   a header, which is pretty much 100% of them).

 - because TCP needs to do scatter-gather anyway across calls, there is no
   real reason for sendfile() to do it. And sendfile() doing it would
   _not_ obviate the need for it in the networking layer - it would only
   add complexity for absolutely no performance gain.

So neither sendfile _nor_ the networking layer want kiobuf's. Never have,
never will. The "half-way scatter-gather" support they give ends up either
being too much baggage, or too little. It's never the right fit.

kiovec adds the support for true scatter-gather, but with a horribly bad
interface, and much too much overhead - and absolutely NO advantages over
the _proper_ array of <page-offset-tuple> which is much simpler than the
complex two-level arrays that you get with kiovec+kiobuf.

End of story.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
