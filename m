Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRDWUpb>; Mon, 23 Apr 2001 16:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRDWUpV>; Mon, 23 Apr 2001 16:45:21 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:35235 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131806AbRDWUpI>; Mon, 23 Apr 2001 16:45:08 -0400
Date: Mon, 23 Apr 2001 22:45:05 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Christoph Rohland <cr@sap.com>, "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010423224505.H719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010423172335.G719@nightmaster.csn.tu-chemnitz.de> <Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Apr 23, 2001 at 11:36:24AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:36:24AM -0400, Alexander Viro wrote:
> > Great idea. We allocate this space anyway. And we don't have to
> > care about the internals of this union, because never have to use
> > it outside the kernel ;-)
> > 
> > I like it. ext2fs does the same, so there should be no VFS
> > hassles involved. Al?
> 
> We should get ext2 and friends to move the sucker _out_ of struct inode.
> As it is, sizeof(struct inode) is way too large. This is 2.5 stuff, but
> it really has to be done. More filesystems adding stuff into the union
> is a Bad Thing(tm). If you want to allocates space - allocate if yourself;
> ->clear_inode() is the right place for freeing it.

You need an inode anyway. So why not using the space in it? tmpfs
would only use sizeof(*inode.u)-sizeof(struct shmem_inode_info) for
this kind of symlinks.

Last time we suggested this, people ended up with some OS trying
it and getting worse performance. 

Why? You need to allocate the VFS-inode (vnode in other OSs) and
the on-disk-inode anyway at the same time. You get better
performance and less fragmentation, if you allocate them both
together[1].

So that struct inode around is ok.

BTW: Is it still less than one page? Then it doesn't make me
   nervous. Why? Guess what granularity we allocate at, if we
   just store pointers instead of the inode.u. Or do you like
   every FS creating his own slab cache?

Regards

Ingo Oeser

[1] Which is true for other allocations, too.
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
