Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268417AbRGXSKW>; Tue, 24 Jul 2001 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRGXSKM>; Tue, 24 Jul 2001 14:10:12 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:48393 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268419AbRGXSJz>; Tue, 24 Jul 2001 14:09:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Optimization for use-once pages
Date: Tue, 24 Jul 2001 20:14:36 +0200
X-Mailer: KMail [version 1.2]
Cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241359180.20326-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107241359180.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01072420143600.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 19:04, Rik van Riel wrote:
> On Tue, 24 Jul 2001, Linus Torvalds wrote:
> > Hey, this looks _really_ nice. I never liked the special-cases
> > that you removed (drop_behind in particular), and I have to say
> > that the new code looks a lot saner, even without your extensive
> > description and timing analysis.
>
> Fully agreed, drop_behind is an ugly hack.  The sooner
> it dies the happier I am ;)
>
> > Please people, test this out extensively - I'd love to integrate
> > it, but while it looks very sane I'd really like to hear of
> > different peoples reactions to it under different loads.
>
> The one thing which has always come up in LRU/k and 2Q
> papers is that the "first reference" can really be a
> series of references in a very short time.

Yes, I thought about that but decided to try to demonstrate the
concept in its simplest form, and if things worked out, go ahead
and try to refine it.

Memory-mapped files have to be handled too.  One possible way to
go at it is to do the test not against the current page being
handled by generic_* but against the page already on the head of
the inactive_dirty list, at the time the *next* page is queued.
This introduces a slight delay, time enough for several programmed
IO operations to complete.  It will also work for mmap.  As a
bonus, the code might even get cleaner because all the use_once
tests are gathered together into a single place.

> Counting only the very first reference will fail if we
> do eg. sequential IO with non-page aligned read() calls,
> which doesn't look like it's too uncommon.

Yep.  We should also look at some statistics.  So far I've just
used a single number: execution time.

> In order to prevent this from happening, either the system
> counts all first references in a short timespan (complex to
> implement) or it has the new pages on a special - small fixed
> size - page list and all references to the page while on that
> list are ignored.

Yes, those are both possibilities.

--
Daniel
