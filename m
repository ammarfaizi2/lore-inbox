Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133070AbRDZC6n>; Wed, 25 Apr 2001 22:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133071AbRDZC6d>; Wed, 25 Apr 2001 22:58:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:56848 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133070AbRDZC6V>; Wed, 25 Apr 2001 22:58:21 -0400
Date: Thu, 26 Apr 2001 04:58:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: RAWIO-6 update [was Re: RAWIO-5 and O_DIRECT-3 updates]
Message-ID: <20010426045800.D24414@athlon.random>
In-Reply-To: <20010424085600.A784@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010424085600.A784@athlon.random>; from andrea@suse.de on Tue, Apr 24, 2001 at 08:56:00AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 08:56:00AM +0200, Andrea Arcangeli wrote:
> I fixed a new bug pointed out by Andrew and discussed on the kiobuf list
> (thanks Andrew!) (lock_kiovec was not handling correctly a failed trylockpage
> and could unlock pages locked by other people, not a big deal though as such
> function is never called in the whole pre6 and I'm wondering if it make sense
> at all to allow the pinned pages to be locked down in 2.4 [it certainly is
> still necessary in 2.2 for all the reads from disk]). However I didn't killed
> that function just in case there's an useful use of it. New updated rawio patch
> against vanilla 2.4.4pre6 is here:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre6/rawio-5.bz2

My 2.4 rawio-* patches had from the start an annoying bug that can be
triggered only with machines with more than 1G (I know, strictly
speaking some houndred MB less than 1G for vmalloc and friends but you
got it)

The bug is caused by this debugging check in the highmem bounce buffer
code that I didn't trapped while keeping the slab cache constructed
to improve the allocation of the buffer headers:

	memset(&bh->b_wait, -1, sizeof(bh->b_wait));

The side effect of the bug is that the kernel locks hard while paging
init in during boot (as said above only if you have more than 1G of
ram). You can guess why I didn't trapped it during regression testing.
So this is the incremental fix against rawio-5:

diff -urN rawio-5/mm/highmem.c rawio-6/mm/highmem.c
--- rawio-5/mm/highmem.c	Thu Dec 14 22:34:14 2000
+++ rawio-6/mm/highmem.c	Thu Apr 26 02:37:07 2001
@@ -207,6 +207,10 @@
 
 	bh_orig->b_end_io(bh_orig, uptodate);
 	__free_page(bh->b_page);
+#ifdef HIGHMEM_DEBUG
+	/* Don't clobber the constructed slab cache */
+	init_waitqueue_head(&bh->b_wait);
+#endif
 	kmem_cache_free(bh_cachep, bh);
 }
 
@@ -260,12 +264,14 @@
 	bh->b_count = bh_orig->b_count;
 	bh->b_rdev = bh_orig->b_rdev;
 	bh->b_state = bh_orig->b_state;
+#ifdef HIGHMEM_DEBUG
 	bh->b_flushtime = jiffies;
 	bh->b_next_free = NULL;
 	bh->b_prev_free = NULL;
 	/* bh->b_this_page */
 	bh->b_reqnext = NULL;
 	bh->b_pprev = NULL;
+#endif
 	/* bh->b_page */
 	if (rw == WRITE) {
 		bh->b_end_io = bounce_end_io_write;
@@ -274,7 +280,9 @@
 		bh->b_end_io = bounce_end_io_read;
 	bh->b_private = (void *)bh_orig;
 	bh->b_rsector = bh_orig->b_rsector;
+#ifdef HIGHMEM_DEBUG
 	memset(&bh->b_wait, -1, sizeof(bh->b_wait));
+#endif
 
 	return bh;
 }


(side note: right now HIGHMEM_DEBUG is enabled by default and that's ok of
course)

And here it is an update that is now supposed to work with highmem
machines as well:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre7/rawio-6

Andrea
