Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVBLEI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVBLEI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 23:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVBLEI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 23:08:56 -0500
Received: from gate.in-addr.de ([212.8.193.158]:48322 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262389AbVBLEID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 23:08:03 -0500
Date: Sat, 12 Feb 2005 05:07:24 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Alasdair G Kergon <agk@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath hardware handler for EMC
Message-ID: <20050212040724.GA3872@marowsky-bree.de>
References: <20050211172211.GA10195@agk.surrey.redhat.com> <20050211195841.GA13925@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050211195841.GA13925@infradead.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-02-11T19:58:41, Christoph Hellwig <hch@infradead.org> wrote:

> > +/* Code borrowed from dm-lsi-rdac by Mike Christie */
> 
> Any reason that module isn't submitted?

No idea why.

> > +	bio->bi_bdev = path->dev->bdev;
> > +	bio->bi_sector = 0;
> > +	bio->bi_private = path;
> > +	bio->bi_end_io = emc_endio;
> > +
> > +	page = alloc_page(GFP_ATOMIC);
> > +	if (!page) {
> > +		DMERR("dm-emc: get_failover_bio: alloc_page() failed.");
> > +		bio_put(bio);
> > +		return NULL;
> > +	}
> > +
> > +	if (bio_add_page(bio, page, data_size, 0) != data_size) {
> > +		DMERR("dm-emc: get_failover_bio: alloc_page() failed.");
> > +		__free_page(page);
> > +		bio_put(bio);
> > +		return NULL;
> > +	}
> > +
> > +	return bio;
> 
> this would benefit from goto unwinding.

OK.

> > +	if (h->short_trespass) {
> > +		memcpy(page22, short_trespass_pg, data_size);
> > +	} else {
> > +		memcpy(page22, long_trespass_pg, data_size);
> > +	}
> 	 memcpy(page22, h->short_trespass ?
> 	 	short_trespass_pg : long_trespass_pg, data_size);
> 
> ?

Yes, I first did some other things there than just copying the commands
around, it can surely benefit from cleanup.

> > +static struct emc_handler *alloc_emc_handler(void)
> > +{
> > +	struct emc_handler *h = kmalloc(sizeof(*h), GFP_KERNEL);
> > +
> > +	if (h) {
> > +		h->lock = SPIN_LOCK_UNLOCKED;
> > +	}
> 
> 	if (h)
> 		spin_lock_init(&h->lock);

Came in via the copy, good catch.

> > +static unsigned emc_err(struct hw_handler *hwh, struct bio *bio)
> > +{
> > +	/* FIXME: Patch from axboe still missing */
> 
> it's in -mm now afaik??

No, it's not. That's the request sense keys, but here we're dealing with
the bio.

> > +#if 0
> > +	int sense;
> > +
> > +	if (bio->bi_error & BIO_SENSE) {
> > +		sense = bio->bi_error & 0xffffff; /* sense key / asc / ascq */
> > +
> > +		if (sense == 0x020403) {
> 
> please use the sense handling helpers from Doug Gilbert so you can handle
> the descriptor sense format aswell.  (And make the code a lot clear).

I'll go look them up.

> Also please try to use constants instead of magic numbers.

Noted. I'll clean this part up when I actually have sense keys to try,
so far this was mostly about getting that tiny bit of logic in.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

