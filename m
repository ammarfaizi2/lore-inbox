Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156493AbPLMPIx>; Mon, 13 Dec 1999 10:08:53 -0500
Received: by vger.rutgers.edu id <S156382AbPLMPIP>; Mon, 13 Dec 1999 10:08:15 -0500
Received: from mg-20425424-9.ricochet.net ([204.254.24.9]:61880 "EHLO trampoline.thunk.org") by vger.rutgers.edu with ESMTP id <S156493AbPLMPHy>; Mon, 13 Dec 1999 10:07:54 -0500
Date: Mon, 13 Dec 1999 10:02:00 -0500
Message-Id: <199912131502.KAA08641@trampoline.thunk.org>
To: afei@jhu.edu
Cc: linux-kernel@vger.rutgers.edu, pgajer@chow.mat.jhu.edu, lynny@hops.cs.jhu.edu, theos@cnds.jhu.edu, afei@jhu.edu, yairamir@cs.jhu.edu
In-reply-to: <Pine.GSO.4.05.9912121619270.16581-100000@aa.eps.jhu.edu> (afei@jhu.edu)
Subject: Re: b-tree search of filename in a directory
From: tytso@mit.edu
Phone: (781) 391-3464
References: <Pine.GSO.4.05.9912121619270.16581-100000@aa.eps.jhu.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date:   Sun, 12 Dec 1999 16:39:43 -0500 (EST)
   From: afei@jhu.edu

   To attempt to expedite the search, we want to use b-tree or avl-tree. But
   we found that there are two principles we have to follow: 1) the tree
   needs to be dynamically allocated or deallocated, it is not going to stay
   in the main memory in a static way. 

   In short, I believe the b-tree approach to expedite filename search is not
   going to work unless the dir entry is essentially reconstructed so that a
   directory on disk has both a directory entry table and a filename
   table. 

You're right.  My work and design on adding b-tree support to the ext2
filesystem basically involves making fundamental changes in how
directories are stored on disk.  If you're not going to make changes to
directory structure, there's absolutely no point.  That was what I was
trying to tell you when I was explaining to you why your original idea
about AVL trees wasn't going to work.  

This is also why (in addition to my being really busy) why work on
adding B-tree support to ext2 has been going slowly; it's not trivial,
especially if you want to do it right.  Some of the design issues (how
to handle opendir/readdir correctly) are quite non-trivial.

This is not a final design, but this should give you an idea of the sort
thing that I've been planning as far making changes to the ext2
directory structure.  

							- Ted


			    B-tree design

Interior node design
====================

Interior nodes are the same across both directories and file extent
maps.

16 bytes per b-tree entry

64 bit index	application (directories versus files extent maps) specific
		   for directories:
			4 byte hash code of name
			2 bytes uniquifier
			2 bytes reserved
		   for extent map: 8 bytes logical block number
64 bit pointers
		4 byte block pointer
		2 byte lvm index
		2 bytes reserved

---> 64-way fanout for 1k blocks (63 keys per block)

Usage:  (4 bit field)

	0	(Reserved)
	1	directory
	2	extent map
	3-15	(Reserved)


Flags: (4 bit field)

	1	Leaf node (if clear, this is an interior node)
	2	(Reserved)
	4	(Reserved)
	8	(Reserved)

Actual data layout

       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |         Magic number (0xB178EE)	       	      | Usage |	Flags |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         Inode number   	       	              |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         block pointer                         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved (mbz)         |       lvm index               |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                          64-bit key (1)                       |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                          64-bit key (2)                       |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         block pointer                         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved (mbz)         |       lvm index               |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                          64-bit key (1)                       |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                          64-bit key (2)                       |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         block pointer                         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       lvm index               |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
		...

Leaf node
=========

Leaf node format is application specific.  First 48 bytes are constant
(magic number, usage, flags, inode number, forward and back pointers).

Open issues:  

	Do we need depth counter?   won't work, because it means that when we 
		split an interior node, we need to update the depth
		counter of all leaf nodes under the subtree.  

	Do we need up pointer to parent interior node?

Extent map layout
-----------------

Flags field for compression
	1	Compressed cluster
	2	(Reserved)
	4	(Reserved)
	...	(Reserved)

Each entry in the leaf node is 20 bytes per entry (5 long words).
There is a 48 byte header at the beginning of each leaf node,
identifying the node as a leaf node, plus the forward and back
pointers in the leaf nodes.

       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |         Magic number (0xB178EE)	       	      | Usage |	Flags |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         Inode number   	       	              |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |               fwd block pointer (to next leaf node)           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       fwd lvm index           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |               back block pointer (to prev leaf node)          |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       back lvm index          |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    64-bit key (logical block 1)               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    64-bit key (logical block 2)               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      | reserved (mbz)|     Flags     |	    Block count               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       lvm index               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         block pointer                         |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
		...


Directory map layout
--------------------

Directory names are padded out to 4 byte boundaries.

There is a 48 byte header at the beginning of each leaf node,
identifying the node as a leaf node, plus the forward and back
pointers in the leaf nodes.


       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |         Magic number (0xB178EE)	       	      | Usage |	Flags |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         Inode number   	       	              |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                 fwd block pointer (to next leaf node)         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       fwd lvm index           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |               back block pointer (to next leaf node)          |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       back lvm index          |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    64-bit key (dir name hash 1)               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                    64-bit key (dir name hash 2)               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |                         inode number                          |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |        reserved  (mbz)        |       lvm index               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      | reserved (mbz)        | Type  |	    name length               |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |       'M      |       'a      |       'k      |      'e       |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |       'f      |       'i      |       'l      |      'e       |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |       '.      |       'i      |       'n      |    padding    |
--    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
