Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSIFJAu>; Fri, 6 Sep 2002 05:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSIFJAt>; Fri, 6 Sep 2002 05:00:49 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13585 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318283AbSIFJAn>; Fri, 6 Sep 2002 05:00:43 -0400
Message-ID: <3D786FFC.EEEA89E1@aitel.hist.no>
Date: Fri, 06 Sep 2002 11:06:04 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux-kernel@vger.kernel.org
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
References: <200209051424.g85EOx105274@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> HI .. I'm currently in an internet cafe in nice, france, watching the
> rain come down, so forgive me if I don't do you justice. I find this
> reply to be excelent for my purposes. Thank you.

Hope you get some better weather soon. :-)

> "Helge Hafting wrote:"
> > "Peter T. Breuer" wrote:
> > > I'm not following you. It seems to me that you are discussing the
> > > process of getting a buffer to write to prior to letting it age and
> > > float down to the device driver via the block layers. But we have
>     ...
> 
> > Some very basic definitions that anyone working on a
> > disk-based filesystem should know:
> 
> Thanks.
> 
[...]
> 
> > 2.
> > The fs however is using a smaller blocksize, such as 4k.  So your
> > big request is broken down into a bunch of requests for the
> > first 4k block, the second 4k block and so on up to the
> > 2560th 4k block.  So far, everything happens fast no matter
> > what kind of fs, or even your no-cache scheme.
> 
> Fine, but where is the log/phys translation done? 

In the filesystem specific code, because different
filesystems have different ways of storing the log/phys
translation information.  The format of this information
is one of the things that makes filesystems different.

