Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272102AbRIJXF6>; Mon, 10 Sep 2001 19:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272116AbRIJXFr>; Mon, 10 Sep 2001 19:05:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:58638 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272102AbRIJXFg>; Mon, 10 Sep 2001 19:05:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 01:13:04 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010910214731Z16329-26183+884@humbolt.nl.linux.org> <1733287603.1000165191@[169.254.198.40]>
In-Reply-To: <1733287603.1000165191@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910230554Z16824-26183+920@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 12:39 am, Alex Bligh - linux-kernel wrote:
> You could look at this problem the other way around, and firstly
> say "what we have read, we shall cache, and we shall not restrict
> this to the reader who caused it to be read; and what we guess
> is going to be read by file we shall read in preparation [1]". And
> /then/ say, once you've elevator sorted the lot, that if we
> have spare I/O bandwidth etc. etc., that it might make sense
> to extend each portion of the elevator vector, especially if
> it coalesces entries together. (But no point caching stuff twice.)

Yes, that's bascially what I had in mind.  The extension of the elevator 
vector is the physical readahead.  Except I had in mind to turn it around, 
and have the logical readahead not do the readahead itself, but just guide 
the operation of the physical readahead.

> [1]=because I am assuming that this has wider applicability (NFS etc.)
> and better results (/alone/) than physical readahead, for most
> applications, not least as you can apply more intelligence at
> that level. And I am assuming any extra benefits of physical readahead
> (i.e. beyond those that would be given by an intelligent form
> of logical readahead whose results were shared) are done by the disk.
> 
> > If we implement the physical block reverse mapping as I described in an
> > earlier post then the dd technique will work fine.
> 
> I think that is nearly isomorphic to what I'm saying, but I'm not
> talking about improving just the benchmark.

We're on the same wavelength now.

> Example: writing read-ahead caching on a different OS (admittedly
> a while ago) we discovered that physical readahead was useful
> (surprise surprise) but ended up eating memory. [This was an
> environment where the readahead cache (and I/O activity) could
> live on a different processor(s) and disk I/O b/w didn't reduce
> other I/O b/w. In some senses this is a little bit similar to
> SMP. We had some memory to give away, but limited]. We discovered,
> somewhat to our surprise, that if you trapped directory enumeration,
> and read (in the background) the first few blocks of every file therein,
> you got vast performance increases over straight readahead. This
> turned out to be because this was exactly what many applications
> did. And we also saw the gain over non-physical filesystems. Now
> I have no idea whether this is the case under Linux too (almost
> a decade later), but all I'm saying is by the time you've got down
> to the block number layer, (a) you've thrown away important
> information,

Don't throw away that information then, use it as hints to guide the physical 
readahead.

> and (b) the device manufacturer has already thought
> of that, and gone done it in hardware. There's no way, however,
> they could have done the directory readahead in h/w.
> 
> >> More serious point: if we retain readahead at a
> >> logical level, you get it for non-physical
> >> files too (e.g. NFS) - I presume this is
> >> the intention. If so, what advantage does
> >> additional physical readahead give you,
> >
> > Well, you can see from my demonstration that logical readahead sucks
> > badly for this common case.
> 
> No, I see you correctly pointing out that /current/
> logical readahead can suck as the page cache cannot
> use the contents of the buffer cache.

OK, now to shorten this up, if you've reached the conclusion that the page 
cache needs to be able to take advantage of blocks already read into the 
buffer cache then we're done.  That was my point all along.

--
Daniel
