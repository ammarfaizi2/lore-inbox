Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUC3SST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUC3SST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:18:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12269 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263800AbUC3SSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:18:09 -0500
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3
	preallocation
From: Mingming Cao <cmm@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, tytso@mit.edu,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200403300907.33995.pbadari@us.ibm.com>
References: <200403190846.56955.pbadari@us.ibm.com>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org> 
	<200403300907.33995.pbadari@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Mar 2004 10:23:52 -0800
Message-Id: <1080671034.4714.4576.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 09:07, Badari Pulavarty wrote:
> On Tuesday 30 March 2004 01:45 am, Andrew Morton wrote:
> 
> >I thing this is heading the right way.
Andrew, Thanks your comment and response to quickly! Will make changes
as you suggested.

> Andrew,
> 
> > - Using ext3_find_next_zero_bit(bitmap_bh->b_data in
> >   alloc_new_reservation() is risky. 

> Can you explain this a little more ?  What does b->data and b->commited_data 
> represent ?  We are assuming that b->data will always be uptodate. 
> 
> May be we should use ext3_test_allocatable() also.
> Mingming, what was the reason for using ext3_find_next_zero_bit() only ?
> We had this discussion earlier, but I forgot :(

I thought that just using ext3_find_next_zero_bit probably would be okey
since, once we get a reservation window that has a possible free block, 
the ext3_try_to_allocate will check both the block group bitmap and the
copy of last committed bitb inside that window range anyway before doing
the real allocation. If there is no really free block on both bitmaps,
ext3_try_to_allocate will fail and will looking for a new reservation
window.  

But as Andrew said, this may cause unnecessary calling
ext3_try_to_allocate() many many times...

We could do the same thing as in find_next_usable_block(): 
/*
 * The bitmap search --- search forward alternately through the actual
 * bitmap and the last-committed copy until we find a bit free in
 * both
 */
  while (here < maxblocks) {
          next = ext3_find_next_zero_bit(bh->b_data, maxblocks, here);
          if (next >= maxblocks)
                  return -1;
         if (ext3_test_allocatable(next, bh))
                 return next;
         jbd_lock_bh_state(bh);
         if (jh->b_committed_data)
         here =
	ext3_find_next_zero_bit(jh->b_committed_data,                                                        maxblocks, next);
        jbd_unlock_bh_state(bh);
 }

Maybe make this a inline function....ext2 does not need to care about
the journalling stuff.

> > - Make sure that you have a many-small-file test.  Say, untar a kernel
> >   tree onto a clean filesystem and make sure that reading all the files in
> >   the tree is nice and fast.
Haven't got a chance to verify that but good point. Will do.
> >
> >   This is to check that the reservation is being discarded appropriately
> >   on file close, and that those small files are contiguous on-disk.  If we
> >   accidentally leave gaps in between them the many-small-file bandwidth
> >   takes a dive.
> 
> Hmm. Ted proposed that we should keep reservation after file close. 
> We weren't sure about this either. Its on our TODO list.

Only some files need to keep reservation cross file open/close, for
those that opened with append flag, or some file like /var/log while
multiple processes frequently open/write/close/. Maybe a file attribute
or a open flag could be used for this purpose.  For regular files, I
think the files should discard at close. Untar a kernel tree just did
open files with WRITE then write and close.

> 
> >
> > - There's a little program called `bmap' in
> >   http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz which
> >   can be used to dump out a file's block allocation map, to check
> >   fragmentation.
> 
Thanks again.

Mingming
 


