Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSIEIqu>; Thu, 5 Sep 2002 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSIEIqu>; Thu, 5 Sep 2002 04:46:50 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:17561 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S316535AbSIEIqp>; Thu, 5 Sep 2002 04:46:45 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Date: Thu, 5 Sep 2002 01:43:32 -0700 (PDT)
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <3D771613.783E3B15@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0209050133260.3481-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

another problem with trying do do special things with the metadata is that
the lower layers don't have any idea what is a metadata block on disk and
what is a user data block on disk, the only thing that can tell the
difference is the filesystem that knows what it is useing the block for
(and depending on how the filesystem was created blocks on disk could have
different uses, just thing about the simple option of changing the number
of inodes allocated, blocks that are inodes in one case are data in the
other)

if making things distributed was as simple as disabling caching then SMP
programming would be simple, disable your caches and let things go,
right???

it doesn't work that easily, you need to have cooperation between
processors.

version one is to make a single lock that you grab before you do any
'special' work to prevent processors clobbering each others memory, in
linux this was the Big Kernel Lock.

it worked (sort of) but barely scaled to two CPUs

making things scale better then that requires careful analysis of the
locking that is needed and careful implementation of the locks, this is
where the linux kernel is now.

take the example above and replace procesors with systems and memory with
disk blocks and you have the problem of distributed filesystems.

just like you can't take a single threaded process, wave a magic wand
(upgrading the underlying OS) and make it use multiple processors you
can't just take a filesystem, upgrade the VFS/block layer and have it
share the same drive from multiple systems, in both cases it takes drastic
modifications that are frequently as bad or worse then writing a new
version from scratch, and in addition the new version is usually less
efficiant if run in a single CPU/system environment.

David Lang

 On Thu, 5 Sep 2002, Helge Hafting
wrote:

