Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271759AbRH0P4g>; Mon, 27 Aug 2001 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271761AbRH0P4T>; Mon, 27 Aug 2001 11:56:19 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:60680 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271759AbRH0P4K>; Mon, 27 Aug 2001 11:56:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 18:02:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010827142441Z16237-32383+1641@humbolt.nl.linux.org> <499114355.998926919@[169.254.198.40]>
In-Reply-To: <499114355.998926919@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827155621Z16272-32385+261@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 04:42 pm, Alex Bligh - linux-kernel wrote:
> --On Monday, 27 August, 2001 4:31 PM +0200 Daniel Phillips 
> <phillips@bonn-fries.net> wrote:
> 
> >   - Readahead cache is important enough to get its own lru list.
> >     We know it's a fifo so don't have to waste cycles scanning/aging.
> >     Having a distinct list makes the accounting trivial, vs keeping
> >     readahead on the active list for example.
> 
> A nit: I think it's a MRU list you want. If you are reading
> ahead (let's have caps for a page that has been used for reading,
> as well as read from the disk, and lowercase for read-ahead that
> has not been used):
> 	ABCDefghijklmnopq
>              |            |
>             read         disk
> 	   ptr          head
> and you want to reclaim memory, you want to drop (say) 'pq'
> to get
> 	ABCDefghijklmno
> for two reasons: firstly because 'efg' etc. are most likely
> to be used NEXT, and secondly because the diskhead is nearer
> 'pq' when you (inevitably) have to read it again.

Good point.  Even with a fifo queue we can deal with this nicely by modifying 
the insertion step to scan forward past other pages of the same file.  So the 
readahead pages end up being inserted in reverse order locally, while 
chunkwise we still have a fifo.

> This seems even more imporant when considering multiple streams,
> as if you drop the least recently 'used' (i.e. read in from disk),
> you will instantly create a thrashing storm.

The object is to avoid getting into the position of having to drop readahead 
pages in the first place, by properly throttling the readahead.  When we do 
have to drop readahead it's because the active list expanded.  Hopefully we 
will stabilize soon with a shorter readahead list.  Yes, it may well be 
better to drop from the head of the queue instead of the tail because the 
dropped pages will come from a smaller set of files.  On the other hand, we 
will penalize faster streams that way.  Furthermore, sometimes readahead 
pages may never be used in which case we would keep them forever.

> And an idea: when dropping read-ahead pages, you might be better
> dropping many readahed pages for a single stream, rather than
> hitting them all equally, else they will tend to run out of
> readahead in sync.

Yes, this requirement is satisfied by the arrangement described.

--
Daniel
