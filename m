Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbRDXD57>; Mon, 23 Apr 2001 23:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRDXD5u>; Mon, 23 Apr 2001 23:57:50 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:43250 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132738AbRDXD5i>; Mon, 23 Apr 2001 23:57:38 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104240356.f3O3ujbI002673@webber.adilger.int>
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <01042320160100.01338@oscar> "from Ed Tomlinson at Apr 23, 2001
 08:16:01 pm"
To: Ed Tomlinson <tomlins@cam.org>
Date: Mon, 23 Apr 2001 21:56:45 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolinux.com>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson writes:
> > Consider, when I was doing some fs benchmark, my inode slab cache was
> > over 120k items on a 128MB machine.  At 480 butes per inode, this is
> > almost 58 MB, close to half of RAM.  Reducing this to exactly ext2
> > sized inodes would save (50 - 27) * 4 * 120k = 11MB of memory (on 32-bit
> > systems)!!! (This assumes nfs_inode_info is the largest).
> 
> Was this with a recient kernel (post Alexander Viro's dcache pressure fix)?  
> If not I suggest rerunning the benchmark.  I had/have a patch to apply
> pressure to the dcache and icache from kswapd but its not been needed here
> since the above fix.

Actually, it had the dcache patch but I'm not aware of a patch from Al to
change icache behaviour.  In any case, changing the icache behaviour is
not what I'm getting at here - having the union of all private inode
structs in the generic inode is a huge waste of RAM.  Even for filesystems
that are heavy NFS users, they will likely still have a considerable amount
of local filesystem space (excluding NFS root systems, which are very few).

Al posted a patch to the NFS code which removes nfs_inode_info from the
inode union.  Since it is (AFAIK) the largest member of the union, we
have just saved 24 bytes per inode (hfs_inode_info is also rather large).
If we removed hfs_inode_info as well, we would save 108 bytes per inode,
about 22% ({ext2,affs,ufs}_inode_info are all about the same size).

No point in punishing all users for filesystems they don't necessarily use.
Even for people that DO use NFS and/or HFS, they are probably still wasting
10k inodes * 108 bytes = 1MB of RAM for no good reason (because most of
their inodes are probably not NFS and/or HFS).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
