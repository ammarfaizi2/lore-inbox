Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUIUNi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUIUNi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUIUNi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:38:28 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:33959 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S267686AbUIUNiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:38:18 -0400
Date: Tue, 21 Sep 2004 09:36:28 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux-kernel@vger.kernel.org
Cc: cryptoapi@lists.logix.cz, jmorris@redhat.com
Subject: [PATCH] Whirlpool-256 and -384
Message-ID: <20040921133627.GJ14119@certainkey.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a patch for the 2.6.9-rc2 tree.

Whirlpool is a 512bit hash function.  This patch truncates the output to 256
and 384 bits for "whirlpool-256" and "whirlpool-384" respectivly.

Truncating of hash is standard pracatice in seen in 2nd generation of SHA
functions as one example.

There was minor flaw in whirlpool.c's update function where
WHIRLPOOL_DIGEST_SIZE was used inplace of WHIRLPOOL_BLOCK_SIZE.  This isn't a
big deal since they are identical values for DIGESTSIZE=512bits.  I have fix
this in the following patch.

tcrypt.c and tcrypt.h have been updated as well.

JLC

--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="whirlpool_256-384.patch"

diff -Nur old/crypto/tcrypt.c new/crypto/tcrypt.c
--- old/crypto/tcrypt.c	2004-09-21 09:26:12.359501680 -0400
+++ new/crypto/tcrypt.c	2004-09-21 09:15:19.470755856 -0400
@@ -63,7 +63,7 @@
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
 	"arc4", "michael_mic", "deflate", "crc32c", "tea", "xtea",
-	"whirlpool", NULL
+	"whirlpool", "whirlpool-384", "whirlpool-256", NULL
 };
 
 static void
@@ -683,6 +683,8 @@
 		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
 		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
 		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("whirlpool-384", whirlpool384_tv_template, WHIRLPOOL384_TEST_VECTORS);
+		test_hash("whirlpool-256", whirlpool256_tv_template, WHIRLPOOL256_TEST_VECTORS);
 		test_deflate();
 		test_crc32c();
 #ifdef CONFIG_CRYPTO_HMAC
@@ -798,6 +800,14 @@
 		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
 		break;
 
+	case 23:
+		test_hash("whirlpool-384", whirlpool384_tv_template, WHIRLPOOL384_TEST_VECTORS);
+		break;
+
+	case 24:
+		test_hash("whirlpool-256", whirlpool256_tv_template, WHIRLPOOL256_TEST_VECTORS);
+		break;
+
 #ifdef CONFIG_CRYPTO_HMAC
 	case 100:
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
diff -Nur old/crypto/tcrypt.h new/crypto/tcrypt.h
--- old/crypto/tcrypt.h	2004-09-21 09:25:38.213692632 -0400
+++ new/crypto/tcrypt.h	2004-09-21 09:25:07.590348088 -0400
@@ -308,6 +308,10 @@
  * submission
  */
 #define WHIRLPOOL_TEST_VECTORS 8
