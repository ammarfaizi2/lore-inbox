Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRH0WYq>; Mon, 27 Aug 2001 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRH0WYh>; Mon, 27 Aug 2001 18:24:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19216 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269489AbRH0WYC>; Mon, 27 Aug 2001 18:24:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Tue, 28 Aug 2001 00:30:46 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <200108271953.VAA20749@ns.cablesurf.de> <200108272144.f7RLi1707676@penguin.transmeta.com>
In-Reply-To: <200108272144.f7RLi1707676@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827222413Z16102-32383+1776@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 11:44 pm, Linus Torvalds wrote:
> In article <20010827203125Z16070-32383+1731@humbolt.nl.linux.org> you write:
> >On August 27, 2001 09:43 pm, Oliver Neukum wrote:
> >> 
> >> If we are optimising for streaming (which readahead is made for) dropping 
> >> only one page will buy you almost nothing in seek time. You might just as 
> >> well drop them all and correct your error in one larger read if necessary.
> >> Dropping the oldest page is possibly the worst you can do, as you will need 
> >> it soonest.
> >
> >Yes, good point.  OK, I'll re-examine the dropping logic.  Bear in mind, 
> >dropping readahead pages is not supposed to happen frequently under 
> >steady-state operation, so it's not that critical what we do here, it's going 
> >to be hard to create a load that shows the impact.  The really big benefit 
> >comes from not overdoing the readahead in the first place, and not underdoing 
> >it either.
> 
> Note that the big reason why I did _not_ end up just increasing the
> read-ahead value from 31 to 511 (it was there for a short while) is that
> large read-ahead does not necessarily improve performance AT ALL,
> regardless of memory pressure. 
> 
> Why? Because if the IO request queue fills up, the read-ahead actually
> ends up waiting for requests, and ends up being synchronous. Which
> totally destroys the whole point of doing read-ahead in the first place.
> And a large read-ahead only makes this more likely.
> 
> Also note that doing tons of parallel reads _also_ makes this more
> likely, and actually ends up also mixing the read-ahead streams which is
> exactly what you do not want to do.
> 
> The solution to both problems is to make the read-ahead not wait
> synchronously on requests - that way the request allocation itself ends
> up being a partial throttle on memory usage too, so that you actually
> probably end up fixing the problem of memory pressure _too_.
> 
> This requires that the read-ahead code would start submitting the blocks
> using READA, which in turn requires that the readpage() function get a
> "READ vs READA" argument.  And the ll_rw_block code would obviously have
> to honour the rw_ahead hint and submit_bh() would have to return an
> error code - which it currently doesn't do, but which should be trivial
> to implement. 
> 
> I really think that doing anything else is (a) stupid and (b) wrong.
> Trying to come up with a complex algorithm on how to change read-ahead
> based on memory pressure is just bound to be extremely fragile and have
> strange performance effects. While letting the IO layer throttle the
> read-ahead on its own is the natural and high-performance approach.

In the real-world case we observed the readahead was actually being
throttled by the ftp clients.  IO request throttling on the file read
side would not have prevented cache from overfilling.  Once the cache
filled up, readahead pages started being dropped and reread, cutting
the server throughput by a factor of 2 or so.  On the other hand,
performance with no readahead was even worse.

The solution was to set readahead down to a low enough number so that
the maximum number of clients allowed would not overfill the cache.
This is clearly fragile since an extra load on the machine from any
source could send the machine back into readahead-thrash mode.

--
Daniel
