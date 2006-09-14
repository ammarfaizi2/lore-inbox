Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWINVti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWINVti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWINVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:49:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751231AbWINVtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:49:36 -0400
Date: Thu, 14 Sep 2006 22:49:28 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
       Christophe Saout <christophe@saout.de>
Subject: [PATCH 18/25] dm crypt: add key msg
Message-ID: <20060914214928.GZ3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Milan Broz <mbroz@redhat.com>,
	Christophe Saout <christophe@saout.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

Add the facility to wipe the encryption key from memory
(for example while a laptop is suspended) and reinstate
it later (when the laptop gets resumed).

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Christophe Saout <christophe@saout.de>

Index: linux-2.6.18-rc7/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-crypt.c	2006-09-14 20:11:37.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-crypt.c	2006-09-14 20:20:20.000000000 +0100
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2003 Christophe Saout <christophe@saout.de>
  * Copyright (C) 2004 Clemens Fruhwirth <clemens@endorphin.org>
+ * Copyright (C) 2006 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -21,6 +22,7 @@
 #include "dm.h"
 
 #define DM_MSG_PREFIX "crypt"
+#define MESG_STR(x) x, sizeof(x)
 
 /*
  * per bio private data
@@ -62,6 +64,7 @@ struct crypt_iv_operations {
  * Crypt: maps a linear range of a block device
  * and encrypts / decrypts at the same time.
  */
+enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID };
 struct crypt_config {
 	struct dm_dev *dev;
 	sector_t start;
@@ -83,6 +86,7 @@ struct crypt_config {
 	unsigned int iv_size;
 
 	struct crypto_tfm *tfm;
+	unsigned long flags;
 	unsigned int key_size;
 	u8 key[0];
 };
@@ -503,6 +507,31 @@ static void crypt_encode_key(char *hex, 
 	}
 }
 
+static int crypt_set_key(struct crypt_config *cc, char *key)
+{
+	unsigned key_size = strlen(key) >> 1;
+
+	if (cc->key_size && cc->key_size != key_size)
+		return -EINVAL;
+
+	cc->key_size = key_size; /* initial settings */
+
+	if ((!key_size && strcmp(key, "-")) ||
+	    (key_size && crypt_decode_key(cc->key, key, key_size) < 0))
+		return -EINVAL;
+
+	set_bit(DM_CRYPT_KEY_VALID, &cc->flags);
+
+	return 0;
+}
+
+static int crypt_wipe_key(struct crypt_config *cc)
+{
+	clear_bit(DM_CRYPT_KEY_VALID, &cc->flags);
+	memset(&cc->key, 0, cc->key_size * sizeof(u8));
+	return 0;
+}
+
 /*
  * Construct an encryption mapping:
  * <cipher> <key> <iv_offset> <dev_path> <start>
@@ -536,16 +565,14 @@ static int crypt_ctr(struct dm_target *t
 
 	key_size = strlen(argv[1]) >> 1;
 
-	cc = kmalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
+ 	cc = kzalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
 	if (cc == NULL) {
 		ti->error =
 			"Cannot allocate transparent encryption context";
 		return -ENOMEM;
 	}
 
-	cc->key_size = key_size;
-	if ((!key_size && strcmp(argv[1], "-") != 0) ||
-	    (key_size && crypt_decode_key(cc->key, argv[1], key_size) < 0)) {
+ 	if (crypt_set_key(cc, argv[1])) {
 		ti->error = "Error decoding key";
 		goto bad1;
 	}
@@ -783,13 +810,14 @@ static int crypt_map(struct dm_target *t
 		     union map_info *map_context)
 {
 	struct crypt_config *cc = (struct crypt_config *) ti->private;
-	struct crypt_io *io = mempool_alloc(cc->io_pool, GFP_NOIO);
+	struct crypt_io *io;
 	struct convert_context ctx;
 	struct bio *clone;
 	unsigned int remaining = bio->bi_size;
 	sector_t sector = bio->bi_sector - ti->begin;
 	unsigned int bvec_idx = 0;
 
+	io = mempool_alloc(cc->io_pool, GFP_NOIO);
 	io->target = ti;
 	io->bio = bio;
 	io->first_clone = NULL;
@@ -895,14 +923,71 @@ static int crypt_status(struct dm_target
 	return 0;
 }
 
+static void crypt_postsuspend(struct dm_target *ti)
+{
+	struct crypt_config *cc = ti->private;
+
+	set_bit(DM_CRYPT_SUSPENDED, &cc->flags);
+}
+
+static int crypt_preresume(struct dm_target *ti)
+{
+	struct crypt_config *cc = ti->private;
+
+	if (!test_bit(DM_CRYPT_KEY_VALID, &cc->flags)) {
+		DMERR("aborting resume - crypt key is not set.");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void crypt_resume(struct dm_target *ti)
+{
+	struct crypt_config *cc = ti->private;
+
+	clear_bit(DM_CRYPT_SUSPENDED, &cc->flags);
+}
+
+/* Message interface
+ *	key set <key>
+ *	key wipe
+ */
+static int crypt_message(struct dm_target *ti, unsigned argc, char **argv)
+{
+	struct crypt_config *cc = ti->private;
+
+	if (argc < 2)
+		goto error;
+
+	if (!strnicmp(argv[0], MESG_STR("key"))) {
+		if (!test_bit(DM_CRYPT_SUSPENDED, &cc->flags)) {
+			DMWARN("not suspended during key manipulation.");
+			return -EINVAL;
+		}
+		if (argc == 3 && !strnicmp(argv[1], MESG_STR("set")))
+			return crypt_set_key(cc, argv[2]);
+		if (argc == 2 && !strnicmp(argv[1], MESG_STR("wipe")))
+			return crypt_wipe_key(cc);
+	}
+
+error:
+	DMWARN("unrecognised message received.");
+	return -EINVAL;
+}
+
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version= {1, 1, 0},
+	.version= {1, 2, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
 	.map    = crypt_map,
 	.status = crypt_status,
+	.postsuspend = crypt_postsuspend,
+	.preresume = crypt_preresume,
+	.resume = crypt_resume,
+	.message = crypt_message,
 };
 
 static int __init dm_crypt_init(void)
