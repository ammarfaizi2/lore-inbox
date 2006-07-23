Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWGWXV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWGWXV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 19:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWGWXVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 19:21:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:16026 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751375AbWGWXVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 19:21:25 -0400
Message-ID: <44C404C9.6050409@suse.com>
Date: Sun, 23 Jul 2006 19:22:49 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <44C3E041.1020909@suse.com> <44C3E6EE.8080607@namesys.com>
In-Reply-To: <44C3E6EE.8080607@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Jeff Mahoney wrote:
> 
>>
>> That particular bug isn't in the bitmap scanning code, it's a side
>> effect of the write batching higher up.
> 
> Did you write the code that looks for a window of 32
> blocks?  If not, and if this code has been around for a long time, I
> apologize.   I thought you did write it and added it in recent months.

Nope. The scan_bitmap_block() code that looks for windows was added in
a changeset from a bk merge against 2.5.33 in September 2002. The change
to want a minimum size window was added in June 2004 to 2.6.8-rc2. That
patch is actually credited to both Mason and I, but I don't recall who
wrote that bit. It may well have been my code, after all, but it's
certainly not a new bug. *shrug* I guess MythTV might just be generating
an i/o pattern that hadn't been seen before.

>> A
>> quick fix would be to set a flag indicating that future writes shouldn't
>> bother trying to find a window that large,
> 
> There are lots of quick fixes.  1) The quickest is to not scan for the
> window at all.  2) The second quickest is to limit the number of bitmaps
> that will be scanned to some number like 3.  3) The not at all quickest
> is to track free extents like XFS does, which is not a hack, but it
> belongs in a development branch.  I am not sure it is worth the
> complexity, but my mind is not closed.
> 
> On monday we will do 1) or 2), probably 1).   After the repacker is
> done, we should review all our block allocation algorithms.  I have an
> idea for how to do things more optimally for streaming media that will
> avoid fragmentation over time, and when combined with the repacker may
> make 3 not worthwhile.

If you want to go the 1) route, it's trivial. See patch below. It will
restore the one-block-at-a-time behavior.

> I am grateful that you and Chris do bug fixes, but when you guys are too
> busy, (and that can and will happen to any of us), the baton needs to
> get passed.  V3 needs to be a zero defect product, and once we know it
> is a bug I don't want bugs in V3 to remain unfixed for more than a day
> plus the time it takes to fix it.    If you do add code, I want any bugs
> that show up in the aftermath of mainstream merging to get jumped on.

Anyone up for it? :) There are changes I'd like to see in reiser3,
particularly ones that address the severe problems observed in David
Chinner's high bandwidth file system talk this year at OLS. Specifically,
it ended up making very little progress and spending the majority of the
time in the journal when the workload is streaming data at the disk at a
very high rate on a very large file system. Yes, that is certainly XFS's
sweet spot, but barely making progress at all is a bit more severe than
"poor performance." Perhaps mkreiserfs should be a bit saner about choosing
journal sizes, since a 32 MB journal is not a good fit for all cases. Also,
I'd like to see the usage of the BKL gone as it severely limits performance
when more than one thread is writing to the file system, or even another
reiserfs file system. It's not entirely low hanging fruit since the nested
cases need to be audited, but it shouldn't be too hard to eliminate the
inter-filesystem lock contention by replacing the BKL with a per-sb mutex.
I have some more things, but I have nowhere near the time to do them,
and other file systems will perform fine.

- -Jeff

Patch:

- --- linux-2.6.17.orig/fs/reiserfs/bitmap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.17.orig.devel/fs/reiserfs/bitmap.c	2006-07-23 19:10:57.000000000 -0400
@@ -1020,7 +1020,6 @@
 	b_blocknr_t finish = SB_BLOCK_COUNT(s) - 1;
 	int passno = 0;
 	int nr_allocated = 0;
- -	int bigalloc = 0;
 
 	determine_prealloc_size(hint);
 	if (!hint->formatted_node) {
@@ -1047,28 +1046,9 @@
 				hint->preallocate = hint->prealloc_size = 0;
 		}
 		/* for unformatted nodes, force large allocations */
- -		bigalloc = amount_needed;
 	}
 
 	do {
- -		/* in bigalloc mode, nr_allocated should stay zero until
- -		 * the entire allocation is filled
- -		 */
- -		if (unlikely(bigalloc && nr_allocated)) {
- -			reiserfs_warning(s, "bigalloc is %d, nr_allocated %d\n",
- -					 bigalloc, nr_allocated);
- -			/* reset things to a sane value */
- -			bigalloc = amount_needed - nr_allocated;
- -		}
- -		/*
- -		 * try pass 0 and pass 1 looking for a nice big
- -		 * contiguous allocation.  Then reset and look
- -		 * for anything you can find.
- -		 */
- -		if (passno == 2 && bigalloc) {
- -			passno = 0;
- -			bigalloc = 0;
- -		}
 		switch (passno++) {
 		case 0:	/* Search from hint->search_start to end of disk */
 			start = hint->search_start;
@@ -1106,8 +1086,7 @@
 								 new_blocknrs +
 								 nr_allocated,
 								 start, finish,
- -								 bigalloc ?
- -								 bigalloc : 1,
+								 1,
 								 amount_needed -
 								 nr_allocated,
 								 hint->


- -- 
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFExATJLPWxlyuTD7IRAmeKAJsFI/awPPAXpB2DI+kO19EZtr3tRwCfWduO
Re+5kXNtj6St/LuUy9lbNm4=
=anQd
-----END PGP SIGNATURE-----
