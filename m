Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269962AbRH1A2n>; Mon, 27 Aug 2001 20:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRH1A2e>; Mon, 27 Aug 2001 20:28:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19208 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269962AbRH1A2Y>; Mon, 27 Aug 2001 20:28:24 -0400
Date: Mon, 27 Aug 2001 20:00:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <200108272144.f7RLi1707676@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0108271954540.7385-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Aug 2001, Linus Torvalds wrote:

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

Its not easy to do.

It would be needed to pass a "READ or READA" flag to get_block_t calls
too, which in turn would end up in a lot of code changes on the low level
filesystems.

Reading metadata to map data which you're not going to read is pretty
stupid.

I'm looking forward to "re-implement" the READA/WRITEA logic for 2.5. 

Do you have any idea/comments on how to do that with the smaller amount of
pain ?



