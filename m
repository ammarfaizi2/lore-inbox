Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRCHMmC>; Thu, 8 Mar 2001 07:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131345AbRCHMlx>; Thu, 8 Mar 2001 07:41:53 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:197 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131348AbRCHMlj>; Thu, 8 Mar 2001 07:41:39 -0500
Date: Thu, 8 Mar 2001 13:41:14 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Questions - Re: [PATCH] documentation for mm.h
Message-ID: <20010308134114.P27675@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk> <Pine.LNX.4.33.0103071931400.1409-100000@duckman.distro.con <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk> <20010308115137.M27675@nightmaster.csn.tu-chemnitz.de> <5.0.2.1.2.20010308110922.00a41a60@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <5.0.2.1.2.20010308110922.00a41a60@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Thu, Mar 08, 2001 at 11:39:27AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 08, 2001 at 11:39:27AM +0000, Anton Altaparmakov wrote:
> > > >+       unsigned long index;            /* Our offset within mapping. */
> > > Assuming index is in bytes (it looks like it is):
> >isn't. To get the byte offset, you have to multiply it by PAGE_{CACHE_,}SIZE.
> 
> How do you reconcile that statement with the following comment from mm.h?
> 
>  > * A page may belong to an inode's memory mapping. In this case,
>  > * page->mapping is the pointer to the inode, and page->offset is the
>  > * file offset of the page (not necessarily a multiple of PAGE_SIZE).
 
page->index << PAGE_CACHE_SHIFT is the byte offset of this page
in the mapping.

The comment is crap, that should be removed (page->offset does
not exist anymore). 

Rik did this in his documentation patch or will do it, if he
reads this ;-)

> And even if it really is PAGE_{CACHE_}SIZE units, this still doesn't solve 
> the problem, it just defers it to 16Tib (on ia32 arch with 4kib 
> PAGE_{CACHE_}SIZE). With NTFS 3.0's use of sparse files, for the usn 
> journal for example, even this will be overflowed at some point on a 
> busy/large server. The only proper solution AFAICS is to allow the full 
> 64-bits.
 
Which is discussed already in another thread at lkml. I hope that
we'll get a 64bit blocklayer one day in 2.5/2.6 development.
Since this is only around 2 years and might be backported to 2.4
if needed, I don't see a big problem of deferring this.

Let's leave some market niche for commercial solutions for a while ;-)

> > > [snip]
> > > >+ * During disk I/O, PG_locked is used. This bit is set before I/O
> > > >+ * and reset when I/O completes. page->wait is a wait queue of all
> > > >+ * tasks waiting for the I/O on this page to complete.
> > >
> > > Is this physical I/O only or does it include a driver writing/reading 
> > the page?
> >
> >Depends on the method of the driver, that is getting called.
> 
> Sorry, I should have been more detailed in my question, so let me try 
> again: When the NTFS file system driver needs to modify the meta data, 
> which will be in the page cache (meta data is stored in normal files on 
> NTFS, hence the page cache is very well suited to storing it with it's 
> page->mapping and page->offset fields), does the NTFS driver need to set 
> PG_locked while writing to the page?

Ahh. I thought you've meant DEVICE drivers. If I talk about
drivers, I usally mean that. 

May be you should raise these issues again under a separate
subject and CC linux-fsdevel@vger.redhat.com for this.

I think it is worth it, because Linus want all fs to use page
cache for meta data and let buffer cache die slowly.

Basically the rules go like this:

The VM will wait for PG_locked pages, before it accesses them or
ignore them, if it cannot wait.

It will also try to read in pages, that are not PG_uptodate.

But user space will never see metadata pages anyway, so you
should be the only one, who cares about them. Just be prepared to
writepage() and readpage() and the like.

Just use lock_page() if you can sleep and TryLockPage() + EFAULT
(or similar) if you cannot.

Then just check Page_Uptodate() before you read and do
ClearUptodate() if you start writing to the metadata.

Since these operations are atomic bit operations, it should
suffice for your purpose.

But as stated above, I'm not very sure that I understand all the
code and know of all the races.

Multiple readers are AFAICS not yet possible with the current page
cache. 

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
