Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUABBad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUABBad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:30:33 -0500
Received: from smtp4.hy.skanova.net ([195.67.199.133]:58575 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262127AbUABBa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:30:29 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, packet-writing@suse.com, linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
	<20040101162427.4c6c020b.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2004 02:30:12 +0100
In-Reply-To: <20040101162427.4c6c020b.akpm@osdl.org>
Message-ID: <m2llorkuhn.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > If I create an ext2 filesystem
> >  with 2kb blocksize, I hit a bug when I try to write some large files to
> >  the filesystem. The problem is that the code in mpage_writepage() fails if
> >  a page is mapped to disk across a packet boundary. In that case, the
> >  bio_add_page() call at line 543 in mpage.c can fail even if the bio was
> >  previously empty. The code then passes an empty bio to submit_bio(), which
> >  triggers a bug at line 2303 in ll_rw_blk.c. This patch seems to fix the
> >  problem.
> > 
> >  --- linux/fs/mpage.c.old	2004-01-02 00:26:19.000000000 +0100
> >  +++ linux/fs/mpage.c	2004-01-02 00:26:50.000000000 +0100
> >  @@ -541,6 +541,11 @@
> >   
> >   	length = first_unmapped << blkbits;
> >   	if (bio_add_page(bio, page, length, 0) < length) {
> >  +		if (!bio->bi_size) {
> >  +			bio_put(bio);
> >  +			bio = NULL;
> >  +			goto confused;
> >  +		}
> >   		bio = mpage_bio_submit(WRITE, bio);
> >   		goto alloc_new;
> >   	}
> 
> Confused.  We initially have an empty BIO, and we run bio_add_page()
> against it, adding one page.
> 
> How can that bio_add_page() fail to add the page?
> 
> Cold you describe the failure a little more please?

In bio_add_page(), there is this check:

	/*
	 * if queue has other restrictions (eg varying max sector size
	 * depending on offset), it can specify a merge_bvec_fn in the
	 * queue to get further control
	 */
	if (q->merge_bvec_fn) {
		/*
		 * merge_bvec_fn() returns number of bytes it can accept
		 * at this offset
		 */
		if (q->merge_bvec_fn(q, bio, bvec) < len) {
			bvec->bv_page = NULL;
			bvec->bv_len = 0;
			bvec->bv_offset = 0;
			return 0;
		}
	}

The packet writing code has the restriction that a bio must not span a
packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
returns 2048, which is less than len, which is 4096 if the whole page
is mapped, so the bio_add_page() call fails.

I don't think this case ever happens with the standard kernel, because
it doesn't (afaik) contain any merge_bvec_fn implementations that are
as restrictive as the one in the cdrw packet writing code. I still
think the code in mpage_writepage() is wrong, even if it happens to
work in the standard kernel.

> >  I noted that performance is quite bad with 2kb blocksize. It is a lot
> >  faster with 4kb blocksize. (2kb blocksize with the udf filesystem is not
> >  slow, only ext2 seems to have this problem.) Maybe the "confused" case
> >  (which calls a_ops->writepage()) in mpage_writepage() isn't really meant
> >  to be fast. Is there a better way to fix this problem?
> 
> How much slower is it?

I didn't make any exact measurements, but it looked like the pageout
code didn't throw enough parallel bios at the packet writing request
queue, so a lot of incomplete packets had to be written to disk. This
is very costly, because the code then has to do read/modify/write
cycles instead of just writing the whole packet directly.

A rough guess is that 2kb block size was 2-3 times slower than 4kb
block size, but I'll make more tests later to see what's really going
on here.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
