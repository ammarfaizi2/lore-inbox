Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSAGTj3>; Mon, 7 Jan 2002 14:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285730AbSAGTjM>; Mon, 7 Jan 2002 14:39:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:19111 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285724AbSAGTiz>;
	Mon, 7 Jan 2002 14:38:55 -0500
Date: Mon, 7 Jan 2002 14:38:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <E16NcLw-0001R9-00@starship.berlin>
Message-ID: <Pine.GSO.4.21.0201071401450.6842-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jan 2002, Daniel Phillips wrote:

> On January 7, 2002 04:19 pm, Daniel Phillips wrote:
> >   - You are dreferencing a pointer, and have two allocations for every
> >     inode instead of one.
> 
> Oh no, you only have one allocator, and you have the filesystem do it, with 
> per-sb methods.  Why is this better than having the VFS do it?  Does this 
> imply you might have different sized inodes with different mounts of the same 
> filesystem?

Because exposing sizes of private objects is Wrong.

Now, the problems I see with Jeff's variant:

a) if you make struct inode a part of ext2_inode - WTF bother with pointer?
b) ->destroy_inode() / ->clear_inode().  Merge them - that way it's one
method.
c) get_empty_inode() must die.  Make it new_inode() and be done with that.
And have socket.c explicitly set ->i_dev to NODEV afterwards.
d) ext2/balloc.c cleanup probably should be merged before.

I can live with "maintain refcounts in common part and leave allocation/freeing
to filesystem".  It's definitely better than allocating/freeing opaque objects
in VFS using numeric fields in fs_type.

We will need to set very strict rules on passing around/storing pointers to
ext2_inode and its ilk, though.  There will be bugs when somebody just decides
that keeping such pointers might be a good idea and forgets to be nice with
->i_count.  Or decrement it manually instead of calling iput(), etc.

It _MUST_ be explicitly documented - preferably beaten into skulls.