> Date: Thu, 05 Sep 2002 10:30:11 +0200
> From: Helge Hafting <helgehaf@aitel.hist.no>
> To: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
> Subject: Re: (fwd) Re: [RFC] mount flag "direct"
>
> "Peter T. Breuer" wrote:
>
> > > Sorry but this really shows you lack of understanding for how a file
> > > system works. Every time you write a single byte(!!!) to a file, this
> > > involves modifying fs structures. Even if you do writes in 1MiB chunks,
> >
> > OK .. in what way?
> >
> > > what happens is that all the writes are broken down into buffer head sized
> > > portions for the purposes of mapping them to disk (this is optimized by
> >
> > Well, they'll be broken down, yes, quite probably.
> >
> > > the get_blocks interface but still it means that every time get_blocks is
> >
> > You mean that the buffer cache is looked up? But we know that we have
> > disabled caching on this device ... well, carry on anyway (it does
> > no harm to write to an already dirty buffer).
> >
> > > involved you have to do a full lookup of the logical block and map it to
> > > an on disk block). For reading while you are not modifying fs structures
> > > you still need to read and parse them for each get_blocks call.
> >
> > I'm not following you. It seems to me that you are discussing the
> > process of getting a buffer to write to prior to letting it age and
> > float down to the device driver via the block layers. But we have
> > disabled caching so we know that get_blocks will deliver a new
> > temporary buffer or block or something or at any rate do what it
> > should do ... anyway, I mumble.... what you are saying is that you
> > think we look up a logical block number and get a physical block
> > number and possibly a buffer associated with it. Well, maybe. So?
> >
> Some very basic definitions that anyone working on a
> disk-based filesystem should know:
>
> Logical block number is the block's number in the file.  Example:
> "this is the 67th kilobyte of this file"
>
> Physical block number is something completely different, it
> is the block's location on disk.  Example:
> "this block is the 2676676th block on the disk drive, counting
> from the start of the drive"
>
> So, what happens when you read gigabytes of data
> to/from your files?  Something like this:
>
> 1.
> Your app asks for the first 10M or so of the file. (You're
> shuffling _big_ chunks around, possibly over the net, aren't you?)
>
> 2.
> The fs however is using a smaller blocksize, such as 4k.  So your
> big request is broken down into a bunch of requests for the
> first 4k block, the second 4k block and so on up to the
> 2560th 4k block.  So far, everything happens fast no matter
> what kind of fs, or even your no-cache scheme.
>
> 3.
> The reason for this breakup is that the file might be fragmented
> on disk.  No one can know that until it is checked, so
> each block is checked to see where it is.  The kernel
> tries to be smart and merges requests whenever the
> logical blocks in the file happens to be consecutive
> on the disk.  They usually are, for performance reasons, but
> not always.  Each logical block requested is looked up
> to see where it actually is on the disk, i.e. we're
> looking up the physical positions.
>
> 4.
> The list of physical positions (or physical blocks)
> are passed to thbe disk drivers and the read
> actually happens.  Then the os lets your app
> know that the read finished successfully and
> is ready for whatever you want to do with it.
> Then your app  goes on to read another 10M or so,
> repeat from (2) until the entire file is processed.
>
> Number (3) is where the no-cache operation breaks
> down completely.  We have to look up where on the _disk_
> _every_ small block of the file exists.  The information
> about where the blocks are is called "metadata".
> So we need to look at metadata for every little 4k block.
> That isn't a problem usually, because the metadata is
> small and is normally cached entirely, even for a large
> file.  So we can look up "wher block 1 is on disk, where block 2
> is on disk..." by looking at a little table in memory.
>
> But wait - you don't allow caching, because some other node
> may have messed with this file!
> So we have to read metadata *again* for each little
> block before we are able to read it, for you don't let
> us cache that in order to look up the next block.
>
> Now metadata is small, but the disk have to seek
> to get it.  Seeking is a very expensive operation, having
> to seek for every block read will reduce performance to
> perhaps 1% of streaming, or even less.
>
> And where on disk is the metadata for this file?
> That information is cached too, but you
> disallow caching.  Rmemeber, the cache isn't just for
> _file data_, it is for _metadata_ too.  And you can't
> say "lets cache metadata only" because then
> you need cache coherency anyway.
>
> And as Anton Altaparmakov pointed out, finding the metadata
> for a file with _nothing_ in cache requires several
> reads and seeks.  You end up with 4 or more seeks and
> small reads for every block of your big file.
>
> With this scheme, you need thousands of pcs just to match
> the performance of a _single_ pc with caching, because
> the performance of _one_ of your nodes will be so low.
>
>
>
> > > This in turn means that each call to get_blocks within the direct_IO code
> > > paths will result in a full block lookup in the filesystem driver.
> >
> > Uh, I'm not sure I understand any of this. You are saying something
> > about logical/physical that I don't follow or don't know. In
>
> Take a course in fs design, or read some books at least.  Discussion
> is pointless when you don't know the basics - it is like discussing
> advanced math with someone who is eager and full of ideas but
> know the single-digit numbers only.
> You can probably come up with something interesting _when_ you
> have learned how filesystems actually works - in detail.
> If you don't bother you'll end up a "failed visionary".
>
> > direct IO, one of the things that I believe happens is that writes are
> > serialized, in order to maintain semantics when we go RWRW (we don't
> > want it to work like WRWR or other), so that overlaps cannot happen.
> > We should never be in the situation of having a dirty (or
> > cached) buffer that we rewrite before it goes to disk (again).
> >
> > Is that relevant?
> Both irrelevant and wrong.  Direct io isn't serialized, but
> it don't matter.
>
>
> > > I explained in a previous post how incredibly expensive that is.
> >
> > Well, I simply don't follow you here. Can you unmuddle my understanding
> > of what you are saying about logical/physical?
> >
> > > So even though you are streaming GiB of /data/ you will end up streaming
> > > TiB of /metadata/ for each GiB of /data/. Is that so difficult to
> > > understand?
> >
> > Yep. Can you be concrete about this metadata? I'lll see if I can work
> > it out ..
> Explained above.  Metadata is the information about where on disk
> the file blocks is.  And the filename.  And the directory
> structure.  The info about how big the file is and who
> is allowed to read/write it.  And all of it is stored on
> the disk.  The inode is metadata, and contains the disk
> addresses for other metadata for that file.  But
> where is the inode located?  That information is
> in the directory entry, looked up from the filename.
>
> > what I think you must be saying is that when we write to
> > a file, we write to a process address space, and that has to be
> > translated into a physical block number on disk.
> Sort of orrect if you're writing to a mmapped file.
>
> > Well, but I imagine
> > that the translation was settled at the point that the inode was first
> > obtained,
> Plain wrong.  _Each block_ needs this translation, because the
> file might be fragmented.  Oh, and don't forget that _you_
> aren't allowed to keep an inode around - unless you
> do cache coherency for inodes.  Another node
> in your cluster might delete the file after all,
> destroying the indode!  So _you_ have to re-read the inode
> for every little block read or written.  We don't, we
> keep the inode in the icache.  But you says "no cache,
> cache coherency is too hard!"
>
> > and now that we have the inode, data that goes to it gets
> > a physical address from the data in the inode. We can even be using an
> > inode that is unconnected to the FS, and we will still be writing away
>
> What is an inode "unconnected to the FS".  Please explain?
> An inode is a part of fs metadata - per definition!
>
> > to disk, and nobody else will be using that space, because the space
> > is marked as occupied in the bit map.
> How do you know, without a cache-coherent bitmap?  A normal fs knows,
> because it can look up the bitmap is cached.  You have
> to re-read it everytime.  And where on disk is the bitmap?
> That too is something you have to check for every block read.
> After all, someone else may have created a new file
> or even deleted yours.
>
> > I see no continuous lookup of metadata.
> The inode and bitmap you speak of are both "metadata".  Anything that
> isn't your file but describes things like where the file blocks
> are, which blocks are free, or how the fs is organized is metadata.
>
> It is all on disk, it is normally cached, and it all requires
> cache coherency in i cluster.
>
> This is why I suggested a new fs, you may then organize the
> metadata such that different nodes _can_ cache metadata
> for _different_ files over time.  Or even for different parts
> of the same file.
> >
> > > Unless you allow the FS to cache the /metadata/ you have already lost all
> >
> > What metadata? I only see the inode, and that's not cached in any
> > meaningful sense (i.e. not available to other things) to but simply
> > "held" in kmem storage and pointed to.
> That _is_ caching.  But what if another node deletes or changes
> the file you're working on?  That leaves you with a invalid
> inode.  Not a problem on smp, where all the processors access
> the same memory.  One cpu can change the inode and then
> it is changed for the others as well.  A cluster don't
> work that way because the others can't access the memory
> with the inode directly.
>
> >
> > > your performance and you will never be able to stream at the speads you
> > > require.
> >
> > Can you be even MORE specific about what this metadata is? Maybe I'll
> > get it if you are very very specific.
> See above!
> > > So far you are completely ignoring my comments. Is that because you see
> > > they are true and cannot come up with a counter argument?
> >
> > Normal users should see no difference, because they won't turn  on
> > O_DIRDIRECT, or whatever, and it should make no difference to them
> it is O_DIRECT
> > that the dir cache /can/ be turned off. That should be a goal, anyway.
> > Can it be done? I think so, at least if it's restricted to directory
> > lookup in the first instance, but I would like your very concrete
> > example of what cached metadata is changed when I do a data write.
> >
> What cached metadata is changed when you write?
> First, the file size.  Second, access time.  the free block
> bitmap, because you use up free blocks when writing.
> Then there is the file's block layout, the information about where
> on the disk your data blocks go. Every block must be written
> _somewhere_ on disk, exactly where is recorded in the file's
> metadata pointed to by the inode.
>
> > > generic kernel cater for your specialised application which will be used
> > > on a few systems on the planet when you would penalize 99.99999% of Linux
> > > users with your solution.
> >
> > Where is the penalty?
> Turning off the cache is big penalty.  It makes even _your own_
> use slow.  Remember, the cache isn't only about file blocks,
> it is also about metadata that is consulted all the time.
>
> And remember that the majority of linux users aren't running your
> special app.  They are running editors, compilers
> and web servers, which all benefit greatly from caching. Turning
> off chaching for those uses _will_ make ordinary
> operations take a thousand time as long - or worse.
>
> Suggesting to remove caching is like suggesting to remove
> the engines from cars - most car problems is with the
> engine and it would reduce pollution too.  The suggestion may
> seem smart fro someone who have no idea what the engine
> is for.  For everybode else it seems crazy.
>
> > > The only viable solution which can enter the generic kernel is to
> > > implement what you suggest at the FS level, not the VFS/block layer
> > > levels.
> >
> > Why? Having VFS ops available does not mean you are obliged to use
> > them! And useing them means swapping them in via a pointer indirection,
> > not testing a flag always.
> >
> > > Of course if you intend to maintain your solution outside the kernel as a
> > > patch of some description until the end of time then that's fine. It is
> > > irrelevant what solution you choose and noone will complain as you are not
> > > trying to force it onto anyone else.
> >
> > I think you are imagining implementation that are simply not the way
> > I imagine them. Can you be specific about the exact metadata that is
> > changed when a data write is done? That will help me decide.
>
> Again, see above.  And it isn't merely about what metadata _changes_.
> It is also about what metadata needs to be _looked at_.  You
> can't even _read_ a single block from a file without looking up
> where on disk that block is.  You can't try to design
> filesystems while overlooking elementary stuff like that.
> And people are probably tired of explaining simple stuff.  Read
> a good book on fs design, or write code and impress us.
>
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
