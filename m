Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315795AbSEEAlF>; Sat, 4 May 2002 20:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315796AbSEEAlE>; Sat, 4 May 2002 20:41:04 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:59468 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315795AbSEEAlE>; Sat, 4 May 2002 20:41:04 -0400
Message-Id: <5.1.0.14.2.20020505010101.048d74e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 05 May 2002 01:41:20 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH-2.5.13] NTFS 2.0.6 Bugfix/adapt to 2.5.12 changes
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD47511.79846141@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:56 05/05/02, Andrew Morton wrote:
>Anton Altaparmakov wrote:
> > I have just sent the below NTFS update to Linus for inclusion. Andrew
> > Morton's changes to 2.5.12 broke NTFS because they added fields to
> > struct address_space which ntfs obviously wasn't initializing...
>
>Sorry about that, Chief.  ra_pages, presumably.  That's one
>which *has* to be initialised.

np, we are in a development kernel after all. (-; It was oopsing in 
ntfs_put_super->truncate_inode_pages->clean_list_pages() with a NULL 
pointer dereference... I didn't investigate further as it was immediately 
obvious what was going wrong once I added a printk in the right place so I 
knew mftbmp_mapping was the problem child.

>I've added quite a lot of "if you didn't provide one then I'll
>do the default" code, but that's an interim step - later, all
>the address_spaces need to be populated with the right stuff.
>
> > ...
> > +       /* Initialize the mftbmp address space mapping.  */
> > +       INIT_RADIX_TREE(&vol->mftbmp_mapping.page_tree, GFP_ATOMIC);
> > +       rwlock_init(&vol->mftbmp_mapping.page_lock);
> > +       INIT_LIST_HEAD(&vol->mftbmp_mapping.clean_pages);
> > +       INIT_LIST_HEAD(&vol->mftbmp_mapping.dirty_pages);
> > +       INIT_LIST_HEAD(&vol->mftbmp_mapping.locked_pages);
> > +       INIT_LIST_HEAD(&vol->mftbmp_mapping.io_pages);
> > +       vol->mftbmp_mapping.nrpages = 0;
> > +       vol->mftbmp_mapping.a_ops = NULL;
> > +       vol->mftbmp_mapping.host = NULL;
> > +       INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap);
> > +       INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap_shared);
> > +       spin_lock_init(&vol->mftbmp_mapping.i_shared_lock);
> > +       vol->mftbmp_mapping.dirtied_when = 0;
> > +       vol->mftbmp_mapping.gfp_mask = GFP_HIGHUSER;
>
>That's all generic code.   It's initialising core
>kernel fields.  If should be done in the core kernel.

Exactly my sentiments! (-:

>It would be better to split the address_space initialisation
>parts out of inode_init_once(), and export the new function...

Yes, I thought about that but the ntfs patch was rather urgent as people 
were reporting hangs and I saw oopses on umount so I wanted to just fix it 
asap without entering in possible discussions of generic code...

The only problem is that inode_init_once() doesn't set all the above 
because part of the initialization happens in alloc_inode(), so not to 
sacrifice this optimization we would need two inline helpers, one called by 
alloc_inode() and one called by inode_init_once(), and both called by the 
new exported function init_address_space().

I will whip up a patch and send it for comments...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

