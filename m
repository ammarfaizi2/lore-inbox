Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSJHRQd>; Tue, 8 Oct 2002 13:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJHRQd>; Tue, 8 Oct 2002 13:16:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:25773 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261403AbSJHRQa>;
	Tue, 8 Oct 2002 13:16:30 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200210081721.g98HLse02334@eng2.beaverton.ibm.com>
Subject: Re: [patch] 512-byte alignment for O_DIRECT I/O
To: akpm@digeo.com (Andrew Morton)
Date: Tue, 8 Oct 2002 10:21:54 -0700 (PDT)
Cc: lord@sgi.com (Steve Lord), linux-kernel@vger.kernel.org (lkml),
       linux-fsdevel@vger.kernel.org (linux-fsdevel@vger.kernel.org),
       pbadari@us.ibm.com (Badari Pulavarty)
In-Reply-To: <3DA30DAB.BDED8ABE@digeo.com> from "Andrew Morton" at Oct 08, 2002 08:54:03 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Steve Lord wrote:
> > 
> > On Mon, 2002-10-07 at 17:59, Andrew Morton wrote:
> > >
> > > This patch from Badari is passing all testing now.
> > >
> > .....
> > > +++ 2.5.41-akpm/fs/xfs/linux/xfs_aops.c       Mon Oct  7 15:50:21 2002
> > > @@ -688,8 +688,8 @@ linvfs_direct_IO(
> > >  {
> > >       struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
> > >
> > > -        return generic_direct_IO(rw, inode, iov, offset, nr_segs,
> > > -                                     linvfs_get_blocks_direct);
> > > +        return generic_direct_IO(rw, inode, inode->i_sb->s_bdev,
> > > +                     iov, offset, nr_segs, linvfs_get_blocks_direct);
> > >  }
> > >
> > >  STATIC int
> > >
> > 
> > Actually this part is broken for XFS - it will work for most cases,
> > but not for realtime files, in this case there is another bdev involved.
> > I just have to work out how to get to it from here...... the getblock
> > code knows enough to set it in the bh, but at this level we do not.
> > 
> 
> Well we can pass in NULL for the while, get the old behaviour.
> 
> But yes, I'd prefer to only ever use the get_block() value.  It's
> really messy though - things like deferring the check of the aligment
> of all the iovec segments until we've run get_block...
> 
> Maybe we should ask the caller to pass in the alignment itself,
> just 512, 2048, etc?

In XFS case, if it does not know what the bdev is, how would the caller 
know the alignment ?

If we really *really* want to use "bdev" from get_block(), we can
do a dummy get_block(..., 0, READ) upfront and use the "bdev". 
Its UGLY but ..

- Badari


