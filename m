Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319251AbSIFRPo>; Fri, 6 Sep 2002 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319258AbSIFRPo>; Fri, 6 Sep 2002 13:15:44 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:1008 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319251AbSIFRPk>; Fri, 6 Sep 2002 13:15:40 -0400
Date: Fri, 6 Sep 2002 18:20:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Daniel Phillips <phillips@arcor.de>, Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209061425.g86EPGW10158@oboe.it.uc3m.es>
Message-ID: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Peter T. Breuer wrote:

> "A month of sundays ago Anton Altaparmakov wrote:"
> > The procedure described is _identical_ if you want to access 1TiB at a 
> > time, because the request is broken down by the VFS into 512 byte size 
> 
> I think you said "1byte". And aren't these 4096B, or whatever the
> blocksize is?

I said 1 byte but that is the same as if you did 512 bytes. No difference
whatsoever that is relevant to the discussion. And 1 terra-byte or bigger
or smaller doesn't matter as it is still the exact same operation repeated
lots and lots of times till you have covered the whole 1 terra-byte or
whatever in blocksize byte units (on NTFS always 512 bytes, technically
not any more as we now always work in units of PAGE_CACHE_SIZE when
talking to the VFS for read/write operations but more on that later).

The blocksize is dependent on file system driver _and_ on the options used
at format time. For example ext2 supports different block sizes, starting
at 1kiB (I think) and going up to the PAGE_SIZE of the machine, i.e.  4kiB
on ia32. For NTFS the cluster size is between 512 bytes and <place big
power of 2 number here, easily 64kiB but even 512kiB or larger possible>
but because the kernel cannot work on blocksize > PAGE_SIZE, I use a
translation where the kernel blocksize for NTFS is always 512 bytes and
the driver translates between kernel blocks (512 bytes each) and NTFS
clusters (512 bytes to 512 or more kilo bytes each).

> > units and I think I explained that, too. And for _each_ 512 byte sized unit 
> > of those 1TiB you would have to repeat the _whole_ of the described 
> 
> Why? Doesn't the inode usually point at a contiguous lump of many
> blocks? Are you perhaps looking at the worst case, not the usual case?

Because the VFS does the split up and it has no idea whatsoever whether
something is contiguous or not. Only the FS itself knows that information.
So the VFS has to ask for each bit individually assuming the worst case
scenario. And the FS itself has no idea what the VFS is doing and hence
has to process each request completely independently from the others. This
is how the VFS is implemented at present time.

As of very recently, Andrew Morton introduced an optimization to this with
the get_blocks() interface in 2.5 kernels. Now the file system, when doing
direct_IO at least, returns to the VFS the requested block position _and_
the size of the block. So the VFS now gains in power in that it only needs
to ask for each block once as it is now aware of the size of the block.

But still, even with this optimization, the VFS still asks the FS for each
block, and then the FS has to lookup each block.

Obviously if only one file was written, and the disk is not fragmented,
the file will be basically contiguous on disk. But if you wrote two
or more files simultaneously they would be very likely interleaved, i.e.
fragmented, i.e. each block would be small. - How an FS allocates space is
entirely FS driver dependent so it is impossible to say how well the FS
driver copes with simultaneous writes...

> > procedure. So just replace 1 byte with 512 bytes in my post and then repeat 
> > the procedure as many times as it takes to make up the 1TiB. Surely you 
> > should know this... just fundamental Linux kernel VFS operation.
> 
> Well, you seem to have improved the situation by a factor of 512 in
> just a few lines. Perhaps you can improve it again ...?
> 
> > It is not clear to me he understands the concept at all. He thinks that you 
> 
> Well, "let it be clear to you".
> 
> > need to read the disk inode just once and then you immediately read all the 
> 
> No, I think that's likely. I don't "think it". But yes, i assume that
> in the case of a normal file it is quite likely that all the info
> involved is in the inode, and we don't need to go hunting elsewhere.
> 
> Wrong?

In NTFS wrong. You have the base inode which contains all metadata (i.e. 
modification times, security information, the conversion table from file
offsets to disk locations, ...). However, as data is added to the file,
the conversion table for example grows and eventually the inode runs out
of space. (In NTFS inodes are fixed size records of 1024 bytes.) When that
happens, the NTFS driver either moves the conversion table completely to a
2nd inode (we call this inode an extent inode because it is _only_
referenced by the original inode itself) or it splits the conversion table
into two pieces and saves the 2nd part to a 2nd (extent) inode. The 2nd
(extent) inode can be anywhere in the inode table, wherever the allocator
finds a free one. When the 2nd inode fills up, the process is repeated, so
we now have a 3rd (extent) inode, and so on, ad infinitum. So NTFS has
pretty much no limit on how many extent inodes can be attached to a base
inode. (Note: the original base inode contains a table describing which
metadata is stored in which extent inode. This table is not necessarily
stored in the inode itself. It can be stored anywhere on disk, and the
base inode then contains a conversion array between the offset in the
table and the physical disk block. - This just to give you the full
picture.)

So, in summary, if you have a small file _or_ the file is bug
but completely or almost completely unfragmented, then you are correct and
one only needs the original inode. But as soon as you get a little
fragmentation and you start needing extent inodes.

