Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUIQHjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUIQHjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268540AbUIQHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:39:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65441 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268515AbUIQHip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:38:45 -0400
Date: Fri, 17 Sep 2004 09:36:56 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.9-rc2 bio sickness with large writes
Message-ID: <20040917073653.GA2573@suse.de>
References: <4148D2C7.3050007@drdos.com> <20040916063416.GI2300@suse.de> <4149C176.2020506@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4149C176.2020506@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16 2004, Jeff V. Merkey wrote:
> 
> >
> >>static int end_bio_asynch(struct bio *bio, unsigned int bytes_done, int 
> >>err)
> >>{
> >>   ASYNCH_IO *io = bio->bi_private;
> >>
> >>   
> >>
> >
> >     if (bio->bi_size)
> >		return 1;
> > 
> >
> 
> I guess the question here is if a group of coalesed bios are submitted, 
> shouldn't I get a callback
> on each one? This implies if they merge beneath me, I won't always see 
> the callback for each one.
> Is this an acuurate assumption?

No, you are reading it wrong. You will get a callback for each bio that
you issued, regardless of merge status. You never need to care about
merge status. But you might get partial completions from drivers, so
multiple completions on the same bio. Your code doesn't look like it's
handling that - you either need to take bytes_done into account, or just
add the above two lines if you don't care about partial completions.
When bi_size reaches 0, all io is done on this bio.

> >>        register struct page *page = virt_to_page(&Sector[i * blocksize]);
> >>        register ULONG offset = ((ULONG)(&Sector[i * blocksize])) % 
> >>        PAGE_SIZE;
> >>        register ULONG bytes;
> >>
> >>        bytes = bio_add_page(io->bio, page, 
> >>                             PAGE_SIZE - (offset % PAGE_SIZE), 0);
> >>   
> >>
> >
> >offset instead of 0?
> >
> > 
> >
> blocksize always = PAGE_SIZE in this code. PAGE_SIZE - (offset % 
> PAGE_SIZE) determines the length of the
> transfer. You could just as well substitute PAGE_SIZE for blocksize. I 
> always set the device (if it supports it) to a
> PAGE_SIZE for the blocksize. 1024 blocksize is a little small.

Ok, that's not visible from the source you sent. You should still change
that to offset in case this changes. Or if not, kill the PAGE_SIZE - xxx
stuff to avoid confusion.

> >Get rid of this if/else, it's not correct. 2.6 always had
> >bio_add_page(), and you _must_ use it.
> >
> > 
> >
> 
> Linus should then do the same in buffer.c since this example is 
> misleading in the code. Linus seems to get away with it
> so why can't I? :-)

Linus didn't write that, I did.
> 
> buffer.c line 2776
> /*
> * from here on down, it's all bio -- do the initial mapping,
> * submit_bio -> generic_make_request may further map this bio around
> */
> bio = bio_alloc(GFP_NOIO, 1);
> 
> bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
> bio->bi_bdev = bh->b_bdev;
> bio->bi_io_vec[0].bv_page = bh->b_page;
> bio->bi_io_vec[0].bv_len = bh->b_size;
> bio->bi_io_vec[0].bv_offset = bh_offset(bh);
> 
> bio->bi_vcnt = 1;
> bio->bi_idx = 0;
> bio->bi_size = bh->b_size;
> 
> bio->bi_end_io = end_bio_bh_io_sync;
> bio->bi_private = bh;
> 
> submit_bio(rw, bio);

And submit_bh() is correct, since it only uses a single page. You are
adding multiple pages to the bio manually, this is highly illegal. If
you aren't using bio_add_page() to do this you are both on your own and
in a world of pain support wise.

> >>   // unplug the queue and drain the bathtub
> >>   bio_get(io->bio);
> >>   submit_bio(WRITE | (1 << BIO_RW_SYNC), io->bio);
> >>   bio_put(io->bio);
> >>   
> >>
> >
> >You don't get to get/put the bio here, you aren't touching it after
> >submit_bio().
> >
> > 
> >
> 
> I removed this from my code. You need to correct the example in bio.h 
> with something more meaningful. This is what
> the source code says to do.
> 
> bio.h line 213
> 
> /*
> * get a reference to a bio, so it won't disappear. the intended use is
> * something like: *
> * bio_get(bio);
> * submit_bio(rw, bio);
> * if (bio->bi_flags ...)
> * do_something
> * bio_put(bio);
> *
> * without the bio_get(), it could potentially complete I/O before submit_bio
> * returns. and then bio would be freed memory when if (bio->bi_flags ...)
> * runs
> */

No, you need to read it properly. See how it looks at the bio after
submitting it in this example? That's why it gets a reference to it.
There's even a comment to that effect. You don't need to hold a
reference across the submit_bio() call if you don't look at the bio
afterwards, why would you care? This is, btw, no different than the bh
semantics since 2.4...

> I still see the problem and I suspect it's related to the callback 
> mechanism with the bio-bi_size check always returning 1. I guess
> the question here is are bios guaranteed to always return a 1:1 ratio of 
> submission vs. callbacks?

Fix your code like I described first, I cannot help you otherwise. Your
question is answered further up (it's yes).

-- 
Jens Axboe

