Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVAKRPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVAKRPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAKRMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:12:21 -0500
Received: from maxipes.logix.cz ([217.11.251.249]:33160 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S262850AbVAKRIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:08:42 -0500
Date: Tue, 11 Jan 2005 18:08:42 +0100 (CET)
From: Michal Ludvig <michal@logix.cz>
To: "David S. Miller" <davem@davemloft.net>
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PadLock processing multiple blocks at a time
In-Reply-To: <Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
Message-ID: <Pine.LNX.4.61.0501111808170.7104@maxipes.logix.cz>
References: <Xine.LNX.4.44.0411301009560.11945-100000@thoron.boston.redhat.com>
 <Pine.LNX.4.61.0411301722270.4409@maxipes.logix.cz>
 <20041130222442.7b0f4f67.davem@davemloft.net> <Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# 
# Update to padlock-aes.c that enables processing of the whole 
# buffer of data at once with the given chaining mode (e.g. CBC).
# 
# Signed-off-by: Michal Ludvig <michal@logix.cz>
# 
Index: linux-2.6.10/drivers/crypto/padlock-aes.c
===================================================================
--- linux-2.6.10.orig/drivers/crypto/padlock-aes.c	2005-01-07 17:26:42.000000000 +0100
+++ linux-2.6.10/drivers/crypto/padlock-aes.c	2005-01-10 17:59:17.000000000 +0100
@@ -369,19 +369,54 @@ aes_set_key(void *ctx_arg, const uint8_t
 
 /* ====== Encryption/decryption routines ====== */
 
-/* This is the real call to PadLock. */
-static inline void
+/* These are the real calls to PadLock. */
+static inline void *
 padlock_xcrypt_ecb(uint8_t *input, uint8_t *output, uint8_t *key,
-		   void *control_word, uint32_t count)
+		   uint8_t *iv, void *control_word, uint32_t count)
 {
 	asm volatile ("pushfl; popfl");		/* enforce key reload. */
 	asm volatile (".byte 0xf3,0x0f,0xa7,0xc8"	/* rep xcryptecb */
 		      : "+S"(input), "+D"(output)
 		      : "d"(control_word), "b"(key), "c"(count));
+	return NULL;
+}
+
+static inline void *
+padlock_xcrypt_cbc(uint8_t *input, uint8_t *output, uint8_t *key,
+		   uint8_t *iv, void *control_word, uint32_t count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xd0"	/* rep xcryptcbc */
+		      : "=m"(*output), "+S"(input), "+D"(output), "+a"(iv)
+		      : "d"(control_word), "b"(key), "c"(count));
+	return iv;
+}
+
+static inline void *
+padlock_xcrypt_cfb(uint8_t *input, uint8_t *output, uint8_t *key,
+		   uint8_t *iv, void *control_word, uint32_t count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xe0"	/* rep xcryptcfb */
+		      : "=m"(*output), "+S"(input), "+D"(output), "+a"(iv)
+		      : "d"(control_word), "b"(key), "c"(count));
+	return iv;
+}
+
+static inline void *
+padlock_xcrypt_ofb(uint8_t *input, uint8_t *output, uint8_t *key,
+		   uint8_t *iv, void *control_word, uint32_t count)
+{
+	asm volatile ("pushfl; popfl");		/* enforce key reload. */
+	asm volatile (".byte 0xf3,0x0f,0xa7,0xe8"	/* rep xcryptofb */
+		      : "=m"(*output), "+S"(input), "+D"(output), "+a"(iv)
+		      : "d"(control_word), "b"(key), "c"(count));
+	return iv;
 }
 
 static void
