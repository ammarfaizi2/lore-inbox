Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSEDXyD>; Sat, 4 May 2002 19:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315258AbSEDXyC>; Sat, 4 May 2002 19:54:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32272 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315257AbSEDXyB>;
	Sat, 4 May 2002 19:54:01 -0400
Message-ID: <3CD47511.79846141@zip.com.au>
Date: Sat, 04 May 2002 16:56:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.5.13] NTFS 2.0.6 Bugfix/adapt to 2.5.12 changes
In-Reply-To: <E1747yJ-0005eY-00@storm.christs.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Hi,
> 
> I have just sent the below NTFS update to Linus for inclusion. Andrew
> Morton's changes to 2.5.12 broke NTFS because they added fields to
> struct address_space which ntfs obviously wasn't initializing...

Sorry about that, Chief.  ra_pages, presumably.  That's one
which *has* to be initialised.

I've added quite a lot of "if you didn't provide one then I'll 
do the default" code, but that's an interim step - later, all
the address_spaces need to be populated with the right stuff.

> ...
> +       /* Initialize the mftbmp address space mapping.  */
> +       INIT_RADIX_TREE(&vol->mftbmp_mapping.page_tree, GFP_ATOMIC);
> +       rwlock_init(&vol->mftbmp_mapping.page_lock);
> +       INIT_LIST_HEAD(&vol->mftbmp_mapping.clean_pages);
> +       INIT_LIST_HEAD(&vol->mftbmp_mapping.dirty_pages);
> +       INIT_LIST_HEAD(&vol->mftbmp_mapping.locked_pages);
> +       INIT_LIST_HEAD(&vol->mftbmp_mapping.io_pages);
> +       vol->mftbmp_mapping.nrpages = 0;
> +       vol->mftbmp_mapping.a_ops = NULL;
> +       vol->mftbmp_mapping.host = NULL;
> +       INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap);
> +       INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap_shared);
> +       spin_lock_init(&vol->mftbmp_mapping.i_shared_lock);
> +       vol->mftbmp_mapping.dirtied_when = 0;
> +       vol->mftbmp_mapping.gfp_mask = GFP_HIGHUSER;

That's all generic code.   It's initialising core
kernel fields.  If should be done in the core kernel.

It would be better to split the address_space initialisation
parts out of inode_init_once(), and export the new function...

-
