Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135489AbRDSA3Q>; Wed, 18 Apr 2001 20:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135488AbRDSA26>; Wed, 18 Apr 2001 20:28:58 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:9734 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135446AbRDSA2g>; Wed, 18 Apr 2001 20:28:36 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: Ext2 Directory Index - Delete Performance
Cc: adilger@turbolinux.com, ext2-devel@lists.sourceforge.net
Message-Id: <20010419002757Z92249-1659+3@humbolt.nl.linux.org>
Date: Thu, 19 Apr 2001 02:27:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few weeks ago, testing my indexed directory code with a 1,000,000 file
directory, I noticed that deletion was taking longer than creation -
about 4 times longer.  Andreas Dilger confirmed this earlier this week,
and I decided I'd better find out what's going on.

Not having any nice tracing tools like LTT or Stephen Tweedie's disk
performance monitoring package installed, I decided to fall back on code
meditation for this one, and after some period of contemplation the
answer just kind of popped into my head.  (Mind you, I would much rather
have used the tools and saved this special magic for some more
earthshaking purpose but oh well.)

It's simple.  It followed from observing that there is actually a lot
more disk space devoted to the inodes of a directory than the directory
entries themselves, something like 6 times more.  Inodes are packed
together 32 per block (4K blocks).   With really big directories not all
inode blocks can fit in cache.  Now, if you go deleting files in random
order there will be a lot of inode blocks in cache with some, but not
all, of the inodes on them deleted.  Some of these blocks will be chosen
for writeout to make space for new blocks that have to be updated, and
they will have to be read back in later to delete the rest of the inodes
on them.  

In brief: for large number of inodes, deleting inodes in random order
thrashes the inode cache.  Conversely, deleting inodes in storage order
should make the thrashing go away.

I tested this theory using the rm_all program below.  It gets as many
dirents as it can, sorts them by inode, and deletes them in inode order.
As predicted, there is no more thrashing and deletions speed up to the
point of being slightly faster than creates.  The delete performance
thus obtained is pretty much independent of the relationship between
storage order and inode order, so it should run at the same speed no
matter how the inodes happen to be laid out on disk.

OK, now I know what's happening, the next question is, what should be
dones about it.  If anything.

I'll start by observing that the inode thrashing effect is not a
property of the particular indexing scheme I've chosen, it's a property
of any indexing scheme that stores names in its leaf blocks in an order
that does not correspond roughly to the inode storage order.  Another
way of putting this is, you can either try to keep the names in your
leaf blocks in creation order and index them all individually, or you
can keep them in an order that forms part of the index, as I have done,
and index them in groups.

The problem with indexing all entries individually is pretty obvious:
your index gets a whole lot bigger.  Suppose it costs 8 bytes to index
each entry, and there are 250 entries per block.  That's 2K to index
each block, 250 times more than what the current indexing scheme
requires.  The index will be about half the size of the directory.  The
access path will be one block longer, and with a much greater chance of
cache misses on the index.

Though I haven't tested it, it doesn't sound like it's worth it. 
Especially since there is a far easier way to solve the problem: add
more memory.  If you have enough memory, the inode cache won't thrash,
and even when it does, it does so gracefully - performance falls off
nice and slowly.  For example, 250 Meg of inode cache will handle 2
million inodes with no thrashing at all.

Another corollary of all this is, with only a few tens of thousands of
files in a directory you won't see any problem, even if you don't have
very much memory.  I'm doing all my development with a total of 16 Meg
allocated to UML and I can handle 40,000 files at pretty much full
speed.

Of course that isn't going to stop me from speculating about what you
could do to make this problem go away completely.  Here are a few of my
thoughts.

1) Use ReiserFS.  I gather that ReiserFS does not have inodes; the kind
of information that ext2 stores in the inode is instead stored in the
directory leaf node, together with the name.  So there is no possibility
to have the storage order of names fail to match the storage order of
inodes, because there aren't any.  On the other hand, all things taken
together, I think I'm still running quite a bit faster than ReiserFS, so
don't be too hasty in adopting this strategy. :-)

2) Use the rm_all program I wrote today.  It works great.[1]

