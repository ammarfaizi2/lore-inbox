Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWFUTid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWFUTid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWFUTiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:38:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932706AbWFUTiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:38:04 -0400
Date: Wed, 21 Jun 2006 20:37:55 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] dm: improve error message consistency
Message-ID: <20060621193755.GD4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy device-mapper error messages to include context information
automatically.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-crypt.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-crypt.c	2006-06-21 18:32:46.000000000 +0100
@@ -20,7 +20,7 @@
 
 #include "dm.h"
 
-#define PFX	"crypt: "
+#define DM_MSG_PREFIX "crypt"
 
 /*
  * per bio private data
@@ -125,19 +125,19 @@ static int crypt_iv_essiv_ctr(struct cry
 	u8 *salt;
 
 	if (opts == NULL) {
-		ti->error = PFX "Digest algorithm missing for ESSIV mode";
+		ti->error = "Digest algorithm missing for ESSIV mode";
 		return -EINVAL;
 	}
 
 	/* Hash the cipher key with the given hash algorithm */
 	hash_tfm = crypto_alloc_tfm(opts, CRYPTO_TFM_REQ_MAY_SLEEP);
 	if (hash_tfm == NULL) {
-		ti->error = PFX "Error initializing ESSIV hash";
+		ti->error = "Error initializing ESSIV hash";
 		return -EINVAL;
 	}
 
 	if (crypto_tfm_alg_type(hash_tfm) != CRYPTO_ALG_TYPE_DIGEST) {
-		ti->error = PFX "Expected digest algorithm for ESSIV hash";
+		ti->error = "Expected digest algorithm for ESSIV hash";
 		crypto_free_tfm(hash_tfm);
 		return -EINVAL;
 	}
