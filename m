Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWJJMrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWJJMrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWJJMrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:47:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:40332 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965000AbWJJMrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=t5g2lFXh71qJPTUxt13lC3/JYbajhCZbcCoBO26y8l51wjUjYFCGIweNXgpL1T78/M7RaB3qKGj6fuiVM/UrLW3U8eJ/KQqTRyY+IzdRyc75jul14E9gXLzy4aTwSupaxDPz0b8AwKuksN/YMHrZUfW6Q/n5aAsNVI0yeoWxkkE=
Date: Tue, 10 Oct 2006 21:47:20 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] crypto: fix crypto_alloc_base() return value
Message-ID: <20061010124720.GA17432@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes crypto_alloc_base() return proper return value.

- If kzalloc() failure happens within __crypto_alloc_tfm(),
  crypto_alloc_base() returns NULL. But crypto_alloc_base()
  is supposed to return error code as pointer. So this patch
  makes it return -ENOMEM in that case.

- crypto_alloc_base() is suppose to return -EINTR, if it is
  interrupted by signal. But it may not return -EINTR.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 crypto/api.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: work-fault-inject/crypto/api.c
===================================================================
--- work-fault-inject.orig/crypto/api.c
+++ work-fault-inject/crypto/api.c
@@ -331,7 +331,7 @@ struct crypto_tfm *__crypto_alloc_tfm(st
 	tfm_size = sizeof(*tfm) + crypto_ctxsize(alg, flags);
 	tfm = kzalloc(tfm_size, GFP_KERNEL);
 	if (tfm == NULL)
-		goto out;
+		goto out_err;
 
 	tfm->__crt_alg = alg;
 
@@ -355,6 +355,7 @@ cra_init_failed:
 	crypto_exit_ops(tfm);
 out_free_tfm:
 	kfree(tfm);
+out_err:
 	tfm = ERR_PTR(err);
 out:
 	return tfm;
@@ -414,14 +415,14 @@ struct crypto_tfm *crypto_alloc_base(con
 		struct crypto_alg *alg;
 
 		alg = crypto_alg_mod_lookup(alg_name, type, mask);
-		err = PTR_ERR(alg);
-		tfm = ERR_PTR(err);
-		if (IS_ERR(alg))
+		if (IS_ERR(alg)) {
+			err = PTR_ERR(alg);
 			goto err;
+		}
 
 		tfm = __crypto_alloc_tfm(alg, 0);
 		if (!IS_ERR(tfm))
-			break;
+			return tfm;
 
 		crypto_mod_put(alg);
 		err = PTR_ERR(tfm);
@@ -433,9 +434,9 @@ err:
 			err = -EINTR;
 			break;
 		}
-	};
+	}
 
-	return tfm;
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_base);
  
