Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSFFTf3>; Thu, 6 Jun 2002 15:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSFFTf2>; Thu, 6 Jun 2002 15:35:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317114AbSFFTf0>;
	Thu, 6 Jun 2002 15:35:26 -0400
Message-ID: <3CFFB92E.E4549B33@zip.com.au>
Date: Thu, 06 Jun 2002 12:34:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's 
 bigger than queue could handle
In-Reply-To: <200206061331.GAA00287@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> ...
> +int bio_append(struct bio **bio_p, struct page *page, int len, int offset)
> +{
> +       struct bio *bio = *bio_p;
> +       struct bio_vec *vec;
> +       if (bio->bi_idx == bio->bi_vcnt) {
> +               struct bio *old = bio;
> +               *bio_p = bio = bio_alloc(GFP_KERNEL, old->bi_vcnt);

GFP_KERKEL is OK on the readpages() path, but on the writepages()
path it can go infinitely recursive - it needs to be GFP_NOFS.
So another arg is needed here.  I suspect this function ends up adding
more complexity than it takes away, frankly.

> +               if (bio != NULL) {
> +                       bio->bi_sector =
> +                               old->bi_sector + (old->bi_size >> 9);
> +
> +#define COPY(field)    bio->bi_ ## field = old->bi_ ## field
> +                       COPY(bdev);
> +                       COPY(flags);
> +                       COPY(idx);
> +                       COPY(rw);
> +                       COPY(end_io);
> +                       COPY(private);
> +#undef COPY
> +               }
> +               old->bi_idx = 0;
> +               submit_bio(old->bi_rw, old);

Here we're allocating a new BIO before submitting the old one.
This increases the risk of oom deadlocks on the vm_writeback()
path.

I'd prefer that the bio alloc/submit code paths be left as-is...


> +       struct block_device *bdev =
> +               S_ISBLK(inode->i_mode) ? inode->i_bdev : inode->i_sb->s_bdev;

I believe it's cleaner to allow get_block() to decide which
blockdevice belongs to this mapping, really.

-