@@ -145,7 +145,7 @@ static int crypt_iv_essiv_ctr(struct cry
 	saltsize = crypto_tfm_alg_digestsize(hash_tfm);
 	salt = kmalloc(saltsize, GFP_KERNEL);
 	if (salt == NULL) {
-		ti->error = PFX "Error kmallocing salt storage in ESSIV";
+		ti->error = "Error kmallocing salt storage in ESSIV";
 		crypto_free_tfm(hash_tfm);
 		return -ENOMEM;
 	}
@@ -159,20 +159,20 @@ static int crypt_iv_essiv_ctr(struct cry
 	                             CRYPTO_TFM_MODE_ECB |
 	                             CRYPTO_TFM_REQ_MAY_SLEEP);
 	if (essiv_tfm == NULL) {
-		ti->error = PFX "Error allocating crypto tfm for ESSIV";
+		ti->error = "Error allocating crypto tfm for ESSIV";
 		kfree(salt);
 		return -EINVAL;
 	}
 	if (crypto_tfm_alg_blocksize(essiv_tfm)
 	    != crypto_tfm_alg_ivsize(cc->tfm)) {
-		ti->error = PFX "Block size of ESSIV cipher does "
+		ti->error = "Block size of ESSIV cipher does "
 			        "not match IV size of block cipher";
 		crypto_free_tfm(essiv_tfm);
 		kfree(salt);
 		return -EINVAL;
 	}
 	if (crypto_cipher_setkey(essiv_tfm, salt, saltsize) < 0) {
-		ti->error = PFX "Failed to set key for ESSIV cipher";
+		ti->error = "Failed to set key for ESSIV cipher";
 		crypto_free_tfm(essiv_tfm);
 		kfree(salt);
 		return -EINVAL;
@@ -521,7 +521,7 @@ static int crypt_ctr(struct dm_target *t
 	unsigned long long tmpll;
 
 	if (argc != 5) {
-		ti->error = PFX "Not enough arguments";
+		ti->error = "Not enough arguments";
 		return -EINVAL;
 	}
 
@@ -532,21 +532,21 @@ static int crypt_ctr(struct dm_target *t
 	ivmode = strsep(&ivopts, ":");
 
 	if (tmp)
-		DMWARN(PFX "Unexpected additional cipher options");
+		DMWARN("Unexpected additional cipher options");
 
 	key_size = strlen(argv[1]) >> 1;
 
 	cc = kmalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
 	if (cc == NULL) {
 		ti->error =
-			PFX "Cannot allocate transparent encryption context";
+			"Cannot allocate transparent encryption context";
 		return -ENOMEM;
 	}
 
 	cc->key_size = key_size;
 	if ((!key_size && strcmp(argv[1], "-") != 0) ||
 	    (key_size && crypt_decode_key(cc->key, argv[1], key_size) < 0)) {
-		ti->error = PFX "Error decoding key";
+		ti->error = "Error decoding key";
 		goto bad1;
 	}
 
@@ -562,22 +562,22 @@ static int crypt_ctr(struct dm_target *t
 	else if (strcmp(chainmode, "ecb") == 0)
 		crypto_flags = CRYPTO_TFM_MODE_ECB;
 	else {
-		ti->error = PFX "Unknown chaining mode";
+		ti->error = "Unknown chaining mode";
 		goto bad1;
 	}
 
 	if (crypto_flags != CRYPTO_TFM_MODE_ECB && !ivmode) {
-		ti->error = PFX "This chaining mode requires an IV mechanism";
+		ti->error = "This chaining mode requires an IV mechanism";
 		goto bad1;
 	}
 
 	tfm = crypto_alloc_tfm(cipher, crypto_flags | CRYPTO_TFM_REQ_MAY_SLEEP);
 	if (!tfm) {
-		ti->error = PFX "Error allocating crypto tfm";
+		ti->error = "Error allocating crypto tfm";
 		goto bad1;
 	}
 	if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER) {
-		ti->error = PFX "Expected cipher algorithm";
+		ti->error = "Expected cipher algorithm";
 		goto bad2;
 	}
 
@@ -595,7 +595,7 @@ static int crypt_ctr(struct dm_target *t
 	else if (strcmp(ivmode, "essiv") == 0)
 		cc->iv_gen_ops = &crypt_iv_essiv_ops;
 	else {
-		ti->error = PFX "Invalid IV mode";
+		ti->error = "Invalid IV mode";
 		goto bad2;
 	}
 
@@ -610,7 +610,7 @@ static int crypt_ctr(struct dm_target *t
 	else {
 		cc->iv_size = 0;
 		if (cc->iv_gen_ops) {
-			DMWARN(PFX "Selected cipher does not support IVs");
+			DMWARN("Selected cipher does not support IVs");
 			if (cc->iv_gen_ops->dtr)
 				cc->iv_gen_ops->dtr(cc);
 			cc->iv_gen_ops = NULL;
@@ -619,36 +619,36 @@ static int crypt_ctr(struct dm_target *t
 
 	cc->io_pool = mempool_create_slab_pool(MIN_IOS, _crypt_io_pool);
 	if (!cc->io_pool) {
-		ti->error = PFX "Cannot allocate crypt io mempool";
+		ti->error = "Cannot allocate crypt io mempool";
 		goto bad3;
 	}
 
 	cc->page_pool = mempool_create_page_pool(MIN_POOL_PAGES, 0);
 	if (!cc->page_pool) {
-		ti->error = PFX "Cannot allocate page mempool";
+		ti->error = "Cannot allocate page mempool";
 		goto bad4;
 	}
 
 	if (tfm->crt_cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
-		ti->error = PFX "Error setting key";
+		ti->error = "Error setting key";
 		goto bad5;
 	}
 
 	if (sscanf(argv[2], "%llu", &tmpll) != 1) {
-		ti->error = PFX "Invalid iv_offset sector";
+		ti->error = "Invalid iv_offset sector";
 		goto bad5;
 	}
 	cc->iv_offset = tmpll;
 
 	if (sscanf(argv[4], "%llu", &tmpll) != 1) {
-		ti->error = PFX "Invalid device sector";
+		ti->error = "Invalid device sector";
 		goto bad5;
 	}
 	cc->start = tmpll;
 
 	if (dm_get_device(ti, argv[3], cc->start, ti->len,
 	                  dm_table_get_mode(ti->table), &cc->dev)) {
-		ti->error = PFX "Device lookup failed";
+		ti->error = "Device lookup failed";
 		goto bad5;
 	}
 
@@ -657,7 +657,7 @@ static int crypt_ctr(struct dm_target *t
 			*(ivopts - 1) = ':';
 		cc->iv_mode = kmalloc(strlen(ivmode) + 1, GFP_KERNEL);
 		if (!cc->iv_mode) {
-			ti->error = PFX "Error kmallocing iv_mode string";
+			ti->error = "Error kmallocing iv_mode string";
 			goto bad5;
 		}
 		strcpy(cc->iv_mode, ivmode);
@@ -918,13 +918,13 @@ static int __init dm_crypt_init(void)
 	_kcryptd_workqueue = create_workqueue("kcryptd");
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
-		DMERR(PFX "couldn't create kcryptd");
+		DMERR("couldn't create kcryptd");
 		goto bad1;
 	}
 
 	r = dm_register_target(&crypt_target);
 	if (r < 0) {
-		DMERR(PFX "register failed %d", r);
+		DMERR("register failed %d", r);
 		goto bad2;
 	}
 
@@ -942,7 +942,7 @@ static void __exit dm_crypt_exit(void)
 	int r = dm_unregister_target(&crypt_target);
 
 	if (r < 0)
-		DMERR(PFX "unregister failed %d", r);
+		DMERR("unregister failed %d", r);
 
 	destroy_workqueue(_kcryptd_workqueue);
 	kmem_cache_destroy(_crypt_io_pool);
Index: linux-2.6.17/drivers/md/dm-emc.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-emc.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-emc.c	2006-06-21 18:32:46.000000000 +0100
@@ -12,6 +12,8 @@
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 
+#define DM_MSG_PREFIX "multipath emc"
+
 struct emc_handler {
 	spinlock_t lock;
 
@@ -66,7 +68,7 @@ static struct bio *get_failover_bio(stru
 
 	bio = bio_alloc(GFP_ATOMIC, 1);
 	if (!bio) {
-		DMERR("dm-emc: get_failover_bio: bio_alloc() failed.");
+		DMERR("get_failover_bio: bio_alloc() failed.");
 		return NULL;
 	}
 
@@ -78,13 +80,13 @@ static struct bio *get_failover_bio(stru
 
 	page = alloc_page(GFP_ATOMIC);
 	if (!page) {
-		DMERR("dm-emc: get_failover_bio: alloc_page() failed.");
+		DMERR("get_failover_bio: alloc_page() failed.");
 		bio_put(bio);
 		return NULL;
 	}
 
 	if (bio_add_page(bio, page, data_size, 0) != data_size) {
-		DMERR("dm-emc: get_failover_bio: alloc_page() failed.");
+		DMERR("get_failover_bio: alloc_page() failed.");
 		__free_page(page);
 		bio_put(bio);
 		return NULL;
@@ -103,7 +105,7 @@ static struct request *get_failover_req(
 	/* FIXME: Figure out why it fails with GFP_ATOMIC. */
 	rq = blk_get_request(q, WRITE, __GFP_WAIT);
 	if (!rq) {
-		DMERR("dm-emc: get_failover_req: blk_get_request failed");
+		DMERR("get_failover_req: blk_get_request failed");
 		return NULL;
 	}
 
@@ -160,7 +162,7 @@ static struct request *emc_trespass_get(
 
 	bio = get_failover_bio(path, data_size);
 	if (!bio) {
-		DMERR("dm-emc: emc_trespass_get: no bio");
+		DMERR("emc_trespass_get: no bio");
 		return NULL;
 	}
 
@@ -173,7 +175,7 @@ static struct request *emc_trespass_get(
 	/* get request for block layer packet command */
 	rq = get_failover_req(h, bio, path);
 	if (!rq) {
-		DMERR("dm-emc: emc_trespass_get: no rq");
+		DMERR("emc_trespass_get: no rq");
 		free_bio(bio);
 		return NULL;
 	}
@@ -200,18 +202,18 @@ static void emc_pg_init(struct hw_handle
 	 * initial state passed into us and then get an update here.
 	 */
 	if (!q) {
-		DMINFO("dm-emc: emc_pg_init: no queue");
+		DMINFO("emc_pg_init: no queue");
 		goto fail_path;
 	}
 
 	/* FIXME: The request should be pre-allocated. */
 	rq = emc_trespass_get(hwh->context, path);
 	if (!rq) {
-		DMERR("dm-emc: emc_pg_init: no rq");
+		DMERR("emc_pg_init: no rq");
 		goto fail_path;
 	}
 
-	DMINFO("dm-emc: emc_pg_init: sending switch-over command");
+	DMINFO("emc_pg_init: sending switch-over command");
 	elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 1);
 	return;
 
@@ -241,18 +243,18 @@ static int emc_create(struct hw_handler 
 		hr = 0;
 		short_trespass = 0;
 	} else if (argc != 2) {
-		DMWARN("dm-emc hwhandler: incorrect number of arguments");
+		DMWARN("incorrect number of arguments");
 		return -EINVAL;
 	} else {
 		if ((sscanf(argv[0], "%u", &short_trespass) != 1)
 			|| (short_trespass > 1)) {
-			DMWARN("dm-emc: invalid trespass mode selected");
+			DMWARN("invalid trespass mode selected");
 			return -EINVAL;
 		}
 
 		if ((sscanf(argv[1], "%u", &hr) != 1)
 			|| (hr > 1)) {
-			DMWARN("dm-emc: invalid honor reservation flag selected");
+			DMWARN("invalid honor reservation flag selected");
 			return -EINVAL;
 		}
 	}
@@ -264,14 +266,14 @@ static int emc_create(struct hw_handler 
 	hwh->context = h;
 
 	if ((h->short_trespass = short_trespass))
-		DMWARN("dm-emc: short trespass command will be send");
+		DMWARN("short trespass command will be send");
 	else
-		DMWARN("dm-emc: long trespass command will be send");
+		DMWARN("long trespass command will be send");
 
 	if ((h->hr = hr))
-		DMWARN("dm-emc: honor reservation bit will be set");
+		DMWARN("honor reservation bit will be set");
 	else
-		DMWARN("dm-emc: honor reservation bit will not be set (default)");
+		DMWARN("honor reservation bit will not be set (default)");
 
 	return 0;
 }
@@ -336,9 +338,9 @@ static int __init dm_emc_init(void)
 	int r = dm_register_hw_handler(&emc_hwh);
 
 	if (r < 0)
-		DMERR("emc: register failed %d", r);
+		DMERR("register failed %d", r);
 
-	DMINFO("dm-emc version 0.0.3 loaded");
+	DMINFO("version 0.0.3 loaded");
 
 	return r;
 }
@@ -348,7 +350,7 @@ static void __exit dm_emc_exit(void)
 	int r = dm_unregister_hw_handler(&emc_hwh);
 
 	if (r < 0)
-		DMERR("emc: unregister failed %d", r);
+		DMERR("unregister failed %d", r);
 }
 
 module_init(dm_emc_init);
Index: linux-2.6.17/drivers/md/dm-exception-store.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-exception-store.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-exception-store.c	2006-06-21 18:32:46.000000000 +0100
@@ -16,6 +16,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 
+#define DM_MSG_PREFIX "snapshots"
+
 /*-----------------------------------------------------------------
  * Persistent snapshots, by persistent we mean that the snapshot
  * will survive a reboot.
Index: linux-2.6.17/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-ioctl.c	2006-06-21 18:32:42.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-ioctl.c	2006-06-21 18:32:46.000000000 +0100
@@ -19,6 +19,7 @@
 
 #include <asm/uaccess.h>
 
+#define DM_MSG_PREFIX "ioctl"
 #define DM_DRIVER_EMAIL "dm-devel@redhat.com"
 
 /*-----------------------------------------------------------------
Index: linux-2.6.17/drivers/md/dm-linear.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-linear.c	2006-06-21 18:32:14.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-linear.c	2006-06-21 18:32:46.000000000 +0100
@@ -12,6 +12,8 @@
 #include <linux/bio.h>
 #include <linux/slab.h>
 
+#define DM_MSG_PREFIX "linear"
+
 /*
  * Linear: maps a linear range of a device.
  */
@@ -29,7 +31,7 @@ static int linear_ctr(struct dm_target *
 	unsigned long long tmp;
 
 	if (argc != 2) {
-		ti->error = "dm-linear: Invalid argument count";
+		ti->error = "Invalid argument count";
 		return -EINVAL;
 	}
 
@@ -122,7 +124,7 @@ int __init dm_linear_init(void)
 	int r = dm_register_target(&linear_target);
 
 	if (r < 0)
-		DMERR("linear: register failed %d", r);
+		DMERR("register failed %d", r);
 
 	return r;
 }
@@ -132,5 +134,5 @@ void dm_linear_exit(void)
 	int r = dm_unregister_target(&linear_target);
 
 	if (r < 0)
-		DMERR("linear: unregister failed %d", r);
+		DMERR("unregister failed %d", r);
 }
Index: linux-2.6.17/drivers/md/dm-log.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-log.c	2006-06-21 18:32:18.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-log.c	2006-06-21 18:32:46.000000000 +0100
@@ -12,6 +12,8 @@
 #include "dm-log.h"
 #include "dm-io.h"
 
+#define DM_MSG_PREFIX "mirror log"
+
 static LIST_HEAD(_log_types);
 static DEFINE_SPINLOCK(_lock);
 
Index: linux-2.6.17/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-mpath.c	2006-06-21 18:32:14.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-mpath.c	2006-06-21 18:32:46.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <asm/atomic.h>
 
+#define DM_MSG_PREFIX "multipath"
 #define MESG_STR(x) x, sizeof(x)
 
 /* Path properties */
@@ -446,8 +447,6 @@ struct param {
 	char *error;
 };
 
-#define ESTR(s) ("dm-multipath: " s)
-
 static int read_param(struct param *param, char *str, unsigned *v, char **error)
 {
 	if (!str ||
@@ -495,12 +494,12 @@ static int parse_path_selector(struct ar
 	unsigned ps_argc;
 
 	static struct param _params[] = {
-		{0, 1024, ESTR("invalid number of path selector args")},
+		{0, 1024, "invalid number of path selector args"},
 	};
 
 	pst = dm_get_path_selector(shift(as));
 	if (!pst) {
-		ti->error = ESTR("unknown path selector type");
+		ti->error = "unknown path selector type";
 		return -EINVAL;
 	}
 
@@ -511,7 +510,7 @@ static int parse_path_selector(struct ar
 	r = pst->create(&pg->ps, ps_argc, as->argv);
 	if (r) {
 		dm_put_path_selector(pst);
-		ti->error = ESTR("path selector constructor failed");
+		ti->error = "path selector constructor failed";
 		return r;
 	}
 
@@ -529,7 +528,7 @@ static struct pgpath *parse_path(struct 
 
 	/* we need at least a path arg */
 	if (as->argc < 1) {
-		ti->error = ESTR("no device given");
+		ti->error = "no device given";
 		return NULL;
 	}
 
@@ -540,7 +539,7 @@ static struct pgpath *parse_path(struct 
 	r = dm_get_device(ti, shift(as), ti->begin, ti->len,
 			  dm_table_get_mode(ti->table), &p->path.dev);
 	if (r) {
-		ti->error = ESTR("error getting device");
+		ti->error = "error getting device";
 		goto bad;
 	}
 
@@ -562,8 +561,8 @@ static struct priority_group *parse_prio
 						   struct dm_target *ti)
 {
 	static struct param _params[] = {
-		{1, 1024, ESTR("invalid number of paths")},
-		{0, 1024, ESTR("invalid number of selector args")}
+		{1, 1024, "invalid number of paths"},
+		{0, 1024, "invalid number of selector args"}
 	};
 
 	int r;
@@ -572,13 +571,13 @@ static struct priority_group *parse_prio
 
 	if (as->argc < 2) {
 		as->argc = 0;
-		ti->error = ESTR("not enough priority group aruments");
+		ti->error = "not enough priority group aruments";
 		return NULL;
 	}
 
 	pg = alloc_priority_group();
 	if (!pg) {
-		ti->error = ESTR("couldn't allocate priority group");
+		ti->error = "couldn't allocate priority group";
 		return NULL;
 	}
 	pg->m = m;
@@ -633,7 +632,7 @@ static int parse_hw_handler(struct arg_s
 	unsigned hw_argc;
 
 	static struct param _params[] = {
-		{0, 1024, ESTR("invalid number of hardware handler args")},
+		{0, 1024, "invalid number of hardware handler args"},
 	};
 
 	r = read_param(_params, shift(as), &hw_argc, &ti->error);
@@ -645,14 +644,14 @@ static int parse_hw_handler(struct arg_s
 
 	hwht = dm_get_hw_handler(shift(as));
 	if (!hwht) {
-		ti->error = ESTR("unknown hardware handler type");
+		ti->error = "unknown hardware handler type";
 		return -EINVAL;
 	}
 
 	r = hwht->create(&m->hw_handler, hw_argc - 1, as->argv);
 	if (r) {
 		dm_put_hw_handler(hwht);
-		ti->error = ESTR("hardware handler constructor failed");
+		ti->error = "hardware handler constructor failed";
 		return r;
 	}
 
@@ -669,7 +668,7 @@ static int parse_features(struct arg_set
 	unsigned argc;
 
 	static struct param _params[] = {
-		{0, 1, ESTR("invalid number of feature args")},
+		{0, 1, "invalid number of feature args"},
 	};
 
 	r = read_param(_params, shift(as), &argc, &ti->error);
@@ -692,8 +691,8 @@ static int multipath_ctr(struct dm_targe
 {
 	/* target parameters */
 	static struct param _params[] = {
-		{1, 1024, ESTR("invalid number of priority groups")},
-		{1, 1024, ESTR("invalid initial priority group number")},
+		{1, 1024, "invalid number of priority groups"},
+		{1, 1024, "invalid initial priority group number"},
 	};
 
 	int r;
@@ -707,7 +706,7 @@ static int multipath_ctr(struct dm_targe
 
 	m = alloc_multipath();
 	if (!m) {
-		ti->error = ESTR("can't allocate multipath");
+		ti->error = "can't allocate multipath";
 		return -EINVAL;
 	}
 
@@ -746,7 +745,7 @@ static int multipath_ctr(struct dm_targe
 	}
 
 	if (pg_count != m->nr_priority_groups) {
-		ti->error = ESTR("priority group count mismatch");
+		ti->error = "priority group count mismatch";
 		r = -EINVAL;
 		goto bad;
 	}
@@ -807,7 +806,7 @@ static int fail_path(struct pgpath *pgpa
 	if (!pgpath->path.is_active)
 		goto out;
 
-	DMWARN("dm-multipath: Failing path %s.", pgpath->path.dev->name);
+	DMWARN("Failing path %s.", pgpath->path.dev->name);
 
 	pgpath->pg->ps.type->fail_path(&pgpath->pg->ps, &pgpath->path);
 	pgpath->path.is_active = 0;
@@ -1250,7 +1249,7 @@ static int multipath_message(struct dm_t
 	r = dm_get_device(ti, argv[1], ti->begin, ti->len,
 			  dm_table_get_mode(ti->table), &dev);
 	if (r) {
-		DMWARN("dm-multipath message: error getting device %s",
+		DMWARN("message: error getting device %s",
 		       argv[1]);
 		return -EINVAL;
 	}
@@ -1338,7 +1337,7 @@ static int __init dm_multipath_init(void
 		return -ENOMEM;
 	}
 
-	DMINFO("dm-multipath version %u.%u.%u loaded",
+	DMINFO("version %u.%u.%u loaded",
 	       multipath_target.version[0], multipath_target.version[1],
 	       multipath_target.version[2]);
 
Index: linux-2.6.17/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-raid1.c	2006-06-21 18:32:18.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-raid1.c	2006-06-21 18:32:46.000000000 +0100
@@ -20,6 +20,8 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
+#define DM_MSG_PREFIX "raid1"
+
 static struct workqueue_struct *_kmirrord_wq;
 static struct work_struct _kmirrord_work;
 
@@ -894,7 +896,7 @@ static struct mirror_set *alloc_context(
 
 	ms = kmalloc(len, GFP_KERNEL);
 	if (!ms) {
-		ti->error = "dm-mirror: Cannot allocate mirror context";
+		ti->error = "Cannot allocate mirror context";
 		return NULL;
 	}
 
@@ -908,7 +910,7 @@ static struct mirror_set *alloc_context(
 	ms->default_mirror = &ms->mirror[DEFAULT_MIRROR];
 
 	if (rh_init(&ms->rh, ms, dl, region_size, ms->nr_regions)) {
-		ti->error = "dm-mirror: Error creating dirty region hash";
+		ti->error = "Error creating dirty region hash";
 		kfree(ms);
 		return NULL;
 	}
@@ -938,14 +940,14 @@ static int get_mirror(struct mirror_set 
 	unsigned long long offset;
 
 	if (sscanf(argv[1], "%llu", &offset) != 1) {
-		ti->error = "dm-mirror: Invalid offset";
+		ti->error = "Invalid offset";
 		return -EINVAL;
 	}
 
 	if (dm_get_device(ti, argv[0], offset, ti->len,
 			  dm_table_get_mode(ti->table),
 			  &ms->mirror[mirror].dev)) {
-		ti->error = "dm-mirror: Device lookup failure";
+		ti->error = "Device lookup failure";
 		return -ENXIO;
 	}
 
@@ -982,30 +984,30 @@ static struct dirty_log *create_dirty_lo
 	struct dirty_log *dl;
 
 	if (argc < 2) {
-		ti->error = "dm-mirror: Insufficient mirror log arguments";
+		ti->error = "Insufficient mirror log arguments";
 		return NULL;
 	}
 
 	if (sscanf(argv[1], "%u", &param_count) != 1) {
-		ti->error = "dm-mirror: Invalid mirror log argument count";
+		ti->error = "Invalid mirror log argument count";
 		return NULL;
 	}
 
 	*args_used = 2 + param_count;
 
 	if (argc < *args_used) {
-		ti->error = "dm-mirror: Insufficient mirror log arguments";
+		ti->error = "Insufficient mirror log arguments";
 		return NULL;
 	}
 
 	dl = dm_create_dirty_log(argv[0], ti, param_count, argv + 2);
 	if (!dl) {
-		ti->error = "dm-mirror: Error creating mirror dirty log";
+		ti->error = "Error creating mirror dirty log";
 		return NULL;
 	}
 
 	if (!_check_region_size(ti, dl->type->get_region_size(dl))) {
-		ti->error = "dm-mirror: Invalid region size";
+		ti->error = "Invalid region size";
 		dm_destroy_dirty_log(dl);
 		return NULL;
 	}
@@ -1039,7 +1041,7 @@ static int mirror_ctr(struct dm_target *
 
 	if (!argc || sscanf(argv[0], "%u", &nr_mirrors) != 1 ||
 	    nr_mirrors < 2 || nr_mirrors > KCOPYD_MAX_REGIONS + 1) {
-		ti->error = "dm-mirror: Invalid number of mirrors";
+		ti->error = "Invalid number of mirrors";
 		dm_destroy_dirty_log(dl);
 		return -EINVAL;
 	}
@@ -1047,7 +1049,7 @@ static int mirror_ctr(struct dm_target *
 	argv++, argc--;
 
 	if (argc != nr_mirrors * 2) {
-		ti->error = "dm-mirror: Wrong number of mirror arguments";
+		ti->error = "Wrong number of mirror arguments";
 		dm_destroy_dirty_log(dl);
 		return -EINVAL;
 	}
Index: linux-2.6.17/drivers/md/dm-round-robin.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-round-robin.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-round-robin.c	2006-06-21 18:32:46.000000000 +0100
@@ -14,6 +14,8 @@
 
 #include <linux/slab.h>
 
+#define DM_MSG_PREFIX "multipath round-robin"
+
 /*-----------------------------------------------------------------
  * Path-handling code, paths are held in lists
  *---------------------------------------------------------------*/
@@ -191,9 +193,9 @@ static int __init dm_rr_init(void)
 	int r = dm_register_path_selector(&rr_ps);
 
 	if (r < 0)
-		DMERR("round-robin: register failed %d", r);
+		DMERR("register failed %d", r);
 
-	DMINFO("dm-round-robin version 1.0.0 loaded");
+	DMINFO("version 1.0.0 loaded");
 
 	return r;
 }
Index: linux-2.6.17/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-snap.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-snap.c	2006-06-21 18:32:46.000000000 +0100
@@ -23,6 +23,8 @@
 #include "dm-bio-list.h"
 #include "kcopyd.h"
 
+#define DM_MSG_PREFIX "snapshots"
+
 /*
  * The percentage increment we will wake up users at
  */
@@ -117,7 +119,7 @@ static int init_origin_hash(void)
 	_origins = kmalloc(ORIGIN_HASH_SIZE * sizeof(struct list_head),
 			   GFP_KERNEL);
 	if (!_origins) {
-		DMERR("Device mapper: Snapshot: unable to allocate memory");
+		DMERR("unable to allocate memory");
 		return -ENOMEM;
 	}
 
@@ -412,7 +414,7 @@ static int snapshot_ctr(struct dm_target
 	int blocksize;
 
 	if (argc < 4) {
-		ti->error = "dm-snapshot: requires exactly 4 arguments";
+		ti->error = "requires exactly 4 arguments";
 		r = -EINVAL;
 		goto bad1;
 	}
@@ -1127,7 +1129,7 @@ static int origin_ctr(struct dm_target *
 	struct dm_dev *dev;
 
 	if (argc != 1) {
-		ti->error = "dm-origin: incorrect number of arguments";
+		ti->error = "origin: incorrect number of arguments";
 		return -EINVAL;
 	}
 
@@ -1236,7 +1238,7 @@ static int __init dm_snapshot_init(void)
 
 	r = dm_register_target(&origin_target);
 	if (r < 0) {
-		DMERR("Device mapper: Origin: register failed %d\n", r);
+		DMERR("Origin target register failed %d", r);
 		goto bad1;
 	}
 
Index: linux-2.6.17/drivers/md/dm-stripe.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-stripe.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-stripe.c	2006-06-21 18:32:46.000000000 +0100
@@ -12,6 +12,8 @@
 #include <linux/bio.h>
 #include <linux/slab.h>
 
+#define DM_MSG_PREFIX "striped"
+
 struct stripe {
 	struct dm_dev *dev;
 	sector_t physical_start;
@@ -78,19 +80,19 @@ static int stripe_ctr(struct dm_target *
 	unsigned int i;
 
 	if (argc < 2) {
-		ti->error = "dm-stripe: Not enough arguments";
+		ti->error = "Not enough arguments";
 		return -EINVAL;
 	}
 
 	stripes = simple_strtoul(argv[0], &end, 10);
 	if (*end) {
-		ti->error = "dm-stripe: Invalid stripe count";
+		ti->error = "Invalid stripe count";
 		return -EINVAL;
 	}
 
 	chunk_size = simple_strtoul(argv[1], &end, 10);
 	if (*end) {
-		ti->error = "dm-stripe: Invalid chunk_size";
+		ti->error = "Invalid chunk_size";
 		return -EINVAL;
 	}
 
@@ -99,19 +101,19 @@ static int stripe_ctr(struct dm_target *
 	 */
 	if (!chunk_size || (chunk_size & (chunk_size - 1)) ||
 	    (chunk_size < (PAGE_SIZE >> SECTOR_SHIFT))) {
-		ti->error = "dm-stripe: Invalid chunk size";
+		ti->error = "Invalid chunk size";
 		return -EINVAL;
 	}
 
 	if (ti->len & (chunk_size - 1)) {
-		ti->error = "dm-stripe: Target length not divisible by "
+		ti->error = "Target length not divisible by "
 		    "chunk size";
 		return -EINVAL;
 	}
 
 	width = ti->len;
 	if (sector_div(width, stripes)) {
-		ti->error = "dm-stripe: Target length not divisible by "
+		ti->error = "Target length not divisible by "
 		    "number of stripes";
 		return -EINVAL;
 	}
@@ -120,14 +122,14 @@ static int stripe_ctr(struct dm_target *
 	 * Do we have enough arguments for that many stripes ?
 	 */
 	if (argc != (2 + 2 * stripes)) {
-		ti->error = "dm-stripe: Not enough destinations "
+		ti->error = "Not enough destinations "
 			"specified";
 		return -EINVAL;
 	}
 
 	sc = alloc_context(stripes);
 	if (!sc) {
-		ti->error = "dm-stripe: Memory allocation for striped context "
+		ti->error = "Memory allocation for striped context "
 		    "failed";
 		return -ENOMEM;
 	}
@@ -149,8 +151,7 @@ static int stripe_ctr(struct dm_target *
 
 		r = get_stripe(ti, sc, i, argv);
 		if (r < 0) {
-			ti->error = "dm-stripe: Couldn't parse stripe "
-				"destination";
+			ti->error = "Couldn't parse stripe destination";
 			while (i--)
 				dm_put_device(ti, sc->stripe[i].dev);
 			kfree(sc);
@@ -227,7 +228,7 @@ int __init dm_stripe_init(void)
 
 	r = dm_register_target(&stripe_target);
 	if (r < 0)
-		DMWARN("striped target registration failed");
+		DMWARN("target registration failed");
 
 	return r;
 }
@@ -235,7 +236,7 @@ int __init dm_stripe_init(void)
 void dm_stripe_exit(void)
 {
 	if (dm_unregister_target(&stripe_target))
-		DMWARN("striped target unregistration failed");
+		DMWARN("target unregistration failed");
 
 	return;
 }
Index: linux-2.6.17/drivers/md/dm-table.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-table.c	2006-06-21 18:32:38.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-table.c	2006-06-21 18:32:46.000000000 +0100
@@ -17,6 +17,8 @@
 #include <linux/mutex.h>
 #include <asm/atomic.h>
 
+#define DM_MSG_PREFIX "table"
+
 #define MAX_DEPTH 16
 #define NODE_SIZE L1_CACHE_BYTES
 #define KEYS_PER_NODE (NODE_SIZE / sizeof(sector_t))
@@ -716,15 +718,14 @@ int dm_table_add_target(struct dm_table 
 	memset(tgt, 0, sizeof(*tgt));
 
 	if (!len) {
-		tgt->error = "zero-length target";
-		DMERR("%s", tgt->error);
+		DMERR("%s: zero-length target", dm_device_name(t->md));
 		return -EINVAL;
 	}
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
-		tgt->error = "unknown target type";
-		DMERR("%s", tgt->error);
+		DMERR("%s: %s: unknown target type", dm_device_name(t->md),
+		      type);
 		return -EINVAL;
 	}
 
@@ -761,7 +762,7 @@ int dm_table_add_target(struct dm_table 
 	return 0;
 
  bad:
-	DMERR("%s", tgt->error);
+	DMERR("%s: %s: %s", dm_device_name(t->md), type, tgt->error);
 	dm_put_target_type(tgt->type);
 	return r;
 }
Index: linux-2.6.17/drivers/md/dm-target.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-target.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-target.c	2006-06-21 18:32:46.000000000 +0100
@@ -12,6 +12,8 @@
 #include <linux/bio.h>
 #include <linux/slab.h>
 
+#define DM_MSG_PREFIX "target"
+
 struct tt_internal {
 	struct target_type tt;
 
Index: linux-2.6.17/drivers/md/dm-zero.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-zero.c	2006-06-21 17:44:40.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-zero.c	2006-06-21 18:32:46.000000000 +0100
@@ -10,13 +10,15 @@
 #include <linux/init.h>
 #include <linux/bio.h>
 
+#define DM_MSG_PREFIX "zero"
+
 /*
  * Construct a dummy mapping that only returns zeros
  */
 static int zero_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	if (argc != 0) {
-		ti->error = "dm-zero: No arguments required";
+		ti->error = "No arguments required";
 		return -EINVAL;
 	}
 
@@ -60,7 +62,7 @@ static int __init dm_zero_init(void)
 	int r = dm_register_target(&zero_target);
 
 	if (r < 0)
-		DMERR("zero: register failed %d", r);
+		DMERR("register failed %d", r);
 
 	return r;
 }
@@ -70,7 +72,7 @@ static void __exit dm_zero_exit(void)
 	int r = dm_unregister_target(&zero_target);
 
 	if (r < 0)
-		DMERR("zero: unregister failed %d", r);
+		DMERR("unregister failed %d", r);
 }
 
 module_init(dm_zero_init)
Index: linux-2.6.17/drivers/md/dm.h
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.h	2006-06-21 18:32:42.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.h	2006-06-21 18:32:46.000000000 +0100
@@ -17,9 +17,10 @@
 #include <linux/hdreg.h>
 
 #define DM_NAME "device-mapper"
-#define DMWARN(f, x...) printk(KERN_WARNING DM_NAME ": " f "\n" , ## x)
-#define DMERR(f, x...) printk(KERN_ERR DM_NAME ": " f "\n" , ## x)
-#define DMINFO(f, x...) printk(KERN_INFO DM_NAME ": " f "\n" , ## x)
+
+#define DMERR(f, arg...) printk(KERN_ERR DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
+#define DMWARN(f, arg...) printk(KERN_WARNING DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
+#define DMINFO(f, arg...) printk(KERN_INFO DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
 
 #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
 			  0 : scnprintf(result + sz, maxlen - sz, x))
Index: linux-2.6.17/include/linux/device-mapper.h
===================================================================
--- linux-2.6.17.orig/include/linux/device-mapper.h	2006-06-21 18:32:38.000000000 +0100
+++ linux-2.6.17/include/linux/device-mapper.h	2006-06-21 18:32:46.000000000 +0100
@@ -176,6 +176,7 @@ int dm_wait_event(struct mapped_device *
 /*
  * Info functions.
  */
+const char *dm_device_name(struct mapped_device *md);
 struct gendisk *dm_disk(struct mapped_device *md);
 int dm_suspended(struct mapped_device *md);
 
Index: linux-2.6.17/drivers/md/dm.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.c	2006-06-21 18:32:42.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.c	2006-06-21 18:32:46.000000000 +0100
@@ -22,6 +22,8 @@
 #include <linux/blktrace_api.h>
 #include <linux/smp_lock.h>
 
+#define DM_MSG_PREFIX "core"
+
 static const char *_name = DM_NAME;
 
 static unsigned int major = 0;
@@ -1156,6 +1158,12 @@ void dm_get(struct mapped_device *md)
 	atomic_inc(&md->holders);
 }
 
+const char *dm_device_name(struct mapped_device *md)
+{
+	return md->name;
+}
+EXPORT_SYMBOL_GPL(dm_device_name);
+
 void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map;