-aes_padlock(void *ctx_arg, uint8_t *out_arg, const uint8_t *in_arg, int encdec)
+aes_padlock(void *ctx_arg, uint8_t *out_arg, const uint8_t *in_arg,
+	    uint8_t *iv_arg, size_t nbytes, int encdec, int mode)
 {
 	/* Don't blindly modify this structure - the items must 
 	   fit on 16-Bytes boundaries! */
@@ -419,21 +454,126 @@ aes_padlock(void *ctx_arg, uint8_t *out_
 	else
 		key = ctx->D;
 	
-	memcpy(data->buf, in_arg, AES_BLOCK_SIZE);
-	padlock_xcrypt_ecb(data->buf, data->buf, key, &data->cword, 1);
-	memcpy(out_arg, data->buf, AES_BLOCK_SIZE);
+	if (nbytes == AES_BLOCK_SIZE) {
+		/* Processing one block only => ECB is enough */
+		memcpy(data->buf, in_arg, AES_BLOCK_SIZE);
+		padlock_xcrypt_ecb(data->buf, data->buf, key, NULL,
+				   &data->cword, 1);
+		memcpy(out_arg, data->buf, AES_BLOCK_SIZE);
+	} else {
+		/* Processing multiple blocks at once */
+		uint8_t *in, *out, *iv;
+		int gfp = in_atomic() ? GFP_ATOMIC : GFP_KERNEL;
+		void *index = NULL;
+
+		if (unlikely(((long)in_arg) & 0x0F)) {
+			in = crypto_aligned_kmalloc(nbytes, gfp, 16, &index);
+			memcpy(in, in_arg, nbytes);
+		}
+		else
+			in = (uint8_t*)in_arg;
+
+		if (unlikely(((long)out_arg) & 0x0F)) {
+			if (index)
+				out = in;	/* xcrypt can work "in place" */
+			else
+				out = crypto_aligned_kmalloc(nbytes, gfp, 16,
+							     &index);
+		}
+		else
+			out = out_arg;
+
+		/* Always make a local copy of IV - xcrypt may change it! */
+		iv = data->buf;
+		if (iv_arg)
+			memcpy(iv, iv_arg, AES_BLOCK_SIZE);
+
+		switch (mode) {
+			case CRYPTO_TFM_MODE_ECB:
+				iv = padlock_xcrypt_ecb(in, out, key, iv,
+							&data->cword,
+							nbytes/AES_BLOCK_SIZE);
+				break;
+
+			case CRYPTO_TFM_MODE_CBC:
+				iv = padlock_xcrypt_cbc(in, out, key, iv,
+							&data->cword,
+							nbytes/AES_BLOCK_SIZE);
+				break;
+
+			case CRYPTO_TFM_MODE_CFB:
+				iv = padlock_xcrypt_cfb(in, out, key, iv,
+							&data->cword,
+							nbytes/AES_BLOCK_SIZE);
+				break;
+
+			case CRYPTO_TFM_MODE_OFB:
+				iv = padlock_xcrypt_ofb(in, out, key, iv,
+							&data->cword,
+							nbytes/AES_BLOCK_SIZE);
+				break;
+
+			default:
+				BUG();
+		}
+
+		/* Back up IV */
+		if (iv && iv_arg)
+			memcpy(iv_arg, iv, AES_BLOCK_SIZE);
+
+		/* Copy the 16-Byte aligned output to the caller's buffer. */
+		if (out != out_arg)
+			memcpy(out_arg, out, nbytes);
+
+		if (index)
+			kfree(index);
+	}
+}
+
+static void
+aes_padlock_ecb(void *ctx, uint8_t *dst, const uint8_t *src,
+		uint8_t *iv, size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, NULL, nbytes, encdec,
+		    CRYPTO_TFM_MODE_ECB);
+}
+
+static void
+aes_padlock_cbc(void *ctx, uint8_t *dst, const uint8_t *src, uint8_t *iv,
+		size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    CRYPTO_TFM_MODE_CBC);
+}
+
+static void
+aes_padlock_cfb(void *ctx, uint8_t *dst, const uint8_t *src, uint8_t *iv,
+		size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    CRYPTO_TFM_MODE_CFB);
+}
+
+static void
+aes_padlock_ofb(void *ctx, uint8_t *dst, const uint8_t *src, uint8_t *iv,
+		size_t nbytes, int encdec, int inplace)
+{
+	aes_padlock(ctx, dst, src, iv, nbytes, encdec,
+		    CRYPTO_TFM_MODE_OFB);
 }
 
 static void
 aes_encrypt(void *ctx_arg, uint8_t *out, const uint8_t *in)
 {
-	aes_padlock(ctx_arg, out, in, CRYPTO_DIR_ENCRYPT);
+	aes_padlock(ctx_arg, out, in, NULL, AES_BLOCK_SIZE,
+		    CRYPTO_DIR_ENCRYPT, CRYPTO_TFM_MODE_ECB);
 }
 
 static void
 aes_decrypt(void *ctx_arg, uint8_t *out, const uint8_t *in)
 {
-	aes_padlock(ctx_arg, out, in, CRYPTO_DIR_DECRYPT);
+	aes_padlock(ctx_arg, out, in, NULL, AES_BLOCK_SIZE,
+		    CRYPTO_DIR_DECRYPT, CRYPTO_TFM_MODE_ECB);
 }
 
 static struct crypto_alg aes_alg = {
@@ -454,9 +594,25 @@ static struct crypto_alg aes_alg = {
 	}
 };
 
+static int disable_multiblock = 0;
+MODULE_PARM(disable_multiblock, "i");
+MODULE_PARM_DESC(disable_multiblock,
+		 "Disable encryption of whole multiblock buffers.");
+
 int __init padlock_init_aes(void)
 {
-	printk(KERN_NOTICE PFX "Using VIA PadLock ACE for AES algorithm.\n");
+	if (!disable_multiblock) {
+		aes_alg.cra_u.cipher.cia_max_nbytes = (size_t)-1;
+		aes_alg.cra_u.cipher.cia_req_align  = 16;
+		aes_alg.cra_u.cipher.cia_ecb        = aes_padlock_ecb;
+		aes_alg.cra_u.cipher.cia_cbc        = aes_padlock_cbc;
+		aes_alg.cra_u.cipher.cia_cfb        = aes_padlock_cfb;
+		aes_alg.cra_u.cipher.cia_ofb        = aes_padlock_ofb;
+	}
+
+	printk(KERN_NOTICE PFX 
+		"Using VIA PadLock ACE for AES algorithm%s.\n", 
+		disable_multiblock ? "" : " (multiblock)");
 
 	gen_tabs();
 	return crypto_register_alg(&aes_alg);
