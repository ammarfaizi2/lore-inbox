Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316090AbSEJUwt>; Fri, 10 May 2002 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316094AbSEJUws>; Fri, 10 May 2002 16:52:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28592 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316090AbSEJUws>;
	Fri, 10 May 2002 16:52:48 -0400
Date: Fri, 10 May 2002 16:52:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget_locked [1/6]
In-Reply-To: <20020510203658.GA23583@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101649540.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> > > +			if (err) {
> > > +				destroy_inode(inode);
> > > +				return NULL;
> > > +			}
> > 
> > Please, take that code out of the path - will be cleaner that way.
> 
> Ok, a later patch already makes 'set' required, and I was only using the
> failure path in Coda. I'll change this so that set never fails.

I'm not sure that it's a good assumption - just add if (err) goto set_failed;
and take the cleanup there. 

> > >    destroy_inode: reiserfs_destroy_inode,
> > >    read_inode: reiserfs_read_inode,
> > > -  read_inode2: reiserfs_read_inode2,
> > 
> > Why do we keep ->read_inode() here?
> 
> Just in case someone outside of reiser calls 'iget' on a reiserfs inode.
> I guess it's not really necessary to have it around.

Umm...  Wait a second.  If reiserfs ->read_inode() would work, they wouldn't
need ->read_inode2() in the first place.  So any external caller of iget()
is going to have problems anyway, isn't it?
 
> > > Here we simply add an argument to insert_inode_hash. If at some
> > > point a FS specific getattr method is implemented it will be possible to
> > > completely remove all uses of i_ino in the VFS.
> >
> > How about
> > 
> > static inline void insert_inode_hash(struct inode *inode)
> > { 
> >         __insert_inode_hash(inode, inode->i_hash);
> 
> Ok, will do that.
> 
> Should I create one patch that goes in relative to iget_locked-6, or
> resubmit updated patches for each step? I guess an additional patch is
> the easiest. Or a -6a that replaces the existing -6.

-6a - incremental to -6 would mostly revert the stuff done in -6.

