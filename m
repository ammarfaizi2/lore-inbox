Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLWRDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTLWRC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:02:57 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:55450 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261872AbTLWRCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:02:43 -0500
Date: Tue, 23 Dec 2003 18:01:18 +0100
From: Christophe Saout <christophe@saout.de>
To: Joe Thornber <thornber@sistina.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031223170118.GA4384@leto.cs.pocnet.net>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <20031223131355.A6864@infradead.org> <1072186582.4111.46.camel@leto.cs.pocnet.net> <20031223151545.GE476@reti> <20031223153143.GA28690@gtf.org> <20031223154325.GF476@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223154325.GF476@reti>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 03:43:25PM +0000, Joe Thornber wrote:

> On Tue, Dec 23, 2003 at 10:31:43AM -0500, Jeff Garzik wrote:
> > I agree w/ Christoph...  overly defensive programming like this just
> > creates a new class of programmer errors, doesn't really solve anything.
> > It's standard Linux kernel style, and making code look like all other
> > code has benefits in review and debugging.  Finally, the programmer
> > should be paying attention to what kernel APIs he/she uses, and add
> > headers accordingly.
> 
> ok, I don't feel strongly enough about it to argue, so we'll change it.

Ok, me too. :-)

So how does this look?

--- linux.orig/drivers/md/dm-crypt.c	2003-12-23 16:43:48.409077048 +0100
+++ linux/drivers/md/dm-crypt.c	2003-12-23 16:52:11.946527720 +0100
@@ -4,9 +4,6 @@
  * This file is released under the GPL.
  */
 
-#include "dm.h"
-#include "dm-daemon.h"
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/bio.h>
@@ -16,6 +13,9 @@
 #include <linux/spinlock.h>
 #include <asm/scatterlist.h>
 
+#include "dm.h"
+#include "dm-daemon.h"
+
 /*
  * per bio private data
  */
@@ -70,10 +70,10 @@
 #define MIN_POOL_PAGES 16
 #define MIN_BIO_PAGES  8
 
-static kmem_cache_t *_io_cache;
+static kmem_cache_t *crypt_io_pool;
 
 /*
- * Mempool alloc and free functions for the page and io pool
+ * Mempool alloc and free functions for the page
  */
 static void *mempool_alloc_page(int gfp_mask, void *data)
 {
@@ -85,26 +85,6 @@
 	__free_page(page);
 }
 
-static inline struct page *crypt_alloc_page(struct crypt_c *cc, int gfp_mask)
-{
-	return mempool_alloc(cc->page_pool, gfp_mask);
-}
-
-static inline void crypt_free_page(struct crypt_c *cc, struct page *page)
-{
-	 mempool_free(page, cc->page_pool);
-}
-
-static inline struct crypt_io *crypt_alloc_io(struct crypt_c *cc)
-{
-	return mempool_alloc(cc->io_pool, GFP_NOIO);
-}
-
-static inline void crypt_free_io(struct crypt_c *cc, struct crypt_io *io)
-{
-	return mempool_free(io, cc->io_pool);
-}
-
 /*
  * Encrypt / decrypt a single sector, source and destination buffers
  * are stored in scatterlists. In CBC mode initialise the "previous
@@ -232,7 +212,7 @@
 	for(i = bio->bi_idx; i < nr_iovecs; i++) {
 		struct bio_vec *bv = bio_iovec_idx(bio, i);
 
-		bv->bv_page = crypt_alloc_page(cc, gfp_mask);
+		bv->bv_page = mempool_alloc(cc->page_pool, gfp_mask);
 		if (!bv->bv_page)
 			break;
 
@@ -276,7 +256,7 @@
 
 	while(bytes) {
 		struct bio_vec *bv = bio_iovec_idx(bio, i++);
-		crypt_free_page(cc, bv->bv_page);
+		mempool_free(bv->bv_page, cc->page_pool);
 		bytes -= bv->bv_len;
 	}
 }
@@ -301,7 +281,7 @@
 	if (io->bio)
 		bio_endio(io->bio, io->bio->bi_size, io->error);
 
-	crypt_free_io(cc, io);
+	mempool_free(io, cc->io_pool);
 }
 
 /*
@@ -311,11 +291,11 @@
  * interrupt context, so returning bios from read requests get
  * queued here.
  */
-static spinlock_t _kcryptd_lock = SPIN_LOCK_UNLOCKED;
-static struct bio *_bio_head;
-static struct bio *_bio_tail;
+static spinlock_t kcryptd_lock = SPIN_LOCK_UNLOCKED;
+static struct bio *kcryptd_bio_head;
+static struct bio *kcryptd_bio_tail;
 
