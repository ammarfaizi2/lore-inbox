Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVBKT7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVBKT7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVBKT7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:59:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36512 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262324AbVBKT6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:58:53 -0500
Date: Fri, 11 Feb 2005 19:58:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath hardware handler for EMC
Message-ID: <20050211195841.GA13925@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050211172211.GA10195@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211172211.GA10195@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Code borrowed from dm-lsi-rdac by Mike Christie */

Any reason that module isn't submitted?

> +	bio->bi_bdev = path->dev->bdev;
> +	bio->bi_sector = 0;
> +	bio->bi_private = path;
> +	bio->bi_end_io = emc_endio;
> +
> +	page = alloc_page(GFP_ATOMIC);
> +	if (!page) {
> +		DMERR("dm-emc: get_failover_bio: alloc_page() failed.");
> +		bio_put(bio);
> +		return NULL;
> +	}
> +
> +	if (bio_add_page(bio, page, data_size, 0) != data_size) {
> +		DMERR("dm-emc: get_failover_bio: alloc_page() failed.");
> +		__free_page(page);
> +		bio_put(bio);
> +		return NULL;
> +	}
> +
> +	return bio;

this would benefit from goto unwinding.

> +	if (h->short_trespass) {
> +		memcpy(page22, short_trespass_pg, data_size);
> +	} else {
> +		memcpy(page22, long_trespass_pg, data_size);
> +	}

	 memcpy(page22, h->short_trespass ?
	 	short_trespass_pg : long_trespass_pg, data_size);

?

> +static struct emc_handler *alloc_emc_handler(void)
> +{
> +	struct emc_handler *h = kmalloc(sizeof(*h), GFP_KERNEL);
> +
> +	if (h) {
> +		h->lock = SPIN_LOCK_UNLOCKED;
> +	}

	if (h)
		spin_lock_init(&h->lock);

> +static unsigned emc_err(struct hw_handler *hwh, struct bio *bio)
> +{
> +	/* FIXME: Patch from axboe still missing */

it's in -mm now afaik??

> +#if 0
> +	int sense;
> +
> +	if (bio->bi_error & BIO_SENSE) {
> +		sense = bio->bi_error & 0xffffff; /* sense key / asc / ascq */
> +
> +		if (sense == 0x020403) {

please use the sense handling helpers from Doug Gilbert so you can handle
the descriptor sense format aswell.  (And make the code a lot clear).

Also please try to use constants instead of magic numbers.

