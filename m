Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUBTTDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUBTTDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:03:37 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:9177 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261254AbUBTTDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:03:32 -0500
Date: Fri, 20 Feb 2004 19:53:41 +0100
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@intercode.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040220185340.GA14358@leto.cs.pocnet.net>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220171427.GD9266@certainkey.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 12:14:27PM -0500, Jean-Luc Cooke wrote:

> > > It simply hashes the sector number and the key and uses it as IV.
> > > 
> > > You can specify the encryption mode as "cipher-digest" like aes-md5 or
> > > serpent-sha1 or some other combination.
> 
> As for naming the cipher-hash as "aes-sha256", why not just go all the way
> and specify the mode of operation as well?
> 
> cipher-hash-modeop example: aes-sha256-cbc

The plan was to du <cipher>-<iv mode> where <iv mode> can be
ecb (well, no IV at all), plain (unhashed sector number) or a
digest (hmac_key sector number). CBC mode is implicit when you
have some kind of IV generation. Everything else doesn't make
sense and would be redundant. CFB and CTR are not implemented
by cryptoloop BTW.

> As for hashing the hey etc.  You should be using HMAC for that.
>   Christophe - would you like to change your patch to use HMACs?

Yes, I alread got that suggestion.

This attached patch does this, along with some cleanups.

The crypto_hmac_init part could be done in the dm target constructor
once and then call crypto_hmac_update and crypto_hmac_final in the
iv_generator but this would require some cryptoapi hacking which I'm
not too happy about. I would like to make a copy of the tfm (including
the private context) on the stack and then operate on that copy for
crypto_hmac_update and crypto_hmac_final.

Can I have a function to return the tfm size so I can do a memcpy
to a variable on the stack? I could get rid of the mutex too then.

(in case you're wondering, crypto_hmac calls crypto_hmac_init,
crypto_hmac_update and crypto_hmac_final)


--- linux.orig/drivers/md/dm-crypt.c	2004-02-20 19:36:50.363184760 +0100
+++ linux/drivers/md/dm-crypt.c	2004-02-20 19:36:58.265983352 +0100
@@ -107,16 +107,10 @@
 static int crypt_iv_digest(struct crypt_config *cc, u8 *iv, sector_t sector)
 {
 	static DECLARE_MUTEX(tfm_mutex);
-	struct scatterlist sg[2] = {
-		{
-			.page = virt_to_page(iv),
-			.offset = offset_in_page(iv),
-			.length = sizeof(u64) / sizeof(u8)
-		}, {
-			.page = virt_to_page(cc->key),
-			.offset = offset_in_page(cc->key),
-			.length = cc->key_size
-		}
+	struct scatterlist sg = {
+		.page = virt_to_page(iv),
+		.offset = offset_in_page(iv),
+		.length = sizeof(u64) / sizeof(u8)
 	};
 	int i;
 
@@ -124,7 +118,8 @@
 
 	/* digests use the context in the tfm, sigh */
 	down(&tfm_mutex);
-	crypto_digest_digest(cc->digest, sg, 2, iv);
+	crypto_hmac(cc->digest, cc->key, (unsigned int *)&cc->key_size,
+	            &sg, 1, iv);
 	up(&tfm_mutex);
 
 	for(i = cc->digest_size; i < cc->iv_size; i += cc->digest_size)
@@ -504,8 +499,8 @@
 		goto bad1;
 	}
 
-	if (tfm->crt_u.cipher.cit_decrypt_iv &&
-	    tfm->crt_u.cipher.cit_encrypt_iv) {
+	if (tfm->crt_cipher.cit_decrypt_iv &&
+	    tfm->crt_cipher.cit_encrypt_iv) {
 		/* at least a sector number should fit in our buffer */
 		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm), 
 		                  (unsigned int)(sizeof(u64) / sizeof(u8)));
@@ -540,7 +535,7 @@
 		goto bad4;
 	}
 
-	if (tfm->crt_u.cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
+	if (tfm->crt_cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
 		ti->error = "dm-crypt: Error setting key";
 		goto bad4;
 	}
@@ -737,19 +732,12 @@
 	case STATUSTYPE_TABLE:
 		cipher = crypto_tfm_alg_name(cc->cipher);
 
-		switch(cc->cipher->crt_u.cipher.cit_mode) {
-		case CRYPTO_TFM_MODE_CBC:
-			if (cc->digest)
-				mode = crypto_tfm_alg_name(cc->digest);
-			else
-				mode = "plain";
-			break;
-		case CRYPTO_TFM_MODE_ECB:
+		if (!cc->iv_generator)
 			mode = "ecb";
-			break;
-		default:
-			BUG();
-		}
+		else if (!cc->digest)
+			mode = "plain";
+		else
+			mode = crypto_tfm_alg_name(cc->digest);
 
 		snprintf(result, maxlen, "%s-%s ", cipher, mode);
 		offset = strlen(result);
