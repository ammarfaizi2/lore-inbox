Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUBZQXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUBZQXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:23:43 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:24477 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262803AbUBZQXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:23:34 -0500
Date: Thu, 26 Feb 2004 17:23:25 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/2] dm-crypt cleanups
Message-ID: <20040226162324.GA12597@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these are some dm-crypt cleanups. Use a #define PFX "crypt: " for all
the places where something gets logged as suggested by Jeff Garzik.
It also adds a small additional security check and fixed header includes.

--- linux.orig/drivers/md/dm-crypt.c	2004-02-26 16:47:44.436899648 +0100
+++ linux/drivers/md/dm-crypt.c	2004-02-26 16:54:08.068578768 +0100
@@ -8,15 +8,18 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
+#include <linux/blkdev.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/crypto.h>
-#include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <asm/atomic.h>
 #include <asm/scatterlist.h>
 
 #include "dm.h"
 
+#define PFX	"crypt: "
+
 /*
  * per bio private data
  */
@@ -416,7 +419,7 @@
 	int key_size;
 
 	if (argc != 5) {
-		ti->error = "dm-crypt: Not enough arguments";
+		ti->error = PFX "Not enough arguments";
 		return -EINVAL;
 	}
 
@@ -425,14 +428,14 @@
 	mode = strsep(&tmp, "-");
 
 	if (tmp)
-		DMWARN("dm-crypt: Unexpected additional cipher options");
+		DMWARN(PFX "Unexpected additional cipher options");
 
 	key_size = strlen(argv[1]) >> 1;
 
 	cc = kmalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
 	if (cc == NULL) {
 		ti->error =
-			"dm-crypt: Cannot allocate transparent encryption context";
+			PFX "Cannot allocate transparent encryption context";
 		return -ENOMEM;
 	}
 
@@ -441,7 +444,7 @@
 	else if (strcmp(mode, "ecb") == 0)
 		cc->iv_generator = NULL;
 	else {
-		ti->error = "dm-crypt: Invalid chaining mode";
+		ti->error = PFX "Invalid chaining mode";
 		goto bad1;
 	}
 
@@ -452,18 +455,22 @@
 
 	tfm = crypto_alloc_tfm(cipher, crypto_flags);
 	if (!tfm) {
-		ti->error = "dm-crypt: Error allocating crypto tfm";
+		ti->error = PFX "Error allocating crypto tfm";
 		goto bad1;
 	}
+	if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER) {
+		ti->error = PFX "Expected cipher algorithm";
+		goto bad2;
+	}
 
-	if (tfm->crt_u.cipher.cit_decrypt_iv && tfm->crt_u.cipher.cit_encrypt_iv)
+	if (tfm->crt_cipher.cit_decrypt_iv && tfm->crt_cipher.cit_encrypt_iv)
 		/* at least a 32 bit sector number should fit in our buffer */
 		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm),
 		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
 	else {
 		cc->iv_size = 0;
 		if (cc->iv_generator) {
-			DMWARN("dm-crypt: Selected cipher does not support IVs");
+			DMWARN(PFX "Selected cipher does not support IVs");
 			cc->iv_generator = NULL;
 		}
 	}
@@ -471,14 +478,14 @@
 	cc->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
 				     mempool_free_slab, _crypt_io_pool);
 	if (!cc->io_pool) {
-		ti->error = "dm-crypt: Cannot allocate crypt io mempool";
+		ti->error = PFX "Cannot allocate crypt io mempool";
 		goto bad2;
 	}
 
 	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_page,
 				       mempool_free_page, NULL);
 	if (!cc->page_pool) {
-		ti->error = "dm-crypt: Cannot allocate page mempool";
+		ti->error = PFX "Cannot allocate page mempool";
 		goto bad3;
 	}
 
@@ -486,28 +493,28 @@
 	cc->key_size = key_size;
 	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
 	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
-		ti->error = "dm-crypt: Error decoding key";
+		ti->error = PFX "Error decoding key";
 		goto bad4;
 	}
 
-	if (tfm->crt_u.cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
-		ti->error = "dm-crypt: Error setting key";
+	if (tfm->crt_cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
+		ti->error = PFX "Error setting key";
 		goto bad4;
 	}
 
 	if (sscanf(argv[2], SECTOR_FORMAT, &cc->iv_offset) != 1) {
-		ti->error = "dm-crypt: Invalid iv_offset sector";
+		ti->error = PFX "Invalid iv_offset sector";
 		goto bad4;
 	}
 
 	if (sscanf(argv[4], SECTOR_FORMAT, &cc->start) != 1) {
-		ti->error = "dm-crypt: Invalid device sector";
+		ti->error = PFX "Invalid device sector";
 		goto bad4;
 	}
 
 	if (dm_get_device(ti, argv[3], cc->start, ti->len,
 	                  dm_table_get_mode(ti->table), &cc->dev)) {
-		ti->error = "dm-crypt: Device lookup failed";
+		ti->error = PFX "Device lookup failed";
 		goto bad4;
 	}
 
@@ -682,7 +689,7 @@
 	case STATUSTYPE_TABLE:
 		cipher = crypto_tfm_alg_name(cc->tfm);
 
-		switch(cc->tfm->crt_u.cipher.cit_mode) {
+		switch(cc->tfm->crt_cipher.cit_mode) {
 		case CRYPTO_TFM_MODE_CBC:
 			mode = "plain";
 			break;
@@ -739,13 +746,13 @@
 	_kcryptd_workqueue = create_workqueue("kcryptd");
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
-		DMERR("couldn't create kcryptd");
+		DMERR(PFX "couldn't create kcryptd");
 		goto bad1;
 	}
 
 	r = dm_register_target(&crypt_target);
 	if (r < 0) {
-		DMERR("crypt: register failed %d", r);
+		DMERR(PFX "register failed %d", r);
 		goto bad2;
 	}
 
@@ -763,7 +770,7 @@
 	int r = dm_unregister_target(&crypt_target);
 
 	if (r < 0)
-		DMERR("crypt: unregister failed %d", r);
+		DMERR(PFX "unregister failed %d", r);
 
 	destroy_workqueue(_kcryptd_workqueue);
 	kmem_cache_destroy(_crypt_io_pool);
