Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRDWPhn>; Mon, 23 Apr 2001 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135395AbRDWPh2>; Mon, 23 Apr 2001 11:37:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15540 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135397AbRDWPg1>;
	Mon, 23 Apr 2001 11:36:27 -0400
Date: Mon, 23 Apr 2001 11:36:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Christoph Rohland <cr@sap.com>, "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <20010423172335.G719@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, Ingo Oeser wrote:

> Hi Chris,
> 
> On Mon, Apr 23, 2001 at 04:54:02PM +0200, Christoph Rohland wrote:
> > > The question is: How? If you do it like ramfs, you cannot swap
> > > these symlinks and this is effectively a mlock(symlink) operation
> > > allowed for normal users. -> BAD!
> > 
> > How about storing it into the inode structure if it fits into the
> > fs-private union? If it is too big we allocate the page as we do it
> > now. The union has 192 bytes. This should be sufficient for most
> > cases.
> 
> Great idea. We allocate this space anyway. And we don't have to
> care about the internals of this union, because never have to use
> it outside the kernel ;-)
> 
> I like it. ext2fs does the same, so there should be no VFS
> hassles involved. Al?

We should get ext2 and friends to move the sucker _out_ of struct inode.
As it is, sizeof(struct inode) is way too large. This is 2.5 stuff, but
it really has to be done. More filesystems adding stuff into the union
is a Bad Thing(tm). If you want to allocates space - allocate if yourself;
->clear_inode() is the right place for freeing it.

