Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262612AbSJHAeP>; Mon, 7 Oct 2002 20:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbSJHAeP>; Mon, 7 Oct 2002 20:34:15 -0400
Received: from thunk.org ([140.239.227.29]:48321 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262612AbSJHAeN>;
	Mon, 7 Oct 2002 20:34:13 -0400
Date: Mon, 7 Oct 2002 20:39:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-ID: <20021008003903.GA473@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Oliver Neukum <oliver@neukum.name>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
References: <E17ydRY-0003uQ-00@starship> <Pine.LNX.4.33.0210071229080.10168-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210071229080.10168-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:35:26PM -0700, Linus Torvalds wrote:
> 
> On Mon, 7 Oct 2002, Daniel Phillips wrote:
> > 
> > Ext2 likes to spread directory inodes around the volume so that there is
> > room to keep the associated file blocks nearby.  This interacts rather
> > poorly with readahead.
> 
> Not a read-ahead problem. It interacts rather poory _full_stop_.
> 
> It means that the inode tables are spread all out, the bitmaps are
> fragmented etc, so the disk head has to move all over the disk even when
> only working with one directory tree like the kernel sources.

It depends on what you are doing.  BSD, and even XFS, uses the concept
of using cylinder groups or block groups as one of many tools to avoid
file fragmentation and to concetrate locality for files within a
directory.  The reason why FAT filesystems have file fragmentation
problems in far more worse way is because they attempt don't have the
concept of a block group, and simply always allocate from the
beginning of the filesystem.  This is effectively what would happen if
you had a single block/cylinder group in the filesystem.

> So the problem with spreading stuff out doesn't have anything to do with 
> read-ahead, and has everything to do with the basic issue of BAD LOCALITY. 
> Locality is _good_, independently of read-ahead and independently of 
> medium. 

Ironically, as I mentioned, one of the reasons behind the block group
scheme is to *increase* locality for files within a particular
directory.  As you point out quite correctly, though, it tends to
destroy locality across an entire directory tree.

Maybe the answer is that we need some way of declaring that some
directory is the root of "a directory tree".  That way, the filesystem
can keep directories underneath the directory tree close together, and
the filesystem can try to keep directory trees far apart from each
other.  

In order to do something like this, we would just need a filesystem
API extension to allow programs like tar and bitkeeper to give a hint
that a new directory tree is being established --- and ideally, it
needs to be done at mkdir time, so that the filesystem can perform
appropriate do a better job of deciding where to place the initial
root of the "directory tree".  Things would also work if you declared
some directory tree to be the root of a "directory tree" after the
directory was initially created, but the allocation hueristics
wouldn't be nearly as effective.

Linus, what do you think about defining a new flag which could be
passed as part of the mode bits to mkdir()?  If we allow the
filesystem to get some additional hints from userspace about what the
difference between /usr/src/linux (where directory spreading is a bad
idea) and /usr/home (where directory spreading is a very good idea),
it would make life for the filesystem much easier.

						- Ted

