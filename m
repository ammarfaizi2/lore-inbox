Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSAFEEx>; Sat, 5 Jan 2002 23:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287686AbSAFEEo>; Sat, 5 Jan 2002 23:04:44 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:15590 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287684AbSAFEEk>; Sat, 5 Jan 2002 23:04:40 -0500
Message-Id: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 06 Jan 2002 04:04:36 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16N42t-0001It-00@starship.berlin>
In-Reply-To: <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:32 06/01/2002, Daniel Phillips wrote:
>On January 5, 2002 03:56 pm, Anton Altaparmakov wrote:
> > At 14:47 05/01/02, Daniel Phillips wrote:
> > >On January 5, 2002 03:29 pm, Anton Altaparmakov wrote:
> > > > If anyone wants a look NTFS TNG already has gone all the way (for a
> > > > while now in fact). Both fs inode and super block are fs internal slab
> > > > caches and both use static inline NTFS_I / NTFS_SB functions and the
> > > > ntfs includes from linux/fs.h are removed altogether. Code is in
> > > > sourceforge cvs. For instructions how to download the code or to 
> browse
> > > > it online, see:
> > >
> > >Nice, did you use the generic_ip fields?
> >
> > Yes. From ntfs-driver-tng/linux/fs/ntfs/fs.h:
> >
> > [...]
> >
> >   static inline ntfs_inode *NTFS_I(struct inode *inode)
> >   {
> >            return inode->u.generic_ip;
> >   }
>
>OK, so are doing two kmem_cache_allocs for every new_inode.  With the
>unbork.fs patch you could save 50% of the kmem_cache_allocs by
>rewriting as follows:
>
>     static inline ntfs_inode *NTFS_I(struct inode *inode)
>     {
>             /* should bug-check to be sure it's really one of ours */
>             return (ntfs_inode *) &(inode->u);
>     }
>
>And you just fill in the inode_size field of the file_system_type
>declaration.  The vfs will then handle all the details of allocating/freeing
>inodes and the inode slab cache.  (Note that Al seems to think this is the
>wrong way of doing it, but hasn't said why he thinks that yet.)

I will hold back any changes until all the details have been ironed out 
first and Al has given his seal of approval... To be honest I fail to see 
how one additional slab allocation will make any difference. Certainly for 
NTFS where we attach dynamically allocated data to the fs specific part of 
the inode (sometimes going via the slow vmalloc() at that) during the read 
inode call, I doubt very much that there will be any visible performance 
difference. But if it is decided that this is the Right Way(TM) to do it, I 
will of course go with it.

>For superblocks - are you sure you want a dedicated slab cache for those?  It
>seems to me that kmalloc is perfectly appropriate for this, and saves the
>code needed to set up, keep track of, and tear down the slab cache.

No, I was doing both at the same time and got slightly carried away. (-; I 
will convert the super block allocations to simple kmalloc()s when I get bored.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

