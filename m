Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269922AbUJSTAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269922AbUJSTAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269087AbUJSSWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:22:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5515 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270063AbUJSRtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:49:24 -0400
Date: Tue, 19 Oct 2004 18:49:20 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1/1: device-mapper: dm-crypt tidy-ups
Message-ID: <20041019174920.GC6420@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small dm-crypt tidy-ups:
- Use unsigned consistently
- Simplify crypt_iv_plain memset
- Use DMEMIT macro
 
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
Signed-Off-By: Christophe Saout <christophe@saout.de>
--- diff/drivers/md/dm-crypt.c	2004-05-19 22:11:47.000000000 +0100
+++ source/drivers/md/dm-crypt.c	2004-10-19 16:54:13.000000000 +0100
@@ -40,8 +40,8 @@
 	struct bio *bio_out;
 	unsigned int offset_in;
 	unsigned int offset_out;
-	int idx_in;
-	int idx_out;
+	unsigned int idx_in;
+	unsigned int idx_out;
 	sector_t sector;
 	int write;
 };
@@ -64,11 +64,12 @@
 	/*
 	 * crypto related data
 	 */
-	struct crypto_tfm *tfm;
-	sector_t iv_offset;
 	int (*iv_generator)(struct crypt_config *cc, u8 *iv, sector_t sector);
-	int iv_size;
-	int key_size;
+	sector_t iv_offset;
+	unsigned int iv_size;
+
+	struct crypto_tfm *tfm;
+	unsigned int key_size;
 	u8 key[0];
 };
 
@@ -97,10 +98,8 @@
  */
 static int crypt_iv_plain(struct crypt_config *cc, u8 *iv, sector_t sector)
 {
+	memset(iv, 0, cc->iv_size);
 	*(u32 *)iv = cpu_to_le32(sector & 0xffffffff);
-	if (cc->iv_size > sizeof(u32) / sizeof(u8))
-		memset(iv + (sizeof(u32) / sizeof(u8)), 0,
-		       cc->iv_size - (sizeof(u32) / sizeof(u8)));
 
 	return 0;
 }
@@ -200,13 +199,13 @@
  */
 static struct bio *
 crypt_alloc_buffer(struct crypt_config *cc, unsigned int size,
-                   struct bio *base_bio, int *bio_vec_idx)
+                   struct bio *base_bio, unsigned int *bio_vec_idx)
 {
 	struct bio *bio;
-	int nr_iovecs = dm_div_up(size, PAGE_SIZE);
+	unsigned int nr_iovecs = dm_div_up(size, PAGE_SIZE);
 	int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
-	int flags = current->flags;
-	int i;
+	unsigned long flags = current->flags;
+	unsigned int i;
 
 	/*
 	 * Tell VM to act less aggressively and fail earlier.
@@ -280,9 +279,8 @@
 static void crypt_free_buffer_pages(struct crypt_config *cc,
                                     struct bio *bio, unsigned int bytes)
 {
-	unsigned int start, end;
+	unsigned int i, start, end;
 	struct bio_vec *bv;
-	int i;
 
 	/*
 	 * This is ugly, but Jens Axboe thinks that using bi_idx in the
@@ -366,11 +364,11 @@
 /*
  * Decode key from its hex representation
  */
-static int crypt_decode_key(u8 *key, char *hex, int size)
+static int crypt_decode_key(u8 *key, char *hex, unsigned int size)
 {
 	char buffer[3];
 	char *endp;
-	int i;
+	unsigned int i;
 
 	buffer[2] = '\0';
 
@@ -393,9 +391,9 @@
 /*
  * Encode key into its hex representation
  */
-static void crypt_encode_key(char *hex, u8 *key, int size)
+static void crypt_encode_key(char *hex, u8 *key, unsigned int size)
 {
-	int i;
+	unsigned int i;
 
 	for(i = 0; i < size; i++) {
 		sprintf(hex, "%02x", *key);
@@ -415,8 +413,8 @@
 	char *tmp;
 	char *cipher;
 	char *mode;
-	int crypto_flags;
-	int key_size;
+	unsigned int crypto_flags;
+	unsigned int key_size;
 
 	if (argc != 5) {
 		ti->error = PFX "Not enough arguments";
@@ -577,7 +575,8 @@
 
 static inline struct bio *
 crypt_clone(struct crypt_config *cc, struct crypt_io *io, struct bio *bio,
-            sector_t sector, int *bvec_idx, struct convert_context *ctx)
+            sector_t sector, unsigned int *bvec_idx,
+            struct convert_context *ctx)
 {
 	struct bio *clone;
 
@@ -630,7 +629,7 @@
 	struct bio *clone;
 	unsigned int remaining = bio->bi_size;
 	sector_t sector = bio->bi_sector - ti->begin;
-	int bvec_idx = 0;
+	unsigned int bvec_idx = 0;
 
 	io->target = ti;
 	io->bio = bio;
@@ -693,7 +692,7 @@
 	char buffer[32];
 	const char *cipher;
 	const char *mode = NULL;
-	int offset;
+	unsigned int sz = 0;
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -714,25 +713,23 @@
 			BUG();
 		}
 
-		snprintf(result, maxlen, "%s-%s ", cipher, mode);
-		offset = strlen(result);
+		DMEMIT("%s-%s ", cipher, mode);
 
 		if (cc->key_size > 0) {
-			if ((maxlen - offset) < ((cc->key_size << 1) + 1))
+			if ((maxlen - sz) < ((cc->key_size << 1) + 1))
 				return -ENOMEM;
 
-			crypt_encode_key(result + offset, cc->key, cc->key_size);
-			offset += cc->key_size << 1;
+			crypt_encode_key(result + sz, cc->key, cc->key_size);
+			sz += cc->key_size << 1;
 		} else {
-			if (offset >= maxlen)
+			if (sz >= maxlen)
 				return -ENOMEM;
-			result[offset++] = '-';
+			result[sz++] = '-';
 		}
 
 		format_dev_t(buffer, cc->dev->bdev->bd_dev);
-		snprintf(result + offset, maxlen - offset, " " SECTOR_FORMAT
-		         " %s " SECTOR_FORMAT, cc->iv_offset,
-		         buffer, cc->start);
+		DMEMIT(" " SECTOR_FORMAT " %s " SECTOR_FORMAT,
+		       cc->iv_offset, buffer, cc->start);
 		break;
 	}
 	return 0;
