Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVA1KoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVA1KoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 05:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVA1KoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 05:44:04 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:4742 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261254AbVA1Knw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 05:43:52 -0500
Date: Fri, 28 Jan 2005 10:43:49 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Advice sought on how to lock multiple pages in ->prepare_write
 and ->writepage
In-Reply-To: <20050127165822.291dbd2d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0501280849120.7887@hermes-1.csi.cam.ac.uk>
References: <1106822924.30098.27.camel@imp.csi.cam.ac.uk>
 <20050127165822.291dbd2d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks a lot for your help!  Some comments below...

On Thu, 27 Jan 2005, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > What would you propose can I do to perform the required zeroing in a
> > deadlock safe manner whilst also ensuring that it cannot happen that a
> > concurrent ->readpage() will cause me to miss a page and thus end up
> > with non-initialized/random data on disk for that page?
> 
> The only thing I can think of is to lock all the pages.

Yes, that is what I was thinking, too.

> There's no other place in the kernel above you which locks multiple 
> pagecache pages, but we can certainly adopt the convention that 
> multiple-page-locking must proceed in ascending file offset order.

That sounds sensible.

> Which means that you'll need to drop and reacquire the page lock in
> ->prepare_write and in ->writepage, which could get unpleasant.

Yes, this is the bit I was worried about...

> For ->prepare_write it should be OK: the caller has a ref on the inode and
> you can check ->mapping after locking the page to see if a truncate flew
> past (OK, you have i_sem, but writepage will need to do this check).

Ok.  One down.

> For writepage() or writepages() with for_reclaim=0 you're OK: the caller
> has a ref on the inode and has taken sb->s_umount, so you can safely drop
> and retake the page lock.

Ok.

> For ->writepage with for_reclaim=1 the problem is that the inode can
> disappear on you altogether: you have no inode ref and if you let go of
> that page lock, truncate+reclaim or truncate+umount can zap the inode.
> 
> So hrm.  I guess your ->writepage(for_reclaim=1) could do a trylock on
> s_umount and fail the writepage if that didn't work out.

Ok, this should cause no problems.  I have already other places inside 
writepage (for metadata writes) which do trylock on an ntfs internal inode 
lock (it was necessary due to lock reversal: pagelock is held already in 
writepage but usually the ntfs lock is taken first and then pages are 
locked - now we just redirty the page in writepage if the trylock fails).

> That leaves the problem of preventing truncate+reclaim from zapping the
> inode when you've dropped the page lock.  I don't think you'll want to take
> a ref on the inode because the subsequent iput() can cause a storm of
> activity and I have vague memories that iput() inside
> ->writepage(for_reclaim=1) is a bad deal.  Maybe do a trylock on i_sem and
> fail the writepage if that doesn't work out?

The trylock is once again no problem.  But holding i_sem without a 
reference to the inode seems dodgy.  Will it really be sufficient?  I 
mean, yes it will exclude truncate but couldn't a reclaim kick in after 
the truncate has released i_sem and we have taken it?  Or am I missing 
something here?

In any case, once I relock the page I will need to check that it 
is still inside i_size I assume and also that it is in fact still dirty.

> That way, once you have i_sem and s_umount you can unlock the target page
> then populate+lock all the pages in the 64k segment.
> 
> Not very pretty though.

No, not pretty at all.  Especially as I will have to drop all sorts of 
NTFS locks (as my code is at present) which will cause me to have to redo 
a lot of work after reaquiring those locks.  I guess I will have to put in 
a "if (cluster_size > PAGE_CACHE_SIZE) detect hole" logic really early on 
and do the page cache magic at this stage and only then start taking NTFS 
locks and doing the work.

But it doesn't matter that it is not pretty.  It is not the usual scenario 
after all.  Normally a file gets created/opened and writing begins so the 
problem does not really occur as we would always be starting with the 
first page in a cluster and hence we would not need to drop its lock at 
all.  Also, the problem only occurs if cluster size > PAGE_CACHE_SIZE 
which will be false for the majority of cases.  (In NTFS using cluster 
size > 4kiB causes all sorts of negative side effects such as compression 
and possibly encryption being disabled for example and Windows will in 
fact never use cluster size > 4kiB by default but some people override the 
default due to special usage scenarios or really large volumes: with 4kiB 
clusters and the current artificial limit of 2^32-1 clusters imposed by 
Windows the maximum volume size is 16TiB.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
