Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUBPCK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUBPCK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:10:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265321AbUBPCKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:10:38 -0500
Message-ID: <4030268C.6050701@pobox.com>
Date: Sun, 15 Feb 2004 21:10:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Mike Christie <mikenc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net> <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net> <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net> <20040215194633.A8948@infradead.org> <20040216014433.GA5430@leto.cs.pocnet.net>
In-Reply-To: <20040216014433.GA5430@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> diff -Nur linux-2.6.3-rc3-mm1.orig/drivers/md/dm-crypt.c linux-2.6.3-rc3-mm1/drivers/md/dm-crypt.c
> --- linux-2.6.3-rc3-mm1.orig/drivers/md/dm-crypt.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.3-rc3-mm1/drivers/md/dm-crypt.c	2004-02-16 01:47:37.000000000 +0100

Overall it looks pretty nice and clean, but some issues...



> +#define MIN_IOS        256
> +#define MIN_POOL_PAGES 32
> +#define MIN_BIO_PAGES  8

> +static kmem_cache_t *_crypt_io_pool;

> +static struct bio *
> +crypt_alloc_buffer(struct crypt_config *cc, unsigned int size,
> +                   struct bio *base_bio, int *bio_vec_idx)
> +{
> +	struct bio *bio;
> +	int nr_iovecs = dm_div_up(size, PAGE_SIZE);
> +	int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
> +	int flags = current->flags;
> +	int i;
> +
> +	/*
> +	 * Tell VM to act less aggressively and fail earlier.
> +	 * This is not necessary but increases throughput.
> +	 * FIXME: Is this really intelligent?
> +	 */
> +	current->flags &= ~PF_MEMALLOC;
> +
> +	if (base_bio)
> +		bio = bio_clone(base_bio, GFP_NOIO);
> +	else
> +		bio = bio_alloc(GFP_NOIO, nr_iovecs);

Ewww.  Somebody (not you) should be thwapped for the ordering of the 
gfp_mask argument in each bio_xxx function.



> +		/*
> +		 * if additional pages cannot be allocated without waiting,
> +		 * return a partially allocated bio, the caller will then try
> +		 * to allocate additional bios while submitting this partial bio
> +		 */
> +		if ((i - bio->bi_idx) == (MIN_BIO_PAGES - 1))
> +			gfp_mask = (gfp_mask | __GFP_NOWARN) & ~__GFP_WAIT;

If the caller said they can wait, why not wait?



> +static void dec_pending(struct crypt_io *io, int error)
> +{
> +	struct crypt_config *cc = (struct crypt_config *) io->target->private;
> +
> +	if (error < 0)
> +		io->error = error;
> +
> +	if (!atomic_dec_and_test(&io->pending))
> +		return;
> +
> +	if (io->first_clone)
> +		bio_put(io->first_clone);

> +	if (io->bio)
> +		bio_endio(io->bio, io->bio->bi_size, io->error);

when does io->bio==NULL ?



> +static spinlock_t _kcryptd_lock = SPIN_LOCK_UNLOCKED;
> +static struct bio_list _kcryptd_bios;
> +
> +static struct task_struct *_kcryptd;
> +
> +/*
> + * Fetch a list of the complete bios.
> + */
> +static struct bio *kcryptd_get_bios(void)
> +{
> +	struct bio *bio;
> +
> +	spin_lock_irq(&_kcryptd_lock);
> +	bio = bio_list_get(&_kcryptd_bios);
> +	spin_unlock_irq(&_kcryptd_lock);
> +
> +	return bio;
> +}
> +
> +/*
> + * Append bio to work queue
> + */
> +static void kcryptd_queue_bio(struct bio *bio)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&_kcryptd_lock, flags);
> +	bio_list_add(&_kcryptd_bios, bio);
> +	spin_unlock_irqrestore(&_kcryptd_lock, flags);
> +}
> +
> +static int kcryptd_do_work(void *data)
> +{
> +	current->flags |= PF_IOTHREAD;
> +
> +	for(;;) {
> +		struct bio *bio;
> +
> +		set_task_state(current, TASK_INTERRUPTIBLE);
> +		while (!(bio = kcryptd_get_bios())) {
> +			schedule();
> +			if (signal_pending(current))
> +				return 0;
> +		}
> +		set_task_state(current, TASK_RUNNING);

You just keep calling schedule() rapid-fire until you get a bio?  That's 
a bit sub-optimal.

This seems like a semaphore is needed.


> +		while (bio) {
> +			struct crypt_io *io;
> +			struct crypt_config *cc;
> +			struct convert_context ctx;
> +			struct bio *next_bio;
> +			int r;
> +
> +			io = (struct crypt_io *) bio->bi_private;
> +			cc = (struct crypt_config *) io->target->private;
> +
> +			crypt_convert_init(cc, &ctx, io->bio, io->bio,
> +				io->bio->bi_sector - io->target->begin, 0);
> +			r = crypt_convert(cc, &ctx);
> +
> +			next_bio = bio->bi_next;
> +			bio->bi_next = NULL;
> +
> +			bio_put(bio);
> +			dec_pending(io, r);
> +
> +			bio = next_bio;
> +		}
> +	}
> +}
> +
> +/*
> + * Encode key into its hex representation
> + */
> +static void crypt_encode_key(char *hex, u8 *key, int size)
> +{
> +	static char hex_digits[] = "0123456789abcdef";

static const


> +/*
> + * Construct an encryption mapping:
> + * <cipher> <key> <iv_offset> <dev_path> <start>
> + */
> +static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> +{
> +	struct crypt_config *cc;
> +	struct crypto_tfm *tfm;
> +	char *tmp;
> +	char *cipher;
> +	char *mode;
> +	int crypto_flags;
> +	int key_size;
> +
> +	if (argc != 5) {
> +		ti->error = "dm-crypt: Not enough arguments";
> +		return -EINVAL;
> +	}
> +
> +	tmp = argv[0];
> +	cipher = strsep(&tmp, "-");
> +	mode = strsep(&tmp, "-");
> +
> +	if (tmp)
> +		DMWARN("dm-crypt: Unexpected additional cipher options");
> +
> +	key_size = strlen(argv[1]) >> 1;
> +
> +	cc = kmalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
> +	if (cc == NULL) {
> +		ti->error =
> +			"dm-crypt: Cannot allocate transparent encryption context";
> +		return -ENOMEM;
> +	}
> +
> +	if (!mode || strcmp(mode, "plain") == 0)
> +		cc->iv_generator = crypt_iv_plain;
> +	else if (strcmp(mode, "ecb") == 0)
> +		cc->iv_generator = NULL;
> +	else {
> +		ti->error = "dm-crypt: Invalid chaining mode";
> +		return -EINVAL;
> +	}

memory leak on error


> +	if (cc->iv_generator)
> +		crypto_flags = CRYPTO_TFM_MODE_CBC;
> +	else
> +		crypto_flags = CRYPTO_TFM_MODE_ECB;
> +
> +	tfm = crypto_alloc_tfm(cipher, crypto_flags);
> +	if (!tfm) {
> +		ti->error = "dm-crypt: Error allocating crypto tfm";
> +		goto bad1;
> +	}
> +
> +	if (tfm->crt_u.cipher.cit_decrypt_iv && tfm->crt_u.cipher.cit_encrypt_iv)
> +		/* at least a 32 bit sector number should fit in our buffer */
> +		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm), 
> +		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
> +	else {
> +		cc->iv_size = 0;
> +		if (cc->iv_generator) {
> +			DMWARN("dm-crypt: Selected cipher does not support IVs");
> +			cc->iv_generator = NULL;
> +		}
> +	}
> +
> +	cc->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
> +				     mempool_free_slab, _crypt_io_pool);
> +	if (!cc->io_pool) {
> +		ti->error = "dm-crypt: Cannot allocate crypt io mempool";
> +		goto bad2;
> +	}
> +
> +	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_page,
> +				       mempool_free_page, NULL);
> +	if (!cc->page_pool) {
> +		ti->error = "dm-crypt: Cannot allocate page mempool";
> +		goto bad3;
> +	}
> +
> +	cc->tfm = tfm;
> +	cc->key_size = key_size;
> +	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
> +	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
> +		ti->error = "dm-crypt: Error decoding key";
> +		goto bad4;
> +	}
> +
> +	if (tfm->crt_u.cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
> +		ti->error = "dm-crypt: Error setting key";
> +		goto bad4;
> +	}
> +
> +	if (sscanf(argv[2], SECTOR_FORMAT, &cc->iv_offset) != 1) {
> +		ti->error = "dm-crypt: Invalid iv_offset sector";
> +		goto bad4;
> +	}
> +
> +	if (sscanf(argv[4], SECTOR_FORMAT, &cc->start) != 1) {
> +		ti->error = "dm-crypt: Invalid device sector";
> +		goto bad4;
> +	}
> +
> +	if (dm_get_device(ti, argv[3], cc->start, ti->len,
> +	                  dm_table_get_mode(ti->table), &cc->dev)) {
> +		ti->error = "dm-crypt: Device lookup failed";
> +		goto bad4;
> +	}
> +
> +	ti->private = cc;
> +	return 0;
> +
> +bad4:
> +	mempool_destroy(cc->page_pool);
> +bad3:
> +	mempool_destroy(cc->io_pool);
> +bad2:
> +	crypto_free_tfm(tfm);
> +bad1:
> +	kfree(cc);
> +	return -EINVAL;
> +}
> +
> +static void crypt_dtr(struct dm_target *ti)
> +{
> +	struct crypt_config *cc = (struct crypt_config *) ti->private;
> +
> +	mempool_destroy(cc->page_pool);
> +	mempool_destroy(cc->io_pool);
> +
> +	crypto_free_tfm(cc->tfm);
> +	dm_put_device(ti, cc->dev);
> +	kfree(cc);
> +}
> +
> +static int crypt_endio(struct bio *bio, unsigned int done, int error)
> +{
> +	struct crypt_io *io = (struct crypt_io *) bio->bi_private;
> +	struct crypt_config *cc = (struct crypt_config *) io->target->private;
> +
> +	if (bio_rw(bio) == WRITE) {
> +		/*
> +		 * free the processed pages, even if
> +		 * it's only a partially completed write
> +		 */
> +		crypt_free_buffer_pages(cc, bio, done);
> +	}
> +
> +	if (bio->bi_size)
> +		return 1;

dumb question, for my own knowledge:  what does this 'if' test do?


> +static int crypt_map(struct dm_target *ti, struct bio *bio,
> +                     union map_info *map_context)
> +{
> +	struct crypt_config *cc = (struct crypt_config *) ti->private;
> +	struct crypt_io *io = mempool_alloc(cc->io_pool, GFP_NOIO);
> +	struct bio *clone = NULL;
> +	struct convert_context ctx;
> +	unsigned int remaining = bio->bi_size;
> +	sector_t sector = bio->bi_sector - ti->begin;
> +	int bio_vec_idx = 0;
> +	int r = 0;
> +
> +	io->target = ti;
> +	io->bio = bio;
> +	io->first_clone = NULL;
> +	io->error = 0;
> +	atomic_set(&io->pending, 1); /* hold a reference */
> +
> +	if (bio_rw(bio) == WRITE)
> +		crypt_convert_init(cc, &ctx, NULL, bio, sector, 1);
> +
> +	/*
> +	 * The allocated buffers can be smaller than the whole bio,
> +	 * so repeat the whole process until all the data can be handled.
> +	 */
> +	while (remaining) {
> +		if (bio_rw(bio) == WRITE) {
> +			clone = crypt_alloc_buffer(cc, bio->bi_size,
> +			                           io->first_clone,
> +			                           &bio_vec_idx);
> +			if (clone) {
> +				ctx.bio_out = clone;
> +				r = crypt_convert(cc, &ctx);
> +				if (r < 0) {
> +					crypt_free_buffer_pages(cc, clone,
> +					                        clone->bi_size);
> +					bio_put(clone);
> +					goto cleanup;
> +				}
> +			}
> +		} else
> +			clone = bio_clone(bio, GFP_NOIO);
> +
> +		if (!clone) {
> +			r = -ENOMEM;
> +			goto cleanup;
> +		}
> +
> +		if (!io->first_clone) {
> +			/*
> +			 * hold a reference to the first clone, because it
> +			 * holds the bio_vec array and that can't be freed
> +			 * before all other clones are released
> +			 */
> +			bio_get(clone);
> +			io->first_clone = clone;
> +		}
> +		atomic_inc(&io->pending);
> +
> +		clone->bi_private = io;
> +		clone->bi_end_io = crypt_endio;
> +		clone->bi_bdev = cc->dev->bdev;
> +		clone->bi_sector = cc->start + sector;
> +		clone->bi_rw = bio->bi_rw;
> +
> +		remaining -= clone->bi_size;
> +		sector += bio_sectors(clone);

would be nice to move this code into a separate "create and init my 
clone" function, simply to be ease review and make things a bit more 
clear...


> +		generic_make_request(clone);
> +	}
> +
> +	/* drop reference, clones could have returned before we reach this */
> +	dec_pending(io, 0);
> +	return 0;
> +
> +cleanup:
> +	if (io->first_clone) {
> +		dec_pending(io, r);
> +		return 0;
> +	}
> +
> +	/* if no bio has been dispatched yet, we can directly return the error */
> +	mempool_free(io, cc->io_pool);
> +	return r;
> +}
> +
> +static int crypt_status(struct dm_target *ti, status_type_t type,
> +			char *result, unsigned int maxlen)
> +{
> +	struct crypt_config *cc = (struct crypt_config *) ti->private;
> +	char buffer[32];
> +	const char *cipher;
> +	const char *mode = NULL;
> +	int offset;
> +
> +	switch (type) {
> +	case STATUSTYPE_INFO:
> +		result[0] = '\0';
> +		break;
> +
> +	case STATUSTYPE_TABLE:
> +		cipher = crypto_tfm_alg_name(cc->tfm);
> +
> +		switch(cc->tfm->crt_u.cipher.cit_mode) {
> +		case CRYPTO_TFM_MODE_CBC:
> +			mode = "plain";
> +			break;
> +		case CRYPTO_TFM_MODE_ECB:
> +			mode = "ecb";
> +			break;
> +		default:
> +			BUG();
> +		}
> +
> +		snprintf(result, maxlen, "%s-%s ", cipher, mode);
> +		offset = strlen(result);
> +
> +		if (cc->key_size > 0) {
> +			if ((maxlen - offset) < ((cc->key_size << 1) + 1))
> +				return -ENOMEM;
> +
> +			crypt_encode_key(result + offset, cc->key, cc->key_size);
> +			offset += cc->key_size << 1;
> +		} else {
> +			if (offset >= maxlen)
> +				return -ENOMEM;
> +			result[offset++] = '-';
> +		}
> +
> +		format_dev_t(buffer, cc->dev->bdev->bd_dev);
> +		snprintf(result + offset, maxlen - offset, " " SECTOR_FORMAT
> +		         " %s " SECTOR_FORMAT, cc->iv_offset,
> +		         buffer, cc->start);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static struct target_type crypt_target = {
> +	.name   = "crypt",
> +	.module = THIS_MODULE,
> +	.ctr    = crypt_ctr,
> +	.dtr    = crypt_dtr,
> +	.map    = crypt_map,
> +	.status = crypt_status,
> +};
> +
> +static int __init dm_crypt_init(void)
> +{
> +	int r;
> +
> +	_crypt_io_pool = kmem_cache_create("dm-crypt_io",
> +	                                   sizeof(struct crypt_io),
> +	                                   0, 0, NULL, NULL);
> +	if (!_crypt_io_pool)
> +		return -ENOMEM;
> +
> +	_kcryptd = kthread_create(kcryptd_do_work, NULL, "kcryptd");
> +	if (IS_ERR(_kcryptd)) {
> +		r = PTR_ERR(_kcryptd);
> +		DMERR("couldn't create kcryptd: %d", r);
> +		kmem_cache_destroy(_crypt_io_pool);
> +		return r;
> +	}

> +	r = dm_register_target(&crypt_target);
> +	if (r < 0) {
> +		DMERR("crypt: register failed %d", r);
> +		kthread_stop(_kcryptd);
> +		kmem_cache_destroy(_crypt_io_pool);
> +		return r;
> +	}

might want to use the standard 'goto' style exception handling here too, 
instead of duplicating the error unwind code.

Overall, needs a tiny bit of work, but I like it.

	Jeff



