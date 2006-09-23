Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWIWOkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWIWOkp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWIWOkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 10:40:45 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:50951 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751206AbWIWOko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 10:40:44 -0400
Date: Sun, 24 Sep 2006 00:40:41 +1000
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]: Fix ALIGN() macro
Message-ID: <20060923144041.GA3540@gondor.apana.org.au>
References: <20060922.223136.41635862.davem@davemloft.net> <20060923124633.GA2567@gondor.apana.org.au> <20060923125458.GA2682@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923125458.GA2682@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

OK I think I've found the problem.

[CRYPTO] hmac: Fix hmac_init update call

The crypto_hash_update call in hmac_init gave the number 1
instead of the length of the sg list in bytes.  This is a
missed conversion from the digest => hash change.

As tcrypt only tests crypto_hash_digest it didn't catch this.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/crypto/hmac.c b/crypto/hmac.c
index f403b69..d52b234 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -98,7 +98,7 @@ static int hmac_init(struct hash_desc *p
 	sg_set_buf(&tmp, ipad, bs);
 
 	return unlikely(crypto_hash_init(&desc)) ?:
-	       crypto_hash_update(&desc, &tmp, 1);
+	       crypto_hash_update(&desc, &tmp, bs);
 }
 
 static int hmac_update(struct hash_desc *pdesc,
