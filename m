Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWIWXa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWIWXa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 19:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWIWXa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 19:30:29 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:14091 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750916AbWIWXa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 19:30:28 -0400
Date: Sun, 24 Sep 2006 09:30:19 +1000
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH]: Fix ALIGN() macro
Message-ID: <20060923233019.GA6779@gondor.apana.org.au>
References: <20060922.223136.41635862.davem@davemloft.net> <20060923124633.GA2567@gondor.apana.org.au> <20060923125458.GA2682@gondor.apana.org.au> <20060923144041.GA3540@gondor.apana.org.au> <0C3FEC03-29A8-49B0-9D12-BBFA4AE99A78@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C3FEC03-29A8-49B0-9D12-BBFA4AE99A78@mac.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 04:36:33PM -0400, Kyle Moffett wrote:
>
> Quick question:  does "crypto_hash_init()" ever return anything other  
> than 0 or 1?  If so this is a subtle bug, as "unlikely()" is  
> implemented like this:

Good point.  It's meant to be an errno value so this is a bug.

[CRYPTO] hmac: Fix error truncation by unlikely()

The error return values are truncated by unlikely so we need to
save it first.  Thanks to Kyle Moffett for spotting this.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/crypto/hmac.c b/crypto/hmac.c
index d52b234..b521bcd 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -92,13 +92,17 @@ static int hmac_init(struct hash_desc *p
 	struct hmac_ctx *ctx = align_ptr(ipad + bs * 2 + ds, sizeof(void *));
 	struct hash_desc desc;
 	struct scatterlist tmp;
+	int err;
 
 	desc.tfm = ctx->child;
 	desc.flags = pdesc->flags & CRYPTO_TFM_REQ_MAY_SLEEP;
 	sg_set_buf(&tmp, ipad, bs);
 
-	return unlikely(crypto_hash_init(&desc)) ?:
-	       crypto_hash_update(&desc, &tmp, bs);
+	err = crypto_hash_init(&desc);
+	if (unlikely(err))
+		return err;
+
+	return crypto_hash_update(&desc, &tmp, bs);
 }
 
 static int hmac_update(struct hash_desc *pdesc,
@@ -123,13 +127,17 @@ static int hmac_final(struct hash_desc *
 	struct hmac_ctx *ctx = align_ptr(digest + ds, sizeof(void *));
 	struct hash_desc desc;
 	struct scatterlist tmp;
+	int err;
 
 	desc.tfm = ctx->child;
 	desc.flags = pdesc->flags & CRYPTO_TFM_REQ_MAY_SLEEP;
 	sg_set_buf(&tmp, opad, bs + ds);
 
-	return unlikely(crypto_hash_final(&desc, digest)) ?:
-	       crypto_hash_digest(&desc, &tmp, bs + ds, out);
+	err = crypto_hash_final(&desc, digest);
+	if (unlikely(err))
+		return err;
+
+	return crypto_hash_digest(&desc, &tmp, bs + ds, out);
 }
 
 static int hmac_digest(struct hash_desc *pdesc, struct scatterlist *sg,
@@ -145,6 +153,7 @@ static int hmac_digest(struct hash_desc 
 	struct hash_desc desc;
 	struct scatterlist sg1[2];
 	struct scatterlist sg2[1];
+	int err;
 
 	desc.tfm = ctx->child;
 	desc.flags = pdesc->flags & CRYPTO_TFM_REQ_MAY_SLEEP;
@@ -154,8 +163,11 @@ static int hmac_digest(struct hash_desc 
 	sg1[1].length = 0;
 	sg_set_buf(sg2, opad, bs + ds);
 
-	return unlikely(crypto_hash_digest(&desc, sg1, nbytes + bs, digest)) ?:
-	       crypto_hash_digest(&desc, sg2, bs + ds, out);
+	err = crypto_hash_digest(&desc, sg1, nbytes + bs, digest);
+	if (unlikely(err))
+		return err;
+
+	return crypto_hash_digest(&desc, sg2, bs + ds, out);
 }
 
 static int hmac_init_tfm(struct crypto_tfm *tfm)
