Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310170AbSCGWES>; Thu, 7 Mar 2002 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293714AbSCGWEK>; Thu, 7 Mar 2002 17:04:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39684 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293726AbSCGWD5>;
	Thu, 7 Mar 2002 17:03:57 -0500
Message-ID: <3C87E35E.B841801D@zip.com.au>
Date: Thu, 07 Mar 2002 14:02:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, yodaiken@fsmlabs.com,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87D40C.603DE513@zip.com.au> <Pine.LNX.4.44L.0203071818140.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 7 Mar 2002, Andrew Morton wrote:
> 
> > > Nope.  Readahead pages are clean and very easy to evict, so
> > > it's still trivial to evict all the pages from another readahead
> > > window because everybody's readahead window is too large.
> 
> > Any clever ideas?
> 
> 1) keep track of which pages we are reading ahead
>    ... the readahead code already does this
> 
> 2) at read() or fault time, see if the page
>    (a) is resident
>    (b) is in the current readahead window,
>        ie. already read ahead
> 
> 3) if the page is in the current readahead window
>    but NOT resident, the page was read in and
>    evicted before we got around to using it, so
>    readahead window thrashing is going on
>    ... in that case, collapse the size of the
>    readahead window TCP-style

I have all that.  See handle_ra_thrashing() in 
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre2/dallocbase-10-readahead.patch

> 4) slowly growing the readahead window when there is
>    enough memory available, in order to minimise the
>    number of disk seeks
> 
> 5) the growing in (3) and shrinking in (4) mean that
>    the readahead size of all streaming IO in the system
>    gets automatically balanced against each other and
>    against other memory demand in the system

Doesn't work.

Ah, this is hard to describe.

umm.

a) Suppose that we're getting readahead thrashing.  readahead
   pages are getting dropped.  So we keep seeking to each
   file to get new data, so we do a ton of seeking.

b) Suppose that we nicely detect thrashing and reduce the readahead
   window.  Well, we *still* need to seek to each file to read
   some blocks.

See?  They're equivalent.  In case a) we're doing more (pointless)
I/O, but the cost of that is vanishingly small because it's just
one request.

So what *is* a solution.  Well, there's only so much memory available.
In either case a) or case b) we're "fairly" distributing that memory
between all files.  And that's the problem.  *All* the files have too
small a readahead window.  Which points one at: we need to stop being
fair. We need to give some files a good readahead window and others
not.   The "soft pinning" which I propose with GFP_READAHEAD and
PG_readhead might have that effect, I think.

I'll try it, see how it feels.

-
