Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSJHQsa>; Tue, 8 Oct 2002 12:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSJHQsa>; Tue, 8 Oct 2002 12:48:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:56799 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261284AbSJHQs3>;
	Tue, 8 Oct 2002 12:48:29 -0400
Message-ID: <3DA30DAB.BDED8ABE@digeo.com>
Date: Tue, 08 Oct 2002 09:54:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch] 512-byte alignment for O_DIRECT I/O
References: <3DA211B8.325C32BA@digeo.com> <1034094869.16054.7.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 16:54:03.0890 (UTC) FILETIME=[4ED75520:01C26EEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> On Mon, 2002-10-07 at 17:59, Andrew Morton wrote:
> >
> > This patch from Badari is passing all testing now.
> >
> .....
> > +++ 2.5.41-akpm/fs/xfs/linux/xfs_aops.c       Mon Oct  7 15:50:21 2002
> > @@ -688,8 +688,8 @@ linvfs_direct_IO(
> >  {
> >       struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
> >
> > -        return generic_direct_IO(rw, inode, iov, offset, nr_segs,
> > -                                     linvfs_get_blocks_direct);
> > +        return generic_direct_IO(rw, inode, inode->i_sb->s_bdev,
> > +                     iov, offset, nr_segs, linvfs_get_blocks_direct);
> >  }
> >
> >  STATIC int
> >
> 
> Actually this part is broken for XFS - it will work for most cases,
> but not for realtime files, in this case there is another bdev involved.
> I just have to work out how to get to it from here...... the getblock
> code knows enough to set it in the bh, but at this level we do not.
> 

Well we can pass in NULL for the while, get the old behaviour.

But yes, I'd prefer to only ever use the get_block() value.  It's
really messy though - things like deferring the check of the aligment
of all the iovec segments until we've run get_block...

Maybe we should ask the caller to pass in the alignment itself,
just 512, 2048, etc?