-static struct dm_daemon _kcryptd;
+static struct dm_daemon kcryptd;
 
 /*
  * Fetch a list of the complete bios.
@@ -324,11 +304,11 @@
 {
 	struct bio *bio;
 
-	spin_lock_irq(&_kcryptd_lock);
-	bio = _bio_head;
+	spin_lock_irq(&kcryptd_lock);
+	bio = kcryptd_bio_head;
 	if (bio)
-		_bio_head = _bio_tail = NULL;
-	spin_unlock_irq(&_kcryptd_lock);
+		kcryptd_bio_head = kcryptd_bio_tail = NULL;
+	spin_unlock_irq(&kcryptd_lock);
 
 	return bio;
 }
@@ -340,16 +320,16 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&_kcryptd_lock, flags);
-	if (_bio_tail)
-		_bio_tail->bi_next = bio;
+	spin_lock_irqsave(&kcryptd_lock, flags);
+	if (kcryptd_bio_tail)
+		kcryptd_bio_tail->bi_next = bio;
 	else
-		_bio_head = bio;
-	_bio_tail = bio;
-	spin_unlock_irqrestore(&_kcryptd_lock, flags);
+		kcryptd_bio_head = bio;
+	kcryptd_bio_tail = bio;
+	spin_unlock_irqrestore(&kcryptd_lock, flags);
 }
 
-static jiffy_t kcryptd(void)
+static jiffy_t kcryptd_do_work(void)
 {
 	int r;
 	struct bio *bio;
@@ -493,7 +473,7 @@
 	}
 
 	cc->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-				     mempool_free_slab, _io_cache);
+				     mempool_free_slab, crypt_io_pool);
 	if (!cc->io_pool) {
 		ti->error = "dm-crypt: Cannot allocate crypt io mempool";
 		goto bad1;
@@ -584,7 +564,7 @@
 	if ((bio_rw(bio) == READ || bio_rw(bio) == READA)
 	    && bio_flagged(bio, BIO_UPTODATE)) {
 		kcryptd_queue_bio(bio);
-		dm_daemon_wake(&_kcryptd);
+		dm_daemon_wake(&kcryptd);
 		return 0;
 	}
 
@@ -597,7 +577,7 @@
 static int crypt_map(struct dm_target *ti, struct bio *bio)
 {
 	struct crypt_c *cc = (struct crypt_c *) ti->private;
-	struct crypt_io *io = crypt_alloc_io(cc);
+	struct crypt_io *io = mempool_alloc(cc->io_pool, GFP_NOIO);
 	struct bio *clone = NULL;
 	struct convert_context ctx;
 	unsigned int remaining = bio->bi_size;
@@ -675,7 +655,7 @@
 	}
 
 	/* if no bio has been dispatched yet, we can directly return the error */
-	crypt_free_io(cc, io);
+	mempool_free(io, cc->io_pool);
 	return r;
 }
 
@@ -740,48 +720,45 @@
 	.status = crypt_status,
 };
 
-int __init dm_crypt_init(void)
+static int __init dm_crypt_init(void)
 {
 	int r;
 
-	_io_cache = kmem_cache_create("dm-crypt_io", sizeof(struct crypt_io),
-	                              0, 0, NULL, NULL);
-	if (!_io_cache)
+	crypt_io_pool = kmem_cache_create("dm-crypt_io", sizeof(struct crypt_io),
+	                                  0, 0, NULL, NULL);
+	if (!crypt_io_pool)
 		return -ENOMEM;
 
-	r = dm_daemon_start(&_kcryptd, "kcryptd", kcryptd);
+	r = dm_daemon_start(&kcryptd, "kcryptd", kcryptd_do_work);
 	if (r) {
 		DMERR("couldn't create kcryptd: %d", r);
-		kmem_cache_destroy(_io_cache);
+		kmem_cache_destroy(crypt_io_pool);
 		return r;
 	}
 
 	r = dm_register_target(&crypt_target);
 	if (r < 0) {
 		DMERR("crypt: register failed %d", r);
-		dm_daemon_stop(&_kcryptd);
-		kmem_cache_destroy(_io_cache);
+		dm_daemon_stop(&kcryptd);
+		kmem_cache_destroy(crypt_io_pool);
 	}
 
 	return r;
 }
 
-void __exit dm_crypt_exit(void)
+static void __exit dm_crypt_exit(void)
 {
 	int r = dm_unregister_target(&crypt_target);
 
 	if (r < 0)
 		DMERR("crypt: unregister failed %d", r);
 
-	dm_daemon_stop(&_kcryptd);
-	kmem_cache_destroy(_io_cache);
+	dm_daemon_stop(&kcryptd);
+	kmem_cache_destroy(crypt_io_pool);
 }
 
-/*
- * module hooks
- */
-module_init(dm_crypt_init)
-module_exit(dm_crypt_exit)
+module_init(dm_crypt_init);
+module_exit(dm_crypt_exit);
 
 MODULE_AUTHOR("Christophe Saout <christophe@saout.de>");
 MODULE_DESCRIPTION(DM_NAME " target for transparent encryption / decryption");