> > 1TiB of data and somehow all this magic is done by the VFS. This is 
> 
> No, the fs reads.  But yes, the inode is "looked up once" on average, I
> believe, and if it says there's 1TB of data on disk here, here and here,
> then I am going to tell you that I think it's locked in the fs while we
> go look up the data on disk in the fs.
> 
> What I am not clear about now is exactly when the data is looked up - I
> get the impression from what I have seen of the code that the VFS passes
> down a complete request for 1TB, and that the the FS then goes and locks
> the inode and chases down the data.  What you are saying above gives me
> the impression that things are broken down into 512B lumps FIRST in or
> above VFS, and then sent to the fs as individual requests with no inode
> or fs locking. And I simply don't buy that as a strategy.

But that is how the VFS works! The VFS _does_ break up everything into
512B lumps FIRST. Let me show you where this happens (assume current 2.5
kernel):

VFS: on file read we eventually reach:

mm/filemap.c::generic_file_read() which calls
mm/filemap.c::do_generic_file_read() which breaks the request into units
of PAGE_CACHE_SIZE, i.e. into individual pages and calls the file system's
address space ->readpage() method for each of those pages.

Assuming the file system uses the generic readpage implementation, i.e.
fs/buffer.c::block_read_full_page(), this in turn breaks the page into
blocksize blocks (for NTFS 512 bytes, remember?) and calls the FS
supplied get_block() callback, once for each blocksize block (in the form
of a struct buffer_head).

This finds where this 512 byte block is, and maps the buffer head (i.e.
sets up the buffer_head to point to the correct on disk location) and
returns it to the VFS, i.e. to block_read_full_page() which then goes and
calls get_block() for the next blocksize block, etc...

So this is how file reads work. For NTFS, I figured this is too
inefficient (and because of other complications in NTFS, too) and I don't
use block_read_full_page() any more. Instead, I copied
block_read_full_page() and get_block() and rewrote them for NTFS so that
they became one single function, which takes the page and maps all the
buffers in it in one go, keeping the conversion table from file offsets to
disk blocks locked (rw_semaphore) during that period. That is way more
efficient as it means I don't need to do a lookup in the conversion table
for every 512 byte block any more and instead I perform the lookup for all
blocks in the current page in one go.

Note, Andrew Morton actually optimized this, too, in recent 2.5 kernels,
where there is now a ->readpages() address space method which optimizes it
even further. But that involves using BIOs instead of buffer heads and I
haven't really looked into it much yet. (I want to keep NTFS as close to
2.4 compatibility as possible for the time being.)

> > complete crap and is _NOT_ how the Linux kernel works. The VFS breaks every 
> > request into super block->s_blocksize sized units and _each_ and _every_ 
> 
> Well, that's 4096 (or 1024), not 512.

512 if the FS says so. blocksize on NTFS is 512 bytes. Fixed. Otherwise
the code would have become too complicated...

> > request is _individually_ looked up as to where it is on disk.
> 
> Then that's crazy, but, shrug, if you want to do things that way, it

I agree. Which is why I don't use block_read_full_page() in NTFS any
more...

But you were talking modifying the VFS so I am telling you how the VFS
works. An important issue to remember is that FS drivers don't have to use
all the VFS helpers provided, they can just go off and implement their own
thing instead. But at least for file systems using the VFS helpers a
modification of the VFS means changing every single FS driver using this
which is a lot of work...

> means that locking the inode becomes even more important, so that you
> can cache it safely for a while. I'm quite happy with that. Just tell
> me about it .. after all, I want to issue an appropriate  "lock"
> instruction from vfs before every vfs op. I would also like to remove
> the dcache after every vfs opn, as we unlock. I'm asking for insight
> into doing this ...
>
> > Each of those lookups requires a lot of seeks, reads, memory allocations, 
> > etc. Just _read_ my post...
> 
> No they don't. You don't seem to realize that the remote disk server is
> doing all that and has the data cached. What we, the client kernels
> get, is latency in accessing that info, and not even that if we lock,
> cache, and unlock.

I thought that your nodes are the disk servers at the same time, i.e. each
node has several hds and all the hds together make up the "virtual" huge
disk. Are you talking about a server with a single HD then? You
didn't define your idea precisely enough... It now makes no sense to me at
all with your above comment...

Could you describe the setup you envision exactly? From the above it seems
to me that you are talking about this:

- a pool of servers sharing the same harddisk, all the servers attached
to the HD via SCSI or some simillar interface. - Or are you saying that
there is a "master node" which has the hd attached and then all the other
servers talk to the master node to get access to the disk?

- all the servers mount the HD with some FS and they somehow manage to get
this right without breaking anything. Presumably all the servers are
interconnected directly via some super fast super low latency interface? -
Or do they all talk to the master node?

- the FS mounted on the servers is exported via NFS (or other networking
FS) to the workstations which then read/write files on the NFS shares.

Is this correct? If not what is it that you _really_ have in mind. It
would help a lot to know what you are _really_ trying to do otherwise it
is difficult to talk about it... Your turn to explain your idea better
now. (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

