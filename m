Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269895AbRHEBru>; Sat, 4 Aug 2001 21:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269896AbRHEBrc>; Sat, 4 Aug 2001 21:47:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15572 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269895AbRHEBr2>;
	Sat, 4 Aug 2001 21:47:28 -0400
Date: Sat, 4 Aug 2001 21:47:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semanticchange
 patch)
In-Reply-To: <20010805063123.A20164@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108042114190.10111-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Aug 2001, Chris Wedgwood wrote:

> On Sat, Aug 04, 2001 at 11:45:47AM +0400, Hans Reiser wrote:
> 
>     Can you define f_cred for us?
> 
> Surely is becomes a fs-specific opaque type, void* or whatever?  For
> many filesystems it somply won't be relevant, and for some filesystems
> such as NFS and Coda, presumably it will need deep fs-specific
> details?

Not really. It _is_ relevant for, say it, ext2. Why? Because we need that
to handle, e.g. 5% reserve. Look:

	Disk is almost full. We have only 3% of blocks free and in that
situation only root should be able to allocate more.
	User foo creates an empty file. No blocks allocated, so we are OK.
He does truncate() to, say it, 10Mb. Still no block allocations.
	He mmaps that file. And does memset() on mmaped area. Now we have
a bunch of dirty pages. Well, eventually kswapd will write them out, right?
	What UID does kswapd run under? Exactly. Welcome to the fun - we've
managed to trick the system into allocating 10Mb of disk space for us, since
in the allocation time UID and GID were 0.
	Now that we have these blocks allocated, usual write() will succeeed
just fine - no block allocation, no checks.

See what I mean? Blind use of current->fsuid et.al. in filesystem code is a
Bad Thing(tm). We really want to know who is responsible for the operation
and "current task" is not always the right answer.

What we need is a cache of objects that would contain (at least) UID,
GID and auxillary groups. That, and ability to add extra authentication
tokens. Process should have a pointer to its current credentials (quite
possibly shared by many processes). Ditto for an opened file. When we
open a file we should simply inherit credentials of opening process.
When we do seteuid(2), etc., we should create a separate copy of current
credentials, modify that copy, drop the reference to old creds and set
the pointer to credentials to the modified copy. Fs operations should
(eventually) be changed to get credentials explicitly - as an argument.
That, BTW, would allow knfsd to avoid the silly games with setting
->fsuid for the duration of fs operation - we could simply pass the
credentials of the party responsible for NFS request to filesystem
methods.

It's nothing new - both the problem and solution are well-known since
at least early 90s. All this stuff is pretty straightforward, but it
can't be done in 2.4 - it involves changing the prototypes of fs
methods. Changes to the bodies of methods (i.e. to fs code) are
minimal - basically, it's a search-and-replace job that can be done
at once on the whole tree. However, such things do not belong to
-STABLE.

PS: probably "identity" would be a better term than "credentials". It's
a "look, I'm acting on behalf of Joe R. User and I carry a bunch of IDs to
prove that" thing.

