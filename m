Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWLAHxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWLAHxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936072AbWLAHxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:53:44 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44677 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S936084AbWLAHxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:53:43 -0500
Date: Fri, 1 Dec 2006 08:53:41 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061201075341.GB31347@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp> <20061201020910.GC455@wotan.suse.de> <87mz68xoyi.fsf@duaron.myhome.or.jp> <20061201050852.GA31347@wotan.suse.de> <20061130232102.0cc7fc0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130232102.0cc7fc0b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 11:21:02PM -0800, Andrew Morton wrote:
> On Fri, 1 Dec 2006 06:08:52 +0100
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > On Fri, Dec 01, 2006 at 12:41:25PM +0900, OGAWA Hirofumi wrote:
> > > 
> > > Yes, this patch doesn't pass zero-length to prepare_write. However,
> > > I'm not checking this patch is ok for reiserfs...
> > 
> > OK, vfat wasn't working correctly for me -- I needed the following patch:
> 
> Now I'm confused.  What relationship does this patch have to the below?

It is on top of OGAWA Hirofumi's patch, which itself is a replacement
for fs-fix-cont-vs-deadlock-patches.patch. I'll ensure you get the
right one.

> revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
> revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
> generic_file_buffered_write-cleanup.patch
> mm-only-mm-debug-write-deadlocks.patch
> mm-fix-pagecache-write-deadlocks.patch
> mm-fix-pagecache-write-deadlocks-comment.patch
> mm-fix-pagecache-write-deadlocks-xip.patch
> mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
> mm-fix-pagecache-write-deadlocks-zerolength-fix.patch
> mm-fix-pagecache-write-deadlocks-stale-holes-fix.patch
> fs-prepare_write-fixes.patch
> fs-prepare_write-fixes-fuse-fix.patch
> fs-prepare_write-fixes-jffs-fix.patch
> fs-prepare_write-fixes-fat-fix.patch
> fs-fix-cont-vs-deadlock-patches.patch
> 
> 
> > Index: linux-2.6/fs/buffer.c
> > ===================================================================
> > --- linux-2.6.orig/fs/buffer.c	2006-12-01 15:31:22.000000000 +1100
> > +++ linux-2.6/fs/buffer.c	2006-12-01 16:02:23.000000000 +1100
> > @@ -2102,6 +2102,7 @@
> 
> Please always use `diff -p'

Dang, yes its much better.

> >  			*bytes |= (blocksize-1);
> >  			(*bytes)++;
> >  		}
> > +
> >  		status = __block_prepare_write(inode, new_page, zerofrom,
> >  						PAGE_CACHE_SIZE, get_block);
> >  		if (status)
> > @@ -2110,7 +2111,7 @@
> >  		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
> >  		flush_dcache_page(new_page);
> >  		kunmap_atomic(kaddr, KM_USER0);
> > -		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
> > +		__block_commit_write(inode, new_page, zerofrom, PAGE_CACHE_SIZE);
> 
> Whatever function this is doesn't need to update i_size?

Yes, it is the code in cont_prepare_write that is expanding a hole
at the end of file.

We can do this now because fat_commit_write is now changed to call
generic_commit_write in the case of a non-zero length.

I think it is an improvement because now the file will not get
arbitrarily extended in the case of a write failure somewhere down
the track.