application asks VFS to read large amount from a file,
VFS repeatedly asks FS to provide one block from the file,
FS uses metadata (from cache, asking the block device to read 
it into cache if it isn't there already) to look up
where on disk the block is, then FS asks the block
device to "read that block into process memory."

> I presume that the
> actual inode contains sufficient info to do the translation,

No, it doesn't.  Some filesystems manage to squeeze all the translation
information into the inode for rather small files.  But you are
going to deal with big files.

Be aware that inodes are small fixed size things.  (For performance)
They do, however, contain pointers to more information when
that is necessary.

Remember, logical->physical translation needs to be done for
each disk block.  (4k or so)  That means such information
is stored somewhere - for each disk block.  Traditional
unix block-based filesystems (like ext2) store one disk
address per disk block, meaning the size of this metadata is
proportional to the file size.  Translation
information is about 1/1024 of file size, so a 1GB file
has about 1M of translation info and so on.  This don't
fit in a fixed-size inode that is smaller than a single disk block.

The first few blocks of a file is usually specified in the inode
itself, as a performance optimization for small files. The rest is
stored using indirect blocks.  (Blocks full of disk addresses)

The (unix) inode contains a disk address for a indirect block,
this one is full of disk addresses mapping 1024 file blocks in
the case of 4k blocks and 4-byte disk addresses.
That may not be enough either, so the inode also have a disk
address for a double indirect block.  That one holds
1024 disk addresses for more indirect blocks, each holding
1024 file block addresses.  Now were able to look up
the first 1024*1024 blocks of the file.  With one block
being 4k, we have 4G files unless my math is wrong somewhere.
Of course we may want even bigger files, so there is a
triple indirect block too, able to map another 1024*1024*1024
4k blocks.  This is considered "enough" for most uses,
and ther is no more capacity in our inode.

> because
> the inode has a physical location on disk, and it is also associated
> with a file, and what we do is generally start from the inode and trace
> down to where the inode says the logical block shoul dbe, and then look
> it up. During this time the inode location on disk must be locked
> (with a read lock). 

In the case of ext2, you'll be doing something like
1. lock the inode, verify that it still exists, read it
2. the inode has a disk address for a double indirect block, read that
from disk
3. look up the correct indirect block in the double one, read that
4. look up the physical block in the indirect block, read the physical
block
5. release the inode lock.

This is 4 reads, to locations that likely is spread all over the disk. 
4 seek operations, each taking much more time than all the actual
reading.  Even if we don't worry about that, you'll be reading 4 blocks
in order to get one block of your _file_.  This divides effective
bandwith by 4.  But it will actually be hundreds of times worse because
of the
seeking.

> I can do that. If you let me have "tag
> requests" in the block layers and let me generate them in the VFS
> layers. Yes, I agree, I have to know where the inode is on disk
> in order to generate the block request, but the FS will know,

Sure, the FS will know.  But it don't know that in any magical
way.  It finds out because metadata is cached, or by
looking it up on disk when it isn't.  But looking things
up on disk takes time.

> and I just want it to tell VFS .. well, too much detail.
> 
> > 3.
> > The reason for this breakup is that the file might be fragmented
> > on disk.  No one can know that until it is checked, so
> 
> Yes, indeed. I agree.
> 
> > each block is checked to see where it is.  The kernel
> > tries to be smart and merges requests whenever the
> > logical blocks in the file happens to be consecutive
> 
> That's fine. This is the elevator alg. working in the block layers.
> Theer's no problem there. What I want to know is more about the
> lookup procedure for the inode, but already this much info is enough
> to confirm the picture I have. One needs to lock the inode position
> on disk.
> 
> > 4.
> > The list of physical positions (or physical blocks)
> > are passed to thbe disk drivers and the read
> 
> > Number (3) is where the no-cache operation breaks
> > down completely.  We have to look up where on the _disk_
> > _every_ small block of the file exists.  The information
> 
> Yes. But this is not a "complete breakdown" but a requirement to
> (a) lock bits of disk not associated with data while we look at them,
> and (b) relook again next time.
> 
Well, not a complete breakdown, because it _works_.  But it'll be so
_slow_, that it is useless for anyone wanting performance.  And you
seems to want this to be fast.  Everybody want speed of course, you
want to optimize for large transfers.  That is doable,
but I can't see it happening with _no_ caching of metadata.

> Frankly, a single FS lock works at this point. That is, a single
> location on disk (say the sb) that can be locked by some layer.
> It can be finer, but there's no need to. The problem is avoiding
> caching the metadata lookup that results, so that next time we look it
> up again.
 
> > about where the blocks are is called "metadata".
> > So we need to look at metadata for every little 4k block.
> 
> No .. I don't see that. Not every block has some unique metadata
> associated, with it, surely? 
Yes, every block has unique metadata on a unix fs.  And that is
the information about where on the disk the actual block is
stored.  Such information is stored for every block of the file.
Otherwise, how could we know where on disk the blocks are?  They
don't necessarily follow each other in any nice order.  Most
fs'es _try_ for a contigous layout, because that allows much
faster operation.  (The disk don't have to seek as long as the blocks
are contigous, it can read one block directly after another.
That gives us lots of performance.  Seeking to a different
position takes very long time compared to reading a single block.)  

Although the fs try for contigous positions, it can't always
get that.  Because the disk may have been used before, so
free space is scattered all over in small chunks.  That's
when you need a metadata format that allows the blocks
of a file to be scattered all over.  They usually aren't, but
the metadata format must be able to cope with it.  So the
position of every little block _is_ stored.  A single
4k disk block can hold 1024 disk addresses though, so
this metadata don't take up much space.  But it
have to be consulted for every block of a file.
You could try a simple modification to ext2, so it
discards such blocks from cache after each use.  (The blocks
will have to be read again for each use then.)  Then
see how slow the filesystem gets.


> I thought that normally inodes
> were "direct", that is, pointing at contiguous lumps?
No, most filesystems aren't like that.  I have described above
how unix fs'es tend to work, and that is what you have
to deal with _if_ you want to modify existing filesystems.

There are some historical filesystems that store each file
as a contigous lump.  All necessary info fits in the inode
for such a fs, but nobody uses them because they can't deal
with fragmentation at all.  I.e. there may be 10GB free space
on the disk, but no single contigous free lump is bigger
than 1M (there's over 10.000 small lumps of free space)
so we can't even fit a 2M file in that fs.

There are also filesystems like hpfs that store one unit
of allocation information for each contigous lump
instead of each block.  That works well as long as there
is little fragmentation, but you get a O(n) worst case
lookup time for the last block in a badly fragmented
file, where a unix fs always has a O(1) lookup time.
(n is the number of blocks in the file)

The hpfs approach may seem vastly superior as long as
we avoid bad fragmentation, but it don't buy that much
for systems that use caching.  The ext2 metadata
is small compared to the file size even if it is proportional.


> Sure,
> sometimes some other lookups might be required. but often? No.

Yes - _if_ using ext2.  No, _if_ using hpfs and there's little
fragmentation.

But you seem to overlook something.
Each time you drop the fs lock, you'll have to re-read
the inode even though it is the same inode as last time.  Because
it may have changed.  _Probably_ not, but you can only _know_
by reading it.  So a fs design with little metadata won't help,
you have to read it anyway if you dropped the lock.  If you
didn't drop the lock then you're free to enjoy the benefits of metadata
caching, but then the other nodes can't access that fs in the meantime.

> Especially if you imagine that 99.99% of the ops on the file system will
> be rewriting or rereading files. Just a "metadata updated" flag on the
> FS might be useful to avoid looking everything up again avery time,
> but I realy would like to see how much overhead there IS first.

That might help for you case, sure.  You could then cache
metadata as long as the flag don't change.  There is 
a problem though, you might still need to check that flag
for each operation, and the going over the network is
_slow_ compared to mostly working in memory.

> > That isn't a problem usually, because the metadata is
> > small and is normally cached entirely, even for a large
> > file.  So we can look up "wher block 1 is on disk, where block 2
> > is on disk..." by looking at a little table in memory.
> 
> Well, or on disk :-)
> 
> > But wait - you don't allow caching, because some other node
> 
> Thanks, but I know. That's right - we have to look up the inode again.
> That's precisely what I want to do.
> 
> > may have messed with this file!
> 
> May have, but probably won't. 
Sure.  The problem is that you can't know.  The probability
is low, but you can't know if the inode were updated.

> To have messed with it it must
> have messed with the inode, and we can ask the driver if anyone
> but us has written to that spot (the inode), and if not, not
> reread it. 

What driver?  The disk controller driver?  It keeps no record
about who writes where.  If it did, it'd run out of memory 
to store that kind of info quickly.  

> That's just an idea, but really, I would prefer to reread
> it. Data reads and writes will generally be in lumps the order of
> 0.25M. An extra 4K on that is latency, not appreciable extra data.
> 
> > So we have to read metadata *again* for each little
> > block before we are able to read it, for you don't let
> 
> No, not each little block. I disagree totally. Remember that
> we get the lock on the inode area at the start of the opn. 

Remember that the inode isn't enough for some of the fs'es you
want to modify.  Nothing wrong in locking down the
rest of the metadata too for the duration of your
0.25M transaction though.  

> Nobody
> can mess with it while we do the sequence of small reads or writes
> (which will be merged into large reads or writes). That was the
> whole point of my request for extra "tag requests" in the block
> layer. I want to be able to request a region lock, by whatever
> mechanism.

This starts looking better.  You lock the entire file,
or at least the region you want to work on, _with_
associated metadata.  

Try to be aware of terminology though.  What you have specified
now _is_ a system for metadata cache coherency.  A good
implementation might
work well too.  But you started out by stating that you
didn't want to cache anything at all and turn caching
off entirely because cache coherency was "too hard".

Now you want to lock down regions leaving other 
regions open for other nodes in the cluster to reserve.
  

> 
> > us cache that in order to look up the next block.
> 
> At this point the argument has gone wrong, so I can't follow ...
> 
> > Now metadata is small, but the disk have to seek
> > to get it.  Seeking is a very expensive operation, having
> > to seek for every block read will reduce performance to
> > perhaps 1% of streaming, or even less.
> 
> Well, you forget that we had to seek there anyway, 

No.  the nice thing about disks is that we
don't seek to every block and then read it.  We take
advantage of the fact that after disk block 1 comes
disk block 2 and so on.  So, if we just read block 1 then
block 2 is available _without_ any seeking at all. 
Consider that seeking is much slower than reading, and you
see that this zero-seek reading gets us a lot of
performance.  That's why we have elevator algorithms, and that
is why filesystems try their best to lay out files
contigously whenever possible.  It is in order to
enjoy the performance of zero-seek reading and writing,
which is just what you too need for your big-file streaming.

Anything that throws in a few extra seeks here and there
will slow down streaming considerably.  It don't help
that the data volume is small, because transfer speed
isn't the issue at all.  Moving disk heads around is
much slower, you could read _many_ blocks (tens, hundreds)in the
time spent on moving disk heads to a different location.

> and that the
> _server_ kernel has cached the result (I am only saying that the
> _client_ kernels need O_*DIRECT) , and that therefore there is
> no ondisk seek on the real device, just a "memory seek" in the
> guardian of the real device.
> 
You should also take a look at network speed and latency.
Transferring unnecessary blocks across the network
takes time too.  Your transfer speed is probably very high,
and the volume of metadata is small.  But not so small
if you keep requesting the same block of metadata over
and over because you want to look at the next 
disk address stored in some indirect block.
Of course you can avoid that if you have a lock
on the entire 0.25M region of the file (with
metadata included) but you can't avoid
it if you don't want to cache metadata _at all_.

Consider the latency issue too.  The transfer 
of a metadata block may be fast, but there is
a roundtrip time where you're waiting.  The other
node don't necessarily respond instantaneously.

Other cluster systems have seen performance limitations
from cache coherency issues even if they only transfer
small packets for this purpose.  A avoidable transfer
of an entire disk block could cost you more.

> > And where on disk is the metadata for this file?
> > That information is cached too, but you
> > disallow caching.  Rmemeber, the cache isn't just for
> 
> You are confusing yourself with syntax instead of semantics, I think ..
> I can't relate this account to anything that really happens right now.
> The words "no caching" only apply to the kernel for which the
> real device is remote. On the kernel for which it is local, of course
> there is block-level caching (though not FS level caching, I hope!).

So, you're no longer limited by _disk_ issues.  Still, if you insist
on no caching at all (of metadata) you'll end up transferring
4 blocks or more for _each_ block in a ext2 filesystem because
of the indirect block lookup on _every_ disk block.  
It has to be done, and it divides your streaming bandwith by
4 at least.  Of course you can reserve the metadata (inode & 
indirect blocks for that file) so others can't write
them, and cache that on the client until your 0.25M is done.

But don't say you aren't caching anything if you do that!
This _is_ metadata caching on the client side.  
not caching any _file_ data may indeed make sense for
your large transfers, but don't forget the metadata necessary
to find the file data.

When we speak of "cache" in general, we mean both data 
and all kinds of metadata.  If you mean to say that you want to
not cache any _file_ data but lock down and cache some
metadata for the duration of a transfer then please
say so.  You'll avoid a lot of misunderstanding that way.
And it looks like something that might work too, so
you might get people interested instead of irritated
over ideas obfuscated by misunderstandable ill-formed 
specifications.

If you really want "no cache at all" on the client then
you still get your streaming bandwith divided by n, where
n is the number of metadata blocks necessary to look up
per file block.
You won't suffer from ill-ordered disk requests, but
you'll transfer a lot of metadata over and over.

If you lock down the metadata for a while so the
client can keep looking at the same copy for
a while before discarding it then you _are_
implemening limited metadata caching _and_ a
simple cache coherency protocol.  

> This is all way off beam .. sorry. I'd like to know why people
> imagine in this way .. it doesn't correspond to the real state
> of play.
> 
Seems to be a language problem - you started by stating
that you wanted to do no caching, when it turns out
you meant something different.  Technical language is
very precise, and definitions can't be bent a little.


> Well, tell me whatyou mean by "logical". telling me you mean "offset
> within file" is enough  explanation for me! 
Good.  There is no way I could _know_ that though.

> I really wish you would stop patronising - you are confusing unfamiliarity with YOUR jargon
> for unfamiliarity with the logic and the science involved. Try again.

Sorry.  You seem to be on to something. We do, however, get occationally 
clueless people who insist on the impossible and won't go away.
That kind of people is sometimes hard to tell from those
that merely misunderstand or use the language/jargon wrongly.

[...]

> > > Is that relevant?
> > Both irrelevant and wrong.  Direct io isn't serialized, but
> 
> It appears to be. I have measured the sequencialization that takes
> place on reads and writes through direct_io at the block level in
> 2.5.31, and as far as in can tell, a new write request does not go
> out before the "previous" one has come back in. Shrug.

Again, this depends on precise definitions.  One process issuing
one direct io after another will of course have them
executed in order - serialized by the process itself.

A general statement about "direct io" covers _all_ direct io though.

What if I have several processes on my SMP machine all issuing
direct io operations on my multiple local disks?

Process 1 on cpu 1 starts direct io against disk 1
Slightly later, while process 1's io operation barely has
begun, process 2 on cpu 2 starts direct io against disk 2.

There's no need for process 2 to wait until process 1's
io completes, it is against another device.  There's even
another cpu to handle it, although that isn't really
necessary as one cpu has plenty of time to start
two simultaneous requests against different devices.

Process 2's io might even complete long before 
process 1's io, because disk 2 is a faster disk. Or
because disk 1 is busy, a third process have a long queue
of outstanding io's against it.

The io's might even get re-ordered in a two-process
one-cpu one-disk case, because the second io issued
is nearer the disk heads and so the elevator 
algorithm prefers to do the second io first.

Direct io is merely a way of saying don't waste
cache capacity on this, I know the usage pattern
and know that it won't pay off.

The one-process case is serialized because a 
process waits on its _own_ io operation, so it
is obvious that it can't issue a new one until
the old one completes.

Helge Hafting
