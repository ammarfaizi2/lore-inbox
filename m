Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUIPRTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUIPRTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUIPRRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:17:45 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:2195 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S268334AbUIPRL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:11:59 -0400
Message-ID: <4149C176.2020506@drdos.com>
Date: Thu, 16 Sep 2004 10:38:14 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.9-rc2 bio sickness with large writes
References: <4148D2C7.3050007@drdos.com> <20040916063416.GI2300@suse.de>
In-Reply-To: <20040916063416.GI2300@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>>static int end_bio_asynch(struct bio *bio, unsigned int bytes_done, int err)
>>{
>>    ASYNCH_IO *io = bio->bi_private;
>>
>>    
>>
>
>      if (bio->bi_size)
>		return 1;
>  
>

I guess the question here is if a group of coalesed bios are submitted, 
shouldn't I get a callback
on each one? This implies if they merge beneath me, I won't always see 
the callback for each one.
Is this an acuurate assumption?

>  
>
>>         register struct page *page = virt_to_page(&Sector[i * blocksize]);
>>         register ULONG offset = ((ULONG)(&Sector[i * blocksize])) % PAGE_SIZE;
>>         register ULONG bytes;
>>
>>         bytes = bio_add_page(io->bio, page, 
>>                              PAGE_SIZE - (offset % PAGE_SIZE), 0);
>>    
>>
>
>offset instead of 0?
>
>  
>
blocksize always = PAGE_SIZE in this code. PAGE_SIZE - (offset % 
PAGE_SIZE) determines the length of the
transfer. You could just as well substitute PAGE_SIZE for blocksize. I 
always set the device (if it supports it) to a
PAGE_SIZE for the blocksize. 1024 blocksize is a little small.

>Get rid of this if/else, it's not correct. 2.6 always had
>bio_add_page(), and you _must_ use it.
>
>  
>

Linus should then do the same in buffer.c since this example is 
misleading in the code. Linus seems to get away with it
so why can't I? :-)

buffer.c line 2776
/*
* from here on down, it's all bio -- do the initial mapping,
* submit_bio -> generic_make_request may further map this bio around
*/
bio = bio_alloc(GFP_NOIO, 1);

bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
bio->bi_bdev = bh->b_bdev;
bio->bi_io_vec[0].bv_page = bh->b_page;
bio->bi_io_vec[0].bv_len = bh->b_size;
bio->bi_io_vec[0].bv_offset = bh_offset(bh);

bio->bi_vcnt = 1;
bio->bi_idx = 0;
bio->bi_size = bh->b_size;

bio->bi_end_io = end_bio_bh_io_sync;
bio->bi_private = bh;

submit_bio(rw, bio);


>>    // unplug the queue and drain the bathtub
>>    bio_get(io->bio);
>>    submit_bio(WRITE | (1 << BIO_RW_SYNC), io->bio);
>>    bio_put(io->bio);
>>    
>>
>
>You don't get to get/put the bio here, you aren't touching it after
>submit_bio().
>
>  
>

I removed this from my code. You need to correct the example in bio.h 
with something more meaningful. This is what
the source code says to do.

bio.h line 213

/*
* get a reference to a bio, so it won't disappear. the intended use is
* something like: *
* bio_get(bio);
* submit_bio(rw, bio);
* if (bio->bi_flags ...)
* do_something
* bio_put(bio);
*
* without the bio_get(), it could potentially complete I/O before submit_bio
* returns. and then bio would be freed memory when if (bio->bi_flags ...)
* runs
*/

I still see the problem and I suspect it's related to the callback 
mechanism with the bio-bi_size check always returning 1. I guess
the question here is are bios guaranteed to always return a 1:1 ratio of 
submission vs. callbacks?

Jeff


