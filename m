Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRGSQsF>; Thu, 19 Jul 2001 12:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRGSQr4>; Thu, 19 Jul 2001 12:47:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:43268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265042AbRGSQrn>; Thu, 19 Jul 2001 12:47:43 -0400
Date: Thu, 19 Jul 2001 09:46:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Dave McCracken <dmc@austin.ibm.com>, Dirk Wetter <dirkw@rentec.com>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.33L.0107191059460.13351-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107190940370.7162-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Thu, 19 Jul 2001, Rik van Riel wrote:
>
> On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
>
> > Still able to trigger the problem with the GFP_HIGHUSER patch applied.
>
> Hrrm, maybe the fact that the free target in the DMA zone is
> four times higher than in the other zones has something to do
> with the unbalance...

No, the free target is higher for the DMA zone just to make the small zone
not deplete as easily. It might make the problem slightly easier to
trigger, but I think the bassic problem is real - some zones inherently
have higher pressure on them, and those zones do need to be aged faster.

Note that most people don't see this very much, because there are happily
not that many cases where the 16MB DMA limit matters any more. These days
you're more likely to start seeing the NORMAL vs HIGHMEM zone issues,
where the NORMAL zone just automatically has more pressure because a lot
of things like the icache/dcache can only be allocated from there.

Note that the unfair aging (apart from just being a natural requirement of
higher allocation pressure) actually has some other advantages too: it
ends up being  aload balancing thing. Sure, it might throw out some things
that get "unfairly" treated, but once we bring them in again we have a
better chance of bringing them into a zone that _isn't_ under pressure.

So unfair eviction can actually end up being a natural solution to
different memory pressure too (it obviously only works if the memory
pressure isn't _too_ one-sided - if the great majority of allocations all
_have_ to be to the pressure zone, the other zones obviously have no way
to accept any of the extra pressure regardless of how hard they'd try).

		Linus

