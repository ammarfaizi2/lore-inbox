Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287615AbSAFD3W>; Sat, 5 Jan 2002 22:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287626AbSAFD3N>; Sat, 5 Jan 2002 22:29:13 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:52240 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287615AbSAFD3E>;
	Sat, 5 Jan 2002 22:29:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Date: Sun, 6 Jan 2002 04:32:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk> <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16N42t-0001It-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 03:56 pm, Anton Altaparmakov wrote:
> At 14:47 05/01/02, Daniel Phillips wrote:
> >On January 5, 2002 03:29 pm, Anton Altaparmakov wrote:
> > > If anyone wants a look NTFS TNG already has gone all the way (for a
> > > while now in fact). Both fs inode and super block are fs internal slab 
> > > caches and both use static inline NTFS_I / NTFS_SB functions and the 
> > > ntfs includes from linux/fs.h are removed altogether. Code is in 
> > > sourceforge cvs. For instructions how to download the code or to browse 
> > > it online, see:
> >
> >Nice, did you use the generic_ip fields?
> 
> Yes. From ntfs-driver-tng/linux/fs/ntfs/fs.h:
>
> [...]
>
>   static inline ntfs_inode *NTFS_I(struct inode *inode)
>   {
>            return inode->u.generic_ip;
>   }

OK, so are doing two kmem_cache_allocs for every new_inode.  With the 
unbork.fs patch you could save 50% of the kmem_cache_allocs by 
rewriting as follows:

    static inline ntfs_inode *NTFS_I(struct inode *inode)
    {
            /* should bug-check to be sure it's really one of ours */
            return (ntfs_inode *) &(inode->u);
    }

And you just fill in the inode_size field of the file_system_type 
declaration.  The vfs will then handle all the details of allocating/freeing 
inodes and the inode slab cache.  (Note that Al seems to think this is the 
wrong way of doing it, but hasn't said why he thinks that yet.)

For superblocks - are you sure you want a dedicated slab cache for those?  It 
seems to me that kmalloc is perfectly appropriate for this, and saves the 
code needed to set up, keep track of, and tear down the slab cache.

--
Daniel
