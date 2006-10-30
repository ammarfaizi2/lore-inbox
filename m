Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWJ3Xfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWJ3Xfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWJ3Xfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:35:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:7578 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161339AbWJ3Xfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:35:52 -0500
Date: Mon, 30 Oct 2006 17:35:29 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com,
       Jeff Garzik <jeff@garzik.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/6] eCryptfs: Hash code to new crypto API
Message-ID: <20061030233529.GA21515@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233209.GC3458@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update eCryptfs hash code to the new kernel crypto API.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   36 +++++++++++++++++++++---------------
 fs/ecryptfs/ecryptfs_kernel.h |    7 ++++---
 2 files changed, 25 insertions(+), 18 deletions(-)

33eaa8582847bd8cef8b69537bee03f91fa5a28b
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 82e7d02..f14c5a3 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -94,25 +94,31 @@ static int ecryptfs_calculate_md5(char *
 				  struct ecryptfs_crypt_stat *crypt_stat,
 				  char *src, int len)
 {
-	int rc = 0;
 	struct scatterlist sg;
+	struct hash_desc desc = {
+		.tfm = crypt_stat->hash_tfm,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
+	};
+	int rc = 0;
 
-	mutex_lock(&crypt_stat->cs_md5_tfm_mutex);
+	mutex_lock(&crypt_stat->cs_hash_tfm_mutex);
 	sg_init_one(&sg, (u8 *)src, len);
-	if (!crypt_stat->md5_tfm) {
-		crypt_stat->md5_tfm =
-			crypto_alloc_tfm("md5", CRYPTO_TFM_REQ_MAY_SLEEP);
-		if (!crypt_stat->md5_tfm) {
-			rc = -ENOMEM;
+	if (!desc.tfm) {
+		desc.tfm = crypto_alloc_hash(ECRYPTFS_DEFAULT_HASH, 0,
+					     CRYPTO_ALG_ASYNC);
+		if (IS_ERR(desc.tfm)) {
+			rc = PTR_ERR(desc.tfm);
 			ecryptfs_printk(KERN_ERR, "Error attempting to "
-					"allocate crypto context\n");
+					"allocate crypto context; rc = [%d]\n",
+					rc);
 			goto out;
 		}
+		crypt_stat->hash_tfm = desc.tfm;
 	}
-	crypto_digest_init(crypt_stat->md5_tfm);
-	crypto_digest_update(crypt_stat->md5_tfm, &sg, 1);
-	crypto_digest_final(crypt_stat->md5_tfm, dst);
-	mutex_unlock(&crypt_stat->cs_md5_tfm_mutex);
+	crypto_hash_init(&desc);
+	crypto_hash_update(&desc, &sg, len);
+	crypto_hash_final(&desc, dst);
+	mutex_unlock(&crypt_stat->cs_hash_tfm_mutex);
 out:
 	return rc;
 }
@@ -178,7 +184,7 @@ ecryptfs_init_crypt_stat(struct ecryptfs
 	memset((void *)crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 	mutex_init(&crypt_stat->cs_mutex);
 	mutex_init(&crypt_stat->cs_tfm_mutex);
-	mutex_init(&crypt_stat->cs_md5_tfm_mutex);
+	mutex_init(&crypt_stat->cs_hash_tfm_mutex);
 	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_STRUCT_INITIALIZED);
 }
 
@@ -192,8 +198,8 @@ void ecryptfs_destruct_crypt_stat(struct
 {
 	if (crypt_stat->tfm)
 		crypto_free_tfm(crypt_stat->tfm);
-	if (crypt_stat->md5_tfm)
-		crypto_free_tfm(crypt_stat->md5_tfm);
+	if (crypt_stat->hash_tfm)
+		crypto_free_hash(crypt_stat->hash_tfm);
 	memset(crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 }
 
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4112df9..840aa01 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -175,6 +175,7 @@ #define ECRYPTFS_FILE_SIZE_BYTES 8
 #define ECRYPTFS_DEFAULT_CIPHER "aes"
 #define ECRYPTFS_DEFAULT_KEY_BYTES 16
 #define ECRYPTFS_DEFAULT_CHAINING_MODE CRYPTO_TFM_MODE_CBC
+#define ECRYPTFS_DEFAULT_HASH "md5"
 #define ECRYPTFS_TAG_3_PACKET_TYPE 0x8C
 #define ECRYPTFS_TAG_11_PACKET_TYPE 0xED
 #define MD5_DIGEST_SIZE 16
@@ -205,14 +206,14 @@ #define ECRYPTFS_KEY_VALID          0x00
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
 	struct crypto_tfm *tfm;
-	struct crypto_tfm *md5_tfm; /* Crypto context for generating
-				     * the initialization vectors */
+	struct crypto_hash *hash_tfm; /* Crypto context for generating
+				       * the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
 	unsigned char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
 	struct mutex cs_tfm_mutex;
-	struct mutex cs_md5_tfm_mutex;
+	struct mutex cs_hash_tfm_mutex;
 	struct mutex cs_mutex;
 };
 
-- 
1.3.3

