Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271894AbRIJVr2>; Mon, 10 Sep 2001 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271888AbRIJVrT>; Mon, 10 Sep 2001 17:47:19 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:62216 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271877AbRIJVrL>; Mon, 10 Sep 2001 17:47:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 23:54:39 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010910211135Z16537-26183+875@humbolt.nl.linux.org> <1728722119.1000160593@[169.254.198.40]>
In-Reply-To: <1728722119.1000160593@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910214731Z16329-26183+884@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 11:23 pm, Alex Bligh - linux-kernel wrote:
> --On Monday, 10 September, 2001 11:18 PM +0200 Daniel Phillips 
> <phillips@bonn-fries.net> wrote:
> 
> > We lost 78.5 seconds somewhere.  From the sound of the disk drives, I'd
> > say  we lost it to seeking, which physical readahead with a large cache
> > would be  able to largely eliminate in this case.
> 
> So you only get a large % of your 78.5 seconds back
> from pure physical readahead if the files and metadata
> are (a) ordered in monitonically increasing disk
> locations w.r.t. access order, and

Well, no, that's one of the benefits of physical readahead: it is far less 
sensitive to disk layout than file-base readahead.

> (b) physically close (no time wasted reading in irrelevant data),

You mean, well clustered, which it is.  These trees were created by an untar 
onto an otherwise relatively young filetree.  I could repeat the experiment 
on a partition with nothing but this source on it.  I would expect similar 
results.

> or you apply some
> form of clairvoyance patch :-) An alternative benchmark
> would be do dd the /entire/ disk into RAM, then
> run your diff on that, and I bet you get the
> opposite result.

Doesn't this just support what I'm saying?  Anyway, the dd trick won't work 
because the page cache has no way of using the contents of the buffer cache.  
It has to re-read it even though it's already in memory - this is ugly, don't 
you agree?  When we make dd use the page cache as with Andrea's patch it 
still won't work because the page cache will still ignore blocks that already 
exist in the buffer cache mapping.

Because we're still using the buffer cache for metadata there will be some 
improvement with the dd trick, but not enormous.  I can't take the time to 
test it right now, but I will.

If we implement the physical block reverse mapping as I described in an 
earlier post then the dd technique will work fine.

> More serious point: if we retain readahead at a
> logical level, you get it for non-physical
> files too (e.g. NFS) - I presume this is
> the intention. If so, what advantage does
> additional physical readahead give you,

Well, you can see from my demonstration that logical readahead sucks 
badly for this common case.  I did mention that the two can coexist, didn't 
I?  In fact they already do on any system with a caching disk controller.  
Just not enough to handle two kernel trees.

> given physical ordering is surely no better
> (and probably worse than) logical ordering.

I'd have a good think about that 'surely'.

--
Daniel
