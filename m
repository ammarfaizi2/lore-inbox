Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUABKIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbUABKIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:08:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26291 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265465AbUABKIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:08:13 -0500
Date: Fri, 2 Jan 2004 11:08:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, packet-writing@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
Message-ID: <20040102100807.GF5523@suse.de>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com> <20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2llorkuhn.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Peter Osterlund wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Peter Osterlund <petero2@telia.com> wrote:
> > >
> > > If I create an ext2 filesystem
> > >  with 2kb blocksize, I hit a bug when I try to write some large files to
> > >  the filesystem. The problem is that the code in mpage_writepage() fails if
> > >  a page is mapped to disk across a packet boundary. In that case, the
> > >  bio_add_page() call at line 543 in mpage.c can fail even if the bio was
> > >  previously empty. The code then passes an empty bio to submit_bio(), which
> > >  triggers a bug at line 2303 in ll_rw_blk.c. This patch seems to fix the
> > >  problem.
> > > 
> > >  --- linux/fs/mpage.c.old	2004-01-02 00:26:19.000000000 +0100
> > >  +++ linux/fs/mpage.c	2004-01-02 00:26:50.000000000 +0100
> > >  @@ -541,6 +541,11 @@
> > >   
> > >   	length = first_unmapped << blkbits;
> > >   	if (bio_add_page(bio, page, length, 0) < length) {
> > >  +		if (!bio->bi_size) {
> > >  +			bio_put(bio);
> > >  +			bio = NULL;
> > >  +			goto confused;
> > >  +		}
> > >   		bio = mpage_bio_submit(WRITE, bio);
> > >   		goto alloc_new;
> > >   	}
> > 
> > Confused.  We initially have an empty BIO, and we run bio_add_page()
> > against it, adding one page.
> > 
> > How can that bio_add_page() fail to add the page?
> > 
> > Cold you describe the failure a little more please?
> 
> In bio_add_page(), there is this check:
> 
> 	/*
> 	 * if queue has other restrictions (eg varying max sector size
> 	 * depending on offset), it can specify a merge_bvec_fn in the
> 	 * queue to get further control
> 	 */
> 	if (q->merge_bvec_fn) {
> 		/*
> 		 * merge_bvec_fn() returns number of bytes it can accept
> 		 * at this offset
> 		 */
> 		if (q->merge_bvec_fn(q, bio, bvec) < len) {
> 			bvec->bv_page = NULL;
> 			bvec->bv_len = 0;
> 			bvec->bv_offset = 0;
> 			return 0;
> 		}
> 	}
> 
> The packet writing code has the restriction that a bio must not span a
> packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
> to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
> returns 2048, which is less than len, which is 4096 if the whole page
> is mapped, so the bio_add_page() call fails.

The packet writing code is buggy then, you must always allow a page to
be added to an empty bio. You'll have to deal with the pieces there, I'm
afraid.

So it's not a bug in mpage. If that was the case, there are other buggy
places in the kernel.

-- 
Jens Axboe

