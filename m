Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUBPBps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUBPBps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:45:48 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:49828 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265284AbUBPBoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:44:54 -0500
Date: Mon, 16 Feb 2004 02:44:34 +0100
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joe Thornber <thornber@redhat.com>, Mike Christie <mikenc@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: dm-crypt using kthread (was: Oopsing cryptoapi (or loop device?) on 2.6.*)
Message-ID: <20040216014433.GA5430@leto.cs.pocnet.net>
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net> <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net> <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net> <20040215194633.A8948@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040215194633.A8948@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 07:46:33PM +0000, Christoph Hellwig wrote:

> Well, actually the above code should not enter the kernel tree at all.
> Care to rewrite dm-crypt to use Rusty's kthread code in -mm instead and
> submit a patch to Andrew?  Whenever he merges the kthread stuff to mainline
> he could just include dm-crypt then.

In spite of the objections I've decided to give it a try.

It's working fine this way and it seems to work fine. The overhead is
very small.


diff -Nur linux-2.6.3-rc3-mm1.orig/drivers/md/dm-crypt.c linux-2.6.3-rc3-mm1/drivers/md/dm-crypt.c
--- linux-2.6.3-rc3-mm1.orig/drivers/md/dm-crypt.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.3-rc3-mm1/drivers/md/dm-crypt.c	2004-02-16 01:47:37.000000000 +0100
@@ -0,0 +1,815 @@
+/*
+ * Copyright (C) 2003 Christophe Saout <christophe@saout.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/bio.h>
+#include <linux/mempool.h>
+#include <linux/slab.h>
+#include <linux/crypto.h>
+#include <linux/spinlock.h>
+#include <linux/kthread.h>
+#include <asm/scatterlist.h>
+
+#include "dm.h"
+#include "dm-bio-list.h"
+
+/*
+ * per bio private data
+ */
+struct crypt_io {
+	struct dm_target *target;
+	struct bio *bio;
+	struct bio *first_clone;
+	atomic_t pending;
+	int error;
+};
+
+/*
+ * context holding the current state of a multi-part conversion
+ */
+struct convert_context {
+	struct bio *bio_in;
+	struct bio *bio_out;
+	unsigned int offset_in;
+	unsigned int offset_out;
+	int idx_in;
+	int idx_out;
+	sector_t sector;
+	int write;
+};
+
+/*
+ * Crypt: maps a linear range of a block device
+ * and encrypts / decrypts at the same time.
+ */
+struct crypt_config {
+	struct dm_dev *dev;
+	sector_t start;
+
+	/*
+	 * pool for per bio private data and
+	 * for encryption buffer pages
+	 */
+	mempool_t *io_pool;
+	mempool_t *page_pool;
+
+	/*
+	 * crypto related data
+	 */
+	struct crypto_tfm *tfm;
+	sector_t iv_offset;
+	int (*iv_generator)(struct crypt_config *cc, u8 *iv, sector_t sector);
+	int iv_size;
+	int key_size;
+	u8 key[0];
+};
+
+#define MIN_IOS        256
+#define MIN_POOL_PAGES 32
+#define MIN_BIO_PAGES  8
+
+static kmem_cache_t *_crypt_io_pool;
+
+/*
+ * Mempool alloc and free functions for the page
+ */
+static void *mempool_alloc_page(int gfp_mask, void *data)
+{
+	return alloc_page(gfp_mask);
+}
+
+static void mempool_free_page(void *page, void *data)
+{
+	__free_page(page);
+}
+
+
+/*
+ * Different IV generation algorithms
+ */
+static int crypt_iv_plain(struct crypt_config *cc, u8 *iv, sector_t sector)
+{
+	*(u32 *)iv = cpu_to_le32(sector & 0xffffffff);
+	if (cc->iv_size > sizeof(u32) / sizeof(u8))
+		memset(iv + (sizeof(u32) / sizeof(u8)), 0,
+		       cc->iv_size - (sizeof(u32) / sizeof(u8)));
+
+	return 0;
+}
+
+static inline int
+crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
+                          struct scatterlist *in, unsigned int length,
+                          int write, sector_t sector)
+{
+	u8 iv[cc->iv_size];
+	int r;
+
+	if (cc->iv_generator) {
+		r = cc->iv_generator(cc, iv, sector);
+		if (r < 0)
+			return r;
+
+		if (write)
+			r = crypto_cipher_encrypt_iv(cc->tfm, out, in, length, iv);
+		else
+			r = crypto_cipher_decrypt_iv(cc->tfm, out, in, length, iv);
+	} else {
+		if (write)
+			r = crypto_cipher_encrypt(cc->tfm, out, in, length);
+		else
+			r = crypto_cipher_decrypt(cc->tfm, out, in, length);
+	}
+
+	return r;
+}
+
+static void
+crypt_convert_init(struct crypt_config *cc, struct convert_context *ctx,
+                   struct bio *bio_out, struct bio *bio_in,
+                   sector_t sector, int write)
+{
+	ctx->bio_in = bio_in;
+	ctx->bio_out = bio_out;
+	ctx->offset_in = 0;
+	ctx->offset_out = 0;
+	ctx->idx_in = bio_in ? bio_in->bi_idx : 0;
+	ctx->idx_out = bio_out ? bio_out->bi_idx : 0;
+	ctx->sector = sector + cc->iv_offset;
+	ctx->write = write;
+}
+
+/*
+ * Encrypt / decrypt data from one bio to another one (can be the same one)
+ */
+static int crypt_convert(struct crypt_config *cc,
+                         struct convert_context *ctx)
+{
+	int r = 0;
+
+	while(ctx->idx_in < ctx->bio_in->bi_vcnt &&
+	      ctx->idx_out < ctx->bio_out->bi_vcnt) {
+		struct bio_vec *bv_in = bio_iovec_idx(ctx->bio_in, ctx->idx_in);
+		struct bio_vec *bv_out = bio_iovec_idx(ctx->bio_out, ctx->idx_out);
+		struct scatterlist sg_in = {
+			.page = bv_in->bv_page,
+			.offset = bv_in->bv_offset + ctx->offset_in,
+			.length = 1 << SECTOR_SHIFT
+		};
+		struct scatterlist sg_out = {
+			.page = bv_out->bv_page,
+			.offset = bv_out->bv_offset + ctx->offset_out,
+			.length = 1 << SECTOR_SHIFT
+		};
+
+		ctx->offset_in += sg_in.length;
+		if (ctx->offset_in >= bv_in->bv_len) {
+			ctx->offset_in = 0;
+			ctx->idx_in++;
+		}
+
+		ctx->offset_out += sg_out.length;
+		if (ctx->offset_out >= bv_out->bv_len) {
+			ctx->offset_out = 0;
+			ctx->idx_out++;
+		}
+
+		r = crypt_convert_scatterlist(cc, &sg_out, &sg_in, sg_in.length,
+		                              ctx->write, ctx->sector);
+		if (r < 0)
+			break;
+
+		ctx->sector++;
+	}
+
+	return r;
+}
+
+/*
+ * Generate a new unfragmented bio with the given size
+ * This should never violate the device limitations
+ * May return a smaller bio when running out of pages
+ */
+static struct bio *
+crypt_alloc_buffer(struct crypt_config *cc, unsigned int size,
+                   struct bio *base_bio, int *bio_vec_idx)
+{
+	struct bio *bio;
+	int nr_iovecs = dm_div_up(size, PAGE_SIZE);
+	int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
+	int flags = current->flags;
+	int i;
+
+	/*
+	 * Tell VM to act less aggressively and fail earlier.
+	 * This is not necessary but increases throughput.
+	 * FIXME: Is this really intelligent?
+	 */
+	current->flags &= ~PF_MEMALLOC;
+
+	if (base_bio)
+		bio = bio_clone(base_bio, GFP_NOIO);
+	else
+		bio = bio_alloc(GFP_NOIO, nr_iovecs);
+	if (!bio)
+		return NULL;
+
+	/* if the last bio was not complete, continue where that one ended */
+	bio->bi_idx = *bio_vec_idx;
+	bio->bi_vcnt = *bio_vec_idx;
+	bio->bi_size = 0;
+	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
+
+	/* bio->bi_idx pages have already been allocated */
+	size -= bio->bi_idx * PAGE_SIZE;
+
+	for(i = bio->bi_idx; i < nr_iovecs; i++) {
+		struct bio_vec *bv = bio_iovec_idx(bio, i);
+
+		bv->bv_page = mempool_alloc(cc->page_pool, gfp_mask);
+		if (!bv->bv_page)
+			break;
+
+		/*
+		 * if additional pages cannot be allocated without waiting,
+		 * return a partially allocated bio, the caller will then try
+		 * to allocate additional bios while submitting this partial bio
+		 */
+		if ((i - bio->bi_idx) == (MIN_BIO_PAGES - 1))
+			gfp_mask = (gfp_mask | __GFP_NOWARN) & ~__GFP_WAIT;
+
+		bv->bv_offset = 0;
+		if (size > PAGE_SIZE)
+			bv->bv_len = PAGE_SIZE;
+		else
+			bv->bv_len = size;
+
+		bio->bi_size += bv->bv_len;
+		bio->bi_vcnt++;
+		size -= bv->bv_len;
+	}
+
+	if (flags & PF_MEMALLOC)
+		current->flags |= PF_MEMALLOC;
+
+	if (!bio->bi_size) {
+		bio_put(bio);
+		return NULL;
+	}
+
+	/*
+	 * Remember the last bio_vec allocated to be able
+	 * to correctly continue after the splitting.
+	 */
+	*bio_vec_idx = bio->bi_vcnt;
+
+	return bio;
+}
+
+static void crypt_free_buffer_pages(struct crypt_config *cc,
+                                    struct bio *bio, unsigned int bytes)
+{
+	unsigned int start, end;
+	struct bio_vec *bv;
+	int i;
+
+	/*
+	 * This is ugly, but Jens Axboe thinks that using bi_idx in the
+	 * endio function is too dangerous at the moment, so I calculate the
+	 * correct position using bi_vcnt and bi_size.
+	 * The bv_offset and bv_len fields might already be modified but we
+	 * know that we always allocated whole pages.
+	 * A fix to the bi_idx issue in the kernel is in the works, so
+	 * we will hopefully be able to revert to the cleaner solution soon.
+	 */
+	i = bio->bi_vcnt - 1;
+	bv = bio_iovec_idx(bio, i);
+	end = (i << PAGE_SHIFT) + (bv->bv_offset + bv->bv_len) - bio->bi_size;
+	start = end - bytes;
+
+	start >>= PAGE_SHIFT;
+	if (!bio->bi_size)
+		end = bio->bi_vcnt;
+	else
+		end >>= PAGE_SHIFT;
+
+	for(i = start; i < end; i++) {
+		bv = bio_iovec_idx(bio, i);
+		BUG_ON(!bv->bv_page);
+		mempool_free(bv->bv_page, cc->page_pool);
+		bv->bv_page = NULL;
+	}
+}
+
+/*
+ * One of the bios was finished. Check for completion of
+ * the whole request and correctly clean up the buffer.
+ */
+static void dec_pending(struct crypt_io *io, int error)
+{
+	struct crypt_config *cc = (struct crypt_config *) io->target->private;
+
+	if (error < 0)
+		io->error = error;
+
+	if (!atomic_dec_and_test(&io->pending))
+		return;
+
+	if (io->first_clone)
+		bio_put(io->first_clone);
+
+	if (io->bio)
+		bio_endio(io->bio, io->bio->bi_size, io->error);
+
+	mempool_free(io, cc->io_pool);
+}
+
+/*
+ * kcryptd:
+ *
+ * Needed because it would be very unwise to do decryption in an
+ * interrupt context, so bios returning from read requests get
+ * queued here.
+ */
+static spinlock_t _kcryptd_lock = SPIN_LOCK_UNLOCKED;
+static struct bio_list _kcryptd_bios;
+
+static struct task_struct *_kcryptd;
+
+/*
+ * Fetch a list of the complete bios.
+ */
+static struct bio *kcryptd_get_bios(void)
+{
+	struct bio *bio;
+
+	spin_lock_irq(&_kcryptd_lock);
+	bio = bio_list_get(&_kcryptd_bios);
+	spin_unlock_irq(&_kcryptd_lock);
+
+	return bio;
+}
+
+/*
+ * Append bio to work queue
+ */
+static void kcryptd_queue_bio(struct bio *bio)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&_kcryptd_lock, flags);
+	bio_list_add(&_kcryptd_bios, bio);
+	spin_unlock_irqrestore(&_kcryptd_lock, flags);
+}
+
+static int kcryptd_do_work(void *data)
+{
+	current->flags |= PF_IOTHREAD;
+
+	for(;;) {
+		struct bio *bio;
+
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		while (!(bio = kcryptd_get_bios())) {
+			schedule();
+			if (signal_pending(current))
+				return 0;
+		}
+		set_task_state(current, TASK_RUNNING);
+
+		while (bio) {
+			struct crypt_io *io;
+			struct crypt_config *cc;
+			struct convert_context ctx;
+			struct bio *next_bio;
+			int r;
+
+			io = (struct crypt_io *) bio->bi_private;
+			cc = (struct crypt_config *) io->target->private;
+
+			crypt_convert_init(cc, &ctx, io->bio, io->bio,
+				io->bio->bi_sector - io->target->begin, 0);
+			r = crypt_convert(cc, &ctx);
+
+			next_bio = bio->bi_next;
+			bio->bi_next = NULL;
+
+			bio_put(bio);
+			dec_pending(io, r);
+
+			bio = next_bio;
+		}
+	}
+}
+
+/*
+ * Decode key from its hex representation
+ */
+static int crypt_decode_key(u8 *key, char *hex, int size)
+{
+	char buffer[3];
+	char *endp;
+	int i;
+
+	buffer[2] = '\0';
+
+	for(i = 0; i < size; i++) {
+		buffer[0] = *hex++;
+		buffer[1] = *hex++;
+
+		key[i] = (u8)simple_strtoul(buffer, &endp, 16);
+
+		if (endp != &buffer[2])
+			return -EINVAL;
+	}
+
+	if (*hex != '\0')
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Encode key into its hex representation
+ */
+static void crypt_encode_key(char *hex, u8 *key, int size)
+{
+	static char hex_digits[] = "0123456789abcdef";
+	int i;
+
+	for(i = 0; i < size; i++) {
+		*hex++ = hex_digits[*key >> 4];
+		*hex++ = hex_digits[*key & 0x0f];
+		key++;
+	}
+
+	*hex++ = '\0';
+}
+
+/*
+ * Construct an encryption mapping:
+ * <cipher> <key> <iv_offset> <dev_path> <start>
+ */
+static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct crypt_config *cc;
+	struct crypto_tfm *tfm;
+	char *tmp;
+	char *cipher;
+	char *mode;
+	int crypto_flags;
+	int key_size;
+
+	if (argc != 5) {
+		ti->error = "dm-crypt: Not enough arguments";
+		return -EINVAL;
+	}
+
+	tmp = argv[0];
+	cipher = strsep(&tmp, "-");
+	mode = strsep(&tmp, "-");
+
+	if (tmp)
+		DMWARN("dm-crypt: Unexpected additional cipher options");
+
+	key_size = strlen(argv[1]) >> 1;
+
+	cc = kmalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
+	if (cc == NULL) {
+		ti->error =
+			"dm-crypt: Cannot allocate transparent encryption context";
+		return -ENOMEM;
+	}
+
+	if (!mode || strcmp(mode, "plain") == 0)
+		cc->iv_generator = crypt_iv_plain;
+	else if (strcmp(mode, "ecb") == 0)
+		cc->iv_generator = NULL;
+	else {
+		ti->error = "dm-crypt: Invalid chaining mode";
+		return -EINVAL;
+	}
+
+	if (cc->iv_generator)
+		crypto_flags = CRYPTO_TFM_MODE_CBC;
+	else
+		crypto_flags = CRYPTO_TFM_MODE_ECB;
+
+	tfm = crypto_alloc_tfm(cipher, crypto_flags);
+	if (!tfm) {
+		ti->error = "dm-crypt: Error allocating crypto tfm";
+		goto bad1;
+	}
+
+	if (tfm->crt_u.cipher.cit_decrypt_iv && tfm->crt_u.cipher.cit_encrypt_iv)
+		/* at least a 32 bit sector number should fit in our buffer */
+		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm), 
+		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
+	else {
+		cc->iv_size = 0;
+		if (cc->iv_generator) {
+			DMWARN("dm-crypt: Selected cipher does not support IVs");
+			cc->iv_generator = NULL;
+		}
+	}
+
+	cc->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
+				     mempool_free_slab, _crypt_io_pool);
+	if (!cc->io_pool) {
+		ti->error = "dm-crypt: Cannot allocate crypt io mempool";
+		goto bad2;
+	}
+
+	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_page,
+				       mempool_free_page, NULL);
+	if (!cc->page_pool) {
+		ti->error = "dm-crypt: Cannot allocate page mempool";
+		goto bad3;
+	}
+
+	cc->tfm = tfm;
+	cc->key_size = key_size;
+	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
+	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
+		ti->error = "dm-crypt: Error decoding key";
+		goto bad4;
+	}
+
+	if (tfm->crt_u.cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
+		ti->error = "dm-crypt: Error setting key";
+		goto bad4;
+	}
+
+	if (sscanf(argv[2], SECTOR_FORMAT, &cc->iv_offset) != 1) {
+		ti->error = "dm-crypt: Invalid iv_offset sector";
+		goto bad4;
+	}
+
+	if (sscanf(argv[4], SECTOR_FORMAT, &cc->start) != 1) {
+		ti->error = "dm-crypt: Invalid device sector";
+		goto bad4;
+	}
+
+	if (dm_get_device(ti, argv[3], cc->start, ti->len,
+	                  dm_table_get_mode(ti->table), &cc->dev)) {
+		ti->error = "dm-crypt: Device lookup failed";
+		goto bad4;
+	}
+
+	ti->private = cc;
+	return 0;
+
+bad4:
+	mempool_destroy(cc->page_pool);
+bad3:
+	mempool_destroy(cc->io_pool);
+bad2:
+	crypto_free_tfm(tfm);
+bad1:
+	kfree(cc);
+	return -EINVAL;
+}
+
+static void crypt_dtr(struct dm_target *ti)
+{
+	struct crypt_config *cc = (struct crypt_config *) ti->private;
+
+	mempool_destroy(cc->page_pool);
+	mempool_destroy(cc->io_pool);
+
+	crypto_free_tfm(cc->tfm);
+	dm_put_device(ti, cc->dev);
+	kfree(cc);
+}
+
+static int crypt_endio(struct bio *bio, unsigned int done, int error)
+{
+	struct crypt_io *io = (struct crypt_io *) bio->bi_private;
+	struct crypt_config *cc = (struct crypt_config *) io->target->private;
+
+	if (bio_rw(bio) == WRITE) {
+		/*
+		 * free the processed pages, even if
+		 * it's only a partially completed write
+		 */
+		crypt_free_buffer_pages(cc, bio, done);
+	}
+
+	if (bio->bi_size)
+		return 1;
+
+	/*
+	 * successful reads are decrypted by the worker thread
+	 */
+	if ((bio_rw(bio) == READ || bio_rw(bio) == READA)
+	    && bio_flagged(bio, BIO_UPTODATE)) {
+		kcryptd_queue_bio(bio);
+		wake_up_process(_kcryptd);
+		return 0;
+	}
+
+	bio_put(bio);
+	dec_pending(io, error);
+
+	return error;
+}
+
+static int crypt_map(struct dm_target *ti, struct bio *bio,
+                     union map_info *map_context)
+{
+	struct crypt_config *cc = (struct crypt_config *) ti->private;
+	struct crypt_io *io = mempool_alloc(cc->io_pool, GFP_NOIO);
+	struct bio *clone = NULL;
+	struct convert_context ctx;
+	unsigned int remaining = bio->bi_size;
+	sector_t sector = bio->bi_sector - ti->begin;
+	int bio_vec_idx = 0;
+	int r = 0;
+
+	io->target = ti;
+	io->bio = bio;
+	io->first_clone = NULL;
+	io->error = 0;
+	atomic_set(&io->pending, 1); /* hold a reference */
+
+	if (bio_rw(bio) == WRITE)
+		crypt_convert_init(cc, &ctx, NULL, bio, sector, 1);
+
+	/*
+	 * The allocated buffers can be smaller than the whole bio,
+	 * so repeat the whole process until all the data can be handled.
+	 */
+	while (remaining) {
+		if (bio_rw(bio) == WRITE) {
+			clone = crypt_alloc_buffer(cc, bio->bi_size,
+			                           io->first_clone,
+			                           &bio_vec_idx);
+			if (clone) {
+				ctx.bio_out = clone;
+				r = crypt_convert(cc, &ctx);
+				if (r < 0) {
+					crypt_free_buffer_pages(cc, clone,
+					                        clone->bi_size);
+					bio_put(clone);
+					goto cleanup;
+				}
+			}
+		} else
+			clone = bio_clone(bio, GFP_NOIO);
+
+		if (!clone) {
+			r = -ENOMEM;
+			goto cleanup;
+		}
+
+		if (!io->first_clone) {
+			/*
+			 * hold a reference to the first clone, because it
+			 * holds the bio_vec array and that can't be freed
+			 * before all other clones are released
+			 */
+			bio_get(clone);
+			io->first_clone = clone;
+		}
+		atomic_inc(&io->pending);
+
+		clone->bi_private = io;
+		clone->bi_end_io = crypt_endio;
+		clone->bi_bdev = cc->dev->bdev;
+		clone->bi_sector = cc->start + sector;
+		clone->bi_rw = bio->bi_rw;
+
+		remaining -= clone->bi_size;
+		sector += bio_sectors(clone);
+
+		generic_make_request(clone);
+	}
+
+	/* drop reference, clones could have returned before we reach this */
+	dec_pending(io, 0);
+	return 0;
+
+cleanup:
+	if (io->first_clone) {
+		dec_pending(io, r);
+		return 0;
+	}
+
+	/* if no bio has been dispatched yet, we can directly return the error */
+	mempool_free(io, cc->io_pool);
+	return r;
+}
+
+static int crypt_status(struct dm_target *ti, status_type_t type,
+			char *result, unsigned int maxlen)
+{
+	struct crypt_config *cc = (struct crypt_config *) ti->private;
+	char buffer[32];
+	const char *cipher;
+	const char *mode = NULL;
+	int offset;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		cipher = crypto_tfm_alg_name(cc->tfm);
+
+		switch(cc->tfm->crt_u.cipher.cit_mode) {
+		case CRYPTO_TFM_MODE_CBC:
+			mode = "plain";
+			break;
+		case CRYPTO_TFM_MODE_ECB:
+			mode = "ecb";
+			break;
+		default:
+			BUG();
+		}
+
+		snprintf(result, maxlen, "%s-%s ", cipher, mode);
+		offset = strlen(result);
+
+		if (cc->key_size > 0) {
+			if ((maxlen - offset) < ((cc->key_size << 1) + 1))
+				return -ENOMEM;
+
+			crypt_encode_key(result + offset, cc->key, cc->key_size);
+			offset += cc->key_size << 1;
+		} else {
+			if (offset >= maxlen)
+				return -ENOMEM;
+			result[offset++] = '-';
+		}
+
+		format_dev_t(buffer, cc->dev->bdev->bd_dev);
+		snprintf(result + offset, maxlen - offset, " " SECTOR_FORMAT
+		         " %s " SECTOR_FORMAT, cc->iv_offset,
+		         buffer, cc->start);
+		break;
+	}
+	return 0;
+}
+
+static struct target_type crypt_target = {
+	.name   = "crypt",
+	.module = THIS_MODULE,
+	.ctr    = crypt_ctr,
+	.dtr    = crypt_dtr,
+	.map    = crypt_map,
+	.status = crypt_status,
+};
+
+static int __init dm_crypt_init(void)
+{
+	int r;
+
+	_crypt_io_pool = kmem_cache_create("dm-crypt_io",
+	                                   sizeof(struct crypt_io),
+	                                   0, 0, NULL, NULL);
+	if (!_crypt_io_pool)
+		return -ENOMEM;
+
+	_kcryptd = kthread_create(kcryptd_do_work, NULL, "kcryptd");
+	if (IS_ERR(_kcryptd)) {
+		r = PTR_ERR(_kcryptd);
+		DMERR("couldn't create kcryptd: %d", r);
+		kmem_cache_destroy(_crypt_io_pool);
+		return r;
+	}
+
+	r = dm_register_target(&crypt_target);
+	if (r < 0) {
+		DMERR("crypt: register failed %d", r);
+		kthread_stop(_kcryptd);
+		kmem_cache_destroy(_crypt_io_pool);
+		return r;
+	}
+
+	wake_up_process(_kcryptd);
+	return 0;
+}
+
+static void __exit dm_crypt_exit(void)
+{
+	int r = dm_unregister_target(&crypt_target);
+
+	if (r < 0)
+		DMERR("crypt: unregister failed %d", r);
+
+	kthread_stop(_kcryptd);
+	kmem_cache_destroy(_crypt_io_pool);
+}
+
+module_init(dm_crypt_init);
+module_exit(dm_crypt_exit);
+
+MODULE_AUTHOR("Christophe Saout <christophe@saout.de>");
+MODULE_DESCRIPTION(DM_NAME " target for transparent encryption / decryption");
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.3-rc3-mm1.orig/drivers/md/Kconfig linux-2.6.3-rc3-mm1/drivers/md/Kconfig
--- linux-2.6.3-rc3-mm1.orig/drivers/md/Kconfig	2004-02-10 18:06:13.000000000 +0100
+++ linux-2.6.3-rc3-mm1/drivers/md/Kconfig	2004-02-16 01:30:51.000000000 +0100
@@ -170,5 +170,17 @@
 	  Recent tools use a new version of the ioctl interface, only
           select this option if you intend using such tools.
 
+config DM_CRYPT
+	tristate "Crypt target support"
+	depends on BLK_DEV_DM && EXPERIMENTAL
+	select CRYPTO
+	---help---
+	  This device-mapper target allows you to create a device that
+	  transparently encrypts the data on it. You'll need to activate
+	  the required ciphers in the cryptoapi configuration in order to
+	  be able to use it.
+
+	  If unsure, say N.
+
 endmenu
 
diff -Nur linux-2.6.3-rc3-mm1.orig/drivers/md/Makefile linux-2.6.3-rc3-mm1/drivers/md/Makefile
--- linux-2.6.3-rc3-mm1.orig/drivers/md/Makefile	2004-02-16 01:24:17.000000000 +0100
+++ linux-2.6.3-rc3-mm1/drivers/md/Makefile	2004-02-16 01:30:51.000000000 +0100
@@ -23,6 +23,7 @@
 obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
+obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \

