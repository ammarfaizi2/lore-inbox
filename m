Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRDWWwU>; Mon, 23 Apr 2001 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRDWWut>; Mon, 23 Apr 2001 18:50:49 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:39154 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132502AbRDWWso>; Mon, 23 Apr 2001 18:48:44 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104232247.f3NMlHF8002256@webber.adilger.int>
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <20010423224505.H719@nightmaster.csn.tu-chemnitz.de>
 "from Ingo Oeser at Apr 23, 2001 10:45:05 pm"
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Date: Mon, 23 Apr 2001 16:47:17 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
> > We should get ext2 and friends to move the sucker _out_ of struct inode.
> > As it is, sizeof(struct inode) is way too large. This is 2.5 stuff, but
> > it really has to be done. More filesystems adding stuff into the union
> > is a Bad Thing(tm). If you want to allocates space - allocate if yourself;
> > ->clear_inode() is the right place for freeing it.
> 
> BTW: Is it still less than one page? Then it doesn't make me
>    nervous. Why? Guess what granularity we allocate at, if we
>    just store pointers instead of the inode.u. Or do you like
>    every FS creating his own slab cache?

I would much rather we allocate a slab cache for each fs type (it
would be trivial at register_fs time).  Most people have only a limited
number of filesystems active at a single time, yet tens or hundreds of
thousands of inodes in the inode slab cache.  Making the per-fs private
inode data as small as possible would reduce memory wastage considerably,
and not impact performance (AFAICS) if we use a per-fs type slab cache
for fs private data.

Consider, when I was doing some fs benchmark, my inode slab cache was
over 120k items on a 128MB machine.  At 480 butes per inode, this is
almost 58 MB, close to half of RAM.  Reducing this to exactly ext2
sized inodes would save (50 - 27) * 4 * 120k = 11MB of memory (on 32-bit
systems)!!! (This assumes nfs_inode_info is the largest).

This also makes it possible to safely (and efficiently) use external
filesystem modules without the need to recompile the kernel.  Granted,
if the external filesystem doesn't use more than the largest .u struct,
then it is currently possible as well, but that number changes, so it
is not safe.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
