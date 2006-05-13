Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWEMHCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWEMHCn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 03:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWEMHCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 03:02:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750959AbWEMHCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 03:02:42 -0400
Date: Fri, 12 May 2006 23:59:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
Message-Id: <20060512235934.4f609019.akpm@osdl.org>
In-Reply-To: <17509.22160.118149.49714@cse.unsw.edu.au>
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Friday May 12, akpm@osdl.org wrote:
> > NeilBrown <neilb@suse.de> wrote:
> > >
> > > If md is asked to store a bitmap in a file, it tries to hold onto the
> > > page cache pages for that file, manipulate them directly, and call a
> > > cocktail of operations to write the file out.  I don't believe this is
> > > a supportable approach.
> > 
> > erk.  I think it's better than...
> > 
> > > This patch changes the approach to use the same approach as swap files.
> > > i.e. bmap is used to enumerate all the block address of parts of the file
> > > and we write directly to those blocks of the device.
> > 
> > That's going in at a much lower level.  Even swapfiles don't assume
> > buffer_heads.
> 
> I'm not "assuming" buffer_heads.  I'm creating buffer heads and using
> them for my own purposes.  These are my pages and my buffer heads.
> None of them belong to the filesystem.

Right, so it's incoherent with pagecache and userspace can no longer
usefully read this file.

> The buffer_heads are simply a convenient data-structure to record the
> several block addresses for each page.  I could have equally created
> an array storing all the addresses, and built the required bios by
> hand at write time.  But buffer_heads did most of the work for me, so
> I used them.

OK.

> Yes, it is a lower level, but
>  1/ I am certain that there will be no kmalloc problems and
>  2/ Because it is exactly the level used by swapfile, I know that it
>     is sufficiently 'well defined' that no-one is going to break it.

It would be nicer of course to actually use the mm/page_io.c code.  That
would involve implementing swap_bmap() and reimplementing the
get_swap_bio() stuff in terms of a_ops->bmap().

But the swap code can afford to skip blockruns which aren't page-sized and
it uses that capability nicely.  You cannot do that.

> > 
> > All this (and a set_fs(KERNEL_DS), ug) looks like a step backwards to me. 
> > Operating at the pagecache a_ops level looked better, and more
> > filesystem-independent.
> 
> If you really want filesystem independence, you need to use vfs_read
> and vfs_write to read/write the file.

yup.

>  I have a patch which did that,
> but decided that the possibility of kmalloc failure at awkward times
> would make that not suitable.

submit_bh() can and will allocate memory, although most decent device
drivers should be OK.

There are tricks we can do with writepage.  If the backing filesystem uses
buffer_heads and if you hold a ref on the page then we know that there
won't be any buffer_head allocations nor any disk reads in the writepage
path.  It'll go direct into bio_alloc+submit_bio, just as you're doing now.
IOW: no gain.

> So I now use vfs_read to read in the file (just like knfsd) and
> bmap/submit_bh to write out the file (just like swapfile).
> 
> I don't think a_ops really provides an interface that I can use, partly
> because, as I said in a previous email, it isn't really a public
> interface to a filesystem.

It's publicer than bmap+submit_bh!

> > 
> > I haven't looked at this patch at all closely yet.  Do I really need to?
> 
> I assume you are asking that because you hope I will retract the
> patch.

Was kinda hoping that would be the outcome.  It's rather gruesome, using
set_fs()+vfs_read() on one side and submit_bh() on the other.

Are you sure the handling at EOF for a non-multiple-of-PAGE_SIZE file
is OK?

The loss of pagecache coherency seems sad.  I assume there's never a
requirement for userspace to read this file.

invalidate_inode_pages() is best-effort.  If someone else has the page
locked or if the page is mmapped then the attempt to take down the
pagecache will fail.  That's relatively-OK, because it'll just lead to
userspace seeing wrong stuff, and we've already conceded that.

But if the pagecache is dirty then invalidate_inode_pages() will leave it
dirty and the VM will later write it back, corrupting your bitmap file. 
You should get i_writecount, fsync the file and then run
invalidate_inode_pages().

Or not run invalidate_inode_pages() - it doesn't gain anything and will
just reduce the observeability of bugs.  Better off leaving the pagecache
there all the time so that any rarely-occurring bugs become all-the-time
bugs.

You might as well use kernel_read() too, if you insist on begin oddball ;)
