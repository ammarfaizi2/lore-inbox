Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135304AbRDLUBo>; Thu, 12 Apr 2001 16:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135305AbRDLUBZ>; Thu, 12 Apr 2001 16:01:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46607 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135304AbRDLUBN>; Thu, 12 Apr 2001 16:01:13 -0400
Date: Thu, 12 Apr 2001 15:19:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode() broken?
In-Reply-To: <Pine.LNX.4.21.0104121451180.3059-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104121517360.3110-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Marcelo Tosatti wrote:

> 
> On Thu, 12 Apr 2001, Linus Torvalds wrote:
> 
> > On Thu, 12 Apr 2001, Marcelo Tosatti wrote:
> > >
> > > Comments?
> > >
> > > --- fs/inode.c~	Thu Mar 22 16:04:13 2001
> > > +++ fs/inode.c	Thu Apr 12 15:18:22 2001
> > > @@ -347,6 +347,11 @@
> > >  #endif
> > >
> > >  	spin_lock(&inode_lock);
> > > +	while (inode->i_state & I_LOCK) {
> > > +		spin_unlock(&inode_lock);
> > > +		__wait_on_inode(inode);
> > > +		spin_lock(&inode_lock);
> > > +	}
> > >  	if (!(inode->i_state & I_DIRTY))
> > >  		goto out;
> > >  	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> > 
> > Ehh.
> > 
> > Why not just lock the inode around the thing?
> > 
> > The above looks rather ugly.
> 
> You mean writing a function called "lock_inode()" or whatever to basically
> do what I did ? 

Oh well, its still bad.

We drop the inode_lock before calling write_inode_now() (which is broken,
too :)), which means someone can set I_LOCK under us.

I'll send you a patch to fix that one (and other callers of
write_inode_now()) later.


