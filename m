Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbTLWNOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTLWNOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:14:03 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:21519 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265132AbTLWNN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:13:58 -0500
Date: Tue, 23 Dec 2003 13:13:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031223131355.A6864@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Fruhwirth Clemens <clemens@endorphin.org>,
	Joe Thornber <thornber@sistina.com>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031222215236.GB13103@leto.cs.pocnet.net>; from christophe@saout.de on Mon, Dec 22, 2003 at 10:52:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Fruhwirth dropped from Cc list due to his braindead spam "filter"]

On Mon, Dec 22, 2003 at 10:52:36PM +0100, Christophe Saout wrote:
> +#include "dm.h"
> +#include "dm-daemon.h"

Please include driver-private headers after kernel headers.

> +/*
> + * Crypt: maps a linear range of a block device
> + * and encrypts / decrypts at the same time.
> + */
> +struct crypt_c {

crypt_context?  The current name isn't very descriptive..

> +static kmem_cache_t *_io_cache;

Again a rather strange variable name.  What about dm_crypt_pool?

> +
> +/*
> + * Mempool alloc and free functions for the page and io pool
> + */
> +static void *mempool_alloc_page(int gfp_mask, void *data)
> +{
> +	return alloc_page(gfp_mask);
> +}
> +
> +static void mempool_free_page(void *page, void *data)
> +{
> +	__free_page(page);
> +}

Should probably go into generic code one day, along with the slab wrappers.

> +
> +static inline struct page *crypt_alloc_page(struct crypt_c *cc, int gfp_mask)
> +{
> +	return mempool_alloc(cc->page_pool, gfp_mask);
> +}
> +
> +static inline void crypt_free_page(struct crypt_c *cc, struct page *page)
> +{
> +	 mempool_free(page, cc->page_pool);
> +}
> +
> +static inline struct crypt_io *crypt_alloc_io(struct crypt_c *cc)
> +{
> +	return mempool_alloc(cc->io_pool, GFP_NOIO);
> +}
> +
> +static inline void crypt_free_io(struct crypt_c *cc, struct crypt_io *io)
> +{
> +	return mempool_free(io, cc->io_pool);
> +}

Please kill these superflous wrappers.

> +static spinlock_t _kcryptd_lock = SPIN_LOCK_UNLOCKED;
> +static struct bio *_bio_head;
> +static struct bio *_bio_tail;
> +
> +static struct dm_daemon _kcryptd;

Again, rather strange naming..

> +int __init dm_crypt_init(void)

static?

> +void __exit dm_crypt_exit(void)

static?

> +/*
> + * module hooks
> + */

Comment looks slightly superflous :)

Else the code look great and definitly better han cryptoloop from the
conceptual point of view.
