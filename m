Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272080AbRIJWkD>; Mon, 10 Sep 2001 18:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272079AbRIJWjz>; Mon, 10 Sep 2001 18:39:55 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:11713 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272080AbRIJWjm>;
	Mon, 10 Sep 2001 18:39:42 -0400
Date: Mon, 10 Sep 2001 23:39:51 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1733287603.1000165191@[169.254.198.40]>
In-Reply-To: <20010910214731Z16329-26183+884@humbolt.nl.linux.org>
In-Reply-To: <20010910214731Z16329-26183+884@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

(apologies for reorder)

> Doesn't this just support what I'm saying?  Anyway, the dd trick won't
> work  because the page cache has no way of using the contents of the
> buffer cache.

You have nicely illustrated an assumption of mine which was:

>   It has to re-read it even though it's already in memory -
> this is ugly, don't  you agree?  When we make dd use the page cache as
> with Andrea's patch it  still won't work because the page cache will
> still ignore blocks that already  exist in the buffer cache mapping.

Doing logical as opposed to physical readahead is at least theoretically
orthogonal to whether or not caching 'product' is available per
reader/file or on a system wide basis.

You could look at this problem the other way around, and firstly
say "what we have read, we shall cache, and we shall not restrict
this to the reader who caused it to be read; and what we guess
is going to be read by file we shall read in preparation [1]". And
/then/ say, once you've elevator sorted the lot, that if we
have spare I/O bandwidth etc. etc., that it might make sense
to extend each portion of the elevator vector, especially if
it coalesces entries together. (But no point caching stuff twice.)

[1]=because I am assuming that this has wider applicability (NFS etc.)
and better results (/alone/) than physical readahead, for most
applications, not least as you can apply more intelligence at
that level. And I am assuming any extra benefits of physical readahead
(i.e. beyond those that would be given by an intelligent form
of logical readahead whose results were shared) are done by the disk.

> If we implement the physical block reverse mapping as I described in an
> earlier post then the dd technique will work fine.

I think that is nearly isomorphic to what I'm saying, but I'm not
talking about improving just the benchmark.

Example: writing read-ahead caching on a different OS (admittedly
a while ago) we discovered that physical readahead was useful
(surprise surprise) but ended up eating memory. [This was an
environment where the readahead cache (and I/O activity) could
live on a different processor(s) and disk I/O b/w didn't reduce
other I/O b/w. In some senses this is a little bit similar to
SMP. We had some memory to give away, but limited]. We discovered,
somewhat to our surprise, that if you trapped directory enumeration,
and read (in the background) the first few blocks of every file therein,
you got vast performance increases over straight readahead. This
turned out to be because this was exactly what many applications
did. And we also saw the gain over non-physical filesystems. Now
I have no idea whether this is the case under Linux too (almost
a decade later), but all I'm saying is by the time you've got down
to the block number layer, (a) you've thrown away important
information, and (b) the device manufacturer has already thought
of that, and gone done it in hardware. There's no way, however,
they could have done the directory readahead in h/w.

>> More serious point: if we retain readahead at a
>> logical level, you get it for non-physical
>> files too (e.g. NFS) - I presume this is
>> the intention. If so, what advantage does
>> additional physical readahead give you,
>
> Well, you can see from my demonstration that logical readahead sucks
> badly for this common case.

No, I see you correctly pointing out that /current/
logical readahead can suck as the page cache cannot
use the contents of the buffer cache.

> I did mention that the two can coexist,
> didn't  I?  In fact they already do on any system with a caching disk
> controller.   Just not enough to handle two kernel trees.

All I'm saying is we already have 2 layers of cache: disk
controller, and logical readahead (though it seems the
latter needs fixing). If you add a third between them
(in kernel physical caching) better it has some intelligence
(i.e. information), or ability (your suggestion: proximity
of well clustered files) sufficient to justify its presence.

>> given physical ordering is surely no better
>> (and probably worse than) logical ordering.
>
> I'd have a good think about that 'surely'.

By 'better' I meant 'gives no more information to a
caching algorithm, given we have it at the physical
layer (disk) anyway'.

What your benchmark seems to argue is that the disk's
physical readahead cache needs to be supplemented. I don't
necessarily disagree. But what readahead, and what cache?

Extraneous nits:

>> (a) ordered in monitonically increasing disk
>> locations w.r.t. access order, and
>
> Well, no, that's one of the benefits of physical readahead: it is far
> less  sensitive to disk layout than file-base readahead.

1. Hangon, if it's like that on disk, the disk  will have
   (physical) read ahead into its onboard cache, but...

2. Assume no (or ineffective) disk cache. You miss the point. If the
   data is stored on disk in a different physical order from that in
   which it is accessed, not only will you seek, but you will now
   read unnecessary data. As we are picking the kernel as our example
   du jour, consider untar linux kernel to disk, reboot machine,
   compile. Now are all those .c files, and (worse) .h files read
   in the same order they were written to disk? Sure, you may accidentally
   end up reading ahead data that you need later, but 150Mb is a pretty
   large data set to iterate over; how much of the job does the on-disk
   cache do for you? And where is the rest best done? We have finite
   amounts of memory, and I/O b/w, and using them maximally intelligently
   is a good thing. Your argument before was that I/O b/w was cheap,
   and memory was cheap. So should we make a RAM image of the entire
   disk? No. Selecting the bits to transfer with maximum intelligence
   is the key.

>> (b) physically close (no time wasted reading in irrelevant data),
>
> You mean, well clustered, which it is.

Because (as you say below) you untarred it clean. It
needs to be both clustered, and accessed in the same
order, more than once, was my point. And I wonder
how often this occurs (yes, tar then diff is a
valid example).

--
Alex Bligh
