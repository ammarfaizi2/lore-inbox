Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSFOTq1>; Sat, 15 Jun 2002 15:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFOTq0>; Sat, 15 Jun 2002 15:46:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315481AbSFOTqZ>;
	Sat, 15 Jun 2002 15:46:25 -0400
Message-ID: <3D0B9A74.5872B63B@zip.com.au>
Date: Sat, 15 Jun 2002 12:50:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO 
 simplification
In-Reply-To: <200206151030.DAA01140@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> ...
>         newbio = q->one_more_bvec(q, bio, page, offset, len);
> 

That's a comfortable interface.  Or maybe just:

	struct bio *bio_add_bvec(bio, page, offset, len);

Couple of points:

- It's tricky to determine how many bvecs are available in
  a bio.  There is no straightforward "how big is it" field
  in struct bio.

- AFAIK, there are no established conventions for BIO assembly.
  We have conventions which state what the various fields do
  while the BIO is being processed by the block layer, but not
  for when the client is assembling the BIO.

What I did, and what I'd suggest as a convention is:

During BIO assembly, bi_vcnt indicates the maximum number of
bvecs which the BIO can hold. And bi_idx indexes the next-free
bvec within the BIO.

If you do this, *now* you have enough information to write
bio_add_bvec:

struct bio *bio_add_bvec(bio, page, offset, len)
{
	if (block layer says bio is maximum size) ||
			(bio->bi_idx == bio->bi_vcnt) {
		bio->bi_vcnt = bio->bi_idx;
		bio->bi_idx = 0;
		submit_bio(bio);	/* Caller has set up bi_end_io() */
		bio = NULL;
	} else {
		bio->bi_io_vec[bio->bi_idx].page = page;
		...
		bio->bi_idx++;
	}
	return bio;
}

It returns NULL if the bio was sent so that the caller gets
to allocate the new BIO.  If you want to allocate the new BIO
here you'll need to pass in gfp_flags and the new bio's
desired size as well.   And copy that size into bi_vcnt.

ll_rw_kio() can be adapted to the above convention too, which will
simplify it a little.

-
