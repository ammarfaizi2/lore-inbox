Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132572AbRDKNIY>; Wed, 11 Apr 2001 09:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDKNIO>; Wed, 11 Apr 2001 09:08:14 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:9988 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132572AbRDKNIA>; Wed, 11 Apr 2001 09:08:00 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: acahalan@cs.uml.edu, phillips@nl.linux.org
Subject: Re: [RFC] Ext2 Directory Index - File Structure
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010411130746Z92169-20971+29@humbolt.nl.linux.org>
Date: Wed, 11 Apr 2001 15:07:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 April 2001 18:37, you wrote:
> Daniel Phillips writes:
> > The zeroth block of an indexed directory is the index root.  Initially
> > the index has only one block.  The following blocks are normal ext2
> > directory entry blocks.  When the directory grows large enough to fill
> > all the available entries in the root index block (around 80-90,000
> > entries on a 4K blocksize filesystem) a second level is added to the
> > index tree in the form of an internal index block appended to the
> > directory.  As the directory expands, new index blocks are appended as
> > needed so that the directory consists of normal directory blocks with
> > index nodes interspersed every 200 blocks or so.
>
> It looks like you end up jumping back and forth to read the
> index blocks.

Only after the index has grown past 80-90,000 entries, and only when you
hit the directory once in isolation so that the root index node isn't
in cache - a concurrence of events likely only under light load, and
then you don't care about the slight extra head movement.  I think you'd
have a hard time measuring the performance impact. 

> (but maybe I need more sleep) It might be better
> to allocate 1, 2, 4, 8, ... index blocks at once, instead of
> always allocating just one.

Other than the requirement that the root be in the 0th block the
allocation of index blocks is completely unrestricted.  If there turns
out to be a better way to lay it out, allocation policy can be changed
at any time without losing compatibility with preexisting directories.

> > The high four bits of the block pointer field are reserved for use by
> > a coalesce-on-delete feature which may be implemented in the future.
> > The remaining 28 bits are capable of indexing up to 1TB per directory
> > file.  (Perhaps I should coopt 8 bits instead of 4.)
>
> Doing a 1 TB directory means you must give up on i_size, which is
> too small. You may instead calculate what you need from the block count.
> If you don't give up on i_size, you might as well coopt 11 bits.

Directories of this size are pretty theoretical at this point, but who
knows?  Suppose Yahoo wants to have one file for each freemail account
and have them all in one directory.  I guess they'd already need tens of
millions of entries.  One thing you can be sure of is that you'll always
be surprised, looking back, at just how much you underestimated the
amount of storage that people will use.

Platitudes aside, I'll be happy with 8 bits reserved, probably more than
needed to support an efficient coalescing policy.  This limits directory
size to 64 gig with 4K blocks, and I'm not going to be the one to say
that nobody would ever want one that big.

i_size is a separate problem.  It's been expanded in the VFS and Ext2
for regular files but not for directories.  See Andreas Dilger's comment
re reuse of the dir acl field in another thread.

> Oh, just grab 12 or 16 bits. It isn't at all OK to make directories
> that are pretty much impossible to read on a 32-bit system. Think
> about what /bin/ls must do to sort a 1 TB directory.

ls already can't handle the directories I'm working with on a regular
basis.  It's broken and needs to be fixed.  A merge sort using log n
temporary files is not hard to write.

> > The first kind of forward compatibility is addressed by hiding all the
> > new index structures inside what appears to earlier versions of Ext2 to
> > be free space.  This is accomplished by placing an empty Ext2 dirent
> > structure at the beginning of each index node which marks the entire
> > block as empty, from the point of view of non-index-aware versions of
> > Ext2.
>
> Well, it looks better than vfat. Next you will be wanting to
> increase the inode size and switch to 64-bit block numbers.
> You could write such a wonderful NEW filesystem.

Thanks.  We haven't quite filled up our 128 byte inodes yet, at least if
we treat the unused fragment fields as available.  As far as the total
Ext2 filesystem capacity goes, we can increase it by increasing the
block size, up to 64K (and then the only limit we hit is the 16 bit
fields in the directory blocks).  The only thing that degenerates
seriously is the internal fragmentation, a problem I've done some work
on as you know.  With 64K blocks we get a 64 TB filesystem size and by
the time we hit that limit (we *will* hit it) I guess we'll have had
time to figure out what to do about it.

Getting back to mundane reality.  Lots of users, particularly ISPs, are
suffering now from poor performance of Ext2's directory operations and
have been for some time.  It's a safe bet that most of them would prefer
that we quietly solve such problems instead of making them reformat
their disks.

--
Daniel
