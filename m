Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUGONw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUGONw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUGONw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:52:29 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:58788 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S266208AbUGONwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:52:12 -0400
Date: Thu, 15 Jul 2004 15:46:04 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: [2.6.8-rc1-mm1][CD-Burning]kernel BUG at mm/page_alloc.c:796
In-reply-to: <20040715090052.GF22672@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, j@bitron.ch,
       cadcam@ipt.rwth-aachen.de
Message-id: <200407151546.04153@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <200407142336.15998@zodiac.zodiac.dnsalias.org>
 <20040715090052.GF22672@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch does the trick. Thanks for the fast response ;)

regards
Alex

Am Donnerstag, 15. Juli 2004 11:00 schrieb Jens Axboe:
> On Wed, Jul 14 2004, Alexander Gran wrote:
> > Hi,
> >
> > I cannot burn cd's with 2.6.8-rc1-mm1.
> > System is Fujustu Siemens Celsius, detailed info below.
> > I hope it is not NVidias fault, but I don't think so.
> > I gonna check older kernels now.
> >
> > root@ipt-cax-ws1: /root >cdrecord dev=/dev/hdc --checkdrive
> > results in:
> > ------------[ cut here ]------------
> > kernel BUG at mm/page_alloc.c:796!
> > invalid operand: 0000 [#1]
> > PREEMPT SMP
> > Modules linked in: nvidia thermal processor fan button battery ac
> > CPU:    0
> > EIP:    0060:[<c01421ef>]    Tainted: P   VLI
> > EFLAGS: 00010246   (2.6.8-rc1-mm1)
> > EIP is at __free_pages+0x3e/0x48
> > eax: ffffffff   ebx: c2197400   ecx: c16c94a0   edx: 00000000
> > esi: c2191600   edi: 00000001   ebp: c2191680   esp: f52ddd34
> > ds: 007b   es: 007b   ss: 0068
> > Process cdrecord (pid: 1968, threadinfo=f52dc000 task=f5f562b0)
> > Stack: c2197400 c2191600 c0164b78 c2191600 f64a5000 00000100 fffffff2
> > 00000000 00079963 c2191680 00000000 c0392dcb c2191680 f5223eac c0396b2c
> > f5223eac c2191680 00000100 00000100 21000046 01000000 00000000 f64d7930
> > 00000000 Call Trace:
> >  [<c0164b78>] bio_uncopy_user+0x84/0xa9
> >  [<c0392dcb>] blk_rq_unmap_user+0x37/0x4c
> >  [<c0396b2c>] sg_io+0x296/0x310
> >  [<c03971dc>] scsi_cmd_ioctl+0x363/0x487
>
> Can you check if this patch works for you? Andrew, this also fixes a
> problem in the bouncing for io errors (it needs to free the pages and
> clear the BIO_UPTODATE flag, not set it. it's already set. passing -EIO
> to bio_endio() takes care of that).
>
> diff -urp -X /home/axboe/cdrom/exclude
> /opt/kernel/linux-2.6.8-rc1-mm1/drivers/block/ll_rw_blk.c
> linux-2.6.8-rc1-mm1/drivers/block/ll_rw_blk.c ---
> /opt/kernel/linux-2.6.8-rc1-mm1/drivers/block/ll_rw_blk.c	2004-07-15
> 10:41:31.678544355 +0200 +++
> linux-2.6.8-rc1-mm1/drivers/block/ll_rw_blk.c	2004-07-15 10:43:09.096987402
> +0200 @@ -1853,6 +1853,12 @@ EXPORT_SYMBOL(blk_insert_request);
>   *
>   *    A matching blk_rq_unmap_user() must be issued at the end of io,
> while *    still in process context.
> + *
> + *    Note: The mapped bio may need to be bounced through
> blk_queue_bounce() + *    before being submitted to the device, as pages
> mapped may be out of + *    reach. It's the callers responsibility to make
> sure this happens. The + *    original bio must be passed back in to
> blk_rq_unmap_user() for proper + *    unmapping.
>   */
>  struct request *blk_rq_map_user(request_queue_t *q, int rw, void __user
> *ubuf, unsigned int len)
> diff -urp -X /home/axboe/cdrom/exclude
> /opt/kernel/linux-2.6.8-rc1-mm1/drivers/block/scsi_ioctl.c
> linux-2.6.8-rc1-mm1/drivers/block/scsi_ioctl.c ---
> /opt/kernel/linux-2.6.8-rc1-mm1/drivers/block/scsi_ioctl.c	2004-07-15
> 10:41:31.762535252 +0200 +++
> linux-2.6.8-rc1-mm1/drivers/block/scsi_ioctl.c	2004-07-15
> 10:43:09.092987835 +0200 @@ -170,6 +170,13 @@ static int
> sg_io(request_queue_t *q, str
>  	rq->flags |= REQ_BLOCK_PC;
>  	bio = rq->bio;
>
> +	/*
> +	 * bounce this after holding a reference to the original bio, it's
> +	 * needed for proper unmapping
> +	 */
> +	if (rq->bio)
> +		blk_queue_bounce(q, &rq->bio);
> +
>  	rq->timeout = (hdr->timeout * HZ) / 1000;
>  	if (!rq->timeout)
>  		rq->timeout = q->sg_timeout;
> diff -urp -X /home/axboe/cdrom/exclude
> /opt/kernel/linux-2.6.8-rc1-mm1/drivers/cdrom/cdrom.c
> linux-2.6.8-rc1-mm1/drivers/cdrom/cdrom.c ---
> /opt/kernel/linux-2.6.8-rc1-mm1/drivers/cdrom/cdrom.c	2004-07-15
> 10:41:32.994401746 +0200 +++
> linux-2.6.8-rc1-mm1/drivers/cdrom/cdrom.c	2004-07-15 10:43:09.094987619
> +0200 @@ -2082,6 +2082,9 @@ static int cdrom_read_cdda_bpc(struct cd
>  		rq->timeout = 60 * HZ;
>  		bio = rq->bio;
>
> +		if (rq->bio)
> +			blk_queue_bounce(q, &rq->bio);
> +
>  		if (blk_execute_rq(q, cdi->disk, rq)) {
>  			struct request_sense *s = rq->sense;
>  			ret = -EIO;
> diff -urp -X /home/axboe/cdrom/exclude
> /opt/kernel/linux-2.6.8-rc1-mm1/fs/bio.c linux-2.6.8-rc1-mm1/fs/bio.c ---
> /opt/kernel/linux-2.6.8-rc1-mm1/fs/bio.c	2004-07-15 10:41:44.105197605
> +0200 +++ linux-2.6.8-rc1-mm1/fs/bio.c	2004-07-15 10:43:09.091987944 +0200
> @@ -557,7 +557,6 @@ static struct bio *__bio_map_user(reques
>  		bio->bi_rw |= (1 << BIO_RW);
>
>  	bio->bi_flags |= (1 << BIO_USER_MAPPED);
> -	blk_queue_bounce(q, &bio);
>  	return bio;
>  out:
>  	kfree(pages);
> diff -urp -X /home/axboe/cdrom/exclude
> /opt/kernel/linux-2.6.8-rc1-mm1/mm/highmem.c
> linux-2.6.8-rc1-mm1/mm/highmem.c ---
> /opt/kernel/linux-2.6.8-rc1-mm1/mm/highmem.c	2004-07-15 10:41:50.046553716
> +0200 +++ linux-2.6.8-rc1-mm1/mm/highmem.c	2004-07-15 10:43:09.090988052
> +0200 @@ -308,12 +308,10 @@ static void bounce_end_io(struct bio *bi
>  {
>  	struct bio *bio_orig = bio->bi_private;
>  	struct bio_vec *bvec, *org_vec;
> -	int i;
> +	int i, err = 0;
>
>  	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
> -		goto out_eio;
> -
> -	set_bit(BIO_UPTODATE, &bio_orig->bi_flags);
> +		err = -EIO;
>
>  	/*
>  	 * free up bounce indirect pages used
> @@ -326,8 +324,7 @@ static void bounce_end_io(struct bio *bi
>  		mempool_free(bvec->bv_page, pool);
>  	}
>
> -out_eio:
> -	bio_endio(bio_orig, bio_orig->bi_size, 0);
> +	bio_endio(bio_orig, bio_orig->bi_size, err);
>  	bio_put(bio);
>  }

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