3) Create a new interface to let the filesystem instead of glibc handle
the rm -rf.  The filesystem knows how to do it efficiently.  In fact,
the filesystem would probably just do the equivalent of rm_all, but with
less overhead.

4) In the VFS, instead of deleting the inode at the same time as
unlinking the entries, keep a list and process it efficiently later.

5) Index every entry individually and keep them in creation order in the
leaf nodes.

6) Set the inode allocation goal according to the hash.  The problem to
solve here is: you don't know how many inodes the directory will use
ahead of time, but this could be adaptive: when the file grows over a
block, set aside a range of inodes for that and use them in an order
roughly corresponding to the hash value.  If that region gets used up,
allocate a new region twice the size and so on.

This last approach would work pretty well, but what I don't like about
it is: we're writing a whole bunch of code to solve what is pretty much
a non-problem.  I haven't tested (6) and I don't indend to - my guess
is, it's a net performance loss because of the index's bigger cache
footprint, and it certainly uses more disk space.

On the other hand, if we did number (3), that would be worth it because
we'd have a new interface that would be generally useful and wouldn't
have to be limited to just rm.  Think how much faster things would go if
a directory filter could be applied inside the filesystem, with a
callback to user space only for matching files.  Yum. 

So, to wrap this up, now we know why indexed deletion is slower than
creation for huge directories, it's not a mystery any more.  It's also
not a problem, because overall performance, including creation, random
access and random deletion, is quadratically better with the index. 
Deletion speed is roughly even with unindexed Ext2 up to a few 10's of
thousands of files per directory.  For small directories, (99% of the
directories on your disk now) the non-indexed code path is used, so 
performance will be identical or maybe a little better, since the code
has been cleaned up quite a bit.

rm_all program:
----------------

#include <sys/types.h>
#include <dirent.h>

#define u32 unsigned int

#ifndef COMBSORT
#define COMBSORT(size, i, j, COMPARE, EXCHANGE) { \
	unsigned gap = size, more, i; \
	if (size) do { \
		if (gap > 1) gap = gap*10/13; \
		if (gap - 9 < 2) gap = 11; \
		for (i = size - 1, more = gap > 1; i >= gap; i--) { \
			int j = i - gap; \
			if (COMPARE) { EXCHANGE; more = 1; } } \
	} while (more); }
#endif

#ifndef exchange
#define exchange(x, y) do { typeof(x) z = x; x = y; y = z; } while (0)
#endif

int main (int argc, char *argv[])
{
	char *dirname = argv[1];
	unsigned dirnamelen = strlen(dirname);
	unsigned maxmap = 50000, namesize = 20 * maxmap, count, i, more = 1;
	struct { char *name; u32 ino; } map[maxmap], *mp;
	char names[namesize], *namep;
	struct dirent *de;	
	DIR *dir;

	dir = opendir(dirname);
	readdir(dir);
	readdir(dir);
more:
	for (mp = map, namep = names; mp < map + maxmap; mp++)
	{
		int len;
		if (!(de = readdir(dir)))
		{
			more = 0;
			break;
		}
		len = strlen(de->d_name);
		if (namep + len + 1 > names + namesize) break;
		mp->ino = de->d_ino;
		mp->name = namep;
		*namep++ = len;
		memcpy(namep, de->d_name, len);
		namep += len;
	}
	count = mp - map, i = 0;
	COMBSORT(count, i, j, map[i].ino < map[j].ino, exchange(map[i], map[j]));
	for (mp = map; i < count; i++, mp++)
	{
		char name[50], *p = name;
		memcpy (p, dirname, dirnamelen);
		p += dirnamelen;
		*p++ = '/';
		memcpy (p, mp->name + 1, *mp->name);
		p += *mp->name;
		*p = 0;
		unlink(name);
	}
	if (more) goto more;
	closedir(dir);
	return 0;

}

----------------

Used in the form:

  rm_all dirname

[1] If somebody would send me some sample code for using getdents in
place of readdir I'd be much obliged.  I'd have used getdents if it was
actually defined in the libraries.

--
Daniel
