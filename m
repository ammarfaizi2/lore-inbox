Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135412AbRAYMbK>; Thu, 25 Jan 2001 07:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRAYMbA>; Thu, 25 Jan 2001 07:31:00 -0500
Received: from hermes.mixx.net ([212.84.196.2]:28434 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129511AbRAYMaz>;
	Thu, 25 Jan 2001 07:30:55 -0500
From: Daniel Phillips <phillips@innominate.de>
To: David Wragg <dpw@doc.ic.ac.uk>, "Benjamin C.R. LaHaise" <blah@kvack.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Random thoughts on sustained write performance
Date: Thu, 25 Jan 2001 11:06:00 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.3.96.1010123205643.7482A-100000@kanga.kvack.org> <y7r7l3ldzxp.fsf@sytry.doc.ic.ac.uk>
In-Reply-To: <y7r7l3ldzxp.fsf@sytry.doc.ic.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Message-Id: <01012513283301.19696@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, David Wragg wrote:
> "Benjamin C.R. LaHaise" <blah@kvack.org> writes:
> > On 24 Jan 2001, David Wragg wrote:
> > 
> > > ebiederm@xmission.com (Eric W. Biederman) writes:
> > > > Why do you need such a large buffer? 
> > > 
> > > ext2 doesn't guarantee sustained write bandwidth (in particular,
> > > writing a page to an ext2 file can have a high latency due to reading
> > > the block bitmap synchronously).  To deal with this I need at least a
> > > 2MB buffer.
> > 
> > This is the wrong way of going about things -- you should probably insert
> > the pages into the page cache and write them into the filesystem via
> > writepage. 
> 
> I currently use prepare_write/commit_write, but I think writepage
> would have the same issue: When ext2 allocates a block, and has to
> allocate from a new block group, it may do a synchronous read of the
> new block group bitmap.  So before the writepage (or whatever) that
> causes this completes, it has to wait for the read to get picked by
> the elevator, the seek for the read, etc.  By the time it gets back to
> writing normally, I've buffered a couple of MB of data.

I'll add my $0.02 here.  Besides reading the block bitmap you may have
to read up to three levels of file index blocks as well.  If we stop
pinning the group descriptors in memory you might need to read those as
well.  So this adds up to 4-5 reads, all synchronous.  Worse, the
bitmap block may be widely separated from the index blocks, in turn
widely separated from the data block, and if group descriptors get
added to the mix you may have to seek across the entire disk.  This all
adds up to a pretty horrible worst case latency. 

Mapping index blocks into the page cache should produce a noticable
average case improvement because we can change from a top-down
traversal of the index hierarchy:

  - get triple-indirect index block nr out of inode, getblk(tind)
  - get double-ind nr, getblk(dind)
  - get indirect nr, getblk(ind)

to bottom-up:

  - is the indirect index block in the page cache? 
  - no? this is it mapped and just needs to be reread?
  - no? then is the double-indirect block there?
  - yes? ah, now we know the block nr of the triple-indirect block,
    map it and read it in and we're done.

The common case for the page cache is even better:

  - is the indirect index block in the page cache? 
  - yes, we're done.

The page cache approach is so much better because we directly compute
the page cache index at which we should find the bottom-level index
block.  The buffers-only approach requires us to traverse the whole
chain every time.

We are doing considerably less hashing with the page cache approach
(because we can directly compute the page cache index at which we
should find the bottom level index block) and we'll avoid some reads. 
Note: in case anybody thinks avoiding hashing is unimportant, we *are*
wasting too much cpu in ext2, just look at the cpu numbers for dbench
runs and you'll see it clearly.

Getting back on-topic, we don't improve the worst case behaviour at all
with the page-cache approach, which is what matters in rate-guaranteed
io.  So the big buffer is still needed, and it might need to be even
bigger than suggested.  If we are *really* unlucky and everything is
not only out of cache but widely separated on disk, we could be hit
with 4 reads at 5 ms each, total 20 ms.  If the disk transfers 16
meg/sec (4 blocks/ms) and we're generating io at 8 meg/sec (2
blocks/ms) then the metadata reads will create a backlog of 80 blocks
which will take 40 ms to clear - hope we don't hit more synchronous
reads during that time.

Clearly, we can construct a worst case that will overflow any size
buffer.  Even though the chances of that happening may be very small,
we have so many users that somebody, somewhere will get hit by it. 
It's worth having a good think to see if there's a nice way to come up
with a rate guarantee for ext2.  Mapping metadata into the page cache
seems like it's heading in the right design direction, but we also
need to think about some organized way of memory-locking the higher
level, infrequently accessed index blocks to prevent them from
contributing to the worst case.

Another part of the rate-guarantee is physical layout on disk: we
*must* update index blocks from time to time.  With streaming writes,
after a while they tend to get very far from where the write activity
is taking place and seek times start to hurt.  The solution is to
relocate the whole chain of index blocks from time to time,
which sounds a lot like what Tux2 does in normal operation.  This
behaviour can be added to Ext2/Ext3 quite easily.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
