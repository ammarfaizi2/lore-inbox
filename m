Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271613AbRHXXDi>; Fri, 24 Aug 2001 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271614AbRHXXD2>; Fri, 24 Aug 2001 19:03:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12817 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271613AbRHXXDT>; Fri, 24 Aug 2001 19:03:19 -0400
Date: Fri, 24 Aug 2001 20:03:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010824210523Z16096-32383+1216@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108241955440.31410-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Daniel Phillips wrote:

> > Actually, no.  FIFO would be ok if you had ONE readahead
> > stream going on, but when you have multiple readahead
> > streams going on you want to evict the data each of the
> > streams has already used, and not all the readahead data
> > which happened to be read in first.
>
> We will be fine up until the point that the set of all readahead
> fills the entire cache, then we will start dropping *some* of
> the readahead.  This will degrade gracefully: if the set of
> readahead is twice as large as cache then half the readahead
> will be dropped.  We will drop the readahead in coherent chunks
> so that it can be re-read in one disk seek.  This is not such
> bad behaviour.

The problem is that it WON'T degrade gracefully. Suppose we
have 5 readahead streams, A B C D and E, and we can store
4 readahead windows in RAM without problems. A page which has
not yet been read is marked with a capital letter, a page
which has already been read is marked with a small letter.

The queue looks like this, with new pages being added to the
front and old pages being dropped off the right side:
	AAaaBBbbCCccDDdd

With the current use-once thing, we will end up dropping ALL
pages from file D, even the ones we are about to use (DDdd).

With drop-behind we'll drop four pages we have already used,
without affecting the pages we are about to use (dcba).


> That said, I think I might be able to come up with something
> that uses specific knowledge about readahead to squeeze a little
> better performance out of your example case without breaking
> loads that are already working pretty well.  It will require
> another lru list - this is not something we want to do right
> now, don't you agree?

Ummm, if you're still busy trying to come up with the idea,
how do you already know your future idea will require an extra
LRU list? ;)

cheers,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

