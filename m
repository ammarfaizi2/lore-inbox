Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272367AbRHYAfQ>; Fri, 24 Aug 2001 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272365AbRHYAfL>; Fri, 24 Aug 2001 20:35:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:49931 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272366AbRHYAe7>; Fri, 24 Aug 2001 20:34:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 02:41:46 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108241955440.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108241955440.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825003508Z16139-32383+1258@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 01:03 am, Rik van Riel wrote:
> On Fri, 24 Aug 2001, Daniel Phillips wrote:
> 
> > > Actually, no.  FIFO would be ok if you had ONE readahead
> > > stream going on, but when you have multiple readahead
> > > streams going on you want to evict the data each of the
> > > streams has already used, and not all the readahead data
> > > which happened to be read in first.
> >
> > We will be fine up until the point that the set of all readahead
> > fills the entire cache, then we will start dropping *some* of
> > the readahead.  This will degrade gracefully: if the set of
> > readahead is twice as large as cache then half the readahead
> > will be dropped.  We will drop the readahead in coherent chunks
> > so that it can be re-read in one disk seek.  This is not such
> > bad behaviour.
> 
> The problem is that it WON'T degrade gracefully. Suppose we
> have 5 readahead streams, A B C D and E, and we can store
> 4 readahead windows in RAM without problems. A page which has
> not yet been read is marked with a capital letter, a page
> which has already been read is marked with a small letter.
> 
> The queue looks like this, with new pages being added to the
> front and old pages being dropped off the right side:
> 	AAaaBBbbCCccDDdd
> 
> With the current use-once thing, we will end up dropping ALL
> pages from file D, even the ones we are about to use (DDdd).

I call that gracefull.  Look, you only lost 2 pages out of 16, and when you 
have to re-read them it will be a clustered read.  It's just not that big a 
deal.

> With drop-behind we'll drop four pages we have already used,
> without affecting the pages we are about to use (dcba).

Well, yes, but you will also drop that header file your compiler wants to 
read over and over.  How do you tell the difference?  There are lots of nice 
things you can do if your algorithm can assume omniscience.

> > That said, I think I might be able to come up with something
> > that uses specific knowledge about readahead to squeeze a little
> > better performance out of your example case without breaking
> > loads that are already working pretty well.  It will require
> > another lru list - this is not something we want to do right
> > now, don't you agree?
> 
> Ummm, if you're still busy trying to come up with the idea,
> how do you already know your future idea will require an extra
> LRU list? ;)

Because it's still in the conceptual stage.  Point taken about the readahead, 
it wants to have a higher priority than used-once pages.  If marked in some 
way, the readahead pages could start on the active ring then be moved 
immediately to the inactive queue when first used, or after being fully aged 
if unused.  Write pages on the other hand want to start on the inactive list. 
With our current page cache factoring this is a bit of a pain to implement.

My point is, even with the case you supplied the expected behaviour of the 
existing algorithm is acceptable.  There is no burning fire to put out, not 
here anyway.

--
Daniel

--
Daniel