+#define WHIRLPOOL384_TEST_VECTORS 8
+#define whirlpool384_tv_template whirlpool_tv_template
+#define WHIRLPOOL256_TEST_VECTORS 8
+#define whirlpool256_tv_template whirlpool_tv_template
 
 struct hash_testvec whirlpool_tv_template[] = {
 	{
diff -Nur old/crypto/whirlpool.c new/crypto/whirlpool.c
--- old/crypto/whirlpool.c	2004-09-21 09:30:05.534053760 -0400
+++ new/crypto/whirlpool.c	2004-09-21 09:15:19.471755704 -0400
@@ -28,6 +28,8 @@
 #include <linux/crypto.h>
 
 #define WHIRLPOOL_DIGEST_SIZE 64
+#define WHIRLPOOL384_DIGEST_SIZE 48
+#define WHIRLPOOL256_DIGEST_SIZE 32
 #define WHIRLPOOL_BLOCK_SIZE  64
 #define WHIRLPOOL_LENGTHBYTES 32
 
@@ -1112,7 +1114,7 @@
 		((source[sourcePos + 1] & 0xff) >> (8 - sourceGap));
 		buffer[bufferPos++] |= (u8)(b >> bufferRem);
 		bufferBits += 8 - bufferRem;
-		if (bufferBits == WHIRLPOOL_DIGEST_SIZE * 8) {
+		if (bufferBits == WHIRLPOOL_BLOCK_SIZE * 8) {
 			whirlpool_process_buffer(wctx);
 			bufferBits = bufferPos = 0;
 		}
@@ -1135,7 +1137,7 @@
 		bufferPos++;
 		bufferBits += 8 - bufferRem;
 		bits_len -= 8 - bufferRem;
-		if (bufferBits == WHIRLPOOL_DIGEST_SIZE * 8) {
+		if (bufferBits == WHIRLPOOL_BLOCK_SIZE * 8) {
 			whirlpool_process_buffer(wctx);
 			bufferBits = bufferPos = 0;
 		}
@@ -1149,7 +1151,7 @@
 
 }
 
-static void whirlpool_final(void *ctx, u8 *out)
+static void whirlpool_final_(void *ctx, u8 *out, int digestSize)
 {
 	struct whirlpool_ctx *wctx = ctx;
 	int i;
@@ -1178,7 +1180,7 @@
 	memcpy(&buffer[WHIRLPOOL_BLOCK_SIZE - WHIRLPOOL_LENGTHBYTES],
 		   bitLength, WHIRLPOOL_LENGTHBYTES);
 	whirlpool_process_buffer(wctx);
-	for (i = 0; i < WHIRLPOOL_DIGEST_SIZE/8; i++) {
+	for (i = 0; i < digestSize/8; i++) {
 
 		digest[0] = (u8)(wctx->hash[i] >> 56);
 		digest[1] = (u8)(wctx->hash[i] >> 48);
@@ -1195,7 +1197,22 @@
 	wctx->bufferPos    = bufferPos;
 }
 
-static struct crypto_alg alg = {
+static void whirlpool_final(void *ctx, u8 *out)
+{
+	whirlpool_final_(ctx, out, WHIRLPOOL_DIGEST_SIZE);
+}
+
+static void whirlpool384_final(void *ctx, u8 *out)
+{
+	whirlpool_final_(ctx, out, WHIRLPOOL384_DIGEST_SIZE);
+}
+
+static void whirlpool256_final(void *ctx, u8 *out)
+{
+	whirlpool_final_(ctx, out, WHIRLPOOL256_DIGEST_SIZE);
+}
+
+static struct crypto_alg wp512 = {
 	.cra_name = "whirlpool",
 	.cra_flags = CRYPTO_ALG_TYPE_DIGEST,
 	.cra_blocksize = WHIRLPOOL_BLOCK_SIZE,
@@ -1209,16 +1226,63 @@
 	.dia_final = whirlpool_final } }
 };
 
+static struct crypto_alg wp384 = {
+	.cra_name = "whirlpool-384",
+	.cra_flags = CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize = WHIRLPOOL_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct whirlpool_ctx),
+	.cra_module = THIS_MODULE,
+	.cra_list = LIST_HEAD_INIT(alg.cra_list),
+	.cra_u = { .digest = {
+	.dia_digestsize = WHIRLPOOL384_DIGEST_SIZE,
+	.dia_init = whirlpool_init,
+	.dia_update = whirlpool_update,
+	.dia_final = whirlpool384_final } }
+};
+
+static struct crypto_alg wp256 = {
+	.cra_name = "whirlpool-256",
+	.cra_flags = CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize = WHIRLPOOL_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct whirlpool_ctx),
+	.cra_module = THIS_MODULE,
+	.cra_list = LIST_HEAD_INIT(alg.cra_list),
+	.cra_u = { .digest = {
+	.dia_digestsize = WHIRLPOOL256_DIGEST_SIZE,
+	.dia_init = whirlpool_init,
+	.dia_update = whirlpool_update,
+	.dia_final = whirlpool256_final } }
+};
+
 static int __init init(void)
 {
-	return crypto_register_alg(&alg);
+	int ret;
+	if ((ret = crypto_register_alg(&wp512)) < 0 ) {
+		goto err;
+	}
+	if ((ret = crypto_register_alg(&wp384)) < 0 ) {
+		crypto_unregister_alg(&wp512);
+		goto err;
+	}
+	if ((ret = crypto_register_alg(&wp256)) < 0 ) {
+		crypto_unregister_alg(&wp512);
+		crypto_unregister_alg(&wp384);
+		goto err;
+	}
+err:
+	return ret;
 }
 
 static void __exit fini(void)
 {
-	crypto_unregister_alg(&alg);
+	crypto_unregister_alg(&wp512);
+	crypto_unregister_alg(&wp384);
+	crypto_unregister_alg(&wp256);
 }
 
+MODULE_ALIAS("whirlpool-384");
+MODULE_ALIAS("whirlpool-256");
+
 module_init(init);
 module_exit(fini);
 

--udcq9yAoWb9A4FsZ--
